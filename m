From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:52 +0000
Subject: [PATCH 17/19] ARM: mach-shmobile: ag5evm: Use the backlight API for brightness control
Message-Id: <1345122054-16013-18-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Don't hook up brightness control in the display on/off operations, use
the backlight API instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   45 +++++++++++++++++++++-----------
 1 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 7d6b96b..826ac13 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -281,28 +281,38 @@ static unsigned char lcd_backlight_seq[3][2] = {
 	{ 0x03, 0x01 },
 };
 
-static void lcd_backlight_on(void)
+static int lcd_backlight_set_brightness(int brightness)
 {
-	struct i2c_adapter *a;
+	struct i2c_adapter *adap;
 	struct i2c_msg msg;
-	int k;
+	unsigned int i;
+	int ret;
+
+	if (brightness = 0) {
+		/* Reset the chip */
+		gpio_set_value(GPIO_PORT235, 0);
+		mdelay(24);
+		gpio_set_value(GPIO_PORT235, 1);
+		return 0;
+	}
+
+	adap = i2c_get_adapter(1);
+	if (adap = NULL)
+		return -ENODEV;
 
-	a = i2c_get_adapter(1);
-	for (k = 0; a && k < 3; k++) {
+	for (i = 0; i < ARRAY_SIZE(lcd_backlight_seq); i++) {
 		msg.addr = 0x6d;
-		msg.buf = &lcd_backlight_seq[k][0];
+		msg.buf = &lcd_backlight_seq[i][0];
 		msg.len = 2;
 		msg.flags = 0;
-		if (i2c_transfer(a, &msg, 1) != 1)
+
+		ret = i2c_transfer(adap, &msg, 1);
+		if (ret < 0)
 			break;
 	}
-}
 
-static void lcd_backlight_reset(void)
-{
-	gpio_set_value(GPIO_PORT235, 0);
-	mdelay(24);
-	gpio_set_value(GPIO_PORT235, 1);
+	i2c_put_adapter(adap);
+	return ret < 0 ? ret : 0;
 }
 
 /* LCDC0 */
@@ -334,8 +344,11 @@ static struct sh_mobile_lcdc_info lcdc0_info = {
 		.panel_cfg = {
 			.width = 44,
 			.height = 79,
-			.display_on = lcd_backlight_on,
-			.display_off = lcd_backlight_reset,
+		},
+		.bl_info = {
+			.name = "sh_mobile_lcdc_bl",
+			.max_brightness = 1,
+			.set_brightness = lcd_backlight_set_brightness,
 		},
 		.tx_dev = &mipidsi0_device,
 	}
@@ -545,7 +558,7 @@ static void __init ag5evm_init(void)
 	/* LCD backlight controller */
 	gpio_request(GPIO_PORT235, NULL); /* RESET */
 	gpio_direction_output(GPIO_PORT235, 0);
-	lcd_backlight_reset();
+	lcd_backlight_set_brightness(0);
 
 	/* enable SDHI0 on CN15 [SD I/F] */
 	gpio_request(GPIO_FN_SDHIWP0, NULL);
-- 
1.7.8.6

