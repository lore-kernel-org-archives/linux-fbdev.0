From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Fri, 20 Feb 2015 17:51:28 +0000
Subject: [PATCH] fbdev: goldfishfb: use devres api
Message-Id: <1424454688-2509-1-git-send-email-prabhakar.csengg@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch does the following:
a> uses devm_kzalloc() instead of kzalloc and cleanup the error path
b> uses devm_ioremap() instead of ioremap and cleanup the error path
c> uses devm_request_irq() instead of request_irq and cleanup the error path

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 Note: This patch is compile tested only and applies on linux-next.

 drivers/video/fbdev/goldfishfb.c | 61 +++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index 7f6c9e6..841514d 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -188,31 +188,25 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 	u32 width, height;
 	dma_addr_t fbpaddr;
 
-	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
-	if (fb = NULL) {
-		ret = -ENOMEM;
-		goto err_fb_alloc_failed;
-	}
+	fb = devm_kzalloc(&pdev->dev, sizeof(*fb), GFP_KERNEL);
+	if (fb = NULL)
+		return -ENOMEM;
+
 	spin_lock_init(&fb->lock);
 	init_waitqueue_head(&fb->wait);
 	platform_set_drvdata(pdev, fb);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (r = NULL) {
-		ret = -ENODEV;
-		goto err_no_io_base;
-	}
-	fb->reg_base = ioremap(r->start, PAGE_SIZE);
-	if (fb->reg_base = NULL) {
-		ret = -ENOMEM;
-		goto err_no_io_base;
-	}
+	if (r = NULL)
+		return -ENODEV;
+
+	fb->reg_base = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
+	if (fb->reg_base = NULL)
+		return -ENOMEM;
 
 	fb->irq = platform_get_irq(pdev, 0);
-	if (fb->irq <= 0) {
-		ret = -ENODEV;
-		goto err_no_irq;
-	}
+	if (fb->irq <= 0)
+		return -ENODEV;
 
 	width = readl(fb->reg_base + FB_GET_WIDTH);
 	height = readl(fb->reg_base + FB_GET_HEIGHT);
@@ -249,43 +243,34 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 						&fbpaddr, GFP_KERNEL);
 	pr_debug("allocating frame buffer %d * %d, got %p\n",
 					width, height, fb->fb.screen_base);
-	if (fb->fb.screen_base = NULL) {
-		ret = -ENOMEM;
-		goto err_alloc_screen_base_failed;
-	}
+	if (fb->fb.screen_base = NULL)
+		return -ENOMEM;
+
 	fb->fb.fix.smem_start = fbpaddr;
 	fb->fb.fix.smem_len = framesize;
 
 	ret = fb_set_var(&fb->fb, &fb->fb.var);
 	if (ret)
-		goto err_fb_set_var_failed;
+		goto error;
 
-	ret = request_irq(fb->irq, goldfish_fb_interrupt, IRQF_SHARED,
-							pdev->name, fb);
+	ret = devm_request_irq(&pdev->dev, fb->irq, goldfish_fb_interrupt,
+			       IRQF_SHARED, pdev->name, fb);
 	if (ret)
-		goto err_request_irq_failed;
+		goto error;
 
 	writel(FB_INT_BASE_UPDATE_DONE, fb->reg_base + FB_INT_ENABLE);
 	goldfish_fb_pan_display(&fb->fb.var, &fb->fb); /* updates base */
 
 	ret = register_framebuffer(&fb->fb);
 	if (ret)
-		goto err_register_framebuffer_failed;
+		goto error;
+
 	return 0;
 
-err_register_framebuffer_failed:
-	free_irq(fb->irq, fb);
-err_request_irq_failed:
-err_fb_set_var_failed:
+error:
 	dma_free_coherent(&pdev->dev, framesize,
 				(void *)fb->fb.screen_base,
 				fb->fb.fix.smem_start);
-err_alloc_screen_base_failed:
-err_no_irq:
-	iounmap(fb->reg_base);
-err_no_io_base:
-	kfree(fb);
-err_fb_alloc_failed:
 	return ret;
 }
 
@@ -296,11 +281,9 @@ static int goldfish_fb_remove(struct platform_device *pdev)
 
 	framesize = fb->fb.var.xres_virtual * fb->fb.var.yres_virtual * 2;
 	unregister_framebuffer(&fb->fb);
-	free_irq(fb->irq, fb);
 
 	dma_free_coherent(&pdev->dev, framesize, (void *)fb->fb.screen_base,
 						fb->fb.fix.smem_start);
-	iounmap(fb->reg_base);
 	return 0;
 }
 
-- 
1.9.1

