From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 29 Mar 2014 10:00:20 +0000
Subject: [PATCH 2/2] backlight: platform_lcd: Remove #ifdef CONFIG_PM_SLEEP
Message-Id: <1396087220-1564-2-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch removes #ifdef CONFIG_PM_SLEEP to improve compile coverage.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/backlight/platform_lcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
index 4afc21f..986f46a 100644
--- a/drivers/video/backlight/platform_lcd.c
+++ b/drivers/video/backlight/platform_lcd.c
@@ -110,8 +110,7 @@ static int platform_lcd_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int platform_lcd_suspend(struct device *dev)
+static int __maybe_unused platform_lcd_suspend(struct device *dev)
 {
 	struct platform_lcd *plcd = dev_get_drvdata(dev);
 
@@ -121,7 +120,7 @@ static int platform_lcd_suspend(struct device *dev)
 	return 0;
 }
 
-static int platform_lcd_resume(struct device *dev)
+static int __maybe_unused platform_lcd_resume(struct device *dev)
 {
 	struct platform_lcd *plcd = dev_get_drvdata(dev);
 
@@ -130,7 +129,6 @@ static int platform_lcd_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(platform_lcd_pm_ops, platform_lcd_suspend,
 			platform_lcd_resume);
-- 
1.8.3.2

