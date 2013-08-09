From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 09 Aug 2013 23:03:14 +0000
Subject: [PATCH/RFC v3 15/19] ARM: shmobile: r8a7790: Add DU device node to device tree
Message-Id: <1376089398-13322-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376089398-13322-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1376089398-13322-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ab0582c..b63f1a6 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -186,4 +186,37 @@
 		reg = <0 0xe6060000 0 0x250>;
 		#gpio-range-cells = <3>;
 	};
+
+	du: display@feb00000 {
+		compatible = "renesas,du-r8a7790";
+		reg = <0 0xfeb00000 0 0x70000>,
+		      <0 0xfeb90000 0 0x1c>,
+		      <0 0xfeb94000 0 0x1c>;
+		reg-names = "core", "lvds.0", "lvds.1";
+		interrupt-parent = <&gic>;
+		interrupts = <0 256 4
+			      0 268 4
+			      0 269 4>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				du_out_rgb: endpoint {
+				};
+			};
+			port@1 {
+				reg = <1>;
+				du_out_lvds0: endpoint {
+				};
+			};
+			port@2 {
+				reg = <2>;
+				du_out_lvds1: endpoint {
+				};
+			};
+		};
+	};
 };
-- 
1.8.1.5

