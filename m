From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 20 Feb 2012 10:40:19 +0000
Subject: [PATCH] video: s3c-fb: use devm_request_irq()
Message-Id: <017101ccefbc$0ab90710$202b1530$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The devm_ functions allocate memory that is released when a driver
detaches. This patch uses devm_request_irq of these functions.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index e22bf9d..1fb7ddf 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1433,7 +1433,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 		goto err_lcd_clk;
 	}
 	sfb->irq_no = res->start;
-	ret = request_irq(sfb->irq_no, s3c_fb_irq,
+	ret = devm_request_irq(dev, sfb->irq_no, s3c_fb_irq,
 			  0, "s3c_fb", sfb);
 	if (ret) {
 		dev_err(dev, "irq request failed\n");
@@ -1499,7 +1499,6 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 
 err_pm_runtime:
 	pm_runtime_put_sync(sfb->dev);
-	free_irq(sfb->irq_no, sfb);
 
 err_lcd_clk:
 	pm_runtime_disable(sfb->dev);
@@ -1535,8 +1534,6 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 		if (sfb->windows[win])
 			s3c_fb_release_win(sfb, sfb->windows[win]);
 
-	free_irq(sfb->irq_no, sfb);
-
 	if (!sfb->variant.has_clksel) {
 		clk_disable(sfb->lcd_clk);
 		clk_put(sfb->lcd_clk);
-- 
1.7.1


