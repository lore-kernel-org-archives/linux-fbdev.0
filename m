From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 17 Oct 2019 08:10:59 +0000
Subject: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
Message-Id: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Adam Ford <aford173@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, dri-devel@lists.freedesktop.org

A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
pwm_get_state() return the last implemented state")) changed the
semantic of pwm_get_state() and disclosed an (as it seems) common
problem in lowlevel PWM drivers. By not relying on the period and duty
cycle being retrievable from a disabled PWM this type of problem is
worked around.

Apart from this issue only calling the pwm_get_state/pwm_apply_state
combo once is also more effective.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

There are now two reports about 01ccf903edd6 breaking a backlight. As
far as I understand the problem this is a combination of the backend pwm
driver yielding surprising results and the pwm-bl driver doing things
more complicated than necessary.

So I guess this patch works around these problems. Still it would be
interesting to find out the details in the imx driver that triggers the
problem. So Adam, can you please instrument the pwm-imx27 driver to
print *state at the beginning of pwm_imx27_apply() and the end of
pwm_imx27_get_state() and provide the results?

Note I only compile tested this change.

Best regards
Uwe

 drivers/video/backlight/pwm_bl.c | 34 +++++++++++---------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm=
_bl.c
index 746eebc411df..ddebd62b3978 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -42,10 +42,8 @@ struct pwm_bl_data {
=20
 static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 {
-	struct pwm_state state;
 	int err;
=20
-	pwm_get_state(pb->pwm, &state);
 	if (pb->enabled)
 		return;
=20
@@ -53,9 +51,6 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
=20
-	state.enabled =3D true;
-	pwm_apply_state(pb->pwm, &state);
-
 	if (pb->post_pwm_on_delay)
 		msleep(pb->post_pwm_on_delay);
=20
@@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data *=
pb)
=20
 static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 {
-	struct pwm_state state;
-
-	pwm_get_state(pb->pwm, &state);
-	if (!pb->enabled)
-		return;
-
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 0);
=20
 	if (pb->pwm_off_delay)
 		msleep(pb->pwm_off_delay);
=20
-	state.enabled =3D false;
-	state.duty_cycle =3D 0;
-	pwm_apply_state(pb->pwm, &state);
-
 	regulator_disable(pb->power_supply);
 	pb->enabled =3D false;
 }
=20
-static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
+static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness, stru=
ct pwm_state *state)
 {
 	unsigned int lth =3D pb->lth_brightness;
-	struct pwm_state state;
 	u64 duty_cycle;
=20
-	pwm_get_state(pb->pwm, &state);
-
 	if (pb->levels)
 		duty_cycle =3D pb->levels[brightness];
 	else
 		duty_cycle =3D brightness;
=20
-	duty_cycle *=3D state.period - lth;
+	duty_cycle *=3D state->period - lth;
 	do_div(duty_cycle, pb->scale);
=20
 	return duty_cycle + lth;
@@ -122,12 +104,20 @@ static int pwm_backlight_update_status(struct backlig=
ht_device *bl)
=20
 	if (brightness > 0) {
 		pwm_get_state(pb->pwm, &state);
-		state.duty_cycle =3D compute_duty_cycle(pb, brightness);
+		state.duty_cycle =3D compute_duty_cycle(pb, brightness, &state);
+		state.enabled =3D true;
 		pwm_apply_state(pb->pwm, &state);
+
 		pwm_backlight_power_on(pb);
-	} else
+	} else {
 		pwm_backlight_power_off(pb);
=20
+		pwm_get_state(pb->pwm, &state);
+		state.enabled =3D false;
+		state.duty_cycle =3D 0;
+		pwm_apply_state(pb->pwm, &state);
+	}
+
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, brightness);
=20
--=20
2.23.0
