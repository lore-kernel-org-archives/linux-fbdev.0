From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 14 Nov 2019 12:51:04 +0000
Subject: [PATCH v5 1/3] drm/udl: Replace fbdev code with generic emulation
Message-Id: <20191114125106.28347-2-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191114125106.28347-1-tzimmermann@suse.de>
In-Reply-To: <20191114125106.28347-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, noralf@tronnes.org, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

The udl driver can use the generic fbdev implementation. Convert it.

v5:
	* initialize console after registering device
v4:
	* hardcode console bpp to 16
v3:
	* remove module parameter fb_bpp in favor of fbdev's video
	* call drm_fbdev_generic_setup() directly; remove udl_fbdev_init()
	* use default for struct drm_mode_config_funcs.output_poll_changed
	* use default for struct drm_driver.lastclose

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
---
 drivers/gpu/drm/udl/udl_drv.c     |   8 +-
 drivers/gpu/drm/udl/udl_drv.h     |   6 -
 drivers/gpu/drm/udl/udl_fb.c      | 282 ------------------------------
 drivers/gpu/drm/udl/udl_main.c    |   6 -
 drivers/gpu/drm/udl/udl_modeset.c |   1 -
 5 files changed, 7 insertions(+), 296 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 563cc5809e56..d5783fa32c5b 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -7,6 +7,7 @@
=20
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_ioctl.h>
@@ -107,8 +108,14 @@ static int udl_usb_probe(struct usb_interface *interfa=
ce,
=20
 	DRM_INFO("Initialized udl on minor %d\n", udl->drm.primary->index);
=20
+	r =3D drm_fbdev_generic_setup(&udl->drm, 16);
+	if (r)
+		goto err_drm_dev_unregister;
+
 	return 0;
=20
+err_drm_dev_unregister:
+	drm_dev_unregister(&udl->drm);
 err_free:
 	drm_dev_put(&udl->drm);
 	return r;
@@ -119,7 +126,6 @@ static void udl_usb_disconnect(struct usb_interface *in=
terface)
 	struct drm_device *dev =3D usb_get_intfdata(interface);
=20
 	drm_kms_helper_poll_disable(dev);
-	udl_fbdev_unplug(dev);
 	udl_drop_usb(dev);
 	drm_dev_unplug(dev);
 	drm_dev_put(dev);
diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 987d99ae2dfa..be585e3e572d 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -47,8 +47,6 @@ struct urb_list {
 	size_t size;
 };
=20
-struct udl_fbdev;
-
 struct udl_device {
 	struct drm_device drm;
 	struct device *dev;
@@ -62,7 +60,6 @@ struct udl_device {
 	struct urb_list urbs;
 	atomic_t lost_pixels; /* 1 =3D a render op failed. Need screen refresh */
=20
-	struct udl_fbdev *fbdev;
 	char mode_buf[1024];
 	uint32_t mode_buf_len;
 	atomic_t bytes_rendered; /* raw pixel-bytes driver asked to render */
@@ -97,9 +94,6 @@ void udl_urb_completion(struct urb *urb);
 int udl_init(struct udl_device *udl);
 void udl_fini(struct drm_device *dev);
=20
-int udl_fbdev_init(struct drm_device *dev);
-void udl_fbdev_cleanup(struct drm_device *dev);
-void udl_fbdev_unplug(struct drm_device *dev);
 struct drm_framebuffer *
 udl_fb_user_fb_create(struct drm_device *dev,
 		      struct drm_file *file,
diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
index f8153b726343..8fe4d8cf3212 100644
--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -13,27 +13,12 @@
=20
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_modeset_helper.h>
=20
 #include "udl_drv.h"
=20
-#define DL_DEFIO_WRITE_DELAY    (HZ/20) /* fb_deferred_io.delay in jiffies=
 */
-
-static int fb_defio =3D 0;  /* Optionally enable experimental fb_defio mma=
p support */
-static int fb_bpp =3D 16;
-
-module_param(fb_bpp, int, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
-module_param(fb_defio, int, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
-
-struct udl_fbdev {
-	struct drm_fb_helper helper; /* must be first */
-	struct udl_framebuffer ufb;
-	int fb_count;
-};
-
 #define DL_ALIGN_UP(x, a) ALIGN(x, a)
 #define DL_ALIGN_DOWN(x, a) ALIGN_DOWN(x, a)
=20
@@ -156,123 +141,6 @@ int udl_handle_damage(struct udl_framebuffer *fb, int=
 x, int y,
 	return 0;
 }
=20
-static int udl_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
-{
-	unsigned long start =3D vma->vm_start;
-	unsigned long size =3D vma->vm_end - vma->vm_start;
-	unsigned long offset;
-	unsigned long page, pos;
-
-	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
-		return -EINVAL;
-
-	offset =3D vma->vm_pgoff << PAGE_SHIFT;
-
-	if (offset > info->fix.smem_len || size > info->fix.smem_len - offset)
-		return -EINVAL;
-
-	pos =3D (unsigned long)info->fix.smem_start + offset;
-
-	pr_debug("mmap() framebuffer addr:%lu size:%lu\n",
-		  pos, size);
-
-	/* We don't want the framebuffer to be mapped encrypted */
-	vma->vm_page_prot =3D pgprot_decrypted(vma->vm_page_prot);
-
-	while (size > 0) {
-		page =3D vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
-			return -EAGAIN;
-
-		start +=3D PAGE_SIZE;
-		pos +=3D PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -=3D PAGE_SIZE;
-		else
-			size =3D 0;
-	}
-
-	/* VM_IO | VM_DONTEXPAND | VM_DONTDUMP are set by remap_pfn_range() */
-	return 0;
-}
-
-/*
- * It's common for several clients to have framebuffer open simultaneously.
- * e.g. both fbcon and X. Makes things interesting.
- * Assumes caller is holding info->lock (for open and release at least)
- */
-static int udl_fb_open(struct fb_info *info, int user)
-{
-	struct udl_fbdev *ufbdev =3D info->par;
-	struct drm_device *dev =3D ufbdev->ufb.base.dev;
-	struct udl_device *udl =3D to_udl(dev);
-
-	/* If the USB device is gone, we don't accept new opens */
-	if (drm_dev_is_unplugged(&udl->drm))
-		return -ENODEV;
-
-	ufbdev->fb_count++;
-
-#ifdef CONFIG_DRM_FBDEV_EMULATION
-	if (fb_defio && (info->fbdefio =3D NULL)) {
-		/* enable defio at last moment if not disabled by client */
-
-		struct fb_deferred_io *fbdefio;
-
-		fbdefio =3D kzalloc(sizeof(struct fb_deferred_io), GFP_KERNEL);
-
-		if (fbdefio) {
-			fbdefio->delay =3D DL_DEFIO_WRITE_DELAY;
-			fbdefio->deferred_io =3D drm_fb_helper_deferred_io;
-		}
-
-		info->fbdefio =3D fbdefio;
-		fb_deferred_io_init(info);
-	}
-#endif
-
-	pr_debug("open /dev/fb%d user=3D%d fb_info=3D%p count=3D%d\n",
-		  info->node, user, info, ufbdev->fb_count);
-
-	return 0;
-}
-
-
-/*
- * Assumes caller is holding info->lock mutex (for open and release at lea=
st)
- */
-static int udl_fb_release(struct fb_info *info, int user)
-{
-	struct udl_fbdev *ufbdev =3D info->par;
-
-	ufbdev->fb_count--;
-
-#ifdef CONFIG_DRM_FBDEV_EMULATION
-	if ((ufbdev->fb_count =3D 0) && (info->fbdefio)) {
-		fb_deferred_io_cleanup(info);
-		kfree(info->fbdefio);
-		info->fbdefio =3D NULL;
-		info->fbops->fb_mmap =3D udl_fb_mmap;
-	}
-#endif
-
-	pr_debug("released /dev/fb%d user=3D%d count=3D%d\n",
-		info->node, user, ufbdev->fb_count);
-
-	return 0;
-}
-
-static struct fb_ops udlfb_ops =3D {
-	.owner =3D THIS_MODULE,
-	DRM_FB_HELPER_DEFAULT_OPS,
-	.fb_fillrect =3D drm_fb_helper_sys_fillrect,
-	.fb_copyarea =3D drm_fb_helper_sys_copyarea,
-	.fb_imageblit =3D drm_fb_helper_sys_imageblit,
-	.fb_mmap =3D udl_fb_mmap,
-	.fb_open =3D udl_fb_open,
-	.fb_release =3D udl_fb_release,
-};
-
 static int udl_user_framebuffer_dirty(struct drm_framebuffer *fb,
 				      struct drm_file *file,
 				      unsigned flags, unsigned color,
@@ -347,156 +215,6 @@ udl_framebuffer_init(struct drm_device *dev,
 	return ret;
 }
=20
-
-static int udlfb_create(struct drm_fb_helper *helper,
-			struct drm_fb_helper_surface_size *sizes)
-{
-	struct udl_fbdev *ufbdev -		container_of(helper, struct udl_fbdev, helper=
);
-	struct drm_device *dev =3D ufbdev->helper.dev;
-	struct fb_info *info;
-	struct drm_framebuffer *fb;
-	struct drm_mode_fb_cmd2 mode_cmd;
-	struct drm_gem_shmem_object *shmem;
-	void *vaddr;
-	uint32_t size;
-	int ret =3D 0;
-
-	if (sizes->surface_bpp =3D 24)
-		sizes->surface_bpp =3D 32;
-
-	mode_cmd.width =3D sizes->surface_width;
-	mode_cmd.height =3D sizes->surface_height;
-	mode_cmd.pitches[0] =3D mode_cmd.width * ((sizes->surface_bpp + 7) / 8);
-
-	mode_cmd.pixel_format =3D drm_mode_legacy_fb_format(sizes->surface_bpp,
-							  sizes->surface_depth);
-
-	size =3D mode_cmd.pitches[0] * mode_cmd.height;
-	size =3D ALIGN(size, PAGE_SIZE);
-
-	shmem =3D drm_gem_shmem_create(dev, size);
-	if (IS_ERR(shmem)) {
-		ret =3D PTR_ERR(shmem);
-		goto out;
-	}
-
-	vaddr =3D drm_gem_shmem_vmap(&shmem->base);
-	if (IS_ERR(vaddr)) {
-		ret =3D PTR_ERR(vaddr);
-		DRM_ERROR("failed to vmap fb\n");
-		goto out_gfree;
-	}
-
-	info =3D drm_fb_helper_alloc_fbi(helper);
-	if (IS_ERR(info)) {
-		ret =3D PTR_ERR(info);
-		goto out_gfree;
-	}
-
-	ret =3D udl_framebuffer_init(dev, &ufbdev->ufb, &mode_cmd, shmem);
-	if (ret)
-		goto out_gfree;
-
-	fb =3D &ufbdev->ufb.base;
-
-	ufbdev->helper.fb =3D fb;
-
-	info->screen_base =3D vaddr;
-	info->fix.smem_len =3D size;
-	info->fix.smem_start =3D (unsigned long)vaddr;
-
-	info->fbops =3D &udlfb_ops;
-	drm_fb_helper_fill_info(info, &ufbdev->helper, sizes);
-
-	DRM_DEBUG_KMS("allocated %dx%d vmal %p\n",
-		      fb->width, fb->height,
-		      ufbdev->ufb.shmem->vaddr);
-
-	return ret;
-out_gfree:
-	drm_gem_object_put_unlocked(&ufbdev->ufb.shmem->base);
-out:
-	return ret;
-}
-
-static const struct drm_fb_helper_funcs udl_fb_helper_funcs =3D {
-	.fb_probe =3D udlfb_create,
-};
-
-static void udl_fbdev_destroy(struct drm_device *dev,
-			      struct udl_fbdev *ufbdev)
-{
-	drm_fb_helper_unregister_fbi(&ufbdev->helper);
-	drm_fb_helper_fini(&ufbdev->helper);
-	if (ufbdev->ufb.shmem) {
-		drm_framebuffer_unregister_private(&ufbdev->ufb.base);
-		drm_framebuffer_cleanup(&ufbdev->ufb.base);
-		drm_gem_object_put_unlocked(&ufbdev->ufb.shmem->base);
-	}
-}
-
-int udl_fbdev_init(struct drm_device *dev)
-{
-	struct udl_device *udl =3D to_udl(dev);
-	int bpp_sel =3D fb_bpp;
-	struct udl_fbdev *ufbdev;
-	int ret;
-
-	ufbdev =3D kzalloc(sizeof(struct udl_fbdev), GFP_KERNEL);
-	if (!ufbdev)
-		return -ENOMEM;
-
-	udl->fbdev =3D ufbdev;
-
-	drm_fb_helper_prepare(dev, &ufbdev->helper, &udl_fb_helper_funcs);
-
-	ret =3D drm_fb_helper_init(dev, &ufbdev->helper, 1);
-	if (ret)
-		goto free;
-
-	ret =3D drm_fb_helper_single_add_all_connectors(&ufbdev->helper);
-	if (ret)
-		goto fini;
-
-	/* disable all the possible outputs/crtcs before entering KMS mode */
-	drm_helper_disable_unused_functions(dev);
-
-	ret =3D drm_fb_helper_initial_config(&ufbdev->helper, bpp_sel);
-	if (ret)
-		goto fini;
-
-	return 0;
-
-fini:
-	drm_fb_helper_fini(&ufbdev->helper);
-free:
-	kfree(ufbdev);
-	return ret;
-}
-
-void udl_fbdev_cleanup(struct drm_device *dev)
-{
-	struct udl_device *udl =3D to_udl(dev);
-	if (!udl->fbdev)
-		return;
-
-	udl_fbdev_destroy(dev, udl->fbdev);
-	kfree(udl->fbdev);
-	udl->fbdev =3D NULL;
-}
-
-void udl_fbdev_unplug(struct drm_device *dev)
-{
-	struct udl_device *udl =3D to_udl(dev);
-	struct udl_fbdev *ufbdev;
-	if (!udl->fbdev)
-		return;
-
-	ufbdev =3D udl->fbdev;
-	drm_fb_helper_unlink_fbi(&ufbdev->helper);
-}
-
 struct drm_framebuffer *
 udl_fb_user_fb_create(struct drm_device *dev,
 		   struct drm_file *file,
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 4e854e017390..9b091b5b063e 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -338,10 +338,6 @@ int udl_init(struct udl_device *udl)
 	if (ret)
 		goto err;
=20
-	ret =3D udl_fbdev_init(dev);
-	if (ret)
-		goto err;
-
 	drm_kms_helper_poll_init(dev);
=20
 	return 0;
@@ -367,6 +363,4 @@ void udl_fini(struct drm_device *dev)
=20
 	if (udl->urbs.count)
 		udl_free_urb_list(dev);
-
-	udl_fbdev_cleanup(dev);
 }
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_mo=
deset.c
index bc1ab6060dc6..6582c9d27a87 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -422,7 +422,6 @@ static int udl_crtc_init(struct drm_device *dev)
=20
 static const struct drm_mode_config_funcs udl_mode_funcs =3D {
 	.fb_create =3D udl_fb_user_fb_create,
-	.output_poll_changed =3D NULL,
 };
=20
 int udl_modeset_init(struct drm_device *dev)
--=20
2.23.0
