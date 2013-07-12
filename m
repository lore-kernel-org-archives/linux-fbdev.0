From: Alison Wang <b18965@freescale.com>
Date: Fri, 12 Jul 2013 06:07:56 +0000
Subject: [PATCH 5/5] Documentation: DT: Add DCU framebuffer driver
Message-Id: <1373609276-14566-6-git-send-email-b18965@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373609276-14566-1-git-send-email-b18965@freescale.com>
In-Reply-To: <1373609276-14566-1-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds the document for DCU framebuffer driver under
Documentation/devicetree/bindings/fb/.

Signed-off-by: Alison Wang <b18965@freescale.com>
---
Changes in v2: New
- Add this document for DCU framebuffer driver.

 .../devicetree/bindings/fb/fsl-dcu-fb.txt          | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt

diff --git a/Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt b/Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt
new file mode 100644
index 0000000..231bda7
--- /dev/null
+++ b/Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt
@@ -0,0 +1,36 @@
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
+
+For the DCU initialization, we read data from TCON node.
+Required properties for TCON:
+- compatible: Should be "fsl,vf610-tcon". Supported chips include
+  Vybrid VF610.
+- reg: Address and length of the register set for TCON.
+- clocks: From common clock binding: handle to TCON clock.
+- clock-names: From common clock binding: Shall be "tcon".
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


