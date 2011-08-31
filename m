From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 31 Aug 2011 11:00:57 +0000
Subject: [PATCH v2 6/8] fbdev: sh_mobile_lcdc: Avoid forward declarations
Message-Id: <1314788459-31791-7-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Reorder probe/remove functions to avoid forward declarations.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |  102 ++++++++++++++++++-------------------
 1 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index b6da1d6..366315b 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1434,7 +1434,56 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static int sh_mobile_lcdc_remove(struct platform_device *pdev);
+static int sh_mobile_lcdc_remove(struct platform_device *pdev)
+{
+	struct sh_mobile_lcdc_priv *priv = platform_get_drvdata(pdev);
+	struct fb_info *info;
+	int i;
+
+	fb_unregister_client(&priv->notifier);
+
+	for (i = 0; i < ARRAY_SIZE(priv->ch); i++)
+		if (priv->ch[i].info && priv->ch[i].info->dev)
+			unregister_framebuffer(priv->ch[i].info);
+
+	sh_mobile_lcdc_stop(priv);
+
+	for (i = 0; i < ARRAY_SIZE(priv->ch); i++) {
+		info = priv->ch[i].info;
+
+		if (!info || !info->device)
+			continue;
+
+		if (priv->ch[i].sglist)
+			vfree(priv->ch[i].sglist);
+
+		if (info->screen_base)
+			dma_free_coherent(&pdev->dev, info->fix.smem_len,
+					  info->screen_base,
+					  priv->ch[i].dma_handle);
+		fb_dealloc_cmap(&info->cmap);
+		framebuffer_release(info);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(priv->ch); i++) {
+		if (priv->ch[i].bl)
+			sh_mobile_lcdc_bl_remove(priv->ch[i].bl);
+	}
+
+	if (priv->dot_clk)
+		clk_put(priv->dot_clk);
+
+	if (priv->dev)
+		pm_runtime_disable(priv->dev);
+
+	if (priv->base)
+		iounmap(priv->base);
+
+	if (priv->irq)
+		free_irq(priv->irq, priv);
+	kfree(priv);
+	return 0;
+}
 
 static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 {
@@ -1691,57 +1740,6 @@ err1:
 	return error;
 }
 
-static int sh_mobile_lcdc_remove(struct platform_device *pdev)
-{
-	struct sh_mobile_lcdc_priv *priv = platform_get_drvdata(pdev);
-	struct fb_info *info;
-	int i;
-
-	fb_unregister_client(&priv->notifier);
-
-	for (i = 0; i < ARRAY_SIZE(priv->ch); i++)
-		if (priv->ch[i].info && priv->ch[i].info->dev)
-			unregister_framebuffer(priv->ch[i].info);
-
-	sh_mobile_lcdc_stop(priv);
-
-	for (i = 0; i < ARRAY_SIZE(priv->ch); i++) {
-		info = priv->ch[i].info;
-
-		if (!info || !info->device)
-			continue;
-
-		if (priv->ch[i].sglist)
-			vfree(priv->ch[i].sglist);
-
-		if (info->screen_base)
-			dma_free_coherent(&pdev->dev, info->fix.smem_len,
-					  info->screen_base,
-					  priv->ch[i].dma_handle);
-		fb_dealloc_cmap(&info->cmap);
-		framebuffer_release(info);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(priv->ch); i++) {
-		if (priv->ch[i].bl)
-			sh_mobile_lcdc_bl_remove(priv->ch[i].bl);
-	}
-
-	if (priv->dot_clk)
-		clk_put(priv->dot_clk);
-
-	if (priv->dev)
-		pm_runtime_disable(priv->dev);
-
-	if (priv->base)
-		iounmap(priv->base);
-
-	if (priv->irq)
-		free_irq(priv->irq, priv);
-	kfree(priv);
-	return 0;
-}
-
 static struct platform_driver sh_mobile_lcdc_driver = {
 	.driver		= {
 		.name		= "sh_mobile_lcdc_fb",
-- 
1.7.3.4

