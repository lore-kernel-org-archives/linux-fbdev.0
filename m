From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] intelfb: fix sparse warnings
Date: Fri, 28 Nov 2008 18:28:49 +0100
Message-ID: <493051d1.0c11660a.4d00.ffffb9b4@mx.google.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755431AbYK1URf@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, trivial@kernel.org

Fix this sparse warnings:

  drivers/video/intelfb/intelfbdrv.c:1497:3: warning: returning void-valued expression
  drivers/video/intelfb/intelfbdrv.c:1525:3: warning: returning void-valued expression
  drivers/video/intelfb/intelfbdrv.c:1544:3: warning: returning void-valued expression
  drivers/video/intelfb/intelfbdrv.c:1558:3: warning: returning void-valued expression

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---
 drivers/video/intelfb/intelfbdrv.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index a09e236..6d8e541 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -1493,8 +1493,10 @@ static void intelfb_fillrect (struct fb_info *info,
 	DBG_MSG("intelfb_fillrect\n");
 #endif
 
-	if (!ACCEL(dinfo, info) || dinfo->depth == 4)
-		return cfb_fillrect(info, rect);
+	if (!ACCEL(dinfo, info) || dinfo->depth == 4) {
+		cfb_fillrect(info, rect);
+		return;
+	}
 
 	if (rect->rop == ROP_COPY)
 		rop = PAT_ROP_GXCOPY;
@@ -1521,8 +1523,10 @@ static void intelfb_copyarea(struct fb_info *info,
 	DBG_MSG("intelfb_copyarea\n");
 #endif
 
-	if (!ACCEL(dinfo, info) || dinfo->depth == 4)
-		return cfb_copyarea(info, region);
+	if (!ACCEL(dinfo, info) || dinfo->depth == 4) {
+		cfb_copyarea(info, region);
+		return;
+	}
 
 	intelfbhw_do_bitblt(dinfo, region->sx, region->sy, region->dx,
 			    region->dy, region->width, region->height,
@@ -1540,8 +1544,10 @@ static void intelfb_imageblit(struct fb_info *info,
 #endif
 
 	if (!ACCEL(dinfo, info) || dinfo->depth == 4
-	    || image->depth != 1)
-		return cfb_imageblit(info, image);
+	    || image->depth != 1) {
+		cfb_imageblit(info, image);
+		return;
+	}
 
 	if (dinfo->depth != 8) {
 		fgcolor = dinfo->pseudo_palette[image->fg_color];
@@ -1554,8 +1560,10 @@ static void intelfb_imageblit(struct fb_info *info,
 	if (!intelfbhw_do_drawglyph(dinfo, fgcolor, bgcolor, image->width,
 				    image->height, image->data,
 				    image->dx, image->dy,
-				    dinfo->pitch, info->var.bits_per_pixel))
-		return cfb_imageblit(info, image);
+				    dinfo->pitch, info->var.bits_per_pixel)) {
+		cfb_imageblit(info, image);
+		return;
+	}
 }
 
 static int intelfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
-- 
1.5.6.3
