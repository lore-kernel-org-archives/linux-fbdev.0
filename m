From: Daniel Mack <daniel@zonque.org>
Date: Wed, 04 Jul 2018 19:35:01 +0000
Subject: [PATCH v2 1/2] dt-bindings: display: add devicetree bindings for pxa300-gcu
Message-Id: <20180704193502.3805-1-daniel@zonque.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh+dt@kernel.org, airlied@linux.ie, mark.rutland@arm.com, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>

This patch adds the binding documentation for the pxa300 gcu.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/display/marvell,pxa300-gcu.txt     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/marvell,pxa300-gcu.txt

diff --git a/Documentation/devicetree/bindings/display/marvell,pxa300-gcu.txt b/Documentation/devicetree/bindings/display/marvell,pxa300-gcu.txt
new file mode 100644
index 000000000000..9cfae5c4e8ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/marvell,pxa300-gcu.txt
@@ -0,0 +1,17 @@
+PXA3xx GCU Controller
+---------------------
+
+Required properties:
+ - compatible : "marvell,pxa300-gcu"
+ - reg : should contain the register range (address and length).
+ - interrupts : Controller interrupt.
+ - clocks: phandle to the PXA specific input clock.
+
+Example for PXA300:
+
+	display-controller@54000000 {
+		compatible = "marvell,pxa300-gcu";
+		reg = <0x54000000 0x1000>;
+		interrupts = <39>;
+		clocks = <&clks CLK_PXA300_GCU>;
+	};
-- 
2.17.1

