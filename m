From: Xiubo Li <Li.Xiubo@freescale.com>
Date: Mon, 24 Nov 2014 10:20:53 +0000
Subject: [PATCH 3/4] ARM: ls1021a: dtsi: Add dt node support for dcfb.
Message-Id: <1416824454-28156-4-git-send-email-Li.Xiubo@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416824454-28156-1-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1416824454-28156-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On LS1021A SoC, the dcfb device is in BE mode.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..740a04e 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -383,6 +383,16 @@
 				 <&platform_clk 1>;
 		};
 
+		dcfb: dcfb@2ce0000 {
+			compatible = "fsl,ls1021a-dcfb";
+			reg = <0x0 0x2ce0000 0x0 0x10000>;
+			clocks = <&platform_clk 0>;
+			clock-names = "dcfb";
+			scfg-controller = <&scfg>;
+			big-endian;
+			status = "disabled";
+		};
+
 		mdio0: mdio@2d24000 {
 			compatible = "gianfar";
 			device_type = "mdio";
-- 
2.1.0.27.g96db324

