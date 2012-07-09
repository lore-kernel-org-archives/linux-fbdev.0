From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 09 Jul 2012 06:08:25 +0000
Subject: [RFC][PATCH V2 3/3] tegra: add pwm backlight device tree nodes
Message-Id: <1341814105-20690-4-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341814105-20690-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1341814105-20690-1-git-send-email-acourbot@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Alexandre Courbot <acourbot@nvidia.com>

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/boot/dts/tegra20-ventana.dts | 31 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra20.dtsi        |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index be90544..c67d9e1 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -317,6 +317,37 @@
 		bus-width = <8>;
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 208 224 240 255>;
+		default-brightness-level = <12>;
+
+		pwms = <&pwm 2 5000000>;
+		pwm-names = "backlight";
+		power-supply = <&backlight_reg>;
+		enable-gpios = <&gpio 28 0>;
+
+		power-on-sequence = "REGULATOR", "power", <1>,
+				    "DELAY", <10>,
+				    "PWM", "backlight", <1>,
+				    "GPIO", "enable", <1>;
+		power-off-sequence = "GPIO", "enable", <0>,
+				     "PWM", "backlight", <0>,
+				     "DELAY", <10>,
+				     "REGULATOR", "power", <0>;
+	};
+
+	backlight_reg: fixedregulator@176 {
+		compatible = "regulator-fixed";
+		regulator-name = "backlight_regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio 176 0>;
+		startup-delay-us = <0>;
+		enable-active-high;
+		regulator-boot-off;
+	};
+
 	sound {
 		compatible = "nvidia,tegra-audio-wm8903-ventana",
 			     "nvidia,tegra-audio-wm8903";
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 405d167..67a6cd9 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -123,7 +123,7 @@
 		status = "disabled";
 	};
 
-	pwm {
+	pwm: pwm {
 		compatible = "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
-- 
1.7.11.1

