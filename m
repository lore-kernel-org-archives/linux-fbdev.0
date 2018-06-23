From: Daniel Mack <daniel@zonque.org>
Date: Sat, 23 Jun 2018 19:11:24 +0000
Subject: [PATCH 1/2] dt-bindings: video: fbdev: add devicetree bindings for pxa3xx-gcu
Message-Id: <20180623191125.22965-1-daniel@zonque.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh+dt@kernel.org, airlied@linux.ie, mark.rutland@arm.com, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>

This patch adds the binding documentation for the pxa3xx gcu.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/display/marvell,pxa3xx-gcu.txt    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/marvell,pxa3xx-gcu.txt

diff --git a/Documentation/devicetree/bindings/display/marvell,pxa3xx-gcu.txt b/Documentation/devicetree/bindings/display/marvell,pxa3xx-gcu.txt
new file mode 100644
index 000000000000..d1b2302d0fd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/marvell,pxa3xx-gcu.txt
@@ -0,0 +1,18 @@
+PXA3xx GCU Controller
+---------------------
+
+Required properties:
+ - compatible : "marvell,pxa3xx-gcu"
+ - reg : should contain the register range (address and length).
+ - interrupts : GCU interrupt.
+ - clocks: phandle to input clocks
+
+Example for PXA3xx:
+
+	gcu@54000000 {
+		compatible = "marvell,pxa3xx-gcu";
+		reg = <0x54000000 0x1000>;
+		interrupts = <39>;
+		clocks = <&clks CLK_PXA300_GCU>;
+	};
+
-- 
2.17.1

