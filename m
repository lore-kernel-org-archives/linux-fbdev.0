From: Pawel Moll <pawel.moll@arm.com>
Date: Tue, 10 Sep 2013 10:25:26 +0000
Subject: [PATCH v2 2/2] ARM: vexpress: Add CLCD Device Tree properties
Message-Id: <1378808726-32535-2-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378808726-32535-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1378808726-32535-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

... for V2M-P1 motherboard CLCD (limited to 640x480 16bpp and using
dedicated video RAM bank) and for V2P-CA9 (up to 1024x768 16bpp).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi | 25 +++++++++++++++++++++++--
 arch/arm/boot/dts/vexpress-v2m.dtsi     | 25 +++++++++++++++++++++++--
 arch/arm/boot/dts/vexpress-v2p-ca9.dts  | 20 ++++++++++++++++++++
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index ac870fb..91dff88 100644
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
@@ -233,6 +233,27 @@
 				interrupts = <14>;
 				clocks = <&v2m_oscclk1>, <&smbclk>;
 				clock-names = "clcdclk", "apb_pclk";
+
+				video-ram = <&v2m_vram>;
+				max-framebuffer-size = <614400>; /* 640x480 16bpp */
+
+				/* This is the best the CLCD can do here */
+				panel-type = "tft";
+				panel-tft-interface = <8 8 8>;
+				display-timings {
+					native-mode = <&v2m_clcd_timing0>;
+					v2m_clcd_timing0: vga {
+						clock-frequency = <25175000>;
+						hactive = <640>;
+						hback-porch = <40>;
+						hfront-porch = <24>;
+						hsync-len = <96>;
+						vactive = <480>;
+						vback-porch = <32>;
+						vfront-porch = <11>;
+						vsync-len = <2>;
+					};
+				};
 			};
 		};
 
@@ -282,7 +303,7 @@
 				/* CLCD clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 1>;
-				freq-range = <23750000 63500000>;
+				freq-range = <23750000 65000000>;
 				#clock-cells = <0>;
 				clock-output-names = "v2m:oscclk1";
 			};
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index f142036..4bc348c 100644
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
@@ -232,6 +232,27 @@
 				interrupts = <14>;
 				clocks = <&v2m_oscclk1>, <&smbclk>;
 				clock-names = "clcdclk", "apb_pclk";
+
+				video-ram = <&v2m_vram>;
+				max-framebuffer-size = <614400>; /* 640x480 16bpp */
+
+				/* This is the best the CLCD can do here */
+				panel-type = "tft";
+				panel-tft-interface = <8 8 8>;
+				display-timings {
+					native-mode = <&v2m_clcd_timing0>;
+					v2m_clcd_timing0: vga {
+						clock-frequency = <25175000>;
+						hactive = <640>;
+						hback-porch = <40>;
+						hfront-porch = <24>;
+						hsync-len = <96>;
+						vactive = <480>;
+						vback-porch = <32>;
+						vfront-porch = <11>;
+						vsync-len = <2>;
+					};
+				};
 			};
 		};
 
@@ -281,7 +302,7 @@
 				/* CLCD clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 1>;
-				freq-range = <23750000 63500000>;
+				freq-range = <23750000 65000000>;
 				#clock-cells = <0>;
 				clock-output-names = "v2m:oscclk1";
 			};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 62d9b22..fbe1c998 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -73,6 +73,26 @@
 		interrupts = <0 44 4>;
 		clocks = <&oscclk1>, <&oscclk2>;
 		clock-names = "clcdclk", "apb_pclk";
+
+		max-framebuffer-size = <1572864>; /* 1024x768 16bpp */
+
+		/* This is the best the CLCD can do here */
+		panel-type = "tft";
+		panel-tft-interface = <8 8 8>;
+		display-timings {
+			native-mode = <&clcd_timing0>;
+			clcd_timing0: xga {
+				clock-frequency = <63500127>;
+				hactive = <1024>;
+				hback-porch = <152>;
+				hfront-porch = <48>;
+				hsync-len = <104>;
+				vactive = <768>;
+				vback-porch = <23>;
+				vfront-porch = <3>;
+				vsync-len = <4>;
+			};
+		};
 	};
 
 	memory-controller@100e0000 {
-- 
1.8.1.2


