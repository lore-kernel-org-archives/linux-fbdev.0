From: Inki Dae <inki.dae@samsung.com>
Date: Thu, 14 Apr 2011 12:15:29 +0000
Subject: [PATCH 2/2] video: Samsung SoC MIPI-DSI based sample lcd panel driver.
Message-Id: <1302783329-31266-1-git-send-email-inki.dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

this driver provides an example for implementing MIPI-DSI based lcd panel
driver and includes most features for LCD Panel driver so just implement
lcd register setting functions using sample functions.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 Documentation/s5p_mipi_dsim/dsim_sample_lcd.c |  244 +++++++++++++++++++++++++
 1 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/s5p_mipi_dsim/dsim_sample_lcd.c

diff --git a/Documentation/s5p_mipi_dsim/dsim_sample_lcd.c b/Documentation/s5p_mipi_dsim/dsim_sample_lcd.c
new file mode 100644
index 0000000..7f38c84
--- /dev/null
+++ b/Documentation/s5p_mipi_dsim/dsim_sample_lcd.c
@@ -0,0 +1,244 @@
+/*
+ * Samsung SoC MIPI-DSI based sample lcd panel driver.
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd
+ *
+ * Inki Dae, <inki.dae@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/ctype.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/lcd.h>
+#include <linux/backlight.h>
+
+#include <video/mipi_display.h>
+
+#include <plat/mipi_dsim.h>
+
+#define MIN_BRIGHTNESS		(0)
+#define MAX_BRIGHTNESS		(10)
+
+#define lcd_to_master(a)	(a->dsim_dev->master)
+#define lcd_to_master_ops(a)	((lcd_to_master(a))->master_ops)
+
+struct dsim_lcd {
+	struct device			*dev;
+
+	struct lcd_device		*ld;
+	struct backlight_device		*bd;
+
+	struct mipi_dsim_lcd_device	*dsim_dev;
+	struct lcd_platform_data	*ddi_pd;
+};
+
+static void dsim_lcd_short_write(struct dsim_lcd *lcd)
+{
+	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
+
+	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_SHORT_WRITE_PARAM,
+				0x00, 0x00);
+}
+
+static void dsim_lcd_long_write(struct dsim_lcd *lcd)
+{
+	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
+	unsigned char data_to_send[8] = {
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+	};
+
+	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
+		(unsigned int) data_to_send, sizeof(data_to_send));
+}
+
+static int dsim_lcd_panel_init(struct dsim_lcd *lcd)
+{
+
+	dsim_lcd_short_write(lcd);
+	dsim_lcd_long_write(lcd);
+
+	return 0;
+}
+
+static int dsim_lcd_gamma_ctrl(struct dsim_lcd *lcd, int gamma)
+{
+	struct mipi_dsim_master_ops *ops = lcd_to_master_ops(lcd);
+
+	/* update gamma value at here. */
+
+	return 0;
+}
+
+static int dsim_lcd_set_power(struct lcd_device *ld, int power)
+{
+	return 0;
+}
+
+static int dsim_lcd_get_power(struct lcd_device *ld)
+{
+	return 0;
+}
+
+static int dsim_lcd_get_brightness(struct backlight_device *bd)
+{
+	return bd->props.brightness;
+}
+
+static int dsim_lcd_set_brightness(struct backlight_device *bd)
+{
+	int ret = 0, brightness = bd->props.brightness;
+	struct dsim_lcd *lcd = bl_get_data(bd);
+
+	if (brightness < MIN_BRIGHTNESS ||
+		brightness > bd->props.max_brightness) {
+		dev_err(lcd->dev, "lcd brightness should be %d to %d.\n",
+			MIN_BRIGHTNESS, MAX_BRIGHTNESS);
+		return -EINVAL;
+	}
+
+	ret = dsim_lcd_gamma_ctrl(lcd, bd->props.brightness);
+	if (ret) {
+		dev_err(&bd->dev, "lcd brightness setting failed.\n");
+		return -EIO;
+	}
+
+	return ret;
+}
+
+static const struct lcd_ops dsim_lcd_lcd_ops = {
+	.set_power = dsim_lcd_set_power,
+	.get_power = dsim_lcd_get_power,
+};
+
+static const struct backlight_ops dsim_lcd_backlight_ops = {
+	.get_brightness = dsim_lcd_get_brightness,
+	.update_status = dsim_lcd_set_brightness,
+};
+
+static int dsim_lcd_probe(struct mipi_dsim_lcd_device *dsim_dev)
+{
+	struct dsim_lcd *lcd = NULL;
+	int ret;
+
+	lcd = kzalloc(sizeof(struct dsim_lcd), GFP_KERNEL);
+	if (!lcd) {
+		dev_err(&dsim_dev->dev, "failed to allocate dsim_lcd structure.\n");
+		return -ENOMEM;
+	}
+
+	lcd->dsim_dev = dsim_dev;
+	lcd->ddi_pd = (struct lcd_platform_data *)dsim_dev->platform_data;
+	lcd->dev = &dsim_dev->dev;
+
+	dev_set_drvdata(&dsim_dev->dev, lcd);
+
+	lcd->ld = lcd_device_register("dsim_lcd", lcd->dev, lcd,
+			&dsim_lcd_lcd_ops);
+	if (IS_ERR(lcd->ld)) {
+		dev_err(lcd->dev, "failed to register lcd ops.\n");
+		ret = PTR_ERR(lcd->ld);
+
+		goto err1;
+	}
+
+	lcd->bd = backlight_device_register("dsim_lcd-bl", lcd->dev, lcd,
+			&dsim_lcd_backlight_ops, NULL);
+	if (IS_ERR(lcd->bd)) {
+		dev_err(lcd->dev, "failed to register backlight ops.\n");
+		ret = PTR_ERR(lcd->bd);
+
+		goto err1;
+	}
+
+	lcd->bd->props.max_brightness = MAX_BRIGHTNESS;
+	lcd->bd->props.brightness = MAX_BRIGHTNESS;
+
+	/* lcd power on */
+	if (lcd->ddi_pd->power_on)
+		lcd->ddi_pd->power_on(lcd->ld, 1);
+	else
+		dev_warn(lcd->dev, "lcd_power_on func is null.\n");
+
+	mdelay(lcd->ddi_pd->reset_delay);
+
+	/* lcd reset */
+	if (lcd->ddi_pd->reset)
+		lcd->ddi_pd->reset(lcd->ld);
+	else
+		dev_warn(lcd->dev, "lcd_reset func is null.\n");
+
+	dsim_lcd_panel_init(lcd);
+
+	dev_dbg(lcd->dev, "dsim_lcd panel driver has been probed.\n");
+
+	return 0;
+
+err1:
+	kfree(lcd);
+
+	return ret;
+}
+
+static int __devexit dsim_lcd_remove(struct mipi_dsim_lcd_device *dsim_dev)
+{
+	struct dsim_lcd *lcd = dev_get_drvdata(&dsim_dev->dev);
+
+	kfree(lcd);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int dsim_lcd_suspend(struct mipi_dsim_lcd_device *dsim_dev)
+{
+	struct dsim_lcd *lcd = dev_get_drvdata(&dsim_dev->dev);
+
+	return 0;
+}
+
+static int dsim_lcd_resume(struct mipi_dsim_lcd_device *dsim_dev)
+{
+	struct dsim_lcd *lcd = dev_get_drvdata(&dsim_dev->dev);
+
+	return 0;
+}
+#else
+#define dsim_lcd_suspend	NULL
+#define dsim_lcd_resume		NULL
+#endif
+
+static struct mipi_dsim_lcd_driver dsim_lcd_dsim_ddi_driver = {
+	.name		= "dsim_lcd",
+	.id		= -1,
+
+	.probe		= dsim_lcd_probe,
+	.remove		= __devexit_p(dsim_lcd_remove),
+	.suspend	= dsim_lcd_suspend,
+	.resume		= dsim_lcd_resume,
+};
+
+static int dsim_lcd_init(void)
+{
+	s5p_mipi_dsi_register_lcd_driver(&dsim_lcd_dsim_ddi_driver);
+
+	return 0;
+}
+
+static void dsim_lcd_exit(void)
+{
+}
+
+module_init(dsim_lcd_init);
+module_exit(dsim_lcd_exit);
+
+MODULE_AUTHOR("Inki Dae <inki.dae@samsung.com>");
+MODULE_DESCRIPTION("Samsung SoC MIPI-DSI based sample lcd panel driver");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4

