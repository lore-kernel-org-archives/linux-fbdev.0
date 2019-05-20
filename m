From: Brian Masney <masneyb@onstation.org>
Date: Mon, 20 May 2019 08:58:46 +0000
Subject: [PATCH] dt-bindings: backlight: lm3630a: correct schema validation
Message-Id: <20190520085846.22320-1-masneyb@onstation.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh+dt@kernel.org, lee.jones@linaro.org
Cc: daniel.thompson@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca

The '#address-cells' and '#size-cells' properties were not defined in
the lm3630a bindings and would cause the following error when
attempting to validate the examples against the schema:

Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
'#address-cells', '#size-cells' do not match any of the regexes:
'^led@[01]$', 'pinctrl-[0-9]+'

Correct this by adding those two properties.

While we're here, move the ti,linear-mapping-mode property to the
led@[01] child nodes to correct the following validation error:

Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
led@0: 'ti,linear-mapping-mode' does not match any of the regexes:
'pinctrl-[0-9]+'

Fixes: 32fcb75c66a0 ("dt-bindings: backlight: Add lm3630a bindings")
Signed-off-by: Brian Masney <masneyb@onstation.org>
Reported-by: Rob Herring <robh+dt@kernel.org>
---
 .../leds/backlight/lm3630a-backlight.yaml     | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
index 4d61fe0a98a4..f0855e248ae5 100644
--- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
@@ -23,16 +23,17 @@ properties:
   reg:
     maxItems: 1
 
-  ti,linear-mapping-mode:
-    description: |
-      Enable linear mapping mode. If disabled, then it will use exponential
-      mapping mode in which the ramp up/down appears to have a more uniform
-      transition to the human eye.
-    type: boolean
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
 
 required:
   - compatible
   - reg
+  - '#address-cells'
+  - '#size-cells'
 
 patternProperties:
   "^led@[01]$":
@@ -73,6 +74,13 @@ patternProperties:
         minimum: 0
         maximum: 255
 
+      ti,linear-mapping-mode:
+        description: |
+          Enable linear mapping mode. If disabled, then it will use exponential
+          mapping mode in which the ramp up/down appears to have a more uniform
+          transition to the human eye.
+        type: boolean
+
     required:
       - reg
 
-- 
2.20.1
