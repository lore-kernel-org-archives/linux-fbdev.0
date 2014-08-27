From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Aug 2014 16:41:01 +0000
Subject: [PATCH 04/16] video: Add ADV7123 DT bindings documentation
Message-Id: <1409157673-4154-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-sh@vger.kernel.org

The ADV7123 is a video DAC described by an input port, an output port,
and an optional power save GPIO.

Cc: devicetree@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../devicetree/bindings/video/adi,adv7123.txt      | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/adi,adv7123.txt

diff --git a/Documentation/devicetree/bindings/video/adi,adv7123.txt b/Documentation/devicetree/bindings/video/adi,adv7123.txt
new file mode 100644
index 0000000..a6b2b2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/adi,adv7123.txt
@@ -0,0 +1,50 @@
+Analog Device ADV7123 Video DAC
+-------------------------------
+
+The ADV7123 is a digital-to-analog converter that outputs VGA signals from a
+parallel video input.
+
+Required properties:
+
+- compatible: Should be "adi,adv7123"
+
+Optional properties:
+
+- psave-gpios: Power save control GPIO
+
+Required nodes:
+
+The ADV7123 has two video ports. Their connections are modeled using the OF
+graph bindings specified in Documentation/devicetree/bindings/graph.txt.
+
+- Video port 0 for DPI input
+- Video port 1 for VGA output
+
+
+Example
+-------
+
+	adv7123: encoder@0 {
+		compatible = "adi,adv7123";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				adv7123_in: endpoint@0 {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				adv7123_out: endpoint@0 {
+					remote-endpoint = <&vga_connector_in>;
+				};
+			};
+		};
+	};
-- 
1.8.5.5

