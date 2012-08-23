From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 23 Aug 2012 08:42:30 +0000
Subject: [PATCH 3/4] ARM: dts: mxs: Add pwm4 muxing options for imx28
Message-Id: <1345711351-16367-4-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345711351-16367-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1345711351-16367-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Brian Lilly <brian@crystalfontz.com>
---
 arch/arm/boot/dts/imx28.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index f6ffcd9..60d10d7 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -464,6 +464,16 @@
 					fsl,pull-up = <0>;
 				};
 
+				pwm4_pins_a: pwm4@0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x31d0 /* MX28_PAD_PWM4__PWM_4 */
+					>;
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

