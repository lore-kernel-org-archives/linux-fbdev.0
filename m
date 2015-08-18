From: Vaishali Thakkar <vthakkar1994@gmail.com>
Date: Tue, 18 Aug 2015 03:40:40 +0000
Subject: [PATCH] video: fbdev: Use devm_clk_get
Message-Id: <20150818032840.GA14566@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This patch introduces the use of managed resource function
devm_clk_get instead of clk_get and removes corresponding calls
to clk_put in the probe and remove functions.

To be compatible with the change various gotos are replaced with
direct returns, and unneeded label failed_put_clk is dropped.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/video/fbdev/pxa168fb.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index e209b03..efb57c0 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -615,7 +615,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	clk = clk_get(&pdev->dev, "LCDCLK");
+	clk = devm_clk_get(&pdev->dev, "LCDCLK");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get LCDCLK");
 		return PTR_ERR(clk);
@@ -624,21 +624,18 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res = NULL) {
 		dev_err(&pdev->dev, "no IO memory defined\n");
-		ret = -ENOENT;
-		goto failed_put_clk;
+		return -ENOENT;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no IRQ defined\n");
-		ret = -ENOENT;
-		goto failed_put_clk;
+		return -ENOENT;
 	}
 
 	info = framebuffer_alloc(sizeof(struct pxa168fb_info), &pdev->dev);
 	if (info = NULL) {
-		ret = -ENOMEM;
-		goto failed_put_clk;
+		return -ENOMEM;
 	}
 
 	/* Initialize private data */
@@ -776,8 +773,6 @@ failed_free_fbmem:
 			info->screen_base, fbi->fb_start_dma);
 failed_free_info:
 	kfree(info);
-failed_put_clk:
-	clk_put(clk);
 
 	dev_err(&pdev->dev, "frame buffer device init failed with %d\n", ret);
 	return ret;
@@ -813,7 +808,6 @@ static int pxa168fb_remove(struct platform_device *pdev)
 				info->screen_base, info->fix.smem_start);
 
 	clk_disable(fbi->clk);
-	clk_put(fbi->clk);
 
 	framebuffer_release(info);
 
-- 
1.9.1

