From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Wed, 28 May 2014 23:20:05 +0000
Subject: [PATCHv2 02/15] ARM: at91: sam9m10g45ek: use generic leds_pwm driver
Message-Id: <1401319218-16772-3-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401319218-16772-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1401319218-16772-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Switch to the generic leds_pwm driver instead of leds-atmel-pwm.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-sam9m10g45ek.c | 42 ++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 1ea61328f30d..b227732b0c83 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -26,6 +26,8 @@
 #include <linux/leds.h>
 #include <linux/atmel-mci.h>
 #include <linux/delay.h>
+#include <linux/pwm.h>
+#include <linux/leds_pwm.h>
 
 #include <linux/platform_data/at91_adc.h>
 
@@ -416,7 +418,7 @@ static struct gpio_led ek_leds[] = {
 		.active_low		= 1,
 		.default_trigger	= "nand-disk",
 	},
-#if !(defined(CONFIG_LEDS_ATMEL_PWM) || defined(CONFIG_LEDS_ATMEL_PWM_MODULE))
+#if !IS_ENABLED(CONFIG_LEDS_PWM)
 	{	/* "right" led, green, userled1, pwm1 */
 		.name			= "d7",
 		.gpio			= AT91_PIN_PD31,
@@ -430,22 +432,41 @@ static struct gpio_led ek_leds[] = {
 /*
  * PWM Leds
  */
-static struct gpio_led ek_pwm_led[] = {
-#if defined(CONFIG_LEDS_ATMEL_PWM) || defined(CONFIG_LEDS_ATMEL_PWM_MODULE)
+static struct pwm_lookup pwm_lookup[] = {
+	PWM_LOOKUP("at91sam9rl-pwm", 1, "leds_pwm", "d7",
+		   5000, PWM_POLARITY_INVERSED),
+};
+
+#if IS_ENABLED(CONFIG_LEDS_PWM)
+static struct led_pwm pwm_leds[] = {
 	{	/* "right" led, green, userled1, pwm1 */
-		.name			= "d7",
-		.gpio			= 1,	/* is PWM channel number */
-		.active_low		= 1,
-		.default_trigger	= "none",
+		.name = "d7",
+		.max_brightness	= 255,
 	},
-#endif
 };
 
+static struct led_pwm_platform_data pwm_data = {
+	.num_leds	= ARRAY_SIZE(pwm_leds),
+	.leds		= pwm_leds,
+};
+
+static struct platform_device leds_pwm = {
+	.name	= "leds_pwm",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pwm_data,
+	},
+};
+#endif
+
 static struct platform_device *devices[] __initdata = {
 #if defined(CONFIG_SOC_CAMERA_OV2640) || \
 	defined(CONFIG_SOC_CAMERA_OV2640_MODULE)
 	&isi_ov2640,
 #endif
+#if IS_ENABLED(CONFIG_LEDS_PWM)
+	&leds_pwm,
+#endif
 };
 
 static void __init ek_board_init(void)
@@ -486,7 +507,10 @@ static void __init ek_board_init(void)
 	at91_add_device_ac97(&ek_ac97_data);
 	/* LEDs */
 	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
-	at91_pwm_leds(ek_pwm_led, ARRAY_SIZE(ek_pwm_led));
+	pwm_add_table(pwm_lookup, ARRAY_SIZE(pwm_lookup));
+#if IS_ENABLED(CONFIG_LEDS_PWM)
+	at91_add_device_pwm(1 << AT91_PWM1);
+#endif
 	/* Other platform devices */
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
-- 
1.9.1

