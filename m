From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 18 May 2015 21:06:02 +0000
Subject: [PATCH] backlight: pwm: make use of 3rd argument to devm_gpiod_get_optional
Message-Id: <1431983162-21494-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additional
parameter that allows to specify direction and initial value for output.

This allows to drop the explicit setting of direction.

Furthermore this is one caller less that stops us making the 3rd
argument mandatory.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/backlight/pwm_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm=
_bl.c
index 3a145a643e0d..57cb9ec8be43 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -241,7 +241,8 @@ static int pwm_backlight_probe(struct platform_device *=
pdev)
 	pb->dev =3D &pdev->dev;
 	pb->enabled =3D false;
=20
-	pb->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable");
+	pb->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable",
+						  GPIOD_OUT_HIGH);
 	if (IS_ERR(pb->enable_gpio)) {
 		ret =3D PTR_ERR(pb->enable_gpio);
 		goto err_alloc;
@@ -263,9 +264,6 @@ static int pwm_backlight_probe(struct platform_device *=
pdev)
 		pb->enable_gpio =3D gpio_to_desc(data->enable_gpio);
 	}
=20
-	if (pb->enable_gpio)
-		gpiod_direction_output(pb->enable_gpio, 1);
-
 	pb->power_supply =3D devm_regulator_get(&pdev->dev, "power");
 	if (IS_ERR(pb->power_supply)) {
 		ret =3D PTR_ERR(pb->power_supply);
--=20
2.1.4

