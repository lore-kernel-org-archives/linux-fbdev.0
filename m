From: Richard Purdie <rpurdie@rpsys.net>
Subject: [patch 3/3] Corgi backlight: Generalise to support other Sharp SL
 hardware
Date: Sun, 26 Mar 2006 23:59:02 +0100
Message-ID: <1143413942.18513.41.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNeCU-00020T-Af
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Mar 2006 14:59:10 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FNeCQ-0004k5-OH
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Mar 2006 14:59:10 -0800
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Generalise the Corgi backlight driver by moving the default intensity
and limit mask settings into the platform specific data structure. This
enables the driver to support other Zaurus hardware, specifically the
SL-6000x (Tosa) model.

Also change the spinlock to a mutex (the spinlock is overkill).

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.16/arch/arm/mach-pxa/corgi.c
===================================================================
--- linux-2.6.16.orig/arch/arm/mach-pxa/corgi.c	2006-03-26 17:04:28.000000000 +0100
+++ linux-2.6.16/arch/arm/mach-pxa/corgi.c	2006-03-26 23:09:00.000000000 +0100
@@ -142,6 +142,8 @@
  */
 static struct corgibl_machinfo corgi_bl_machinfo = {
 	.max_intensity = 0x2f,
+	.default_intensity = 0x1f,
+	.limit_mask = 0x0b,
 	.set_bl_intensity = corgi_bl_set_intensity,
 };
 
Index: linux-2.6.16/arch/arm/mach-pxa/spitz.c
===================================================================
--- linux-2.6.16.orig/arch/arm/mach-pxa/spitz.c	2006-03-26 17:04:28.000000000 +0100
+++ linux-2.6.16/arch/arm/mach-pxa/spitz.c	2006-03-26 23:09:00.000000000 +0100
@@ -221,6 +221,8 @@
  * Spitz Backlight Device
  */
 static struct corgibl_machinfo spitz_bl_machinfo = {
+	.default_intensity = 0x1f,
+	.limit_mask = 0x0b,
 	.max_intensity = 0x2f,
 };
 
Index: linux-2.6.16/drivers/video/backlight/Kconfig
===================================================================
--- linux-2.6.16.orig/drivers/video/backlight/Kconfig	2006-03-26 17:04:28.000000000 +0100
+++ linux-2.6.16/drivers/video/backlight/Kconfig	2006-03-26 19:01:13.000000000 +0100
@@ -43,11 +43,11 @@
 	default y
 
 config BACKLIGHT_CORGI
-	tristate "Sharp Corgi Backlight Driver (SL-C7xx Series)"
+	tristate "Sharp Corgi Backlight Driver (SL Series)"
 	depends on BACKLIGHT_DEVICE && PXA_SHARPSL
 	default y
 	help
-	  If you have a Sharp Zaurus SL-C7xx, say y to enable the
+	  If you have a Sharp Zaurus SL-C7xx, SL-Cxx00 or SL-6000x say y to enable the
 	  backlight driver.
 
 config BACKLIGHT_HP680
Index: linux-2.6.16/include/asm-arm/arch-pxa/sharpsl.h
===================================================================
--- linux-2.6.16.orig/include/asm-arm/arch-pxa/sharpsl.h	2006-03-26 17:04:28.000000000 +0100
+++ linux-2.6.16/include/asm-arm/arch-pxa/sharpsl.h	2006-03-26 18:38:54.000000000 +0100
@@ -27,6 +27,8 @@
  */
 struct corgibl_machinfo {
 	int max_intensity;
+	int default_intensity;
+	int limit_mask;
 	void (*set_bl_intensity)(int intensity);
 };
 extern void corgibl_limit_intensity(int limit);
Index: linux-2.6.16/drivers/video/backlight/corgi_bl.c
===================================================================
--- linux-2.6.16.orig/drivers/video/backlight/corgi_bl.c	2006-03-26 18:07:27.000000000 +0100
+++ linux-2.6.16/drivers/video/backlight/corgi_bl.c	2006-03-26 18:44:52.000000000 +0100
@@ -1,7 +1,7 @@
 /*
- *  Backlight Driver for Sharp Corgi
+ *  Backlight Driver for Sharp Zaurus Handhelds (various models)
  *
- *  Copyright (c) 2004-2005 Richard Purdie
+ *  Copyright (c) 2004-2006 Richard Purdie
  *
  *  Based on Sharp's 2.4 Backlight Driver
  *
@@ -15,21 +15,17 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/fb.h>
 #include <linux/backlight.h>
-
 #include <asm/arch/sharpsl.h>
 #include <asm/hardware/sharpsl_pm.h>
 
-#define CORGI_DEFAULT_INTENSITY		0x1f
-#define CORGI_LIMIT_MASK		0x0b
-
 static int corgibl_intensity;
-static void (*corgibl_mach_set_intensity)(int intensity);
-static spinlock_t bl_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_MUTEX(bl_mutex);
 static struct backlight_properties corgibl_data;
 static struct backlight_device *corgi_backlight_device;
+static struct corgibl_machinfo *bl_machinfo;
 
 static unsigned long corgibl_flags;
 #define CORGIBL_SUSPENDED     0x01
@@ -37,7 +33,6 @@
 
 static int corgibl_send_intensity(struct backlight_device *bd)
 {
-	unsigned long flags;
 	void (*corgi_kick_batt)(void);
 	int intensity = bd->props->brightness;
 
@@ -48,13 +43,11 @@
 	if (corgibl_flags & CORGIBL_SUSPENDED)
 		intensity = 0;
 	if (corgibl_flags & CORGIBL_BATTLOW)
-		intensity &= CORGI_LIMIT_MASK;
-
-	spin_lock_irqsave(&bl_lock, flags);
-
-	corgibl_mach_set_intensity(intensity);
+		intensity &= bl_machinfo->limit_mask;
 
-	spin_unlock_irqrestore(&bl_lock, flags);
+ 	mutex_lock(&bl_mutex);
+	bl_machinfo->set_bl_intensity(intensity);
+	mutex_unlock(&bl_mutex);
 
 	corgibl_intensity = intensity;
 
@@ -122,8 +115,10 @@
 {
 	struct corgibl_machinfo *machinfo = pdev->dev.platform_data;
 
+	bl_machinfo = machinfo;
 	corgibl_data.max_brightness = machinfo->max_intensity;
-	corgibl_mach_set_intensity = machinfo->set_bl_intensity;
+	if (!machinfo->limit_mask)
+		machinfo->limit_mask = -1;
 
 	corgi_backlight_device = backlight_device_register ("corgi-bl",
 		NULL, &corgibl_data);
@@ -131,7 +126,7 @@
 		return PTR_ERR (corgi_backlight_device);
 
 	corgibl_data.power = FB_BLANK_UNBLANK;
-	corgibl_data.brightness = CORGI_DEFAULT_INTENSITY;
+	corgibl_data.brightness = machinfo->default_intensity;
 	corgibl_send_intensity(corgi_backlight_device);
 
 	printk("Corgi Backlight Driver Initialized.\n");




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
