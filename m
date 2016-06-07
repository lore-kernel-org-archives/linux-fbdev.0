From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Tue, 07 Jun 2016 10:13:49 +0000
Subject: [PATCHv2] backlight: pwm_bl: disable PWM when 'duty_cycle' is zero
Message-Id: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

'brightness' is usually an index into a table of duty_cycle values,
where the value at index 0 may well be non-zero
(tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are real-life
examples).
Thus brightness =3D 0 does not necessarily mean that the PWM output
will be inactive.
Check for 'duty_cycle =3D 0' rather than 'brightness =3D 0' to decide
whether to disable the PWM.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
Changes wrt. v1:
  - update binding docs to reflect the change

 .../devicetree/bindings/leds/backlight/pwm-backlight.txt         | 9 +++++=
+---
 drivers/video/backlight/pwm_bl.c                                 | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight=
.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
index 764db86..95fa8a9 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
@@ -4,10 +4,13 @@ Required properties:
   - compatible: "pwm-backlight"
   - pwms: OF device-tree PWM specification (see PWM binding[0])
   - brightness-levels: Array of distinct brightness levels. Typically these
-      are in the range from 0 to 255, but any range starting at 0 will do.
+      are in the range from 0 to 255, but any range will do.
       The actual brightness level (PWM duty cycle) will be interpolated
-      from these values. 0 means a 0% duty cycle (darkest/off), while the
-      last value in the array represents a 100% duty cycle (brightest).
+      from these values. 0 means a 0% duty cycle, while the highest value =
in
+      the array represents a 100% duty cycle.
+      The range may be in reverse order (starting with the maximum duty cy=
cle
+      value) to create a PWM signal with the 100% duty cycle representing
+      minimum and 0% duty cycle maximum brigthness.
   - default-brightness-level: the default brightness level (index into the
       array defined by the "brightness-levels" property)
   - power-supply: regulator for supply voltage
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm=
_bl.c
index b2b366b..80b2b52 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -103,8 +103,8 @@ static int pwm_backlight_update_status(struct backlight=
_device *bl)
 	if (pb->notify)
 		brightness =3D pb->notify(pb->dev, brightness);
=20
-	if (brightness > 0) {
-		duty_cycle =3D compute_duty_cycle(pb, brightness);
+	duty_cycle =3D compute_duty_cycle(pb, brightness);
+	if (duty_cycle > 0) {
 		pwm_config(pb->pwm, duty_cycle, pb->period);
 		pwm_backlight_power_on(pb, brightness);
 	} else
--=20
2.1.4

