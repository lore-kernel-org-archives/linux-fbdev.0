From: Inki Dae <inki.dae@samsung.com>
Date: Tue, 28 Dec 2010 11:26:35 +0000
Subject: [PATCH 5/5] S5PC110: add MIPI-DSI based sample lcd panel driver.
Message-Id: <1293535595-24861-1-git-send-email-inki.dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

this patch addes MIPI-DSI based sample panel driver.
to write MIPI-DSI based lcd panel driver, you can refer to
this sample driver.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
---
 drivers/video/Kconfig           |    7 ++
 drivers/video/Makefile          |    1 +
 drivers/video/s5p_mipi_sample.c |  220 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/s5p_mipi_sample.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index aa305c5..325ce86 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2003,6 +2003,13 @@ config S5P_MIPI_DSI
 	---help---
 	  This enables support for MIPI-DSI device.
 
+config S5P_MIPI_SAMPLE
+	tristate "Samsung SoC MIPI-DSI based sample driver."
+	depends on S5P_MIPI_DSI && BACKLIGHT_LCD_SUPPORT
+	default n
+	---help---
+	  This enables support for MIPI-DSI based sample driver.
+
 config FB_NUC900
         bool "NUC900 LCD framebuffer support"
         depends on FB && ARCH_W90X900
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index f4baed6..c8ac591 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -117,6 +117,7 @@ obj-$(CONFIG_FB_S3C)		  += s3c-fb.o
 obj-$(CONFIG_FB_S3C2410)	  += s3c2410fb.o
 obj-$(CONFIG_S5P_MIPI_DSI)	  += s5p_mipi_dsi.o s5p_mipi_dsi_common.o \
     					s5p_mipi_dsi_lowlevel.o
+obj-$(CONFIG_S5P_MIPI_SAMPLE)		+= s5p_mipi_sample.o
 obj-$(CONFIG_FB_FSL_DIU)	  += fsl-diu-fb.o
 obj-$(CONFIG_FB_COBALT)           += cobalt_lcdfb.o
 obj-$(CONFIG_FB_PNX4008_DUM)	  += pnx4008/
diff --git a/drivers/video/s5p_mipi_sample.c b/drivers/video/s5p_mipi_sample.c
new file mode 100644
index 0000000..8a8abfe
--- /dev/null
+++ b/drivers/video/s5p_mipi_sample.c
@@ -0,0 +1,220 @@
+/* linux/drivers/video/sample.c
+ *
+ * MIPI-DSI based sample AMOLED lcd panel driver.
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
+#include <plat/mipi-dsi.h>
+#include <plat/mipi-ddi.h>
+
+#define MIN_BRIGHTNESS		(0)
+#define MAX_BRIGHTNESS		(10)
+
+#define lcd_to_master(a)	(a->mipi_dev->master)
+#define lcd_to_master_ops(a)	((lcd_to_master(a))->master_ops)
+#define device_to_ddi_pd(a)	(a->master->dsim_info->mipi_ddi_pd)
+
+struct sample {
+	struct device			*dev;
+
+	struct lcd_device		*ld;
+	struct backlight_device		*bd;
+
+	struct mipi_lcd_device		*mipi_dev;
+	struct mipi_ddi_platform_data	*ddi_pd;
+};
+
+static void sample_long_command(struct sample *lcd)
+{
+	struct dsim_master_ops *ops = lcd_to_master_ops(lcd);
+	unsigned char data_to_send[5] = {
+		0x00, 0x00, 0x00, 0x00, 0x00
+	};
+
+	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
+		(unsigned int) data_to_send, sizeof(data_to_send));
+}
+
+static void sample_short_command(struct sample *lcd)
+{
+	struct dsim_master_ops *ops = lcd_to_master_ops(lcd);
+
+	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_SHORT_WRITE_PARAM,
+				0x00, 0x00);
+}
+
+static int sample_panel_init(struct sample *lcd)
+{
+	sample_long_command(lcd);
+	sample_short_command(lcd);
+
+	return 0;
+}
+
+static int sample_gamma_ctrl(struct sample *lcd, int gamma)
+{
+	struct dsim_master_ops *ops = lcd_to_master_ops(lcd);
+
+	/* change transfer mode to LP mode */
+	if (ops->change_dsim_transfer_mode)
+		ops->change_dsim_transfer_mode(lcd_to_master(lcd), 0);
+
+	/* update gamma table. */
+
+	/* change transfer mode to HS mode */
+	if (ops->change_dsim_transfer_mode)
+		ops->change_dsim_transfer_mode(lcd_to_master(lcd), 1);
+
+	return 0;
+}
+
+static int sample_get_brightness(struct backlight_device *bd)
+{
+	return bd->props.brightness;
+}
+
+static int sample_set_brightness(struct backlight_device *bd)
+{
+	int ret = 0, brightness = bd->props.brightness;
+	struct sample *lcd = bl_get_data(bd);
+
+	if (brightness < MIN_BRIGHTNESS ||
+		brightness > bd->props.max_brightness) {
+		dev_err(lcd->dev, "lcd brightness should be %d to %d.\n",
+			MIN_BRIGHTNESS, MAX_BRIGHTNESS);
+		return -EINVAL;
+	}
+
+	ret = sample_gamma_ctrl(lcd, bd->props.brightness);
+	if (ret) {
+		dev_err(&bd->dev, "lcd brightness setting failed.\n");
+		return -EIO;
+	}
+
+	return ret;
+}
+
+static const struct backlight_ops sample_backlight_ops = {
+	.get_brightness = sample_get_brightness,
+	.update_status = sample_set_brightness,
+};
+
+static int sample_probe(struct mipi_lcd_device *mipi_dev)
+{
+	struct sample *lcd = NULL;
+	struct backlight_device *bd = NULL;
+
+	lcd = kzalloc(sizeof(struct sample), GFP_KERNEL);
+	if (!lcd) {
+		dev_err(&mipi_dev->dev, "failed to allocate sample structure.\n");
+		return -ENOMEM;
+	}
+
+	lcd->mipi_dev = mipi_dev;
+	lcd->ddi_pd +		(struct mipi_ddi_platform_data *)device_to_ddi_pd(mipi_dev);
+	lcd->dev = &mipi_dev->dev;
+
+	dev_set_drvdata(&mipi_dev->dev, lcd);
+
+	bd = backlight_device_register("sample-bl", lcd->dev, lcd,
+		&sample_backlight_ops, NULL);
+
+	lcd->bd = bd;
+
+	bd->props.max_brightness = MAX_BRIGHTNESS;
+	bd->props.brightness = MAX_BRIGHTNESS;
+
+	/* lcd power on */
+	if (lcd->ddi_pd->lcd_power_on)
+		lcd->ddi_pd->lcd_power_on(NULL, 1);
+
+	mdelay(lcd->ddi_pd->reset_delay);
+
+	/* lcd reset */
+	if (lcd->ddi_pd->lcd_reset)
+		lcd->ddi_pd->lcd_reset(NULL);
+
+	sample_panel_init(lcd);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sample_suspend(struct mipi_lcd_device *mipi_dev)
+{
+	struct sample *lcd = dev_get_drvdata(&mipi_dev->dev);
+
+	/* some work. */
+
+	mdelay(lcd->ddi_pd->power_off_delay);
+
+	/* lcd power off */
+	if (lcd->ddi_pd->lcd_power_on)
+		lcd->ddi_pd->lcd_power_on(NULL, 0);
+
+	return 0;
+}
+
+static int sample_resume(struct mipi_lcd_device *mipi_dev)
+{
+	struct sample *lcd = dev_get_drvdata(&mipi_dev->dev);
+
+	mdelay(lcd->ddi_pd->power_on_delay);
+
+	/* lcd power on */
+	if (lcd->ddi_pd->lcd_power_on)
+		lcd->ddi_pd->lcd_power_on(NULL, 1);
+
+	/* some work. */
+
+	return 0;
+}
+#else
+#define sample_suspend		NULL
+#define sample_resume		NULL
+#endif
+
+static struct mipi_lcd_driver sample_mipi_driver = {
+	.name = "sample",
+
+	.probe = sample_probe,
+	.suspend = sample_suspend,
+	.resume = sample_resume,
+};
+
+static int sample_init(void)
+{
+	s5p_mipi_register_lcd_driver(&sample_mipi_driver);
+
+	return 0;
+}
+
+static void sample_exit(void)
+{
+	return;
+}
+
+module_init(sample_init);
+module_exit(sample_exit);
+
+MODULE_AUTHOR("Inki Dae <inki.dae@samsung.com>");
+MODULE_DESCRIPTION("MIPI-DSI based sample AMOLED LCD Panel Driver");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4

