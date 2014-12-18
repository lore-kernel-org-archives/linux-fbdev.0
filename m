From: gyungoh@gmail.com
Date: Thu, 18 Dec 2014 05:47:46 +0000
Subject: [PATCH v10 1/6] mfd: Add support for Skyworks SKY81452 driver
Message-Id: <1418881671-3495-2-git-send-email-jack.yoo@skyworksinc.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418881671-3495-1-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1418881671-3495-1-git-send-email-jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, matti.vaittinen-OYasijW0DpE@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, florian.vaussard-p8DiymsW2f8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hytszk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Gyungoh Yoo <jack.yoo@skyworksinc.com>

Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Changes v10:
Nothing

Changes v9:
Nothing

Changes v8:
Nothing

Changes v7:
Modified licensing text to GPLv2

Changes v6:
Added new line character at the end of line of dev_err()

Changes v5:
Move sky81452-backlight.h to include/linux/platform_data

Changes v4:
Removed MODULE_VERSION()
Modified license to GPLv2

Changes v3:
Fixed the backlight name from 'sky81452-bl' to 'sky81452-backlight'
Assigned mfd_cell.of_compatible for binding device node
Modified error messages

Changes v2:
Renamed CONFIG_SKY81452 to CONFIG_MFD_SKY81452
Changed the dependency from I2C=y to I2C, for CONFIG_MFD_SKY81452
Added message for exception or errors

 drivers/mfd/Kconfig          |  12 +++++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/sky81452.c       | 108 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sky81452.h |  31 +++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 drivers/mfd/sky81452.c
 create mode 100644 include/linux/mfd/sky81452.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 1456ea7..a54244c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -693,6 +693,18 @@ config MFD_SM501_GPIO
 	 lines on the SM501. The platform data is used to supply the
 	 base number for the first GPIO line to register.
 
+config MFD_SKY81452
+	tristate "Skyworks Solutions SKY81452"
+	select MFD_CORE
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  This is the core driver for the Skyworks SKY81452 backlight and
+	  voltage regulator device.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sky81452.
+
 config MFD_SMSC
        bool "SMSC ECE1099 series chips"
        depends on I2C=y
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 8bd54b1..d9683ea 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -174,6 +174,7 @@ obj-$(CONFIG_MFD_STW481X)	+= stw481x.o
 obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
+obj-$(CONFIG_MFD_SKY81452)		+= sky81452.o
 
 intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
diff --git a/drivers/mfd/sky81452.c b/drivers/mfd/sky81452.c
new file mode 100644
index 0000000..b0c9b04
--- /dev/null
+++ b/drivers/mfd/sky81452.c
@@ -0,0 +1,108 @@
+/*
+ * sky81452.c	SKY81452 MFD driver
+ *
+ * Copyright 2014 Skyworks Solutions Inc.
+ * Author : Gyungoh Yoo <jack.yoo@skyworksinc.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/sky81452.h>
+
+static const struct regmap_config sky81452_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int sky81452_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	const struct sky81452_platform_data *pdata = dev_get_platdata(dev);
+	struct mfd_cell cells[2];
+	struct regmap *regmap;
+	int ret;
+
+	if (!pdata) {
+		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+	}
+
+	regmap = devm_regmap_init_i2c(client, &sky81452_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to initialize.err=%ld\n", PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	i2c_set_clientdata(client, regmap);
+
+	memset(cells, 0, sizeof(cells));
+	cells[0].name = "sky81452-backlight";
+	cells[0].of_compatible = "skyworks,sky81452-backlight";
+	cells[0].platform_data = pdata->bl_pdata;
+	cells[0].pdata_size = sizeof(*pdata->bl_pdata);
+	cells[1].name = "sky81452-regulator";
+	cells[1].platform_data = pdata->regulator_init_data;
+	cells[1].pdata_size = sizeof(*pdata->regulator_init_data);
+
+	ret = mfd_add_devices(dev, -1, cells, ARRAY_SIZE(cells), NULL, 0, NULL);
+	if (ret)
+		dev_err(dev, "failed to add child devices. err=%d\n", ret);
+
+	return ret;
+}
+
+static int sky81452_remove(struct i2c_client *client)
+{
+	mfd_remove_devices(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id sky81452_ids[] = {
+	{ "sky81452" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sky81452_ids);
+
+#ifdef CONFIG_OF
+static const struct of_device_id sky81452_of_match[] = {
+	{ .compatible = "skyworks,sky81452", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sky81452_of_match);
+#endif
+
+static struct i2c_driver sky81452_driver = {
+	.driver = {
+		.name = "sky81452",
+		.of_match_table = of_match_ptr(sky81452_of_match),
+	},
+	.probe = sky81452_probe,
+	.remove = sky81452_remove,
+	.id_table = sky81452_ids,
+};
+
+module_i2c_driver(sky81452_driver);
+
+MODULE_DESCRIPTION("Skyworks SKY81452 MFD driver");
+MODULE_AUTHOR("Gyungoh Yoo <jack.yoo@skyworksinc.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/sky81452.h b/include/linux/mfd/sky81452.h
new file mode 100644
index 0000000..b0925fa
--- /dev/null
+++ b/include/linux/mfd/sky81452.h
@@ -0,0 +1,31 @@
+/*
+ * sky81452.h	SKY81452 MFD driver
+ *
+ * Copyright 2014 Skyworks Solutions Inc.
+ * Author : Gyungoh Yoo <jack.yoo@skyworksinc.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _SKY81452_H
+#define _SKY81452_H
+
+#include <linux/platform_data/sky81452-backlight.h>
+#include <linux/regulator/machine.h>
+
+struct sky81452_platform_data {
+	struct sky81452_bl_platform_data *bl_pdata;
+	struct regulator_init_data *regulator_init_data;
+};
+
+#endif
-- 
1.9.1

