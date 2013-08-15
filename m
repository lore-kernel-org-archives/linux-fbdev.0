From: Alison Wang <b18965@freescale.com>
Date: Thu, 15 Aug 2013 08:01:51 +0000
Subject: [PATCH v3 2/5] ARM: dts: vf610-twr: Enable DCU and TCON devices
Message-Id: <1376553714-25922-3-git-send-email-b18965@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376553714-25922-1-git-send-email-b18965@freescale.com>
In-Reply-To: <1376553714-25922-1-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch enables DCU and TCON devices for Vybrid VF610 TOWER board.

Signed-off-by: Alison Wang <b18965@freescale.com>
---
Changes in v3: Add panel description in devicetree.
Changes in v2: None

 arch/arm/boot/dts/vf610-twr.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index b3905f5..82c03fe 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -36,6 +36,34 @@
 
 };
 
+&dcu0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dcu0_1>;
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
+				vback-porch = <1>;
+				vfront-porch = <1>;
+				hsync-len = <41>;
+				vsync-len = <2>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+			};
+		};
+	};
+};
+
 &fec0 {
 	phy-mode = "rmii";
 	pinctrl-names = "default";
@@ -50,6 +78,10 @@
 	status = "okay";
 };
 
+&tcon0 {
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_1>;
-- 
1.8.0


