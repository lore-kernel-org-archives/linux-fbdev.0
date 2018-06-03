From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:07 +0000
Subject: [PATCH 14/21] udlfb: make a local copy of fb_ops
Message-Id: <20180603144224.059013384@twibright.com>
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
 drivers/video/fbdev/udlfb.c |    3 ++-
 include/video/udlfb.h       |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-4.17-rc7/drivers/video/fbdev/udlfb.c
=================================--- linux-4.17-rc7.orig/drivers/video/fbdev/udlfb.c	2018-06-03 13:17:33.000000000 +0200
+++ linux-4.17-rc7/drivers/video/fbdev/udlfb.c	2018-06-03 13:17:33.000000000 +0200
@@ -1665,7 +1665,8 @@ static void dlfb_init_framebuffer_work(s
 	dlfb->info = info;
 	info->par = dlfb;
 	info->pseudo_palette = dlfb->pseudo_palette;
-	info->fbops = &dlfb_ops;
+	dlfb->ops = dlfb_ops;
+	info->fbops = &dlfb->ops;
 
 	retval = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (retval < 0) {
Index: linux-4.17-rc7/include/video/udlfb.h
=================================--- linux-4.17-rc7.orig/include/video/udlfb.h	2018-06-03 13:17:33.000000000 +0200
+++ linux-4.17-rc7/include/video/udlfb.h	2018-06-03 13:17:33.000000000 +0200
@@ -51,6 +51,7 @@ struct dlfb_data {
 	int base8;
 	u32 pseudo_palette[256];
 	int blank_mode; /*one of FB_BLANK_ */
+	struct fb_ops ops;
 	/* blit-only rendering path metrics, exposed through sysfs */
 	atomic_t bytes_rendered; /* raw pixel-bytes driver asked to render */
 	atomic_t bytes_identical; /* saved effort with backbuffer comparison */

