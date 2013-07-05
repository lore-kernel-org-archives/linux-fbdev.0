From: Alison Wang <b18965@freescale.com>
Date: Fri, 05 Jul 2013 07:51:40 +0000
Subject: [PATCH 2/4] ARM: dts: vf610-twr: Enable DCU and TCON devices
Message-Id: <1373010702-9244-3-git-send-email-b18965@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373010702-9244-1-git-send-email-b18965@freescale.com>
In-Reply-To: <1373010702-9244-1-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch enables DCU and TCON devices for Vybrid VF610 TOWER board.

Signed-off-by: Alison Wang <b18965@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index b3905f5..605fb04 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -36,6 +36,12 @@
 
 };
 
+&dcu0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dcu0_1>;
+	status = "okay";
+};
+
 &fec0 {
 	phy-mode = "rmii";
 	pinctrl-names = "default";
@@ -50,6 +56,10 @@
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


