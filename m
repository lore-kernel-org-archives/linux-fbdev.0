From: Denis Carikli <denis@eukrea.com>
Date: Fri, 14 Mar 2014 09:12:49 +0000
Subject: =?UTF-8?q?=5BPATCH=20v7=5D=5B=205/5=5D=20ARM=3A=20dts=3A=20mbimxsd35=20Add=20video=20and=20displays=
Message-Id: <1394788369-5096-5-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1394788369-5096-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v6->v7:
- Removed the Cc from the patch, they went into 
  git send-email instead.

ChangeLog v5->v6:
- Shrinked the Cc list.
- Added the targets in the Makefile
- rebased not to use the now gone pingrp headers.

ChangeLog v4->v5:
- Added Grant Likely and Shawn Guo in the Cc list.
- Adapted to the new non-dma ipu bindings.

ChangeLog v3->v4:
- Shortened the licenses.
- adapted the dts(i) to the new bindings.
ChangeLog v2->v3:
- The dts were adapted to the new DT bindings which looks more like the IPUv3
  ones.
---
 arch/arm/boot/dts/Makefile                         |    3 +
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi       |   28 ++++++++++
 .../imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts  |   58 ++++++++++++++++++++
 .../imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts  |   47 ++++++++++++++++
 .../imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts   |   47 ++++++++++++++++
 5 files changed, 183 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cf6c523..1df8945 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -173,6 +173,9 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx27-phytec-phycard-s-rdk.dtb \
 	imx31-bug.dtb \
 	imx35-eukrea-mbimxsd35-baseboard.dtb \
+	imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dtb \
+	imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dtb \
+	imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dtb \
 	imx50-evk.dtb \
 	imx51-apf51.dtb \
 	imx51-apf51dev.dtb \
diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
index 906ae93..6596009 100644
--- a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
+++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
@@ -70,6 +70,34 @@
 				MX35_PAD_I2C1_DAT__I2C1_SDA		0x80000000
 			>;
 		};
+
+		pinctrl_ipu_disp0: ipudisp0grp {
+			fsl,pins = <
+				MX35_PAD_LD0__IPU_DISPB_DAT_0         0x80000000
+				MX35_PAD_LD1__IPU_DISPB_DAT_1         0x80000000
+				MX35_PAD_LD2__IPU_DISPB_DAT_2         0x80000000
+				MX35_PAD_LD3__IPU_DISPB_DAT_3         0x80000000
+				MX35_PAD_LD4__IPU_DISPB_DAT_4         0x80000000
+				MX35_PAD_LD5__IPU_DISPB_DAT_5         0x80000000
+				MX35_PAD_LD6__IPU_DISPB_DAT_6         0x80000000
+				MX35_PAD_LD7__IPU_DISPB_DAT_7         0x80000000
+				MX35_PAD_LD8__IPU_DISPB_DAT_8         0x80000000
+				MX35_PAD_LD9__IPU_DISPB_DAT_9         0x80000000
+				MX35_PAD_LD10__IPU_DISPB_DAT_10       0x80000000
+				MX35_PAD_LD11__IPU_DISPB_DAT_11       0x80000000
+				MX35_PAD_LD12__IPU_DISPB_DAT_12       0x80000000
+				MX35_PAD_LD13__IPU_DISPB_DAT_13       0x80000000
+				MX35_PAD_LD14__IPU_DISPB_DAT_14       0x80000000
+				MX35_PAD_LD15__IPU_DISPB_DAT_15       0x80000000
+				MX35_PAD_LD16__IPU_DISPB_DAT_16       0x80000000
+				MX35_PAD_LD17__IPU_DISPB_DAT_17       0x80000000
+				MX35_PAD_D3_HSYNC__IPU_DISPB_D3_HSYNC 0x80000000
+				MX35_PAD_D3_FPSHIFT__IPU_DISPB_D3_CLK 0x80000000
+				MX35_PAD_D3_DRDY__IPU_DISPB_D3_DRDY   0x80000000
+				MX35_PAD_D3_VSYNC__IPU_DISPB_D3_VSYNC 0x80000000
+				MX35_PAD_CONTRAST__IPU_DISPB_CONTR    0x80000000
+			>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts
new file mode 100644
index 0000000..345f560
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-cmo-qvga.dts
@@ -0,0 +1,58 @@
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
+		pinctrl-0 = <&pinctrl_ipu_disp0>;
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
+	display = <&cmo_qvga>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts
new file mode 100644
index 0000000..1a249d0
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-svga.dts
@@ -0,0 +1,47 @@
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
+		pinctrl-0 = <&pinctrl_ipu_disp0>;
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
+	display = <&dvi_svga>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts
new file mode 100644
index 0000000..44a7616
--- /dev/null
+++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard-dvi-vga.dts
@@ -0,0 +1,47 @@
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
+		pinctrl-0 = <&pinctrl_ipu_disp0>;
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
+&ipu {
+	display = <&dvi_vga>;
+	status = "okay";
+};
-- 
1.7.9.5

