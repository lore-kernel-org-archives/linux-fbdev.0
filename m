From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 23 Nov 2012 16:35:14 +0000
Subject: [PATCH 4/5] sh: ecovec24: Use gpio-backlight
Message-Id: <1353688515-30458-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Replace the backlight callback with a gpio-backlight platform device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   37 ++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 3fede45..865f765 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -33,6 +33,7 @@
 #include <linux/sh_eth.h>
 #include <linux/sh_intc.h>
 #include <linux/videodev2.h>
+#include <video/gpio_backlight.h>
 #include <video/sh_mobile_lcdc.h>
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
@@ -291,7 +292,7 @@ static struct platform_device usbhs_device = {
 	.resource	= usbhs_resources,
 };
 
-/* LCDC */
+/* LCDC and backlight */
 static const struct fb_videomode ecovec_lcd_modes[] = {
 	{
 		.name		= "Panel",
@@ -322,13 +323,6 @@ static const struct fb_videomode ecovec_dvi_modes[] = {
 	},
 };
 
-static int ecovec24_set_brightness(int brightness)
-{
-	gpio_set_value(GPIO_PTR1, brightness);
-
-	return 0;
-}
-
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.ch[0] = {
 		.interface_type = RGB18,
@@ -338,11 +332,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.width = 152,
 			.height = 91,
 		},
-		.bl_info = {
-			.name = "sh_mobile_lcdc_bl",
-			.max_brightness = 1,
-			.set_brightness = ecovec24_set_brightness,
-		},
 	}
 };
 
@@ -368,6 +357,20 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+static struct gpio_backlight_platform_data gpio_backlight_data = {
+	.fbdev = &lcdc_device.dev,
+	.gpio = GPIO_PTR1,
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
 /* CEU0 */
 static struct sh_mobile_ceu_info sh_mobile_ceu0_info = {
 	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
@@ -1046,6 +1049,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&usb1_common_device,
 	&usbhs_device,
 	&lcdc_device,
+	&gpio_backlight_device,
 	&ceu0_device,
 	&ceu1_device,
 	&keysc_device,
@@ -1236,11 +1240,9 @@ static int __init arch_setup(void)
 
 	gpio_request(GPIO_PTE6, NULL);
 	gpio_request(GPIO_PTU1, NULL);
-	gpio_request(GPIO_PTR1, NULL);
 	gpio_request(GPIO_PTA2, NULL);
 	gpio_direction_input(GPIO_PTE6);
 	gpio_direction_output(GPIO_PTU1, 0);
-	gpio_direction_output(GPIO_PTR1, 0);
 	gpio_direction_output(GPIO_PTA2, 0);
 
 	/* I/O buffer drive ability is high */
@@ -1253,6 +1255,9 @@ static int __init arch_setup(void)
 		lcdc_info.ch[0].lcd_modes		= ecovec_dvi_modes;
 		lcdc_info.ch[0].num_modes		= ARRAY_SIZE(ecovec_dvi_modes);
 
+		/* No backlight */
+		gpio_backlight_data.fbdev = NULL;
+
 		gpio_set_value(GPIO_PTA2, 1);
 		gpio_set_value(GPIO_PTU1, 1);
 	} else {
@@ -1262,8 +1267,6 @@ static int __init arch_setup(void)
 		lcdc_info.ch[0].lcd_modes		= ecovec_lcd_modes;
 		lcdc_info.ch[0].num_modes		= ARRAY_SIZE(ecovec_lcd_modes);
 
-		gpio_set_value(GPIO_PTR1, 1);
-
 		/* FIXME
 		 *
 		 * LCDDON control is needed for Panel,
-- 
1.7.8.6

