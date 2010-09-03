From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:12 +0000
Subject: [PATCH 07/15] fbdev: sh_mobile_lcdcfb: allocate memory, sufficient
Message-Id: <Pine.LNX.4.64.1009030913380.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Now, that we add support for multiple modes to the sh_mobile_lcdcfb driver, it
has to allocate memory, sufficient for the biggest of them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 2f6e37e..ddd6c46 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1103,8 +1103,10 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < j; i++) {
 		struct fb_var_screeninfo *var;
-		const struct fb_videomode *lcd_cfg;
+		const struct fb_videomode *lcd_cfg, *max_cfg = NULL;
 		struct sh_mobile_lcdc_chan *ch = priv->ch + i;
+		unsigned long max_size = 0;
+		int k;
 
 		cfg = &ch->cfg;
 
@@ -1117,9 +1119,8 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 		info = ch->info;
 		var = &info->var;
-		lcd_cfg = &cfg->lcd_cfg[0];
 		info->fbops = &sh_mobile_lcdc_ops;
-		fb_videomode_to_var(var, lcd_cfg);
+		fb_videomode_to_var(var, &cfg->lcd_cfg[0]);
 		/* Default Y virtual resolution is 2x panel size */
 		var->yres_virtual = var->yres * 2;
 
@@ -1127,10 +1128,23 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		if (error)
 			break;
 
+		for (k = 0, lcd_cfg = cfg->lcd_cfg;
+		     k < cfg->num_cfg;
+		     k++, lcd_cfg++) {
+			unsigned long size = lcd_cfg->yres * lcd_cfg->xres;
+
+			if (size > max_size) {
+				max_cfg = lcd_cfg;
+				max_size = size;
+			}
+		}
+
+		dev_dbg(&pdev->dev, "Found largest videomode %ux%u\n",
+			max_cfg->xres, max_cfg->yres);
+
 		info->fix = sh_mobile_lcdc_fix;
-		info->fix.line_length = lcd_cfg->xres * (cfg->bpp / 8);
-		info->fix.smem_len = info->fix.line_length *
-			var->yres_virtual;
+		info->fix.line_length = cfg->lcd_cfg[0].xres * (cfg->bpp / 8);
+		info->fix.smem_len = max_size * (cfg->bpp / 8) * 2;
 
 		buf = dma_alloc_coherent(&pdev->dev, info->fix.smem_len,
 					 &ch->dma_handle, GFP_KERNEL);
-- 
1.7.1

