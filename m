From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 14 Apr 2014 21:59:52 +0000
Subject: [PATCHv2 10/11] leds: leds-pwm: retrieve configured pwm period
Message-Id: <1397512793-10325-11-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The PWM core is now able to initialize the PWM period. Use it and if it is not
configured, use the supplied pwm_period_ns.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/leds/leds-pwm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 7d0aaed1e23a..aa770ec1e892 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -181,7 +181,6 @@ static int led_pwm_probe(struct platform_device *pdev)
 			led_dat->cdev.name = cur_led->name;
 			led_dat->cdev.default_trigger = cur_led->default_trigger;
 			led_dat->active_low = cur_led->active_low;
-			led_dat->period = cur_led->pwm_period_ns;
 			led_dat->cdev.brightness_set = led_pwm_set;
 			led_dat->cdev.brightness = LED_OFF;
 			led_dat->cdev.max_brightness = cur_led->max_brightness;
@@ -191,6 +190,10 @@ static int led_pwm_probe(struct platform_device *pdev)
 			if (led_dat->can_sleep)
 				INIT_WORK(&led_dat->work, led_pwm_work);
 
+			led_dat->period = pwm_get_period(led_dat->pwm);
+			if (!led_dat->period && (cur_led->pwm_period_ns > 0))
+				led_dat->period = cur_led->pwm_period_ns;
+
 			ret = led_classdev_register(&pdev->dev, &led_dat->cdev);
 			if (ret < 0)
 				goto err;
-- 
1.8.3.2

