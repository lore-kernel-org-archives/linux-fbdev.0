From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] neofb: fix sparse warnings
Date: Fri, 28 Nov 2008 18:19:24 +0100
Message-ID: <49305146.170e660a.2535.ffffbeb9@mx.google.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755353AbYK1UPZ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, trivial@kernel.org

Fix this sparse warnings:

  drivers/video/neofb.c:1456:4: warning: returning void-valued expression
  drivers/video/neofb.c:1464:3: warning: returning void-valued expression

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---
 drivers/video/neofb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index bfb802d..588527a 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -1453,7 +1453,8 @@ neo2200_imageblit(struct fb_info *info, const struct fb_image *image)
 			 * is less than 16 bits wide. This is due to insufficient
 			 * padding when writing the image. We need to adjust
 			 * struct fb_pixmap. Not yet done. */
-			return cfb_imageblit(info, image);
+			cfb_imageblit(info, image);
+			return;
 		}
 		bltCntl_flags = NEO_BC0_SRC_MONO;
 	} else if (image->depth == info->var.bits_per_pixel) {
@@ -1461,7 +1462,8 @@ neo2200_imageblit(struct fb_info *info, const struct fb_image *image)
 	} else {
 		/* We don't currently support hardware acceleration if image
 		 * depth is different from display */
-		return cfb_imageblit(info, image);
+		cfb_imageblit(info, image);
+		return;
 	}
 
 	switch (info->var.bits_per_pixel) {
-- 
1.5.6.3
