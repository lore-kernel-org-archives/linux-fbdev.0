From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:51 +0000
Subject: [PATCH 06/13] drivers/video: fsl-diu-fb: remove redundant default video mode
Message-Id: <1316123098-30967-7-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The framebuffer layer already uses the first video mode defined in the
fb_videomode array as a default, so there's no need to duplicate the
first entry into a stand-alone structure.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   32 +++++++-------------------------
 1 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 96417ab..c893954 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -36,26 +36,10 @@
 #include "edid.h"
 
 /*
- * These parameters give default parameters
- * for video output 1024x768,
- * FIXME - change timing to proper amounts
- * hsync 31.5kHz, vsync 60Hz
+ * List of supported video modes
+ *
+ * The first entry is the default video mode
  */
-static struct fb_videomode __devinitdata fsl_diu_default_mode = {
-	.refresh	= 60,
-	.xres		= 1024,
-	.yres		= 768,
-	.pixclock	= 15385,
-	.left_margin	= 160,
-	.right_margin	= 24,
-	.upper_margin	= 29,
-	.lower_margin	= 3,
-	.hsync_len	= 136,
-	.vsync_len	= 6,
-	.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	.vmode		= FB_VMODE_NONINTERLACED
-};
-
 static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
 	{
 		.name		= "1024x768-60",
@@ -1165,8 +1149,8 @@ static int __devinit install_fb(struct fb_info *info)
 	} else {
 		aoi_mode = init_aoi_mode;
 	}
-	rc = fb_find_mode(&info->var, info, aoi_mode, db, dbsize,
-			  &fsl_diu_default_mode, default_bpp);
+	rc = fb_find_mode(&info->var, info, aoi_mode, db, dbsize, NULL,
+			  default_bpp);
 	if (!rc) {
 		/*
 		 * For plane 0 we continue and look into
@@ -1180,10 +1164,8 @@ static int __devinit install_fb(struct fb_info *info)
 
 	if (!has_default_mode) {
 		rc = fb_find_mode(&info->var, info, aoi_mode, fsl_diu_mode_db,
-				  ARRAY_SIZE(fsl_diu_mode_db),
-				  &fsl_diu_default_mode,
-				  default_bpp);
-		if (rc > 0 && rc < 5)
+			ARRAY_SIZE(fsl_diu_mode_db), NULL, default_bpp);
+		if (rc)
 			has_default_mode = 1;
 	}
 
-- 
1.7.3.4


