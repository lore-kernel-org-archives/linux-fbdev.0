From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 16 May 2014 09:55:11 +0000
Subject: [PATCH 2/3] Doc/DT: Add DT binding documentation for TPO td043mtea1 panel
Message-Id: <1400234112-29306-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400234112-29306-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1400234112-29306-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

Add DT binding documentation for TPO td043mtea1 panel

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>
---
 .../devicetree/bindings/video/tpo,td043mtea1.txt   | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/tpo,td043mtea1.txt

diff --git a/Documentation/devicetree/bindings/video/tpo,td043mtea1.txt b/Documentation/devicetree/bindings/video/tpo,td043mtea1.txt
new file mode 100644
index 000000000000..ec6d62975162
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/tpo,td043mtea1.txt
@@ -0,0 +1,33 @@
+TPO TD043MTEA1 Panel
+==========
+
+Required properties:
+- compatible: "tpo,td043mtea1"
+- reset-gpios: panel reset gpio
+
+Optional properties:
+- label: a symbolic name for the panel
+
+Required nodes:
+- Video port for DPI input
+
+Example
+-------
+
+lcd-panel: panel@0 {
+	compatible = "tpo,td043mtea1";
+	reg = <0>;
+	spi-max-frequency = <100000>;
+	spi-cpol;
+	spi-cpha;
+
+	label = "lcd";
+
+	reset-gpios = <&gpio7 7 0>;
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+	};
+};
-- 
1.9.1

