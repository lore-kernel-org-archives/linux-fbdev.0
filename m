From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 17 Jul 2012 15:59:46 +0000
Subject: [PATCH 3/4] ARM: dts: mxs: Add pwm4 muxing options for imx28
Message-Id: <1342540787-14930-4-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342540787-14930-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1342540787-14930-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Brian Lilly <brian@crystalfontz.com>
---
 arch/arm/boot/dts/imx28.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 44ce1fd..0a565ef 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -461,6 +461,15 @@
 					fsl,pull-up = <0>;
 				};
 
+				pwm4_pins_a: pwm4@0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x31d0 /* MX28_PAD_PWM4__PWM_4 */
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				lcdif_24bit_pins_a: lcdif-24bit@0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.9.5

