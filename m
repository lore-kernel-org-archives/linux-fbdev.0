From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:01:58 +0000
Subject: [PATCH 03/57] fbdev: sh_mobile_lcdc: Move pm runtime enable to probe()
Message-Id: <1323784972-24205-4-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The pm_runtime_enable() and pm_runtime_resume() calls don't belong to
sh_mobile_lcdc_setup_clocks(). Move them to the probe function. Remove
the unneeded pm_runtime_resume() call.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index a6bf4fb..7ceeed4 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -191,6 +191,7 @@ static int sh_mobile_lcdc_setup_clocks(struct platform_device *pdev,
 				       int clock_source,
 				       struct sh_mobile_lcdc_priv *priv)
 {
+	struct clk *clk;
 	char *str;
 
 	switch (clock_source) {
@@ -210,21 +211,16 @@ static int sh_mobile_lcdc_setup_clocks(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	if (str) {
-		priv->dot_clk = clk_get(&pdev->dev, str);
-		if (IS_ERR(priv->dot_clk)) {
-			dev_err(&pdev->dev, "cannot get dot clock %s\n", str);
-			return PTR_ERR(priv->dot_clk);
-		}
+	if (str = NULL)
+		return 0;
+
+	clk = clk_get(&pdev->dev, str);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "cannot get dot clock %s\n", str);
+		return PTR_ERR(clk);
 	}
 
-	/* Runtime PM support involves two step for this driver:
-	 * 1) Enable Runtime PM
-	 * 2) Force Runtime PM Resume since hardware is accessed from probe()
-	 */
-	priv->dev = &pdev->dev;
-	pm_runtime_enable(priv->dev);
-	pm_runtime_resume(priv->dev);
+	priv->dot_clk = clk;
 	return 0;
 }
 
@@ -1513,11 +1509,10 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 			sh_mobile_lcdc_bl_remove(priv->ch[i].bl);
 	}
 
-	if (priv->dot_clk)
+	if (priv->dot_clk) {
+		pm_runtime_disable(&pdev->dev);
 		clk_put(priv->dot_clk);
-
-	if (priv->dev)
-		pm_runtime_disable(priv->dev);
+	}
 
 	if (priv->base)
 		iounmap(priv->base);
@@ -1740,6 +1735,8 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	priv->dev = &pdev->dev;
+	priv->meram_dev = pdata->meram_dev;
 	platform_set_drvdata(pdev, priv);
 
 	error = request_irq(i, sh_mobile_lcdc_irq, 0,
@@ -1805,7 +1802,8 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	priv->meram_dev = pdata->meram_dev;
+	/* Enable runtime PM. */
+	pm_runtime_enable(&pdev->dev);
 
 	for (i = 0; i < num_channels; i++) {
 		struct sh_mobile_lcdc_chan *ch = priv->ch + i;
-- 
1.7.3.4

