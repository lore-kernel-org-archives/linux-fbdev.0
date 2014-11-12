From: Marek Belisko <marek@goldelico.com>
Date: Wed, 12 Nov 2014 22:10:46 +0000
Subject: [PATCH v2 4/5] arm: dts: omap3: Add definition for devconf1 register
Message-Id: <1415830247-31633-5-git-send-email-marek@goldelico.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830247-31633-1-git-send-email-marek@goldelico.com>
In-Reply-To: <1415830247-31633-1-git-send-email-marek@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch expose DEVCONF1 register via pincrtl-single. Because reserved bits
are different for omap34xx and omap36xx functional-mask is defined in omap3
variant dtsi files. Bit MPUFORCEWRNP is leaved out.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3.dtsi    | 13 +++++++++++++
 arch/arm/boot/dts/omap34xx.dtsi |  4 ++++
 arch/arm/boot/dts/omap36xx.dtsi |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index d0e884d..75aaab3 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -181,6 +181,19 @@
 			pinctrl-single,function-mask = <0xff1f>;
 		};
 
+		control_devconf1: pinmux@480022d8 {
+			compatible = "pinctrl-single";
+			reg = <0x480022d8 4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,bit-per-mux;
+			pinctrl-single,register-width = <32>;
+			/*
+			 * reserved bits differs for omap34xx and omap36xx
+			 * so function-mask is defined in appropriate dtsi files
+			 */
+		};
+
 		omap3_scm_general: tisyscon@48002270 {
 			compatible = "syscon";
 			reg = <0x48002270 0x2f0>;
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 3819c1e..18299b0 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -51,6 +51,10 @@
 		      "ssi_ick";
 };
 
+&control_devconf1 {
+	pinctrl-single,function-mask = <0xfc79d5>;
+};
+
 /include/ "omap34xx-omap36xx-clocks.dtsi"
 /include/ "omap36xx-omap3430es2plus-clocks.dtsi"
 /include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 541704a..736d35d 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -89,6 +89,10 @@
 		      "ssi_ick";
 };
 
+&control_devconf1 {
+	pinctrl-single,function-mask = <0xfc09d5>;
+};
+
 /include/ "omap34xx-omap36xx-clocks.dtsi"
 /include/ "omap36xx-omap3430es2plus-clocks.dtsi"
 /include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
-- 
1.9.1

