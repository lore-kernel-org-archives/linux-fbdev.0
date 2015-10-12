From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Mon, 12 Oct 2015 11:30:23 +0000
Subject: [PATCH v3] video: fbdev: add Marvell PXA LCD controller binding
Message-Id: <1444649423-25369-1-git-send-email-robert.jarzmik@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>

Add documentation for the PXA LCD controller devicetree binding.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: Philipp's review on the whole binding
Since v2: moved to display/, Philipp's and Rob's review
      	  dropped panel description, should be a simple panel with a
	  lcd-type optional node that could be added to simple-panel.
---
 .../bindings/display/marvell,pxa2xx-lcdc.txt       | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt

diff --git a/Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt b/Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt
new file mode 100644
index 000000000000..309c47f25b87
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt
@@ -0,0 +1,34 @@
+PXA LCD Controller
+------------------
+
+Required properties:
+ - compatible : one of these
+	"marvell,pxa2xx-lcdc",
+	"marvell,pxa270-lcdc",
+	"marvell,pxa300-lcdc"
+ - reg : should contain 1 register range (address and length).
+ - interrupts : framebuffer controller interrupt.
+ - clocks: phandle to input clocks
+
+Required nodes:
+ - port: connection to the LCD panel (see video-interfaces.txt)
+	 This node must have its properties bus-width and remote-endpoint set.
+	 If the panel is not a TFT color panel, then a "lcd-type" property in
+	 the panel should specify the panel type.
+	 This panel node should be in the board dts.
+
+Example:
+	lcd-controller@40500000 {
+		compatible = "marvell,pxa2xx-lcdc";
+		reg = <0x44000000 0x10000>;
+		interrupts = <17>;
+		clocks = <&clks CLK_LCD>;
+		status = "okay";
+
+		port {
+			lcdc_out: endpoint {
+				remote-endpoint = <&panel_in>;
+				bus-width = <16>;
+			};
+		};
+	};
-- 
2.1.4

