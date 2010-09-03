From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:00 +0000
Subject: [PATCH 04/15] fbdev: sh_mobile_lcdcfb: minor simplifications and
Message-Id: <Pine.LNX.4.64.1009030911520.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove an unused variable and simplify several pointer dereferences.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |   51 +++++++++++++++++++------------------
 1 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 295bf4b..e4f6012 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -460,7 +460,6 @@ static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
 static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 {
 	struct sh_mobile_lcdc_chan *ch;
-	struct fb_videomode *lcd_cfg;
 	struct sh_mobile_lcdc_board_cfg	*board_cfg;
 	unsigned long tmp;
 	int k, m;
@@ -518,7 +517,6 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
 		ch = &priv->ch[k];
-		lcd_cfg = &ch->cfg.lcd_cfg;
 
 		if (!ch->enabled)
 			continue;
@@ -1018,14 +1016,14 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 {
 	struct fb_info *info;
 	struct sh_mobile_lcdc_priv *priv;
-	struct sh_mobile_lcdc_info *pdata;
+	struct sh_mobile_lcdc_info *pdata = pdev->dev.platform_data;
 	struct sh_mobile_lcdc_chan_cfg *cfg;
 	struct resource *res;
 	int error;
 	void *buf;
 	int i, j;
 
-	if (!pdev->dev.platform_data) {
+	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data defined\n");
 		return -EINVAL;
 	}
@@ -1053,32 +1051,33 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 	}
 
 	priv->irq = i;
-	pdata = pdev->dev.platform_data;
 	atomic_set(&priv->hw_usecnt, -1);
 
 	j = 0;
 	for (i = 0; i < ARRAY_SIZE(pdata->ch); i++) {
-		priv->ch[j].lcdc = priv;
-		memcpy(&priv->ch[j].cfg, &pdata->ch[i], sizeof(pdata->ch[i]));
+		struct sh_mobile_lcdc_chan *ch = priv->ch + j;
 
-		error = sh_mobile_lcdc_check_interface(&priv->ch[j]);
+		ch->lcdc = priv;
+		memcpy(&ch->cfg, &pdata->ch[i], sizeof(pdata->ch[i]));
+
+		error = sh_mobile_lcdc_check_interface(ch);
 		if (error) {
 			dev_err(&pdev->dev, "unsupported interface type\n");
 			goto err1;
 		}
-		init_waitqueue_head(&priv->ch[j].frame_end_wait);
-		init_completion(&priv->ch[j].vsync_completion);
-		priv->ch[j].pan_offset = 0;
+		init_waitqueue_head(&ch->frame_end_wait);
+		init_completion(&ch->vsync_completion);
+		ch->pan_offset = 0;
 
 		switch (pdata->ch[i].chan) {
 		case LCDC_CHAN_MAINLCD:
-			priv->ch[j].enabled = 1 << 1;
-			priv->ch[j].reg_offs = lcdc_offs_mainlcd;
+			ch->enabled = 1 << 1;
+			ch->reg_offs = lcdc_offs_mainlcd;
 			j++;
 			break;
 		case LCDC_CHAN_SUBLCD:
-			priv->ch[j].enabled = 1 << 2;
-			priv->ch[j].reg_offs = lcdc_offs_sublcd;
+			ch->enabled = 1 << 2;
+			ch->reg_offs = lcdc_offs_sublcd;
 			j++;
 			break;
 		}
@@ -1102,17 +1101,19 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < j; i++) {
 		struct fb_var_screeninfo *var;
-		struct fb_videomode *lcd_cfg;
-		cfg = &priv->ch[i].cfg;
+		const struct fb_videomode *lcd_cfg;
+		struct sh_mobile_lcdc_chan *ch = priv->ch + i;
+
+		cfg = &ch->cfg;
 
-		priv->ch[i].info = framebuffer_alloc(0, &pdev->dev);
-		if (!priv->ch[i].info) {
+		ch->info = framebuffer_alloc(0, &pdev->dev);
+		if (!ch->info) {
 			dev_err(&pdev->dev, "unable to allocate fb_info\n");
 			error = -ENOMEM;
 			break;
 		}
 
-		info = priv->ch[i].info;
+		info = ch->info;
 		var = &info->var;
 		lcd_cfg = &cfg->lcd_cfg;
 		info->fbops = &sh_mobile_lcdc_ops;
@@ -1130,28 +1131,28 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			var->yres_virtual;
 
 		buf = dma_alloc_coherent(&pdev->dev, info->fix.smem_len,
-					 &priv->ch[i].dma_handle, GFP_KERNEL);
+					 &ch->dma_handle, GFP_KERNEL);
 		if (!buf) {
 			dev_err(&pdev->dev, "unable to allocate buffer\n");
 			error = -ENOMEM;
 			break;
 		}
 
-		info->pseudo_palette = &priv->ch[i].pseudo_palette;
+		info->pseudo_palette = &ch->pseudo_palette;
 		info->flags = FBINFO_FLAG_DEFAULT;
 
 		error = fb_alloc_cmap(&info->cmap, PALETTE_NR, 0);
 		if (error < 0) {
 			dev_err(&pdev->dev, "unable to allocate cmap\n");
 			dma_free_coherent(&pdev->dev, info->fix.smem_len,
-					  buf, priv->ch[i].dma_handle);
+					  buf, ch->dma_handle);
 			break;
 		}
 
-		info->fix.smem_start = priv->ch[i].dma_handle;
+		info->fix.smem_start = ch->dma_handle;
 		info->screen_base = buf;
 		info->device = &pdev->dev;
-		info->par = &priv->ch[i];
+		info->par = ch;
 	}
 
 	if (error)
-- 
1.7.1

