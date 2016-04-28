From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Date: Thu, 28 Apr 2016 15:18:33 +0000
Subject: [PATCH v4 3/7] drm/fb-helper: Add fb_deferred_io support
Message-Id: <1461856717-6476-4-git-send-email-noralf@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org

This adds deferred io support to drm_fb_helper.
The fbdev framebuffer changes are flushed using the callback
(struct drm_framebuffer *)->funcs->dirty() by a dedicated worker
ensuring that it always runs in process context.

Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

Changes since v3:
- Don't use forward decl, move drm_fb_helper_dirty_work()
- Use DIV_ROUND_UP in drm_fb_helper_deferred_io()

Changes since v2:
- FB_DEFERRED_IO is now always selected by DRM_KMS_FB_HELPER, ifdef removed
- The drm_clip_rect utility functions are dropped, so open code it
- docs: use & to denote structs

Changes since v1:
- Use a dedicated worker to run the framebuffer flushing like qxl does
- Add parameter descriptions to drm_fb_helper_deferred_io

 drivers/gpu/drm/Kconfig         |   1 +
 drivers/gpu/drm/drm_fb_helper.c | 103 ++++++++++++++++++++++++++++++++++++=
+++-
 include/drm/drm_fb_helper.h     |  15 ++++++
 3 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 9e4f2f1..8e6f34b 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -52,6 +52,7 @@ config DRM_KMS_FB_HELPER
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_DEFERRED_IO
 	help
 	  FBDEV helpers for KMS drivers.

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helpe=
r.c
index 855108e..62f849f 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -84,6 +84,15 @@ static LIST_HEAD(kernel_fb_helper_list);
  * and set up an initial configuration using the detected hardware, drivers
  * should call drm_fb_helper_single_add_all_connectors() followed by
  * drm_fb_helper_initial_config().
+ *
+ * If CONFIG_FB_DEFERRED_IO is enabled and &drm_framebuffer_funcs ->dirty =
is
+ * set, the drm_fb_helper_{cfb,sys}_{write,fillrect,copyarea,imageblit}
+ * functions will accumulate changes and schedule &fb_helper .dirty_work t=
o run
+ * right away. This worker then calls the dirty() function ensuring that it
+ * will always run in process context since the fb_*() function could be
+ * running in atomic context. If drm_fb_helper_deferred_io() is used as the
+ * deferred_io callback it will also schedule dirty_work with the damage
+ * collected from the mmap page writes.
  */

 /**
@@ -637,6 +646,23 @@ static void drm_fb_helper_crtc_free(struct drm_fb_help=
er *helper)
 	kfree(helper->crtc_info);
 }

+static void drm_fb_helper_dirty_work(struct work_struct *work)
+{
+	struct drm_fb_helper *helper =3D container_of(work, struct drm_fb_helper,
+						    dirty_work);
+	struct drm_clip_rect *clip =3D &helper->dirty_clip;
+	struct drm_clip_rect clip_copy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&helper->dirty_lock, flags);
+	clip_copy =3D *clip;
+	clip->x1 =3D clip->y1 =3D ~0;
+	clip->x2 =3D clip->y2 =3D 0;
+	spin_unlock_irqrestore(&helper->dirty_lock, flags);
+
+	helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip_copy, 1);
+}
+
 /**
  * drm_fb_helper_prepare - setup a drm_fb_helper structure
  * @dev: DRM device
@@ -650,6 +676,9 @@ void drm_fb_helper_prepare(struct drm_device *dev, stru=
ct drm_fb_helper *helper,
 			   const struct drm_fb_helper_funcs *funcs)
 {
 	INIT_LIST_HEAD(&helper->kernel_fb_list);
+	spin_lock_init(&helper->dirty_lock);
+	INIT_WORK(&helper->dirty_work, drm_fb_helper_dirty_work);
+	helper->dirty_clip.x1 =3D helper->dirty_clip.y1 =3D ~0;
 	helper->funcs =3D funcs;
 	helper->dev =3D dev;
 }
@@ -834,6 +863,59 @@ void drm_fb_helper_unlink_fbi(struct drm_fb_helper *fb=
_helper)
 }
 EXPORT_SYMBOL(drm_fb_helper_unlink_fbi);

+static void drm_fb_helper_dirty(struct fb_info *info, u32 x, u32 y,
+				u32 width, u32 height)
+{
+	struct drm_fb_helper *helper =3D info->par;
+	struct drm_clip_rect *clip =3D &helper->dirty_clip;
+	unsigned long flags;
+
+	if (!helper->fb->funcs->dirty)
+		return;
+
+	spin_lock_irqsave(&helper->dirty_lock, flags);
+	clip->x1 =3D min_t(u32, clip->x1, x);
+	clip->y1 =3D min_t(u32, clip->y1, y);
+	clip->x2 =3D max_t(u32, clip->x2, x + width);
+	clip->y2 =3D max_t(u32, clip->y2, y + height);
+	spin_unlock_irqrestore(&helper->dirty_lock, flags);
+
+	schedule_work(&helper->dirty_work);
+}
+
+/**
+ * drm_fb_helper_deferred_io() - fbdev deferred_io callback function
+ * @info: fb_info struct pointer
+ * @pagelist: list of dirty mmap framebuffer pages
+ *
+ * This function is used as the &fb_deferred_io ->deferred_io
+ * callback function for flushing the fbdev mmap writes.
+ */
+void drm_fb_helper_deferred_io(struct fb_info *info,
+			       struct list_head *pagelist)
+{
+	unsigned long start, end, min, max;
+	struct page *page;
+	u32 y1, y2;
+
+	min =3D ULONG_MAX;
+	max =3D 0;
+	list_for_each_entry(page, pagelist, lru) {
+		start =3D page->index << PAGE_SHIFT;
+		end =3D start + PAGE_SIZE - 1;
+		min =3D min(min, start);
+		max =3D max(max, end);
+	}
+
+	if (min < max) {
+		y1 =3D min / info->fix.line_length;
+		y2 =3D min_t(u32, DIV_ROUND_UP(max, info->fix.line_length),
+			   info->var.yres);
+		drm_fb_helper_dirty(info, 0, y1, info->var.xres, y2 - y1);
+	}
+}
+EXPORT_SYMBOL(drm_fb_helper_deferred_io);
+
 /**
  * drm_fb_helper_sys_read - wrapper around fb_sys_read
  * @info: fb_info struct pointer
@@ -862,7 +944,14 @@ EXPORT_SYMBOL(drm_fb_helper_sys_read);
 ssize_t drm_fb_helper_sys_write(struct fb_info *info, const char __user *b=
uf,
 				size_t count, loff_t *ppos)
 {
-	return fb_sys_write(info, buf, count, ppos);
+	ssize_t ret;
+
+	ret =3D fb_sys_write(info, buf, count, ppos);
+	if (ret > 0)
+		drm_fb_helper_dirty(info, 0, 0, info->var.xres,
+				    info->var.yres);
+
+	return ret;
 }
 EXPORT_SYMBOL(drm_fb_helper_sys_write);

@@ -877,6 +966,8 @@ void drm_fb_helper_sys_fillrect(struct fb_info *info,
 				const struct fb_fillrect *rect)
 {
 	sys_fillrect(info, rect);
+	drm_fb_helper_dirty(info, rect->dx, rect->dy,
+			    rect->width, rect->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_sys_fillrect);

@@ -891,6 +982,8 @@ void drm_fb_helper_sys_copyarea(struct fb_info *info,
 				const struct fb_copyarea *area)
 {
 	sys_copyarea(info, area);
+	drm_fb_helper_dirty(info, area->dx, area->dy,
+			    area->width, area->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_sys_copyarea);

@@ -905,6 +998,8 @@ void drm_fb_helper_sys_imageblit(struct fb_info *info,
 				 const struct fb_image *image)
 {
 	sys_imageblit(info, image);
+	drm_fb_helper_dirty(info, image->dx, image->dy,
+			    image->width, image->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_sys_imageblit);

@@ -919,6 +1014,8 @@ void drm_fb_helper_cfb_fillrect(struct fb_info *info,
 				const struct fb_fillrect *rect)
 {
 	cfb_fillrect(info, rect);
+	drm_fb_helper_dirty(info, rect->dx, rect->dy,
+			    rect->width, rect->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_cfb_fillrect);

@@ -933,6 +1030,8 @@ void drm_fb_helper_cfb_copyarea(struct fb_info *info,
 				const struct fb_copyarea *area)
 {
 	cfb_copyarea(info, area);
+	drm_fb_helper_dirty(info, area->dx, area->dy,
+			    area->width, area->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_cfb_copyarea);

@@ -947,6 +1046,8 @@ void drm_fb_helper_cfb_imageblit(struct fb_info *info,
 				 const struct fb_image *image)
 {
 	cfb_imageblit(info, image);
+	drm_fb_helper_dirty(info, image->dx, image->dy,
+			    image->width, image->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_cfb_imageblit);

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 062723b..5b4aa35 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -172,6 +172,10 @@ struct drm_fb_helper_connector {
  * @funcs: driver callbacks for fb helper
  * @fbdev: emulated fbdev device info struct
  * @pseudo_palette: fake palette of 16 colors
+ * @dirty_clip: clip rectangle used with deferred_io to accumulate damage =
to
+ *              the screen buffer
+ * @dirty_lock: spinlock protecting @dirty_clip
+ * @dirty_work: worker used to flush the framebuffer
  *
  * This is the main structure used by the fbdev helpers. Drivers supporting
  * fbdev emulation should embedded this into their overall driver structur=
e.
@@ -189,6 +193,9 @@ struct drm_fb_helper {
 	const struct drm_fb_helper_funcs *funcs;
 	struct fb_info *fbdev;
 	u32 pseudo_palette[17];
+	struct drm_clip_rect dirty_clip;
+	spinlock_t dirty_lock;
+	struct work_struct dirty_work;

 	/**
 	 * @kernel_fb_list:
@@ -245,6 +252,9 @@ void drm_fb_helper_fill_fix(struct fb_info *info, uint3=
2_t pitch,

 void drm_fb_helper_unlink_fbi(struct drm_fb_helper *fb_helper);

+void drm_fb_helper_deferred_io(struct fb_info *info,
+			       struct list_head *pagelist);
+
 ssize_t drm_fb_helper_sys_read(struct fb_info *info, char __user *buf,
 			       size_t count, loff_t *ppos);
 ssize_t drm_fb_helper_sys_write(struct fb_info *info, const char __user *b=
uf,
@@ -368,6 +378,11 @@ static inline void drm_fb_helper_unlink_fbi(struct drm=
_fb_helper *fb_helper)
 {
 }

+static inline void drm_fb_helper_deferred_io(struct fb_info *info,
+					     struct list_head *pagelist)
+{
+}
+
 static inline ssize_t drm_fb_helper_sys_read(struct fb_info *info,
 					     char __user *buf, size_t count,
 					     loff_t *ppos)
--
2.2.2

