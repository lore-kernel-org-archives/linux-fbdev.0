From: Ben Dooks <ben-linux@fluff.org>
Subject: [patch 5/5] LCD: Add platform_lcd driver.
Date: Sun, 22 Jun 2008 22:04:44 +0100
Message-ID: <20080622210615.036067525@fluff.org.uk>
References: <20080622210439.018928412@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KAWlc-0002y0-0i for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 14:06:32 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KAWlb-00018B-0p
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 14:06:31 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-backlight-generic.patch
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Ben Dooks <ben-linux@fluff.org>

Add a platform_lcd driver to allow boards with simple
lcd power controls to register themselves easily.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc5-quilt2/include/video/platform_lcd.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.26-rc5-quilt2/include/video/platform_lcd.h	2008-06-12 11:32:17.000000000 +0100
@@ -0,0 +1,21 @@
+/* include/video/platform_lcd.h
+ *
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Generic platform-device LCD power control interface.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+struct plat_lcd_data;
+struct fb_info;
+
+struct plat_lcd_data {
+	void	(*set_power)(struct plat_lcd_data *, unsigned int power);
+	int	(*match_fb)(struct plat_lcd_data *, struct fb_info *);
+};
+
Index: linux-2.6.26-rc5-quilt2/drivers/video/backlight/Kconfig
===================================================================
--- linux-2.6.26-rc5-quilt2.orig/drivers/video/backlight/Kconfig	2008-06-12 10:49:49.000000000 +0100
+++ linux-2.6.26-rc5-quilt2/drivers/video/backlight/Kconfig	2008-06-12 11:25:22.000000000 +0100
@@ -53,6 +53,13 @@ config LCD_VGG2432A4
 	  If you have a VGG2432A4 panel based on the ILI9320 controller chip
 	  then say y to include a power driver for it.
 
+config LCD_PLATFORM
+	tristate "Platform LCD controls"
+	depends on LCD_CLASS_DEVICE
+	help
+	  This driver provides a platform-device registered LCD power
+	  control interface.
+
 #
 # Backlight
 #
Index: linux-2.6.26-rc5-quilt2/drivers/video/backlight/Makefile
===================================================================
--- linux-2.6.26-rc5-quilt2.orig/drivers/video/backlight/Makefile	2008-06-12 10:49:49.000000000 +0100
+++ linux-2.6.26-rc5-quilt2/drivers/video/backlight/Makefile	2008-06-12 11:25:22.000000000 +0100
@@ -3,6 +3,7 @@
 obj-$(CONFIG_LCD_CLASS_DEVICE)     += lcd.o
 obj-$(CONFIG_LCD_LTV350QV)	   += ltv350qv.o
 obj-$(CONFIG_LCD_ILI9320)	   += ili9320.o
+obj-$(CONFIG_LCD_PLATFORM)	   += platform_lcd.o
 obj-$(CONFIG_LCD_VGG2432A4)	   += vgg2432a4.o
 
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
Index: linux-2.6.26-rc5-quilt2/drivers/video/backlight/platform_lcd.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.26-rc5-quilt2/drivers/video/backlight/platform_lcd.c	2008-06-12 14:19:55.000000000 +0100
@@ -0,0 +1,172 @@
+/* drivers/video/backlight/platform_lcd.c
+ *
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Generic platform-device LCD power control interface.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+#include <linux/lcd.h>
+
+#include <video/platform_lcd.h>
+
+struct platform_lcd {
+	struct device		*us;
+	struct lcd_device	*lcd;
+	struct plat_lcd_data	*pdata;
+
+	unsigned int		 power;
+	unsigned int		 suspended : 1;
+};
+
+static inline struct platform_lcd *to_our_lcd(struct lcd_device *lcd)
+{
+	return lcd_get_data(lcd);
+}
+
+static int platform_lcd_get_power(struct lcd_device *lcd)
+{
+	struct platform_lcd *plcd = to_our_lcd(lcd);
+
+	return plcd->power;
+}
+
+static int platform_lcd_set_power(struct lcd_device *lcd, int power)
+{
+	struct platform_lcd *plcd = to_our_lcd(lcd);
+	int lcd_power = 1;
+
+	if (power == FB_BLANK_POWERDOWN || plcd->suspended)
+		lcd_power = 0;
+
+	plcd->pdata->set_power(plcd->pdata, lcd_power);
+	plcd->power = power;
+
+	return 0;
+}
+
+static int platform_lcd_match(struct lcd_device *lcd, struct fb_info *info)
+{
+	struct platform_lcd *plcd = to_our_lcd(lcd);
+	struct plat_lcd_data *pdata = plcd->pdata;
+
+	if (pdata->match_fb)
+		return pdata->match_fb(pdata, info);
+
+	return plcd->us->parent == info->dev;
+}
+
+static struct lcd_ops platform_lcd_ops = {
+	.get_power	= platform_lcd_get_power,
+	.set_power	= platform_lcd_set_power,
+	.check_fb	= platform_lcd_match,
+};
+
+static int __devinit platform_lcd_probe(struct platform_device *pdev)
+{
+	struct plat_lcd_data *pdata;
+	struct platform_lcd *plcd;
+	struct device *dev = &pdev->dev;
+	int err;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(dev, "no platform data supplied\n");
+		return -EINVAL;
+	}
+
+	plcd = kzalloc(sizeof(struct platform_lcd), GFP_KERNEL);
+	if (!plcd) {
+		dev_err(dev, "no memory for state\n");
+		return -ENOMEM;
+	}
+
+	plcd->us = dev;
+	plcd->pdata = pdata;
+	plcd->lcd = lcd_device_register("platform-lcd", dev,
+					plcd, &platform_lcd_ops);
+	if (IS_ERR(plcd->lcd)) {
+		dev_err(dev, "cannot register lcd device\n");
+		err = PTR_ERR(plcd->lcd);
+		goto err_mem;
+	}
+
+	platform_set_drvdata(pdev, plcd);
+	return 0;
+
+ err_mem:
+	kfree(plcd);
+	return err;
+}
+
+static int __devexit platform_lcd_remove(struct platform_device *pdev)
+{
+	struct platform_lcd *plcd = platform_get_drvdata(pdev);
+
+	lcd_device_unregister(plcd->lcd);
+	kfree(plcd);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int platform_lcd_suspend(struct platform_device *pdev, pm_message_t st)
+{
+	struct platform_lcd *plcd = platform_get_drvdata(pdev);
+
+	plcd->suspended = 1;
+	platform_lcd_set_power(plcd->lcd, plcd->power);
+
+	return 0;
+}
+
+static int platform_lcd_resume(struct platform_device *pdev)
+{
+	struct platform_lcd *plcd = platform_get_drvdata(pdev);
+
+	plcd->suspended = 0;
+	platform_lcd_set_power(plcd->lcd, plcd->power);
+
+	return 0;
+}
+#else
+#define s3c2410bl_suspend NULL
+#define s3c2410bl_resume  NULL
+#endif
+
+static struct platform_driver platform_lcd_driver = {
+	.driver		= {
+		.name	= "platform-lcd",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= platform_lcd_probe,
+	.remove		= __devexit_p(platform_lcd_remove),
+	.suspend        = platform_lcd_suspend,
+	.resume         = platform_lcd_resume,
+};
+
+static int __init platform_lcd_init(void)
+{
+	return platform_driver_register(&platform_lcd_driver);
+}
+
+static void __exit platform_lcd_cleanup(void)
+{
+	platform_driver_unregister(&platform_lcd_driver);
+}
+
+module_init(platform_lcd_init);
+module_exit(platform_lcd_cleanup);
+
+MODULE_AUTHOR("Ben Dooks <ben-linux@fluff.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:platform-lcd");

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
