From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 23 Oct 2015 03:50:41 +0000
Subject: [PATCH v4 4/4] ARM: dts: sun6i: Add dts file for MSI Primo81 tablet
Message-Id: <1445572241-13259-5-git-send-email-wens@csie.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1445572241-13259-1-git-send-email-wens@csie.org>
In-Reply-To: <1445572241-13259-1-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Karsten Merker <merker@debian.org>

The MSI Primo81 is an A31s based tablet, with 1G RAM, 16G NAND,
768x1024 IPS LCD display, mono speaker, 0.3 MP front camera, 2.0 MP
rear camera, 3500 mAh battery, gt911 touchscreen, mma8452 accelerometer
and rtl8188etv usb wifi. Has "power", "volume+" and "volume-" buttons
(both volume buttons are also connected to the UBOOT_SEL pin). The
external connectors are represented by MicroSD slot, MiniHDMI, MicroUSB
OTG and 3.5mm headphone jack.

USB OTG is enabled in host only mode. AXP221 USB power supply and
GPIO support are required for full USB OTG support.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Signed-off-by: Karsten Merker <merker@debian.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since last submission (was part of Sinlinx SinA31s series)

  - Update axp22x.dtsi file name
  - Sort regulators
  - Drop URL in commit message
  - Drop comment for capacitive touch panel
  - Add simplefb regulators
  - Drop regulator-always-on for regulators that aren't critical
  - Fix CPU and GPU regulator supply mix-up

---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/sun6i-a31s-primo81.dts | 255 +++++++++++++++++++++++++++++++
 2 files changed, 256 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-primo81.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c00b72e750ab..78ade1a5e886 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -612,6 +612,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
 	sun6i-a31-m9.dtb \
 	sun6i-a31-mele-a1000g-quad.dtb \
 	sun6i-a31s-cs908.dtb \
+	sun6i-a31s-primo81.dtb \
 	sun6i-a31s-sina31s.dtb \
 	sun6i-a31s-sinovoip-bpi-m2.dtb \
 	sun6i-a31s-yones-toptech-bs1078-v2.dtb
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
new file mode 100644
index 000000000000..2d4250b1faf8
--- /dev/null
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -0,0 +1,255 @@
+/*
+ * Copyright 2014 Siarhei Siamashka <siarhei.siamashka@gmail.com>
+ * Copyright 2015 Karsten Merker <merker@debian.org>
+ * Copyright 2015 Chen-Yu Tsai <wens@csie.org>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "sun6i-a31s.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
+
+/ {
+	model = "MSI Primo81 tablet";
+	compatible = "msi,primo81", "allwinner,sun6i-a31s";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
+&ehci0 {
+	/* rtl8188etv wifi is connected here */
+	status = "okay";
+};
+
+&i2c0 {
+	/* pull-ups and device VDDIO use AXP221 DLDO3 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "failed";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+
+	ctp@5d {
+		pinctrl-names = "default";
+		pinctrl-0 = <&gt911_int_primo81>;
+		compatible = "goodix,gt911";
+		reg = <0x5d>;
+		interrupt-parent = <&pio>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>; /* PA3 */
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+
+	accelerometer@1c {
+		pinctrl-names = "default";
+		pinctrl-0 = <&mma8452_int_primo81>;
+		compatible = "fsl,mma8452";
+		reg = <0x1c>;
+		interrupt-parent = <&pio>;
+		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>; /* PA9 */
+		#io-channel-cells = <1>;
+	};
+};
+
+&lradc {
+	vref-supply = <&reg_aldo3>;
+	status = "okay";
+
+	button@158 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <158730>;
+	};
+
+	button@349 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <349206>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_primo81>;
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <4>;
+	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
+	cd-inverted;
+	status = "okay";
+};
+
+&pio {
+	gt911_int_primo81: gt911_int_pin@0 {
+		allwinner,pins = "PA3";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	mma8452_int_primo81: mma8452_int_pin@0 {
+		allwinner,pins = "PA9";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	mmc0_cd_pin_primo81: mmc0_cd_pin@0 {
+		allwinner,pins = "PA8";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+};
+
+&p2wi {
+	status = "okay";
+
+	axp22x: pmic@68 {
+		compatible = "x-powers,axp221";
+		reg = <0x68>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+#include "axp22x.dtsi"
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2700000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "avcc";
+};
+
+&reg_dc1sw {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-lcd";
+};
+
+&reg_dc5ldo {
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-cpus"; /* This is an educated guess */
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-3v0";
+};
+
+&reg_dcdc2 {
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-gpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc4 {
+	regulator-always-on;
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-sys-dll";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_dldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
+&reg_dldo3 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vddio-csi";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1080000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-mipi-bridge";
+};
+
+&simplefb_lcd {
+	vcc-lcd-supply = <&reg_dc1sw>;
+	vdd-mipi-bridge-supply = <&reg_eldo3>;
+};
+
+&usb_otg {
+	/* otg support requires support for AXP221 usb-power-supply and GPIO */
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_dldo1>;
+	status = "okay";
+};
-- 
2.6.1

