From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jul 2019 13:44:17 +0000
Subject: [PATCH v2 3/9] ARM: davinci: da850-evm: model the backlight GPIO as an actual device
Message-Id: <20190722134423.26555-4-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722134423.26555-1-brgl@bgdev.pl>
In-Reply-To: <20190722134423.26555-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Instead of enabling the panel backlight in a callback defined in board
file using deprecated legacy GPIO API calls, model the line as a GPIO
backlight device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-davinci/board-da850-evm.c | 40 +++++++++++++++++--------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 0628e7d7dcf3..ac05d4838f1e 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -36,6 +36,7 @@
 #include <linux/platform_data/ti-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/uio_pruss.h>
+#include <linux/property.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/tps6507x.h>
 #include <linux/regulator/fixed.h>
@@ -804,34 +805,49 @@ static const short da850_evm_mmcsd0_pins[] __initconst = {
 
 static void da850_panel_power_ctrl(int val)
 {
-	/* lcd backlight */
-	gpio_set_value(DA850_LCD_BL_PIN, val);
-
 	/* lcd power */
 	gpio_set_value(DA850_LCD_PWR_PIN, val);
 }
 
+static struct property_entry da850_lcd_backlight_props[] = {
+	PROPERTY_ENTRY_BOOL("default-on"),
+	{ }
+};
+
+static struct gpiod_lookup_table da850_lcd_backlight_gpio_table = {
+	.dev_id		= "gpio-backlight",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", DA850_LCD_BL_PIN, NULL, 0),
+		{ }
+	},
+};
+
+static const struct platform_device_info da850_lcd_backlight_info = {
+	.name		= "gpio-backlight",
+	.id		= PLATFORM_DEVID_NONE,
+	.properties	= da850_lcd_backlight_props,
+};
+
 static int da850_lcd_hw_init(void)
 {
+	struct platform_device *backlight;
 	int status;
 
-	status = gpio_request(DA850_LCD_BL_PIN, "lcd bl");
-	if (status < 0)
-		return status;
+	gpiod_add_lookup_table(&da850_lcd_backlight_gpio_table);
+	backlight = platform_device_register_full(&da850_lcd_backlight_info);
+	if (IS_ERR(backlight))
+		return PTR_ERR(backlight);
 
 	status = gpio_request(DA850_LCD_PWR_PIN, "lcd pwr");
-	if (status < 0) {
-		gpio_free(DA850_LCD_BL_PIN);
+	if (status < 0)
 		return status;
-	}
 
-	gpio_direction_output(DA850_LCD_BL_PIN, 0);
 	gpio_direction_output(DA850_LCD_PWR_PIN, 0);
 
-	/* Switch off panel power and backlight */
+	/* Switch off panel power */
 	da850_panel_power_ctrl(0);
 
-	/* Switch on panel power and backlight */
+	/* Switch on panel power */
 	da850_panel_power_ctrl(1);
 
 	return 0;
-- 
2.21.0
