From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 19 Aug 2011 09:16:09 +0000
Subject: [PATCH 4/7] fbdev: sh_mobile_lcdc: Update fix.line_length in .fb_set_par()
Message-Id: <1313745372-20856-5-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Instead of updating the fixed screen information line length manually
after calling fb_set_var() in sh_mobile_fb_reconfig(), update the field
in the .fb_set_par() operation handler.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 1ff215c..b6da1d6 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -998,11 +998,6 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 		/* Couldn't reconfigure, hopefully, can continue as before */
 		return;
 
-	if (info->var.nonstd)
-		info->fix.line_length = mode1.xres;
-	else
-		info->fix.line_length = mode1.xres * (ch->cfg.bpp / 8);
-
 	/*
 	 * fb_set_var() calls the notifier change internally, only if
 	 * FBINFO_MISC_USEREVENT flag is set. Since we do not want to fake a
@@ -1157,12 +1152,22 @@ static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *in
 static int sh_mobile_set_par(struct fb_info *info)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
+	u32 line_length = info->fix.line_length;
 	int ret;
 
 	sh_mobile_lcdc_stop(ch->lcdc);
+
+	if (info->var.nonstd)
+		info->fix.line_length = info->var.xres;
+	else
+		info->fix.line_length = info->var.xres
+				      * info->var.bits_per_pixel / 8;
+
 	ret = sh_mobile_lcdc_start(ch->lcdc);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(info->dev, "%s: unable to restart LCDC\n", __func__);
+		info->fix.line_length = line_length;
+	}
 
 	return ret;
 }
-- 
1.7.3.4

