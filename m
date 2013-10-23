From: Johan Hovold <jhovold@gmail.com>
Date: Wed, 23 Oct 2013 09:55:39 +0000
Subject: [PATCH 5/9] backlight: atmel-pwm-bl: clean up get_intensity
Message-Id: <1382522143-32072-6-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382522143-32072-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382522143-32072-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Clean up get_intensity to increase readability.

Acked-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/video/backlight/atmel-pwm-bl.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/atmel-pwm-bl.c b/drivers/video/backlight/atmel-pwm-bl.c
index 52a8134..504061c 100644
--- a/drivers/video/backlight/atmel-pwm-bl.c
+++ b/drivers/video/backlight/atmel-pwm-bl.c
@@ -70,15 +70,14 @@ static int atmel_pwm_bl_set_intensity(struct backlight_device *bd)
 static int atmel_pwm_bl_get_intensity(struct backlight_device *bd)
 {
 	struct atmel_pwm_bl *pwmbl = bl_get_data(bd);
+	u32 cdty;
 	u32 intensity;
 
-	if (pwmbl->pdata->pwm_active_low) {
-		intensity = pwm_channel_readl(&pwmbl->pwmc, PWM_CDTY) -
-			pwmbl->pdata->pwm_duty_min;
-	} else {
-		intensity = pwmbl->pdata->pwm_duty_max -
-			pwm_channel_readl(&pwmbl->pwmc, PWM_CDTY);
-	}
+	cdty = pwm_channel_readl(&pwmbl->pwmc, PWM_CDTY);
+	if (pwmbl->pdata->pwm_active_low)
+		intensity = cdty - pwmbl->pdata->pwm_duty_min;
+	else
+		intensity = pwmbl->pdata->pwm_duty_max - cdty;
 
 	return (u16)intensity;
 }
-- 
1.8.4

