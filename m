From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 29 Mar 2014 10:11:11 +0000
Subject: [PATCH] backlight: pwm_bl: Use SIMPLE_DEV_PM_OPS()
Message-Id: <1396087871-9091-1-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the SIMPLE_DEV_PM_OPS() macro to declare the driver's pm_ops.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/backlight/pwm_bl.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index b75201f..d5e1f5b 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -359,8 +359,7 @@ static int pwm_backlight_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pwm_backlight_suspend(struct device *dev)
+static int __maybe_unused pwm_bl_suspend(struct device *dev)
 {
 	struct backlight_device *bl = dev_get_drvdata(dev);
 	struct pwm_bl_data *pb = bl_get_data(bl);
@@ -376,7 +375,7 @@ static int pwm_backlight_suspend(struct device *dev)
 	return 0;
 }
 
-static int pwm_backlight_resume(struct device *dev)
+static int __maybe_unused pwm_bl_resume(struct device *dev)
 {
 	struct backlight_device *bl = dev_get_drvdata(dev);
 
@@ -384,22 +383,14 @@ static int pwm_backlight_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops pwm_backlight_pm_ops = {
-#ifdef CONFIG_PM_SLEEP
-	.suspend = pwm_backlight_suspend,
-	.resume = pwm_backlight_resume,
-	.poweroff = pwm_backlight_suspend,
-	.restore = pwm_backlight_resume,
-#endif
-};
+static SIMPLE_DEV_PM_OPS(pwm_bl_pm_ops, pwm_bl_suspend, pwm_bl_resume);
 
 static struct platform_driver pwm_backlight_driver = {
 	.driver		= {
 		.name		= "pwm-backlight",
 		.owner		= THIS_MODULE,
-		.pm		= &pwm_backlight_pm_ops,
+		.pm		= &pwm_bl_pm_ops,
 		.of_match_table	= of_match_ptr(pwm_backlight_of_match),
 	},
 	.probe		= pwm_backlight_probe,
-- 
1.8.3.2

