From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 16 Aug 2012 06:08:57 +0000
Subject: [PATCH v4 3/3] tegra: add pwm backlight device tree nodes
Message-Id: <1345097337-24170-4-git-send-email-acourbot@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345097337-24170-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1345097337-24170-1-git-send-email-acourbot@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Leela Krishna Amudala <leelakrishna.a@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/boot/dts/tegra20-ventana.dts | 58 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra20.dtsi        |  2 +-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index be90544..b253697 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -317,6 +317,64 @@
 		bus-width = <8>;
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 208 224 240 255>;
+		default-brightness-level = <12>;
+
+		/* resources used by the power sequences */
+		pwms = <&pwm 2 5000000>;
+		pwm-names = "backlight";
+		power-supply = <&backlight_reg>;
+		enable-gpio = <&gpio 28 0>;
+
+		power-on-sequence {
+			step0 {
+				regulator = "power";
+				enable;
+			};
+			step1 {
+				delay = <10000>;
+			};
+			step2 {
+				pwm = "backlight";
+				enable;
+			};
+			step3 {
+				gpio = "enable";
+				enable;
+			};
+		};
+		power-off-sequence {
+			step0 {
+				gpio = "enable";
+				disable;
+			};
+			step1 {
+				pwm = "backlight";
+				disable;
+			};
+			step2 {
+				delay = <10000>;
+			};
+			step3 {
+				regulator = "power";
+				disable;
+			};
+		};
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
1.7.11.4

