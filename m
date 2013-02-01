From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 01 Feb 2013 09:20:29 +0000
Subject: [PATCH v6 4/8] video: mmp: add tpo hvga panel supported
Message-Id: <1359710429-9715-1-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Lisa Du <cldu@marvell.com>

Add tpo hvga panel support in marvell display framework.
This panel driver implements modes query and power on/off.

This panel driver gets panel config/ plat power on/off/ connected
path name from machine-info and registered as a spi device.
This panel driver uses mmp_disp supplied register_panel function to
register panel to path as machine-info defined.

Signed-off-by: Lisa Du <cldu@marvell.com>
Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/video/mmp/Kconfig                 |    1 +
 drivers/video/mmp/Makefile                |    2 +-
 drivers/video/mmp/panel/Kconfig           |    6 +
 drivers/video/mmp/panel/Makefile          |    1 +
 drivers/video/mmp/panel/tpo_tj032md01bw.c |  186 +++++++++++++++++++++++++++++
 5 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/mmp/panel/Kconfig
 create mode 100644 drivers/video/mmp/panel/Makefile
 create mode 100644 drivers/video/mmp/panel/tpo_tj032md01bw.c

diff --git a/drivers/video/mmp/Kconfig b/drivers/video/mmp/Kconfig
index ed51d15..e9ea39e 100644
--- a/drivers/video/mmp/Kconfig
+++ b/drivers/video/mmp/Kconfig
@@ -6,5 +6,6 @@ menuconfig MMP_DISP
 
 if MMP_DISP
 source "drivers/video/mmp/hw/Kconfig"
+source "drivers/video/mmp/panel/Kconfig"
 source "drivers/video/mmp/fb/Kconfig"
 endif
diff --git a/drivers/video/mmp/Makefile b/drivers/video/mmp/Makefile
index 6999a09..a014cb3 100644
--- a/drivers/video/mmp/Makefile
+++ b/drivers/video/mmp/Makefile
@@ -1 +1 @@
-obj-y += core.o hw/ fb/
+obj-y += core.o hw/ panel/ fb/
diff --git a/drivers/video/mmp/panel/Kconfig b/drivers/video/mmp/panel/Kconfig
new file mode 100644
index 0000000..4b2c4f4
--- /dev/null
+++ b/drivers/video/mmp/panel/Kconfig
@@ -0,0 +1,6 @@
+config MMP_PANEL_TPOHVGA
+	bool "tpohvga panel TJ032MD01BW support"
+	depends on SPI_MASTER
+	default n
+	help
+		tpohvga panel support
diff --git a/drivers/video/mmp/panel/Makefile b/drivers/video/mmp/panel/Makefile
new file mode 100644
index 0000000..2f91611
--- /dev/null
+++ b/drivers/video/mmp/panel/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MMP_PANEL_TPOHVGA)    += tpo_tj032md01bw.o
diff --git a/drivers/video/mmp/panel/tpo_tj032md01bw.c b/drivers/video/mmp/panel/tpo_tj032md01bw.c
new file mode 100644
index 0000000..998978b
--- /dev/null
+++ b/drivers/video/mmp/panel/tpo_tj032md01bw.c
@@ -0,0 +1,186 @@
+/*
+ * linux/drivers/video/mmp/panel/tpo_tj032md01bw.c
+ * active panel using spi interface to do init
+ *
+ * Copyright (C) 2012 Marvell Technology Group Ltd.
+ * Authors:  Guoqing Li <ligq@marvell.com>
+ *          Lisa Du <cldu@marvell.com>
+ *          Zhou Zhu <zzhu3@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/spi/spi.h>
+#include <video/mmp_disp.h>
+
+static u16 init[] = {
+	0x0801,
+	0x0800,
+	0x0200,
+	0x0304,
+	0x040e,
+	0x0903,
+	0x0b18,
+	0x0c53,
+	0x0d01,
+	0x0ee0,
+	0x0f01,
+	0x1058,
+	0x201e,
+	0x210a,
+	0x220a,
+	0x231e,
+	0x2400,
+	0x2532,
+	0x2600,
+	0x27ac,
+	0x2904,
+	0x2aa2,
+	0x2b45,
+	0x2c45,
+	0x2d15,
+	0x2e5a,
+	0x2fff,
+	0x306b,
+	0x310d,
+	0x3248,
+	0x3382,
+	0x34bd,
+	0x35e7,
+	0x3618,
+	0x3794,
+	0x3801,
+	0x395d,
+	0x3aae,
+	0x3bff,
+	0x07c9,
+};
+
+static u16 poweroff[] = {
+	0x07d9,
+};
+
+struct tpohvga_plat_data {
+	void (*plat_onoff)(int status);
+	struct spi_device *spi;
+};
+
+static void tpohvga_onoff(struct mmp_panel *panel, int status)
+{
+	struct tpohvga_plat_data *plat = panel->plat_data;
+	int ret;
+
+	if (status) {
+		plat->plat_onoff(1);
+
+		ret = spi_write(plat->spi, init, sizeof(init));
+		if (ret < 0)
+			dev_warn(panel->dev, "init cmd failed(%d)\n", ret);
+	} else {
+		ret = spi_write(plat->spi, poweroff, sizeof(poweroff));
+		if (ret < 0)
+			dev_warn(panel->dev, "poweroff cmd failed(%d)\n", ret);
+
+		plat->plat_onoff(0);
+	}
+}
+
+static struct mmp_mode mmp_modes_tpohvga[] = {
+	[0] = {
+		.pixclock_freq = 10394400,
+		.refresh = 60,
+		.xres = 320,
+		.yres = 480,
+		.hsync_len = 10,
+		.left_margin = 15,
+		.right_margin = 10,
+		.vsync_len = 2,
+		.upper_margin = 4,
+		.lower_margin = 2,
+		.invert_pixclock = 1,
+		.pix_fmt_out = PIXFMT_RGB565,
+	},
+};
+
+static int tpohvga_get_modelist(struct mmp_panel *panel,
+		struct mmp_mode **modelist)
+{
+	*modelist = mmp_modes_tpohvga;
+	return 1;
+}
+
+static struct mmp_panel panel_tpohvga = {
+	.name = "tpohvga",
+	.panel_type = PANELTYPE_ACTIVE,
+	.get_modelist = tpohvga_get_modelist,
+	.set_onoff = tpohvga_onoff,
+};
+
+static int tpohvga_probe(struct spi_device *spi)
+{
+	struct mmp_mach_panel_info *mi;
+	int ret;
+	struct tpohvga_plat_data *plat_data;
+
+	/* get configs from platform data */
+	mi = spi->dev.platform_data;
+	if (mi = NULL) {
+		dev_err(&spi->dev, "%s: no platform data defined\n", __func__);
+		return -EINVAL;
+	}
+
+	/* setup spi related info */
+	spi->bits_per_word = 16;
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		dev_err(&spi->dev, "spi setup failed %d", ret);
+		return ret;
+	}
+
+	plat_data = kzalloc(sizeof(*plat_data), GFP_KERNEL);
+	if (plat_data = NULL)
+		return -ENOMEM;
+
+	plat_data->spi = spi;
+	plat_data->plat_onoff = mi->plat_set_onoff;
+	panel_tpohvga.plat_data = plat_data;
+	panel_tpohvga.plat_path_name = mi->plat_path_name;
+	panel_tpohvga.dev = &spi->dev;
+
+	mmp_register_panel(&panel_tpohvga);
+
+	return 0;
+}
+
+static struct spi_driver panel_tpohvga_driver = {
+	.driver		= {
+		.name	= "tpo-hvga",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= tpohvga_probe,
+};
+module_spi_driver(panel_tpohvga_driver);
+
+MODULE_AUTHOR("Lisa Du<cldu@marvell.com>");
+MODULE_DESCRIPTION("Panel driver for tpohvga");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

