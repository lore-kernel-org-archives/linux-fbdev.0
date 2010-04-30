From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 30 Apr 2010 16:07:00 +0000
Subject: [PATCH 1/2] sh: fix a number of Oopses and leaks in SH framebuffer
Message-Id: <Pine.LNX.4.64.1004301802370.4055@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix a number of Oopses, memory leaks and unbalanced calls on error paths in
sh_mobile_lcdcfb.c.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Patches are not really related, but the second one applies on top of this 
one.

 drivers/video/sh_mobile_lcdcfb.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index bbd1dbf..e498fb5 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -694,6 +694,7 @@ static int sh_mobile_lcdc_setup_clocks(struct platform_device *pdev,
 	 * 1) Enable Runtime PM
 	 * 2) Force Runtime PM Resume since hardware is accessed from probe()
 	 */
+	priv->dev = &pdev->dev;
 	pm_runtime_enable(priv->dev);
 	pm_runtime_resume(priv->dev);
 	return 0;
@@ -956,25 +957,24 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 	if (!pdev->dev.platform_data) {
 		dev_err(&pdev->dev, "no platform data defined\n");
-		error = -EINVAL;
-		goto err0;
+		return -EINVAL;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i = platform_get_irq(pdev, 0);
 	if (!res || i < 0) {
 		dev_err(&pdev->dev, "cannot get platform resources\n");
-		error = -ENOENT;
-		goto err0;
+		return -ENOENT;
 	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		dev_err(&pdev->dev, "cannot allocate device data\n");
-		error = -ENOMEM;
-		goto err0;
+		return -ENOMEM;
 	}
 
+	platform_set_drvdata(pdev, priv);
+
 	error = request_irq(i, sh_mobile_lcdc_irq, IRQF_DISABLED,
 			    dev_name(&pdev->dev), priv);
 	if (error) {
@@ -983,8 +983,6 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 	}
 
 	priv->irq = i;
-	priv->dev = &pdev->dev;
-	platform_set_drvdata(pdev, priv);
 	pdata = pdev->dev.platform_data;
 
 	j = 0;
@@ -1098,9 +1096,9 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		info = ch->info;
 
 		if (info->fbdefio) {
-			priv->ch->sglist = vmalloc(sizeof(struct scatterlist) *
+			ch->sglist = vmalloc(sizeof(struct scatterlist) *
 					info->fix.smem_len >> PAGE_SHIFT);
-			if (!priv->ch->sglist) {
+			if (!ch->sglist) {
 				dev_err(&pdev->dev, "cannot allocate sglist\n");
 				goto err1;
 			}
@@ -1125,9 +1123,9 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 	}
 
 	return 0;
- err1:
+err1:
 	sh_mobile_lcdc_remove(pdev);
- err0:
+
 	return error;
 }
 
@@ -1138,7 +1136,7 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(priv->ch); i++)
-		if (priv->ch[i].info->dev)
+		if (priv->ch[i].info && priv->ch[i].info->dev)
 			unregister_framebuffer(priv->ch[i].info);
 
 	sh_mobile_lcdc_stop(priv);
@@ -1161,7 +1159,8 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 	if (priv->dot_clk)
 		clk_put(priv->dot_clk);
 
-	pm_runtime_disable(priv->dev);
+	if (priv->dev)
+		pm_runtime_disable(priv->dev);
 
 	if (priv->base)
 		iounmap(priv->base);
-- 
1.6.2.4

