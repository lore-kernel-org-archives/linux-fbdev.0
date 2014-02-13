From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Feb 2014 12:32:26 +0000
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <1392294752-18762-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392294752-18762-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1392294752-18762-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Add DT binding documentation for DVI Connector.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/video/dvi-connector.txt    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/dvi-connector.txt

diff --git a/Documentation/devicetree/bindings/video/dvi-connector.txt b/Documentation/devicetree/bindings/video/dvi-connector.txt
new file mode 100644
index 000000000000..6a0aff866c78
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/dvi-connector.txt
@@ -0,0 +1,26 @@
+DVI Connector
+=======
+
+Required properties:
+- compatible: "dvi-connector"
+
+Optional properties:
+- label: a symbolic name for the connector
+- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
+
+Required nodes:
+- Video port for DVI input
+
+Example
+-------
+
+dvi0: connector@0 {
+	compatible = "dvi-connector";
+	label = "dvi";
+
+	i2c-bus = <&i2c3>;
+
+	dvi_connector_in: endpoint {
+		remote-endpoint = <&tfp410_out>;
+	};
+};
-- 
1.8.3.2

