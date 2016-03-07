From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 07 Mar 2016 19:53:43 +0000
Subject: [PATCH 1/3] video: fbdev: imxfb: fix semantic of .get_power and .set_power
Message-Id: <1457380425-20244-2-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

.set_power gets passed an FB_BLANK_XXX value, not a bool. So 0 signals
on; and >1 means off. The same applies for return values of .get_power.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/imxfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index cee88603efc9..c5fcedde2a60 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -759,9 +759,9 @@ static int imxfb_lcd_get_power(struct lcd_device *lcdde=
v)
 	struct imxfb_info *fbi =3D dev_get_drvdata(&lcddev->dev);
=20
 	if (!IS_ERR(fbi->lcd_pwr))
-		return regulator_is_enabled(fbi->lcd_pwr);
+		return !regulator_is_enabled(fbi->lcd_pwr);
=20
-	return 1;
+	return 0;
 }
=20
 static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
@@ -769,7 +769,7 @@ static int imxfb_lcd_set_power(struct lcd_device *lcdde=
v, int power)
 	struct imxfb_info *fbi =3D dev_get_drvdata(&lcddev->dev);
=20
 	if (!IS_ERR(fbi->lcd_pwr)) {
-		if (power)
+		if (!power)
 			return regulator_enable(fbi->lcd_pwr);
 		else
 			return regulator_disable(fbi->lcd_pwr);
--=20
2.7.0

