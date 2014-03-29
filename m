From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 29 Mar 2014 10:00:19 +0000
Subject: [PATCH 1/2] backlight: platform_lcd: Remove DT compatibility string
Message-Id: <1396087220-1564-1-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver is written for using platform callback functions and it cannot
be used without these functions, so having "platform-lcd" in the device
tree do nothing. This patch removes DT compatibility string.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/backlight/platform_lcd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
index c3d2e20..4afc21f 100644
--- a/drivers/video/backlight/platform_lcd.c
+++ b/drivers/video/backlight/platform_lcd.c
@@ -16,8 +16,6 @@
 #include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/lcd.h>
-#include <linux/of.h>
-#include <linux/slab.h>
 
 #include <video/platform_lcd.h>
 
@@ -137,20 +135,11 @@ static int platform_lcd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(platform_lcd_pm_ops, platform_lcd_suspend,
 			platform_lcd_resume);
 
-#ifdef CONFIG_OF
-static const struct of_device_id platform_lcd_of_match[] = {
-	{ .compatible = "platform-lcd" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, platform_lcd_of_match);
-#endif
-
 static struct platform_driver platform_lcd_driver = {
 	.driver		= {
 		.name	= "platform-lcd",
 		.owner	= THIS_MODULE,
 		.pm	= &platform_lcd_pm_ops,
-		.of_match_table = of_match_ptr(platform_lcd_of_match),
 	},
 	.probe		= platform_lcd_probe,
 };
-- 
1.8.3.2

