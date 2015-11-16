From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Mon, 16 Nov 2015 08:56:31 +0000
Subject: [PATCH v4 08/24] leds: pwm: use pwm_get/set_default_xxx() helpers where appropriate
Message-Id: <1447664207-24370-9-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

pwm_set/get_default_xxx() helpers have been introduced to differentiate
the default PWM states (those retrieved through DT, PWM lookup table or
statically assigned by the driver) and the current ones.
Make use of those helpers where appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>
---
 drivers/leds/leds-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 1d07e3e..2c564d1 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -125,7 +125,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	if (led_data->can_sleep)
 		INIT_WORK(&led_data->work, led_pwm_work);
 
-	led_data->period = pwm_get_period(led_data->pwm);
+	led_data->period = pwm_get_default_period(led_data->pwm);
 	if (!led_data->period && (led->pwm_period_ns > 0))
 		led_data->period = led->pwm_period_ns;
 
-- 
2.1.4

