From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 17 Apr 2013 15:17:22 +0000
Subject: [RFC 10/10] ARM: vexpress: Add CLCD Device Tree properties
Message-Id: <1366211842-21497-11-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi |   17 +++++++++++++----
 arch/arm/boot/dts/vexpress-v2m.dtsi     |   17 +++++++++++++----
 arch/arm/boot/dts/vexpress-v2p-ca9.dts  |    5 +++++
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index ac870fb..aac9459 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -41,7 +41,7 @@
 			bank-width = <4>;
 		};
 
-		vram@2,00000000 {
+		v2m_vram: vram@2,00000000 {
 			compatible = "arm,vexpress-vram";
 			reg = <2 0x00000000 0x00800000>;
 		};
@@ -233,6 +233,12 @@
 				interrupts = <14>;
 				clocks = <&v2m_oscclk1>, <&smbclk>;
 				clock-names = "clcdclk", "apb_pclk";
+				label = "IOFPGA CLCD";
+				video-ram = <&v2m_vram>;
+				display = <&v2m_muxfpga 0>;
+				max-hactive = <640>;
+				max-vactive = <480>;
+				max-bpp = <16>;
 			};
 		};
 
@@ -282,7 +288,7 @@
 				/* CLCD clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 1>;
-				freq-range = <23750000 63500000>;
+				freq-range = <23750000 65000000>;
 				#clock-cells = <0>;
 				clock-output-names = "v2m:oscclk1";
 			};
@@ -317,9 +323,11 @@
 				arm,vexpress-sysreg,func = <5 0>;
 			};
 
-			muxfpga@0 {
+			v2m_muxfpga: muxfpga@0 {
 				compatible = "arm,vexpress-muxfpga";
 				arm,vexpress-sysreg,func = <7 0>;
+				#display-cells = <1>;
+				display = <&v2m_dvimode>;
 			};
 
 			shutdown@0 {
@@ -332,9 +340,10 @@
 				arm,vexpress-sysreg,func = <9 0>;
 			};
 
-			dvimode@0 {
+			v2m_dvimode: dvimode@0 {
 				compatible = "arm,vexpress-dvimode";
 				arm,vexpress-sysreg,func = <11 0>;
+				#display-cells = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index f142036..4d080d0 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -40,7 +40,7 @@
 			bank-width = <4>;
 		};
 
-		vram@3,00000000 {
+		v2m_vram: vram@3,00000000 {
 			compatible = "arm,vexpress-vram";
 			reg = <3 0x00000000 0x00800000>;
 		};
@@ -232,6 +232,12 @@
 				interrupts = <14>;
 				clocks = <&v2m_oscclk1>, <&smbclk>;
 				clock-names = "clcdclk", "apb_pclk";
+				label = "IOFPGA CLCD";
+				video-ram = <&v2m_vram>;
+				display = <&v2m_muxfpga 0>;
+				max-hactive = <640>;
+				max-vactive = <480>;
+				max-bpp = <16>;
 			};
 		};
 
@@ -281,7 +287,7 @@
 				/* CLCD clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 1>;
-				freq-range = <23750000 63500000>;
+				freq-range = <23750000 65000000>;
 				#clock-cells = <0>;
 				clock-output-names = "v2m:oscclk1";
 			};
@@ -316,9 +322,11 @@
 				arm,vexpress-sysreg,func = <5 0>;
 			};
 
-			muxfpga@0 {
+			v2m_muxfpga: muxfpga@0 {
 				compatible = "arm,vexpress-muxfpga";
 				arm,vexpress-sysreg,func = <7 0>;
+				#display-cells = <1>;
+				display = <&v2m_dvimode>;
 			};
 
 			shutdown@0 {
@@ -331,9 +339,10 @@
 				arm,vexpress-sysreg,func = <9 0>;
 			};
 
-			dvimode@0 {
+			v2m_dvimode: dvimode@0 {
 				compatible = "arm,vexpress-dvimode";
 				arm,vexpress-sysreg,func = <11 0>;
+				#display-cells = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 1420bb1..2a63510 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -73,6 +73,11 @@
 		interrupts = <0 44 4>;
 		clocks = <&oscclk1>, <&oscclk2>;
 		clock-names = "clcdclk", "apb_pclk";
+		label = "V2P-CA9 CLCD";
+		display = <&v2m_muxfpga 0xf>;
+		max-hactive = <1024>;
+		max-vactive = <768>;
+		max-bpp = <16>;
 	};
 
 	memory-controller@100e0000 {
-- 
1.7.10.4


