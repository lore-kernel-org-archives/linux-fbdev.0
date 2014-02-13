From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Feb 2014 12:32:25 +0000
Subject: [PATCH 2/9] Doc/DT: Add DT binding documentation for Analog TV Connector
Message-Id: <1392294752-18762-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392294752-18762-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1392294752-18762-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Add DT binding documentation for Analog TV Connector.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../bindings/video/analog-tv-connector.txt         | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/analog-tv-connector.txt

diff --git a/Documentation/devicetree/bindings/video/analog-tv-connector.txt b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
new file mode 100644
index 000000000000..d6be373d8705
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
@@ -0,0 +1,23 @@
+Analog TV Connector
+=========+
+Required properties:
+- compatible: "composite-connector" or "svideo-connector"
+
+Optional properties:
+- label: a symbolic name for the connector
+
+Required nodes:
+- Video port for TV input
+
+Example
+-------
+
+tv: connector {
+	compatible = "composite-connector";
+	label = "tv";
+
+	tv_connector_in: endpoint {
+		remote-endpoint = <&venc_out>;
+	};
+};
-- 
1.8.3.2

