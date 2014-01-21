From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Jan 2014 10:57:06 +0000
Subject: [PATCHv3 34/41] Doc/DT: Add DT binding documentation for Analog TV Connector
Message-Id: <1390301833-24944-35-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

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

