From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Feb 2014 12:32:28 +0000
Subject: [PATCH 5/9] Doc/DT: Add DT binding documentation for MIPI DPI Panel
Message-Id: <1392294752-18762-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392294752-18762-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1392294752-18762-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Add DT binding documentation for MIPI DPI Panel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/video/panel-dpi.txt        | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/panel-dpi.txt

diff --git a/Documentation/devicetree/bindings/video/panel-dpi.txt b/Documentation/devicetree/bindings/video/panel-dpi.txt
new file mode 100644
index 000000000000..72636c6f1c67
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/panel-dpi.txt
@@ -0,0 +1,43 @@
+Generic MIPI DPI Panel
+===========
+
+Required properties:
+- compatible: "panel-dpi"
+
+Optional properties:
+- label: a symbolic name for the panel
+- gpios: panel enable gpio and backlight enable gpio
+
+Required nodes:
+- "panel-timing" containing video timings
+  (Documentation/devicetree/bindings/video/display-timing.txt)
+- Video port for DPI input
+
+Example
+-------
+
+lcd0: display@0 {
+        compatible = "samsung,lte430wq-f0c", "panel-dpi";
+        label = "lcd";
+
+        lcd_in: endpoint {
+                remote-endpoint = <&dpi_out>;
+        };
+
+        panel-timing {
+                clock-frequency = <9200000>;
+                hactive = <480>;
+                vactive = <272>;
+                hfront-porch = <8>;
+                hback-porch = <4>;
+                hsync-len = <41>;
+                vback-porch = <2>;
+                vfront-porch = <4>;
+                vsync-len = <10>;
+
+                hsync-active = <0>;
+                vsync-active = <0>;
+                de-active = <1>;
+                pixelclk-active = <1>;
+        };
+};
-- 
1.8.3.2

