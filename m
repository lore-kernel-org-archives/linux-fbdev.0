From: Timur Tabi <timur@freescale.com>
Date: Wed, 05 Oct 2011 00:36:46 +0000
Subject: [PATCH 3/9] drivers/video: fsl-diu-fb: remove broken screen blanking support
Message-Id: <1317775012-9797-3-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The function which is supposed to provide screen blanking support doesn't
actually do anything, so the framebuffer layer thinks the screen has
been blanked when it really isn't.  Remove the code completely for now.

A side-effect of this change is that the framebuffer console blanking now
works correctly.  Presumably this is because the console now receives -EINVAL
instead of '0' when it asks the driver to blank the screen, so the console
does it manually now.

A signficant refactoring of the driver is planned, and proper hardware
blanking support will added afterwards.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   38 --------------------------------------
 1 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 9b3891a..4dc65c9 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -231,7 +231,6 @@ struct mfb_info {
 	int type;
 	char *id;
 	int registered;
-	int blank;
 	unsigned long pseudo_palette[16];
 	struct diu_ad *ad;
 	int cursor_reset;
@@ -960,37 +959,6 @@ static int fsl_diu_pan_display(struct fb_var_screeninfo *var,
 	return 0;
 }
 
-/*
- * Blank the screen if blank_mode != 0, else unblank. Return 0 if blanking
- * succeeded, != 0 if un-/blanking failed.
- * blank_mode = 2: suspend vsync
- * blank_mode = 3: suspend hsync
- * blank_mode = 4: powerdown
- */
-static int fsl_diu_blank(int blank_mode, struct fb_info *info)
-{
-	struct mfb_info *mfbi = info->par;
-
-	mfbi->blank = blank_mode;
-
-	switch (blank_mode) {
-	case FB_BLANK_VSYNC_SUSPEND:
-	case FB_BLANK_HSYNC_SUSPEND:
-	/* FIXME: fixes to enable_panel and enable lcdc needed */
-	case FB_BLANK_NORMAL:
-	/*	fsl_diu_disable_panel(info);*/
-		break;
-	case FB_BLANK_POWERDOWN:
-	/*	disable_lcdc(info);	*/
-		break;
-	case FB_BLANK_UNBLANK:
-	/*	fsl_diu_enable_panel(info);*/
-		break;
-	}
-
-	return 0;
-}
-
 static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
 		       unsigned long arg)
 {
@@ -1137,7 +1105,6 @@ static struct fb_ops fsl_diu_ops = {
 	.fb_check_var = fsl_diu_check_var,
 	.fb_set_par = fsl_diu_set_par,
 	.fb_setcolreg = fsl_diu_setcolreg,
-	.fb_blank = fsl_diu_blank,
 	.fb_pan_display = fsl_diu_pan_display,
 	.fb_fillrect = cfb_fillrect,
 	.fb_copyarea = cfb_copyarea,
@@ -1232,11 +1199,6 @@ static int __devinit install_fb(struct fb_info *info)
 		fb_videomode_to_var(&info->var, modedb);
 	}
 
-	if (mfbi->type = MFB_TYPE_OFF)
-		mfbi->blank = FB_BLANK_NORMAL;
-	else
-		mfbi->blank = FB_BLANK_UNBLANK;
-
 	if (fsl_diu_check_var(&info->var, info)) {
 		dev_err(info->dev, "fsl_diu_check_var failed\n");
 		unmap_video_memory(info);
-- 
1.7.4.4


