From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 May 2014 10:10:37 +0000
Subject: [PATCH 3/3] Doc/DT: Add binding doc for lgphilips,lb035q02.txt
Message-Id: <1400148637-17726-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

Add DT bindings documentation for LG.Philips LB035Q02 LCD panel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 .../bindings/video/lgphilips,lb035q02.txt          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt

diff --git a/Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt b/Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt
new file mode 100644
index 000000000000..1a1e653e5407
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt
@@ -0,0 +1,33 @@
+LG.Philips LB035Q02 Panel
+============+
+Required properties:
+- compatible: "lgphilips,lb035q02"
+- enable-gpios: panel enable gpio
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
+	compatible = "lgphilips,lb035q02";
+	reg = <0>;
+	spi-max-frequency = <100000>;
+	spi-cpol;
+	spi-cpha;
+
+	label = "lcd";
+
+	enable-gpios = <&gpio7 7 0>;
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+	};
+};
-- 
1.9.1

