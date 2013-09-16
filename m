From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 16 Sep 2013 17:18:54 +0000
Subject: [PATCH v3 2/2] ARM: vexpress: Add CLCD Device Tree properties
Message-Id: <1379351934-25415-2-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

... for V2M-P1 motherboard CLCD (limited to 640x480 16bpp and using
dedicated video RAM bank) and for V2P-CA9 (up to 1024x768 16bpp).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi | 22 +++++++++++++++++++++-
 arch/arm/boot/dts/vexpress-v2m.dtsi     | 22 +++++++++++++++++++++-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts  | 19 +++++++++++++++++++
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index ac870fb..8226149 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -233,6 +233,26 @@
 				interrupts = <14>;
 				clocks = <&v2m_oscclk1>, <&smbclk>;
 				clock-names = "clcdclk", "apb_pclk";
+
+				arm,pl11x,panel-data-pads = <0x300 0x301 0x302 0x303 0x304 0x305 0x306 0x307>,
+							    <0x310 0x311 0x312 0x313 0x314 0x315 0x316 0x317>,
+							    <0x320 0x321 0x322 0x323 0x324 0x325 0x326 0x327>;
+				arm,pl11x,framebuffer-base = <0x18000000 0x00800000>;
+				max-memory-bandwidth = <36864000>; /* Bps, 640x480@60 16bpp */
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
 
@@ -282,7 +302,7 @@
 				/* CLCD clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 1>;
-				freq-range = <23750000 63500000>;
+				freq-range = <23750000 65000000>;
 				#clock-cells = <0>;
 				clock-output-names = "v2m:oscclk1";
 			};
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index f142036..4befe1c 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -232,6 +232,26 @@
 				interrupts = <14>;
 				clocks = <&v2m_oscclk1>, <&smbclk>;
 				clock-names = "clcdclk", "apb_pclk";
+
+				arm,pl11x,panel-data-pads = <0x300 0x301 0x302 0x303 0x304 0x305 0x306 0x307>,
+							    <0x310 0x311 0x312 0x313 0x314 0x315 0x316 0x317>,
+							    <0x320 0x321 0x322 0x323 0x324 0x325 0x326 0x327>;
+				arm,pl11x,framebuffer-base = <0x4c000000 0x00800000>;
+				max-memory-bandwidth = <36864000>; /* Bps, 640x480@60 16bpp */
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
 
@@ -281,7 +301,7 @@
 				/* CLCD clock */
 				compatible = "arm,vexpress-osc";
 				arm,vexpress-sysreg,func = <1 1>;
-				freq-range = <23750000 63500000>;
+				freq-range = <23750000 65000000>;
 				#clock-cells = <0>;
 				clock-output-names = "v2m:oscclk1";
 			};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 62d9b22..5eb68b8 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -73,6 +73,25 @@
 		interrupts = <0 44 4>;
 		clocks = <&oscclk1>, <&oscclk2>;
 		clock-names = "clcdclk", "apb_pclk";
+
+		arm,pl11x,panel-data-pads = <0x300 0x301 0x302 0x303 0x304 0x305 0x306 0x307>,
+					    <0x310 0x311 0x312 0x313 0x314 0x315 0x316 0x317>,
+					    <0x320 0x321 0x322 0x323 0x324 0x325 0x326 0x327>;
+		max-memory-bandwidth = <94371840>; /* Bps, 1024x768@60 16bpp */
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


