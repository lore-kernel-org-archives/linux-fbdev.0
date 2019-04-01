From: Brian Masney <masneyb@onstation.org>
Date: Mon, 01 Apr 2019 10:30:33 +0000
Subject: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <20190401103034.21062-3-masneyb@onstation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
In-Reply-To: <20190401103034.21062-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org
Cc: jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca

Add new backlight bindings for the TI LM3630A dual-string white LED.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../leds/backlight/lm3630a-backlight.yaml     | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
new file mode 100644
index 000000000000..42a8c59d237a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/lm3630a-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LM3630A High-Efficiency Dual-String White LED
+
+maintainers:
+  - Lee Jones <lee.jones@linaro.org>
+  - Daniel Thompson <daniel.thompson@linaro.org>
+  - Jingoo Han <jingoohan1@gmail.com>
+
+description: |
+  The LM3630A is a current-mode boost converter which supplies the power and
+  controls the current in up to two strings of 10 LEDs per string.
+  https://www.ti.com/product/LM3630A
+
+properties:
+  compatible:
+    const: ti,lm3630a
+
+  reg:
+    maxItems: 1
+
+  ti,linear-mapping-mode:
+    description: |
+      Enable linear mapping mode. If disabled, then it will use exponential
+      mapping mode in which the ramp up/down appears to have a more uniform
+      tranisiton to the human eye.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^led*$":
+    type: object
+    description: |
+      Properties for a string of connected LEDs.
+
+    properties:
+      label:
+        description: |
+          The label for this LED. If omitted, the label is taken from the node
+          name (excluding the unit address). It has to uniquely identify a
+          device, i.e. no other LED class device can be assigned the same label.
+
+      led-sources:
+        description: |
+          List of device current outputs the LED is connected to.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+          - minItems: 1
+            maxItems: 2
+            items:
+              minimum: 0
+              maximum: 1
+
+      default-brightness:
+        description: Default brightness level on boot.
+        minimum: 0
+        maximum: 255
+
+      max-brightness:
+        description: Maximum brightness level on boot.
+        minimum: 0
+        maximum: 255
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lm3630a_bl@38 {
+                compatible = "ti,lm3630a";
+                status = "ok";
+                reg = <0x38>;
+
+                led {
+                        label = "main-lcd";
+                        led-sources = <0 1>;
+                        default-brightness = <200>;
+                        max-brightness = <255>;
+                };
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lm3630a_bl@38 {
+                compatible = "ti,lm3630a";
+                status = "ok";
+                reg = <0x38>;
+
+                led-bank-a {
+                        led-sources = <0>;
+                        default-brightness = <150>;
+                        ti,linear-mapping-mode;
+                };
+
+                led-bank-b {
+                        led-sources = <1>;
+                        default-brightness = <225>;
+                        ti,linear-mapping-mode;
+                };
+        };
+    };
-- 
2.20.1
