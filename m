From: Olimpiu Dejeu <olimpiu@arcticsand.com>
Date: Fri, 18 Nov 2016 15:17:41 +0000
Subject: [PATCH 2/2] backlight: arcxcnn: devicetree bindings for ArticSand devices
Message-Id: <1479482261-19072-1-git-send-email-olimpiu@arcticsand.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1475166937-6299-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1475166937-6299-1-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jingoohan1@gmail.com, Olimpiu Dejeu <olimpiu@arcticsand.com>

Re-submission of arcxcnn backlight driver addressing the naming convention
 concerns raised by Rob H. Note that all the device tree properties are
 determined by the board design or IC EPROM settings and are not intended
 to be user adjustable.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>

---
 .../bindings/leds/backlight/arcxcnn_bl.txt         | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt

diff --git a/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
new file mode 100644
index 0000000..a7b6ff2
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
@@ -0,0 +1,33 @@
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
+- arc,led-config-0: setting for register ILED_CONFIG_0
+- arc,led-config-1: setting for register ILED_CONFIG_1
+- arc,dim-freq: PWM mode frequence setting (bits [3:0] used)
+- arc,comp-config: setting for register CONFIG_COMP
+- arc,filter-config: setting for register FILTER_CONFIG
+- arc,trim-config: setting for register IMAXTUNE
+
+Note: Optional properties not specified will default to values in IC EPROM
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
+};
+
-- 
2.7.4

