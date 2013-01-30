From: Tomasz Figa <t.figa@samsung.com>
Date: Wed, 30 Jan 2013 15:39:03 +0000
Subject: [RFC PATCH 4/4] video: display: Add Samsung s6e8ax0 display panel driver
Message-Id: <1359560343-31636-5-git-send-email-t.figa@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com>
In-Reply-To: <1359560343-31636-1-git-send-email-t.figa@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.figa@samsung.com, tomasz.figa@gmail.com, Daniel Vetter <daniel@ffwll.ch>, Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, rob@ti.com, tomi.valkeinen@ti.com, Vikas Sajjan <vikas.sajjan@linaro.org>, inki.dae@samsung.com, dh09.lee@samsung.com, ville.syrjala@intel.com, s.nawrocki@samsung.com

This patch adds Common Display Framework driver for Samsung s6e8ax0
MIPI DSI display panel.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/display/Kconfig         |    3 +
 drivers/video/display/Makefile        |    1 +
 drivers/video/display/panel-s6e8ax0.c | 1027 +++++++++++++++++++++++++++++++++
 include/video/panel-s6e8ax0.h         |   41 ++
 4 files changed, 1072 insertions(+)
 create mode 100644 drivers/video/display/panel-s6e8ax0.c
 create mode 100644 include/video/panel-s6e8ax0.h

diff --git a/drivers/video/display/Kconfig b/drivers/video/display/Kconfig
index b14527a..f19ec04 100644
--- a/drivers/video/display/Kconfig
+++ b/drivers/video/display/Kconfig
@@ -5,6 +5,9 @@ menuconfig DISPLAY_CORE
 
 if DISPLAY_CORE
 
+config DISPLAY_PANEL_S6E8AX0
+	tristate "S6E8AX0 DSI video mode panel"
+	select OF_VIDEOMODE
 
 config DISPLAY_SOURCE_EXYNOS_DSI
 	tristate "Samsung SoC MIPI DSI Master"
diff --git a/drivers/video/display/Makefile b/drivers/video/display/Makefile
index 40a283a..0f7fdc2 100644
--- a/drivers/video/display/Makefile
+++ b/drivers/video/display/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_DISPLAY_CORE) += display-core.o
+obj-$(CONFIG_DISPLAY_PANEL_S6E8AX0) += panel-s6e8ax0.o
 obj-$(CONFIG_DISPLAY_SOURCE_EXYNOS_DSI) += source-exynos_dsi.o
diff --git a/drivers/video/display/panel-s6e8ax0.c b/drivers/video/display/panel-s6e8ax0.c
new file mode 100644
index 0000000..4c09fe2
--- /dev/null
+++ b/drivers/video/display/panel-s6e8ax0.c
@@ -0,0 +1,1027 @@
+/* linux/drivers/video/exynos/s6e8ax0.c
+ *
+ * MIPI-DSI based s6e8ax0 AMOLED lcd 4.65 inch panel driver.
+ *
+ * Inki Dae, <inki.dae@samsung.com>
+ * Donghwa Lee, <dh09.lee@samsung.com>
+ * Tomasz Figa, <t.figa@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/ctype.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include <linux/fb.h>
+#include <linux/gpio.h>
+#include <linux/lcd.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_videomode.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/backlight.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/display.h>
+#include <video/mipi_display.h>
+#include <video/panel-s6e8ax0.h>
+
+#define LDI_MTP_LENGTH		24
+#define DSIM_PM_STABLE_TIME	10
+#define MIN_BRIGHTNESS		0
+#define MAX_BRIGHTNESS		24
+#define GAMMA_TABLE_COUNT	26
+
+struct s6e8ax0 {
+	struct display_entity entity;
+	struct device *dev;
+
+	struct s6e8ax0_platform_data *pdata;
+	struct backlight_device	*bd;
+	struct lcd_device *ld;
+	struct regulator_bulk_data supplies[2];
+
+	bool enabled;
+	unsigned int id;
+	unsigned int gamma;
+	unsigned int acl_enable;
+	unsigned int cur_acl;
+	int power;
+
+	unsigned int reset_gpio;
+};
+
+#define to_panel(p)	container_of(p, struct s6e8ax0, entity)
+
+static const unsigned char s6e8ax0_22_gamma_30[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xf5, 0x00, 0xff, 0xad, 0xaf,
+	0xbA, 0xc3, 0xd8, 0xc5, 0x9f, 0xc6, 0x9e, 0xc1, 0xdc, 0xc0,
+	0x00, 0x61, 0x00, 0x5a, 0x00, 0x74,
+};
+
+static const unsigned char s6e8ax0_22_gamma_50[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xe8, 0x1f, 0xf7, 0xad, 0xc0,
+	0xb5, 0xc4, 0xdc, 0xc4, 0x9e, 0xc6, 0x9c, 0xbb, 0xd8, 0xbb,
+	0x00, 0x70, 0x00, 0x68, 0x00, 0x86,
+};
+
+static const unsigned char s6e8ax0_22_gamma_60[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xde, 0x1f, 0xef, 0xad, 0xc4,
+	0xb3, 0xc3, 0xdd, 0xc4, 0x9e, 0xc6, 0x9c, 0xbc, 0xd6, 0xba,
+	0x00, 0x75, 0x00, 0x6e, 0x00, 0x8d,
+};
+
+static const unsigned char s6e8ax0_22_gamma_70[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xd8, 0x1f, 0xe7, 0xaf, 0xc8,
+	0xb4, 0xc4, 0xdd, 0xc3, 0x9d, 0xc6, 0x9c, 0xbb, 0xd6, 0xb9,
+	0x00, 0x7a, 0x00, 0x72, 0x00, 0x93,
+};
+
+static const unsigned char s6e8ax0_22_gamma_80[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xc9, 0x1f, 0xde, 0xae, 0xc9,
+	0xb1, 0xc3, 0xdd, 0xc2, 0x9d, 0xc5, 0x9b, 0xbc, 0xd6, 0xbb,
+	0x00, 0x7f, 0x00, 0x77, 0x00, 0x99,
+};
+
+static const unsigned char s6e8ax0_22_gamma_90[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xc7, 0x1f, 0xd9, 0xb0, 0xcc,
+	0xb2, 0xc3, 0xdc, 0xc1, 0x9c, 0xc6, 0x9c, 0xbc, 0xd4, 0xb9,
+	0x00, 0x83, 0x00, 0x7b, 0x00, 0x9e,
+};
+
+static const unsigned char s6e8ax0_22_gamma_100[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xbd, 0x80, 0xcd, 0xba, 0xce,
+	0xb3, 0xc4, 0xde, 0xc3, 0x9c, 0xc4, 0x9, 0xb8, 0xd3, 0xb6,
+	0x00, 0x88, 0x00, 0x80, 0x00, 0xa5,
+};
+
+static const unsigned char s6e8ax0_22_gamma_120[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb9, 0x95, 0xc8, 0xb1, 0xcf,
+	0xb2, 0xc6, 0xdf, 0xc5, 0x9b, 0xc3, 0x99, 0xb6, 0xd2, 0xb6,
+	0x00, 0x8f, 0x00, 0x86, 0x00, 0xac,
+};
+
+static const unsigned char s6e8ax0_22_gamma_130[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb7, 0xa0, 0xc7, 0xb1, 0xd0,
+	0xb2, 0xc4, 0xdd, 0xc3, 0x9a, 0xc3, 0x98, 0xb6, 0xd0, 0xb4,
+	0x00, 0x92, 0x00, 0x8a, 0x00, 0xb1,
+};
+
+static const unsigned char s6e8ax0_22_gamma_140[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb7, 0xa0, 0xc5, 0xb2, 0xd0,
+	0xb3, 0xc3, 0xde, 0xc3, 0x9b, 0xc2, 0x98, 0xb6, 0xd0, 0xb4,
+	0x00, 0x95, 0x00, 0x8d, 0x00, 0xb5,
+};
+
+static const unsigned char s6e8ax0_22_gamma_150[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb3, 0xa0, 0xc2, 0xb2, 0xd0,
+	0xb2, 0xc1, 0xdd, 0xc2, 0x9b, 0xc2, 0x98, 0xb4, 0xcf, 0xb1,
+	0x00, 0x99, 0x00, 0x90, 0x00, 0xba,
+};
+
+static const unsigned char s6e8ax0_22_gamma_160[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xaf, 0xa5, 0xbf, 0xb0, 0xd0,
+	0xb1, 0xc3, 0xde, 0xc2, 0x99, 0xc1, 0x97, 0xb4, 0xce, 0xb1,
+	0x00, 0x9c, 0x00, 0x93, 0x00, 0xbe,
+};
+
+static const unsigned char s6e8ax0_22_gamma_170[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xaf, 0xb5, 0xbf, 0xb1, 0xd1,
+	0xb1, 0xc3, 0xde, 0xc3, 0x99, 0xc0, 0x96, 0xb4, 0xce, 0xb1,
+	0x00, 0x9f, 0x00, 0x96, 0x00, 0xc2,
+};
+
+static const unsigned char s6e8ax0_22_gamma_180[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xaf, 0xb7, 0xbe, 0xb3, 0xd2,
+	0xb3, 0xc3, 0xde, 0xc2, 0x97, 0xbf, 0x95, 0xb4, 0xcd, 0xb1,
+	0x00, 0xa2, 0x00, 0x99, 0x00, 0xc5,
+};
+
+static const unsigned char s6e8ax0_22_gamma_190[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xaf, 0xb9, 0xbe, 0xb2, 0xd2,
+	0xb2, 0xc3, 0xdd, 0xc3, 0x98, 0xbf, 0x95, 0xb2, 0xcc, 0xaf,
+	0x00, 0xa5, 0x00, 0x9c, 0x00, 0xc9,
+};
+
+static const unsigned char s6e8ax0_22_gamma_200[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xaf, 0xb9, 0xbc, 0xb2, 0xd2,
+	0xb1, 0xc4, 0xdd, 0xc3, 0x97, 0xbe, 0x95, 0xb1, 0xcb, 0xae,
+	0x00, 0xa8, 0x00, 0x9f, 0x00, 0xcd,
+};
+
+static const unsigned char s6e8ax0_22_gamma_210[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb1, 0xc1, 0xbd, 0xb1, 0xd1,
+	0xb1, 0xc2, 0xde, 0xc2, 0x97, 0xbe, 0x94, 0xB0, 0xc9, 0xad,
+	0x00, 0xae, 0x00, 0xa4, 0x00, 0xd4,
+};
+
+static const unsigned char s6e8ax0_22_gamma_220[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb1, 0xc7, 0xbd, 0xb1, 0xd1,
+	0xb1, 0xc2, 0xdd, 0xc2, 0x97, 0xbd, 0x94, 0xb0, 0xc9, 0xad,
+	0x00, 0xad, 0x00, 0xa2, 0x00, 0xd3,
+};
+
+static const unsigned char s6e8ax0_22_gamma_230[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb1, 0xc3, 0xbd, 0xb2, 0xd1,
+	0xb1, 0xc3, 0xdd, 0xc1, 0x96, 0xbd, 0x94, 0xb0, 0xc9, 0xad,
+	0x00, 0xb0, 0x00, 0xa7, 0x00, 0xd7,
+};
+
+static const unsigned char s6e8ax0_22_gamma_240[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb1, 0xcb, 0xbd, 0xb1, 0xd2,
+	0xb1, 0xc3, 0xdD, 0xc2, 0x95, 0xbd, 0x93, 0xaf, 0xc8, 0xab,
+	0x00, 0xb3, 0x00, 0xa9, 0x00, 0xdb,
+};
+
+static const unsigned char s6e8ax0_22_gamma_250[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb3, 0xcc, 0xbe, 0xb0, 0xd2,
+	0xb0, 0xc3, 0xdD, 0xc2, 0x94, 0xbc, 0x92, 0xae, 0xc8, 0xab,
+	0x00, 0xb6, 0x00, 0xab, 0x00, 0xde,
+};
+
+static const unsigned char s6e8ax0_22_gamma_260[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb3, 0xd0, 0xbe, 0xaf, 0xd1,
+	0xaf, 0xc2, 0xdd, 0xc1, 0x96, 0xbc, 0x93, 0xaf, 0xc8, 0xac,
+	0x00, 0xb7, 0x00, 0xad, 0x00, 0xe0,
+};
+
+static const unsigned char s6e8ax0_22_gamma_270[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb2, 0xcF, 0xbd, 0xb0, 0xd2,
+	0xaf, 0xc2, 0xdc, 0xc1, 0x95, 0xbd, 0x93, 0xae, 0xc6, 0xaa,
+	0x00, 0xba, 0x00, 0xb0, 0x00, 0xe4,
+};
+
+static const unsigned char s6e8ax0_22_gamma_280[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb2, 0xd0, 0xbd, 0xaf, 0xd0,
+	0xad, 0xc4, 0xdd, 0xc3, 0x95, 0xbd, 0x93, 0xac, 0xc5, 0xa9,
+	0x00, 0xbd, 0x00, 0xb2, 0x00, 0xe7,
+};
+
+static const unsigned char s6e8ax0_22_gamma_300[] = {
+	0xfa, 0x01, 0x60, 0x10, 0x60, 0xb5, 0xd3, 0xbd, 0xb1, 0xd2,
+	0xb0, 0xc0, 0xdc, 0xc0, 0x94, 0xba, 0x91, 0xac, 0xc5, 0xa9,
+	0x00, 0xc2, 0x00, 0xb7, 0x00, 0xed,
+};
+
+static const unsigned char *s6e8ax0_22_gamma_table[] = {
+	s6e8ax0_22_gamma_30,
+	s6e8ax0_22_gamma_50,
+	s6e8ax0_22_gamma_60,
+	s6e8ax0_22_gamma_70,
+	s6e8ax0_22_gamma_80,
+	s6e8ax0_22_gamma_90,
+	s6e8ax0_22_gamma_100,
+	s6e8ax0_22_gamma_120,
+	s6e8ax0_22_gamma_130,
+	s6e8ax0_22_gamma_140,
+	s6e8ax0_22_gamma_150,
+	s6e8ax0_22_gamma_160,
+	s6e8ax0_22_gamma_170,
+	s6e8ax0_22_gamma_180,
+	s6e8ax0_22_gamma_190,
+	s6e8ax0_22_gamma_200,
+	s6e8ax0_22_gamma_210,
+	s6e8ax0_22_gamma_220,
+	s6e8ax0_22_gamma_230,
+	s6e8ax0_22_gamma_240,
+	s6e8ax0_22_gamma_250,
+	s6e8ax0_22_gamma_260,
+	s6e8ax0_22_gamma_270,
+	s6e8ax0_22_gamma_280,
+	s6e8ax0_22_gamma_300,
+};
+
+static void s6e8ax0_panel_cond(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xf8, 0x3d, 0x35, 0x00, 0x00, 0x00, 0x93, 0x00, 0x3c, 0x7d,
+		0x08, 0x27, 0x7d, 0x3f, 0x00, 0x00, 0x00, 0x20, 0x04, 0x08,
+		0x6e, 0x00, 0x00, 0x00, 0x02, 0x08, 0x08, 0x23, 0x23, 0xc0,
+		0xc8, 0x08, 0x48, 0xc1, 0x00, 0xc1, 0xff, 0xff, 0xc8
+	};
+	static const unsigned char data_to_send_panel_reverse[] = {
+		0xf8, 0x19, 0x35, 0x00, 0x00, 0x00, 0x93, 0x00, 0x3c, 0x7d,
+		0x08, 0x27, 0x7d, 0x3f, 0x00, 0x00, 0x00, 0x20, 0x04, 0x08,
+		0x6e, 0x00, 0x00, 0x00, 0x02, 0x08, 0x08, 0x23, 0x23, 0xc0,
+		0xc1, 0x01, 0x41, 0xc1, 0x00, 0xc1, 0xf6, 0xf6, 0xc1
+	};
+
+	if (lcd->pdata->panel_reverse)
+		dsi_dcs_write(lcd->entity.source, 0,
+				data_to_send_panel_reverse,
+				ARRAY_SIZE(data_to_send_panel_reverse));
+	else
+		dsi_dcs_write(lcd->entity.source, 0,
+				data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_display_cond(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xf2, 0x80, 0x03, 0x0d
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+/* Gamma 2.2 Setting (200cd, 7500K, 10MPCD) */
+static void s6e8ax0_gamma_cond(struct s6e8ax0 *lcd)
+{
+	unsigned int gamma = lcd->bd->props.brightness;
+
+	dsi_dcs_write(lcd->entity.source, 0,
+			s6e8ax0_22_gamma_table[gamma],
+			GAMMA_TABLE_COUNT);
+}
+
+static void s6e8ax0_gamma_update(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xf7, 0x03
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0, data_to_send,
+		ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_etc_cond1(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xd1, 0xfe, 0x80, 0x00, 0x01, 0x0b, 0x00, 0x00, 0x40,
+		0x0d, 0x00, 0x00
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_etc_cond2(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xb6, 0x0c, 0x02, 0x03, 0x32, 0xff, 0x44, 0x44, 0xc0,
+		0x00
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_etc_cond3(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xe1, 0x10, 0x1c, 0x17, 0x08, 0x1d
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_etc_cond4(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xe2, 0xed, 0x07, 0xc3, 0x13, 0x0d, 0x03
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_etc_cond5(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xf4, 0xcf, 0x0a, 0x12, 0x10, 0x19, 0x33, 0x02
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+static void s6e8ax0_etc_cond6(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xe3, 0x40
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_etc_cond7(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xe4, 0x00, 0x00, 0x14, 0x80, 0x00, 0x00, 0x00
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_elvss_set(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xb1, 0x04, 0x00
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_elvss_nvm_set(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xd9, 0x5c, 0x20, 0x0c, 0x0f, 0x41, 0x00, 0x10, 0x11,
+		0x12, 0xd1, 0x00, 0x00, 0x00, 0x00, 0x80, 0xcb, 0xed,
+		0x64, 0xaf
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_sleep_in(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0x10
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_sleep_out(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0x11
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_display_on(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0x29
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_display_off(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0x28
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_apply_level2_key(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xf0, 0x5a, 0x5a
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_acl_on(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xc0, 0x01
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+static void s6e8ax0_acl_off(struct s6e8ax0 *lcd)
+{
+	static const unsigned char data_to_send[] = {
+		0xc0, 0x00
+	};
+
+	dsi_dcs_write(lcd->entity.source, 0,
+		data_to_send, ARRAY_SIZE(data_to_send));
+}
+
+/* Full white 50% reducing setting */
+static void s6e8ax0_acl_ctrl_set(struct s6e8ax0 *lcd)
+{
+	/* Full white 50% reducing setting */
+	static const unsigned char cutoff_50[] = {
+		0xc1, 0x47, 0x53, 0x13, 0x53, 0x00, 0x00, 0x02, 0xcf,
+		0x00, 0x00, 0x04, 0xff,	0x00, 0x00, 0x00, 0x00, 0x00,
+		0x01, 0x08, 0x0f, 0x16, 0x1d, 0x24, 0x2a, 0x31, 0x38,
+		0x3f, 0x46
+	};
+	/* Full white 45% reducing setting */
+	static const unsigned char cutoff_45[] = {
+		0xc1, 0x47, 0x53, 0x13, 0x53, 0x00, 0x00, 0x02, 0xcf,
+		0x00, 0x00, 0x04, 0xff,	0x00, 0x00, 0x00, 0x00, 0x00,
+		0x01, 0x07, 0x0d, 0x13, 0x19, 0x1f, 0x25, 0x2b, 0x31,
+		0x37, 0x3d
+	};
+	/* Full white 40% reducing setting */
+	static const unsigned char cutoff_40[] = {
+		0xc1, 0x47, 0x53, 0x13, 0x53, 0x00, 0x00, 0x02, 0xcf,
+		0x00, 0x00, 0x04, 0xff,	0x00, 0x00, 0x00, 0x00, 0x00,
+		0x01, 0x06, 0x0c, 0x11, 0x16, 0x1c, 0x21, 0x26, 0x2b,
+		0x31, 0x36
+	};
+
+	if (lcd->acl_enable) {
+		if (lcd->cur_acl = 0) {
+			if (lcd->gamma = 0 || lcd->gamma = 1) {
+				s6e8ax0_acl_off(lcd);
+				dev_dbg(lcd->dev,
+					"cur_acl=%d\n", lcd->cur_acl);
+			} else
+				s6e8ax0_acl_on(lcd);
+		}
+		switch (lcd->gamma) {
+		case 0: /* 30cd */
+			s6e8ax0_acl_off(lcd);
+			lcd->cur_acl = 0;
+			break;
+		case 1 ... 3: /* 50cd ~ 90cd */
+			dsi_dcs_write(lcd->entity.source, 0,
+				cutoff_40,
+				ARRAY_SIZE(cutoff_40));
+			lcd->cur_acl = 40;
+			break;
+		case 4 ... 7: /* 120cd ~ 210cd */
+			dsi_dcs_write(lcd->entity.source, 0,
+				cutoff_45,
+				ARRAY_SIZE(cutoff_45));
+			lcd->cur_acl = 45;
+			break;
+		case 8 ... 10: /* 220cd ~ 300cd */
+			dsi_dcs_write(lcd->entity.source, 0,
+				cutoff_50,
+				ARRAY_SIZE(cutoff_50));
+			lcd->cur_acl = 50;
+			break;
+		default:
+			break;
+		}
+	} else {
+		s6e8ax0_acl_off(lcd);
+		lcd->cur_acl = 0;
+		dev_dbg(lcd->dev, "cur_acl = %d\n", lcd->cur_acl);
+	}
+}
+
+static void s6e8ax0_read_id(struct s6e8ax0 *lcd, u8 *mtp_id)
+{
+	unsigned int ret;
+	u8 addr = 0xd1;	/* MTP ID */
+
+	ret = dsi_dcs_read(lcd->entity.source, 0, addr, mtp_id, 3);
+}
+
+static int s6e8ax0_panel_init(struct s6e8ax0 *lcd)
+{
+	s6e8ax0_apply_level2_key(lcd);
+	s6e8ax0_sleep_out(lcd);
+	msleep(1);
+	s6e8ax0_panel_cond(lcd);
+	s6e8ax0_display_cond(lcd);
+	s6e8ax0_gamma_cond(lcd);
+	s6e8ax0_gamma_update(lcd);
+
+	s6e8ax0_etc_cond1(lcd);
+	s6e8ax0_etc_cond2(lcd);
+	s6e8ax0_etc_cond3(lcd);
+	s6e8ax0_etc_cond4(lcd);
+	s6e8ax0_etc_cond5(lcd);
+	s6e8ax0_etc_cond6(lcd);
+	s6e8ax0_etc_cond7(lcd);
+
+	s6e8ax0_elvss_nvm_set(lcd);
+	s6e8ax0_elvss_set(lcd);
+
+	s6e8ax0_acl_ctrl_set(lcd);
+	s6e8ax0_acl_on(lcd);
+
+	/* if ID3 value is not 33h, branch private elvss mode */
+	msleep(lcd->pdata->power_on_delay);
+
+	return 0;
+}
+
+static int s6e8ax0_update_gamma_ctrl(struct s6e8ax0 *lcd, int brightness)
+{
+	dsi_dcs_write(lcd->entity.source, 0,
+			s6e8ax0_22_gamma_table[brightness],
+			ARRAY_SIZE(s6e8ax0_22_gamma_table));
+
+	/* update gamma table. */
+	s6e8ax0_gamma_update(lcd);
+	lcd->gamma = brightness;
+
+	return 0;
+}
+
+static int s6e8ax0_gamma_ctrl(struct s6e8ax0 *lcd, int gamma)
+{
+	s6e8ax0_update_gamma_ctrl(lcd, gamma);
+
+	return 0;
+}
+
+static int s6e8ax0_get_brightness(struct backlight_device *bd)
+{
+	return bd->props.brightness;
+}
+
+static int s6e8ax0_set_brightness(struct backlight_device *bd)
+{
+	int ret = 0, brightness = bd->props.brightness;
+	struct s6e8ax0 *lcd = bl_get_data(bd);
+
+	if (brightness < MIN_BRIGHTNESS ||
+		brightness > bd->props.max_brightness) {
+		dev_err(lcd->dev,
+					"lcd brightness should be %d to %d.\n",
+					MIN_BRIGHTNESS, MAX_BRIGHTNESS);
+		return -EINVAL;
+	}
+
+	ret = s6e8ax0_gamma_ctrl(lcd, brightness);
+	if (ret) {
+		dev_err(lcd->dev,
+					"lcd brightness setting failed.\n");
+		return -EIO;
+	}
+
+	return ret;
+}
+
+static const struct backlight_ops s6e8ax0_backlight_ops = {
+	.get_brightness = s6e8ax0_get_brightness,
+	.update_status = s6e8ax0_set_brightness,
+};
+
+static int s6e8ax0_set_power(struct lcd_device *ld, int power)
+{
+	struct s6e8ax0 *lcd = lcd_get_data(ld);
+	enum display_entity_state state;
+	int ret;
+
+	if (power = FB_BLANK_POWERDOWN)
+		state = DISPLAY_ENTITY_STATE_OFF;
+	else if (power != FB_BLANK_UNBLANK)
+		state = DISPLAY_ENTITY_STATE_STANDBY;
+	else
+		state = DISPLAY_ENTITY_STATE_ON;
+
+	ret = display_entity_set_state(&lcd->entity, state);
+	if (ret)
+		return ret;
+
+	lcd->power = power;
+	return 0;
+}
+
+static int s6e8ax0_get_power(struct lcd_device *ld)
+{
+	struct s6e8ax0 *lcd = lcd_get_data(ld);
+
+	return lcd->power;
+}
+
+static struct lcd_ops s6e8ax0_lcd_ops = {
+	.set_power = s6e8ax0_set_power,
+	.get_power = s6e8ax0_get_power,
+};
+
+static void s6e8ax0_set_sequence(struct s6e8ax0 *lcd)
+{
+	u8 mtp_id[3] = {0, };
+
+	msleep(100);
+
+	s6e8ax0_read_id(lcd, mtp_id);
+	if (mtp_id[0] = 0x00)
+		dev_err(lcd->dev, "read id failed\n");
+
+	dev_info(lcd->dev, "Read ID : %x, %x, %x\n",
+			mtp_id[0], mtp_id[1], mtp_id[2]);
+
+	if (mtp_id[2] = 0x33)
+		dev_info(lcd->dev,
+			"ID-3 is 0xff does not support dynamic elvss\n");
+	else
+		dev_info(lcd->dev,
+			"ID-3 is 0x%x support dynamic elvss\n", mtp_id[2]);
+
+	s6e8ax0_panel_init(lcd);
+	s6e8ax0_display_on(lcd);
+}
+
+#ifdef CONFIG_OF
+static int s6e8ax0_generic_reset(struct device *dev)
+{
+	struct s6e8ax0 *lcd = dev_get_drvdata(dev);
+
+	mdelay(10);
+	gpio_set_value(lcd->reset_gpio, 0);
+	mdelay(10);
+	gpio_set_value(lcd->reset_gpio, 1);
+
+	return 0;
+}
+
+static struct s6e8ax0_platform_data *s6e8ax0_parse_dt(struct s6e8ax0 *lcd)
+{
+	struct device_node *node = lcd->dev->of_node;
+	struct s6e8ax0_platform_data *data;
+	const __be32 *prop_data;
+	int ret;
+
+	data = devm_kzalloc(lcd->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		dev_err(lcd->dev, "failed to allocate platform data.\n");
+		return NULL;
+	}
+
+	ret = of_get_videomode(node, &data->mode, 0);
+	if (ret) {
+		dev_err(lcd->dev, "failed to read video mode from DT\n");
+		return NULL;
+	}
+
+	lcd->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
+	if (lcd->reset_gpio < 0)
+		return NULL;
+
+	prop_data = of_get_property(node, "reset-delay", NULL);
+	if (!prop_data)
+		return NULL;
+	data->reset_delay = be32_to_cpu(*prop_data);
+
+	prop_data = of_get_property(node, "power-off-delay", NULL);
+	if (!prop_data)
+		return NULL;
+	data->power_off_delay = be32_to_cpu(*prop_data);
+
+	prop_data = of_get_property(node, "power-on-delay", NULL);
+	if (!prop_data)
+		return NULL;
+	data->power_on_delay = be32_to_cpu(*prop_data);
+
+	data->reset = s6e8ax0_generic_reset;
+
+	return data;
+}
+
+static struct of_device_id s6e8ax0_of_match[] = {
+	{ .compatible = "samsung,s6e8ax0" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, s6e8ax0_of_match);
+#else
+static struct s6e8ax0_platform_data *s6e8ax0_parse_dt(struct s6e8ax0 *lcd)
+{
+	return NULL;
+}
+#endif
+
+static const struct display_entity_interface_params s6e8ax0_params = {
+	.type = DISPLAY_ENTITY_INTERFACE_DSI,
+	.p.dsi = {
+		.format = DSI_FMT_RGB888,
+		.mode = DSI_MODE_VIDEO | DSI_MODE_VIDEO_BURST
+			| DSI_MODE_VIDEO_HFP | DSI_MODE_VIDEO_HBP
+			| DSI_MODE_VIDEO_HSA | DSI_MODE_EOT_PACKET
+			| DSI_MODE_VSYNC_FLUSH,
+		.data_lanes = 0xf,
+		.hs_clk_freq = 500000000,
+		.esc_clk_freq = 10000000,
+	},
+};
+
+static int s6e8ax0_set_state(struct display_entity *entity,
+			    enum display_entity_state state)
+{
+	struct s6e8ax0 *panel = to_panel(entity);
+
+	switch (state) {
+	case DISPLAY_ENTITY_STATE_OFF:
+		if (entity->state = DISPLAY_ENTITY_STATE_ON) {
+			s6e8ax0_sleep_in(panel);
+			panel->entity.source->common_ops->set_stream(entity->source,
+						DISPLAY_ENTITY_STREAM_STOPPED);
+
+			msleep(panel->pdata->power_off_delay);
+			s6e8ax0_display_off(panel);
+
+			panel->entity.source->ops.dsi->disable(entity->source);
+
+			regulator_bulk_disable(ARRAY_SIZE(panel->supplies),
+								panel->supplies);
+		} else if (entity->state = DISPLAY_ENTITY_STATE_STANDBY) {
+			msleep(panel->pdata->power_off_delay);
+			s6e8ax0_display_off(panel);
+
+			panel->entity.source->ops.dsi->disable(entity->source);
+
+			regulator_bulk_disable(ARRAY_SIZE(panel->supplies),
+								panel->supplies);
+		}
+		break;
+
+	case DISPLAY_ENTITY_STATE_STANDBY:
+		if (entity->state = DISPLAY_ENTITY_STATE_ON) {
+			s6e8ax0_sleep_in(panel);
+			panel->entity.source->common_ops->set_stream(entity->source,
+						DISPLAY_ENTITY_STREAM_STOPPED);
+		} else if (entity->state = DISPLAY_ENTITY_STATE_OFF) {
+			msleep(panel->pdata->power_on_delay);
+
+			regulator_bulk_enable(ARRAY_SIZE(panel->supplies),
+								panel->supplies);
+
+			msleep(panel->pdata->reset_delay);
+
+			/* lcd reset */
+			if (panel->pdata->reset)
+				panel->pdata->reset(panel->dev);
+			msleep(5);
+
+			panel->entity.source->ops.dsi->enable(entity->source);
+
+			s6e8ax0_set_sequence(panel);
+			s6e8ax0_sleep_in(panel);
+		}
+		break;
+
+	case DISPLAY_ENTITY_STATE_ON:
+		if (entity->state = DISPLAY_ENTITY_STATE_OFF) {
+			msleep(panel->pdata->power_on_delay);
+
+			regulator_bulk_enable(ARRAY_SIZE(panel->supplies),
+								panel->supplies);
+
+			msleep(panel->pdata->reset_delay);
+
+			/* lcd reset */
+			if (panel->pdata->reset)
+				panel->pdata->reset(panel->dev);
+			msleep(5);
+
+			panel->entity.source->ops.dsi->enable(entity->source);
+
+			s6e8ax0_set_sequence(panel);
+
+			panel->entity.source->common_ops->set_stream(entity->source,
+					DISPLAY_ENTITY_STREAM_CONTINUOUS);
+		} else {
+			panel->entity.source->common_ops->set_stream(entity->source,
+					DISPLAY_ENTITY_STREAM_CONTINUOUS);
+			s6e8ax0_sleep_out(panel);
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int s6e8ax0_get_modes(struct display_entity *entity,
+			    const struct videomode **modes)
+{
+	struct s6e8ax0 *panel = to_panel(entity);
+
+	*modes = &panel->pdata->mode;
+	return 1;
+}
+
+static int s6e8ax0_get_size(struct display_entity *entity,
+			   unsigned int *width, unsigned int *height)
+{
+	struct s6e8ax0 *panel = to_panel(entity);
+
+	*width = panel->pdata->width;
+	*height = panel->pdata->height;
+	return 0;
+}
+
+static int s6e8ax0_get_params(struct display_entity *entity,
+				struct display_entity_interface_params *params)
+{
+	*params = s6e8ax0_params;
+	return 0;
+}
+
+static const struct display_entity_control_ops s6e8ax0_control_ops = {
+	.set_state = s6e8ax0_set_state,
+	.get_modes = s6e8ax0_get_modes,
+	.get_size = s6e8ax0_get_size,
+	.get_params = s6e8ax0_get_params,
+};
+
+static void s6e8ax0_release(struct display_entity *entity)
+{
+	struct s6e8ax0 *panel = to_panel(entity);
+
+	backlight_device_unregister(panel->bd);
+	lcd_device_unregister(panel->ld);
+	regulator_bulk_free(ARRAY_SIZE(panel->supplies), panel->supplies);
+	kfree(panel);
+}
+
+static int s6e8ax0_probe(struct platform_device *pdev)
+{
+	struct s6e8ax0 *lcd;
+	int ret;
+
+	lcd = kzalloc(sizeof(struct s6e8ax0), GFP_KERNEL);
+	if (!lcd) {
+		dev_err(&pdev->dev, "failed to allocate s6e8ax0 structure.\n");
+		return -ENOMEM;
+	}
+
+	lcd->dev = &pdev->dev;
+	lcd->pdata = (struct s6e8ax0_platform_data *)pdev->dev.platform_data;
+
+	if (!lcd->pdata) {
+		lcd->pdata = s6e8ax0_parse_dt(lcd);
+		if (!lcd->pdata) {
+			dev_err(&pdev->dev, "failed to find platform data\n");
+			return -ENODEV;
+		}
+	}
+
+	lcd->supplies[0].supply = "vdd3";
+	lcd->supplies[1].supply = "vci";
+	ret = regulator_bulk_get(&pdev->dev,
+				ARRAY_SIZE(lcd->supplies), lcd->supplies);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to get regulators: %d\n", ret);
+		goto err_regulator_bulk_get;
+	}
+
+	lcd->ld = lcd_device_register("s6e8ax0", &pdev->dev, lcd,
+			&s6e8ax0_lcd_ops);
+	if (IS_ERR(lcd->ld)) {
+		dev_err(&pdev->dev, "failed to register lcd ops.\n");
+		ret = PTR_ERR(lcd->ld);
+		goto err_lcd_register;
+	}
+
+	lcd->bd = backlight_device_register("s6e8ax0-bl", &pdev->dev, lcd,
+			&s6e8ax0_backlight_ops, NULL);
+	if (IS_ERR(lcd->bd)) {
+		dev_err(&pdev->dev, "failed to register backlight ops.\n");
+		ret = PTR_ERR(lcd->bd);
+		goto err_backlight_register;
+	}
+
+	lcd->acl_enable = 1;
+	lcd->cur_acl = 0;
+	lcd->power = FB_BLANK_UNBLANK;
+
+	lcd->bd->props.max_brightness = MAX_BRIGHTNESS;
+	lcd->bd->props.brightness = MAX_BRIGHTNESS;
+
+	lcd->entity.of_node = pdev->dev.of_node;
+	lcd->entity.dev = &pdev->dev;
+	lcd->entity.release = s6e8ax0_release;
+	lcd->entity.ops = &s6e8ax0_control_ops;
+
+	platform_set_drvdata(pdev, lcd);
+
+	ret = display_entity_register(&lcd->entity);
+	if (ret < 0)
+		goto err_display_register;
+
+	display_entity_set_state(&lcd->entity, DISPLAY_ENTITY_STATE_ON);
+
+	dev_dbg(&pdev->dev, "probed s6e8ax0 panel driver.\n");
+
+	return 0;
+
+err_display_register:
+	backlight_device_unregister(lcd->bd);
+err_backlight_register:
+	lcd_device_unregister(lcd->ld);
+err_lcd_register:
+	regulator_bulk_free(ARRAY_SIZE(lcd->supplies), lcd->supplies);
+err_regulator_bulk_get:
+	kfree(lcd);
+
+	return ret;
+}
+
+static int s6e8ax0_remove(struct platform_device *dev)
+{
+	struct s6e8ax0 *lcd = platform_get_drvdata(dev);
+
+	platform_set_drvdata(dev, NULL);
+	display_entity_unregister(&lcd->entity);
+
+	return 0;
+}
+
+static int s6e8ax0_suspend(struct device *dev)
+{
+	struct s6e8ax0 *lcd = dev_get_drvdata(dev);
+
+	if (lcd->power = FB_BLANK_UNBLANK)
+		display_entity_set_state(&lcd->entity,
+						DISPLAY_ENTITY_STATE_OFF);
+
+	return 0;
+}
+
+static int s6e8ax0_resume(struct device *dev)
+{
+	struct s6e8ax0 *lcd = dev_get_drvdata(dev);
+
+	if (lcd->power = FB_BLANK_UNBLANK)
+		display_entity_set_state(&lcd->entity,
+						DISPLAY_ENTITY_STATE_ON);
+
+	return 0;
+}
+
+static struct dev_pm_ops s6e8ax0_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(s6e8ax0_suspend, s6e8ax0_resume)
+};
+
+static struct platform_driver s6e8ax0_driver = {
+	.probe = s6e8ax0_probe,
+	.remove = s6e8ax0_remove,
+	.driver = {
+		.name = "panel_s6e8ax0",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(s6e8ax0_of_match),
+		.pm = &s6e8ax0_pm_ops,
+	},
+};
+module_platform_driver(s6e8ax0_driver);
+
+MODULE_AUTHOR("Donghwa Lee <dh09.lee@samsung.com>");
+MODULE_AUTHOR("Inki Dae <inki.dae@samsung.com>");
+MODULE_AUTHOR("Tomasz Figa <t.figa@samsung.com>");
+MODULE_DESCRIPTION("MIPI-DSI based s6e8ax0 AMOLED LCD Panel Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/video/panel-s6e8ax0.h b/include/video/panel-s6e8ax0.h
new file mode 100644
index 0000000..e522bfb
--- /dev/null
+++ b/include/video/panel-s6e8ax0.h
@@ -0,0 +1,41 @@
+/*
+ * Renesas R61505-based Display Panels
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * Contacts: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __PANEL_S6E8AX0_H__
+#define __PANEL_S6E8AX0_H__
+
+#include <linux/videomode.h>
+
+struct s6e8ax0_platform_data {
+	unsigned long width;		/* Panel width in mm */
+	unsigned long height;		/* Panel height in mm */
+	struct videomode mode;
+
+	/* reset lcd panel device. */
+	int (*reset)(struct device *dev);
+
+	/* it indicates whether lcd panel was enabled
+	   from bootloader or not. */
+	int lcd_enabled;
+	/* it means delay for stable time when it becomes low to high
+	   or high to low that is dependent on whether reset gpio is
+	   low active or high active. */
+	unsigned int reset_delay;
+	/* stable time needing to become lcd power on. */
+	unsigned int power_on_delay;
+	/* stable time needing to become lcd power off. */
+	unsigned int power_off_delay;
+	/* panel is reversed */
+	bool panel_reverse;
+};
+
+#endif /* __PANEL_S6E8AX0_H__ */
-- 
1.8.1

