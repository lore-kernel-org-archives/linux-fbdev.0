From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Mon, 06 Jun 2016 10:44:56 +0000
Subject: [PATCH] backlight: pwm_bl: disable PWM when 'duty_cycle' is zero
Message-Id: <1465209896-10319-1-git-send-email-LW@KARO-electronics.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

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
 drivers/video/backlight/pwm_bl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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

