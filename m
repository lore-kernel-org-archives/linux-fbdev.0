From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 09 Sep 2016 21:25:35 +0000
Subject: [PATCH 6/6] ARM: dts: add the CLCD LCD display to the NHK15
Message-Id: <1473456335-22767-7-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1473456335-22767-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1473456335-22767-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This adds the TPG110 TDO43MTEA2 24-bit RGB LCD panel and sets
up the Nomadik device tree to activate the CLCD and connect it
to this panel.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts    | 44 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 22 +++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index 3ec5c653ad56..1ec46a794a4d 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -176,6 +176,50 @@
 	};
 
 	amba {
+		clcd@10120000 {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&clcd_24bit_mux>;
+			port {
+				nomadik_clcd_pads: endpoint {
+					remote-endpoint = <&nomadik_clcd_panel>;
+					arm,pl11x,tft-r0g0b0-pads = <16 8 0>;
+				};
+			};
+
+			/*
+			 * WVGA connector 21
+			 * WVGA (800x480): 4.3" TPG110 TDO43MTEA2 24-bit RGB
+			 * with TPO touch screen.
+			 */
+			panel {
+				compatible = "tpo,tpg110", "panel-dpi";
+				grestb-gpios = <&stmpe_gpio44 5 GPIO_ACTIVE_LOW>;
+				scen-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
+				scl-gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+				sda-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+				backlight = <&bl>;
+
+				port {
+					nomadik_clcd_panel: endpoint {
+						remote-endpoint = <&nomadik_clcd_pads>;
+					};
+				};
+
+				panel-timing {
+					clock-frequency = <33200000>;
+					hactive = <800>;
+					hback-porch = <216>;
+					hfront-porch = <40>;
+					hsync-len = <1>;
+					vactive = <480>;
+					vback-porch = <35>;
+					vfront-porch = <10>;
+					vsync-len = <1>;
+				};
+			};
+		};
+
 		/* Activate RX/TX and CTS/RTS on UART 0 */
 		uart0: uart@101fd000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 80a3c9ccccd9..adb1c0998b81 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -166,6 +166,18 @@
 				};
 			};
 		};
+		clcd {
+			/*
+			 * This should be activated to use the additional
+			 * 8 lines for bits 16 thru 23 from the CLCD block.
+			 */
+			clcd_24bit_mux: clcd_mux {
+				clcd_24bit_mux {
+					function = "clcd";
+					groups = "clcd_16_23_b_1";
+				};
+			};
+		};
 	};
 
 	/* Power Management Unit */
@@ -732,6 +744,16 @@
 		#size-cells = <1>;
 		ranges;
 
+		clcd@10120000 {
+			compatible = "arm,pl110", "arm,primecell";
+			reg = <0x10120000 0x1000>;
+			interrupt-names = "combined";
+			interrupts = <14>;
+			clocks = <&clcdclk>, <&hclkclcd>;
+			clock-names = "clcdclk", "apb_pclk";
+			status = "disabled";
+		};
+
 		vica: intc@10140000 {
 			compatible = "arm,versatile-vic";
 			interrupt-controller;
-- 
2.7.4

