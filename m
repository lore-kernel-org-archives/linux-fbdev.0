From: Daniel Mack <daniel@zonque.org>
Date: Sun, 24 Jun 2018 15:38:15 +0000
Subject: [PATCH 2/4] video: fbdev: pxafb: switch to devm_* API
Message-Id: <20180624153817.24387-2-daniel@zonque.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This helps us clean up the probe() and remove() implementations.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/video/fbdev/pxafb.c | 64 ++++++++++---------------------------
 1 file changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index dfe382e68287..6f3a93b3097c 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -1799,19 +1799,17 @@ static struct pxafb_info *pxafb_init_fbinfo(struct device *dev,
 	void *addr;
 
 	/* Alloc the pxafb_info and pseudo_palette in one step */
-	fbi = kmalloc(sizeof(struct pxafb_info) + sizeof(u32) * 16, GFP_KERNEL);
+	fbi = devm_kzalloc(dev, sizeof(struct pxafb_info) + sizeof(u32) * 16,
+			   GFP_KERNEL);
 	if (!fbi)
 		return NULL;
 
-	memset(fbi, 0, sizeof(struct pxafb_info));
 	fbi->dev = dev;
 	fbi->inf = inf;
 
-	fbi->clk = clk_get(dev, NULL);
-	if (IS_ERR(fbi->clk)) {
-		kfree(fbi);
+	fbi->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(fbi->clk))
 		return NULL;
-	}
 
 	strcpy(fbi->fb.fix.id, PXA_NAME);
 
@@ -2128,8 +2126,9 @@ static int of_get_pxafb_display(struct device *dev, struct device_node *disp,
 		return -EINVAL;
 
 	ret = -ENOMEM;
-	info->modes = kcalloc(timings->num_timings, sizeof(info->modes[0]),
-			      GFP_KERNEL);
+	info->modes = devm_kcalloc(dev, timings->num_timings,
+				   sizeof(info->modes[0]),
+				   GFP_KERNEL);
 	if (!info->modes)
 		goto out;
 	info->num_modes = timings->num_timings;
@@ -2305,21 +2304,14 @@ static int pxafb_probe(struct platform_device *dev)
 	if (r = NULL) {
 		dev_err(&dev->dev, "no I/O memory resource defined\n");
 		ret = -ENODEV;
-		goto failed_fbi;
-	}
-
-	r = request_mem_region(r->start, resource_size(r), dev->name);
-	if (r = NULL) {
-		dev_err(&dev->dev, "failed to request I/O memory\n");
-		ret = -EBUSY;
-		goto failed_fbi;
+		goto failed;
 	}
 
-	fbi->mmio_base = ioremap(r->start, resource_size(r));
-	if (fbi->mmio_base = NULL) {
-		dev_err(&dev->dev, "failed to map I/O memory\n");
+	fbi->mmio_base = devm_ioremap_resource(&dev->dev, r);
+	if (IS_ERR(fbi->mmio_base)) {
+		dev_err(&dev->dev, "failed to get I/O memory\n");
 		ret = -EBUSY;
-		goto failed_free_res;
+		goto failed;
 	}
 
 	fbi->dma_buff_size = PAGE_ALIGN(sizeof(struct pxafb_dma_buff));
@@ -2328,7 +2320,7 @@ static int pxafb_probe(struct platform_device *dev)
 	if (fbi->dma_buff = NULL) {
 		dev_err(&dev->dev, "failed to allocate memory for DMA\n");
 		ret = -ENOMEM;
-		goto failed_free_io;
+		goto failed;
 	}
 
 	ret = pxafb_init_video_memory(fbi);
@@ -2345,7 +2337,7 @@ static int pxafb_probe(struct platform_device *dev)
 		goto failed_free_mem;
 	}
 
-	ret = request_irq(irq, pxafb_handle_irq, 0, "LCD", fbi);
+	ret = devm_request_irq(&dev->dev, irq, pxafb_handle_irq, 0, "LCD", fbi);
 	if (ret) {
 		dev_err(&dev->dev, "request_irq failed: %d\n", ret);
 		ret = -EBUSY;
@@ -2355,7 +2347,7 @@ static int pxafb_probe(struct platform_device *dev)
 	ret = pxafb_smart_init(fbi);
 	if (ret) {
 		dev_err(&dev->dev, "failed to initialize smartpanel\n");
-		goto failed_free_irq;
+		goto failed_free_mem;
 	}
 
 	/*
@@ -2365,13 +2357,13 @@ static int pxafb_probe(struct platform_device *dev)
 	ret = pxafb_check_var(&fbi->fb.var, &fbi->fb);
 	if (ret) {
 		dev_err(&dev->dev, "failed to get suitable mode\n");
-		goto failed_free_irq;
+		goto failed_free_mem;
 	}
 
 	ret = pxafb_set_par(&fbi->fb);
 	if (ret) {
 		dev_err(&dev->dev, "Failed to set parameters\n");
-		goto failed_free_irq;
+		goto failed_free_mem;
 	}
 
 	platform_set_drvdata(dev, fbi);
@@ -2404,20 +2396,11 @@ static int pxafb_probe(struct platform_device *dev)
 failed_free_cmap:
 	if (fbi->fb.cmap.len)
 		fb_dealloc_cmap(&fbi->fb.cmap);
-failed_free_irq:
-	free_irq(irq, fbi);
 failed_free_mem:
 	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
 failed_free_dma:
 	dma_free_coherent(&dev->dev, fbi->dma_buff_size,
 			fbi->dma_buff, fbi->dma_buff_phys);
-failed_free_io:
-	iounmap(fbi->mmio_base);
-failed_free_res:
-	release_mem_region(r->start, resource_size(r));
-failed_fbi:
-	clk_put(fbi->clk);
-	kfree(fbi);
 failed:
 	return ret;
 }
@@ -2425,8 +2408,6 @@ static int pxafb_probe(struct platform_device *dev)
 static int pxafb_remove(struct platform_device *dev)
 {
 	struct pxafb_info *fbi = platform_get_drvdata(dev);
-	struct resource *r;
-	int irq;
 	struct fb_info *info;
 
 	if (!fbi)
@@ -2442,22 +2423,11 @@ static int pxafb_remove(struct platform_device *dev)
 	if (fbi->fb.cmap.len)
 		fb_dealloc_cmap(&fbi->fb.cmap);
 
-	irq = platform_get_irq(dev, 0);
-	free_irq(irq, fbi);
-
 	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
 
 	dma_free_wc(&dev->dev, fbi->dma_buff_size, fbi->dma_buff,
 		    fbi->dma_buff_phys);
 
-	iounmap(fbi->mmio_base);
-
-	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	release_mem_region(r->start, resource_size(r));
-
-	clk_put(fbi->clk);
-	kfree(fbi);
-
 	return 0;
 }
 
-- 
2.17.1

