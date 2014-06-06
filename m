From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Fri, 06 Jun 2014 11:02:09 +0000
Subject: [PATCH] pwm-backlight:
Message-Id: <1402052529-22761-1-git-send-email-LW@KARO-electronics.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

commit 257462dbf3ed pwm-backlight: switch to gpiod interface
introduced a regression leading to acquiring a bogus GPIO-0 when
configured from DT without an 'enable-gpios' property.
The driver will happily accept the 0 initialized 'enable_gpio' member
of the struct platform_pwm_backlight_data as valid gpio number, and
request this GPIO as enable pin. In case of multiple driver instances,
the second will fail to register with the error message:
pwm-backlight backlight1.23: failed to request GPIO#0: -16

Fix this by setting enable_gpio in the pdata struct to -EINVAL.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/video/backlight/pwm_bl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm=
_bl.c
index 38ca88b..3d265c4 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -178,7 +178,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		data->dft_brightness =3D value;
 		data->max_brightness--;
 	}
-
+	data->enable_gpio =3D -EINVAL;
 	return 0;
 }
=20
--=20
1.7.10.4

