From: Richard Purdie <rpurdie@rpsys.net>
Subject: [patch 1/3] Backlight Class Improvements
Date: Sun, 26 Mar 2006 23:58:28 +0100
Message-ID: <1143413908.18513.38.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNeC0-0001vO-TN
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Mar 2006 14:58:40 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FNeBz-0004d3-8A
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Mar 2006 14:58:41 -0800
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
Cc: Andrew Zabolotny <zap@homelink.ru>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Backlight class attributes are currently easy to implement incorrectly.
Moving certain handling into the backlight core prevents this whilst at
the same time makes the drivers simpler and consistent. The following
changes are included:

The brightness attribute only sets and reads the brightness variable in
the backlight_properties structure.

The power attribute only sets and reads the power variable in the
backlight_properties structure.

Any framebuffer blanking events change a variable fb_blank in the
backlight_properties structure.

The backlight driver has only two functions to implement. One function
is called when any of the above properties change (to update the
backlight brightness), the second is called to return the current
backlight brightness value. A new attribute "actual_brightness" is added
to return this brightness as determined by the driver having combined
all the above factors (and any driver/device specific factors).

Additionally, the backlight core takes care of checking the maximum
brightness is not exceeded and of turning off the backlight before
device removal.

The corgi backlight driver is updated to reflect these changes.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.16/drivers/video/backlight/backlight.c
===================================================================
--- linux-2.6.16.orig/drivers/video/backlight/backlight.c	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16/drivers/video/backlight/backlight.c	2006-03-26 17:46:00.000000000 +0100
@@ -16,14 +16,12 @@
 
 static ssize_t backlight_show_power(struct class_device *cdev, char *buf)
 {
-	int rc;
+	int rc = -ENXIO;
 	struct backlight_device *bd = to_backlight_device(cdev);
 
 	down(&bd->sem);
-	if (likely(bd->props && bd->props->get_power))
-		rc = sprintf(buf, "%d\n", bd->props->get_power(bd));
-	else
-		rc = -ENXIO;
+	if (likely(bd->props))
+		rc = sprintf(buf, "%d\n", bd->props->power);
 	up(&bd->sem);
 
 	return rc;
@@ -31,7 +29,7 @@
 
 static ssize_t backlight_store_power(struct class_device *cdev, const char *buf, size_t count)
 {
-	int rc, power;
+	int rc = -ENXIO, power;
 	char *endp;
 	struct backlight_device *bd = to_backlight_device(cdev);
 
@@ -40,12 +38,13 @@
 		return -EINVAL;
 
 	down(&bd->sem);
-	if (likely(bd->props && bd->props->set_power)) {
+	if (likely(bd->props)) {
 		pr_debug("backlight: set power to %d\n", power);
-		bd->props->set_power(bd, power);
+		bd->props->power = power;
+		if (likely(bd->props->update_status))
+			bd->props->update_status(bd);
 		rc = count;
-	} else
-		rc = -ENXIO;
+	}
 	up(&bd->sem);
 
 	return rc;
@@ -53,14 +52,12 @@
 
 static ssize_t backlight_show_brightness(struct class_device *cdev, char *buf)
 {
-	int rc;
+	int rc = -ENXIO;
 	struct backlight_device *bd = to_backlight_device(cdev);
 
 	down(&bd->sem);
-	if (likely(bd->props && bd->props->get_brightness))
-		rc = sprintf(buf, "%d\n", bd->props->get_brightness(bd));
-	else
-		rc = -ENXIO;
+	if (likely(bd->props))
+		rc = sprintf(buf, "%d\n", bd->props->brightness);
 	up(&bd->sem);
 
 	return rc;
@@ -68,7 +65,7 @@
 
 static ssize_t backlight_store_brightness(struct class_device *cdev, const char *buf, size_t count)
 {
-	int rc, brightness;
+	int rc = -ENXIO, brightness;
 	char *endp;
 	struct backlight_device *bd = to_backlight_device(cdev);
 
@@ -77,12 +74,17 @@
 		return -EINVAL;
 
 	down(&bd->sem);
-	if (likely(bd->props && bd->props->set_brightness)) {
-		pr_debug("backlight: set brightness to %d\n", brightness);
-		bd->props->set_brightness(bd, brightness);
-		rc = count;
-	} else
-		rc = -ENXIO;
+	if (likely(bd->props)) {
+		if (brightness > bd->props->max_brightness)
+			rc = -EINVAL;
+		else {
+			pr_debug("backlight: set brightness to %d\n", brightness);
+			bd->props->brightness = brightness;
+			if (likely(bd->props->update_status))
+				bd->props->update_status(bd);
+			rc = count;
+		}
+	}
 	up(&bd->sem);
 
 	return rc;
@@ -90,14 +92,25 @@
 
 static ssize_t backlight_show_max_brightness(struct class_device *cdev, char *buf)
 {
-	int rc;
+	int rc = -ENXIO;
 	struct backlight_device *bd = to_backlight_device(cdev);
 
 	down(&bd->sem);
 	if (likely(bd->props))
 		rc = sprintf(buf, "%d\n", bd->props->max_brightness);
-	else
-		rc = -ENXIO;
+	up(&bd->sem);
+
+	return rc;
+}
+
+static ssize_t backlight_show_actual_brightness(struct class_device *cdev, char *buf)
+{
+	int rc = -ENXIO;
+	struct backlight_device *bd = to_backlight_device(cdev);
+
+	down(&bd->sem);
+	if (likely(bd->props && bd->props->get_brightness))
+		rc = sprintf(buf, "%d\n", bd->props->get_brightness(bd));
 	up(&bd->sem);
 
 	return rc;
@@ -124,6 +137,7 @@
 static struct class_device_attribute bl_class_device_attributes[] = {
 	DECLARE_ATTR(power, 0644, backlight_show_power, backlight_store_power),
 	DECLARE_ATTR(brightness, 0644, backlight_show_brightness, backlight_store_brightness),
+	DECLARE_ATTR(actual_brightness, 0444, backlight_show_actual_brightness, NULL),
 	DECLARE_ATTR(max_brightness, 0444, backlight_show_max_brightness, NULL),
 };
 
@@ -144,8 +158,11 @@
 	bd = container_of(self, struct backlight_device, fb_notif);
 	down(&bd->sem);
 	if (bd->props)
-		if (!bd->props->check_fb || bd->props->check_fb(evdata->info))
-			bd->props->set_power(bd, *(int *)evdata->data);
+		if (!bd->props->check_fb || bd->props->check_fb(evdata->info)) {
+			bd->props->fb_blank = *(int *)evdata->data;
+			if (likely(bd->props && bd->props->update_status))
+				bd->props->update_status(bd);
+		}
 	up(&bd->sem);
 	return 0;
 }
@@ -231,6 +248,12 @@
 					 &bl_class_device_attributes[i]);
 
 	down(&bd->sem);
+	if (likely(bd->props && bd->props->update_status)) {
+		bd->props->brightness = 0;
+		bd->props->power = 0;
+		bd->props->update_status(bd);
+	}
+
 	bd->props = NULL;
 	up(&bd->sem);
 
Index: linux-2.6.16/drivers/video/backlight/corgi_bl.c
===================================================================
--- linux-2.6.16.orig/drivers/video/backlight/corgi_bl.c	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16/drivers/video/backlight/corgi_bl.c	2006-03-26 23:09:15.000000000 +0100
@@ -25,24 +25,30 @@
 #define CORGI_DEFAULT_INTENSITY		0x1f
 #define CORGI_LIMIT_MASK		0x0b
 
-static int corgibl_powermode = FB_BLANK_UNBLANK;
-static int current_intensity = 0;
-static int corgibl_limit = 0;
+static int corgibl_intensity;
 static void (*corgibl_mach_set_intensity)(int intensity);
 static spinlock_t bl_lock = SPIN_LOCK_UNLOCKED;
 static struct backlight_properties corgibl_data;
+static struct backlight_device *corgi_backlight_device;
+
+static unsigned long corgibl_flags;
+#define CORGIBL_SUSPENDED     0x01
+#define CORGIBL_BATTLOW       0x02
 
-static void corgibl_send_intensity(int intensity)
+static int corgibl_send_intensity(struct backlight_device *bd)
 {
 	unsigned long flags;
 	void (*corgi_kick_batt)(void);
+	int intensity = bd->props->brightness;
 
-	if (corgibl_powermode != FB_BLANK_UNBLANK) {
+	if (bd->props->power != FB_BLANK_UNBLANK)
+		intensity = 0;
+	if (bd->props->fb_blank != FB_BLANK_UNBLANK)
 		intensity = 0;
-	} else {
-		if (corgibl_limit)
-			intensity &= CORGI_LIMIT_MASK;
-	}
+	if (corgibl_flags & CORGIBL_SUSPENDED)
+		intensity = 0;
+	if (corgibl_flags & CORGIBL_BATTLOW)
+		intensity &= CORGI_LIMIT_MASK;
 
 	spin_lock_irqsave(&bl_lock, flags);
 
@@ -50,45 +56,29 @@
 
 	spin_unlock_irqrestore(&bl_lock, flags);
 
+	corgibl_intensity = intensity;
+
  	corgi_kick_batt = symbol_get(sharpsl_battery_kick);
  	if (corgi_kick_batt) {
  		corgi_kick_batt();
  		symbol_put(sharpsl_battery_kick);
  	}
-}
 
-static void corgibl_blank(int blank)
-{
-	switch(blank) {
-
-	case FB_BLANK_NORMAL:
-	case FB_BLANK_VSYNC_SUSPEND:
-	case FB_BLANK_HSYNC_SUSPEND:
-	case FB_BLANK_POWERDOWN:
-		if (corgibl_powermode == FB_BLANK_UNBLANK) {
-			corgibl_send_intensity(0);
-			corgibl_powermode = blank;
-		}
-		break;
-	case FB_BLANK_UNBLANK:
-		if (corgibl_powermode != FB_BLANK_UNBLANK) {
-			corgibl_powermode = blank;
-			corgibl_send_intensity(current_intensity);
-		}
-		break;
-	}
+	return 0;
 }
 
 #ifdef CONFIG_PM
 static int corgibl_suspend(struct platform_device *dev, pm_message_t state)
 {
-	corgibl_blank(FB_BLANK_POWERDOWN);
+	corgibl_flags |= CORGIBL_SUSPENDED;
+	corgibl_send_intensity(corgi_backlight_device);
 	return 0;
 }
 
 static int corgibl_resume(struct platform_device *dev)
 {
-	corgibl_blank(FB_BLANK_UNBLANK);
+	corgibl_flags &= ~CORGIBL_SUSPENDED;
+	corgibl_send_intensity(corgi_backlight_device);
 	return 0;
 }
 #else
@@ -96,54 +86,38 @@
 #define corgibl_resume	NULL
 #endif
 
-
-static int corgibl_set_power(struct backlight_device *bd, int state)
-{
-	corgibl_blank(state);
-	return 0;
-}
-
-static int corgibl_get_power(struct backlight_device *bd)
+static int corgibl_get_intensity(struct backlight_device *bd)
 {
-	return corgibl_powermode;
+	return corgibl_intensity;
 }
 
-static int corgibl_set_intensity(struct backlight_device *bd, int intensity)
+static int corgibl_set_intensity(struct backlight_device *bd)
 {
-	if (intensity > corgibl_data.max_brightness)
-		intensity = corgibl_data.max_brightness;
-	corgibl_send_intensity(intensity);
-	current_intensity=intensity;
+	corgibl_send_intensity(corgi_backlight_device);
 	return 0;
 }
 
-static int corgibl_get_intensity(struct backlight_device *bd)
-{
-	return current_intensity;
-}
-
 /*
  * Called when the battery is low to limit the backlight intensity.
  * If limit==0 clear any limit, otherwise limit the intensity
  */
 void corgibl_limit_intensity(int limit)
 {
-	corgibl_limit = (limit ? 1 : 0);
-	corgibl_send_intensity(current_intensity);
+	if (limit)
+		corgibl_flags |= CORGIBL_BATTLOW;
+	else
+		corgibl_flags &= ~CORGIBL_BATTLOW;
+	corgibl_send_intensity(corgi_backlight_device);
 }
 EXPORT_SYMBOL(corgibl_limit_intensity);
 

 static struct backlight_properties corgibl_data = {
-	.owner		= THIS_MODULE,
-	.get_power      = corgibl_get_power,
-	.set_power      = corgibl_set_power,
+	.owner          = THIS_MODULE,
 	.get_brightness = corgibl_get_intensity,
-	.set_brightness = corgibl_set_intensity,
+	.update_status  = corgibl_set_intensity,
 };
 
-static struct backlight_device *corgi_backlight_device;
-
 static int __init corgibl_probe(struct platform_device *pdev)
 {
 	struct corgibl_machinfo *machinfo = pdev->dev.platform_data;
@@ -156,8 +130,9 @@
 	if (IS_ERR (corgi_backlight_device))
 		return PTR_ERR (corgi_backlight_device);
 
-	corgibl_set_intensity(NULL, CORGI_DEFAULT_INTENSITY);
-	corgibl_limit_intensity(0);
+	corgibl_data.power = FB_BLANK_UNBLANK;
+	corgibl_data.brightness = CORGI_DEFAULT_INTENSITY;
+	corgibl_send_intensity(corgi_backlight_device);
 
 	printk("Corgi Backlight Driver Initialized.\n");
 	return 0;
@@ -167,8 +142,6 @@
 {
 	backlight_device_unregister(corgi_backlight_device);
 
-	corgibl_set_intensity(NULL, 0);
-
 	printk("Corgi Backlight Driver Unloaded\n");
 	return 0;
 }
Index: linux-2.6.16/include/linux/backlight.h
===================================================================
--- linux-2.6.16.orig/include/linux/backlight.h	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16/include/linux/backlight.h	2006-03-26 18:38:31.000000000 +0100
@@ -19,20 +19,25 @@
 struct backlight_properties {
 	/* Owner module */
 	struct module *owner;
-	/* Get the backlight power status (0: full on, 1..3: power saving
-	   modes; 4: full off), see FB_BLANK_XXX */
-	int (*get_power)(struct backlight_device *);
-	/* Enable or disable power to the LCD (0: on; 4: off, see FB_BLANK_XXX) */
-	int (*set_power)(struct backlight_device *, int power);
-	/* Maximal value for brightness (read-only) */
-	int max_brightness;
-	/* Get current backlight brightness */
+
+	/* Notify the backlight driver some property has changed */
+	int (*update_status)(struct backlight_device *);
+	/* Return the current backlight brightness (accounting for power,
+	   fb_blank etc.) */
 	int (*get_brightness)(struct backlight_device *);
-	/* Set backlight brightness (0..max_brightness) */
-	int (*set_brightness)(struct backlight_device *, int brightness);
 	/* Check if given framebuffer device is the one bound to this backlight;
 	   return 0 if not, !=0 if it is. If NULL, backlight always matches the fb. */
 	int (*check_fb)(struct fb_info *);
+
+	/* Current User requested brightness (0 - max_brightness) */
+	int brightness;
+	/* Maximal value for brightness (read-only) */
+	int max_brightness;
+	/* Current FB Power mode (0: full on, 1..3: power saving
+	   modes; 4: full off), see FB_BLANK_XXX */
+	int power;
+	/* FB Blanking active? (values as for power) */
+	int fb_blank;
 };
 
 struct backlight_device {



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
