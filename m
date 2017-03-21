From: Olimpiu Dejeu <olimpiu@arcticsand.com>
Date: Tue, 21 Mar 2017 16:58:47 +0000
Subject: [PATCH v9 2/3] backlight arcxcnn devicetree bindings for ArcticSand
Message-Id: <1490115528-11044-2-git-send-email-olimpiu@arcticsand.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1490115528-11044-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1490115528-11044-1-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jingoohan1@gmail.com, bdodge@arcticsand.com, joe@perches.com, medasaro@arcticsand.com, daniel.thompson@linaro.org, lkp@intel.com, fengguang.wu@intel.com, Olimpiu Dejeu <olimpiu@arcticsand.com>

backlight: Add devicetree bindings for the Arctic Sand backlight driver
This patch provides devicetree bindings for the Arctic Sand
    driver submitted in the previous patch
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
---
v8 => v9:
- Version updated to match other patch in set. No other changes.
v7 => v8:
- Version updated to match other patch in set. No other changes.
v6 => v7:
- Version updated to match other patch in set. No other changes.
v5 => v6:
- Version updated to match other patch in set. No other changes.
v4 => v5:
- Added spaces for increased readability per Lee Jones
v3 => v4:
- Added spaces for increased readability per Lee Jones
v2 => v3:
- Version updated to match other patch in set. No other changes.
v1 => v2:
- Version updated to match other patch in set. No other changes.

 .../bindings/leds/backlight/arcxcnn_bl.txt         | 33 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt

diff --git a/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
new file mode 100644
index 0000000..ecb7731
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
@@ -0,0 +1,33 @@
+Binding for ArcticSand arc2c0608 LED driver
+
+Required properties:
+- compatible:		should be "arc,arc2c0608"
+- reg:			slave address
+
+Optional properties:
+- default-brightness:	brightness value on boot, value from: 0-4095
+- label:		The name of the backlight device
+			See Documentation/devicetree/bindings/leds/common.txt
+- led-sources:		List of enabled channels from 0 to 5.
+			See Documentation/devicetree/bindings/leds/common.txt
+
+- arc,led-config-0:	setting for register ILED_CONFIG_0
+- arc,led-config-1:	setting for register ILED_CONFIG_1
+- arc,dim-freq:		PWM mode frequence setting (bits [3:0] used)
+- arc,comp-config:	setting for register CONFIG_COMP
+- arc,filter-config:	setting for register FILTER_CONFIG
+- arc,trim-config:	setting for register IMAXTUNE
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

