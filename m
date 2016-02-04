From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 04 Feb 2016 14:04:19 +0000
Subject: [PATCH 10/11] ARM: PB1176: define a standard VGA panel
Message-Id: <1454594660-7532-11-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This defines the CLCD block in the PB1176 and adds a standard
640x480 VGA panel to the device tree.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index d012ecf25127..af10d888545b 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -362,6 +362,46 @@
 			clocks = <&uartclk>, <&pclk>;
 			clock-names = "uartclk", "apb_pclk";
 		};
+
+		clcd@10112000 {
+			compatible = "arm,pl111", "arm,primecell";
+			reg = <0x10112000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupt-names = "combined";
+			interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&oscclk0>, <&pclk>;
+			clock-names = "clcdclk", "apb_pclk";
+
+			port {
+				clcd_pads: endpoint {
+					remote-endpoint = <&clcd_panel>;
+					arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
+				};
+			};
+
+			panel {
+				compatible = "panel-dpi";
+
+				port {
+					clcd_panel: endpoint {
+						remote-endpoint = <&clcd_pads>;
+					};
+				};
+
+				/* Standard 640x480 VGA timings */
+				panel-timing {
+					clock-frequency = <25175000>;
+					hactive = <640>;
+					hback-porch = <48>;
+					hfront-porch = <16>;
+					hsync-len = <96>;
+					vactive = <480>;
+					vback-porch = <33>;
+					vfront-porch = <10>;
+					vsync-len = <2>;
+				};
+			};
+		};
 	};
 
 	/* These peripherals are inside the FPGA rather than the DevChip */
-- 
2.4.3

