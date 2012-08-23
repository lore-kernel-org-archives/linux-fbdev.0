From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 23 Aug 2012 08:42:29 +0000
Subject: [PATCH 2/4] ARM: dts: mxs: Add alternative I2C muxing options for imx28
Message-Id: <1345711351-16367-3-git-send-email-maxime.ripard@free-electrons.com>
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
 arch/arm/boot/dts/imx28.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 787efac..f6ffcd9 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -410,6 +410,17 @@
 					fsl,pull-up = <1>;
 				};
 
+				i2c0_pins_b: i2c0@1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						0x3001 /* MX28_PAD_AUART0_RX__DUART_CTS */
+						0x3011 /* MX28_PAD_AUART0_TX__DUART_RTS */
+					>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
 				saif0_pins_a: saif0@0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.9.5

