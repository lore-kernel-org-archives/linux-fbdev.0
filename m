From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Sep 2015 09:32:02 +0000
Subject: [PATCHv4 3/3] devicetree: Add led-backlight binding
Message-Id: <1443605522-1118-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

Add DT binding for led-backlight.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 .../bindings/video/backlight/led-backlight.txt     | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/led-backlight.txt

diff --git a/Documentation/devicetree/bindings/video/backlight/led-backlight.txt b/Documentation/devicetree/bindings/video/backlight/led-backlight.txt
new file mode 100644
index 000000000000..d4621d7414bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/led-backlight.txt
@@ -0,0 +1,30 @@
+led-backlight bindings
+
+Required properties:
+  - compatible: "led-backlight"
+  - leds: phandle to a led OF node [0]
+  - brightness-levels: Array of distinct LED brightness levels. These
+      are in the range from 0 to 255, passed to the LED class driver.
+  - default-brightness-level: the default brightness level (index into the
+      array defined by the "brightness-levels" property)
+
+Optional properties:
+  - power-supply: regulator for supply voltage
+  - enable-gpios: contains a single GPIO specifier for the GPIO which enables
+                  and disables the backlight (see GPIO binding[1])
+
+[0]: Documentation/devicetree/bindings/leds/common.txt
+[1]: Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+
+	backlight {
+		compatible = "led-backlight";
+		leds = <&backlight_led>;
+
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+
+		power-supply = <&vdd_bl_reg>;
+		enable-gpios = <&gpio 58 0>;
+	};
-- 
2.1.4

