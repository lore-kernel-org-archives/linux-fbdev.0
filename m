From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 10 Sep 2019 21:29:08 +0000
Subject: [PATCH v2 1/2] dt-bindings: backlight: lm3630a: add enable_gpios
Message-Id: <20190910212909.18095-2-andreas@kemnade.info>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190910212909.18095-1-andreas@kemnade.info>
In-Reply-To: <20190910212909.18095-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andreas Kemnade <andreas@kemnade.info>

add enable-gpios to describe HWEN pin

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
changes in v2: add example
 .../bindings/leds/backlight/lm3630a-backlight.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
index dc129d9a329e..1fa83feffe16 100644
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
@@ -92,6 +96,7 @@ examples:
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
+        enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
 
         led-controller@38 {
                 compatible = "ti,lm3630a";
-- 
2.20.1
