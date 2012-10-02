From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Tue, 02 Oct 2012 23:57:40 +0000
Subject: [PATCH] video: s3c-fb: use clk_prepare_enable and clk_disable_unprepare
Message-Id: <1349222260-3248-1-git-send-email-thomas.abraham@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: FlorianSchandinat@gmx.de, jg1.han@samsung.com, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org

Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
calls as required by common clock framework.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/video/s3c-fb.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 52b744f..2ed7b63 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1404,7 +1404,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 		return PTR_ERR(sfb->bus_clk);
 	}
 
-	clk_enable(sfb->bus_clk);
+	clk_prepare_enable(sfb->bus_clk);
 
 	if (!sfb->variant.has_clksel) {
 		sfb->lcd_clk = devm_clk_get(dev, "sclk_fimd");
@@ -1414,7 +1414,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 			goto err_bus_clk;
 		}
 
-		clk_enable(sfb->lcd_clk);
+		clk_prepare_enable(sfb->lcd_clk);
 	}
 
 	pm_runtime_enable(sfb->dev);
@@ -1504,10 +1504,10 @@ err_lcd_clk:
 	pm_runtime_disable(sfb->dev);
 
 	if (!sfb->variant.has_clksel)
-		clk_disable(sfb->lcd_clk);
+		clk_disable_unprepare(sfb->lcd_clk);
 
 err_bus_clk:
-	clk_disable(sfb->bus_clk);
+	clk_disable_unprepare(sfb->bus_clk);
 
 	return ret;
 }
@@ -1531,9 +1531,9 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 			s3c_fb_release_win(sfb, sfb->windows[win]);
 
 	if (!sfb->variant.has_clksel)
-		clk_disable(sfb->lcd_clk);
+		clk_disable_unprepare(sfb->lcd_clk);
 
-	clk_disable(sfb->bus_clk);
+	clk_disable_unprepare(sfb->bus_clk);
 
 	pm_runtime_put_sync(sfb->dev);
 	pm_runtime_disable(sfb->dev);
@@ -1561,9 +1561,9 @@ static int s3c_fb_suspend(struct device *dev)
 	}
 
 	if (!sfb->variant.has_clksel)
-		clk_disable(sfb->lcd_clk);
+		clk_disable_unprepare(sfb->lcd_clk);
 
-	clk_disable(sfb->bus_clk);
+	clk_disable_unprepare(sfb->bus_clk);
 
 	pm_runtime_put_sync(sfb->dev);
 
@@ -1581,10 +1581,10 @@ static int s3c_fb_resume(struct device *dev)
 
 	pm_runtime_get_sync(sfb->dev);
 
-	clk_enable(sfb->bus_clk);
+	clk_prepare_enable(sfb->bus_clk);
 
 	if (!sfb->variant.has_clksel)
-		clk_enable(sfb->lcd_clk);
+		clk_prepare_enable(sfb->lcd_clk);
 
 	/* setup gpio and output polarity controls */
 	pd->setup_gpio();
@@ -1640,9 +1640,9 @@ static int s3c_fb_runtime_suspend(struct device *dev)
 	struct s3c_fb *sfb = platform_get_drvdata(pdev);
 
 	if (!sfb->variant.has_clksel)
-		clk_disable(sfb->lcd_clk);
+		clk_disable_unprepare(sfb->lcd_clk);
 
-	clk_disable(sfb->bus_clk);
+	clk_disable_unprepare(sfb->bus_clk);
 
 	return 0;
 }
@@ -1653,10 +1653,10 @@ static int s3c_fb_runtime_resume(struct device *dev)
 	struct s3c_fb *sfb = platform_get_drvdata(pdev);
 	struct s3c_fb_platdata *pd = sfb->pdata;
 
-	clk_enable(sfb->bus_clk);
+	clk_prepare_enable(sfb->bus_clk);
 
 	if (!sfb->variant.has_clksel)
-		clk_enable(sfb->lcd_clk);
+		clk_prepare_enable(sfb->lcd_clk);
 
 	/* setup gpio and output polarity controls */
 	pd->setup_gpio();
-- 
1.7.4.1

