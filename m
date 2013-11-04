From: Denis Carikli <denis@eukrea.com>
Date: Mon, 04 Nov 2013 16:15:24 +0000
Subject: [PATCHv4][ 6/6] ARM: dts: mbimxsd35 Add video and displays support.
Message-Id: <1383581724-14817-6-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383581724-14817-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1383581724-14817-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Eric Bénard <eric@eukrea.com>

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v3->v4:
- Shortened the licenses.
- adapted the dts(i) to the new bindings.
ChangeLog v2->v3:
- The dts were adapted to the new DT bindings which looks more like the IPUv3
  ones.
---
 .../imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts  |   62 ++++++++++++++++++++
 .../imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts  |   51 ++++++++++++++++
 .../imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts   |   52 ++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts

diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts
new file mode 100644
index 0000000..b060f08
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts
@@ -0,0 +1,62 @@
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
+#include "imx35-eukrea-mbimxsd35-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD35 with the CMO-QVGA Display";
+	compatible = "eukrea,mbimxsd35-baseboard-cmo-qvga", "eukrea,mbimxsd35-baseboard", "eukrea,cpuimx35", "fsl,imx35";
+
+	cmo_qvga: display@di0 {
+		compatible = "fsl,mx3-parallel-display";
+		regulator-name = "lcd";
+		interface-pix-fmt = "rgb666";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcdc_1>;
+		lcd-supply = <&reg_lcd_3v3>;
+		model = "CMO-QVGA";
+		display-timings {
+			qvga_timings: 320x240 {
+				clock-frequency = <6500000>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <68>;
+				hfront-porch = <20>;
+				vback-porch = <15>;
+				vfront-porch = <4>;
+				hsync-len = <30>;
+				vsync-len = <3>;
+			};
+		};
+	};
+
+	reg_lcd_3v3: lcd-en {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
+		regulator-name = "lcd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 4 0>;
+		enable-active-high;
+	};
+};
+
+&ipu {
+	status = "okay";
+};
+
+&lcdc {
+	display = <&cmo_qvga>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts
new file mode 100644
index 0000000..ec1a713
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts
@@ -0,0 +1,51 @@
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
+#include "imx35-eukrea-mbimxsd35-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD35 with the DVI-SVGA Display";
+	compatible = "eukrea,mbimxsd35-baseboard-dvi-svga", "eukrea,mbimxsd35-baseboard", "eukrea,cpuimx35", "fsl,imx35";
+	dvi_svga: display@di0 {
+		interface-pix-fmt = "rgb666";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcdc_1>;
+		model = "DVI-SVGA";
+		display-timings {
+			svga_timings: 800x600 {
+				clock-frequency = <40000000>;
+				hactive = <800>;
+				vactive = <600>;
+				hback-porch = <75>;
+				hfront-porch = <75>;
+				vback-porch = <7>;
+				vfront-porch = <75>;
+				hsync-len = <7>;
+				vsync-len = <7>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&ipu {
+	status = "okay";
+};
+
+&lcdc {
+	display = <&dvi_svga>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts
new file mode 100644
index 0000000..9e3d08a
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts
@@ -0,0 +1,52 @@
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
+#include "imx35-eukrea-mbimxsd35-baseboard.dts"
+
+/ {
+	model = "Eukrea MBIMXSD35 with the DVI-VGA Display";
+	compatible = "eukrea,mbimxsd35-baseboard-dvi-vga", "eukrea,mbimxsd35-baseboard", "eukrea,cpuimx35", "fsl,imx35";
+	dvi_vga: display@di0 {
+		interface-pix-fmt = "rgb666";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcdc_1>;
+		model = "DVI-VGA";
+		display-timings {
+			vga_timings: 640x480 {
+				clock-frequency = <31250000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <100>;
+				hfront-porch = <100>;
+				vback-porch = <7>;
+				vfront-porch = <100>;
+				hsync-len = <7>;
+				vsync-len = <7>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+
+&ipu {
+	status = "okay";
+};
+
+&lcdc {
+	display = <&dvi_vga>;
+	status = "okay";
+};
-- 
1.7.9.5

