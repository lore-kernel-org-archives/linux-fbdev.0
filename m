From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 20 Sep 2012 16:33:20 +0000
Subject: [PATCH 2/2] ARM: dts: mxs: add oled support for the cfa-10036
Message-Id: <1348158800-23039-3-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348158800-23039-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1348158800-23039-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Brian Lilly <brian@crystalfontz.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index c03a577..e5ee46e 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -33,11 +33,31 @@
 		};
 
 		apbx@80040000 {
+			pwm: pwm@80064000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pwm4_pins_a>;
+				status = "okay";
+			};
+
 			duart: serial@80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_b>;
 				status = "okay";
 			};
+
+			i2c0: i2c@80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_b>;
+				status = "okay";
+
+				ssd1307: oled@3c {
+					compatible = "solomon,ssd1307fb-i2c";
+					reg = <0x3c>;
+					pwms = <&pwm 4 3000>;
+					reset-gpios = <&gpio2 7 1>;
+					reset-active-low;
+				};
+			};
 		};
 	};
 
-- 
1.7.9.5

