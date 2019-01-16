From: Alexander Shiyan <shc_work@mail.ru>
Date: Wed, 16 Jan 2019 13:38:17 +0000
Subject: [PATCH v2] backlight: pwm_bl: Use SIMPLE_DEV_PM_OPS()
Message-Id: <20190116133817.2483-1-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pwm@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>

Use the SIMPLE_DEV_PM_OPS() macro to declare the driver's pm_ops.
As a side effect, removing #ifdef CONFIG_PM_SLEEP will improve
compilation coverage.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/backlight/pwm_bl.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index feb9076..eaefdb0 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -673,8 +673,7 @@ static void pwm_backlight_shutdown(struct platform_device *pdev)
 	pwm_backlight_power_off(pb);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pwm_backlight_suspend(struct device *dev)
+static int __maybe_unused pwm_backlight_suspend(struct device *dev)
 {
 	struct backlight_device *bl = dev_get_drvdata(dev);
 	struct pwm_bl_data *pb = bl_get_data(bl);
@@ -690,7 +689,7 @@ static int pwm_backlight_suspend(struct device *dev)
 	return 0;
 }
 
-static int pwm_backlight_resume(struct device *dev)
+static int __maybe_unused pwm_backlight_resume(struct device *dev)
 {
 	struct backlight_device *bl = dev_get_drvdata(dev);
 
@@ -698,16 +697,9 @@ static int pwm_backlight_resume(struct device *dev)
 
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
+static SIMPLE_DEV_PM_OPS(pwm_backlight_pm_ops,
+			 pwm_backlight_suspend, pwm_backlight_resume);
 
 static struct platform_driver pwm_backlight_driver = {
 	.driver		= {
-- 
2.10.2
