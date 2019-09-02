From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 02 Sep 2019 12:34:38 +0000
Subject: [RESEND PATCH v3 1/7] sh: ecovec24: add additional properties to the backlight device
Message-Id: <20190902123444.19924-2-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190902123444.19924-1-brgl@bgdev.pl>
In-Reply-To: <20190902123444.19924-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a GPIO lookup entry and a device property for GPIO backlight to the
board file. Tie them to the platform device which is now registered using
platform_device_register_full() because of the properties. These changes
are inactive now but will be used once the gpio backlight driver is
modified.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/sh/boards/mach-ecovec24/setup.c | 30 +++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index f402aa741bf3..6926bb3865b9 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -371,6 +371,19 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+static struct gpiod_lookup_table gpio_backlight_lookup = {
+	.dev_id		= "gpio-backlight.0",
+	.table = {
+		GPIO_LOOKUP("sh7724_pfc", GPIO_PTR1, NULL, GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
+static struct property_entry gpio_backlight_props[] = {
+	PROPERTY_ENTRY_BOOL("default-on"),
+	{ }
+};
+
 static struct gpio_backlight_platform_data gpio_backlight_data = {
 	.fbdev = &lcdc_device.dev,
 	.gpio = GPIO_PTR1,
@@ -378,13 +391,15 @@ static struct gpio_backlight_platform_data gpio_backlight_data = {
 	.name = "backlight",
 };
 
-static struct platform_device gpio_backlight_device = {
+static const struct platform_device_info gpio_backlight_device_info = {
 	.name = "gpio-backlight",
-	.dev = {
-		.platform_data = &gpio_backlight_data,
-	},
+	.data = &gpio_backlight_data,
+	.size_data = sizeof(gpio_backlight_data),
+	.properties = gpio_backlight_props,
 };
 
+static struct platform_device *gpio_backlight_device;
+
 /* CEU0 */
 static struct ceu_platform_data ceu0_pdata = {
 	.num_subdevs			= 2,
@@ -1006,7 +1021,6 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&usb1_common_device,
 	&usbhs_device,
 	&lcdc_device,
-	&gpio_backlight_device,
 	&keysc_device,
 	&cn12_power,
 #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
@@ -1464,6 +1478,12 @@ static int __init arch_setup(void)
 #endif
 #endif
 
+	gpiod_add_lookup_table(&gpio_backlight_lookup);
+	gpio_backlight_device = platform_device_register_full(
+					&gpio_backlight_device_info);
+	if (IS_ERR(gpio_backlight_device))
+		return PTR_ERR(gpio_backlight_device);
+
 	return platform_add_devices(ecovec_devices,
 				    ARRAY_SIZE(ecovec_devices));
 }
-- 
2.21.0
