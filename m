From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Date: Wed, 20 Apr 2016 15:25:28 +0000
Subject: [PATCH 7/8] drm/qxl: Use drm_fb_helper deferred_io support
Message-Id: <1461165929-11344-8-git-send-email-noralf@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org

Use the fbdev deferred io support in drm_fb_helper.
The (struct fb_ops *)->fb_{fillrect,copyarea,imageblit} functions will
now be deferred in the same way that mmap damage is, instead of being
flushed directly.
This patch has only been compile tested.

Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
---
 drivers/gpu/drm/qxl/qxl_display.c |   9 +-
 drivers/gpu/drm/qxl/qxl_drv.h     |   7 +-
 drivers/gpu/drm/qxl/qxl_fb.c      | 220 ++++++++++------------------------=
----
 drivers/gpu/drm/qxl/qxl_kms.c     |   4 -
 4 files changed, 62 insertions(+), 178 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_di=
splay.c
index 030409a..9a03524 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -465,7 +465,7 @@ static const struct drm_crtc_funcs qxl_crtc_funcs =3D {
 	.page_flip =3D qxl_crtc_page_flip,
 };
=20
-static void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb)
+void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb)
 {
 	struct qxl_framebuffer *qxl_fb =3D to_qxl_framebuffer(fb);
=20
@@ -527,12 +527,13 @@ int
 qxl_framebuffer_init(struct drm_device *dev,
 		     struct qxl_framebuffer *qfb,
 		     const struct drm_mode_fb_cmd2 *mode_cmd,
-		     struct drm_gem_object *obj)
+		     struct drm_gem_object *obj,
+		     const struct drm_framebuffer_funcs *funcs)
 {
 	int ret;
=20
 	qfb->obj =3D obj;
-	ret =3D drm_framebuffer_init(dev, &qfb->base, &qxl_fb_funcs);
+	ret =3D drm_framebuffer_init(dev, &qfb->base, funcs);
 	if (ret) {
 		qfb->obj =3D NULL;
 		return ret;
@@ -999,7 +1000,7 @@ qxl_user_framebuffer_create(struct drm_device *dev,
 	if (qxl_fb =3D NULL)
 		return NULL;
=20
-	ret =3D qxl_framebuffer_init(dev, qxl_fb, mode_cmd, obj);
+	ret =3D qxl_framebuffer_init(dev, qxl_fb, mode_cmd, obj, &qxl_fb_funcs);
 	if (ret) {
 		kfree(qxl_fb);
 		drm_gem_object_unreference_unlocked(obj);
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 3f3897e..3ad6604 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -324,8 +324,6 @@ struct qxl_device {
 	struct workqueue_struct *gc_queue;
 	struct work_struct gc_work;
=20
-	struct work_struct fb_work;
-
 	struct drm_property *hotplug_mode_update_property;
 	int monitors_config_width;
 	int monitors_config_height;
@@ -389,11 +387,13 @@ int qxl_get_handle_for_primary_fb(struct qxl_device *=
qdev,
 void qxl_fbdev_set_suspend(struct qxl_device *qdev, int state);
=20
 /* qxl_display.c */
+void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb);
 int
 qxl_framebuffer_init(struct drm_device *dev,
 		     struct qxl_framebuffer *rfb,
 		     const struct drm_mode_fb_cmd2 *mode_cmd,
-		     struct drm_gem_object *obj);
+		     struct drm_gem_object *obj,
+		     const struct drm_framebuffer_funcs *funcs);
 void qxl_display_read_client_monitors_config(struct qxl_device *qdev);
 void qxl_send_monitors_config(struct qxl_device *qdev);
 int qxl_create_monitors_object(struct qxl_device *qdev);
@@ -553,7 +553,6 @@ int qxl_irq_init(struct qxl_device *qdev);
 irqreturn_t qxl_irq_handler(int irq, void *arg);
=20
 /* qxl_fb.c */
-int qxl_fb_init(struct qxl_device *qdev);
 bool qxl_fbdev_qobj_is_fb(struct qxl_device *qdev, struct qxl_bo *qobj);
=20
 int qxl_debugfs_add_files(struct qxl_device *qdev,
diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index 06f032d..090dcee 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -30,6 +30,7 @@
 #include "drm/drm.h"
 #include "drm/drm_crtc.h"
 #include "drm/drm_crtc_helper.h"
+#include "drm/drm_rect.h"
 #include "qxl_drv.h"
=20
 #include "qxl_object.h"
@@ -46,15 +47,6 @@ struct qxl_fbdev {
 	struct list_head delayed_ops;
 	void *shadow;
 	int size;
-
-	/* dirty memory logging */
-	struct {
-		spinlock_t lock;
-		unsigned x1;
-		unsigned y1;
-		unsigned x2;
-		unsigned y2;
-	} dirty;
 };
=20
 static void qxl_fb_image_init(struct qxl_fb_image *qxl_fb_image,
@@ -82,169 +74,18 @@ static void qxl_fb_image_init(struct qxl_fb_image *qxl=
_fb_image,
 	}
 }
=20
-static void qxl_fb_dirty_flush(struct fb_info *info)
-{
-	struct qxl_fbdev *qfbdev =3D info->par;
-	struct qxl_device *qdev =3D qfbdev->qdev;
-	struct qxl_fb_image qxl_fb_image;
-	struct fb_image *image =3D &qxl_fb_image.fb_image;
-	unsigned long flags;
-	u32 x1, x2, y1, y2;
-
-	/* TODO: hard coding 32 bpp */
-	int stride =3D qfbdev->qfb.base.pitches[0];
-
-	spin_lock_irqsave(&qfbdev->dirty.lock, flags);
-
-	x1 =3D qfbdev->dirty.x1;
-	x2 =3D qfbdev->dirty.x2;
-	y1 =3D qfbdev->dirty.y1;
-	y2 =3D qfbdev->dirty.y2;
-	qfbdev->dirty.x1 =3D 0;
-	qfbdev->dirty.x2 =3D 0;
-	qfbdev->dirty.y1 =3D 0;
-	qfbdev->dirty.y2 =3D 0;
-
-	spin_unlock_irqrestore(&qfbdev->dirty.lock, flags);
-
-	/*
-	 * we are using a shadow draw buffer, at qdev->surface0_shadow
-	 */
-	qxl_io_log(qdev, "dirty x[%d, %d], y[%d, %d]", x1, x2, y1, y2);
-	image->dx =3D x1;
-	image->dy =3D y1;
-	image->width =3D x2 - x1 + 1;
-	image->height =3D y2 - y1 + 1;
-	image->fg_color =3D 0xffffffff; /* unused, just to avoid uninitialized
-					 warnings */
-	image->bg_color =3D 0;
-	image->depth =3D 32;	     /* TODO: take from somewhere? */
-	image->cmap.start =3D 0;
-	image->cmap.len =3D 0;
-	image->cmap.red =3D NULL;
-	image->cmap.green =3D NULL;
-	image->cmap.blue =3D NULL;
-	image->cmap.transp =3D NULL;
-	image->data =3D qfbdev->shadow + (x1 * 4) + (stride * y1);
-
-	qxl_fb_image_init(&qxl_fb_image, qdev, info, NULL);
-	qxl_draw_opaque_fb(&qxl_fb_image, stride);
-}
-
-static void qxl_dirty_update(struct qxl_fbdev *qfbdev,
-			     int x, int y, int width, int height)
-{
-	struct qxl_device *qdev =3D qfbdev->qdev;
-	unsigned long flags;
-	int x2, y2;
-
-	x2 =3D x + width - 1;
-	y2 =3D y + height - 1;
-
-	spin_lock_irqsave(&qfbdev->dirty.lock, flags);
-
-	if ((qfbdev->dirty.y2 - qfbdev->dirty.y1) &&
-	    (qfbdev->dirty.x2 - qfbdev->dirty.x1)) {
-		if (qfbdev->dirty.y1 < y)
-			y =3D qfbdev->dirty.y1;
-		if (qfbdev->dirty.y2 > y2)
-			y2 =3D qfbdev->dirty.y2;
-		if (qfbdev->dirty.x1 < x)
-			x =3D qfbdev->dirty.x1;
-		if (qfbdev->dirty.x2 > x2)
-			x2 =3D qfbdev->dirty.x2;
-	}
-
-	qfbdev->dirty.x1 =3D x;
-	qfbdev->dirty.x2 =3D x2;
-	qfbdev->dirty.y1 =3D y;
-	qfbdev->dirty.y2 =3D y2;
-
-	spin_unlock_irqrestore(&qfbdev->dirty.lock, flags);
-
-	schedule_work(&qdev->fb_work);
-}
-
-static void qxl_deferred_io(struct fb_info *info,
-			    struct list_head *pagelist)
-{
-	struct qxl_fbdev *qfbdev =3D info->par;
-	unsigned long start, end, min, max;
-	struct page *page;
-	int y1, y2;
-
-	min =3D ULONG_MAX;
-	max =3D 0;
-	list_for_each_entry(page, pagelist, lru) {
-		start =3D page->index << PAGE_SHIFT;
-		end =3D start + PAGE_SIZE - 1;
-		min =3D min(min, start);
-		max =3D max(max, end);
-	}
-
-	if (min < max) {
-		y1 =3D min / info->fix.line_length;
-		y2 =3D (max / info->fix.line_length) + 1;
-		qxl_dirty_update(qfbdev, 0, y1, info->var.xres, y2 - y1);
-	}
-};
-
 static struct fb_deferred_io qxl_defio =3D {
 	.delay		=3D QXL_DIRTY_DELAY,
-	.deferred_io	=3D qxl_deferred_io,
+	.deferred_io	=3D drm_fb_helper_deferred_io,
 };
=20
-static void qxl_fb_fillrect(struct fb_info *info,
-			    const struct fb_fillrect *rect)
-{
-	struct qxl_fbdev *qfbdev =3D info->par;
-
-	sys_fillrect(info, rect);
-	qxl_dirty_update(qfbdev, rect->dx, rect->dy, rect->width,
-			 rect->height);
-}
-
-static void qxl_fb_copyarea(struct fb_info *info,
-			    const struct fb_copyarea *area)
-{
-	struct qxl_fbdev *qfbdev =3D info->par;
-
-	sys_copyarea(info, area);
-	qxl_dirty_update(qfbdev, area->dx, area->dy, area->width,
-			 area->height);
-}
-
-static void qxl_fb_imageblit(struct fb_info *info,
-			     const struct fb_image *image)
-{
-	struct qxl_fbdev *qfbdev =3D info->par;
-
-	sys_imageblit(info, image);
-	qxl_dirty_update(qfbdev, image->dx, image->dy, image->width,
-			 image->height);
-}
-
-static void qxl_fb_work(struct work_struct *work)
-{
-	struct qxl_device *qdev =3D container_of(work, struct qxl_device, fb_work=
);
-	struct qxl_fbdev *qfbdev =3D qdev->mode_info.qfbdev;
-
-	qxl_fb_dirty_flush(qfbdev->helper.fbdev);
-}
-
-int qxl_fb_init(struct qxl_device *qdev)
-{
-	INIT_WORK(&qdev->fb_work, qxl_fb_work);
-	return 0;
-}
-
 static struct fb_ops qxlfb_ops =3D {
 	.owner =3D THIS_MODULE,
 	.fb_check_var =3D drm_fb_helper_check_var,
 	.fb_set_par =3D drm_fb_helper_set_par, /* TODO: copy vmwgfx */
-	.fb_fillrect =3D qxl_fb_fillrect,
-	.fb_copyarea =3D qxl_fb_copyarea,
-	.fb_imageblit =3D qxl_fb_imageblit,
+	.fb_fillrect =3D drm_fb_helper_sys_fillrect,
+	.fb_copyarea =3D drm_fb_helper_sys_copyarea,
+	.fb_imageblit =3D drm_fb_helper_sys_imageblit,
 	.fb_pan_display =3D drm_fb_helper_pan_display,
 	.fb_blank =3D drm_fb_helper_blank,
 	.fb_setcmap =3D drm_fb_helper_setcmap,
@@ -338,6 +179,53 @@ out_unref:
 	return ret;
 }
=20
+static int qxlfb_framebuffer_dirty(struct drm_framebuffer *fb,
+				   struct drm_file *file_priv,
+				   unsigned flags, unsigned color,
+				   struct drm_clip_rect *clips,
+				   unsigned num_clips)
+{
+	struct qxl_device *qdev =3D fb->dev->dev_private;
+	struct fb_info *info =3D qdev->fbdev_info;
+	struct qxl_fbdev *qfbdev =3D info->par;
+	struct qxl_fb_image qxl_fb_image;
+	struct fb_image *image =3D &qxl_fb_image.fb_image;
+
+	/* TODO: hard coding 32 bpp */
+	int stride =3D qfbdev->qfb.base.pitches[0];
+
+	/*
+	 * we are using a shadow draw buffer, at qdev->surface0_shadow
+	 */
+	qxl_io_log(qdev, "dirty x[%d, %d], y[%d, %d]", clips->x1, clips->x2,
+		   clips->y1, clips->y2);
+	image->dx =3D clips->x1;
+	image->dy =3D clips->y1;
+	image->width =3D drm_clip_rect_width(clips);
+	image->height =3D drm_clip_rect_height(clips);
+	image->fg_color =3D 0xffffffff; /* unused, just to avoid uninitialized
+					 warnings */
+	image->bg_color =3D 0;
+	image->depth =3D 32;	     /* TODO: take from somewhere? */
+	image->cmap.start =3D 0;
+	image->cmap.len =3D 0;
+	image->cmap.red =3D NULL;
+	image->cmap.green =3D NULL;
+	image->cmap.blue =3D NULL;
+	image->cmap.transp =3D NULL;
+	image->data =3D qfbdev->shadow + (clips->x1 * 4) + (stride * clips->y1);
+
+	qxl_fb_image_init(&qxl_fb_image, qdev, info, NULL);
+	qxl_draw_opaque_fb(&qxl_fb_image, stride);
+
+	return 0;
+}
+
+static const struct drm_framebuffer_funcs qxlfb_fb_funcs =3D {
+	.destroy =3D qxl_user_framebuffer_destroy,
+	.dirty =3D qxlfb_framebuffer_dirty,
+};
+
 static int qxlfb_create(struct qxl_fbdev *qfbdev,
 			struct drm_fb_helper_surface_size *sizes)
 {
@@ -383,7 +271,8 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
=20
 	info->par =3D qfbdev;
=20
-	qxl_framebuffer_init(qdev->ddev, &qfbdev->qfb, &mode_cmd, gobj);
+	qxl_framebuffer_init(qdev->ddev, &qfbdev->qfb, &mode_cmd, gobj,
+			     &qxlfb_fb_funcs);
=20
 	fb =3D &qfbdev->qfb.base;
=20
@@ -504,7 +393,6 @@ int qxl_fbdev_init(struct qxl_device *qdev)
 	qfbdev->qdev =3D qdev;
 	qdev->mode_info.qfbdev =3D qfbdev;
 	spin_lock_init(&qfbdev->delayed_ops_lock);
-	spin_lock_init(&qfbdev->dirty.lock);
 	INIT_LIST_HEAD(&qfbdev->delayed_ops);
=20
 	drm_fb_helper_prepare(qdev->ddev, &qfbdev->helper,
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index b2977a1..2319800 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -261,10 +261,6 @@ static int qxl_device_init(struct qxl_device *qdev,
 	qdev->gc_queue =3D create_singlethread_workqueue("qxl_gc");
 	INIT_WORK(&qdev->gc_work, qxl_gc_work);
=20
-	r =3D qxl_fb_init(qdev);
-	if (r)
-		return r;
-
 	return 0;
 }
=20
--=20
2.2.2

