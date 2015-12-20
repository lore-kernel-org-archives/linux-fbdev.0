From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Sun, 20 Dec 2015 11:13:22 +0000
Subject: [PATCH v2 3/3] fbdev: omap2: panel-dpi: implement support for a vcc regulator
Message-Id: <1450610002-10531-4-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

To allow supporting displays that need some logic to enable power to the
display try to get a vcc-supply property from the device tree and drive
the resulting regulator accordingly.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1, sent with
Message-Id: 1449753107-11410-5-git-send-email-uwe@kleine-koenig.org:

 - split out dt binding changes
 - reword commit log
---
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers/v=
ideo/fbdev/omap2/displays-new/panel-dpi.c
index 201a1c1a6f42..8c3f31ebff00 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/regulator/consumer.h>
=20
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -32,6 +33,7 @@ struct panel_drv_data {
 	int backlight_gpio;
=20
 	struct gpio_desc *enable_gpio;
+	struct regulator *vcc_supply;
 };
=20
 #define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev)
@@ -83,6 +85,12 @@ static int panel_dpi_enable(struct omap_dss_device *dssd=
ev)
 	if (r)
 		return r;
=20
+	r =3D regulator_enable(ddata->vcc_supply);
+	if (r) {
+		in->ops.dpi->disable(in);
+		return r;
+	}
+
 	gpiod_set_value_cansleep(ddata->enable_gpio, 1);
=20
 	if (gpio_is_valid(ddata->backlight_gpio))
@@ -105,6 +113,7 @@ static void panel_dpi_disable(struct omap_dss_device *d=
ssdev)
 		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
=20
 	gpiod_set_value_cansleep(ddata->enable_gpio, 0);
+	regulator_disable(ddata->vcc_supply);
=20
 	in->ops.dpi->disable(in);
=20
@@ -223,6 +232,10 @@ static int panel_dpi_probe_of(struct platform_device *=
pdev)
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
=20
+	ddata->vcc_supply =3D devm_regulator_get(&pdev->dev, "vcc");
+	if (IS_ERR(ddata->vcc_supply))
+		return PTR_ERR(ddata->vcc_supply);
+
 	ddata->backlight_gpio =3D -ENOENT;
=20
 	r =3D of_get_display_timing(node, "panel-timing", &timing);
--=20
2.6.2

