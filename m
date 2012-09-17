From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 17 Sep 2012 06:32:47 +0000
Subject: [PATCH Re-send] pwm-backlight: Use devm_pwm_get in pwm_bl.c
Message-Id: <1347862847-2774-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This file already makes use of device managed functions.
Convert pwm_get() too to use it.

Cc: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/backlight/pwm_bl.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 4965408..0c91023 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -218,7 +218,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->exit = data->exit;
 	pb->dev = &pdev->dev;
 
-	pb->pwm = pwm_get(&pdev->dev, NULL);
+	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pb->pwm)) {
 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
 
@@ -251,7 +251,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	if (IS_ERR(bl)) {
 		dev_err(&pdev->dev, "failed to register backlight\n");
 		ret = PTR_ERR(bl);
-		goto err_bl;
+		goto err_alloc;
 	}
 
 	bl->props.brightness = data->dft_brightness;
@@ -260,8 +260,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, bl);
 	return 0;
 
-err_bl:
-	pwm_put(pb->pwm);
 err_alloc:
 	if (data->exit)
 		data->exit(&pdev->dev);
@@ -276,7 +274,6 @@ static int pwm_backlight_remove(struct platform_device *pdev)
 	backlight_device_unregister(bl);
 	pwm_config(pb->pwm, 0, pb->period);
 	pwm_disable(pb->pwm);
-	pwm_put(pb->pwm);
 	if (pb->exit)
 		pb->exit(&pdev->dev);
 	return 0;
-- 
1.7.4.1

