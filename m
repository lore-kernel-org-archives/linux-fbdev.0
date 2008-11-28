From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] i810: fix sparse warnings
Date: Fri, 28 Nov 2008 18:25:01 +0100
Message-ID: <49305187.02a1660a.3c23.ffffa8ef@mx.google.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753950AbYK1UQW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, trivial@kernel.org

Fix this sparse warnings:

  drivers/video/i810/i810_accel.c:305:3: warning: returning void-valued expression
  drivers/video/i810/i810_accel.c:331:3: warning: returning void-valued expression
  drivers/video/i810/i810_accel.c:370:3: warning: returning void-valued expression

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---
 drivers/video/i810/i810_accel.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/video/i810/i810_accel.c b/drivers/video/i810/i810_accel.c
index 76764ea..f5bedee 100644
--- a/drivers/video/i810/i810_accel.c
+++ b/drivers/video/i810/i810_accel.c
@@ -301,8 +301,10 @@ void i810fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 	u32 dx, dy, width, height, dest, rop = 0, color = 0;
 
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP ||
-	    par->depth == 4) 
-		return cfb_fillrect(info, rect);
+	    par->depth == 4) {
+		cfb_fillrect(info, rect);
+		return;
+	}
 
 	if (par->depth == 1) 
 		color = rect->color;
@@ -327,8 +329,10 @@ void i810fb_copyarea(struct fb_info *info, const struct fb_copyarea *region)
 	u32 sx, sy, dx, dy, pitch, width, height, src, dest, xdir;
 
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP ||
-	    par->depth == 4)
-		return cfb_copyarea(info, region);
+	    par->depth == 4) {
+		cfb_copyarea(info, region);
+		return;
+	}
 
 	dx = region->dx * par->depth;
 	sx = region->sx * par->depth;
@@ -366,8 +370,10 @@ void i810fb_imageblit(struct fb_info *info, const struct fb_image *image)
 	u32 fg = 0, bg = 0, size, dst;
 	
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP ||
-	    par->depth == 4 || image->depth != 1) 
-		return cfb_imageblit(info, image);
+	    par->depth == 4 || image->depth != 1) {
+		cfb_imageblit(info, image);
+		return;
+	}
 
 	switch (info->var.bits_per_pixel) {
 	case 8:
-- 
1.5.6.3
