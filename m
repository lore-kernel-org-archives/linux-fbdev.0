From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Jul 2011 11:14:36 +0000
Subject: [PATCH v3 22/29] sisfb: use display information in info not in var for panning
Message-Id: <1310123683-8064-23-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Fix checkpatch.pl warnings in the surrounding code.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/sis/sis_main.c |   30 ++++++++++--------------------
 1 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 7525984..078ca21 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -1333,19 +1333,14 @@ sisfb_set_base_CRT2(struct sis_video_info *ivideo, unsigned int base)
 }
 
 static int
-sisfb_pan_var(struct sis_video_info *ivideo, struct fb_var_screeninfo *var)
+sisfb_pan_var(struct sis_video_info *ivideo, struct fb_info *info,
+	      struct fb_var_screeninfo *var)
 {
-	if(var->xoffset > (var->xres_virtual - var->xres)) {
-		return -EINVAL;
-	}
-	if(var->yoffset > (var->yres_virtual - var->yres)) {
-		return -EINVAL;
-	}
-
-	ivideo->current_base = (var->yoffset * var->xres_virtual) + var->xoffset;
+	ivideo->current_base = var->yoffset * info->var.xres_virtual
+			     + var->xoffset;
 
 	/* calculate base bpp dep. */
-	switch(var->bits_per_pixel) {
+	switch (info->var.bits_per_pixel) {
 	case 32:
 		break;
 	case 16:
@@ -1635,20 +1630,15 @@ sisfb_pan_display(struct fb_var_screeninfo *var, struct fb_info* info)
 	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
 	int err;
 
-	if(var->xoffset > (var->xres_virtual - var->xres))
-		return -EINVAL;
-
-	if(var->yoffset > (var->yres_virtual - var->yres))
-		return -EINVAL;
-
-	if(var->vmode & FB_VMODE_YWRAP)
+	if (var->vmode & FB_VMODE_YWRAP)
 		return -EINVAL;
 
-	if(var->xoffset + info->var.xres > info->var.xres_virtual ||
-	   var->yoffset + info->var.yres > info->var.yres_virtual)
+	if (var->xoffset + info->var.xres > info->var.xres_virtual ||
+	    var->yoffset + info->var.yres > info->var.yres_virtual)
 		return -EINVAL;
 
-	if((err = sisfb_pan_var(ivideo, var)) < 0)
+	err = sisfb_pan_var(ivideo, info, var);
+	if (err < 0)
 		return err;
 
 	info->var.xoffset = var->xoffset;
-- 
1.7.3.4

