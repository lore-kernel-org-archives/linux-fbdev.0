From: David Lechner <david@lechnology.com>
Date: Sat, 29 Jul 2017 19:17:48 +0000
Subject: [PATCH 4/6] drm/tinydrm: mipi-panel: refactor to use driver id
Message-Id: <1501355870-13960-5-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This refactors the mipi-panel module to use the driver id for panel-specific
data. This is in preparation for adding additional panels.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/tinydrm/mipi-panel.c | 40 ++++++++++++++++++++++++++++--------
 include/drm/tinydrm/mipi-dbi.h       |  2 ++
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tinydrm/mipi-panel.c b/drivers/gpu/drm/tinydrm/mipi-panel.c
index 64344f0..8aa1d8e 100644
--- a/drivers/gpu/drm/tinydrm/mipi-panel.c
+++ b/drivers/gpu/drm/tinydrm/mipi-panel.c
@@ -21,7 +21,18 @@
 #include <linux/spi/spi.h>
 #include <video/mipi_display.h>
 
-static int mipi_panel_init(struct mipi_dbi *mipi)
+enum mipi_panel_type {
+	MIPI_PANEL_TYPE_UNKNOWN,
+	MIPI_PANEL_TYPE_MULTI_INNO_MI0283QT,
+};
+
+struct mipi_panel_info {
+	int (*init)(struct mipi_dbi *mipi);
+	const struct drm_display_mode mode;
+	enum mipi_dcs_pixel_format pixel_fmt;
+};
+
+static int mipi_panel_init_ili9341(struct mipi_dbi *mipi)
 {
 	struct tinydrm_device *tdev = &mipi->tinydrm;
 	struct device *dev = tdev->drm->dev;
@@ -129,8 +140,12 @@ static const struct drm_simple_display_pipe_funcs mipi_panel_pipe_funcs = {
 	.prepare_fb = tinydrm_display_pipe_prepare_fb,
 };
 
-static const struct drm_display_mode mipi_panel_mode = {
-	TINYDRM_MODE(320, 240, 58, 43),
+static const struct mipi_panel_info mipi_panel_infos[] = {
+	[MIPI_PANEL_TYPE_MULTI_INNO_MI0283QT] = {
+		.init		= mipi_panel_init_ili9341,
+		.mode		= { TINYDRM_MODE(320, 240, 58, 43) },
+		.pixel_fmt	= MIPI_DCS_PIXEL_FMT_16BIT,
+	},
 };
 
 DEFINE_DRM_GEM_CMA_FOPS(mipi_panel_fops);
@@ -156,13 +171,15 @@ static const struct of_device_id mipi_panel_of_match[] = {
 MODULE_DEVICE_TABLE(of, mipi_panel_of_match);
 
 static const struct spi_device_id mipi_panel_id[] = {
-	{ "mi0283qt", 0 },
+	{ "mi0283qt", MIPI_PANEL_TYPE_MULTI_INNO_MI0283QT },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, mipi_panel_id);
 
 static int mipi_panel_probe(struct spi_device *spi)
 {
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	enum mipi_panel_type type = id->driver_data;
 	struct device *dev = &spi->dev;
 	struct tinydrm_device *tdev;
 	struct mipi_dbi *mipi;
@@ -170,10 +187,17 @@ static int mipi_panel_probe(struct spi_device *spi)
 	u32 rotation = 0;
 	int ret;
 
+	if (type = MIPI_PANEL_TYPE_UNKNOWN) {
+		dev_err(dev, "Unknown panel type\n");
+		return -EINVAL;
+	}
+
 	mipi = devm_kzalloc(dev, sizeof(*mipi), GFP_KERNEL);
 	if (!mipi)
 		return -ENOMEM;
 
+	mipi->init = mipi_panel_infos[type].init;
+
 	mipi->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(mipi->reset)) {
 		dev_err(dev, "Failed to get gpio 'reset'\n");
@@ -197,12 +221,12 @@ static int mipi_panel_probe(struct spi_device *spi)
 	device_property_read_u32(dev, "rotation", &rotation);
 
 	ret = mipi_dbi_spi_init(spi, mipi, dc, &mipi_panel_pipe_funcs,
-				&mipi_panel_driver, &mipi_panel_mode,
-				MIPI_DCS_PIXEL_FMT_16BIT, rotation);
+				&mipi_panel_driver, &mipi_panel_infos[type].mode,
+				mipi_panel_infos[type].pixel_fmt, rotation);
 	if (ret)
 		return ret;
 
-	ret = mipi_panel_init(mipi);
+	ret = mipi->init(mipi);
 	if (ret)
 		return ret;
 
@@ -255,7 +279,7 @@ static int __maybe_unused mipi_panel_pm_resume(struct device *dev)
 	struct mipi_dbi *mipi = dev_get_drvdata(dev);
 	int ret;
 
-	ret = mipi_panel_init(mipi);
+	ret = mipi->init(mipi);
 	if (ret)
 		return ret;
 
diff --git a/include/drm/tinydrm/mipi-dbi.h b/include/drm/tinydrm/mipi-dbi.h
index dda100c..f7ae5ae 100644
--- a/include/drm/tinydrm/mipi-dbi.h
+++ b/include/drm/tinydrm/mipi-dbi.h
@@ -25,6 +25,7 @@ struct regulator;
  * @spi: SPI device
  * @enabled: Pipeline is enabled
  * @cmdlock: Command lock
+ * @init: Panel specific callback executing initialization command sequence.
  * @command: Bus specific callback executing commands.
  * @read_commands: Array of read commands terminated by a zero entry.
  *                 Reading is disabled if this is NULL.
@@ -44,6 +45,7 @@ struct mipi_dbi {
 	struct spi_device *spi;
 	bool enabled;
 	struct mutex cmdlock;
+	int (*init)(struct mipi_dbi *mipi);
 	int (*command)(struct mipi_dbi *mipi, u8 cmd, u8 *param, size_t num);
 	const u8 *read_commands;
 	struct gpio_desc *dc;
-- 
2.7.4

