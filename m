From: Alexander Shiyan <shc_work@mail.ru>
Date: Sun, 16 Dec 2018 04:21:12 +0000
Subject: [PATCH] backlight: pwm_bl: Use SIMPLE_DEV_PM_OPS()
Message-Id: <20181216042112.22644-1-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1396087871-9091-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1396087871-9091-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>

Use the SIMPLE_DEV_PM_OPS() macro to declare the driver's pm_ops.
As a side effect, removing #ifdef CONFIG_PM_SLEEP will improve
compilation coverage.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/backlight/pwm_bl.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index f9ef067..33503ce 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -667,8 +667,7 @@ static void pwm_backlight_shutdown(struct platform_device *pdev)
 	pwm_backlight_power_off(pb);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pwm_backlight_suspend(struct device *dev)
+static int __maybe_unused pwm_bl_suspend(struct device *dev)
 {
 	struct backlight_device *bl = dev_get_drvdata(dev);
 	struct pwm_bl_data *pb = bl_get_data(bl);
@@ -684,7 +683,7 @@ static int pwm_backlight_suspend(struct device *dev)
 	return 0;
 }
 
-static int pwm_backlight_resume(struct device *dev)
+static int __maybe_unused pwm_bl_resume(struct device *dev)
 {
 	struct backlight_device *bl = dev_get_drvdata(dev);
 
@@ -692,21 +691,13 @@ static int pwm_backlight_resume(struct device *dev)
 
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
-		.pm		= &pwm_backlight_pm_ops,
+		.pm		= &pwm_bl_pm_ops,
 		.of_match_table	= of_match_ptr(pwm_backlight_of_match),
 	},
 	.probe		= pwm_backlight_probe,
-- 
2.10.2
