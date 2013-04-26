From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Fri, 26 Apr 2013 20:02:21 +0000
Subject: [PATCH 7/9] s3c2410fb: Use devm_ioremap_resource()
Message-Id: <1367006543-5458-8-git-send-email-sylvester.nawrocki@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
In-Reply-To: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use devm_ioremap_resource instead of reques_mem_region()/ioremap().
This ensures more consistent error values and simplifies error paths.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 drivers/video/s3c2410fb.c |   32 ++++----------------------------
 1 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index da8b6c2..11f98ca 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -825,7 +825,6 @@ static int s3c2410fb_probe(struct platform_device *pdev)
 	int ret;
 	int irq;
 	int i;
-	int size;
 	u32 lcdcon1;
 
 	mach_info = pdev->dev.platform_data;
@@ -860,27 +859,12 @@ static int s3c2410fb_probe(struct platform_device *pdev)
 	info->drv_type = platform_get_device_id(pdev)->driver_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res = NULL) {
-		dev_err(&pdev->dev, "failed to get memory registers\n");
-		ret = -ENXIO;
+	info->io = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(info->io)) {
+		ret = PTR_ERR(info->io);
 		goto dealloc_fb;
 	}
 
-	size = resource_size(res);
-	info->mem = request_mem_region(res->start, size, pdev->name);
-	if (info->mem = NULL) {
-		dev_err(&pdev->dev, "failed to get memory region\n");
-		ret = -ENOENT;
-		goto dealloc_fb;
-	}
-
-	info->io = ioremap(res->start, size);
-	if (info->io = NULL) {
-		dev_err(&pdev->dev, "ioremap() of registers failed\n");
-		ret = -ENXIO;
-		goto release_mem;
-	}
-
 	if (info->drv_type = DRV_S3C2412)
 		info->irq_base = info->io + S3C2412_LCDINTBASE;
 	else
@@ -917,7 +901,7 @@ static int s3c2410fb_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "cannot get irq %d - err %d\n", irq, ret);
 		ret = -EBUSY;
-		goto release_regs;
+		goto dealloc_fb;
 	}
 
 	info->clk = clk_get(NULL, "lcd");
@@ -997,10 +981,6 @@ release_clock:
 	clk_put(info->clk);
 release_irq:
 	free_irq(irq, info);
-release_regs:
-	iounmap(info->io);
-release_mem:
-	release_mem_region(res->start, size);
 dealloc_fb:
 	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
@@ -1033,10 +1013,6 @@ static int s3c2410fb_remove(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	free_irq(irq, info);
 
-	iounmap(info->io);
-
-	release_mem_region(info->mem->start, resource_size(info->mem));
-
 	platform_set_drvdata(pdev, NULL);
 	framebuffer_release(fbinfo);
 
-- 
1.7.4.1

