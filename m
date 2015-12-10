From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Date: Thu, 10 Dec 2015 13:11:47 +0000
Subject: [PATCH 5/5] fbdev: omap2: panel-dpi: allow specification of a vcc regulator
Message-Id: <1449753107-11410-5-git-send-email-uwe@kleine-koenig.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

To allow supporting displays that need some logic to enable power to the
display add support for a vcc-supply property to drive a regulator.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/video/panel-dpi.txt |  1 +
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c    | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/panel-dpi.txt b/Documentation/devicetree/bindings/video/panel-dpi.txt
index 1a1d8f6f884f..eaa39d1b1279 100644
--- a/Documentation/devicetree/bindings/video/panel-dpi.txt
+++ b/Documentation/devicetree/bindings/video/panel-dpi.txt
@@ -8,6 +8,7 @@ Optional properties:
 - label: a symbolic name for the panel
 - enable-gpios: panel enable gpio
 - reset-gpios: GPIO to control the RESET pin
+- vcc-supply: phandle of regulator that will be used to enable power to the display
 
 Required nodes:
 - "panel-timing" containing video timings
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
index 7e2f9e0813dc..65c6d9e6862b 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/regulator/consumer.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -33,6 +34,7 @@ struct panel_drv_data {
 
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *reset_gpio;
+	struct regulator *vcc_supply;
 };
 
 #define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev)
@@ -84,6 +86,12 @@ static int panel_dpi_enable(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
+	r = regulator_enable(ddata->vcc_supply);
+	if (r) {
+		in->ops.dpi->disable(in);
+		return r;
+	}
+
 	gpiod_set_value_cansleep(ddata->reset_gpio, 0);
 	gpiod_set_value_cansleep(ddata->enable_gpio, 1);
 
@@ -107,6 +115,7 @@ static void panel_dpi_disable(struct omap_dss_device *dssdev)
 		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
 
 	gpiod_set_value_cansleep(ddata->enable_gpio, 0);
+	regulator_disable(ddata->vcc_supply);
 
 	in->ops.dpi->disable(in);
 
@@ -218,6 +227,10 @@ static int panel_dpi_probe_of(struct platform_device *pdev)
 	if (IS_ERR(ddata->reset_gpio))
 		return PTR_ERR(ddata->reset_gpio);
 
+	ddata->vcc_supply = devm_regulator_get(&pdev->dev, "vcc");
+	if (IS_ERR(ddata->vcc_supply))
+		return PTR_ERR(ddata->vcc_supply);
+
 	ddata->backlight_gpio = -ENOENT;
 
 	r = of_get_display_timing(node, "panel-timing", &timing);
-- 
2.6.2

