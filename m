From: Andreas Kemnade <andreas@kemnade.info>
Date: Thu, 12 Sep 2019 21:32:56 +0000
Subject: [PATCH v4 1/2] dt-bindings: backlight: lm3630a: add enable_gpios
Message-Id: <20190912213257.24147-2-andreas@kemnade.info>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190912213257.24147-1-andreas@kemnade.info>
In-Reply-To: <20190912213257.24147-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>

add enable-gpios to describe HWEN pin

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
changes in v2: added example
changes in v3: added Acked-by
changes in v4: moved enable-gpios to the right position
  in the example
 .../bindings/leds/backlight/lm3630a-backlight.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
index dc129d9a329e..c8470628fe02 100644
--- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
@@ -29,6 +29,10 @@ properties:
   '#size-cells':
     const: 0
 
+  enable-gpios:
+    description: GPIO to use to enable/disable the backlight (HWEN pin).
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -96,6 +100,7 @@ examples:
         led-controller@38 {
                 compatible = "ti,lm3630a";
                 reg = <0x38>;
+                enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
 
                 #address-cells = <1>;
                 #size-cells = <0>;
-- 
2.20.1
