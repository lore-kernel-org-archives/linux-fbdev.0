From: Alison Wang <b18965@freescale.com>
Date: Fri, 12 Jul 2013 06:07:52 +0000
Subject: [PATCH 1/5] ARM: dts: vf610: Add DCU and TCON nodes
Message-Id: <1373609276-14566-2-git-send-email-b18965@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373609276-14566-1-git-send-email-b18965@freescale.com>
In-Reply-To: <1373609276-14566-1-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds DCU and TCON nodes in SoC level DTS for Freescale
Vybrid VF610. It also removes useless pin for DCU0 pinctrl.

Signed-off-by: Alison Wang <b18965@freescale.com>
---
Changes in v2: None

 arch/arm/boot/dts/vf610.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index e1eb7da..037e8f1 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -140,6 +140,14 @@
 				clock-names = "pit";
 			};
 
+			tcon0: tcon@4003d000 {
+				compatible = "fsl,vf610-tcon";
+				reg = <0x4003d000 0x1000>;
+				clocks = <&clks VF610_CLK_TCON0>;
+				clock-names = "tcon";
+				status = "disabled";
+			};
+
 			wdog@4003e000 {
 				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
 				reg = <0x4003e000 0x1000>;
@@ -169,7 +177,6 @@
 				dcu0 {
 					pinctrl_dcu0_1: dcu0grp_1 {
 						fsl,pins = <
-						VF610_PAD_PTB8__GPIO_30		0x42
 						VF610_PAD_PTE0__DCU0_HSYNC	0x42
 						VF610_PAD_PTE1__DCU0_VSYNC	0x42
 						VF610_PAD_PTE2__DCU0_PCLK	0x42
@@ -395,6 +402,16 @@
 				reg = <0x40050000 0x1000>;
 			};
 
+			dcu0: dcu@40058000 {
+				compatible = "fsl,vf610-dcu";
+				reg = <0x40058000 0x1200>;
+				interrupts = <0 30 0x04>;
+				clocks = <&clks VF610_CLK_DCU0>;
+				clock-names = "dcu";
+				tcon-controller = <&tcon0>;
+				status = "disabled";
+			};
+
 			i2c0: i2c@40066000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
1.8.0


