From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 29 Dec 2011 18:20:38 +0000
Subject: [PATCH 2/2] backlight: Convert pwm_bl to dev_pm_ops
Message-Id: <1325182838-25729-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Should be no functional changes, mainly a reorganisation to support
future work.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/video/backlight/pwm_bl.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index b811e8f..13ba95b 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -169,10 +169,9 @@ static int pwm_backlight_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int pwm_backlight_suspend(struct platform_device *pdev,
-				 pm_message_t state)
+static int pwm_backlight_suspend(struct device *dev)
 {
-	struct backlight_device *bl = platform_get_drvdata(pdev);
+	struct backlight_device *bl = dev_get_drvdata(dev);
 	struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);
 
 	if (pb->notify)
@@ -184,27 +183,29 @@ static int pwm_backlight_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-static int pwm_backlight_resume(struct platform_device *pdev)
+static int pwm_backlight_resume(struct device *dev)
 {
-	struct backlight_device *bl = platform_get_drvdata(pdev);
+	struct backlight_device *bl = dev_get_drvdata(dev);
 
 	backlight_update_status(bl);
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(pwm_backlight_pm_ops, pwm_backlight_suspend,
+			 pwm_backlight_resume);
+
 #else
-#define pwm_backlight_suspend	NULL
-#define pwm_backlight_resume	NULL
+#define pwm_backlight_pm_ops	NULL
 #endif
 
 static struct platform_driver pwm_backlight_driver = {
 	.driver		= {
 		.name	= "pwm-backlight",
 		.owner	= THIS_MODULE,
+		.pm	= &pwm_backlight_pm_ops,
 	},
 	.probe		= pwm_backlight_probe,
 	.remove		= pwm_backlight_remove,
-	.suspend	= pwm_backlight_suspend,
-	.resume		= pwm_backlight_resume,
 };
 
 module_platform_driver(pwm_backlight_driver);
-- 
1.7.7.3

