From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 12 Apr 2013 08:00:03 +0000
Subject: [PATCH 2/2] ARM: dts: cfa10036: Change the OLED display to SSD1306
Message-Id: <1365753603-4438-3-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365753603-4438-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1365753603-4438-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The SSD1307 was used in an early prototype that will never get
distributed. The final board now has a SSD1306 instead, that has its own
power generation unit and thus doesn't need any PWM. The panel attached
to it also changed.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts |   14 +++++---------
 arch/arm/boot/dts/imx28-cfa10049.dts |    4 ++--
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 1594694..40488f5a8 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -58,12 +58,6 @@
 		};
 
 		apbx@80040000 {
-			pwm: pwm@80064000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pwm4_pins_a>;
-				status = "okay";
-			};
-
 			duart: serial@80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_b>;
@@ -75,11 +69,13 @@
 				pinctrl-0 = <&i2c0_pins_b>;
 				status = "okay";
 
-				ssd1307: oled@3c {
-					compatible = "solomon,ssd1307fb-i2c";
+				ssd1306: oled@3c {
+					compatible = "solomon,ssd1306fb-i2c";
 					reg = <0x3c>;
-					pwms = <&pwm 4 3000>;
 					reset-gpios = <&gpio2 7 0>;
+					solomon,height = <32>;
+					solomon,width = <128>;
+					solomon,page-offset = <0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index a0d3e9f..ded7784 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -132,8 +132,8 @@
 
 		apbx@80040000 {
 			pwm: pwm@80064000 {
-				pinctrl-names = "default", "default";
-				pinctrl-1 = <&pwm3_pins_b>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pwm3_pins_b>;
 				status = "okay";
 			};
 
-- 
1.7.10.4

