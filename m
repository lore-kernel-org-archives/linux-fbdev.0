From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 17 Aug 2018 19:15:52 +0000
Subject: [PATCH] mach64: fix console corruption in 24bpp mode
Message-Id: <alpine.LRH.2.02.1808171514010.31883@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

There's console font corruption when using the mach64 driver in 24bpp
mode.

In 24bpp mode, the mach64 accelerator is set up for 8-bpp mode (with
horizontal width and stride multiplied by 3). In this mode, the
accelerator can't even possibly support color expansion. Consquently, we
have to use an unaccelerated function cfb_imageblit for color expansion.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/video/fbdev/aty/mach64_accel.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-stable/drivers/video/fbdev/aty/mach64_accel.c
=================================--- linux-stable.orig/drivers/video/fbdev/aty/mach64_accel.c	2018-04-20 18:11:01.000000000 +0200
+++ linux-stable/drivers/video/fbdev/aty/mach64_accel.c	2018-08-13 17:37:04.000000000 +0200
@@ -291,7 +291,8 @@ void atyfb_imageblit(struct fb_info *inf
 	if (!image->width || !image->height)
 		return;
 	if (!par->accel_flags ||
-	    (image->depth != 1 && info->var.bits_per_pixel != image->depth)) {
+	    (image->depth != 1 && info->var.bits_per_pixel != image->depth) ||
+	    (image->depth = 1 && info->var.bits_per_pixel = 24)) {
 		cfb_imageblit(info, image);
 		return;
 	}
