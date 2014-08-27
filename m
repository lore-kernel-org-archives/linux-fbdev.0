From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Aug 2014 16:41:03 +0000
Subject: [PATCH 06/16] video: Add DT bindings for the R-Car Display Unit
Message-Id: <1409157673-4154-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org

Aside of the usual boring core properties (compatible, reg, interrupts
and clocks), the bindings use the OF graph bindings to model connections
between the DU output video ports and the on-board and off-board
components.

Cc: devicetree@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../devicetree/bindings/video/renesas,du.txt       | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/renesas,du.txt

diff --git a/Documentation/devicetree/bindings/video/renesas,du.txt b/Documentation/devicetree/bindings/video/renesas,du.txt
new file mode 100644
index 0000000..5102830
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/renesas,du.txt
@@ -0,0 +1,84 @@
+* Renesas R-Car Display Unit (DU)
+
+Required Properties:
+
+  - compatible: must be one of the following.
+    - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
+    - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
+    - "renesas,du-r8a7791" for R8A7791 (R-Car M2) compatible DU
+
+  - reg: A list of base address and length of each memory resource, one for
+    each entry in the reg-names property.
+  - reg-names: Name of the memory resources. The DU requires one memory
+    resource for the DU core (named "du") and one memory resource for each
+    LVDS encoder (named "lvds.x" with "x" being the LVDS controller numerical
+    index).
+
+  - interrupt-parent: phandle of the parent interrupt controller.
+  - interrupts: Interrupt specifiers for the DU interrupts.
+
+  - clocks: A list of phandles + clock-specifier pairs, one for each entry in
+    the clock-names property.
+  - clock-names: Name of the clocks. This property is model-dependent.
+    - R8A7779 uses a single functional clock. The clock doesn't need to be
+      named.
+    - R8A7790 and R8A7791 use one functional clock per channel and one clock
+      per LVDS encoder. The functional clocks must be named "du.x" with "x"
+      being the channel numerical index. The LVDS clocks must be named
+      "lvds.x" with "x" being the LVDS encoder numerical index.
+
+Required nodes:
+
+The connections to the DU output video ports are modeled using the OF graph
+bindings specified in Documentation/devicetree/bindings/graph.txt.
+
+The following table lists for each supported model the port number
+corresponding to each DU output.
+
+		Port 0		Port1		Port2
+-----------------------------------------------------------------------------
+ R8A7779 (H1)	DPAD 0		DPAD 1		-
+ R8A7790 (H2)	DPAD		LVDS 0		LVDS 1
+ R8A7791 (M2)	DPAD		LVDS 0		-
+
+
+Example: R8A7790 (R-Car H2) DU
+
+	du: du@feb00000 {
+		compatible = "renesas,du-r8a7790";
+		reg = <0 0xfeb00000 0 0x70000>,
+		      <0 0xfeb90000 0 0x1c>,
+		      <0 0xfeb94000 0 0x1c>;
+		reg-names = "du", "lvds.0", "lvds.1";
+		interrupt-parent = <&gic>;
+		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 268 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 269 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_DU0>,
+		         <&mstp7_clks R8A7790_CLK_DU1>,
+		         <&mstp7_clks R8A7790_CLK_DU2>,
+		         <&mstp7_clks R8A7790_CLK_LVDS0>,
+		         <&mstp7_clks R8A7790_CLK_LVDS1>;
+		clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1";
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
-- 
1.8.5.5

