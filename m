From: Alison Wang <b18965@freescale.com>
Date: Thu, 15 Aug 2013 08:01:54 +0000
Subject: [PATCH v3 5/5] Documentation: DT: Add DCU framebuffer driver
Message-Id: <1376553714-25922-6-git-send-email-b18965@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376553714-25922-1-git-send-email-b18965@freescale.com>
In-Reply-To: <1376553714-25922-1-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds the document for DCU framebuffer driver under
Documentation/devicetree/bindings/fb/.

Signed-off-by: Alison Wang <b18965@freescale.com>
---
Changes in v3: Add display node description
Changes in v2: New

 .../devicetree/bindings/fb/fsl-dcu-fb.txt          | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt

diff --git a/Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt b/Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt
new file mode 100644
index 0000000..d0d50dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt
@@ -0,0 +1,67 @@
+* Freescale Display Control Unit (DCU)
+
+Required properties:
+- compatible: Should be "fsl,vf610-dcu". Supported chips include
+  Vybrid VF610.
+- reg: Address and length of the register set for DCU.
+- interrupts: Should contain DCU interrupts.
+- clocks: From common clock binding: handle to DCU clock.
+- clock-names: From common clock binding: Shall be "dcu".
+- tcon-controller: The phandle of TCON controller.
+- display: The phandle to display node.
+
+For the DCU initialization, we read data from TCON node.
+Required properties for TCON:
+- compatible: Should be "fsl,vf610-tcon". Supported chips include
+  Vybrid VF610.
+- reg: Address and length of the register set for TCON.
+- clocks: From common clock binding: handle to TCON clock.
+- clock-names: From common clock binding: Shall be "tcon".
+
+* display node
+
+Required properties:
+- bits-per-pixel: <24> for RGB888.
+
+Required sub-node:
+- display-timings: Refer to binding doc display-timing.txt for details.
+
+Examples:
+
+dcu0: dcu@40058000 {
+	compatible = "fsl,vf610-dcu";
+	reg = <0x40058000 0x1200>;
+	interrupts = <0 30 0x04>;
+	clocks = <&clks VF610_CLK_DCU0>;
+	clock-names = "dcu";
+	tcon-controller = <&tcon0>;
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
+
+tcon0: tcon@4003d000 {
+	compatible = "fsl,vf610-tcon";
+	reg = <0x4003d000 0x1000>;
+	clocks = <&clks VF610_CLK_TCON0>;
+	clock-names = "tcon";
+};
-- 
1.8.0


