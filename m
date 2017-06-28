From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Wed, 28 Jun 2017 11:16:31 +0000
Subject: [PATCH 1/2] dt-bindings: pwm-backlight: Add pwm-delay-us property
Message-Id: <20170628111632.22582-1-enric.balletbo@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, huang lin <hl@rock-chips.com>

From: huang lin <hl@rock-chips.com>

Add a pwm-delay-us property to specify the delay between setting an
initial (non-zero) PWM value and enabling the backlight, and also the
delay between disabling the backlight and setting PWM value to 0.

Signed-off-by: huang lin <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
index 764db86..f75b08f 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
@@ -17,6 +17,9 @@ Optional properties:
                "pwms" property (see PWM binding[0])
   - enable-gpios: contains a single GPIO specifier for the GPIO which enables
                   and disables the backlight (see GPIO binding[1])
+  - pwm-delay-us: delay between setting an initial (non-zero) PWM value and
+                  enabling the backlight, and also the delay between disabling
+                  the backlight and setting PWM value to 0.
 
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt
 [1]: Documentation/devicetree/bindings/gpio/gpio.txt
@@ -32,4 +35,5 @@ Example:
 
 		power-supply = <&vdd_bl_reg>;
 		enable-gpios = <&gpio 58 0>;
+		pwm-delay-us = <10000>;
 	};
-- 
2.9.3

