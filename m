From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:19:49 +0000
Subject: [PATCH 01/15] fbdev: sh_mobile_lcdcfb: use fb_videomode_to_var()
Message-Id: <Pine.LNX.4.64.1009030909560.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the standard fb_videomode_to_var() instead of filling fb_var_screeninfo
fields manually in, also remove a redundant memset(0).

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index d72075a..43132de 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -837,7 +837,6 @@ static int sh_mobile_ioctl(struct fb_info *info, unsigned int cmd,
 	return retval;
 }
 
-
 static struct fb_ops sh_mobile_lcdc_ops = {
 	.owner          = THIS_MODULE,
 	.fb_setcolreg	= sh_mobile_lcdc_setcolreg,
@@ -1117,21 +1116,9 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		var = &info->var;
 		lcd_cfg = &cfg->lcd_cfg;
 		info->fbops = &sh_mobile_lcdc_ops;
-		var->xres = var->xres_virtual = lcd_cfg->xres;
-		var->yres = lcd_cfg->yres;
+		fb_videomode_to_var(var, lcd_cfg);
 		/* Default Y virtual resolution is 2x panel size */
 		var->yres_virtual = var->yres * 2;
-		var->width = cfg->lcd_size_cfg.width;
-		var->height = cfg->lcd_size_cfg.height;
-		var->activate = FB_ACTIVATE_NOW;
-		var->left_margin = lcd_cfg->left_margin;
-		var->right_margin = lcd_cfg->right_margin;
-		var->upper_margin = lcd_cfg->upper_margin;
-		var->lower_margin = lcd_cfg->lower_margin;
-		var->hsync_len = lcd_cfg->hsync_len;
-		var->vsync_len = lcd_cfg->vsync_len;
-		var->sync = lcd_cfg->sync;
-		var->pixclock = lcd_cfg->pixclock;
 
 		error = sh_mobile_lcdc_set_bpp(var, cfg->bpp);
 		if (error)
@@ -1161,7 +1148,6 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			break;
 		}
 
-		memset(buf, 0, info->fix.smem_len);
 		info->fix.smem_start = priv->ch[i].dma_handle;
 		info->screen_base = buf;
 		info->device = &pdev->dev;
-- 
1.7.1

