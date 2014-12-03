From: Xiubo Li <Li.Xiubo@freescale.com>
Date: Wed, 03 Dec 2014 09:16:02 +0000
Subject: [PATCHv2 4/4] ARM: ls1021a: dts: Add and enable dt node for dcfb.
Message-Id: <1417598162-40433-5-git-send-email-Li.Xiubo@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417598162-40433-1-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1417598162-40433-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On LS1021A TWR board, the TFT LCD panel is WQVGA "480x272", and
the bpp is 24.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a2c591e..3602286 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -58,6 +58,32 @@
 	};
 };
 
+&dcfb {
+	display = <&display>;
+	status = "okay";
+
+	display: display@0 {
+		bits-per-pixel = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: nl4827hc19 {
+				clock-frequency = <10870000>;
+				hactive = <480>;
+				vactive = <272>;
+				hback-porch = <2>;
+				hfront-porch = <2>;
+				vback-porch = <2>;
+				vfront-porch = <2>;
+				hsync-len = <41>;
+				vsync-len = <4>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+			};
+		};
+	};
+};
+
 &dspi1 {
 	bus-num = <0>;
 	status = "okay";
-- 
2.1.0.27.g96db324

