From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 23 Nov 2012 16:35:15 +0000
Subject: [PATCH 5/5] sh: kfr2r09: Use lv5207lp backlight
Message-Id: <1353688515-30458-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Replace the backlight callback with a lv5207lp backlight platform
device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |   48 ---------------------------
 arch/sh/boards/mach-kfr2r09/setup.c         |   19 ++++++++---
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |    2 -
 3 files changed, 14 insertions(+), 55 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c b/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
index c620503..355a78a 100644
--- a/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
+++ b/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
@@ -276,51 +276,3 @@ void kfr2r09_lcd_start(void *sohandle, struct sh_mobile_lcdc_sys_bus_ops *so)
 {
 	write_memory_start(sohandle, so);
 }
-
-#define CTRL_CKSW       0x10
-#define CTRL_C10        0x20
-#define CTRL_CPSW       0x80
-#define MAIN_MLED4      0x40
-#define MAIN_MSW        0x80
-
-int kfr2r09_lcd_set_brightness(int brightness)
-{
-	struct i2c_adapter *a;
-	struct i2c_msg msg;
-	unsigned char buf[2];
-	int ret;
-
-	a = i2c_get_adapter(0);
-	if (!a)
-		return -ENODEV;
-
-	buf[0] = 0x00;
-	if (brightness)
-		buf[1] = CTRL_CPSW | CTRL_C10 | CTRL_CKSW;
-	else
-		buf[1] = 0;
-
-	msg.addr = 0x75;
-	msg.buf = buf;
-	msg.len = 2;
-	msg.flags = 0;
-	ret = i2c_transfer(a, &msg, 1);
-	if (ret != 1)
-		return -ENODEV;
-
-	buf[0] = 0x01;
-	if (brightness)
-		buf[1] = MAIN_MSW | MAIN_MLED4 | 0x0c;
-	else
-		buf[1] = 0;
-
-	msg.addr = 0x75;
-	msg.buf = buf;
-	msg.len = 2;
-	msg.flags = 0;
-	ret = i2c_transfer(a, &msg, 1);
-	if (ret != 1)
-		return -ENODEV;
-
-	return 0;
-}
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index ab502f12..1df4398 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -21,6 +21,7 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/i2c.h>
+#include <linux/platform_data/lv5207lp.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/usb/r8a66597.h>
@@ -159,11 +160,6 @@ static struct sh_mobile_lcdc_info kfr2r09_sh_lcdc_info = {
 			.setup_sys = kfr2r09_lcd_setup,
 			.start_transfer = kfr2r09_lcd_start,
 		},
-		.bl_info = {
-			.name = "sh_mobile_lcdc_bl",
-			.max_brightness = 1,
-			.set_brightness = kfr2r09_lcd_set_brightness,
-		},
 		.sys_bus_cfg = {
 			.ldmt2r = 0x07010904,
 			.ldmt3r = 0x14012914,
@@ -195,6 +191,17 @@ static struct platform_device kfr2r09_sh_lcdc_device = {
 	},
 };
 
+static struct lv5207lp_platform_data kfr2r09_backlight_data = {
+	.fbdev = &kfr2r09_sh_lcdc_device.dev,
+	.def_value = 13,
+	.max_value = 13,
+};
+
+static struct i2c_board_info kfr2r09_backlight_board_info = {
+	I2C_BOARD_INFO("lv5207lp", 0x75),
+	.platform_data = &kfr2r09_backlight_data,
+};
+
 static struct r8a66597_platdata kfr2r09_usb0_gadget_data = {
 	.on_chip = 1,
 };
@@ -627,6 +634,8 @@ static int __init kfr2r09_devices_setup(void)
 	gpio_request(GPIO_FN_SDHI0CMD, NULL);
 	gpio_request(GPIO_FN_SDHI0CLK, NULL);
 
+	i2c_register_board_info(0, &kfr2r09_backlight_board_info, 1);
+
 	return platform_add_devices(kfr2r09_devices,
 				    ARRAY_SIZE(kfr2r09_devices));
 }
diff --git a/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h b/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h
index c20c9e5..79f154e 100644
--- a/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h
+++ b/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h
@@ -4,13 +4,11 @@
 #include <video/sh_mobile_lcdc.h>
 
 #if defined(CONFIG_FB_SH_MOBILE_LCDC) || defined(CONFIG_FB_SH_MOBILE_LCDC_MODULE)
-int kfr2r09_lcd_set_brightness(int brightness);
 int kfr2r09_lcd_setup(void *sys_ops_handle,
 		      struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 void kfr2r09_lcd_start(void *sys_ops_handle,
 		       struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 #else
-static int kfr2r09_lcd_set_brightness(int brightness) {}
 static int kfr2r09_lcd_setup(void *sys_ops_handle,
 				struct sh_mobile_lcdc_sys_bus_ops *sys_ops)
 {
-- 
1.7.8.6

