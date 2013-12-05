From: Denis Carikli <denis@eukrea.com>
Date: Thu, 05 Dec 2013 15:43:39 +0000
Subject: [PATCHv13][ 4/4] ARM: dts: imx25: mbimxsd25: Add displays support.
Message-Id: <1386258219-26437-4-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386258219-26437-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1386258219-26437-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

The CMO-QVGA(With backlight), DVI-VGA and DVI-SVGA displays
were added.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Eric Bénard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v10->v13:
- This patch is the display part splitted out from the patch adding
  support for the cpuimx25(and its baseboard).
- Shawn Guo was added to the Cc list.
- The regulator part was updated to match the current style.
- The new GPIO defines are now used in the dts(i).
---
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |   72 ++++++++++++++++++++
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts  |   45 ++++++++++++
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts   |   45 ++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
new file mode 100644
index 0000000..0df7e9e
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -0,0 +1,72 @@
+/*
+ * Copyright 2013 Eukréa Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "imx25-eukrea-mbimxsd25-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD25 with the CMO-QVGA Display";
+	compatible = "eukrea,mbimxsd25-baseboard-cmo-qvga", "eukrea,mbimxsd25-baseboard", "eukrea,cpuimx25", "fsl,imx25";
+
+	cmo_qvga: display {
+		model = "CMO-QVGA";
+		bits-per-pixel = <16>;
+		fsl,pcr = <0xcad08b80>;
+		bus-width = <18>;
+		native-mode = <&qvga_timings>;
+		display-timings {
+			qvga_timings: 320x240 {
+				clock-frequency = <6500000>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <30>;
+				hfront-porch = <38>;
+				vback-porch = <20>;
+				vfront-porch = <3>;
+				hsync-len = <15>;
+				vsync-len = <4>;
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_lcd_3v3: regulator@0 {
+			compatible = "regulator-fixed";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
+			regulator-name = "lcd-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+	};
+};
+
+&iomuxc {
+	imx25-eukrea-mbimxsd25-baseboard-cmo-qvga {
+		pinctrl_reg_lcd_3v3: reg_lcd_3v3 {
+			fsl,pins = <MX25_PAD_PWM__GPIO_1_26 0x80000000>;
+		};
+	};
+};
+
+&lcdc {
+	display = <&cmo_qvga>;
+	fsl,pwmr = <0x00a903ff>;
+	lcd-supply = <&reg_lcd_3v3>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
new file mode 100644
index 0000000..8eee2f6
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2013 Eukréa Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "imx25-eukrea-mbimxsd25-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD25 with the DVI-SVGA Display";
+	compatible = "eukrea,mbimxsd25-baseboard-dvi-svga", "eukrea,mbimxsd25-baseboard", "eukrea,cpuimx25", "fsl,imx25";
+
+	dvi_svga: display {
+		model = "DVI-SVGA";
+		bits-per-pixel = <16>;
+		fsl,pcr = <0xfa208b80>;
+		bus-width = <18>;
+		native-mode = <&dvi_svga_timings>;
+		display-timings {
+			dvi_svga_timings: 800x600 {
+				clock-frequency = <40000000>;
+				hactive = <800>;
+				vactive = <600>;
+				hback-porch = <75>;
+				hfront-porch = <75>;
+				vback-porch = <7>;
+				vfront-porch = <75>;
+				hsync-len = <7>;
+				vsync-len = <7>;
+			};
+		};
+	};
+};
+
+&lcdc {
+	display = <&dvi_svga>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
new file mode 100644
index 0000000..447da62
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2013 Eukréa Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "imx25-eukrea-mbimxsd25-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD25 with the DVI-VGA Display";
+	compatible = "eukrea,mbimxsd25-baseboard-dvi-vga", "eukrea,mbimxsd25-baseboard", "eukrea,cpuimx25", "fsl,imx25";
+
+	dvi_vga: display {
+		model = "DVI-VGA";
+		bits-per-pixel = <16>;
+		fsl,pcr = <0xfa208b80>;
+		bus-width = <18>;
+		native-mode = <&dvi_vga_timings>;
+		display-timings {
+			dvi_vga_timings: 640x480 {
+				clock-frequency = <31250000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <100>;
+				hfront-porch = <100>;
+				vback-porch = <7>;
+				vfront-porch = <100>;
+				hsync-len = <7>;
+				vsync-len = <7>;
+			};
+		};
+	};
+};
+
+&lcdc {
+	display = <&dvi_vga>;
+	status = "okay";
+};
-- 
1.7.9.5

