From: David Lechner <david@lechnology.com>
Date: Sat, 29 Jul 2017 19:17:49 +0000
Subject: [PATCH 5/6] drm/tinydrm: add support for LEGO MINDSTORMS EV3 LCD
Message-Id: <1501355870-13960-6-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

LEGO MINDSTORMS EV3 has an LCD with a ST7586 controller. This adds a new
module for the ST7586 controller with parameters for the EV3 LCD dispay.

Signed-off-by: David Lechner <david@lechnology.com>
---
 .../devicetree/bindings/display/mipi-panel.txt     |  2 +-
 drivers/gpu/drm/tinydrm/Kconfig                    |  1 +
 drivers/gpu/drm/tinydrm/mipi-panel.c               | 87 ++++++++++++++++++++++
 include/drm/tinydrm/st7586.h                       | 34 +++++++++
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 include/drm/tinydrm/st7586.h

diff --git a/Documentation/devicetree/bindings/display/mipi-panel.txt b/Documentation/devicetree/bindings/display/mipi-panel.txt
index 01d6ea9..ba8c8ab 100644
--- a/Documentation/devicetree/bindings/display/mipi-panel.txt
+++ b/Documentation/devicetree/bindings/display/mipi-panel.txt
@@ -1,7 +1,7 @@
 MIPI DBI compatible display panel
 
 Required properties:
-- compatible:	"multi-inno,mi0283qt".
+- compatible:	one of "lego,ev3-lcd", "multi-inno,mi0283qt".
 
 The node for this driver must be a child node of a SPI controller, hence
 all mandatory properties described in ../spi/spi-bus.txt must be specified.
diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/Kconfig
index 394519b..6e90bb5 100644
--- a/drivers/gpu/drm/tinydrm/Kconfig
+++ b/drivers/gpu/drm/tinydrm/Kconfig
@@ -20,6 +20,7 @@ config TINYDRM_MIPI_PANEL
 	  DRM driver for the MIPI DBI compatible display panels.
 	  
 	  Supported panels include:
+	  * LEGO MINDSTORMS EV3
 	  * Multi-Inno MI0283QT
 
 	  If M is selected the module will be called mipi-panel.
diff --git a/drivers/gpu/drm/tinydrm/mipi-panel.c b/drivers/gpu/drm/tinydrm/mipi-panel.c
index 8aa1d8e..e3d5678 100644
--- a/drivers/gpu/drm/tinydrm/mipi-panel.c
+++ b/drivers/gpu/drm/tinydrm/mipi-panel.c
@@ -12,6 +12,7 @@
 
 #include <drm/tinydrm/ili9341.h>
 #include <drm/tinydrm/mipi-dbi.h>
+#include <drm/tinydrm/st7586.h>
 #include <drm/tinydrm/tinydrm-helpers.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -23,6 +24,7 @@
 
 enum mipi_panel_type {
 	MIPI_PANEL_TYPE_UNKNOWN,
+	MIPI_PANEL_TYPE_LEGO_EV3_LCD,
 	MIPI_PANEL_TYPE_MULTI_INNO_MI0283QT,
 };
 
@@ -125,6 +127,84 @@ static int mipi_panel_init_ili9341(struct mipi_dbi *mipi)
 	return 0;
 }
 
+static int mipi_panel_init_st7586(struct mipi_dbi *mipi)
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
+	ret = mipi_dbi_command(mipi, ST7586_AUTO_READ_CTRL, 0x9f);
+	if (ret) {
+		dev_err(dev, "Error sending command %d\n", ret);
+		regulator_disable(mipi->regulator);
+		return ret;
+	}
+
+	mipi_dbi_command(mipi, ST7586_OTP_RW_CTRL, 0x00);
+
+	msleep(10);
+
+	mipi_dbi_command(mipi, ST7586_OTP_READ);
+
+	msleep(20);
+
+	mipi_dbi_command(mipi, ST7586_OTP_CTRL_OUT);
+	mipi_dbi_command(mipi, MIPI_DCS_EXIT_SLEEP_MODE);
+	mipi_dbi_command(mipi, MIPI_DCS_SET_DISPLAY_OFF);
+
+	msleep(50);
+
+	mipi_dbi_command(mipi, ST7586_SET_VOP_OFFSET, 0x00);
+	mipi_dbi_command(mipi, ST7586_SET_VOP, 0xe3, 0x00);
+	mipi_dbi_command(mipi, ST7586_SET_BIAS_SYSTEM, 0x02);
+	mipi_dbi_command(mipi, ST7586_SET_BOOST_LEVEL, 0x04);
+	mipi_dbi_command(mipi, ST7586_ENABLE_ANALOG, 0x1d);
+	mipi_dbi_command(mipi, ST7586_SET_NLINE_INV, 0x00);
+	mipi_dbi_command(mipi, ST7586_DISP_MODE_GRAY);
+	mipi_dbi_command(mipi, ST7586_ENABLE_DDRAM, 0x02);
+
+	switch (mipi->rotation) {
+	default:
+		addr_mode = 0x00;
+		break;
+	case 90:
+		addr_mode = ST7586_DISP_CTRL_MY;
+		break;
+	case 180:
+		addr_mode = ST7586_DISP_CTRL_MX | ST7586_DISP_CTRL_MY;
+		break;
+	case 270:
+		addr_mode = ST7586_DISP_CTRL_MX;
+		break;
+	}
+	mipi_dbi_command(mipi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
+
+	mipi_dbi_command(mipi, ST7586_SET_DISP_DUTY, 0x7f);
+	mipi_dbi_command(mipi, ST7586_SET_PART_DISP, 0xa0);
+	mipi_dbi_command(mipi, MIPI_DCS_SET_PARTIAL_AREA, 0x00, 0x00, 0x00, 0x77);
+	mipi_dbi_command(mipi, MIPI_DCS_EXIT_INVERT_MODE);
+
+	msleep(100);
+
+	mipi_dbi_command(mipi, MIPI_DCS_SET_DISPLAY_ON);
+
+	return 0;
+}
+
 static void mipi_panel_fini(void *data)
 {
 	struct mipi_dbi *mipi = data;
@@ -141,6 +221,11 @@ static const struct drm_simple_display_pipe_funcs mipi_panel_pipe_funcs = {
 };
 
 static const struct mipi_panel_info mipi_panel_infos[] = {
+	[MIPI_PANEL_TYPE_LEGO_EV3_LCD] = {
+		.init		= mipi_panel_init_st7586,
+		.mode		= { TINYDRM_MODE(178, 128, 37, 27) },
+		.pixel_fmt	= MIPI_DCS_PIXEL_FMT_ST7586_332,
+	},
 	[MIPI_PANEL_TYPE_MULTI_INNO_MI0283QT] = {
 		.init		= mipi_panel_init_ili9341,
 		.mode		= { TINYDRM_MODE(320, 240, 58, 43) },
@@ -165,12 +250,14 @@ static struct drm_driver mipi_panel_driver = {
 };
 
 static const struct of_device_id mipi_panel_of_match[] = {
+	{ .compatible = "lego,ev3-lcd" },
 	{ .compatible = "multi-inno,mi0283qt" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mipi_panel_of_match);
 
 static const struct spi_device_id mipi_panel_id[] = {
+	{ "ev3-lcd", MIPI_PANEL_TYPE_LEGO_EV3_LCD },
 	{ "mi0283qt", MIPI_PANEL_TYPE_MULTI_INNO_MI0283QT },
 	{ },
 };
diff --git a/include/drm/tinydrm/st7586.h b/include/drm/tinydrm/st7586.h
new file mode 100644
index 0000000..18fb56b
--- /dev/null
+++ b/include/drm/tinydrm/st7586.h
@@ -0,0 +1,34 @@
+/*
+ * ST7586 LCD controller
+ *
+ * Copyright (C) 2017 David Lechner <david@lechnology.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_ST7856_H
+#define __LINUX_ST7856_H
+
+#define ST7586_DISP_MODE_GRAY	0x38
+#define ST7586_DISP_MODE_MONO	0x39
+#define ST7586_ENABLE_DDRAM	0x3a
+#define ST7586_SET_DISP_DUTY	0xb0
+#define ST7586_SET_PART_DISP	0xb4
+#define ST7586_SET_NLINE_INV	0xb5
+#define ST7586_SET_VOP		0xc0
+#define ST7586_SET_BIAS_SYSTEM	0xc3
+#define ST7586_SET_BOOST_LEVEL	0xc4
+#define ST7586_SET_VOP_OFFSET	0xc7
+#define ST7586_ENABLE_ANALOG	0xd0
+#define ST7586_AUTO_READ_CTRL	0xd7
+#define ST7586_OTP_RW_CTRL	0xe0
+#define ST7586_OTP_CTRL_OUT	0xe1
+#define ST7586_OTP_READ		0xe3
+
+#define ST7586_DISP_CTRL_MX	BIT(6)
+#define ST7586_DISP_CTRL_MY	BIT(7)
+
+#endif /* __LINUX_ST7856_H */
-- 
2.7.4

