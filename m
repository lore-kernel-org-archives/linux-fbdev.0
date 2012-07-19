From: Donghwa Lee <dh09.lee@samsung.com>
Date: Thu, 19 Jul 2012 00:43:33 +0000
Subject: [PATCH] video: ld9040: support early fb event of fb_blank()
Message-Id: <50075835.2040703@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <500757AE.3010202@samsung.com>
In-Reply-To: <500757AE.3010202@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch supports early fb event of fb_blank().

- In case of lcd power off : call early_set_power() interface and lcd
power is off. And then framebuffer is blanked.

- In case of lcd power on : First, framebuffer is unblanked, and then
call set_power() interface to turn lcd on.

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/backlight/ld9040.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/drivers/video/backlight/ld9040.c b/drivers/video/backlight/ld9040.c
index efd352b..221c843 100644
--- a/drivers/video/backlight/ld9040.c
+++ b/drivers/video/backlight/ld9040.c
@@ -642,17 +642,50 @@ static int ld9040_power(struct ld9040 *lcd, int power)
 	return ret;
 }
 
+static int ld9040_early_set_power(struct lcd_device *ld, int power)
+{
+	struct ld9040 *lcd = lcd_get_data(ld);
+	int ret = 0;
+
+	if (power != FB_BLANK_UNBLANK && power != FB_BLANK_POWERDOWN &&
+		power != FB_BLANK_NORMAL) {
+		dev_err(lcd->dev, "power value should be 0, 1 or 4.\n");
+
+		return -EINVAL;
+	}
+
+	if (!power_is_on(power) && power_is_on(lcd->power)) {
+		ret = ld9040_power(lcd, power);
+		if (!ret)
+			lcd->power = power;
+	}
+
+	return ret;
+}
+
 static int ld9040_set_power(struct lcd_device *ld, int power)
 {
 	struct ld9040 *lcd = lcd_get_data(ld);
+	struct backlight_device *bd = lcd->bd;
+	int ret = 0;
 
 	if (power != FB_BLANK_UNBLANK && power != FB_BLANK_POWERDOWN &&
 		power != FB_BLANK_NORMAL) {
 		dev_err(lcd->dev, "power value should be 0, 1 or 4.\n");
+
 		return -EINVAL;
 	}
 
-	return ld9040_power(lcd, power);
+	if (power_is_on(power) && !power_is_on(lcd->power)) {
+		ret = ld9040_power(lcd, power);
+		if (!ret)
+			lcd->power = power;
+
+		ld9040_gamma_ctl(lcd, bd->props.brightness);
+	} else
+		ld9040_early_set_power(ld, power);
+
+	return ret;
 }
 
 static int ld9040_get_power(struct lcd_device *ld)
@@ -689,6 +722,7 @@ static int ld9040_set_brightness(struct backlight_device *bd)
 }
 
 static struct lcd_ops ld9040_lcd_ops = {
+	.early_set_power = ld9040_early_set_power,
 	.set_power = ld9040_set_power,
 	.get_power = ld9040_get_power,
 };
-- 
1.7.4.1

