From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 14 Sep 2012 21:34:51 +0000
Subject: [PATCH 23/24] video: da8xx-fb: use __iomem pointers for MMIO
Message-Id: <1347658492-11608-24-git-send-email-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1347658492-11608-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

ARM is moving to stricter checks on readl/write functions,
so we need to use the correct types everywhere.

Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/da8xx-fb.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 7ae9d53..113d43a 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -131,7 +131,7 @@
 #define UPPER_MARGIN	32
 #define LOWER_MARGIN	32
 
-static resource_size_t da8xx_fb_reg_base;
+static void __iomem *da8xx_fb_reg_base;
 static struct resource *lcdc_regs;
 static unsigned int lcd_revision;
 static irq_handler_t lcdc_irq_handler;
@@ -951,7 +951,7 @@ static int __devexit fb_remove(struct platform_device *dev)
 		clk_disable(par->lcdc_clk);
 		clk_put(par->lcdc_clk);
 		framebuffer_release(info);
-		iounmap((void __iomem *)da8xx_fb_reg_base);
+		iounmap(da8xx_fb_reg_base);
 		release_mem_region(lcdc_regs->start, resource_size(lcdc_regs));
 
 	}
@@ -1171,7 +1171,7 @@ static int __devinit fb_probe(struct platform_device *device)
 	if (!lcdc_regs)
 		return -EBUSY;
 
-	da8xx_fb_reg_base = (resource_size_t)ioremap(lcdc_regs->start, len);
+	da8xx_fb_reg_base = ioremap(lcdc_regs->start, len);
 	if (!da8xx_fb_reg_base) {
 		ret = -EBUSY;
 		goto err_request_mem;
@@ -1392,7 +1392,7 @@ err_clk_put:
 	clk_put(fb_clk);
 
 err_ioremap:
-	iounmap((void __iomem *)da8xx_fb_reg_base);
+	iounmap(da8xx_fb_reg_base);
 
 err_request_mem:
 	release_mem_region(lcdc_regs->start, len);
-- 
1.7.10

