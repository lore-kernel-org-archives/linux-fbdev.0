From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Mon, 26 Mar 2012 08:58:40 +0000
Subject: [PATCH v3 2/2] ARM: Exynos: Use lcd power control driver for lcd panel
Message-Id: <1332751600-11371-3-git-send-email-thomas.abraham@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332751600-11371-1-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1332751600-11371-1-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The Hydis hv070wsa lcd panel used with the Origen board uses a gpio
for reset and the Vcc supply to the panel can be controlled using
a voltage regulator. Switch to using the lcd power control driver
for controlling the power to the lcd panel.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mach-origen.c |   29 ++++++-----------------------
 1 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index d3b2e9d..6c4997c 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -26,7 +26,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
-#include <video/platform_lcd.h>
+#include <video/lcd_pwrctrl.h>
 
 #include <plat/regs-serial.h>
 #include <plat/regs-fb-v4.h>
@@ -129,7 +129,7 @@ static struct regulator_consumer_supply __initdata buck3_consumer[] = {
 	REGULATOR_SUPPLY("vdd_g3d", "mali_drm"), /* G3D */
 };
 static struct regulator_consumer_supply __initdata buck7_consumer[] = {
-	REGULATOR_SUPPLY("vcc", "platform-lcd"), /* LCD */
+	REGULATOR_SUPPLY("vcc-lcd", "lcd-pwrctrl.0"), /* LCD */
 };
 
 static struct regulator_init_data __initdata max8997_ldo1_data = {
@@ -384,7 +384,7 @@ static struct regulator_init_data __initdata max8997_buck7_data = {
 		.name		= "VDD_LCD_3.3V",
 		.min_uV		= 3300000,
 		.max_uV		= 3300000,
-		.boot_on	= 1,
+		.boot_on	= 0,
 		.apply_uV	= 1,
 		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
 		.state_mem	= {
@@ -553,29 +553,12 @@ static struct platform_device origen_device_gpiokeys = {
 	},
 };
 
-static void lcd_hv070wsa_set_power(struct plat_lcd_data *pd, unsigned int power)
-{
-	int ret;
-
-	if (power)
-		ret = gpio_request_one(EXYNOS4_GPE3(4),
-					GPIOF_OUT_INIT_HIGH, "GPE3_4");
-	else
-		ret = gpio_request_one(EXYNOS4_GPE3(4),
-					GPIOF_OUT_INIT_LOW, "GPE3_4");
-
-	gpio_free(EXYNOS4_GPE3(4));
-
-	if (ret)
-		pr_err("failed to request gpio for LCD power: %d\n", ret);
-}
-
-static struct plat_lcd_data origen_lcd_hv070wsa_data = {
-	.set_power = lcd_hv070wsa_set_power,
+static struct lcd_pwrctrl_data origen_lcd_hv070wsa_data = {
+	.gpio	= EXYNOS4_GPE3(4),
 };
 
 static struct platform_device origen_lcd_hv070wsa = {
-	.name			= "platform-lcd",
+	.name			= "lcd-pwrctrl",
 	.dev.parent		= &s5p_device_fimd0.dev,
 	.dev.platform_data	= &origen_lcd_hv070wsa_data,
 };
-- 
1.6.6.rc2

