From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 21 Dec 2010 10:46:26 +0000
Subject: [PATCH 1/3] fbdev: sh-mobile: restore display size configuration
Message-Id: <Pine.LNX.4.64.1012211048100.32347@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

An earlier patch replaced open-coded video-mode configuration from 
platform data by a call to fb_videomode_to_var(), thereby setting 
ofdisplay sizes have been accidentally lost. Restore them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index b02d97a..257ed0c 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1238,12 +1238,14 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			mode = &default_720p;
 			num_cfg = 1;
 		} else {
-			num_cfg = ch->cfg.num_cfg;
+			num_cfg = cfg->num_cfg;
 		}
 
 		fb_videomode_to_modelist(mode, num_cfg, &info->modelist);
 
 		fb_videomode_to_var(var, mode);
+		var->width = cfg->lcd_size_cfg.width;
+		var->height = cfg->lcd_size_cfg.height;
 		/* Default Y virtual resolution is 2x panel size */
 		var->yres_virtual = var->yres * 2;
 		var->activate = FB_ACTIVATE_NOW;
