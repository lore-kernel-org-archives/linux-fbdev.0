From: Daniel Mack <zonque@gmail.com>
Date: Wed, 05 Mar 2014 16:12:49 +0000
Subject: [PATCH 4/4] video: pxa3xx-gcu: switch to devres functions
Message-Id: <1394035969-32420-5-git-send-email-zonque@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Switch to devres allocators to clean up the error unwinding paths.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/video/pxa3xx-gcu.c | 113 ++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 74 deletions(-)

diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
index 73c29ec..417f9a2 100644
--- a/drivers/video/pxa3xx-gcu.c
+++ b/drivers/video/pxa3xx-gcu.c
@@ -593,18 +593,10 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 	struct pxa3xx_gcu_priv *priv;
 	struct device *dev = &pdev->dev;
 
-	priv = kzalloc(sizeof(struct pxa3xx_gcu_priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(struct pxa3xx_gcu_priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	for (i = 0; i < 8; i++) {
-		ret = pxa3xx_gcu_add_buffer(dev, priv);
-		if (ret) {
-			dev_err(dev, "failed to allocate DMA memory\n");
-			goto err_free_priv;
-		}
-	}
-
 	init_waitqueue_head(&priv->wait_idle);
 	init_waitqueue_head(&priv->wait_free);
 	spin_lock_init(&priv->spinlock);
@@ -618,73 +610,63 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 	priv->misc_dev.name	= DRV_NAME,
 	priv->misc_dev.fops	= &pxa3xx_gcu_miscdev_fops;
 
-	/* register misc device */
-	ret = misc_register(&priv->misc_dev);
-	if (ret < 0) {
-		dev_err(dev, "misc_register() for minor %d failed\n",
-			MISCDEV_MINOR);
-		goto err_free_priv;
-	}
-
 	/* handle IO resources */
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (r = NULL) {
-		dev_err(dev, "no I/O memory resource defined\n");
-		ret = -ENODEV;
-		goto err_misc_deregister;
+	priv->mmio_base = devm_request_and_ioremap(dev, r);
+	if (IS_ERR(priv->mmio_base)) {
+		dev_err(dev, "failed to map I/O memory\n");
+		return PTR_ERR(priv->mmio_base);
 	}
 
-	if (!request_mem_region(r->start, resource_size(r), pdev->name)) {
-		dev_err(dev, "failed to request I/O memory\n");
-		ret = -EBUSY;
-		goto err_misc_deregister;
+	/* enable the clock */
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "failed to get clock\n");
+		return PTR_ERR(priv->clk);
 	}
 
-	priv->mmio_base = ioremap_nocache(r->start, resource_size(r));
-	if (!priv->mmio_base) {
-		dev_err(dev, "failed to map I/O memory\n");
-		ret = -EBUSY;
-		goto err_free_mem_region;
+	/* request the IRQ */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "no IRQ defined\n");
+		return -ENODEV;
+	}
+
+	ret = devm_request_irq(dev, irq, pxa3xx_gcu_handle_irq,
+			       0, DRV_NAME, priv);
+	if (ret < 0) {
+		dev_err(dev, "request_irq failed\n");
+		return ret;
 	}
 
 	/* allocate dma memory */
 	priv->shared = dma_alloc_coherent(dev, SHARED_SIZE,
 					  &priv->shared_phys, GFP_KERNEL);
-
 	if (!priv->shared) {
 		dev_err(dev, "failed to allocate DMA memory\n");
-		ret = -ENOMEM;
-		goto err_free_io;
+		return -ENOMEM;
 	}
 
-	/* enable the clock */
-	priv->clk = clk_get(dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		dev_err(dev, "failed to get clock\n");
-		ret = -ENODEV;
+	/* register misc device */
+	ret = misc_register(&priv->misc_dev);
+	if (ret < 0) {
+		dev_err(dev, "misc_register() for minor %d failed\n",
+			MISCDEV_MINOR);
 		goto err_free_dma;
 	}
 
 	ret = clk_enable(priv->clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable clock\n");
-		goto err_put_clk;
-	}
-
-	/* request the IRQ */
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no IRQ defined\n");
-		ret = -ENODEV;
-		goto err_put_clk;
+		goto err_misc_deregister;
 	}
 
-	ret = request_irq(irq, pxa3xx_gcu_handle_irq,
-			  0, DRV_NAME, priv);
-	if (ret) {
-		dev_err(dev, "request_irq failed\n");
-		ret = -EBUSY;
-		goto err_put_clk;
+	for (i = 0; i < 8; i++) {
+		ret = pxa3xx_gcu_add_buffer(dev, priv);
+		if (ret) {
+			dev_err(dev, "failed to allocate DMA memory\n");
+			goto err_disable_clk;
+		}
 	}
 
 	platform_set_drvdata(pdev, priv);
@@ -697,45 +679,28 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 			SHARED_SIZE, irq);
 	return 0;
 
-err_put_clk:
-	clk_disable(priv->clk);
-	clk_put(priv->clk);
-
 err_free_dma:
 	dma_free_coherent(dev, SHARED_SIZE,
 			priv->shared, priv->shared_phys);
 
-err_free_io:
-	iounmap(priv->mmio_base);
-
-err_free_mem_region:
-	release_mem_region(r->start, resource_size(r));
-
 err_misc_deregister:
 	misc_deregister(&priv->misc_dev);
 
-err_free_priv:
-	pxa3xx_gcu_free_buffers(dev, priv);
-	kfree(priv);
+err_disable_clk:
+	clk_disable(priv->clk);
+
 	return ret;
 }
 
 static int pxa3xx_gcu_remove(struct platform_device *pdev)
 {
 	struct pxa3xx_gcu_priv *priv = platform_get_drvdata(pdev);
-	struct resource *r = priv->resource_mem;
 	struct device *dev = &pdev->dev;
 
 	pxa3xx_gcu_wait_idle(priv);
-
 	misc_deregister(&priv->misc_dev);
-	dma_free_coherent(dev, SHARED_SIZE,
-			  priv->shared, priv->shared_phys);
-	iounmap(priv->mmio_base);
-	release_mem_region(r->start, resource_size(r));
-	clk_disable(priv->clk);
+	dma_free_coherent(dev, SHARED_SIZE, priv->shared, priv->shared_phys);
 	pxa3xx_gcu_free_buffers(dev, priv);
-	kfree(priv);
 
 	return 0;
 }
-- 
1.8.5.3

