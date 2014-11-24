From: Xiubo Li <Li.Xiubo@freescale.com>
Date: Mon, 24 Nov 2014 10:20:52 +0000
Subject: [PATCH 2/4] video: fsl-dcfb: Add devicetree binding support
Message-Id: <1416824454-28156-3-git-send-email-Li.Xiubo@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416824454-28156-1-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1416824454-28156-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add devicetree binding support for fsl-dcfb framebuffer driver. It
uses the generic display bindings and helper functions.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../devicetree/bindings/video/fsl,dcfb.txt         | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/fsl,dcfb.txt

diff --git a/Documentation/devicetree/bindings/video/fsl,dcfb.txt b/Documentation/devicetree/bindings/video/fsl,dcfb.txt
new file mode 100644
index 0000000..2f3d02b
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/fsl,dcfb.txt
@@ -0,0 +1,52 @@
+* Freescale Simple Display Controller FB Driver
+
+== For dcfb node =+Required properties:
+- compatible:		Should be one of "fsl,ls1021a-dcfb".
+- reg:			Address and length of the register set for dcfb.
+- clocks:		From common clock binding: handle to dcfb clock.
+- clock-names:		From common clock binding: Shall be "dcfb".
+- display:		The phandle to display node.
+
+Optional properties:
+- scfg-controller:	The phandle of scfg node.
+
+== For display sub-node =+Required properties:
+- bits-per-pixel:	<16> for RGB565,
+			<24> for RGB888,
+			<32> for RGB8888.
+
+Required timing node for dispplay sub-node:
+- display-timings:	Refer to binding doc display-timing.txt for details.
+
+Examples:
+dcfb: dcfb@2ce0000 {
+	compatible = "fsl,ls1021a-dcfb";
+	reg = <0x0 0x2ce0000 0x0 0x10000>;
+	clocks = <&platform_clk 0>;
+	clock-names = "dcfb";
+	scfg-controller = <&scfg>;
+	display = <&display>;
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
-- 
2.1.0.27.g96db324

