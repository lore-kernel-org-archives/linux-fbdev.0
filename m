From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:38 +0000
Subject: [PATCH 03/19] fbdev: sh_mobile_lcdc: Remove priv argument from channel and overlay init
Message-Id: <1345122054-16013-4-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The channel and overlay init functions operate on a channel and an
overlay, don't pass the priv parameter explicitly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 82b53f7..c169581 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -2536,10 +2536,10 @@ static int __devinit sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *
 }
 
 static int __devinit
-sh_mobile_lcdc_overlay_init(struct sh_mobile_lcdc_priv *priv,
-			  struct sh_mobile_lcdc_overlay *ovl)
+sh_mobile_lcdc_overlay_init(struct sh_mobile_lcdc_overlay *ovl)
 {
 	const struct sh_mobile_lcdc_format_info *format;
+	struct device *dev = ovl->channel->lcdc->dev;
 	int ret;
 
 	if (ovl->cfg->fourcc = 0)
@@ -2548,7 +2548,7 @@ sh_mobile_lcdc_overlay_init(struct sh_mobile_lcdc_priv *priv,
 	/* Validate the format. */
 	format = sh_mobile_format_info(ovl->cfg->fourcc);
 	if (format = NULL) {
-		dev_err(priv->dev, "Invalid FOURCC %08x\n", ovl->cfg->fourcc);
+		dev_err(dev, "Invalid FOURCC %08x\n", ovl->cfg->fourcc);
 		return -EINVAL;
 	}
 
@@ -2576,10 +2576,10 @@ sh_mobile_lcdc_overlay_init(struct sh_mobile_lcdc_priv *priv,
 	/* Allocate frame buffer memory. */
 	ovl->fb_size = ovl->cfg->max_xres * ovl->cfg->max_yres
 		       * format->bpp / 8 * 2;
-	ovl->fb_mem = dma_alloc_coherent(priv->dev, ovl->fb_size,
-					   &ovl->dma_handle, GFP_KERNEL);
+	ovl->fb_mem = dma_alloc_coherent(dev, ovl->fb_size, &ovl->dma_handle,
+					 GFP_KERNEL);
 	if (!ovl->fb_mem) {
-		dev_err(priv->dev, "unable to allocate buffer\n");
+		dev_err(dev, "unable to allocate buffer\n");
 		return -ENOMEM;
 	}
 
@@ -2591,11 +2591,11 @@ sh_mobile_lcdc_overlay_init(struct sh_mobile_lcdc_priv *priv,
 }
 
 static int __devinit
-sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
-			    struct sh_mobile_lcdc_chan *ch)
+sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch)
 {
 	const struct sh_mobile_lcdc_format_info *format;
 	const struct sh_mobile_lcdc_chan_cfg *cfg = ch->cfg;
+	struct device *dev = ch->lcdc->dev;
 	const struct fb_videomode *max_mode;
 	const struct fb_videomode *mode;
 	unsigned int num_modes;
@@ -2608,7 +2608,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	/* Validate the format. */
 	format = sh_mobile_format_info(cfg->fourcc);
 	if (format = NULL) {
-		dev_err(priv->dev, "Invalid FOURCC %08x.\n", cfg->fourcc);
+		dev_err(dev, "Invalid FOURCC %08x.\n", cfg->fourcc);
 		return -EINVAL;
 	}
 
@@ -2624,7 +2624,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 		/* NV12/NV21 buffers must have even number of lines */
 		if ((cfg->fourcc = V4L2_PIX_FMT_NV12 ||
 		     cfg->fourcc = V4L2_PIX_FMT_NV21) && (mode->yres & 0x1)) {
-			dev_err(priv->dev, "yres must be multiple of 2 for "
+			dev_err(dev, "yres must be multiple of 2 for "
 				"YCbCr420 mode.\n");
 			return -EINVAL;
 		}
@@ -2638,7 +2638,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	if (!max_size)
 		max_size = MAX_XRES * MAX_YRES;
 	else
-		dev_dbg(priv->dev, "Found largest videomode %ux%u\n",
+		dev_dbg(dev, "Found largest videomode %ux%u\n",
 			max_mode->xres, max_mode->yres);
 
 	if (cfg->lcd_modes = NULL) {
@@ -2672,10 +2672,10 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 
 	/* Allocate frame buffer memory. */
 	ch->fb_size = max_size * format->bpp / 8 * 2;
-	ch->fb_mem = dma_alloc_coherent(priv->dev, ch->fb_size, &ch->dma_handle,
+	ch->fb_mem = dma_alloc_coherent(dev, ch->fb_size, &ch->dma_handle,
 					GFP_KERNEL);
 	if (ch->fb_mem = NULL) {
-		dev_err(priv->dev, "unable to allocate buffer\n");
+		dev_err(dev, "unable to allocate buffer\n");
 		return -ENOMEM;
 	}
 
@@ -2683,8 +2683,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	if (cfg->tx_dev) {
 		if (!cfg->tx_dev->dev.driver ||
 		    !try_module_get(cfg->tx_dev->dev.driver->owner)) {
-			dev_warn(priv->dev,
-				 "unable to get transmitter device\n");
+			dev_warn(dev, "unable to get transmitter device\n");
 			return -EINVAL;
 		}
 		ch->tx_dev = platform_get_drvdata(cfg->tx_dev);
@@ -2792,9 +2791,9 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	for (i = 0; i < num_channels; i++) {
-		struct sh_mobile_lcdc_chan *ch = priv->ch + i;
+		struct sh_mobile_lcdc_chan *ch = &priv->ch[i];
 
-		error = sh_mobile_lcdc_channel_init(priv, ch);
+		error = sh_mobile_lcdc_channel_init(ch);
 		if (error)
 			goto err1;
 	}
@@ -2805,7 +2804,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		ovl->cfg = &pdata->overlays[i];
 		ovl->channel = &priv->ch[0];
 
-		error = sh_mobile_lcdc_overlay_init(priv, ovl);
+		error = sh_mobile_lcdc_overlay_init(ovl);
 		if (error)
 			goto err1;
 	}
-- 
1.7.8.6

