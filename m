From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 16 May 2014 07:30:01 +0000
Subject: [PATCH 3/4] Doc/DT: Add DT binding documentation for SHARP LS037V7DW01
Message-Id: <1400225402-18274-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400225402-18274-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1400225402-18274-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Tony Lindgren <tony@atomide.com>

Add DT binding documentation for SHARP LS037V7DW01 panel.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 .../bindings/video/sharp,ls037v7dw01.txt           | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt

diff --git a/Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt b/Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt
new file mode 100644
index 000000000000..0cc8981e9d49
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt
@@ -0,0 +1,43 @@
+SHARP LS037V7DW01 TFT-LCD panel
+=================+
+Required properties:
+- compatible: "sharp,ls037v7dw01"
+
+Optional properties:
+- label: a symbolic name for the panel
+- enable-gpios: a GPIO spec for the optional enable pin.
+  This pin is the INI pin as specified in the LS037V7DW01.pdf file.
+- reset-gpios: a GPIO spec for the optional reset pin.
+  This pin is the RESB pin as specified in the LS037V7DW01.pdf file.
+- mode-gpios: a GPIO
+  ordered MO, LR, and UD as specified in the LS037V7DW01.pdf file.
+
+Required nodes:
+- Video port for DPI input
+
+This panel can have zero to five GPIOs to configure to change configuration
+between QVGA and VGA mode and the scan direction. As these pins can be also
+configured with external pulls, all the GPIOs are considered optional with holes
+in the array.
+
+Example
+-------
+
+Example when connected to a omap2+ based device:
+
+lcd0: display {
+	compatible = "sharp,ls037v7dw01";
+	power-supply = <&lcd_3v3>;
+	enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
+	reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
+	mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
+		      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
+		      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+	};
+};
-- 
1.9.1

