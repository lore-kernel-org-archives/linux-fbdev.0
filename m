From: Afzal Mohammed <afzal@ti.com>
Date: Mon, 07 Jan 2013 05:30:15 +0000
Subject: [PATCH 2/5] ARM: dts: AM33XX: Add am335x-evm lcdc panel timings
Message-Id: <6a980ad27ca1daf63d93517a14a544737b92880e.1357304150.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1357304150.git.afzal@ti.com>
In-Reply-To: <cover.1357304150.git.afzal@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Update lcdc node with panel timings (typical) for AM335X-EVM.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d649644..a4229aa 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -244,3 +244,23 @@
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
 };
+
+&lcdc {
+	status = "okay";
+
+	display-timings {
+		800x480p62 {
+			clock-frequency = <30000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hfront-porch = <39>;
+			hback-porch = <39>;
+			hsync-len = <47>;
+			vback-porch = <29>;
+			vfront-porch = <13>;
+			vsync-len = <2>;
+			hsync-active = <1>;
+			vsync-active = <1>;
+		};
+	};
+};
-- 
1.7.9.5

