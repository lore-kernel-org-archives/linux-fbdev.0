From: Johan Hovold <jhovold@gmail.com>
Date: Tue, 22 Oct 2013 17:26:57 +0000
Subject: [PATCH 7/9] backlight: atmel-pwm-bl: use gpio_is_valid
Message-Id: <1382462819-28576-8-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382462819-28576-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382462819-28576-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Use gpio_is_valid rather than open coding the more restrictive != -1
test.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/video/backlight/atmel-pwm-bl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/atmel-pwm-bl.c b/drivers/video/backlight/atmel-pwm-bl.c
index db68cab..ffc30d2 100644
--- a/drivers/video/backlight/atmel-pwm-bl.c
+++ b/drivers/video/backlight/atmel-pwm-bl.c
@@ -48,7 +48,7 @@ static int atmel_pwm_bl_set_intensity(struct backlight_device *bd)
 		pwm_duty = pwmbl->pdata->pwm_duty_min;
 
 	if (!intensity) {
-		if (pwmbl->gpio_on != -1) {
+		if (gpio_is_valid(pwmbl->gpio_on)) {
 			gpio_set_value(pwmbl->gpio_on,
 					0 ^ pwmbl->pdata->on_active_low);
 		}
@@ -57,7 +57,7 @@ static int atmel_pwm_bl_set_intensity(struct backlight_device *bd)
 	} else {
 		pwm_channel_enable(&pwmbl->pwmc);
 		pwm_channel_writel(&pwmbl->pwmc, PWM_CUPD, pwm_duty);
-		if (pwmbl->gpio_on != -1) {
+		if (gpio_is_valid(pwmbl->gpio_on)) {
 			gpio_set_value(pwmbl->gpio_on,
 					1 ^ pwmbl->pdata->on_active_low);
 		}
@@ -146,7 +146,7 @@ static int atmel_pwm_bl_probe(struct platform_device *pdev)
 	if (retval)
 		return retval;
 
-	if (pwmbl->gpio_on != -1) {
+	if (gpio_is_valid(pwmbl->gpio_on)) {
 		retval = devm_gpio_request(&pdev->dev, pwmbl->gpio_on,
 					"gpio_atmel_pwm_bl");
 		if (retval)
@@ -196,7 +196,7 @@ static int atmel_pwm_bl_remove(struct platform_device *pdev)
 {
 	struct atmel_pwm_bl *pwmbl = platform_get_drvdata(pdev);
 
-	if (pwmbl->gpio_on != -1) {
+	if (gpio_is_valid(pwmbl->gpio_on)) {
 		gpio_set_value(pwmbl->gpio_on,
 					0 ^ pwmbl->pdata->on_active_low);
 	}
-- 
1.8.4

