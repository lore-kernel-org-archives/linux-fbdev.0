From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Tue, 01 Mar 2016 10:47:03 +0000
Subject: [PATCH RFC] video: fbdev: imxfb: make the driver cooperate
Message-Id: <1456829223-1526-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

The .get_power and .set_power callbacks didn't adhere to the expected(?)
convention to enable the power when the power parameter is zero.
Moreover ensure that the regulator is enabled together with the lcd
controller.

Without these changes there is nothing visible after bootup because the
regulator is kept off (or disabled by the regulator core because it's not
used). The lcd regulator is enabled only after 10 minutes of idle when it
should really go off.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this introduces a new warning because the return value of regulator_enable
isn't checked. If it's agreed that the patch is ok in general I can fix this
up, but I don't know if fbdev is already too dead even for fixes like this.

Best regards
Uwe

 drivers/video/fbdev/imxfb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index cee88603efc9..7d763164820c 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -499,6 +499,9 @@ static void imxfb_enable_controller(struct imxfb_info *=
fbi)
 	clk_prepare_enable(fbi->clk_ipg);
 	clk_prepare_enable(fbi->clk_ahb);
 	clk_prepare_enable(fbi->clk_per);
+	if (!IS_ERR(fbi->lcd_pwr))
+		regulator_enable(fbi->lcd_pwr);
+
 	fbi->enabled =3D true;
 }
=20
@@ -513,6 +516,8 @@ static void imxfb_disable_controller(struct imxfb_info =
*fbi)
 	clk_disable_unprepare(fbi->clk_ipg);
 	clk_disable_unprepare(fbi->clk_ahb);
 	fbi->enabled =3D false;
+	if (!IS_ERR(fbi->lcd_pwr))
+		regulator_disable(fbi->lcd_pwr);
=20
 	writel(0, fbi->regs + LCDC_RMCR);
 }
@@ -759,9 +764,9 @@ static int imxfb_lcd_get_power(struct lcd_device *lcdde=
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
@@ -769,7 +774,7 @@ static int imxfb_lcd_set_power(struct lcd_device *lcdde=
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

