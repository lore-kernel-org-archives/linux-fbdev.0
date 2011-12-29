From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 29 Dec 2011 18:20:37 +0000
Subject: [PATCH 1/2] backlight: Convert platform_lcd to devm_kzalloc()
Message-Id: <1325182838-25729-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Saves some error handling code and eliminates a class of leaks.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/video/backlight/platform_lcd.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
index 187da59..f0bf491 100644
--- a/drivers/video/backlight/platform_lcd.c
+++ b/drivers/video/backlight/platform_lcd.c
@@ -85,7 +85,8 @@ static int __devinit platform_lcd_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	plcd = kzalloc(sizeof(struct platform_lcd), GFP_KERNEL);
+	plcd = devm_kzalloc(&pdev->dev, sizeof(struct platform_lcd),
+			    GFP_KERNEL);
 	if (!plcd) {
 		dev_err(dev, "no memory for state\n");
 		return -ENOMEM;
@@ -98,7 +99,7 @@ static int __devinit platform_lcd_probe(struct platform_device *pdev)
 	if (IS_ERR(plcd->lcd)) {
 		dev_err(dev, "cannot register lcd device\n");
 		err = PTR_ERR(plcd->lcd);
-		goto err_mem;
+		goto err;
 	}
 
 	platform_set_drvdata(pdev, plcd);
@@ -106,8 +107,7 @@ static int __devinit platform_lcd_probe(struct platform_device *pdev)
 
 	return 0;
 
- err_mem:
-	kfree(plcd);
+ err:
 	return err;
 }
 
@@ -116,7 +116,6 @@ static int __devexit platform_lcd_remove(struct platform_device *pdev)
 	struct platform_lcd *plcd = platform_get_drvdata(pdev);
 
 	lcd_device_unregister(plcd->lcd);
-	kfree(plcd);
 
 	return 0;
 }
-- 
1.7.7.3

