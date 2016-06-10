From: Brian Norris <briannorris@chromium.org>
Date: Fri, 10 Jun 2016 16:28:45 +0000
Subject: [PATCH] backlight: lp855x: Add enable regulator
Message-Id: <1465576125-118369-1-git-send-email-briannorris@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Milo Kim <milo.kim@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Stephen Barber <smbarber@chromium.org>, Doug Anderson <dianders@chromium.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Brian Norris <briannorris@chromium.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

The LP8556 datasheet describes an EN/VDDIO input, which serves "both as
a chip enable and as a power supply reference for PWM, SDA, and SCL
inputs." The LP8556 that I'm testing doesn't respond properly if I try
to talk I2C to it too quickly after enabling VDDIO, and the LP8555
datasheet mentions a t_RESPONSE delay of up to 1 millisecond.

Support this EN/VDDIO by adding a regulator property to the binding;
enabling this regulator at probe time; and sleeping for 1 to 2ms, if the
EN/VDDIO regulator was provided.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 .../devicetree/bindings/leds/backlight/lp855x.txt  |  2 ++
 drivers/video/backlight/lp855x_bl.c                | 29 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/lp855x.txt b/Documentation/devicetree/bindings/leds/backlight/lp855x.txt
index 0a3ecbc3a1b9..88f56641fc28 100644
--- a/Documentation/devicetree/bindings/leds/backlight/lp855x.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/lp855x.txt
@@ -13,6 +13,7 @@ Optional properties:
   - rom-addr: Register address of ROM area to be updated (u8)
   - rom-val: Register value to be updated (u8)
   - power-supply: Regulator which controls the 3V rail
+  - enable-supply: Regulator which controls the EN/VDDIO input
 
 Example:
 
@@ -57,6 +58,7 @@ Example:
 	backlight@2c {
 		compatible = "ti,lp8557";
 		reg = <0x2c>;
+		enable-supply = <&backlight_vddio>;
 		power-supply = <&backlight_vdd>;
 
 		dev-ctrl = /bits/ 8 <0x41>;
diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index e5b14f52628f..7e1f9a78674e 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/backlight.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/platform_data/lp855x.h>
@@ -74,6 +75,7 @@ struct lp855x {
 	struct lp855x_platform_data *pdata;
 	struct pwm_device *pwm;
 	struct regulator *supply;	/* regulator for VDD input */
+	struct regulator *enable;	/* regulator for EN/VDDIO input */
 };
 
 static int lp855x_write_byte(struct lp855x *lp, u8 reg, u8 data)
@@ -433,6 +435,19 @@ static int lp855x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 		lp->supply = NULL;
 	}
 
+	lp->enable = devm_regulator_get_optional(lp->dev, "enable");
+	if (IS_ERR(lp->enable)) {
+		ret = PTR_ERR(lp->enable);
+		if (ret = -ENODEV) {
+			lp->enable = NULL;
+		} else {
+			if (ret != -EPROBE_DEFER)
+				dev_err(lp->dev, "error getting enable regulator: %d\n",
+					ret);
+			return ret;
+		}
+	}
+
 	if (lp->supply) {
 		ret = regulator_enable(lp->supply);
 		if (ret < 0) {
@@ -441,6 +456,20 @@ static int lp855x_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 		}
 	}
 
+	if (lp->enable) {
+		ret = regulator_enable(lp->enable);
+		if (ret < 0) {
+			dev_err(lp->dev, "failed to enable vddio: %d\n", ret);
+			return ret;
+		}
+
+		/*
+		 * TS8555 datasheet says t_RESPONSE (time between VDDIO and
+		 * I2C) is 1ms.
+		 */
+		usleep_range(1000, 2000);
+	}
+
 	i2c_set_clientdata(cl, lp);
 
 	ret = lp855x_configure(lp);
-- 
2.8.0.rc3.226.g39d4020

