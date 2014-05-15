From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 May 2014 10:10:35 +0000
Subject: [PATCH 1/3] OMAPDSS: panel-lgphilips-lb035q02: use gpiod for enable gpio
Message-Id: <1400148637-17726-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The new gpiod API supports automatic handling of active-high/active-low
with DT. To make it possible to use that when booting with DT, change
the driver's handling of the enable GPIO to use gpiod.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../omap2/displays-new/panel-lgphilips-lb035q02.c  | 32 ++++++++++++----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
index 2e6b513222d9..6e6acd696a70 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
@@ -50,9 +50,10 @@ struct panel_drv_data {
 
 	struct omap_video_timings videomode;
 
-	int reset_gpio;
+	/* used for non-DT boot, to be removed */
 	int backlight_gpio;
-	int enable_gpio;
+
+	struct gpio_desc *enable_gpio;
 };
 
 #define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev)
@@ -165,8 +166,8 @@ static int lb035q02_enable(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
-	if (gpio_is_valid(ddata->enable_gpio))
-		gpio_set_value_cansleep(ddata->enable_gpio, 1);
+	if (ddata->enable_gpio)
+		gpiod_set_value_cansleep(ddata->enable_gpio, 1);
 
 	if (gpio_is_valid(ddata->backlight_gpio))
 		gpio_set_value_cansleep(ddata->backlight_gpio, 1);
@@ -184,8 +185,8 @@ static void lb035q02_disable(struct omap_dss_device *dssdev)
 	if (!omapdss_device_is_enabled(dssdev))
 		return;
 
-	if (gpio_is_valid(ddata->enable_gpio))
-		gpio_set_value_cansleep(ddata->enable_gpio, 0);
+	if (ddata->enable_gpio)
+		gpiod_set_value_cansleep(ddata->enable_gpio, 0);
 
 	if (gpio_is_valid(ddata->backlight_gpio))
 		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
@@ -243,6 +244,7 @@ static int lb035q02_probe_pdata(struct spi_device *spi)
 	const struct panel_lb035q02_platform_data *pdata;
 	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
 	struct omap_dss_device *dssdev, *in;
+	int r;
 
 	pdata = dev_get_platdata(&spi->dev);
 
@@ -260,10 +262,19 @@ static int lb035q02_probe_pdata(struct spi_device *spi)
 	dssdev = &ddata->dssdev;
 	dssdev->name = pdata->name;
 
-	ddata->enable_gpio = pdata->enable_gpio;
+	r = devm_gpio_request_one(&spi->dev, pdata->enable_gpio,
+					GPIOF_OUT_INIT_LOW, "panel enable");
+	if (r)
+		goto err_gpio;
+
+	ddata->enable_gpio = gpio_to_desc(pdata->enable_gpio);
+
 	ddata->backlight_gpio = pdata->backlight_gpio;
 
 	return 0;
+err_gpio:
+	omap_dss_put_device(ddata->in);
+	return r;
 }
 
 static int lb035q02_panel_spi_probe(struct spi_device *spi)
@@ -288,13 +299,6 @@ static int lb035q02_panel_spi_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	if (gpio_is_valid(ddata->enable_gpio)) {
-		r = devm_gpio_request_one(&spi->dev, ddata->enable_gpio,
-				GPIOF_OUT_INIT_LOW, "panel enable");
-		if (r)
-			goto err_gpio;
-	}
-
 	if (gpio_is_valid(ddata->backlight_gpio)) {
 		r = devm_gpio_request_one(&spi->dev, ddata->backlight_gpio,
 				GPIOF_OUT_INIT_LOW, "panel backlight");
-- 
1.9.1

