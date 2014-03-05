From: Daniel Mack <zonque@gmail.com>
Date: Wed, 05 Mar 2014 16:12:47 +0000
Subject: [PATCH 2/4] video: pxa3xx-gcu: pass around struct device *
Message-Id: <1394035969-32420-3-git-send-email-zonque@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Instead of passing around struct platform_device, use struct device.
That saves one level of dereference. Also, call platform devices pdev,
and provide a shortcut for &pdev->dev.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/video/pxa3xx-gcu.c | 56 ++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
index 9cd48ab..f9961ba 100644
--- a/drivers/video/pxa3xx-gcu.c
+++ b/drivers/video/pxa3xx-gcu.c
@@ -528,7 +528,7 @@ static inline void pxa3xx_gcu_init_debug_timer(void) {}
 #endif
 
 static int
-pxa3xx_gcu_add_buffer(struct platform_device *dev,
+pxa3xx_gcu_add_buffer(struct device *dev,
 		      struct pxa3xx_gcu_priv *priv)
 {
 	struct pxa3xx_gcu_batch *buffer;
@@ -537,7 +537,7 @@ pxa3xx_gcu_add_buffer(struct platform_device *dev,
 	if (!buffer)
 		return -ENOMEM;
 
-	buffer->ptr = dma_alloc_coherent(&dev->dev, PXA3XX_GCU_BATCH_WORDS * 4,
+	buffer->ptr = dma_alloc_coherent(dev, PXA3XX_GCU_BATCH_WORDS * 4,
 					 &buffer->phys, GFP_KERNEL);
 	if (!buffer->ptr) {
 		kfree(buffer);
@@ -551,7 +551,7 @@ pxa3xx_gcu_add_buffer(struct platform_device *dev,
 }
 
 static void
-pxa3xx_gcu_free_buffers(struct platform_device *dev,
+pxa3xx_gcu_free_buffers(struct device *dev,
 			struct pxa3xx_gcu_priv *priv)
 {
 	struct pxa3xx_gcu_batch *next, *buffer = priv->free;
@@ -559,7 +559,7 @@ pxa3xx_gcu_free_buffers(struct platform_device *dev,
 	while (buffer) {
 		next = buffer->next;
 
-		dma_free_coherent(&dev->dev, PXA3XX_GCU_BATCH_WORDS * 4,
+		dma_free_coherent(dev, PXA3XX_GCU_BATCH_WORDS * 4,
 				  buffer->ptr, buffer->phys);
 
 		kfree(buffer);
@@ -576,11 +576,12 @@ static const struct file_operations pxa3xx_gcu_miscdev_fops = {
 	.mmap =			pxa3xx_gcu_mmap,
 };
 
-static int pxa3xx_gcu_probe(struct platform_device *dev)
+static int pxa3xx_gcu_probe(struct platform_device *pdev)
 {
 	int i, ret, irq;
 	struct resource *r;
 	struct pxa3xx_gcu_priv *priv;
+	struct device *dev = &pdev->dev;
 
 	priv = kzalloc(sizeof(struct pxa3xx_gcu_priv), GFP_KERNEL);
 	if (!priv)
@@ -589,7 +590,7 @@ static int pxa3xx_gcu_probe(struct platform_device *dev)
 	for (i = 0; i < 8; i++) {
 		ret = pxa3xx_gcu_add_buffer(dev, priv);
 		if (ret) {
-			dev_err(&dev->dev, "failed to allocate DMA memory\n");
+			dev_err(dev, "failed to allocate DMA memory\n");
 			goto err_free_priv;
 		}
 	}
@@ -610,60 +611,60 @@ static int pxa3xx_gcu_probe(struct platform_device *dev)
 	/* register misc device */
 	ret = misc_register(&priv->misc_dev);
 	if (ret < 0) {
-		dev_err(&dev->dev, "misc_register() for minor %d failed\n",
+		dev_err(dev, "misc_register() for minor %d failed\n",
 			MISCDEV_MINOR);
 		goto err_free_priv;
 	}
 
 	/* handle IO resources */
-	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (r = NULL) {
-		dev_err(&dev->dev, "no I/O memory resource defined\n");
+		dev_err(dev, "no I/O memory resource defined\n");
 		ret = -ENODEV;
 		goto err_misc_deregister;
 	}
 
-	if (!request_mem_region(r->start, resource_size(r), dev->name)) {
-		dev_err(&dev->dev, "failed to request I/O memory\n");
+	if (!request_mem_region(r->start, resource_size(r), pdev->name)) {
+		dev_err(dev, "failed to request I/O memory\n");
 		ret = -EBUSY;
 		goto err_misc_deregister;
 	}
 
 	priv->mmio_base = ioremap_nocache(r->start, resource_size(r));
 	if (!priv->mmio_base) {
-		dev_err(&dev->dev, "failed to map I/O memory\n");
+		dev_err(dev, "failed to map I/O memory\n");
 		ret = -EBUSY;
 		goto err_free_mem_region;
 	}
 
 	/* allocate dma memory */
-	priv->shared = dma_alloc_coherent(&dev->dev, SHARED_SIZE,
+	priv->shared = dma_alloc_coherent(dev, SHARED_SIZE,
 					  &priv->shared_phys, GFP_KERNEL);
 
 	if (!priv->shared) {
-		dev_err(&dev->dev, "failed to allocate DMA memory\n");
+		dev_err(dev, "failed to allocate DMA memory\n");
 		ret = -ENOMEM;
 		goto err_free_io;
 	}
 
 	/* enable the clock */
-	priv->clk = clk_get(&dev->dev, NULL);
+	priv->clk = clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
-		dev_err(&dev->dev, "failed to get clock\n");
+		dev_err(dev, "failed to get clock\n");
 		ret = -ENODEV;
 		goto err_free_dma;
 	}
 
 	ret = clk_enable(priv->clk);
 	if (ret < 0) {
-		dev_err(&dev->dev, "failed to enable clock\n");
+		dev_err(dev, "failed to enable clock\n");
 		goto err_put_clk;
 	}
 
 	/* request the IRQ */
-	irq = platform_get_irq(dev, 0);
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&dev->dev, "no IRQ defined\n");
+		dev_err(dev, "no IRQ defined\n");
 		ret = -ENODEV;
 		goto err_put_clk;
 	}
@@ -671,17 +672,17 @@ static int pxa3xx_gcu_probe(struct platform_device *dev)
 	ret = request_irq(irq, pxa3xx_gcu_handle_irq,
 			  0, DRV_NAME, priv);
 	if (ret) {
-		dev_err(&dev->dev, "request_irq failed\n");
+		dev_err(dev, "request_irq failed\n");
 		ret = -EBUSY;
 		goto err_put_clk;
 	}
 
-	platform_set_drvdata(dev, priv);
+	platform_set_drvdata(pdev, priv);
 	priv->resource_mem = r;
 	pxa3xx_gcu_reset(priv);
 	pxa3xx_gcu_init_debug_timer();
 
-	dev_info(&dev->dev, "registered @0x%p, DMA 0x%p (%d bytes), IRQ %d\n",
+	dev_info(dev, "registered @0x%p, DMA 0x%p (%d bytes), IRQ %d\n",
 			(void *) r->start, (void *) priv->shared_phys,
 			SHARED_SIZE, irq);
 	return 0;
@@ -691,7 +692,7 @@ err_put_clk:
 	clk_put(priv->clk);
 
 err_free_dma:
-	dma_free_coherent(&dev->dev, SHARED_SIZE,
+	dma_free_coherent(dev, SHARED_SIZE,
 			priv->shared, priv->shared_phys);
 
 err_free_io:
@@ -709,16 +710,17 @@ err_free_priv:
 	return ret;
 }
 
-static int pxa3xx_gcu_remove(struct platform_device *dev)
+static int pxa3xx_gcu_remove(struct platform_device *pdev)
 {
-	struct pxa3xx_gcu_priv *priv = platform_get_drvdata(dev);
+	struct pxa3xx_gcu_priv *priv = platform_get_drvdata(pdev);
 	struct resource *r = priv->resource_mem;
+	struct device *dev = &pdev->dev;
 
 	pxa3xx_gcu_wait_idle(priv);
 
 	misc_deregister(&priv->misc_dev);
-	dma_free_coherent(&dev->dev, SHARED_SIZE,
-			priv->shared, priv->shared_phys);
+	dma_free_coherent(dev, SHARED_SIZE,
+			  priv->shared, priv->shared_phys);
 	iounmap(priv->mmio_base);
 	release_mem_region(r->start, resource_size(r));
 	clk_disable(priv->clk);
-- 
1.8.5.3

