From: Richard Purdie <rpurdie@rpsys.net>
Subject: [patch] Add backlight driver for Sharp Corgi PDAs
Date: Thu, 20 Jan 2005 17:46:04 +0000
Message-ID: <200501201746.04933.rpurdie@rpsys.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrgNy-0004BD-Ky
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 09:46:22 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CrgNw-00012n-L3
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 09:46:22 -0800
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: "adaplas@hotpop.com" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Add a backlight driver for the Sharp Corgi PDAs (SL-C7xx series)
using the backlight class.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.11-rc1/drivers/video/backlight/corgi_bl.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-rc1/drivers/video/backlight/corgi_bl.c	2005-01-20 17:28:16.595287808 +0000
@@ -0,0 +1,198 @@
+/*
+ *  Backlight Driver for Sharp Corgi
+ *
+ *  Copyright (c) 2004-2005 Richard Purdie
+ *
+ *  Based on Sharp's 2.4 Backlight Driver
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/spinlock.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+
+#include <asm/arch-pxa/corgi.h>
+#include <asm/hardware/scoop.h>
+
+#define CORGI_MAX_INTENSITY 		0x3e
+#define CORGI_DEFAULT_INTENSITY		0x1f
+#define CORGI_LIMIT_MASK			0x0b
+
+static int corgibl_powermode = FB_BLANK_UNBLANK;
+static int current_intensity = 0;
+static int corgibl_limit = 0;
+static spinlock_t bl_lock = SPIN_LOCK_UNLOCKED;
+
+static void corgibl_send_intensity(int intensity)
+{
+	unsigned long flags;
+	void (*corgi_kick_batt)(void);
+	
+	if (corgibl_powermode != FB_BLANK_UNBLANK) {
+		intensity = 0;
+	} else {
+		if (corgibl_limit) 
+			intensity &= CORGI_LIMIT_MASK;
+	}
+	
+	/* Skip 0x20 as it will blank the display */
+	if (intensity >= 0x20) 
+		intensity++;
+
+	spin_lock_irqsave(&bl_lock, flags);
+	/* Bits 0-4 are accessed via the SSP interface */
+	corgi_ssp_blduty_set(intensity & 0x1f);
+	/* Bit 5 is via SCOOP */
+	if (intensity & 0x0020) 
+		set_scoop_gpio(CORGI_SCP_BACKLIGHT_CONT);
+	else 
+		reset_scoop_gpio(CORGI_SCP_BACKLIGHT_CONT);
+	spin_unlock_irqrestore(&bl_lock, flags);
+}
+
+static void corgibl_blank(int blank)
+{
+	switch(blank) {
+		
+	case FB_BLANK_NORMAL: 
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_POWERDOWN: 
+		if (corgibl_powermode == FB_BLANK_UNBLANK) {
+			corgibl_send_intensity(0);
+			corgibl_powermode = blank;
+		} 	
+		break;
+	case FB_BLANK_UNBLANK: 
+		if (corgibl_powermode != FB_BLANK_UNBLANK) {
+			corgibl_powermode = blank;
+			corgibl_send_intensity(current_intensity);
+		}
+		break;
+	}
+}
+
+#ifdef CONFIG_PM
+static int corgibl_suspend(struct device *dev, u32 state, u32 level)
+{
+	if (level == SUSPEND_POWER_DOWN) 
+		corgibl_blank(FB_BLANK_POWERDOWN);
+	return 0;
+}
+
+static int corgibl_resume(struct device *dev, u32 level)
+{
+	if (level == RESUME_POWER_ON)
+		corgibl_blank(FB_BLANK_UNBLANK);
+	return 0;
+}
+#else
+#define corgibl_suspend	NULL
+#define corgibl_resume	NULL
+#endif
+
+
+static int corgibl_set_power(struct backlight_device *bd, int state)
+{
+	corgibl_blank(state);
+	return 0;
+}
+
+static int corgibl_get_power(struct backlight_device *bd)
+{
+	return corgibl_powermode;
+}
+
+static int corgibl_set_intensity(struct backlight_device *bd, int intensity)
+{
+	if (intensity > CORGI_MAX_INTENSITY) 
+		intensity = CORGI_MAX_INTENSITY;
+	corgibl_send_intensity(intensity);
+	current_intensity=intensity;
+	return 0;
+}
+
+static int corgibl_get_intensity(struct backlight_device *bd)
+{
+	return current_intensity;
+}
+
+/*
+ * Called when the battery is low to limit the backlight intensity. 
+ * If limit==0 clear any limit, otherwise limit the intensity
+ */
+void corgibl_limit_intensity(int limit)
+{
+	corgibl_limit = (limit ? 1 : 0);
+	corgibl_send_intensity(current_intensity);
+}
+EXPORT_SYMBOL(corgibl_limit_intensity);
+
+
+static struct backlight_properties corgibl_data = {
+	.owner		= THIS_MODULE,
+	.get_power      = corgibl_get_power,
+	.set_power      = corgibl_set_power,
+	.max_brightness = CORGI_MAX_INTENSITY,
+	.get_brightness = corgibl_get_intensity,
+	.set_brightness = corgibl_set_intensity,
+};
+
+static struct backlight_device *corgi_backlight_device;
+
+static int __init corgibl_probe(struct device *dev)
+{
+	corgi_backlight_device = backlight_device_register ("corgi-bl",
+		NULL, &corgibl_data);
+	if (IS_ERR (corgi_backlight_device))
+		return PTR_ERR (corgi_backlight_device);
+
+	corgibl_set_intensity(NULL, CORGI_DEFAULT_INTENSITY);
+	
+	printk("Corgi Backlight Driver Initialized.\n");
+	return 0;
+}
+
+static int corgibl_remove(struct device *dev)
+{
+	backlight_device_unregister(corgi_backlight_device);
+	
+	corgibl_set_intensity(NULL, 0);
+	
+	printk("Corgi Backlight Driver Unloaded\n");
+	return 0;
+}
+
+static struct device_driver corgibl_driver = {
+	.name		= "corgi-bl",
+	.bus		= &platform_bus_type,
+	.probe		= corgibl_probe,
+	.remove		= corgibl_remove,
+	.suspend	= corgibl_suspend,
+	.resume		= corgibl_resume,
+};
+
+static int __init corgibl_init(void)
+{
+	return driver_register(&corgibl_driver);
+}
+
+static void __exit corgibl_exit(void)
+{
+ 	driver_unregister(&corgibl_driver);
+}
+
+module_init(corgibl_init);
+module_exit(corgibl_exit);
+
+MODULE_AUTHOR("Richard Purdie <rpurdie@rpsys.net>");
+MODULE_DESCRIPTION("Corgi Backlight Driver");
+MODULE_LICENSE("GPLv2");
Index: linux-2.6.11-rc1/drivers/video/backlight/Kconfig
===================================================================
--- linux-2.6.11-rc1.orig/drivers/video/backlight/Kconfig	2005-01-20 17:10:48.000000000 +0000
+++ linux-2.6.11-rc1/drivers/video/backlight/Kconfig	2005-01-20 17:29:31.083963808 +0000
@@ -39,3 +39,12 @@
 	bool
 	depends on LCD_CLASS_DEVICE
 	default y
+
+config BACKLIGHT_CORGI
+	tristate "Sharp Corgi Backlight Driver (SL-C7xx Series)
+	depends on BACKLIGHT_DEVICE && PXA_SHARPSL
+	default y
+	help
+	  If you have a Sharp Zaurus SL-C7xx, say y to enable the 
+	  backlight driver.
+
Index: linux-2.6.11-rc1/drivers/video/backlight/Makefile
===================================================================
--- linux-2.6.11-rc1.orig/drivers/video/backlight/Makefile	2005-01-20 17:10:48.000000000 +0000
+++ linux-2.6.11-rc1/drivers/video/backlight/Makefile	2005-01-20 17:10:57.000000000 +0000
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_LCD_CLASS_DEVICE)     += lcd.o
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
+obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
