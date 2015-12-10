From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Date: Thu, 10 Dec 2015 13:11:46 +0000
Subject: [PATCH 4/5] fbdev: omap2: panel-dpi: allow specification of a reset gpio
Message-Id: <1449753107-11410-4-git-send-email-uwe@kleine-koenig.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Some displays have a reset input. To assert that the display is
functional the reset gpio must be deasserted.

Teach the driver to get and drive such a gpio accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/video/panel-dpi.txt | 1 +
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/panel-dpi.txt b/Documentation/devicetree/bindings/video/panel-dpi.txt
index a40180b05bab..1a1d8f6f884f 100644
--- a/Documentation/devicetree/bindings/video/panel-dpi.txt
+++ b/Documentation/devicetree/bindings/video/panel-dpi.txt
@@ -7,6 +7,7 @@ Required properties:
 Optional properties:
 - label: a symbolic name for the panel
 - enable-gpios: panel enable gpio
+- reset-gpios: GPIO to control the RESET pin
 
 Required nodes:
 - "panel-timing" containing video timings
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
index 1216341a0d19..7e2f9e0813dc 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -32,6 +32,7 @@ struct panel_drv_data {
 	int backlight_gpio;
 
 	struct gpio_desc *enable_gpio;
+	struct gpio_desc *reset_gpio;
 };
 
 #define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev)
@@ -83,6 +84,7 @@ static int panel_dpi_enable(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
+	gpiod_set_value_cansleep(ddata->reset_gpio, 0);
 	gpiod_set_value_cansleep(ddata->enable_gpio, 1);
 
 	if (gpio_is_valid(ddata->backlight_gpio))
@@ -211,6 +213,11 @@ static int panel_dpi_probe_of(struct platform_device *pdev)
 	if (IS_ERR(ddata->enable_gpio))
 		return PTR_ERR(ddata->enable_gpio);
 
+	ddata->reset_gpio = devm_gpiod_get_optional(&pdev->dev,
+						    "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ddata->reset_gpio))
+		return PTR_ERR(ddata->reset_gpio);
+
 	ddata->backlight_gpio = -ENOENT;
 
 	r = of_get_display_timing(node, "panel-timing", &timing);
-- 
2.6.2

