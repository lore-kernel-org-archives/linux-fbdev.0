From: Andreas Kemnade <andreas@kemnade.info>
Date: Sun, 08 Sep 2019 20:37:04 +0000
Subject: [PATCH 2/2] dt-bindings: backlight: lm3630a: add enable_gpios
Message-Id: <20190908203704.30147-3-andreas@kemnade.info>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190908203704.30147-1-andreas@kemnade.info>
In-Reply-To: <20190908203704.30147-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andreas Kemnade <andreas@kemnade.info>

add enable-gpios to describe HWEN pin

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
index dc129d9a329e..a9656d72b668 100644
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
-- 
2.20.1
