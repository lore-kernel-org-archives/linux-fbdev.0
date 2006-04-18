From: Richard Purdie <rpurdie@rpsys.net>
Subject: LOCOMO Backlight Driver updates
Date: Tue, 18 Apr 2006 01:37:27 +0100
Message-ID: <1145320647.6199.73.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FVeDt-0007O3-Pc
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Apr 2006 17:37:41 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FVeDs-0008Gk-Ol
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Apr 2006 17:37:41 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>
Cc: lenz@cs.wisc.edu, Pavel Machek <pavel@ucw.cz>

Add backlight intensity control to the LOCOMO lcd/backlight driver using
the backlight class and add basic power management support.

This is a reimplementation and improvement of patches by John Lenz and
Pavel Machek

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: git/arch/arm/common/locomo.c
===================================================================
--- git.orig/arch/arm/common/locomo.c	2006-04-13 09:36:03.000000000 +0100
+++ git/arch/arm/common/locomo.c	2006-04-14 12:16:21.000000000 +0100
@@ -629,21 +629,6 @@
 #endif
 
 
-#define LCM_ALC_EN	0x8000
-
-void frontlight_set(struct locomo *lchip, int duty, int vr, int bpwf)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&lchip->lock, flags);
-	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
-	udelay(100);
-	locomo_writel(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
-	locomo_writel(bpwf | LCM_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
-	spin_unlock_irqrestore(&lchip->lock, flags);
-}
-
-
 /**
  *	locomo_probe - probe for a single LoCoMo chip.
  *	@phys_addr: physical address of device.
@@ -698,14 +683,10 @@
 			, lchip->base + LOCOMO_GPD);
 	locomo_writel(0, lchip->base + LOCOMO_GIE);
 
-	/* FrontLight */
+	/* Frontlight */
 	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
 	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
 
-	/* Same constants can be used for collie and poodle
-	   (depending on CONFIG options in original sharp code)? */
-	frontlight_set(lchip, 163, 0, 148);
-
 	/* Longtime timer */
 	locomo_writel(0, lchip->base + LOCOMO_LTINT);
 	/* SPI */
@@ -1063,6 +1043,30 @@
 }
 
 /*
+ *	Frontlight control
+ */
+
+static struct locomo *locomo_chip_driver(struct locomo_dev *ldev);
+
+void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf)
+{
+	unsigned long flags;
+	struct locomo *lchip = locomo_chip_driver(dev);
+
+	if (vr)
+		locomo_gpio_write(dev, LOCOMO_GPIO_FL_VR, 1);
+	else
+		locomo_gpio_write(dev, LOCOMO_GPIO_FL_VR, 0);
+
+	spin_lock_irqsave(&lchip->lock, flags);
+	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
+	udelay(100);
+	locomo_writel(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
+	locomo_writel(bpwf | LOCOMO_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
+	spin_unlock_irqrestore(&lchip->lock, flags);
+}
+
+/*
  *	LoCoMo "Register Access Bus."
  *
  *	We model this as a regular bus type, and hang devices directly
Index: git/drivers/video/backlight/locomolcd.c
===================================================================
--- git.orig/drivers/video/backlight/locomolcd.c	2006-04-13 09:36:18.000000000 +0100
+++ git/drivers/video/backlight/locomolcd.c	2006-04-14 13:11:05.000000000 +0100
@@ -17,6 +17,8 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
 
 #include <asm/hardware/locomo.h>
 #include <asm/irq.h>
@@ -25,7 +27,10 @@
 
 #include "../../../arch/arm/mach-sa1100/generic.h"
 
+static struct backlight_device *locomolcd_bl_device;
 static struct locomo_dev *locomolcd_dev;
+static unsigned long locomolcd_flags;
+#define LOCOMOLCD_SUSPENDED     0x01
 
 static void locomolcd_on(int comadj)
 {
@@ -89,12 +94,10 @@
 	}
 
 	/* read comadj */
-	if (comadj == -1) {
-		if (machine_is_poodle())
-			comadj = 118;
-		if (machine_is_collie())
-			comadj = 128;
-	}
+	if (comadj == -1 && machine_is_collie())
+		comadj = 128;
+	if (comadj == -1 && machine_is_poodle())
+		comadj = 118;
 
 	if (on)
 		locomolcd_on(comadj);
@@ -105,26 +108,100 @@
 }
 EXPORT_SYMBOL(locomolcd_power);
 
-static int poodle_lcd_probe(struct locomo_dev *dev)
+
+static int current_intensity;
+
+static int locomolcd_set_intensity(struct backlight_device *bd)
+{
+	int intensity = bd->props->brightness;
+
+	if (bd->props->power != FB_BLANK_UNBLANK)
+		intensity = 0;
+	if (bd->props->fb_blank != FB_BLANK_UNBLANK)
+		intensity = 0;
+	if (locomolcd_flags & LOCOMOLCD_SUSPENDED)
+		intensity = 0;
+
+	switch (intensity) {
+	/* AC and non-AC are handled differently, but produce same results in sharp code? */
+	case 0: locomo_frontlight_set(locomolcd_dev, 0, 0, 161); break;
+	case 1: locomo_frontlight_set(locomolcd_dev, 117, 0, 161); break;
+	case 2: locomo_frontlight_set(locomolcd_dev, 163, 0, 148); break;
+	case 3: locomo_frontlight_set(locomolcd_dev, 194, 0, 161); break;
+	case 4: locomo_frontlight_set(locomolcd_dev, 194, 1, 161); break;
+
+	default:
+		return -ENODEV;
+	}
+	current_intensity = intensity;
+	return 0;
+}
+
+static int locomolcd_get_intensity(struct backlight_device *bd)
+{
+	return current_intensity;
+}
+
+static struct backlight_properties locomobl_data = {
+	.owner		= THIS_MODULE,
+	.get_brightness = locomolcd_get_intensity,
+	.update_status  = locomolcd_set_intensity,
+	.max_brightness = 4,
+};
+
+#ifdef CONFIG_PM
+static int locomolcd_suspend(struct locomo_dev *dev, pm_message_t state)
+{
+	locomolcd_flags |= LOCOMOLCD_SUSPENDED;
+	locomolcd_set_intensity(locomolcd_bl_device);
+	return 0;
+}
+
+static int locomolcd_resume(struct locomo_dev *dev)
+{
+	locomolcd_flags &= ~LOCOMOLCD_SUSPENDED;
+	locomolcd_set_intensity(locomolcd_bl_device);
+	return 0;
+}
+#else
+#define locomolcd_suspend	NULL
+#define locomolcd_resume	NULL
+#endif
+
+static int locomolcd_probe(struct locomo_dev *dev)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
 	locomolcd_dev = dev;
 
+	locomo_gpio_set_dir(dev, LOCOMO_GPIO_FL_VR, 0);
+
 	/* the poodle_lcd_power function is called for the first time
 	 * from fs_initcall, which is before locomo is activated.
 	 * We need to recall poodle_lcd_power here*/
-#ifdef CONFIG_MACH_POODLE
-	locomolcd_power(1);
-#endif
+	if (machine_is_poodle())
+		locomolcd_power(1);
+
 	local_irq_restore(flags);
+
+	locomolcd_bl_device = backlight_device_register("locomo-bl", NULL, &locomobl_data);
+
+	if (IS_ERR (locomolcd_bl_device))
+		return PTR_ERR (locomolcd_bl_device);
+
+	/* Set up frontlight so that screen is readable */
+	locomobl_data.brightness = 2;
+	locomolcd_set_intensity(locomolcd_bl_device);
+
 	return 0;
 }
 
-static int poodle_lcd_remove(struct locomo_dev *dev)
+static int locomolcd_remove(struct locomo_dev *dev)
 {
 	unsigned long flags;
+
+	backlight_device_unregister(locomolcd_bl_device);
 	local_irq_save(flags);
 	locomolcd_dev = NULL;
 	local_irq_restore(flags);
@@ -136,19 +213,33 @@
 		.name = "locomo-backlight",
 	},
 	.devid	= LOCOMO_DEVID_BACKLIGHT,
-	.probe	= poodle_lcd_probe,
-	.remove	= poodle_lcd_remove,
+	.probe	= locomolcd_probe,
+	.remove	= locomolcd_remove,
+	.suspend = locomolcd_suspend,
+	.resume = locomolcd_resume,
 };
 
-static int __init poodle_lcd_init(void)
+
+static int __init locomolcd_init(void)
 {
 	int ret = locomo_driver_register(&poodle_lcd_driver);
-	if (ret) return ret;
+	if (ret)
+		return ret;
 
 #ifdef CONFIG_SA1100_COLLIE
 	sa1100fb_lcd_power = locomolcd_power;
 #endif
 	return 0;
 }
-device_initcall(poodle_lcd_init);
 
+static void __exit locomolcd_exit(void)
+{
+	locomo_driver_unregister(&poodle_lcd_driver);
+}
+
+module_init(locomolcd_init);
+module_exit(locomolcd_exit);
+
+MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>");
+MODULE_DESCRIPTION("Collie LCD driver");
+MODULE_LICENSE("GPL");
Index: git/include/asm-arm/hardware/locomo.h
===================================================================
--- git.orig/include/asm-arm/hardware/locomo.h	2006-04-13 09:36:24.000000000 +0100
+++ git/include/asm-arm/hardware/locomo.h	2006-04-14 12:16:21.000000000 +0100
@@ -111,6 +111,8 @@
 #define LOCOMO_ALS		0x00	/* Adjust light cycle */
 #define LOCOMO_ALD		0x04	/* Adjust light duty */
 
+#define LOCOMO_ALC_EN		0x8000
+
 /* Backlight controller: TFT signal */
 #define LOCOMO_BACKLIGHT	0x38
 #define LOCOMO_TC		0x00		/* TFT control signal */
@@ -203,4 +205,7 @@
 /* M62332 control function */
 void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int channel);
 
+/* Frontlight control */
+void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf);
+
 #endif
Index: git/drivers/video/backlight/Kconfig
===================================================================
--- git.orig/drivers/video/backlight/Kconfig	2006-04-14 12:16:17.000000000 +0100
+++ git/drivers/video/backlight/Kconfig	2006-04-14 13:10:17.000000000 +0100
@@ -50,6 +50,14 @@
 	  If you have a Sharp Zaurus SL-C7xx, SL-Cxx00 or SL-6000x say y to enable the
 	  backlight driver.
 
+config BACKLIGHT_LOCOMO
+	tristate "Sharp LOCOMO LCD/Backlight Driver"
+	depends on BACKLIGHT_DEVICE && SHARP_LOCOMO
+	default y
+	help
+	  If you have a Sharp Zaurus SL-5500 (Collie) or SL-5600 (Poodle) say y to 
+	  enable the LCD/backlight driver.
+
 config BACKLIGHT_HP680
 	tristate "HP Jornada 680 Backlight Driver"
 	depends on BACKLIGHT_DEVICE && SH_HP6XX
Index: git/drivers/video/backlight/Makefile
===================================================================
--- git.orig/drivers/video/backlight/Makefile	2006-04-14 12:16:17.000000000 +0100
+++ git/drivers/video/backlight/Makefile	2006-04-14 13:10:26.000000000 +0100
@@ -5,4 +5,4 @@
 obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o
 obj-$(CONFIG_BACKLIGHT_HP680)	+= hp680_bl.o
 obj-$(CONFIG_BACKLIGHT_HX2750)	+= hx2750_bl.o
-obj-$(CONFIG_SHARP_LOCOMO)	+= locomolcd.o
+obj-$(CONFIG_BACKLIGHT_LOCOMO)	+= locomolcd.o




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
