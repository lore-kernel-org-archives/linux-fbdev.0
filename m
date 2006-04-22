From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] backlight: LOCOMO Backlight Driver updates
Date: Sat, 22 Apr 2006 11:19:18 +0800
Message-ID: <4449A0B6.9070005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FX8hc-0006jO-31
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 20:22:32 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FX8hc-0005UL-2F
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 20:22:32 -0700
Received: from pproxy.gmail.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FX8ha-0006Y2-6r
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 20:22:32 -0700
Received: by pproxy.gmail.com with SMTP id i49so649955pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Apr 2006 20:22:18 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@suse.cz>, lenz@cs.wisc.edu

From: Richard Purdie <rpurdie@rpsys.net>

Add backlight intensity control to the LOCOMO lcd/backlight driver using
the backlight class and add basic power management support.

This is a reimplementation and improvement of patches by John Lenz and
Pavel Machek

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/arm/common/locomo.c            |   45 +++++++------
 drivers/video/backlight/Kconfig     |    8 ++
 drivers/video/backlight/Makefile    |    2 -
 drivers/video/backlight/locomolcd.c |  123 ++++++++++++++++++++++++++++++-----
 include/asm-arm/hardware/locomo.h   |    5 +
 5 files changed, 146 insertions(+), 37 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index a7dc137..0dafba3 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -629,21 +629,6 @@ static int locomo_resume(struct platform
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
@@ -698,14 +683,10 @@ __locomo_probe(struct device *me, struct
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
@@ -1063,6 +1044,30 @@ void locomo_m62332_senddata(struct locom
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
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index b895eaa..02f1529 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -50,6 +50,14 @@ config BACKLIGHT_CORGI
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
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 744210c..65e5553 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_LCD_CLASS_DEVICE)     += lc
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
 obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o
 obj-$(CONFIG_BACKLIGHT_HP680)	+= hp680_bl.o
-obj-$(CONFIG_SHARP_LOCOMO)	+= locomolcd.o
+obj-$(CONFIG_BACKLIGHT_LOCOMO)	+= locomolcd.o
diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
index 60831bb..bd879b7 100644
--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
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
@@ -89,12 +94,10 @@ void locomolcd_power(int on)
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
@@ -105,26 +108,100 @@ void locomolcd_power(int on)
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
@@ -136,19 +213,33 @@ static struct locomo_driver poodle_lcd_d
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
diff --git a/include/asm-arm/hardware/locomo.h b/include/asm-arm/hardware/locomo.h
index 5f10048..22dfb17 100644
--- a/include/asm-arm/hardware/locomo.h
+++ b/include/asm-arm/hardware/locomo.h
@@ -111,6 +111,8 @@
 #define LOCOMO_ALS		0x00	/* Adjust light cycle */
 #define LOCOMO_ALD		0x04	/* Adjust light duty */
 
+#define LOCOMO_ALC_EN		0x8000
+
 /* Backlight controller: TFT signal */
 #define LOCOMO_BACKLIGHT	0x38
 #define LOCOMO_TC		0x00		/* TFT control signal */
@@ -203,4 +205,7 @@ void locomo_gpio_write(struct locomo_dev
 /* M62332 control function */
 void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int channel);
 
+/* Frontlight control */
+void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf);
+
 #endif



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
