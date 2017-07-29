From: David Lechner <david@lechnology.com>
Date: Sat, 29 Jul 2017 19:17:47 +0000
Subject: [PATCH 3/6] drm/tinydrm: rename mi028qt module to mipi-panel
Message-Id: <1501355870-13960-4-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-1-git-send-email-david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This renames the mi028qt module to mipi-panel so that it can be used for
other types of panels as well. There is no reason to copy a bunch of
boiler-plate code for each panel or controller.

Signed-off-by: David Lechner <david@lechnology.com>
---
 .../devicetree/bindings/display/mipi-panel.txt     |  27 ++
 .../bindings/display/multi-inno,mi0283qt.txt       |  27 --
 MAINTAINERS                                        |   6 +-
 drivers/gpu/drm/tinydrm/Kconfig                    |  12 +-
 drivers/gpu/drm/tinydrm/Makefile                   |   2 +-
 drivers/gpu/drm/tinydrm/mi0283qt.c                 | 283 --------------------
 drivers/gpu/drm/tinydrm/mipi-panel.c               | 284 +++++++++++++++++++++
 7 files changed, 323 insertions(+), 318 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mipi-panel.txt
 delete mode 100644 Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
 delete mode 100644 drivers/gpu/drm/tinydrm/mi0283qt.c
 create mode 100644 drivers/gpu/drm/tinydrm/mipi-panel.c

diff --git a/Documentation/devicetree/bindings/display/mipi-panel.txt b/Documentation/devicetree/bindings/display/mipi-panel.txt
new file mode 100644
index 0000000..01d6ea9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mipi-panel.txt
@@ -0,0 +1,27 @@
+MIPI DBI compatible display panel
+
+Required properties:
+- compatible:	"multi-inno,mi0283qt".
+
+The node for this driver must be a child node of a SPI controller, hence
+all mandatory properties described in ../spi/spi-bus.txt must be specified.
+
+Optional properties:
+- dc-gpios:	D/C pin. The presence/absence of this GPIO determines
+		the panel interface mode (IM[3:0] pins):
+		- present: IM=x110 4-wire 8-bit data serial interface
+		- absent:  IM=x101 3-wire 9-bit data serial interface
+- reset-gpios:	Reset pin
+- power-supply:	A regulator node for the supply voltage.
+- backlight:	phandle of the backlight device attached to the panel
+- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
+
+Example:
+	display@0{
+		compatible = "multi-inno,mi0283qt";
+		reg = <0>;
+		spi-max-frequency = <32000000>;
+		rotation = <90>;
+		dc-gpios = <&gpio 25 0>;
+		backlight = <&backlight>;
+	};
diff --git a/Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt b/Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
deleted file mode 100644
index eed48c3..0000000
--- a/Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Multi-Inno MI0283QT display panel
-
-Required properties:
-- compatible:	"multi-inno,mi0283qt".
-
-The node for this driver must be a child node of a SPI controller, hence
-all mandatory properties described in ../spi/spi-bus.txt must be specified.
-
-Optional properties:
-- dc-gpios:	D/C pin. The presence/absence of this GPIO determines
-		the panel interface mode (IM[3:0] pins):
-		- present: IM=x110 4-wire 8-bit data serial interface
-		- absent:  IM=x101 3-wire 9-bit data serial interface
-- reset-gpios:	Reset pin
-- power-supply:	A regulator node for the supply voltage.
-- backlight:	phandle of the backlight device attached to the panel
-- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
-
-Example:
-	mi0283qt@0{
-		compatible = "multi-inno,mi0283qt";
-		reg = <0>;
-		spi-max-frequency = <32000000>;
-		rotation = <90>;
-		dc-gpios = <&gpio 25 0>;
-		backlight = <&backlight>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index f66488d..812ffd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4315,11 +4315,11 @@ M:	Dave Airlie <airlied@redhat.com>
 S:	Odd Fixes
 F:	drivers/gpu/drm/mgag200/
 
-DRM DRIVER FOR MI0283QT
+DRM DRIVER FOR MIPI DBI compatible panels
 M:	Noralf Trønnes <noralf@tronnes.org>
 S:	Maintained
-F:	drivers/gpu/drm/tinydrm/mi0283qt.c
-F:	Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
+F:	drivers/gpu/drm/tinydrm/mipi-panel.c
+F:	Documentation/devicetree/bindings/display/mipi-panel.txt
 
 DRM DRIVER FOR MSM ADRENO GPU
 M:	Rob Clark <robdclark@gmail.com>
diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/Kconfig
index 3504c53..394519b 100644
--- a/drivers/gpu/drm/tinydrm/Kconfig
+++ b/drivers/gpu/drm/tinydrm/Kconfig
@@ -12,10 +12,14 @@ menuconfig DRM_TINYDRM
 config TINYDRM_MIPI_DBI
 	tristate
 
-config TINYDRM_MI0283QT
-	tristate "DRM support for MI0283QT"
+config TINYDRM_MIPI_PANEL
+	tristate "DRM support for MIPI DBI compatible display panels"
 	depends on DRM_TINYDRM && SPI
 	select TINYDRM_MIPI_DBI
 	help
-	  DRM driver for the Multi-Inno MI0283QT display panel
-	  If M is selected the module will be called mi0283qt.
+	  DRM driver for the MIPI DBI compatible display panels.
+
+	  Supported panels include:
+	  * Multi-Inno MI0283QT
+
+	  If M is selected the module will be called mipi-panel.
diff --git a/drivers/gpu/drm/tinydrm/Makefile b/drivers/gpu/drm/tinydrm/Makefile
index 7a3604c..7eae65e 100644
--- a/drivers/gpu/drm/tinydrm/Makefile
+++ b/drivers/gpu/drm/tinydrm/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_DRM_TINYDRM)		+= core/
 obj-$(CONFIG_TINYDRM_MIPI_DBI)		+= mipi-dbi.o
 
 # Displays
-obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
+obj-$(CONFIG_TINYDRM_MIPI_PANEL)	+= mipi-panel.o
diff --git a/drivers/gpu/drm/tinydrm/mi0283qt.c b/drivers/gpu/drm/tinydrm/mi0283qt.c
deleted file mode 100644
index 2680dab..0000000
--- a/drivers/gpu/drm/tinydrm/mi0283qt.c
+++ /dev/null
@@ -1,283 +0,0 @@
-/*
- * DRM driver for Multi-Inno MI0283QT panels
- *
- * Copyright 2016 Noralf Trønnes
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <drm/tinydrm/ili9341.h>
-#include <drm/tinydrm/mipi-dbi.h>
-#include <drm/tinydrm/tinydrm-helpers.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
-#include <linux/module.h>
-#include <linux/property.h>
-#include <linux/regulator/consumer.h>
-#include <linux/spi/spi.h>
-#include <video/mipi_display.h>
-
-static int mi0283qt_init(struct mipi_dbi *mipi)
-{
-	struct tinydrm_device *tdev = &mipi->tinydrm;
-	struct device *dev = tdev->drm->dev;
-	u8 addr_mode;
-	int ret;
-
-	DRM_DEBUG_KMS("\n");
-
-	ret = regulator_enable(mipi->regulator);
-	if (ret) {
-		dev_err(dev, "Failed to enable regulator %d\n", ret);
-		return ret;
-	}
-
-	/* Avoid flicker by skipping setup if the bootloader has done it */
-	if (mipi_dbi_display_is_on(mipi))
-		return 0;
-
-	mipi_dbi_hw_reset(mipi);
-	ret = mipi_dbi_command(mipi, MIPI_DCS_SOFT_RESET);
-	if (ret) {
-		dev_err(dev, "Error sending command %d\n", ret);
-		regulator_disable(mipi->regulator);
-		return ret;
-	}
-
-	msleep(20);
-
-	mipi_dbi_command(mipi, MIPI_DCS_SET_DISPLAY_OFF);
-
-	mipi_dbi_command(mipi, ILI9341_PWCTRLB, 0x00, 0x83, 0x30);
-	mipi_dbi_command(mipi, ILI9341_PWRSEQ, 0x64, 0x03, 0x12, 0x81);
-	mipi_dbi_command(mipi, ILI9341_DTCTRLA, 0x85, 0x01, 0x79);
-	mipi_dbi_command(mipi, ILI9341_PWCTRLA, 0x39, 0x2c, 0x00, 0x34, 0x02);
-	mipi_dbi_command(mipi, ILI9341_PUMPCTRL, 0x20);
-	mipi_dbi_command(mipi, ILI9341_DTCTRLB, 0x00, 0x00);
-
-	/* Power Control */
-	mipi_dbi_command(mipi, ILI9341_PWCTRL1, 0x26);
-	mipi_dbi_command(mipi, ILI9341_PWCTRL2, 0x11);
-	/* VCOM */
-	mipi_dbi_command(mipi, ILI9341_VMCTRL1, 0x35, 0x3e);
-	mipi_dbi_command(mipi, ILI9341_VMCTRL2, 0xbe);
-
-	/* Memory Access Control */
-	mipi_dbi_command(mipi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
-
-	switch (mipi->rotation) {
-	default:
-		addr_mode = ILI9341_MADCTL_MV | ILI9341_MADCTL_MY |
-			    ILI9341_MADCTL_MX;
-		break;
-	case 90:
-		addr_mode = ILI9341_MADCTL_MY;
-		break;
-	case 180:
-		addr_mode = ILI9341_MADCTL_MV;
-		break;
-	case 270:
-		addr_mode = ILI9341_MADCTL_MX;
-		break;
-	}
-	addr_mode |= ILI9341_MADCTL_BGR;
-	mipi_dbi_command(mipi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
-
-	/* Frame Rate */
-	mipi_dbi_command(mipi, ILI9341_FRMCTR1, 0x00, 0x1b);
-
-	/* Gamma */
-	mipi_dbi_command(mipi, ILI9341_EN3GAM, 0x08);
-	mipi_dbi_command(mipi, MIPI_DCS_SET_GAMMA_CURVE, 0x01);
-	mipi_dbi_command(mipi, ILI9341_PGAMCTRL,
-		       0x1f, 0x1a, 0x18, 0x0a, 0x0f, 0x06, 0x45, 0x87,
-		       0x32, 0x0a, 0x07, 0x02, 0x07, 0x05, 0x00);
-	mipi_dbi_command(mipi, ILI9341_NGAMCTRL,
-		       0x00, 0x25, 0x27, 0x05, 0x10, 0x09, 0x3a, 0x78,
-		       0x4d, 0x05, 0x18, 0x0d, 0x38, 0x3a, 0x1f);
-
-	/* DDRAM */
-	mipi_dbi_command(mipi, ILI9341_ETMOD, 0x07);
-
-	/* Display */
-	mipi_dbi_command(mipi, ILI9341_DISCTRL, 0x0a, 0x82, 0x27, 0x00);
-	mipi_dbi_command(mipi, MIPI_DCS_EXIT_SLEEP_MODE);
-	msleep(100);
-
-	mipi_dbi_command(mipi, MIPI_DCS_SET_DISPLAY_ON);
-	msleep(100);
-
-	return 0;
-}
-
-static void mi0283qt_fini(void *data)
-{
-	struct mipi_dbi *mipi = data;
-
-	DRM_DEBUG_KMS("\n");
-	regulator_disable(mipi->regulator);
-}
-
-static const struct drm_simple_display_pipe_funcs mi0283qt_pipe_funcs = {
-	.enable = mipi_dbi_pipe_enable,
-	.disable = mipi_dbi_pipe_disable,
-	.update = tinydrm_display_pipe_update,
-	.prepare_fb = tinydrm_display_pipe_prepare_fb,
-};
-
-static const struct drm_display_mode mi0283qt_mode = {
-	TINYDRM_MODE(320, 240, 58, 43),
-};
-
-DEFINE_DRM_GEM_CMA_FOPS(mi0283qt_fops);
-
-static struct drm_driver mi0283qt_driver = {
-	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
-				  DRIVER_ATOMIC,
-	.fops			= &mi0283qt_fops,
-	TINYDRM_GEM_DRIVER_OPS,
-	.lastclose		= tinydrm_lastclose,
-	.debugfs_init		= mipi_dbi_debugfs_init,
-	.name			= "mi0283qt",
-	.desc			= "Multi-Inno MI0283QT",
-	.date			= "20160614",
-	.major			= 1,
-	.minor			= 0,
-};
-
-static const struct of_device_id mi0283qt_of_match[] = {
-	{ .compatible = "multi-inno,mi0283qt" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, mi0283qt_of_match);
-
-static const struct spi_device_id mi0283qt_id[] = {
-	{ "mi0283qt", 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(spi, mi0283qt_id);
-
-static int mi0283qt_probe(struct spi_device *spi)
-{
-	struct device *dev = &spi->dev;
-	struct tinydrm_device *tdev;
-	struct mipi_dbi *mipi;
-	struct gpio_desc *dc;
-	u32 rotation = 0;
-	int ret;
-
-	mipi = devm_kzalloc(dev, sizeof(*mipi), GFP_KERNEL);
-	if (!mipi)
-		return -ENOMEM;
-
-	mipi->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(mipi->reset)) {
-		dev_err(dev, "Failed to get gpio 'reset'\n");
-		return PTR_ERR(mipi->reset);
-	}
-
-	dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
-	if (IS_ERR(dc)) {
-		dev_err(dev, "Failed to get gpio 'dc'\n");
-		return PTR_ERR(dc);
-	}
-
-	mipi->regulator = devm_regulator_get(dev, "power");
-	if (IS_ERR(mipi->regulator))
-		return PTR_ERR(mipi->regulator);
-
-	mipi->backlight = tinydrm_of_find_backlight(dev);
-	if (IS_ERR(mipi->backlight))
-		return PTR_ERR(mipi->backlight);
-
-	device_property_read_u32(dev, "rotation", &rotation);
-
-	ret = mipi_dbi_spi_init(spi, mipi, dc, &mi0283qt_pipe_funcs,
-				&mi0283qt_driver, &mi0283qt_mode,
-				MIPI_DCS_PIXEL_FMT_16BIT, rotation);
-	if (ret)
-		return ret;
-
-	ret = mi0283qt_init(mipi);
-	if (ret)
-		return ret;
-
-	/* use devres to fini after drm unregister (drv->remove is before) */
-	ret = devm_add_action(dev, mi0283qt_fini, mipi);
-	if (ret) {
-		mi0283qt_fini(mipi);
-		return ret;
-	}
-
-	tdev = &mipi->tinydrm;
-
-	ret = devm_tinydrm_register(tdev);
-	if (ret)
-		return ret;
-
-	spi_set_drvdata(spi, mipi);
-
-	DRM_DEBUG_DRIVER("Initialized %s:%s @%uMHz on minor %d\n",
-			 tdev->drm->driver->name, dev_name(dev),
-			 spi->max_speed_hz / 1000000,
-			 tdev->drm->primary->index);
-
-	return 0;
-}
-
-static void mi0283qt_shutdown(struct spi_device *spi)
-{
-	struct mipi_dbi *mipi = spi_get_drvdata(spi);
-
-	tinydrm_shutdown(&mipi->tinydrm);
-}
-
-static int __maybe_unused mi0283qt_pm_suspend(struct device *dev)
-{
-	struct mipi_dbi *mipi = dev_get_drvdata(dev);
-	int ret;
-
-	ret = tinydrm_suspend(&mipi->tinydrm);
-	if (ret)
-		return ret;
-
-	mi0283qt_fini(mipi);
-
-	return 0;
-}
-
-static int __maybe_unused mi0283qt_pm_resume(struct device *dev)
-{
-	struct mipi_dbi *mipi = dev_get_drvdata(dev);
-	int ret;
-
-	ret = mi0283qt_init(mipi);
-	if (ret)
-		return ret;
-
-	return tinydrm_resume(&mipi->tinydrm);
-}
-
-static const struct dev_pm_ops mi0283qt_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mi0283qt_pm_suspend, mi0283qt_pm_resume)
-};
-
-static struct spi_driver mi0283qt_spi_driver = {
-	.driver = {
-		.name = "mi0283qt",
-		.owner = THIS_MODULE,
-		.of_match_table = mi0283qt_of_match,
-		.pm = &mi0283qt_pm_ops,
-	},
-	.id_table = mi0283qt_id,
-	.probe = mi0283qt_probe,
-	.shutdown = mi0283qt_shutdown,
-};
-module_spi_driver(mi0283qt_spi_driver);
-
-MODULE_DESCRIPTION("Multi-Inno MI0283QT DRM driver");
-MODULE_AUTHOR("Noralf Trønnes");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tinydrm/mipi-panel.c b/drivers/gpu/drm/tinydrm/mipi-panel.c
new file mode 100644
index 0000000..64344f0
--- /dev/null
+++ b/drivers/gpu/drm/tinydrm/mipi-panel.c
@@ -0,0 +1,284 @@
+/*
+ * DRM driver for MIPI DBI compatible panels
+ *
+ * Copyright 2016 Noralf Trønnes
+ * Copyright 2017 David Lechner <david@lechnology.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <drm/tinydrm/ili9341.h>
+#include <drm/tinydrm/mipi-dbi.h>
+#include <drm/tinydrm/tinydrm-helpers.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <video/mipi_display.h>
+
+static int mipi_panel_init(struct mipi_dbi *mipi)
+{
+	struct tinydrm_device *tdev = &mipi->tinydrm;
+	struct device *dev = tdev->drm->dev;
+	u8 addr_mode;
+	int ret;
+
+	DRM_DEBUG_KMS("\n");
+
+	ret = regulator_enable(mipi->regulator);
+	if (ret) {
+		dev_err(dev, "Failed to enable regulator %d\n", ret);
+		return ret;
+	}
+
+	/* Avoid flicker by skipping setup if the bootloader has done it */
+	if (mipi_dbi_display_is_on(mipi))
+		return 0;
+
+	mipi_dbi_hw_reset(mipi);
+	ret = mipi_dbi_command(mipi, MIPI_DCS_SOFT_RESET);
+	if (ret) {
+		dev_err(dev, "Error sending command %d\n", ret);
+		regulator_disable(mipi->regulator);
+		return ret;
+	}
+
+	msleep(20);
+
+	mipi_dbi_command(mipi, MIPI_DCS_SET_DISPLAY_OFF);
+
+	mipi_dbi_command(mipi, ILI9341_PWCTRLB, 0x00, 0x83, 0x30);
+	mipi_dbi_command(mipi, ILI9341_PWRSEQ, 0x64, 0x03, 0x12, 0x81);
+	mipi_dbi_command(mipi, ILI9341_DTCTRLA, 0x85, 0x01, 0x79);
+	mipi_dbi_command(mipi, ILI9341_PWCTRLA, 0x39, 0x2c, 0x00, 0x34, 0x02);
+	mipi_dbi_command(mipi, ILI9341_PUMPCTRL, 0x20);
+	mipi_dbi_command(mipi, ILI9341_DTCTRLB, 0x00, 0x00);
+
+	/* Power Control */
+	mipi_dbi_command(mipi, ILI9341_PWCTRL1, 0x26);
+	mipi_dbi_command(mipi, ILI9341_PWCTRL2, 0x11);
+	/* VCOM */
+	mipi_dbi_command(mipi, ILI9341_VMCTRL1, 0x35, 0x3e);
+	mipi_dbi_command(mipi, ILI9341_VMCTRL2, 0xbe);
+
+	/* Memory Access Control */
+	mipi_dbi_command(mipi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
+
+	switch (mipi->rotation) {
+	default:
+		addr_mode = ILI9341_MADCTL_MV | ILI9341_MADCTL_MY |
+			    ILI9341_MADCTL_MX;
+		break;
+	case 90:
+		addr_mode = ILI9341_MADCTL_MY;
+		break;
+	case 180:
+		addr_mode = ILI9341_MADCTL_MV;
+		break;
+	case 270:
+		addr_mode = ILI9341_MADCTL_MX;
+		break;
+	}
+	addr_mode |= ILI9341_MADCTL_BGR;
+	mipi_dbi_command(mipi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
+
+	/* Frame Rate */
+	mipi_dbi_command(mipi, ILI9341_FRMCTR1, 0x00, 0x1b);
+
+	/* Gamma */
+	mipi_dbi_command(mipi, ILI9341_EN3GAM, 0x08);
+	mipi_dbi_command(mipi, MIPI_DCS_SET_GAMMA_CURVE, 0x01);
+	mipi_dbi_command(mipi, ILI9341_PGAMCTRL,
+		       0x1f, 0x1a, 0x18, 0x0a, 0x0f, 0x06, 0x45, 0x87,
+		       0x32, 0x0a, 0x07, 0x02, 0x07, 0x05, 0x00);
+	mipi_dbi_command(mipi, ILI9341_NGAMCTRL,
+		       0x00, 0x25, 0x27, 0x05, 0x10, 0x09, 0x3a, 0x78,
+		       0x4d, 0x05, 0x18, 0x0d, 0x38, 0x3a, 0x1f);
+
+	/* DDRAM */
+	mipi_dbi_command(mipi, ILI9341_ETMOD, 0x07);
+
+	/* Display */
+	mipi_dbi_command(mipi, ILI9341_DISCTRL, 0x0a, 0x82, 0x27, 0x00);
+	mipi_dbi_command(mipi, MIPI_DCS_EXIT_SLEEP_MODE);
+	msleep(100);
+
+	mipi_dbi_command(mipi, MIPI_DCS_SET_DISPLAY_ON);
+	msleep(100);
+
+	return 0;
+}
+
+static void mipi_panel_fini(void *data)
+{
+	struct mipi_dbi *mipi = data;
+
+	DRM_DEBUG_KMS("\n");
+	regulator_disable(mipi->regulator);
+}
+
+static const struct drm_simple_display_pipe_funcs mipi_panel_pipe_funcs = {
+	.enable = mipi_dbi_pipe_enable,
+	.disable = mipi_dbi_pipe_disable,
+	.update = tinydrm_display_pipe_update,
+	.prepare_fb = tinydrm_display_pipe_prepare_fb,
+};
+
+static const struct drm_display_mode mipi_panel_mode = {
+	TINYDRM_MODE(320, 240, 58, 43),
+};
+
+DEFINE_DRM_GEM_CMA_FOPS(mipi_panel_fops);
+
+static struct drm_driver mipi_panel_driver = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
+				  DRIVER_ATOMIC,
+	.fops			= &mipi_panel_fops,
+	TINYDRM_GEM_DRIVER_OPS,
+	.lastclose		= tinydrm_lastclose,
+	.debugfs_init		= mipi_dbi_debugfs_init,
+	.name			= "mipi-panel",
+	.desc			= "MIPI DBI compatible panel",
+	.date			= "20160614",
+	.major			= 1,
+	.minor			= 0,
+};
+
+static const struct of_device_id mipi_panel_of_match[] = {
+	{ .compatible = "multi-inno,mi0283qt" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mipi_panel_of_match);
+
+static const struct spi_device_id mipi_panel_id[] = {
+	{ "mi0283qt", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, mipi_panel_id);
+
+static int mipi_panel_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct tinydrm_device *tdev;
+	struct mipi_dbi *mipi;
+	struct gpio_desc *dc;
+	u32 rotation = 0;
+	int ret;
+
+	mipi = devm_kzalloc(dev, sizeof(*mipi), GFP_KERNEL);
+	if (!mipi)
+		return -ENOMEM;
+
+	mipi->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(mipi->reset)) {
+		dev_err(dev, "Failed to get gpio 'reset'\n");
+		return PTR_ERR(mipi->reset);
+	}
+
+	dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
+	if (IS_ERR(dc)) {
+		dev_err(dev, "Failed to get gpio 'dc'\n");
+		return PTR_ERR(dc);
+	}
+
+	mipi->regulator = devm_regulator_get(dev, "power");
+	if (IS_ERR(mipi->regulator))
+		return PTR_ERR(mipi->regulator);
+
+	mipi->backlight = tinydrm_of_find_backlight(dev);
+	if (IS_ERR(mipi->backlight))
+		return PTR_ERR(mipi->backlight);
+
+	device_property_read_u32(dev, "rotation", &rotation);
+
+	ret = mipi_dbi_spi_init(spi, mipi, dc, &mipi_panel_pipe_funcs,
+				&mipi_panel_driver, &mipi_panel_mode,
+				MIPI_DCS_PIXEL_FMT_16BIT, rotation);
+	if (ret)
+		return ret;
+
+	ret = mipi_panel_init(mipi);
+	if (ret)
+		return ret;
+
+	/* use devres to fini after drm unregister (drv->remove is before) */
+	ret = devm_add_action(dev, mipi_panel_fini, mipi);
+	if (ret) {
+		mipi_panel_fini(mipi);
+		return ret;
+	}
+
+	tdev = &mipi->tinydrm;
+
+	ret = devm_tinydrm_register(tdev);
+	if (ret)
+		return ret;
+
+	spi_set_drvdata(spi, mipi);
+
+	DRM_DEBUG_DRIVER("Initialized %s:%s @%uMHz on minor %d\n",
+			 tdev->drm->driver->name, dev_name(dev),
+			 spi->max_speed_hz / 1000000,
+			 tdev->drm->primary->index);
+
+	return 0;
+}
+
+static void mipi_panel_shutdown(struct spi_device *spi)
+{
+	struct mipi_dbi *mipi = spi_get_drvdata(spi);
+
+	tinydrm_shutdown(&mipi->tinydrm);
+}
+
+static int __maybe_unused mipi_panel_pm_suspend(struct device *dev)
+{
+	struct mipi_dbi *mipi = dev_get_drvdata(dev);
+	int ret;
+
+	ret = tinydrm_suspend(&mipi->tinydrm);
+	if (ret)
+		return ret;
+
+	mipi_panel_fini(mipi);
+
+	return 0;
+}
+
+static int __maybe_unused mipi_panel_pm_resume(struct device *dev)
+{
+	struct mipi_dbi *mipi = dev_get_drvdata(dev);
+	int ret;
+
+	ret = mipi_panel_init(mipi);
+	if (ret)
+		return ret;
+
+	return tinydrm_resume(&mipi->tinydrm);
+}
+
+static const struct dev_pm_ops mipi_panel_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mipi_panel_pm_suspend, mipi_panel_pm_resume)
+};
+
+static struct spi_driver mipi_panel_spi_driver = {
+	.driver = {
+		.name = "mipi-panel",
+		.owner = THIS_MODULE,
+		.of_match_table = mipi_panel_of_match,
+		.pm = &mipi_panel_pm_ops,
+	},
+	.id_table = mipi_panel_id,
+	.probe = mipi_panel_probe,
+	.shutdown = mipi_panel_shutdown,
+};
+module_spi_driver(mipi_panel_spi_driver);
+
+MODULE_DESCRIPTION("MIPI DBI panel DRM driver");
+MODULE_AUTHOR("Noralf Trønnes");
+MODULE_LICENSE("GPL");
-- 
2.7.4

