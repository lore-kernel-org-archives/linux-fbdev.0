From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 18 Feb 2012 18:19:29 +0000
Subject: [PATCH] drivers/video/pxa168fb.c: use devm_ functions
Message-Id: <1329589169-18235-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

The various devm_ functions allocate memory that is released when a driver
detaches.  This patch uses these functions for data that is allocated in
the probe function of a platform device and is only freed in the remove
function.

By using devm_ioremap, it also removes a potential memory leak, because
there was no call to iounmap in the probe function.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/pxa168fb.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 8384b94..f146089 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -21,6 +21,7 @@
 #include <linux/fb.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -670,7 +671,8 @@ static int __devinit pxa168fb_probe(struct platform_device *pdev)
 	/*
 	 * Map LCD controller registers.
 	 */
-	fbi->reg_base = ioremap_nocache(res->start, resource_size(res));
+	fbi->reg_base = devm_ioremap_nocache(&pdev->dev, res->start,
+					     resource_size(res));
 	if (fbi->reg_base = NULL) {
 		ret = -ENOMEM;
 		goto failed_free_info;
@@ -739,8 +741,8 @@ static int __devinit pxa168fb_probe(struct platform_device *pdev)
 	/*
 	 * Register irq handler.
 	 */
-	ret = request_irq(irq, pxa168fb_handle_irq, IRQF_SHARED,
-					info->fix.id, fbi);
+	ret = devm_request_irq(&pdev->dev, irq, pxa168fb_handle_irq,
+			       IRQF_SHARED, info->fix.id, fbi);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "unable to request IRQ\n");
 		ret = -ENXIO;
@@ -759,14 +761,12 @@ static int __devinit pxa168fb_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register pxa168-fb: %d\n", ret);
 		ret = -ENXIO;
-		goto failed_free_irq;
+		goto failed_free_cmap;
 	}
 
 	platform_set_drvdata(pdev, fbi);
 	return 0;
 
-failed_free_irq:
-	free_irq(irq, fbi);
 failed_free_cmap:
 	fb_dealloc_cmap(&info->cmap);
 failed_free_clk:
@@ -808,13 +808,10 @@ static int __devexit pxa168fb_remove(struct platform_device *pdev)
 		fb_dealloc_cmap(&info->cmap);
 
 	irq = platform_get_irq(pdev, 0);
-	free_irq(irq, fbi);
 
 	dma_free_writecombine(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
 				info->screen_base, info->fix.smem_start);
 
-	iounmap(fbi->reg_base);
-
 	clk_disable(fbi->clk);
 	clk_put(fbi->clk);
 

