From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 07 Apr 2013 18:44:59 +0000
Subject: [PATCH v6] video: mxsfb: Introduce regulator support
Message-Id: <1365360299-8707-1-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of using a custom binding for retrieving the GPIO that activates the 
LCD from devicetree, use a standard regulator.

This approach has the advantage to be more generic. 

For example: in the case of a board that has a PMIC supplying the LCD voltage, 
the current approach would not work, as it only searches for a GPIO pin.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v5:
- Remove 'Optional properties' line from mxsfb.txt
- Place regultar_disable in the end of mxsfb_disable_controller
- Check for IS_ERR((IS_ERR(host->reg_lcd)) inside probe
Chages since v4:
- Merged the 2 previous patches into one in order not to break keep mxsfb functionality
- Remove unneeded change in mxsfb.txt
- Use regulator_disable to pair with regulator_enable
Changes since v3:
- None
Changes since v2:
- Use devm_regulator_get()
Changes since v1:
- No changes
 Documentation/devicetree/bindings/fb/mxsfb.txt |    4 ---
 arch/arm/boot/dts/imx23-evk.dts                |   11 ++++++-
 arch/arm/boot/dts/imx28-evk.dts                |   11 ++++++-
 drivers/video/mxsfb.c                          |   41 +++++++++++++-----------
 4 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/fb/mxsfb.txt b/Documentation/devicetree/bindings/fb/mxsfb.txt
index 7ba3b76..96ec517 100644
--- a/Documentation/devicetree/bindings/fb/mxsfb.txt
+++ b/Documentation/devicetree/bindings/fb/mxsfb.txt
@@ -7,9 +7,6 @@ Required properties:
 - interrupts: Should contain lcdif interrupts
 - display : phandle to display node (see below for details)
 
-Optional properties:
-- panel-enable-gpios : Should specify the gpio for panel enable
-
 * display node
 
 Required properties:
@@ -25,7 +22,6 @@ lcdif@80030000 {
 	compatible = "fsl,imx28-lcdif";
 	reg = <0x80030000 2000>;
 	interrupts = <38 86>;
-	panel-enable-gpios = <&gpio3 30 0>;
 
 	display: display {
 		bits-per-pixel = <32>;
diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 7880e17..da0588a 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -59,7 +59,7 @@
 			lcdif@80030000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a>;
-				panel-enable-gpios = <&gpio1 18 0>;
+				lcd-supply = <&reg_lcd_3v3>;
 				display = <&display>;
 				status = "okay";
 
@@ -120,6 +120,15 @@
 			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio1 29 0>;
 		};
+
+		reg_lcd_3v3: lcd-3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "lcd-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio1 18 0>;
+			enable-active-high;
+		};
 	};
 
 	backlight {
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 2d4ea3b..3637bf3 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -123,7 +123,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_evk>;
-				panel-enable-gpios = <&gpio3 30 0>;
+				lcd-supply = <&reg_lcd_3v3>;
 				display = <&display>;
 				status = "okay";
 
@@ -310,6 +310,15 @@
 			gpio = <&gpio3 8 0>;
 			enable-active-high;
 		};
+
+		reg_lcd_3v3: lcd-3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "lcd-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 30 0>;
+			enable-active-high;
+		};
 	};
 
 	sound {
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index eac7c1a..1b2c26d 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -42,7 +42,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <video/of_display_timing.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
@@ -50,6 +49,7 @@
 #include <linux/io.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/fb.h>
+#include <linux/regulator/consumer.h>
 #include <video/videomode.h>
 
 #define REG_SET	4
@@ -179,6 +179,7 @@ struct mxsfb_info {
 	unsigned dotclk_delay;
 	const struct mxsfb_devdata *devdata;
 	u32 sync;
+	struct regulator *reg_lcd;
 };
 
 #define mxsfb_is_v3(host) (host->devdata->ipversion = 3)
@@ -338,9 +339,19 @@ static void mxsfb_enable_controller(struct fb_info *fb_info)
 {
 	struct mxsfb_info *host = to_imxfb_host(fb_info);
 	u32 reg;
+	int ret;
 
 	dev_dbg(&host->pdev->dev, "%s\n", __func__);
 
+	if (host->reg_lcd) {
+		ret = regulator_enable(host->reg_lcd);
+		if (ret) {
+			dev_err(&host->pdev->dev,
+				"lcd regulator enable failed:	%d\n", ret);
+			return;
+		}
+	}
+
 	clk_prepare_enable(host->clk);
 	clk_set_rate(host->clk, PICOS2KHZ(fb_info->var.pixclock) * 1000U);
 
@@ -362,6 +373,7 @@ static void mxsfb_disable_controller(struct fb_info *fb_info)
 	struct mxsfb_info *host = to_imxfb_host(fb_info);
 	unsigned loop;
 	u32 reg;
+	int ret;
 
 	dev_dbg(&host->pdev->dev, "%s\n", __func__);
 
@@ -385,6 +397,13 @@ static void mxsfb_disable_controller(struct fb_info *fb_info)
 	clk_disable_unprepare(host->clk);
 
 	host->enabled = 0;
+
+	if (host->reg_lcd) {
+		ret = regulator_disable(host->reg_lcd);
+		if (ret)
+			dev_err(&host->pdev->dev,
+				"lcd regulator disable failed: %d\n", ret);
+	}
 }
 
 static int mxsfb_set_par(struct fb_info *fb_info)
@@ -859,8 +878,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 	struct fb_info *fb_info;
 	struct fb_modelist *modelist;
 	struct pinctrl *pinctrl;
-	int panel_enable;
-	enum of_gpio_flags flags;
 	int ret;
 
 	if (of_id)
@@ -904,21 +921,9 @@ static int mxsfb_probe(struct platform_device *pdev)
 		goto fb_release;
 	}
 
-	panel_enable = of_get_named_gpio_flags(pdev->dev.of_node,
-					       "panel-enable-gpios", 0, &flags);
-	if (gpio_is_valid(panel_enable)) {
-		unsigned long f = GPIOF_OUT_INIT_HIGH;
-		if (flags = OF_GPIO_ACTIVE_LOW)
-			f = GPIOF_OUT_INIT_LOW;
-		ret = devm_gpio_request_one(&pdev->dev, panel_enable,
-					    f, "panel-enable");
-		if (ret) {
-			dev_err(&pdev->dev,
-				"failed to request gpio %d: %d\n",
-				panel_enable, ret);
-			goto fb_release;
-		}
-	}
+	host->reg_lcd = devm_regulator_get(&pdev->dev, "lcd");
+	if (IS_ERR(host->reg_lcd))
+		host->reg_lcd = NULL;
 
 	fb_info->pseudo_palette = devm_kzalloc(&pdev->dev, sizeof(u32) * 16,
 					       GFP_KERNEL);
-- 
1.7.9.5

