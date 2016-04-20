From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Date: Wed, 20 Apr 2016 15:25:25 +0000
Subject: [PATCH 4/8] drm/fb-helper: Add fb_deferred_io support
Message-Id: <1461165929-11344-5-git-send-email-noralf@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org

This adds deferred io support if CONFIG_FB_DEFERRED_IO is enabled.
Accumulated fbdev framebuffer changes are signaled using the callback
(struct drm_framebuffer_funcs *)->dirty()

The drm_fb_helper_sys_*() functions will accumulate changes and
schedule fb_info.deferred_work _if_ fb_info.fbdefio is set.
This worker is used by the deferred io mmap code to signal that it
has been collecting page faults. The page faults and/or other changes
are then merged into a drm_clip_rect and passed to the framebuffer
dirty() function.

The driver is responsible for setting up the fb_info.fbdefio structure
and calling fb_deferred_io_init() using the provided callback:
(struct fb_deferred_io).deferred_io =3D drm_fb_helper_deferred_io;

Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 119 ++++++++++++++++++++++++++++++++++++=
+++-
 include/drm/drm_fb_helper.h     |  15 +++++
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helpe=
r.c
index 855108e..79c974a 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -40,6 +40,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_rect.h>
=20
 static bool drm_fbdev_emulation =3D true;
 module_param_named(fbdev_emulation, drm_fbdev_emulation, bool, 0600);
@@ -48,6 +49,9 @@ MODULE_PARM_DESC(fbdev_emulation,
=20
 static LIST_HEAD(kernel_fb_helper_list);
=20
+static void drm_fb_helper_defer_dirty(struct fb_info *info, u32 x, u32 y,
+				      u32 width, u32 height);
+
 /**
  * DOC: fbdev helpers
  *
@@ -84,6 +88,13 @@ static LIST_HEAD(kernel_fb_helper_list);
  * and set up an initial configuration using the detected hardware, drivers
  * should call drm_fb_helper_single_add_all_connectors() followed by
  * drm_fb_helper_initial_config().
+ *
+ * If CONFIG_FB_DEFERRED_IO is enabled and (struct fb_info).fbdefio is set,
+ * the drm_fb_helper_{cfb,sys}_{write,fillrect,copyarea,imageblit} functio=
ns
+ * will accumulate changes and schedule (struct fb_info).deferred_work to =
run.
+ * This is the same worker used by the mmap deferred io code path.
+ * drm_fb_helper_deferred_io() will call
+ * (struct drm_framebuffer_funcs)->dirty().
  */
=20
 /**
@@ -401,11 +412,14 @@ backoff:
 static int restore_fbdev_mode(struct drm_fb_helper *fb_helper)
 {
 	struct drm_device *dev =3D fb_helper->dev;
+	struct fb_info *info =3D fb_helper->fbdev;
 	struct drm_plane *plane;
 	int i;
=20
 	drm_warn_on_modeset_not_all_locked(dev);
=20
+	drm_fb_helper_defer_dirty(info, 0, 0, info->var.xres, info->var.yres);
+
 	if (fb_helper->atomic)
 		return restore_fbdev_mode_atomic(fb_helper);
=20
@@ -650,6 +664,9 @@ void drm_fb_helper_prepare(struct drm_device *dev, stru=
ct drm_fb_helper *helper,
 			   const struct drm_fb_helper_funcs *funcs)
 {
 	INIT_LIST_HEAD(&helper->kernel_fb_list);
+#ifdef CONFIG_FB_DEFERRED_IO
+	spin_lock_init(&helper->dirty_lock);
+#endif
 	helper->funcs =3D funcs;
 	helper->dev =3D dev;
 }
@@ -834,6 +851,87 @@ void drm_fb_helper_unlink_fbi(struct drm_fb_helper *fb=
_helper)
 }
 EXPORT_SYMBOL(drm_fb_helper_unlink_fbi);
=20
+#ifdef CONFIG_FB_DEFERRED_IO
+/**
+ * drm_fb_helper_deferred_io() - (struct fb_deferred_io *)->deferred_io ca=
llback
+ *                               function
+ *
+ * This function always runs in process context (struct delayed_work) and =
calls
+ * the (struct drm_framebuffer_funcs)->dirty function with the collected
+ * damage. There's no need to worry about the possibility that the fb_sys_=
*()
+ * functions could be running in atomic context. They only schedule the
+ * delayed worker which then calls this deferred_io callback.
+ */
+void drm_fb_helper_deferred_io(struct fb_info *info,
+			       struct list_head *pagelist)
+{
+	struct drm_fb_helper *helper =3D info->par;
+	unsigned long start, end, min, max;
+	struct drm_clip_rect clip;
+	unsigned long flags;
+	struct page *page;
+
+	if (!helper->fb->funcs->dirty)
+		return;
+
+	spin_lock_irqsave(&helper->dirty_lock, flags);
+	clip =3D helper->dirty_clip;
+	drm_clip_rect_reset(&helper->dirty_clip);
+	spin_unlock_irqrestore(&helper->dirty_lock, flags);
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
+		struct drm_clip_rect mmap_clip;
+
+		mmap_clip.x1 =3D 0;
+		mmap_clip.x2 =3D info->var.xres;
+		mmap_clip.y1 =3D min / info->fix.line_length;
+		mmap_clip.y2 =3D min_t(u32, max / info->fix.line_length,
+				     info->var.yres);
+		drm_clip_rect_merge(&clip, &mmap_clip, 1, 0, 0, 0);
+	}
+
+	if (!drm_clip_rect_is_empty(&clip))
+		helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip, 1);
+}
+EXPORT_SYMBOL(drm_fb_helper_deferred_io);
+
+static void drm_fb_helper_defer_dirty(struct fb_info *info, u32 x, u32 y,
+				      u32 width, u32 height)
+{
+	struct drm_fb_helper *helper =3D info->par;
+	struct drm_clip_rect clip;
+	unsigned long flags;
+
+	if (!info->fbdefio)
+		return;
+
+	clip.x1 =3D x;
+	clip.x2 =3D x + width;
+	clip.y1 =3D y;
+	clip.y2 =3D y + height;
+
+	spin_lock_irqsave(&helper->dirty_lock, flags);
+	drm_clip_rect_merge(&helper->dirty_clip, &clip, 1, 0, 0, 0);
+	spin_unlock_irqrestore(&helper->dirty_lock, flags);
+
+	schedule_delayed_work(&info->deferred_work, info->fbdefio->delay);
+}
+#else
+static void drm_fb_helper_defer_dirty(struct fb_info *info, u32 x, u32 y,
+				      u32 width, u32 height)
+{
+}
+#endif
+
 /**
  * drm_fb_helper_sys_read - wrapper around fb_sys_read
  * @info: fb_info struct pointer
@@ -862,7 +960,14 @@ EXPORT_SYMBOL(drm_fb_helper_sys_read);
 ssize_t drm_fb_helper_sys_write(struct fb_info *info, const char __user *b=
uf,
 				size_t count, loff_t *ppos)
 {
-	return fb_sys_write(info, buf, count, ppos);
+	ssize_t ret;
+
+	ret =3D fb_sys_write(info, buf, count, ppos);
+	if (ret > 0)
+		drm_fb_helper_defer_dirty(info, 0, 0,
+					  info->var.xres, info->var.yres);
+
+	return ret;
 }
 EXPORT_SYMBOL(drm_fb_helper_sys_write);
=20
@@ -877,6 +982,8 @@ void drm_fb_helper_sys_fillrect(struct fb_info *info,
 				const struct fb_fillrect *rect)
 {
 	sys_fillrect(info, rect);
+	drm_fb_helper_defer_dirty(info, rect->dx, rect->dy,
+				  rect->width, rect->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_sys_fillrect);
=20
@@ -891,6 +998,8 @@ void drm_fb_helper_sys_copyarea(struct fb_info *info,
 				const struct fb_copyarea *area)
 {
 	sys_copyarea(info, area);
+	drm_fb_helper_defer_dirty(info, area->dx, area->dy,
+				  area->width, area->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_sys_copyarea);
=20
@@ -905,6 +1014,8 @@ void drm_fb_helper_sys_imageblit(struct fb_info *info,
 				 const struct fb_image *image)
 {
 	sys_imageblit(info, image);
+	drm_fb_helper_defer_dirty(info, image->dx, image->dy,
+				  image->width, image->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_sys_imageblit);
=20
@@ -919,6 +1030,8 @@ void drm_fb_helper_cfb_fillrect(struct fb_info *info,
 				const struct fb_fillrect *rect)
 {
 	cfb_fillrect(info, rect);
+	drm_fb_helper_defer_dirty(info, rect->dx, rect->dy,
+				  rect->width, rect->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_cfb_fillrect);
=20
@@ -933,6 +1046,8 @@ void drm_fb_helper_cfb_copyarea(struct fb_info *info,
 				const struct fb_copyarea *area)
 {
 	cfb_copyarea(info, area);
+	drm_fb_helper_defer_dirty(info, area->dx, area->dy,
+				  area->width, area->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_cfb_copyarea);
=20
@@ -947,6 +1062,8 @@ void drm_fb_helper_cfb_imageblit(struct fb_info *info,
 				 const struct fb_image *image)
 {
 	cfb_imageblit(info, image);
+	drm_fb_helper_defer_dirty(info, image->dx, image->dy,
+				  image->width, image->height);
 }
 EXPORT_SYMBOL(drm_fb_helper_cfb_imageblit);
=20
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 062723b..c9e9271 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -172,6 +172,9 @@ struct drm_fb_helper_connector {
  * @funcs: driver callbacks for fb helper
  * @fbdev: emulated fbdev device info struct
  * @pseudo_palette: fake palette of 16 colors
+ * @dirty_clip: clip rectangle used with deferred_io to accumulate damage =
to
+ *              the screen buffer
+ * @dirty_lock: spinlock protecting @dirty_clip
  *
  * This is the main structure used by the fbdev helpers. Drivers supporting
  * fbdev emulation should embedded this into their overall driver structur=
e.
@@ -189,6 +192,10 @@ struct drm_fb_helper {
 	const struct drm_fb_helper_funcs *funcs;
 	struct fb_info *fbdev;
 	u32 pseudo_palette[17];
+#ifdef CONFIG_FB_DEFERRED_IO
+	struct drm_clip_rect dirty_clip;
+	spinlock_t dirty_lock;
+#endif
=20
 	/**
 	 * @kernel_fb_list:
@@ -245,6 +252,9 @@ void drm_fb_helper_fill_fix(struct fb_info *info, uint3=
2_t pitch,
=20
 void drm_fb_helper_unlink_fbi(struct drm_fb_helper *fb_helper);
=20
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
=20
+static inline void drm_fb_helper_deferred_io(struct fb_info *info,
+					     struct list_head *pagelist)
+{
+}
+
 static inline ssize_t drm_fb_helper_sys_read(struct fb_info *info,
 					     char __user *buf, size_t count,
 					     loff_t *ppos)
--=20
2.2.2

