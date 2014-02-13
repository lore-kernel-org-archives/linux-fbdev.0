From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Feb 2014 12:32:31 +0000
Subject: [PATCH 8/9] Doc/DT: Add DT binding documentation for TFP410 encoder
Message-Id: <1392294752-18762-9-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392294752-18762-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1392294752-18762-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Add DT binding documentation for TFP410 encoder

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/video/ti,tfp410.txt        | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,tfp410.txt

diff --git a/Documentation/devicetree/bindings/video/ti,tfp410.txt b/Documentation/devicetree/bindings/video/ti,tfp410.txt
new file mode 100644
index 000000000000..6a5a04627584
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,tfp410.txt
@@ -0,0 +1,41 @@
+TFP410 DPI to DVI encoder
+============+
+Required properties:
+- compatible: "ti,tfp410"
+
+Optional properties:
+- gpios: power-down gpio
+
+Required nodes:
+- Video port 0 for DPI input
+- Video port 1 for DVI output
+
+Example
+-------
+
+tfp410: encoder@0 {
+	compatible = "ti,tfp410";
+	gpios = <&twl_gpio 2 GPIO_ACTIVE_LOW>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			tfp410_in: endpoint@0 {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			tfp410_out: endpoint@0 {
+				remote-endpoint = <&dvi_connector_in>;
+			};
+		};
+	};
+};
-- 
1.8.3.2

