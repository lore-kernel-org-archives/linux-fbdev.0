From: gyungoh@gmail.com
Date: Thu, 05 Feb 2015 06:31:15 +0000
Subject: [PATCH v11 4/6] devicetree: Add new SKY81452 backlight binding
Message-Id: <1423117877-30667-5-git-send-email-jack.yoo@skyworksinc.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423117877-30667-1-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1423117877-30667-1-git-send-email-jack.yoo@skyworksinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sameo@linux.intel.com, lee.jones@linaro.org, grant.likely@linaro.org, robh+dt@kernel.org, jg1.han@samsung.com, cooloney@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org
Cc: akpm@linux-foundation.org, jic23@kernel.org, thomas.petazzoni@free-electrons.com, ktsai@capellamicro.com, hs@denx.de, stwiss.opensource@diasemi.com, matti.vaittinen@nsn.com, broonie@kernel.org, jason@lakedaemon.net, heiko@sntech.de, shawn.guo@freescale.com, florian.vaussard@epfl.ch, andrew@lunn.ch, antonynpavlov@gmail.com, hytszk@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jack.yoo@skyworksinc.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

From: Gyungoh Yoo <jack.yoo@skyworksinc.com>

Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
Acked-by: Bryan Wu <cooloney@gmail.com>
---
Changes v11:
Renamed 'skyworks,en-channels' property to led-sources.
Removed unused property 'skyworks,ovp-level'.

Changes v10:
Nothing

Changes v9:
Nothing

Changes v8:
Renamed property names for backlight with vendor prefix
Modified gpio-enable property to generic property for GPIO
Made up the example for backlight DT

Changes v7:
Nothing

Changes v6:
Nothing

Changes v5:
Nothing

Changes v4:
Nothing

Changes v3:
Nothing

Changes v2:
Added reg attribute for I2C slave address

 .../video/backlight/sky81452-backlight.txt         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt

diff --git a/Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt b/Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt
new file mode 100644
index 0000000..8bf2940
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt
@@ -0,0 +1,29 @@
+SKY81452-backlight bindings
+
+Required properties:
+- compatible		: Must be "skyworks,sky81452-backlight"
+
+Optional properties:
+- name			: Name of backlight device. Default is 'lcd-backlight'.
+- gpios			: GPIO to use to EN pin.
+			See Documentation/devicetree/bindings/gpio/gpio.txt
+- led-sources		: List of enabled channels from 0 to 5.
+			See Documentation/devicetree/bindings/leds/common.txt
+- skyworks,ignore-pwm	: Ignore both PWM input
+- skyworks,dpwm-mode	: Enable DPWM dimming mode, otherwise Analog dimming.
+- skyworks,phase-shift	: Enable phase shift mode
+- skyworks,short-detection-threshold-volt
+			: It should be one of 4, 5, 6 and 7V.
+- skyworks,current-limit-mA
+			: It should be 2300mA or 2750mA.
+
+Example:
+
+	backlight {
+		compatible = "skyworks,sky81452-backlight";
+		name = "pwm-backlight";
+		led-sources = <0 1 2 5>;
+		skyworks,ignore-pwm;
+		skyworks,phase-shift;
+		skyworks,current-limit-mA = <2300>;
+	};
-- 
1.9.1

