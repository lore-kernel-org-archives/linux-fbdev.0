From: Andrew Zabolotny <zap@homelink.ru>
Subject: [PATCH] Backlight/LCD device basic support
Date: Sun, 9 Jan 2005 23:17:32 +0300
Message-ID: <20050109231732.2d3566a4.zap@homelink.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__9_Jan_2005_23_17_32_+0300_ov1wbEwMEeOPgItv"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnjVw-0004cI-MN
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Jan 2005 12:18:16 -0800
Received: from mail.homelink.ru ([81.9.33.123] helo=eltel.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CnjVo-000559-Cc
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Jan 2005 12:18:13 -0800
Received: from [217.170.93.196] (account zap@homelink.ru HELO zap.sh.nu)
  by eltel.net (CommuniGate Pro SMTP 4.2.6)
  with ESMTP-TLS id 23684611 for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Jan 2005 23:17:42 +0300
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--Multipart=_Sun__9_Jan_2005_23_17_32_+0300_ov1wbEwMEeOPgItv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello!

Here's a patch that adds basic support for controlling backlight
lamps and lcd panels. The drivers can be controlled via sysfs, which
makes it easy to use both from scripts and programs.

The idea is quite straightforward, but if anybody has any questions,
I'll be glad to answer. Please keep me cc:'ed as I'm not subscribed.

-- 
Greetings,
   Andrew

--Multipart=_Sun__9_Jan_2005_23_17_32_+0300_ov1wbEwMEeOPgItv
Content-Type: text/x-patch;
 name="bl-lcd.diff"
Content-Disposition: attachment;
 filename="bl-lcd.diff"
Content-Transfer-Encoding: 7bit

Signed-off-by: Andrew Zabolotny <zap@homelink.ru>
Signed-off-by: Jamey Hicks <jamey.hicks@hp.com>

--- linux-2.6.10/include/linux/lcd.h	1970-01-01 03:00:00.000000000 +0300
+++ linux/include/linux/lcd.h	2005-01-09 21:24:55.000000000 +0300
@@ -0,0 +1,56 @@
+/*
+ * LCD Lowlevel Control Abstraction
+ * 
+ * Copyright (C) 2003,2004 Hewlett-Packard Company
+ * 
+ */
+
+#ifndef _LINUX_LCD_H
+#define _LINUX_LCD_H
+
+#include <linux/device.h>
+#include <linux/notifier.h>
+
+struct lcd_device;
+struct fb_info;
+
+/* This structure defines all the properties of a LCD flat panel. */
+struct lcd_properties {
+	/* Owner module */
+	struct module *owner;
+	/* Get the LCD panel power status (0: full on, 1..3: controller
+	   power on, flat panel power off, 4: full off), see FB_BLANK_XXX */
+	int (*get_power)(struct lcd_device *);
+	/* Enable or disable power to the LCD (0: on; 4: off, see FB_BLANK_XXX) */
+	int (*set_power)(struct lcd_device *, int power);
+	/* The maximum value for contrast (read-only) */
+	int max_contrast;
+	/* Get the current contrast setting (0-max_contrast) */
+	int (*get_contrast)(struct lcd_device *);
+	/* Set LCD panel contrast */
+        int (*set_contrast)(struct lcd_device *, int contrast);
+	/* Check if given framebuffer device is the one LCD is bound to;
+	   return 0 if not, !=0 if it is. If NULL, lcd always matches the fb. */
+	int (*check_fb)(struct fb_info *);
+};
+
+struct lcd_device {
+	/* This protects the 'props' field. If 'props' is NULL, the driver that
+	   registered this device has been unloaded, and if class_get_devdata()
+	   points to something in the body of that driver, it is also invalid. */
+	struct semaphore sem;
+	/* If this is NULL, the backing module is unloaded */
+	struct lcd_properties *props;
+	/* The framebuffer notifier block */
+	struct notifier_block fb_notif;
+	/* The class device structure */
+	struct class_device class_dev;
+};
+
+extern struct lcd_device *lcd_device_register(const char *name,
+	void *devdata, struct lcd_properties *lp);
+extern void lcd_device_unregister(struct lcd_device *ld);
+
+#define to_lcd_device(obj) container_of(obj, struct lcd_device, class_dev)
+
+#endif
--- linux-2.6.10/include/linux/backlight.h	1970-01-01 03:00:00.000000000 +0300
+++ linux/include/linux/backlight.h	2005-01-09 21:25:06.000000000 +0300
@@ -0,0 +1,57 @@
+/*
+ * Backlight Lowlevel Control Abstraction
+ * 
+ * Copyright (C) 2003,2004 Hewlett-Packard Company
+ * 
+ */
+
+#ifndef _LINUX_BACKLIGHT_H
+#define _LINUX_BACKLIGHT_H
+
+#include <linux/device.h>
+#include <linux/notifier.h>
+
+struct backlight_device;
+struct fb_info;
+
+/* This structure defines all the properties of a backlight
+   (usually attached to a LCD). */
+struct backlight_properties {
+	/* Owner module */
+	struct module *owner;
+	/* Get the backlight power status (0: full on, 1..3: power saving
+	   modes; 4: full off), see FB_BLANK_XXX */
+	int (*get_power)(struct backlight_device *);
+	/* Enable or disable power to the LCD (0: on; 4: off, see FB_BLANK_XXX) */
+	int (*set_power)(struct backlight_device *, int power);
+	/* Maximal value for brightness (read-only) */
+	int max_brightness;
+	/* Get current backlight brightness */
+	int (*get_brightness)(struct backlight_device *);
+	/* Set backlight brightness (0..max_brightness) */
+	int (*set_brightness)(struct backlight_device *, int brightness);
+	/* Check if given framebuffer device is the one bound to this backlight;
+	   return 0 if not, !=0 if it is. If NULL, backlight always matches the fb. */
+	int (*check_fb)(struct fb_info *);
+};
+
+struct backlight_device {
+	/* This protects the 'props' field. If 'props' is NULL, the driver that
+	   registered this device has been unloaded, and if class_get_devdata()
+	   points to something in the body of that driver, it is also invalid. */
+	struct semaphore sem;
+	/* If this is NULL, the backing module is unloaded */
+	struct backlight_properties *props;
+	/* The framebuffer notifier block */
+	struct notifier_block fb_notif;
+	/* The class device structure */
+	struct class_device class_dev;
+};
+
+extern struct backlight_device *backlight_device_register(const char *name,
+	void *devdata, struct backlight_properties *bp);
+extern void backlight_device_unregister(struct backlight_device *bd);
+
+#define to_backlight_device(obj) container_of(obj, struct backlight_device, class_dev)
+
+#endif
--- linux-2.6.10/drivers/video/backlight/lcd.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/video/backlight/lcd.c	2005-01-09 21:22:57.000000000 +0300
@@ -0,0 +1,263 @@
+/*
+ * LCD Lowlevel Control Abstraction
+ *
+ * Copyright (C) 2003,2004 Hewlett-Packard Company
+ *
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/lcd.h>
+#include <linux/notifier.h>
+#include <linux/ctype.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <asm/bug.h>
+
+static ssize_t lcd_show_power(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct lcd_device *ld = to_lcd_device(cdev);
+
+	down(&ld->sem);
+	if (likely(ld->props && ld->props->get_power))
+		rc = sprintf(buf, "%d\n", ld->props->get_power(ld));
+	else
+		rc = -ENXIO;
+	up(&ld->sem);
+
+	return rc;
+}
+
+static ssize_t lcd_store_power(struct class_device *cdev, const char *buf, size_t count)
+{
+	int rc, power;
+	char *endp;
+	struct lcd_device *ld = to_lcd_device(cdev);
+
+	power = simple_strtoul(buf, &endp, 0);
+	if (*endp && !isspace(*endp))
+		return -EINVAL;
+
+	down(&ld->sem);
+	if (likely(ld->props && ld->props->set_power)) {
+		pr_debug("lcd: set power to %d\n", power);
+		ld->props->set_power(ld, power);
+		rc = count;
+	} else
+		rc = -ENXIO;
+	up(&ld->sem);
+
+	return rc;
+}
+
+static ssize_t lcd_show_contrast(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct lcd_device *ld = to_lcd_device(cdev);
+
+	down(&ld->sem);
+	if (likely(ld->props && ld->props->get_contrast))
+		rc = sprintf(buf, "%d\n", ld->props->get_contrast(ld));
+	else
+		rc = -ENXIO;
+	up(&ld->sem);
+
+	return rc;
+}
+
+static ssize_t lcd_store_contrast(struct class_device *cdev, const char *buf, size_t count)
+{
+	int rc, contrast;
+	char *endp;
+	struct lcd_device *ld = to_lcd_device(cdev);
+
+	contrast = simple_strtoul(buf, &endp, 0);
+	if (*endp && !isspace(*endp))
+		return -EINVAL;
+
+	down(&ld->sem);
+	if (likely(ld->props && ld->props->set_contrast)) {
+		pr_debug("lcd: set contrast to %d\n", contrast);
+		ld->props->set_contrast(ld, contrast);
+		rc = count;
+	} else
+		rc = -ENXIO;
+	up(&ld->sem);
+
+	return rc;
+}
+
+static ssize_t lcd_show_max_contrast(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct lcd_device *ld = to_lcd_device(cdev);
+
+	down(&ld->sem);
+	if (likely(ld->props))
+		rc = sprintf(buf, "%d\n", ld->props->max_contrast);
+	else
+		rc = -ENXIO;
+	up(&ld->sem);
+
+	return rc;
+}
+
+static void lcd_class_release(struct class_device *dev)
+{
+	struct lcd_device *ld = to_lcd_device(dev);
+	kfree(ld);
+}
+
+struct class lcd_class = {
+	.name = "lcd",
+	.release = lcd_class_release,
+};
+
+#define DECLARE_ATTR(_name,_mode,_show,_store)			\
+{							 	\
+	.attr	= { .name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
+	.show	= _show,					\
+	.store	= _store,					\
+}
+
+static struct class_device_attribute lcd_class_device_attributes[] = {
+	DECLARE_ATTR(power, 0644, lcd_show_power, lcd_store_power),
+	DECLARE_ATTR(contrast, 0644, lcd_show_contrast, lcd_store_contrast),
+	DECLARE_ATTR(max_contrast, 0444, lcd_show_max_contrast, NULL),
+};
+
+/* This callback gets called when something important happens inside a
+ * framebuffer driver. We're looking if that important event is blanking,
+ * and if it is, we're switching lcd power as well ...
+ */
+static int fb_notifier_callback(struct notifier_block *self,
+				 unsigned long event, void *data)
+{
+	struct lcd_device *ld;
+	struct fb_event *evdata =(struct fb_event *)data;
+
+	/* If we aren't interested in this event, skip it immediately ... */
+	if (event != FB_EVENT_BLANK)
+		return 0;
+
+	ld = container_of(self, struct lcd_device, fb_notif);
+	down(&ld->sem);
+	if (ld->props)
+		if (!ld->props->check_fb || ld->props->check_fb(evdata->info))
+			ld->props->set_power(ld, *(int *)evdata->data);
+	up(&ld->sem);
+	return 0;
+}
+
+/**
+ * lcd_device_register - register a new object of lcd_device class.
+ * @name: the name of the new object(must be the same as the name of the
+ *   respective framebuffer device).
+ * @devdata: an optional pointer to be stored in the class_device. The
+ *   methods may retrieve it by using class_get_devdata(ld->class_dev).
+ * @lp: the lcd properties structure.
+ *
+ * Creates and registers a new lcd class_device. Returns either an ERR_PTR()
+ * or a pointer to the newly allocated device.
+ */
+struct lcd_device *lcd_device_register(const char *name, void *devdata,
+				       struct lcd_properties *lp)
+{
+	int i, rc;
+	struct lcd_device *new_ld;
+
+	pr_debug("lcd_device_register: name=%s\n", name);
+
+	new_ld = kmalloc(sizeof(struct lcd_device), GFP_KERNEL);
+	if (unlikely(!new_ld))
+		return ERR_PTR(ENOMEM);
+
+	init_MUTEX(&new_ld->sem);
+	new_ld->props = lp;
+	memset(&new_ld->class_dev, 0, sizeof(new_ld->class_dev));
+	new_ld->class_dev.class = &lcd_class;
+	strlcpy(new_ld->class_dev.class_id, name, KOBJ_NAME_LEN);
+	class_set_devdata(&new_ld->class_dev, devdata);
+
+	rc = class_device_register(&new_ld->class_dev);
+	if (unlikely(rc)) {
+error:		kfree(new_ld);
+		return ERR_PTR(rc);
+	}
+
+	memset(&new_ld->fb_notif, 0, sizeof(new_ld->fb_notif));
+	new_ld->fb_notif.notifier_call = fb_notifier_callback;
+
+	rc = fb_register_client(&new_ld->fb_notif);
+	if (unlikely(rc))
+		goto error;
+
+	for (i = 0; i < ARRAY_SIZE(lcd_class_device_attributes); i++) {
+		rc = class_device_create_file(&new_ld->class_dev,
+					      &lcd_class_device_attributes[i]);
+		if (unlikely(rc)) {
+			while (--i >= 0)
+				class_device_remove_file(&new_ld->class_dev,
+							 &lcd_class_device_attributes[i]);
+			class_device_unregister(&new_ld->class_dev);
+			/* No need to kfree(new_ld) since release() method was called */
+			return ERR_PTR(rc);
+		}
+	}
+
+	return new_ld;
+}
+EXPORT_SYMBOL(lcd_device_register);
+
+/**
+ * lcd_device_unregister - unregisters a object of lcd_device class.
+ * @ld: the lcd device object to be unregistered and freed.
+ *
+ * Unregisters a previously registered via lcd_device_register object.
+ */
+void lcd_device_unregister(struct lcd_device *ld)
+{
+	int i;
+
+	if (!ld)
+		return;
+
+	pr_debug("lcd_device_unregister: name=%s\n", ld->class_dev.class_id);
+
+	for (i = 0; i < ARRAY_SIZE(lcd_class_device_attributes); i++)
+		class_device_remove_file(&ld->class_dev,
+					 &lcd_class_device_attributes[i]);
+
+	down(&ld->sem);
+	ld->props = NULL;
+	up(&ld->sem);
+
+	fb_unregister_client(&ld->fb_notif);
+
+	class_device_unregister(&ld->class_dev);
+}
+EXPORT_SYMBOL(lcd_device_unregister);
+
+static void __exit lcd_class_exit(void)
+{
+	class_unregister(&lcd_class);
+}
+
+static int __init lcd_class_init(void)
+{
+	return class_register(&lcd_class);
+}
+
+/*
+ * if this is compiled into the kernel, we need to ensure that the
+ * class is registered before users of the class try to register lcd's
+ */
+postcore_initcall(lcd_class_init);
+module_exit(lcd_class_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jamey Hicks <jamey.hicks@hp.com>, Andrew Zabolotny <zap@homelink.ru>");
+MODULE_DESCRIPTION("LCD Lowlevel Control Abstraction");
--- linux-2.6.10/drivers/video/backlight/backlight.c	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/video/backlight/backlight.c	2005-01-09 21:22:42.000000000 +0300
@@ -0,0 +1,264 @@
+/*
+ * Backlight Lowlevel Control Abstraction
+ *
+ * Copyright (C) 2003,2004 Hewlett-Packard Company
+ *
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/backlight.h>
+#include <linux/notifier.h>
+#include <linux/ctype.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <asm/bug.h>
+
+static ssize_t backlight_show_power(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct backlight_device *bd = to_backlight_device(cdev);
+
+	down(&bd->sem);
+	if (likely(bd->props && bd->props->get_power))
+		rc = sprintf(buf, "%d\n", bd->props->get_power(bd));
+	else
+		rc = -ENXIO;
+	up(&bd->sem);
+
+	return rc;
+}
+
+static ssize_t backlight_store_power(struct class_device *cdev, const char *buf, size_t count)
+{
+	int rc, power;
+	char *endp;
+	struct backlight_device *bd = to_backlight_device(cdev);
+
+	power = simple_strtoul(buf, &endp, 0);
+	if (*endp && !isspace(*endp))
+		return -EINVAL;
+
+	down(&bd->sem);
+	if (likely(bd->props && bd->props->set_power)) {
+		pr_debug("backlight: set power to %d\n", power);
+		bd->props->set_power(bd, power);
+		rc = count;
+	} else
+		rc = -ENXIO;
+	up(&bd->sem);
+
+	return rc;
+}
+
+static ssize_t backlight_show_brightness(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct backlight_device *bd = to_backlight_device(cdev);
+
+	down(&bd->sem);
+	if (likely(bd->props && bd->props->get_brightness))
+		rc = sprintf(buf, "%d\n", bd->props->get_brightness(bd));
+	else
+		rc = -ENXIO;
+	up(&bd->sem);
+
+	return rc;
+}
+
+static ssize_t backlight_store_brightness(struct class_device *cdev, const char *buf, size_t count)
+{
+	int rc, brightness;
+	char *endp;
+	struct backlight_device *bd = to_backlight_device(cdev);
+
+	brightness = simple_strtoul(buf, &endp, 0);
+	if (*endp && !isspace(*endp))
+		return -EINVAL;
+
+	down(&bd->sem);
+	if (likely(bd->props && bd->props->set_brightness)) {
+		pr_debug("backlight: set brightness to %d\n", brightness);
+		bd->props->set_brightness(bd, brightness);
+		rc = count;
+	} else
+		rc = -ENXIO;
+	up(&bd->sem);
+
+	return rc;
+}
+
+static ssize_t backlight_show_max_brightness(struct class_device *cdev, char *buf)
+{
+	int rc;
+	struct backlight_device *bd = to_backlight_device(cdev);
+
+	down(&bd->sem);
+	if (likely(bd->props))
+		rc = sprintf(buf, "%d\n", bd->props->max_brightness);
+	else
+		rc = -ENXIO;
+	up(&bd->sem);
+
+	return rc;
+}
+
+static void backlight_class_release(struct class_device *dev)
+{
+	struct backlight_device *bd = to_backlight_device(dev);
+	kfree(bd);
+}
+
+struct class backlight_class = {
+	.name = "backlight",
+	.release = backlight_class_release,
+};
+
+#define DECLARE_ATTR(_name,_mode,_show,_store)			\
+{							 	\
+	.attr	= { .name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
+	.show	= _show,					\
+	.store	= _store,					\
+}
+
+static struct class_device_attribute bl_class_device_attributes[] = {
+	DECLARE_ATTR(power, 0644, backlight_show_power, backlight_store_power),
+	DECLARE_ATTR(brightness, 0644, backlight_show_brightness, backlight_store_brightness),
+	DECLARE_ATTR(max_brightness, 0444, backlight_show_max_brightness, NULL),
+};
+
+/* This callback gets called when something important happens inside a
+ * framebuffer driver. We're looking if that important event is blanking,
+ * and if it is, we're switching backlight power as well ...
+ */
+static int fb_notifier_callback(struct notifier_block *self,
+				unsigned long event, void *data)
+{
+	struct backlight_device *bd;
+	struct fb_event *evdata =(struct fb_event *)data;
+
+	/* If we aren't interested in this event, skip it immediately ... */
+	if (event != FB_EVENT_BLANK)
+		return 0;
+
+	bd = container_of(self, struct backlight_device, fb_notif);
+	down(&bd->sem);
+	if (bd->props)
+		if (!bd->props->check_fb || bd->props->check_fb(evdata->info))
+			bd->props->set_power(bd, *(int *)evdata->data);
+	up(&bd->sem);
+	return 0;
+}
+
+/**
+ * backlight_device_register - create and register a new object of
+ *   backlight_device class.
+ * @name: the name of the new object(must be the same as the name of the
+ *   respective framebuffer device).
+ * @devdata: an optional pointer to be stored in the class_device. The
+ *   methods may retrieve it by using class_get_devdata(&bd->class_dev).
+ * @bp: the backlight properties structure.
+ *
+ * Creates and registers new backlight class_device. Returns either an
+ * ERR_PTR() or a pointer to the newly allocated device.
+ */
+struct backlight_device *backlight_device_register(const char *name, void *devdata,
+						   struct backlight_properties *bp)
+{
+	int i, rc;
+	struct backlight_device *new_bd;
+
+	pr_debug("backlight_device_alloc: name=%s\n", name);
+
+	new_bd = kmalloc(sizeof(struct backlight_device), GFP_KERNEL);
+	if (unlikely(!new_bd))
+		return ERR_PTR(ENOMEM);
+
+	init_MUTEX(&new_bd->sem);
+	new_bd->props = bp;
+	memset(&new_bd->class_dev, 0, sizeof(new_bd->class_dev));
+	new_bd->class_dev.class = &backlight_class;
+	strlcpy(new_bd->class_dev.class_id, name, KOBJ_NAME_LEN);
+	class_set_devdata(&new_bd->class_dev, devdata);
+
+	rc = class_device_register(&new_bd->class_dev);
+	if (unlikely(rc)) {
+error:		kfree(new_bd);
+		return ERR_PTR(rc);
+	}
+
+	memset(&new_bd->fb_notif, 0, sizeof(new_bd->fb_notif));
+	new_bd->fb_notif.notifier_call = fb_notifier_callback;
+
+	rc = fb_register_client(&new_bd->fb_notif);
+	if (unlikely(rc))
+		goto error;
+
+	for (i = 0; i < ARRAY_SIZE(bl_class_device_attributes); i++) {
+		rc = class_device_create_file(&new_bd->class_dev,
+					      &bl_class_device_attributes[i]);
+		if (unlikely(rc)) {
+			while (--i >= 0)
+				class_device_remove_file(&new_bd->class_dev,
+							 &bl_class_device_attributes[i]);
+			class_device_unregister(&new_bd->class_dev);
+			/* No need to kfree(new_bd) since release() method was called */
+			return ERR_PTR(rc);
+		}
+	}
+
+	return new_bd;
+}
+EXPORT_SYMBOL(backlight_device_register);
+
+/**
+ * backlight_device_unregister - unregisters a backlight device object.
+ * @bd: the backlight device object to be unregistered and freed.
+ *
+ * Unregisters a previously registered via backlight_device_register object.
+ */
+void backlight_device_unregister(struct backlight_device *bd)
+{
+	int i;
+
+	if (!bd)
+		return;
+
+	pr_debug("backlight_device_unregister: name=%s\n", bd->class_dev.class_id);
+
+	for (i = 0; i < ARRAY_SIZE(bl_class_device_attributes); i++)
+		class_device_remove_file(&bd->class_dev,
+					 &bl_class_device_attributes[i]);
+
+	down(&bd->sem);
+	bd->props = NULL;
+	up(&bd->sem);
+
+	fb_unregister_client(&bd->fb_notif);
+
+	class_device_unregister(&bd->class_dev);
+}
+EXPORT_SYMBOL(backlight_device_unregister);
+
+static void __exit backlight_class_exit(void)
+{
+	class_unregister(&backlight_class);
+}
+
+static int __init backlight_class_init(void)
+{
+	return class_register(&backlight_class);
+}
+
+/*
+ * if this is compiled into the kernel, we need to ensure that the
+ * class is registered before users of the class try to register lcd's
+ */
+postcore_initcall(backlight_class_init);
+module_exit(backlight_class_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jamey Hicks <jamey.hicks@hp.com>, Andrew Zabolotny <zap@homelink.ru>");
+MODULE_DESCRIPTION("Backlight Lowlevel Control Abstraction");
--- linux-2.6.10/drivers/video/backlight/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/video/backlight/Kconfig	2005-01-02 21:58:09.000000000 +0300
@@ -0,0 +1,41 @@
+#
+# Backlight & LCD drivers configuration
+#
+
+menuconfig BACKLIGHT_LCD_SUPPORT
+	bool "Backlight & LCD device support"
+	help
+	  Enable this to be able to choose the drivers for controlling the
+	  backlight and the LCD panel on some platforms, for example on PDAs.
+
+config BACKLIGHT_CLASS_DEVICE
+        tristate "Lowlevel Backlight controls"
+	depends on BACKLIGHT_LCD_SUPPORT
+	help
+	  This framework adds support for low-level control of the LCD
+          backlight. This includes support for brightness and power.
+
+	  To have support for your specific LCD panel you will have to
+	  select the proper drivers which depend on this option.
+
+config BACKLIGHT_DEVICE
+	bool
+	depends on BACKLIGHT_CLASS_DEVICE
+	default y
+
+config LCD_CLASS_DEVICE
+        tristate "Lowlevel LCD controls"
+	depends on BACKLIGHT_LCD_SUPPORT
+	help
+	  This framework adds support for low-level control of LCD.
+	  Some framebuffer devices connect to platform-specific LCD modules
+	  in order to have a platform-specific way to control the flat panel
+	  (contrast and applying power to the LCD (not to the backlight!)).
+
+	  To have support for your specific LCD panel you will have to
+	  select the proper drivers which depend on this option.
+
+config LCD_DEVICE
+	bool
+	depends on LCD_CLASS_DEVICE
+	default y
--- linux-2.6.10/drivers/video/backlight/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux/drivers/video/backlight/Makefile	2005-01-02 21:16:16.000000000 +0300
@@ -0,0 +1,4 @@
+# Backlight & LCD drivers
+
+obj-$(CONFIG_LCD_CLASS_DEVICE)     += lcd.o
+obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
--- linux-2.6.10/drivers/video/Kconfig	2004-12-04 11:29:31.000000000 +0300
+++ linux/drivers/video/Kconfig	2005-01-02 22:01:42.000000000 +0300
@@ -1094,5 +1094,9 @@
 	source "drivers/video/logo/Kconfig"
 endif
 
+if SYSFS
+	source "drivers/video/backlight/Kconfig"
+endif
+
 endmenu
 
--- linux-2.6.10/drivers/video/Makefile	2004-12-04 11:29:31.000000000 +0300
+++ linux/drivers/video/Makefile	2005-01-02 22:00:48.000000000 +0300
@@ -6,6 +6,7 @@
 
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
+obj-$(CONFIG_SYSFS)		  += backlight/
 
 obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o softcursor.o
 # Only include macmodes.o if we have FB support and are PPC

--Multipart=_Sun__9_Jan_2005_23_17_32_+0300_ov1wbEwMEeOPgItv--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
