From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Jan 2014 10:57:01 +0000
Subject: [PATCHv3 29/41] ARM: omap3-igep0020.dts: add display information
Message-Id: <1390301833-24944-30-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Add DT data for OMAP3 IGEPv2 board. The board has the following displays:

dvi: uses TFP410 encoder to convert DPI to DVI

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3-igep0020.dts | 59 +++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 1c7e74d2d2bc..bd8dcc9f7ab4 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -61,14 +61,52 @@
 		reset-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>; /* gpio_24 */
 		vcc-supply = <&hsusb1_power>;
 	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+		gpios = <&gpio6 10 GPIO_ACTIVE_LOW>; /* 170, power-down */
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tfp410_pins>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tfp410_in: endpoint@0 {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tfp410_out: endpoint@0 {
+					remote-endpoint = <&dvi_connector_in>;
+				};
+			};
+		};
+	};
+
+	dvi0: connector@0 {
+		compatible = "dvi-connector";
+		label = "dvi";
+
+		i2c-bus = <&i2c3>;
+
+		dvi_connector_in: endpoint {
+			remote-endpoint = <&tfp410_out>;
+		};
+	};
 };
 
 &omap3_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
 		&hsusbb1_pins
-		&tfp410_pins
-		&dss_pins
 	>;
 
 	hsusbb1_pins: pinmux_hsusbb1_pins {
@@ -88,13 +126,13 @@
 		>;
 	};
 
-	tfp410_pins: tfp410_dvi_pins {
+	tfp410_pins: pinmux_tfp410_pins {
 		pinctrl-single,pins = <
 			0x196 (PIN_OUTPUT | MUX_MODE4)   /* hdq_sio.gpio_170 */
 		>;
 	};
 
-	dss_pins: pinmux_dss_dvi_pins {
+	dss_dpi_pins: pinmux_dss_dpi_pins {
 		pinctrl-single,pins = <
 			0x0a4 (PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
 			0x0a6 (PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
@@ -216,7 +254,14 @@
 	phys = <&hsusb1_phy>;
 };
 
-&vpll2 {
-        /* Needed for DSS */
-        regulator-name = "vdds_dsi";
+&dss {
+	status = "ok";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+
+	dpi_out: endpoint {
+		remote-endpoint = <&tfp410_in>;
+		data-lines = <24>;
+	};
 };
-- 
1.8.3.2

