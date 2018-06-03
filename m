From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:40:59 +0000
Subject: [PATCH 06/21] udl-kms: make a local copy of fb_ops
Message-Id: <20180603144221.252346438@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

The defio subsystem overwrites the method fb_osp->mmap. That method is
stored in module's static data - and that means that if we have multiple
diplaylink adapters, they will over write each other's method.

In order to avoid interference between multiple adapters, we copy the
fb_ops structure to a device-local memory.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/gpu/drm/udl/udl_fb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-4.17-rc7/drivers/gpu/drm/udl/udl_fb.c
=================================--- linux-4.17-rc7.orig/drivers/gpu/drm/udl/udl_fb.c	2018-06-03 13:05:20.000000000 +0200
+++ linux-4.17-rc7/drivers/gpu/drm/udl/udl_fb.c	2018-06-03 13:08:03.000000000 +0200
@@ -34,6 +34,7 @@ module_param(fb_defio, int, S_IWUSR | S_
 struct udl_fbdev {
 	struct drm_fb_helper helper;
 	struct udl_framebuffer ufb;
+	struct fb_ops fb_ops;
 	int fb_count;
 };
 
@@ -405,7 +406,8 @@ static int udlfb_create(struct drm_fb_he
 	info->fix.smem_len = size;
 	info->fix.smem_start = (unsigned long)ufbdev->ufb.obj->vmapping;
 
-	info->fbops = &udlfb_ops;
+	ufbdev->fb_ops = udlfb_ops;
+	info->fbops = &ufbdev->fb_ops;
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
 	drm_fb_helper_fill_var(info, &ufbdev->helper, sizes->fb_width, sizes->fb_height);
 

