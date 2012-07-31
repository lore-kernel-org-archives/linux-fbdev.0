From: Damien Cassou <damien.cassou@lifl.fr>
Date: Tue, 31 Jul 2012 13:54:17 +0000
Subject: [PATCH 4/5] drivers/video/da8xx-fb.c: use devm_ functions
Message-Id: <1343742860-16213-3-git-send-email-damien.cassou@lifl.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343742860-16213-1-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1343742860-16213-1-git-send-email-damien.cassou@lifl.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Damien Cassou <damien.cassou@lifl.fr>

The various devm_ functions allocate memory that is released when a driver
detaches.  This patch uses these functions for data that is allocated in
the probe function of a platform device and is only freed in the remove
function.

Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>

---
 drivers/video/da8xx-fb.c |   34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 7ae9d53..0429431 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -947,12 +947,9 @@ static int __devexit fb_remove(struct platform_device *dev)
 				  par->p_palette_base);
 		dma_free_coherent(NULL, par->vram_size, par->vram_virt,
 				  par->vram_phys);
-		free_irq(par->irq, par);
 		clk_disable(par->lcdc_clk);
 		clk_put(par->lcdc_clk);
 		framebuffer_release(info);
-		iounmap((void __iomem *)da8xx_fb_reg_base);
-		release_mem_region(lcdc_regs->start, resource_size(lcdc_regs));
 
 	}
 	return 0;
@@ -1149,7 +1146,7 @@ static int __devinit fb_probe(struct platform_device *device)
 	struct fb_info *da8xx_fb_info;
 	struct clk *fb_clk = NULL;
 	struct da8xx_fb_par *par;
-	resource_size_t len;
+
 	int ret, i;
 	unsigned long ulcm;
 
@@ -1159,29 +1156,20 @@ static int __devinit fb_probe(struct platform_device *device)
 	}
 
 	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
-	if (!lcdc_regs) {
-		dev_err(&device->dev,
-			"Can not get memory resource for LCD controller\n");
-		return -ENOENT;
-	}
-
-	len = resource_size(lcdc_regs);
 
-	lcdc_regs = request_mem_region(lcdc_regs->start, len, lcdc_regs->name);
-	if (!lcdc_regs)
-		return -EBUSY;
-
-	da8xx_fb_reg_base = (resource_size_t)ioremap(lcdc_regs->start, len);
+	da8xx_fb_reg_base +		(resource_size_t) devm_request_and_ioremap(&device->dev,
+							   lcdc_regs);
 	if (!da8xx_fb_reg_base) {
 		ret = -EBUSY;
-		goto err_request_mem;
+		return ret;
 	}
 
 	fb_clk = clk_get(&device->dev, NULL);
 	if (IS_ERR(fb_clk)) {
 		dev_err(&device->dev, "Can not get device clock\n");
 		ret = -ENODEV;
-		goto err_ioremap;
+		return ret;
 	}
 	ret = clk_enable(fb_clk);
 	if (ret)
@@ -1359,8 +1347,8 @@ static int __devinit fb_probe(struct platform_device *device)
 	else
 		lcdc_irq_handler = lcdc_irq_handler_rev02;
 
-	ret = request_irq(par->irq, lcdc_irq_handler, 0,
-			DRIVER_NAME, par);
+	ret = devm_request_irq(&device->dev, par->irq, lcdc_irq_handler, 0,
+			       DRIVER_NAME, par);
 	if (ret)
 		goto irq_freq;
 	return 0;
@@ -1391,12 +1379,6 @@ err_clk_disable:
 err_clk_put:
 	clk_put(fb_clk);
 
-err_ioremap:
-	iounmap((void __iomem *)da8xx_fb_reg_base);
-
-err_request_mem:
-	release_mem_region(lcdc_regs->start, len);
-
 	return ret;
 }
 

