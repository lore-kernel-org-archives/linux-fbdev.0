From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 23 Mar 2020 21:16:26 +0000
Subject: [PATCH] video: fbdev: imxfb: ensure balanced regulator usage
Message-Id: <20200323211626.24812-1-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sascha Hauer <s.hauer@pengutronix.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, dri-devel@lists.freedesktop.org, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org

The fbdev framework doesn't care to call the .set_power callback only on
changes. So the driver has to care for itself that the regulator doesn't
get disabled more often than enabled.

This fixes the regulator warning

	unbalanced disables for lcd supply

which can be triggered by doing

	echo 4 > /sys/class/lcd/imxfb-lcd/lcd_power

twice.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/imxfb.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 370bf2553d43..884b16efa7e8 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -172,6 +172,7 @@ struct imxfb_info {
 	int			num_modes;
=20
 	struct regulator	*lcd_pwr;
+	int			lcd_pwr_enabled;
 };
=20
 static const struct platform_device_id imxfb_devtype[] =3D {
@@ -801,16 +802,30 @@ static int imxfb_lcd_get_power(struct lcd_device *lcd=
dev)
 	return FB_BLANK_UNBLANK;
 }
=20
+static int imxfb_regulator_set(struct imxfb_info *fbi, int enable)
+{
+	int ret;
+
+	if (enable =3D fbi->lcd_pwr_enabled)
+		return 0;
+
+	if (enable)
+		ret =3D regulator_enable(fbi->lcd_pwr);
+	else
+		ret =3D regulator_disable(fbi->lcd_pwr);
+
+	if (ret =3D 0)
+		fbi->lcd_pwr_enabled =3D enable;
+
+	return ret;
+}
+
 static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
 {
 	struct imxfb_info *fbi =3D dev_get_drvdata(&lcddev->dev);
=20
-	if (!IS_ERR(fbi->lcd_pwr)) {
-		if (power =3D FB_BLANK_UNBLANK)
-			return regulator_enable(fbi->lcd_pwr);
-		else
-			return regulator_disable(fbi->lcd_pwr);
-	}
+	if (!IS_ERR(fbi->lcd_pwr))
+		return imxfb_regulator_set(fbi, power =3D FB_BLANK_UNBLANK);
=20
 	return 0;
 }
--=20
2.25.1
