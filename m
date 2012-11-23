From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 23 Nov 2012 16:35:13 +0000
Subject: [PATCH 3/5] ARM: mach-shmobile: mackerel: Use gpio-backlight
Message-Id: <1353688515-30458-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Replace the backlight callback with a gpio-backlight platform device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   34 +++++++++++++++---------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index bfd2dc8..ea35727 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -48,7 +48,7 @@
 #include <linux/tca6416_keypad.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/dma-mapping.h>
-
+#include <video/gpio_backlight.h>
 #include <video/sh_mobile_hdmi.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
@@ -347,7 +347,7 @@ static struct platform_device meram_device = {
 	},
 };
 
-/* LCDC */
+/* LCDC and backlight */
 static struct fb_videomode mackerel_lcdc_modes[] = {
 	{
 		.name		= "WVGA Panel",
@@ -363,13 +363,6 @@ static struct fb_videomode mackerel_lcdc_modes[] = {
 	},
 };
 
-static int mackerel_set_brightness(int brightness)
-{
-	gpio_set_value(GPIO_PORT31, brightness);
-
-	return 0;
-}
-
 static const struct sh_mobile_meram_cfg lcd_meram_cfg = {
 	.icb[0] = {
 		.meram_size     = 0x40,
@@ -394,11 +387,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.width		= 152,
 			.height		= 91,
 		},
-		.bl_info = {
-			.name = "sh_mobile_lcdc_bl",
-			.max_brightness = 1,
-			.set_brightness = mackerel_set_brightness,
-		},
 		.meram_cfg = &lcd_meram_cfg,
 	}
 };
@@ -426,6 +414,20 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+static struct gpio_backlight_platform_data gpio_backlight_data = {
+	.fbdev = &lcdc_device.dev,
+	.gpio = GPIO_PORT31,
+	.def_value = 1,
+	.name = "backlight",
+};
+
+static struct platform_device gpio_backlight_device = {
+	.name = "gpio-backlight",
+	.dev = {
+		.platform_data = &gpio_backlight_data,
+	},
+};
+
 /* HDMI */
 static struct sh_mobile_hdmi_info hdmi_info = {
 	.flags		= HDMI_SND_SRC_SPDIF,
@@ -1322,6 +1324,7 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
 	&lcdc_device,
+	&gpio_backlight_device,
 	&usbhs0_device,
 	&usbhs1_device,
 	&leds_device,
@@ -1472,9 +1475,6 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_LCDDISP,  NULL);
 	gpio_request(GPIO_FN_LCDDCK,   NULL);
 
-	gpio_request(GPIO_PORT31, NULL); /* backlight */
-	gpio_direction_output(GPIO_PORT31, 0); /* off by default */
-
 	gpio_request(GPIO_PORT151, NULL); /* LCDDON */
 	gpio_direction_output(GPIO_PORT151, 1);
 
-- 
1.7.8.6

