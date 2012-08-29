From: Zhou Zhu <zzhu3@marvell.com>
Date: Wed, 29 Aug 2012 10:15:03 +0000
Subject: [PATCH 4/4] video: mmp: add tpo hvga panel support
Message-Id: <1346235303-12651-1-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Lisa Du <cldu@marvell.com>

Add tpo hvga panel support in marvell display framework.
This panel driver implements modes query and on/off commands by spi.
This panel driver also get panel config/ plat power on/off/ connected
path name from machine-info.
This panel driver uses mmp_disp supplied register_panel function to
register panel to path as machine-info defined.

Change-Id: I1d37a9b436f64a01954d7f32407f84f67945286f
Signed-off-by: Lisa Du <cldu@marvell.com>
---
 drivers/video/mmp/Kconfig                 |    1 +
 drivers/video/mmp/Makefile                |    2 +-
 drivers/video/mmp/panel/Kconfig           |    5 +
 drivers/video/mmp/panel/Makefile          |    1 +
 drivers/video/mmp/panel/tpo_tj032md01bw.c |  181 +++++++++++++++++++++++++++++
 5 files changed, 189 insertions(+), 1 deletions(-)
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
index 0000000..b6aac76
--- /dev/null
+++ b/drivers/video/mmp/panel/Kconfig
@@ -0,0 +1,5 @@
+config MMP_PANEL_TPOHVGA
+	bool "tpohvga panel TJ032MD01BW support"
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
index 0000000..8217650
--- /dev/null
+++ b/drivers/video/mmp/panel/tpo_tj032md01bw.c
@@ -0,0 +1,181 @@
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
+#include <video/mmp_disp.h>
+
+static u16 panel_init[] = {
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
+static u16 panel_poweroff[] = {
+	0x07d9,
+};
+
+static struct mmp_panel_cmds tpohvga_on_cmds[] = {
+	[0] = {
+		.cmds = panel_init,
+		.cmds_num = ARRAY_SIZE(panel_init),
+		.sleep = 0,
+	},
+};
+
+static struct mmp_panel_cmds tpohvga_off_cmds[] = {
+	[0] = {
+		.cmds = panel_poweroff,
+		.cmds_num = ARRAY_SIZE(panel_poweroff),
+		.sleep = 0,
+	},
+};
+
+static struct mmp_spi_cfg tpohvga_spi_cfg = {
+	.clk_cnt = 16,
+	.tx_bits = 16,
+	.wire_num = 1,
+};
+
+static struct mmp_panel_cmd_sets tpohvga_spi_cmds = {
+	.type = PANEL_CMDS_SPI,
+	.on_cmds = tpohvga_on_cmds,
+	.on_cmds_num = ARRAY_SIZE(tpohvga_on_cmds),
+	.off_cmds = tpohvga_off_cmds,
+	.off_cmds_num = ARRAY_SIZE(tpohvga_off_cmds),
+	.config = &tpohvga_spi_cfg,
+};
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
+	.panel_type = PANELTYPE_Active,
+	.get_modelist = tpohvga_get_modelist,
+	.cmd_set = &tpohvga_spi_cmds,
+};
+
+static int __devinit tpohvga_probe(struct platform_device *pdev)
+{
+	struct mmp_mach_panel_info *mi;
+	/* get configs from platform data */
+	mi = pdev->dev.platform_data;
+	if (mi = NULL) {
+		dev_err(&pdev->dev, "%s: no platform data defined\n", __func__);
+		return -EINVAL;
+	}
+
+	panel_tpohvga.plat_set_onoff = mi->plat_set_onoff;
+	panel_tpohvga.plat_path_name = mi->plat_path_name;
+	panel_tpohvga.dev = &pdev->dev;
+
+	if (!mmp_register_panel(&panel_tpohvga)) {
+		dev_err(&pdev->dev, "%s: register failed\n", __func__);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static struct platform_driver panel_tpohvga_driver = {
+	.driver		= {
+		.name	= "tpo-hvga",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= tpohvga_probe,
+};
+
+static int __devinit panel_tpohvga_init(void)
+{
+	return platform_driver_register(&panel_tpohvga_driver);
+}
+module_init(panel_tpohvga_init);
+
+MODULE_AUTHOR("Lisa Du<cldu@marvell.com>");
+MODULE_DESCRIPTION("Panel driver for tpohvga");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4

