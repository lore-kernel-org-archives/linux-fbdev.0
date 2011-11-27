From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sun, 27 Nov 2011 22:51:08 +0000
Subject: [PATCH 2/2] video: s3c-fb: Convert to devm style allocation
Message-Id: <1322434268-25525-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Saves some code, especially useful as the code saved is mostly in the
infrequently tested error paths.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/video/s3c-fb.c |   32 +++++---------------------------
 1 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 27971bc..c8e822b 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -186,7 +186,6 @@ struct s3c_fb_vsync {
  * struct s3c_fb - overall hardware state of the hardware
  * @slock: The spinlock protection for this data sturcture.
  * @dev: The device that we bound to, for printing, etc.
- * @regs_res: The resource we claimed for the IO registers.
  * @bus_clk: The clk (hclk) feeding our interface and possibly pixclk.
  * @lcd_clk: The clk (sclk) feeding pixclk.
  * @regs: The mapped hardware registers.
@@ -201,7 +200,6 @@ struct s3c_fb_vsync {
 struct s3c_fb {
 	spinlock_t		slock;
 	struct device		*dev;
-	struct resource		*regs_res;
 	struct clk		*bus_clk;
 	struct clk		*lcd_clk;
 	void __iomem		*regs;
@@ -1341,7 +1339,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	sfb = kzalloc(sizeof(struct s3c_fb), GFP_KERNEL);
+	sfb = devm_kzalloc(dev, sizeof(struct s3c_fb), GFP_KERNEL);
 	if (!sfb) {
 		dev_err(dev, "no memory for framebuffers\n");
 		return -ENOMEM;
@@ -1384,33 +1382,25 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 		goto err_lcd_clk;
 	}
 
-	sfb->regs_res = request_mem_region(res->start, resource_size(res),
-					   dev_name(dev));
-	if (!sfb->regs_res) {
-		dev_err(dev, "failed to claim register region\n");
-		ret = -ENOENT;
-		goto err_lcd_clk;
-	}
-
-	sfb->regs = ioremap(res->start, resource_size(res));
+	sfb->regs = devm_request_and_ioremap(dev, res);
 	if (!sfb->regs) {
 		dev_err(dev, "failed to map registers\n");
 		ret = -ENXIO;
-		goto err_req_region;
+		goto err_lcd_clk;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res) {
 		dev_err(dev, "failed to acquire irq resource\n");
 		ret = -ENOENT;
-		goto err_ioremap;
+		goto err_lcd_clk;
 	}
 	sfb->irq_no = res->start;
 	ret = request_irq(sfb->irq_no, s3c_fb_irq,
 			  0, "s3c_fb", sfb);
 	if (ret) {
 		dev_err(dev, "irq request failed\n");
-		goto err_ioremap;
+		goto err_lcd_clk;
 	}
 
 	dev_dbg(dev, "got resources (regs %p), probing windows\n", sfb->regs);
@@ -1465,12 +1455,6 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 err_irq:
 	free_irq(sfb->irq_no, sfb);
 
-err_ioremap:
-	iounmap(sfb->regs);
-
-err_req_region:
-	release_mem_region(sfb->regs_res->start, resource_size(sfb->regs_res));
-
 err_lcd_clk:
 	if (!sfb->variant.has_clksel) {
 		clk_disable(sfb->lcd_clk);
@@ -1482,7 +1466,6 @@ err_bus_clk:
 	clk_put(sfb->bus_clk);
 
 err_sfb:
-	kfree(sfb);
 	return ret;
 }
 
@@ -1506,8 +1489,6 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 
 	free_irq(sfb->irq_no, sfb);
 
-	iounmap(sfb->regs);
-
 	if (!sfb->variant.has_clksel) {
 		clk_disable(sfb->lcd_clk);
 		clk_put(sfb->lcd_clk);
@@ -1516,12 +1497,9 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 	clk_disable(sfb->bus_clk);
 	clk_put(sfb->bus_clk);
 
-	release_mem_region(sfb->regs_res->start, resource_size(sfb->regs_res));
-
 	pm_runtime_put_sync(sfb->dev);
 	pm_runtime_disable(sfb->dev);
 
-	kfree(sfb);
 	return 0;
 }
 
-- 
1.7.7.3

