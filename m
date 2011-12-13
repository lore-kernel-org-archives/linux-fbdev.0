From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:01:59 +0000
Subject: [PATCH 04/57] fbdev: sh_mobile_lcdc: Don't pass struct device around
Message-Id: <1323784972-24205-5-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Pass a pointer to a struct sh_mobile_lcdc_priv instead, which stores a
pointer to the device.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   41 +++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 7ceeed4..8b78487 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -187,9 +187,8 @@ static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
 	}
 }
 
-static int sh_mobile_lcdc_setup_clocks(struct platform_device *pdev,
-				       int clock_source,
-				       struct sh_mobile_lcdc_priv *priv)
+static int sh_mobile_lcdc_setup_clocks(struct sh_mobile_lcdc_priv *priv,
+				       int clock_source)
 {
 	struct clk *clk;
 	char *str;
@@ -214,9 +213,9 @@ static int sh_mobile_lcdc_setup_clocks(struct platform_device *pdev,
 	if (str = NULL)
 		return 0;
 
-	clk = clk_get(&pdev->dev, str);
+	clk = clk_get(priv->dev, str);
 	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "cannot get dot clock %s\n", str);
+		dev_err(priv->dev, "cannot get dot clock %s\n", str);
 		return PTR_ERR(clk);
 	}
 
@@ -1564,8 +1563,9 @@ sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *ch)
 	return 0;
 }
 
-static int __devinit sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch,
-						 struct device *dev)
+static int __devinit
+sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
+			    struct sh_mobile_lcdc_chan *ch)
 {
 	struct sh_mobile_lcdc_chan_cfg *cfg = &ch->cfg;
 	const struct fb_videomode *max_mode;
@@ -1581,9 +1581,9 @@ static int __devinit sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch,
 	mutex_init(&ch->open_lock);
 
 	/* Allocate the frame buffer device. */
-	ch->info = framebuffer_alloc(0, dev);
+	ch->info = framebuffer_alloc(0, priv->dev);
 	if (!ch->info) {
-		dev_err(dev, "unable to allocate fb_info\n");
+		dev_err(priv->dev, "unable to allocate fb_info\n");
 		return -ENOMEM;
 	}
 
@@ -1605,8 +1605,8 @@ static int __devinit sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch,
 		/* NV12/NV21 buffers must have even number of lines */
 		if ((cfg->fourcc = V4L2_PIX_FMT_NV12 ||
 		     cfg->fourcc = V4L2_PIX_FMT_NV21) && (mode->yres & 0x1)) {
-			dev_err(dev, "yres must be multiple of 2 for YCbCr420 "
-				"mode.\n");
+			dev_err(priv->dev, "yres must be multiple of 2 for "
+				"YCbCr420 mode.\n");
 			return -EINVAL;
 		}
 
@@ -1619,7 +1619,7 @@ static int __devinit sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch,
 	if (!max_size)
 		max_size = MAX_XRES * MAX_YRES;
 	else
-		dev_dbg(dev, "Found largest videomode %ux%u\n",
+		dev_dbg(priv->dev, "Found largest videomode %ux%u\n",
 			max_mode->xres, max_mode->yres);
 
 	/* Create the mode list. */
@@ -1670,16 +1670,17 @@ static int __devinit sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch,
 	max_size = max_size * var->bits_per_pixel / 8 * 2;
 
 	/* Allocate frame buffer memory and color map. */
-	buf = dma_alloc_coherent(dev, max_size, &ch->dma_handle, GFP_KERNEL);
+	buf = dma_alloc_coherent(priv->dev, max_size, &ch->dma_handle,
+				 GFP_KERNEL);
 	if (!buf) {
-		dev_err(dev, "unable to allocate buffer\n");
+		dev_err(priv->dev, "unable to allocate buffer\n");
 		return -ENOMEM;
 	}
 
 	ret = fb_alloc_cmap(&info->cmap, PALETTE_NR, 0);
 	if (ret < 0) {
-		dev_err(dev, "unable to allocate cmap\n");
-		dma_free_coherent(dev, max_size, buf, ch->dma_handle);
+		dev_err(priv->dev, "unable to allocate cmap\n");
+		dma_free_coherent(priv->dev, max_size, buf, ch->dma_handle);
 		return ret;
 	}
 
@@ -1702,7 +1703,7 @@ static int __devinit sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch,
 	}
 
 	info->screen_base = buf;
-	info->device = dev;
+	info->device = priv->dev;
 	ch->display_var = *var;
 
 	return 0;
@@ -1796,7 +1797,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 	if (!priv->base)
 		goto err1;
 
-	error = sh_mobile_lcdc_setup_clocks(pdev, pdata->clock_source, priv);
+	error = sh_mobile_lcdc_setup_clocks(priv, pdata->clock_source);
 	if (error) {
 		dev_err(&pdev->dev, "unable to setup clocks\n");
 		goto err1;
@@ -1808,7 +1809,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 	for (i = 0; i < num_channels; i++) {
 		struct sh_mobile_lcdc_chan *ch = priv->ch + i;
 
-		error = sh_mobile_lcdc_channel_init(ch, &pdev->dev);
+		error = sh_mobile_lcdc_channel_init(priv, ch);
 		if (error)
 			goto err1;
 	}
@@ -1838,7 +1839,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		if (error < 0)
 			goto err1;
 
-		dev_info(info->dev, "registered %s/%s as %dx%d %dbpp.\n",
+		dev_info(&pdev->dev, "registered %s/%s as %dx%d %dbpp.\n",
 			 pdev->name, (ch->cfg.chan = LCDC_CHAN_MAINLCD) ?
 			 "mainlcd" : "sublcd", info->var.xres, info->var.yres,
 			 info->var.bits_per_pixel);
-- 
1.7.3.4

