From: Olimpiu Dejeu <olimpiu@arcticsand.com>
Date: Thu, 29 Sep 2016 16:35:37 +0000
Subject: [PATCH 2/2] backlight: arcxcnn: devicetree bindings for ArticSand devices
Message-Id: <1475166937-6299-1-git-send-email-olimpiu@arcticsand.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>

Resubmition of arcxcnn backliught driver bindings correcting the file 
 location, device name, and proper use of reg for device address

Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>

---
 .../bindings/leds/backlight/arcxcnn_bl.txt         | 30 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt

diff --git a/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
new file mode 100644
index 0000000..bcf5664
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
@@ -0,0 +1,30 @@
+Binding for ArcticSand arc2c0608 LED driver
+
+Required properties:
+- compatible: should be "arc,arc2c0608"
+- reg: slave address
+
+Optional properties:
+- default-brightness: brightness value on boot, value from: 0-4095
+- label: The name of the backlight device
+			See Documentation/devicetree/bindings/leds/common.txt
+- led-sources: List of enabled channels from 0 to 5.
+			See Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+
+arc2c0608@30 {
+	compatible = "arc,arc2c0608";
+	reg = <0x30>;
+	default-brightness = <500>;
+	label = "lcd-backlight";
+	linux,default-trigger = "backlight";
+	led-sources = <0 1 2 5>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	prog@6 {
+		reg = <0x06>;
+		val = <0x0F>;
+	};
+};
+
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 1992aa9..dc8546f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -27,6 +27,7 @@ analogix	Analogix Semiconductor, Inc.
 apm	Applied Micro Circuits Corporation (APM)
 aptina	Aptina Imaging
 arasan	Arasan Chip Systems
+arc Artic Sand Technologies
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
 arrow	Arrow Electronics
-- 
2.7.4

