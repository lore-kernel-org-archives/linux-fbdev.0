From: Denis Carikli <denis@eukrea.com>
Date: Fri, 08 Nov 2013 13:17:39 +0000
Subject: [PATCHv9][ 3/3] ARM: dts: cpuimx35 Add touchscreen support.
Message-Id: <1383916659-9988-3-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1383916659-9988-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Lothar Waßmann <LW@KARO-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric Bénard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v8->v9:
- Added Grant Likely in the cc list.
- Adapted to the removal of the pinctrl properties in the tsc2007 documentation.
- Fixed the gpios property (before, it was set to active high by error).

ChangeLog v7->v8:
- Added Shawn Guo in the cc list.
---
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
index b9cb5a5..f25a40f 100644
--- a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
+++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
@@ -36,6 +36,27 @@
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
+
+	tsc2007: tsc2007@48 {
+		compatible = "ti,tsc2007";
+		reg = <0x48>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <0x2 0x8>;
+		gpios = <&gpio3 2 1>;
+		ti,x-plate-ohms = <180>;
+        };
+
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	imx35-eukrea {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <MX35_PAD_ATA_DA2__GPIO3_2 0x80000000>;
+		};
+	};
 };
 
 &nfc {
-- 
1.7.9.5

