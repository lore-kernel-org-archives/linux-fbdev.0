From: Darren Etheridge <detheridge@ti.com>
Date: Tue, 30 Jul 2013 18:26:21 +0000
Subject: [PATCH v2 14/24] video: da8xx-fb: use devres
Message-Id: <1375208791-15781-15-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Afzal Mohammed <afzal@ti.com>

Replace existing resource handling in the driver with managed device
resource.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |   35 ++++++-----------------------------
 1 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index dec333e..61150f9 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1037,12 +1037,9 @@ static int fb_remove(struct platform_device *dev)
 				  par->p_palette_base);
 		dma_free_coherent(NULL, par->vram_size, par->vram_virt,
 				  par->vram_phys);
-		free_irq(par->irq, par);
 		pm_runtime_put_sync(&dev->dev);
 		pm_runtime_disable(&dev->dev);
 		framebuffer_release(info);
-		iounmap(da8xx_fb_reg_base);
-		release_mem_region(lcdc_regs->start, resource_size(lcdc_regs));
 
 	}
 	return 0;
@@ -1266,7 +1263,6 @@ static int fb_probe(struct platform_device *device)
 	struct fb_info *da8xx_fb_info;
 	struct clk *fb_clk = NULL;
 	struct da8xx_fb_par *par;
-	resource_size_t len;
 	int ret, i;
 	unsigned long ulcm;
 
@@ -1276,29 +1272,16 @@ static int fb_probe(struct platform_device *device)
 	}
 
 	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
-	if (!lcdc_regs) {
-		dev_err(&device->dev,
-			"Can not get memory resource for LCD controller\n");
-		return -ENOENT;
-	}
-
-	len = resource_size(lcdc_regs);
-
-	lcdc_regs = request_mem_region(lcdc_regs->start, len, lcdc_regs->name);
-	if (!lcdc_regs)
-		return -EBUSY;
-
-	da8xx_fb_reg_base = ioremap(lcdc_regs->start, len);
+	da8xx_fb_reg_base = devm_request_and_ioremap(&device->dev, lcdc_regs);
 	if (!da8xx_fb_reg_base) {
-		ret = -EBUSY;
-		goto err_request_mem;
+		dev_err(&device->dev, "memory resource setup failed\n");
+		return -EADDRNOTAVAIL;
 	}
 
-	fb_clk = clk_get(&device->dev, "fck");
+	fb_clk = devm_clk_get(&device->dev, "fck");
 	if (IS_ERR(fb_clk)) {
 		dev_err(&device->dev, "Can not get device clock\n");
-		ret = -ENODEV;
-		goto err_ioremap;
+		return -ENODEV;
 	}
 
 	pm_runtime_enable(&device->dev);
@@ -1459,7 +1442,7 @@ static int fb_probe(struct platform_device *device)
 		lcdc_irq_handler = lcdc_irq_handler_rev02;
 	}
 
-	ret = request_irq(par->irq, lcdc_irq_handler, 0,
+	ret = devm_request_irq(&device->dev, par->irq, lcdc_irq_handler, 0,
 			DRIVER_NAME, par);
 	if (ret)
 		goto irq_freq;
@@ -1489,12 +1472,6 @@ err_pm_runtime_disable:
 	pm_runtime_put_sync(&device->dev);
 	pm_runtime_disable(&device->dev);
 
-err_ioremap:
-	iounmap(da8xx_fb_reg_base);
-
-err_request_mem:
-	release_mem_region(lcdc_regs->start, len);
-
 	return ret;
 }
 
-- 
1.7.0.4

