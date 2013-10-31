From: Johan Hovold <jhovold@gmail.com>
Date: Thu, 31 Oct 2013 17:57:39 +0000
Subject: [PATCH v3 4/9] backlight: atmel-pwm-bl: clean up probe error handling
Message-Id: <1383242264-7652-5-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383064064-4983-1-git-send-email-jhovold@gmail.com>
 <1383242264-7652-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1383242264-7652-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Clean up probe error handling by checking parameters before any
allocations and removing an obsolete error label. Also remove
unnecessary reset of private gpio number.

Acked-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/video/backlight/atmel-pwm-bl.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/video/backlight/atmel-pwm-bl.c b/drivers/video/backlight/atmel-pwm-bl.c
index 4886028..01af5c2 100644
--- a/drivers/video/backlight/atmel-pwm-bl.c
+++ b/drivers/video/backlight/atmel-pwm-bl.c
@@ -126,40 +126,33 @@ static int atmel_pwm_bl_probe(struct platform_device *pdev)
 	struct atmel_pwm_bl *pwmbl;
 	int retval;
 
+	pdata = dev_get_platdata(&pdev->dev);
+	if (!pdata)
+		return -ENODEV;
+
+	if (pdata->pwm_compare_max < pdata->pwm_duty_max ||
+			pdata->pwm_duty_min > pdata->pwm_duty_max ||
+			pdata->pwm_frequency = 0)
+		return -EINVAL;
+
 	pwmbl = devm_kzalloc(&pdev->dev, sizeof(struct atmel_pwm_bl),
 				GFP_KERNEL);
 	if (!pwmbl)
 		return -ENOMEM;
 
 	pwmbl->pdev = pdev;
-
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		retval = -ENODEV;
-		goto err_free_mem;
-	}
-
-	if (pdata->pwm_compare_max < pdata->pwm_duty_max ||
-			pdata->pwm_duty_min > pdata->pwm_duty_max ||
-			pdata->pwm_frequency = 0) {
-		retval = -EINVAL;
-		goto err_free_mem;
-	}
-
 	pwmbl->pdata = pdata;
 	pwmbl->gpio_on = pdata->gpio_on;
 
 	retval = pwm_channel_alloc(pdata->pwm_channel, &pwmbl->pwmc);
 	if (retval)
-		goto err_free_mem;
+		return retval;
 
 	if (pwmbl->gpio_on != -1) {
 		retval = devm_gpio_request(&pdev->dev, pwmbl->gpio_on,
 					"gpio_atmel_pwm_bl");
-		if (retval) {
-			pwmbl->gpio_on = -1;
+		if (retval)
 			goto err_free_pwm;
-		}
 
 		/* Turn display off by default. */
 		retval = gpio_direction_output(pwmbl->gpio_on,
@@ -197,7 +190,7 @@ static int atmel_pwm_bl_probe(struct platform_device *pdev)
 
 err_free_pwm:
 	pwm_channel_free(&pwmbl->pwmc);
-err_free_mem:
+
 	return retval;
 }
 
-- 
1.8.4.2

