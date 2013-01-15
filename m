From: Afzal Mohammed <afzal@ti.com>
Date: Tue, 15 Jan 2013 13:51:57 +0000
Subject: [PATCH v2 1/5] ARM: dts: AM33XX: Add lcdc node
Message-Id: <62452618e98a5902007fd2d2f07262bca0bea0bd.1358252955.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1358252955.git.afzal@ti.com>
In-Reply-To: <cover.1358252955.git.afzal@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add lcdc node.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c2f14e8..432d4bb8 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -385,5 +385,13 @@
 				mac-address = [ 00 00 00 00 00 00 ];
 			};
 		};
+
+		lcdc: lcdc@4830e000 {
+			compatible = "ti,am3352-lcdc", "ti,da830-lcdc";
+			reg = <0x4830e000 0x1000>;
+			interrupts = <36>;
+			status = "disabled";
+			ti,hwmods = "lcdc";
+		};
 	};
 };
-- 
1.7.9.5

