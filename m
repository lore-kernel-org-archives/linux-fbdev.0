From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Date: Wed, 27 Apr 2016 18:16:36 +0000
Subject: [PATCH v3 7/7] drm/udl: Use drm_fb_helper deferred_io support
Message-Id: <1461780996-8612-8-git-send-email-noralf@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461780996-8612-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461780996-8612-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: daniel@ffwll.ch, laurent.pinchart@ideasonboard.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>

Use the fbdev deferred io support in drm_fb_helper.
The (struct fb_ops *)->fb_{fillrect,copyarea,imageblit} functions will
now schedule a worker instead of being flushed directly like it was
previously (recorded when in atomic).

This patch has only been compile tested.

Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

Changes since v1:
- No need to enable deferred_io by default since drm_fb_helper uses
  a dedicated worker for flushing

 drivers/gpu/drm/udl/udl_drv.h |   2 -
 drivers/gpu/drm/udl/udl_fb.c  | 140 ++------------------------------------=
----
 2 files changed, 6 insertions(+), 136 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 4a064ef..0b03d34 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -81,8 +81,6 @@ struct udl_framebuffer {
 	struct drm_framebuffer base;
 	struct udl_gem_object *obj;
 	bool active_16; /* active on the 16-bit channel */
-	int x1, y1, x2, y2; /* dirty rect */
-	spinlock_t dirty_lock;
 };

 #define to_udl_fb(x) container_of(x, struct udl_framebuffer, base)
diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
index a52de2f..4a9b432 100644
--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -77,68 +77,6 @@ static uint16_t rgb16(uint32_t col)
 }
 #endif

-/*
- * NOTE: fb_defio.c is holding info->fbdefio.mutex
- *   Touching ANY framebuffer memory that triggers a page fault
- *   in fb_defio will cause a deadlock, when it also tries to
- *   grab the same mutex.
- */
-static void udlfb_dpy_deferred_io(struct fb_info *info,
-				  struct list_head *pagelist)
-{
-	struct page *cur;
-	struct fb_deferred_io *fbdefio =3D info->fbdefio;
-	struct udl_fbdev *ufbdev =3D info->par;
-	struct drm_device *dev =3D ufbdev->ufb.base.dev;
-	struct udl_device *udl =3D dev->dev_private;
-	struct urb *urb;
-	char *cmd;
-	cycles_t start_cycles, end_cycles;
-	int bytes_sent =3D 0;
-	int bytes_identical =3D 0;
-	int bytes_rendered =3D 0;
-
-	if (!fb_defio)
-		return;
-
-	start_cycles =3D get_cycles();
-
-	urb =3D udl_get_urb(dev);
-	if (!urb)
-		return;
-
-	cmd =3D urb->transfer_buffer;
-
-	/* walk the written page list and render each to device */
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
-
-		if (udl_render_hline(dev, (ufbdev->ufb.base.bits_per_pixel / 8),
-				     &urb, (char *) info->fix.smem_start,
-				     &cmd, cur->index << PAGE_SHIFT,
-				     cur->index << PAGE_SHIFT,
-				     PAGE_SIZE, &bytes_identical, &bytes_sent))
-			goto error;
-		bytes_rendered +=3D PAGE_SIZE;
-	}
-
-	if (cmd > (char *) urb->transfer_buffer) {
-		/* Send partial buffer remaining before exiting */
-		int len =3D cmd - (char *) urb->transfer_buffer;
-		udl_submit_urb(dev, urb, len);
-		bytes_sent +=3D len;
-	} else
-		udl_urb_completion(urb);
-
-error:
-	atomic_add(bytes_sent, &udl->bytes_sent);
-	atomic_add(bytes_identical, &udl->bytes_identical);
-	atomic_add(bytes_rendered, &udl->bytes_rendered);
-	end_cycles =3D get_cycles();
-	atomic_add(((unsigned int) ((end_cycles - start_cycles)
-		    >> 10)), /* Kcycles */
-		   &udl->cpu_kcycles_used);
-}
-
 int udl_handle_damage(struct udl_framebuffer *fb, int x, int y,
 		      int width, int height)
 {
@@ -152,9 +90,6 @@ int udl_handle_damage(struct udl_framebuffer *fb, int x,=
 int y,
 	struct urb *urb;
 	int aligned_x;
 	int bpp =3D (fb->base.bits_per_pixel / 8);
-	int x2, y2;
-	bool store_for_later =3D false;
-	unsigned long flags;

 	if (!fb->active_16)
 		return 0;
@@ -180,38 +115,6 @@ int udl_handle_damage(struct udl_framebuffer *fb, int =
x, int y,
 	    (y + height > fb->base.height))
 		return -EINVAL;

-	/* if we are in atomic just store the info
-	   can't test inside spin lock */
-	if (in_atomic())
-		store_for_later =3D true;
-
-	x2 =3D x + width - 1;
-	y2 =3D y + height - 1;
-
-	spin_lock_irqsave(&fb->dirty_lock, flags);
-
-	if (fb->y1 < y)
-		y =3D fb->y1;
-	if (fb->y2 > y2)
-		y2 =3D fb->y2;
-	if (fb->x1 < x)
-		x =3D fb->x1;
-	if (fb->x2 > x2)
-		x2 =3D fb->x2;
-
-	if (store_for_later) {
-		fb->x1 =3D x;
-		fb->x2 =3D x2;
-		fb->y1 =3D y;
-		fb->y2 =3D y2;
-		spin_unlock_irqrestore(&fb->dirty_lock, flags);
-		return 0;
-	}
-
-	fb->x1 =3D fb->y1 =3D INT_MAX;
-	fb->x2 =3D fb->y2 =3D 0;
-
-	spin_unlock_irqrestore(&fb->dirty_lock, flags);
 	start_cycles =3D get_cycles();

 	urb =3D udl_get_urb(dev);
@@ -219,14 +122,14 @@ int udl_handle_damage(struct udl_framebuffer *fb, int=
 x, int y,
 		return 0;
 	cmd =3D urb->transfer_buffer;

-	for (i =3D y; i <=3D y2 ; i++) {
+	for (i =3D y; i < height ; i++) {
 		const int line_offset =3D fb->base.pitches[0] * i;
 		const int byte_offset =3D line_offset + (x * bpp);
 		const int dev_byte_offset =3D (fb->base.width * bpp * i) + (x * bpp);
 		if (udl_render_hline(dev, bpp, &urb,
 				     (char *) fb->obj->vmapping,
 				     &cmd, byte_offset, dev_byte_offset,
-				     (x2 - x + 1) * bpp,
+				     width * bpp,
 				     &bytes_identical, &bytes_sent))
 			goto error;
 	}
@@ -283,36 +186,6 @@ static int udl_fb_mmap(struct fb_info *info, struct vm=
_area_struct *vma)
 	return 0;
 }

-static void udl_fb_fillrect(struct fb_info *info, const struct fb_fillrect=
 *rect)
-{
-	struct udl_fbdev *ufbdev =3D info->par;
-
-	sys_fillrect(info, rect);
-
-	udl_handle_damage(&ufbdev->ufb, rect->dx, rect->dy, rect->width,
-			  rect->height);
-}
-
-static void udl_fb_copyarea(struct fb_info *info, const struct fb_copyarea=
 *region)
-{
-	struct udl_fbdev *ufbdev =3D info->par;
-
-	sys_copyarea(info, region);
-
-	udl_handle_damage(&ufbdev->ufb, region->dx, region->dy, region->width,
-			  region->height);
-}
-
-static void udl_fb_imageblit(struct fb_info *info, const struct fb_image *=
image)
-{
-	struct udl_fbdev *ufbdev =3D info->par;
-
-	sys_imageblit(info, image);
-
-	udl_handle_damage(&ufbdev->ufb, image->dx, image->dy, image->width,
-			  image->height);
-}
-
 /*
  * It's common for several clients to have framebuffer open simultaneously.
  * e.g. both fbcon and X. Makes things interesting.
@@ -339,7 +212,7 @@ static int udl_fb_open(struct fb_info *info, int user)

 		if (fbdefio) {
 			fbdefio->delay =3D DL_DEFIO_WRITE_DELAY;
-			fbdefio->deferred_io =3D udlfb_dpy_deferred_io;
+			fbdefio->deferred_io =3D drm_fb_helper_deferred_io;
 		}

 		info->fbdefio =3D fbdefio;
@@ -379,9 +252,9 @@ static struct fb_ops udlfb_ops =3D {
 	.owner =3D THIS_MODULE,
 	.fb_check_var =3D drm_fb_helper_check_var,
 	.fb_set_par =3D drm_fb_helper_set_par,
-	.fb_fillrect =3D udl_fb_fillrect,
-	.fb_copyarea =3D udl_fb_copyarea,
-	.fb_imageblit =3D udl_fb_imageblit,
+	.fb_fillrect =3D drm_fb_helper_sys_fillrect,
+	.fb_copyarea =3D drm_fb_helper_sys_copyarea,
+	.fb_imageblit =3D drm_fb_helper_sys_imageblit,
 	.fb_pan_display =3D drm_fb_helper_pan_display,
 	.fb_blank =3D drm_fb_helper_blank,
 	.fb_setcmap =3D drm_fb_helper_setcmap,
@@ -458,7 +331,6 @@ udl_framebuffer_init(struct drm_device *dev,
 {
 	int ret;

-	spin_lock_init(&ufb->dirty_lock);
 	ufb->obj =3D obj;
 	drm_helper_mode_fill_fb_struct(&ufb->base, mode_cmd);
 	ret =3D drm_framebuffer_init(dev, &ufb->base, &udlfb_funcs);
--
2.2.2

