From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Sun, 20 Dec 2015 11:13:21 +0000
Subject: [PATCH v2 2/3] fbdev: omap2: panel-dpi: make (limited) use of a reset gpio
Message-Id: <1450610002-10531-3-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Some displays have a reset input. To assert that the display is
functional the reset gpio must be deasserted.

Teach the driver to get and drive such a gpio accordingly.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
--
Changes since (implicit) v1, sent with
Message-Id: 1449753107-11410-4-git-send-email-uwe@kleine-koenig.org :

 - never assert reset because there are too many different panels with
   too many different needs for their reset.
 - split out dt binding changes
 - reword commit log
---
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers/v=
ideo/fbdev/omap2/displays-new/panel-dpi.c
index e780fd4f8b46..201a1c1a6f42 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -213,6 +213,16 @@ static int panel_dpi_probe_of(struct platform_device *=
pdev)
=20
 	ddata->enable_gpio =3D gpio;
=20
+	/*
+	 * Many different panels are supported by this driver and there are
+	 * probably very different needs for their reset pins in regards to
+	 * timing and order relative to the enable gpio. So for now it's just
+	 * ensured that the reset line isn't active.
+	 */
+	gpio =3D devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+
 	ddata->backlight_gpio =3D -ENOENT;
=20
 	r =3D of_get_display_timing(node, "panel-timing", &timing);
--=20
2.6.2

