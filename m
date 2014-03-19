From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Wed, 19 Mar 2014 13:03:14 +0000
Subject: [PATCH 01/16] ARM: at91: at91sam9g45: switch to generic PWM framework
Message-Id: <1395234209-15546-2-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Switch to the pwm/pwm-atmel driver instead of misc/atmel_pwm

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9g45.c         |  1 +
 arch/arm/mach-at91/at91sam9g45_devices.c | 11 ++---------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 3c519a7a938f..2d3c6e1ac158 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -250,6 +250,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID(NULL, "atmel_sha", &aestdessha_clk),
 	CLKDEV_CON_DEV_ID(NULL, "atmel_tdes", &aestdessha_clk),
 	CLKDEV_CON_DEV_ID(NULL, "atmel_aes", &aestdessha_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91sam9rl-pwm", &pwm_clk),
 	/* more usart lookup table for DT entries */
 	CLKDEV_CON_DEV_ID("usart", "ffffee00.serial", &mck),
 	CLKDEV_CON_DEV_ID("usart", "fff8c000.serial", &usart0_clk),
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 87135a61357d..25ba920cbe84 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1332,9 +1332,7 @@ static void __init at91_add_device_watchdog(void) {}
  *  PWM
  * --------------------------------------------------------------------*/
 
-#if defined(CONFIG_ATMEL_PWM) || defined(CONFIG_ATMEL_PWM_MODULE)
-static u32 pwm_mask;
-
+#if IS_ENABLED(CONFIG_PWM_ATMEL)
 static struct resource pwm_resources[] = {
 	[0] = {
 		.start	= AT91SAM9G45_BASE_PWMC,
@@ -1349,11 +1347,8 @@ static struct resource pwm_resources[] = {
 };
 
 static struct platform_device at91sam9g45_pwm0_device = {
-	.name	= "atmel_pwm",
+	.name	= "at91sam9rl-pwm",
 	.id	= -1,
-	.dev	= {
-		.platform_data		= &pwm_mask,
-	},
 	.resource	= pwm_resources,
 	.num_resources	= ARRAY_SIZE(pwm_resources),
 };
@@ -1372,8 +1367,6 @@ void __init at91_add_device_pwm(u32 mask)
 	if (mask & (1 << AT91_PWM3))
 		at91_set_B_periph(AT91_PIN_PD0, 1);	/* enable PWM3 */
 
-	pwm_mask = mask;
-
 	platform_device_register(&at91sam9g45_pwm0_device);
 }
 #else
-- 
1.8.3.2

