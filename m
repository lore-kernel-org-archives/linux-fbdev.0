From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 30 Jan 2013 03:02:17 +0000
Subject: [RFC 2/4] tegra: ventana: add display and backlight DT nodes
Message-Id: <1359514939-15653-3-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1359514939-15653-1-git-send-email-acourbot@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thierry Reding <thierry.reding@avionic-design.de>, Stephen Warren <swarren@wwwdotorg.org>, Mark Zhang <markz@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/boot/dts/tegra20-ventana.dts | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index adc4754..48f4e6d 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -10,6 +10,16 @@
 		reg = <0x00000000 0x40000000>;
 	};
 
+	host1x {
+		dc@54200000 {
+			rgb {
+				status = "okay";
+				nvidia,ddc-i2c-bus = <&lcd_ddc>;
+				nvidia,panel = <&panel>;
+			};
+		};
+	};
+
 	pinmux {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
@@ -341,7 +351,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c@1 {
+		lcd_ddc: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -516,6 +526,24 @@
 		bus-width = <8>;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 2 5000000>;
+
+		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 208 224 240 255>;
+		default-brightness-level = <10>;
+	};
+
+	panel: panel {
+		compatible = "chunghwa,claa101wa01a";
+
+		pnl-supply = <&vdd_pnl_reg>;
+		pnl-enable-gpios = <&gpio 10 0>;
+
+		bl-supply = <&vdd_bl_reg>;
+		bl-enable-gpios = <&gpio 28 0>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -549,7 +577,7 @@
 			enable-active-high;
 		};
 
-		regulator@3 {
+		vdd_pnl_reg: regulator@3 {
 			compatible = "regulator-fixed";
 			reg = <3>;
 			regulator-name = "vdd_pnl";
@@ -559,7 +587,7 @@
 			enable-active-high;
 		};
 
-		regulator@4 {
+		vdd_bl_reg: regulator@4 {
 			compatible = "regulator-fixed";
 			reg = <4>;
 			regulator-name = "vdd_bl";
-- 
1.8.1.1

