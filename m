From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 23 Nov 2012 16:35:11 +0000
Subject: [PATCH 1/5] backlight: Add GPIO-based backlight driver
Message-Id: <1353688515-30458-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/backlight/Kconfig          |    7 ++
 drivers/video/backlight/Makefile         |    1 +
 drivers/video/backlight/gpio_backlight.c |  158 ++++++++++++++++++++++++++++++
 include/video/gpio_backlight.h           |   21 ++++
 4 files changed, 187 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/backlight/gpio_backlight.c
 create mode 100644 include/video/gpio_backlight.h

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 765a945..259442d 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -390,6 +390,13 @@ config BACKLIGHT_TPS65217
 	  If you have a Texas Instruments TPS65217 say Y to enable the
 	  backlight driver.
 
+config BACKLIGHT_GPIO
+	tristate "Generic GPIO based Backlight Driver"
+	depends on GENERIC_GPIO
+	help
+	  If you have a LCD backlight adjustable by GPIO, say Y to enable
+	  this driver.
+
 endif # BACKLIGHT_CLASS_DEVICE
 
 endif # BACKLIGHT_LCD_SUPPORT
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index e7ce729..ec91c4a 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
 obj-$(CONFIG_BACKLIGHT_AAT2870) += aat2870_bl.o
 obj-$(CONFIG_BACKLIGHT_OT200) += ot200_bl.o
 obj-$(CONFIG_BACKLIGHT_TPS65217) += tps65217_bl.o
+obj-$(CONFIG_BACKLIGHT_GPIO)	+= gpio_backlight.o
diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
new file mode 100644
index 0000000..5a8cd34
--- /dev/null
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -0,0 +1,158 @@
+/*
+ * gpio_backlight.c - Simple GPIO-controlled backlight
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/backlight.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <video/gpio_backlight.h>
+
+struct gpio_backlight {
+	struct device *dev;
+	struct device *fbdev;
+
+	int gpio;
+	int active;
+};
+
+static int gpio_backlight_update_status(struct backlight_device *bl)
+{
+	struct gpio_backlight *gbl = bl_get_data(bl);
+	int brightness = bl->props.brightness;
+
+	if (bl->props.power != FB_BLANK_UNBLANK ||
+	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
+	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
+		brightness = 0;
+
+	gpio_set_value(gbl->gpio, brightness ? gbl->active : !gbl->active);
+
+	return 0;
+}
+
+static int gpio_backlight_get_brightness(struct backlight_device *bl)
+{
+	return bl->props.brightness;
+}
+
+static int gpio_backlight_check_fb(struct backlight_device *bl,
+				   struct fb_info *info)
+{
+	struct gpio_backlight *gbl = bl_get_data(bl);
+
+	return gbl->fbdev = info->dev;
+}
+
+static const struct backlight_ops gpio_backlight_ops = {
+	.update_status	= gpio_backlight_update_status,
+	.get_brightness	= gpio_backlight_get_brightness,
+	.check_fb	= gpio_backlight_check_fb,
+};
+
+#ifdef CONFIG_PM
+static int gpio_backlight_suspend(struct device *dev)
+{
+	struct backlight_device *bl = dev_get_drvdata(dev);
+	struct gpio_backlight *gbl = bl_get_data(bl);
+
+	gpio_set_value(gbl->gpio, !gbl->active);
+
+	return 0;
+}
+
+static int gpio_backlight_resume(struct device *dev)
+{
+	struct backlight_device *bl = dev_get_drvdata(dev);
+
+	backlight_update_status(bl);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(gpio_backlight_pm_ops, gpio_backlight_suspend,
+			 gpio_backlight_resume);
+
+#endif
+
+static int __devinit gpio_backlight_probe(struct platform_device *pdev)
+{
+	struct gpio_backlight_platform_data *pdata = pdev->dev.platform_data;
+	struct backlight_properties props;
+	struct backlight_device *bl;
+	struct gpio_backlight *gbl;
+	int ret;
+
+	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
+	if (gbl = NULL)
+		return -ENOMEM;
+
+	gbl->dev = &pdev->dev;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "failed to find platform data\n");
+		return -ENODEV;
+	}
+
+	gbl->fbdev = pdata->fbdev;
+	gbl->gpio = pdata->gpio;
+	gbl->active = pdata->active_low ? 0 : 1;
+
+	ret = devm_gpio_request_one(gbl->dev, gbl->gpio, GPIOF_DIR_OUT,
+				    pdata->name);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to request GPIO\n");
+		return ret;
+	}
+
+	memset(&props, 0, sizeof(props));
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = 1;
+	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, gbl,
+				       &gpio_backlight_ops, &props);
+	if (IS_ERR(bl)) {
+		dev_err(&pdev->dev, "failed to register backlight\n");
+		return PTR_ERR(bl);
+	}
+
+	bl->props.brightness = pdata->def_value;
+	backlight_update_status(bl);
+
+	platform_set_drvdata(pdev, bl);
+	return 0;
+}
+
+static int __devexit gpio_backlight_remove(struct platform_device *pdev)
+{
+	struct backlight_device *bl = platform_get_drvdata(pdev);
+
+	backlight_device_unregister(bl);
+	return 0;
+}
+
+static struct platform_driver gpio_backlight_driver = {
+	.driver		= {
+		.name		= "gpio-backlight",
+		.owner		= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm		= &gpio_backlight_pm_ops,
+#endif
+	},
+	.probe		= gpio_backlight_probe,
+	.remove		= __devexit_p(gpio_backlight_remove),
+};
+
+module_platform_driver(gpio_backlight_driver);
+
+MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
+MODULE_DESCRIPTION("GPIO-based Backlight Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:gpio-backlight");
diff --git a/include/video/gpio_backlight.h b/include/video/gpio_backlight.h
new file mode 100644
index 0000000..5ae0d9c
--- /dev/null
+++ b/include/video/gpio_backlight.h
@@ -0,0 +1,21 @@
+/*
+ * gpio_backlight.h - Simple GPIO-controlled backlight
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __GPIO_BACKLIGHT_H__
+#define __GPIO_BACKLIGHT_H__
+
+struct device;
+
+struct gpio_backlight_platform_data {
+	struct device *fbdev;
+	int gpio;
+	int def_value;
+	bool active_low;
+	const char *name;
+};
+
+#endif
-- 
1.7.8.6

