From: James Simmons <jsimmons@infradead.org>
Subject: [PATCH] display class
Date: Sun, 25 Feb 2007 18:39:57 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702251833500.30828@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLOHz-0001zS-20 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 10:40:03 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HLOHx-0004Of-4Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 10:40:02 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Here is the second round to the new display class. This is meant to unite 
the various solutions to display units ie acpi output device, auxdisplay 
and the defunct lcd class in the backlight directory. Please apply.

Signed-off-by: James Simmons <jsimmons@infradead.org>

diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/display/display-sysfs.c fbdev-2.6/drivers/video/display/display-sysfs.c
--- linus-2.6/drivers/video/display/display-sysfs.c	1969-12-31 19:00:00.000000000 -0500
+++ fbdev-2.6/drivers/video/display/display-sysfs.c	2007-02-24 16:20:42.000000000 -0500
@@ -0,0 +1,203 @@
+/*
+ *  display-sysfs.c - Display output driver sysfs interface
+ *
+ *  Copyright (C) 2007 James Simmons <jsimmons@infradead.org>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/module.h>
+#include <linux/display.h>
+#include <linux/bitmap.h>
+#include <linux/err.h>
+#include <linux/ctype.h>
+
+static ssize_t display_show_name(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct display_device *dsp = dev_get_drvdata(dev);
+	return snprintf(buf, PAGE_SIZE, "%s\n", dsp->name);
+}
+
+static ssize_t display_show_type(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct display_device *dsp = dev_get_drvdata(dev);
+	return snprintf(buf, PAGE_SIZE, "%s\n", dsp->type);
+}
+
+static ssize_t display_show_contrast(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct display_device *dsp = dev_get_drvdata(dev);
+	ssize_t rc = -ENXIO;
+
+	mutex_lock(&dsp->lock);
+	if (likely(dsp->driver) && dsp->driver->get_contrast)
+		rc = sprintf(buf, "%d\n", dsp->driver->get_contrast(dsp));
+	mutex_unlock(&dsp->lock);
+	return rc;
+}
+
+static ssize_t display_store_contrast(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct display_device *dsp = dev_get_drvdata(dev);
+	ssize_t ret = -EINVAL, size;
+	int contrast;
+	char *endp;
+
+	contrast = simple_strtoul(buf, &endp, 0);
+	size = endp - buf;
+
+	if (*endp && isspace(*endp))
+		size++;
+
+	if (size != count)
+		return ret;
+
+	mutex_lock(&dsp->lock);
+	if (likely(dsp->driver && dsp->driver->set_contrast)) {
+		pr_debug("display: set contrast to %d\n", contrast);
+		dsp->driver->set_contrast(dsp, contrast);
+		ret = count;
+	}
+	mutex_unlock(&dsp->lock);
+	return ret;
+}
+
+static ssize_t display_show_max_contrast(struct device *dev, struct device_attribute *attr,
+					char *buf)
+{
+	struct display_device *dsp = dev_get_drvdata(dev);
+	ssize_t rc = -ENXIO;
+
+	mutex_lock(&dsp->lock);
+	if (likely(dsp->driver))
+		rc = sprintf(buf, "%d\n", dsp->driver->max_contrast);
+	mutex_unlock(&dsp->lock);
+	return rc;
+}
+
+static struct device_attribute display_attrs[] = {
+	__ATTR(name, S_IRUGO, display_show_name, NULL),
+	__ATTR(type, S_IRUGO, display_show_type, NULL),
+	__ATTR(contrast, S_IRUGO | S_IWUSR, display_show_contrast, display_store_contrast),
+	__ATTR(max_contrast, S_IRUGO, display_show_max_contrast, NULL),
+};
+
+static int display_suspend(struct device *dev, pm_message_t state)
+{
+	struct display_device *dsp = dev_get_drvdata(dev);
+
+	mutex_lock(&dsp->lock);
+	if (likely(dsp->driver->suspend))
+		dsp->driver->suspend(dsp, state);
+	mutex_unlock(&dsp->lock);
+	return 0;
+};
+
+static int display_resume(struct device *dev)
+{
+	struct display_device *dsp = dev_get_drvdata(dev);
+
+	mutex_lock(&dsp->lock);
+	if (likely(dsp->driver->resume))
+		dsp->driver->resume(dsp);
+	mutex_unlock(&dsp->lock);
+	return 0;
+};
+
+struct class *display_class;
+EXPORT_SYMBOL(display_class);
+
+#define NUM_OF_DISPLAYS		32
+DECLARE_BITMAP(inuse, NUM_OF_DISPLAYS);
+
+struct display_device *display_device_register(struct display_driver *driver,
+						struct device *parent, void *devdata)
+{
+	int idx = find_first_zero_bit(inuse, NUM_OF_DISPLAYS);
+	struct display_device *new_dev = NULL;
+	struct device *display_device = NULL;
+
+	if (unlikely(!driver))
+		return ERR_PTR(-EINVAL);
+
+	display_device = device_create(display_class, parent, 0, "display%d", idx);
+	if (IS_ERR(display_device))
+		return ERR_PTR(-ENOMEM);
+
+	new_dev = kzalloc(sizeof(struct display_device), GFP_KERNEL);
+	if (likely(new_dev) && unlikely(driver->probe(new_dev, devdata))) {
+		dev_set_drvdata(display_device, new_dev);
+		new_dev->dev = display_device;
+		new_dev->parent = parent;
+		new_dev->driver = driver;
+		mutex_init(&new_dev->lock);
+		set_bit(idx, inuse);
+		new_dev->idx = idx;
+	} else
+		device_unregister(display_device);
+	return new_dev;
+}
+EXPORT_SYMBOL(display_device_register);
+
+void display_device_unregister(struct display_device *ddev)
+{
+	if (!ddev)
+		return;
+	mutex_lock(&ddev->lock);
+	device_unregister(ddev->parent);
+	clear_bit(ddev->idx, inuse);
+	mutex_unlock(&ddev->lock);
+	kfree(ddev);
+}
+EXPORT_SYMBOL(display_device_unregister);
+
+static int __init display_class_init(void)
+{
+	display_class = class_create(THIS_MODULE, "display");
+	if (IS_ERR(display_class)) {
+		printk(KERN_ERR "Failed to create display class\n");
+		display_class = NULL;
+		return -EINVAL;
+	}
+	display_class->dev_attrs = display_attrs;
+	display_class->suspend = display_suspend;
+	display_class->resume = display_resume;
+	bitmap_zero(inuse, NUM_OF_DISPLAYS);	
+	return 0;
+}
+
+#ifdef MODULE
+module_init(display_class_init);
+
+static void __exit display_class_exit(void)
+{
+	class_destroy(display_class);
+}
+module_exit(display_class_exit);
+#else
+subsys_initcall(display_class_init);
+#endif
+
+MODULE_DESCRIPTION("Display Hardware handling");
+MODULE_AUTHOR("James Simmons <jsimmons@infradead.org>");
+MODULE_LICENSE("GPL");
+
diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/display/Kconfig fbdev-2.6/drivers/video/display/Kconfig
--- linus-2.6/drivers/video/display/Kconfig	1969-12-31 19:00:00.000000000 -0500
+++ fbdev-2.6/drivers/video/display/Kconfig	2007-02-24 16:22:27.000000000 -0500
@@ -0,0 +1,24 @@
+#
+# Display drivers configuration
+#
+
+menu "Display device support"
+
+config DISPLAY_SUPPORT
+	tristate "Display panel/monitor support"
+	---help---
+	  This framework adds support for low-level control of a display.
+	  This includes support for power.
+
+	  Enable this to be able to choose the drivers for controlling the
+	  physical display panel/monitor on some platforms. This not only
+	  covers LCD displays for PDAs but also other types of displays
+	  such as CRT, TVout etc.
+
+	  To have support for your specific display panel you will have to
+	  select the proper drivers which depend on this option.
+
+comment "Display hardware drivers"
+	depends on DISPLAY_SUPPORT
+
+endmenu
diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/display/Makefile fbdev-2.6/drivers/video/display/Makefile
--- linus-2.6/drivers/video/display/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ fbdev-2.6/drivers/video/display/Makefile	2007-02-24 16:22:13.000000000 -0500
@@ -0,0 +1,6 @@
+# Display drivers
+
+display-objs				:= display-sysfs.o
+
+obj-$(CONFIG_DISPLAY_SUPPORT)		+= display.o
+
diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/Kconfig fbdev-2.6/drivers/video/Kconfig
--- linus-2.6/drivers/video/Kconfig	2007-02-21 10:59:24.000000000 -0500
+++ fbdev-2.6/drivers/video/Kconfig	2007-02-24 10:57:18.000000000 -0500
@@ -5,6 +5,7 @@
 menu "Graphics support"
 
 source "drivers/video/backlight/Kconfig"
+source "drivers/video/display/Kconfig"
 
 config FB
 	tristate "Support for frame buffer devices"
diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/drivers/video/Makefile fbdev-2.6/drivers/video/Makefile
--- linus-2.6/drivers/video/Makefile	2007-02-21 10:59:24.000000000 -0500
+++ fbdev-2.6/drivers/video/Makefile	2007-02-22 09:41:41.000000000 -0500
@@ -12,7 +12,7 @@
 
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
-obj-y				  += backlight/
+obj-y				  += backlight/ display/
 
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
 obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
diff -urN -X fbdev-2.6/Documentation/dontdiff linus-2.6/include/linux/display.h fbdev-2.6/include/linux/display.h
--- linus-2.6/include/linux/display.h	1969-12-31 19:00:00.000000000 -0500
+++ fbdev-2.6/include/linux/display.h	2007-02-24 11:09:13.000000000 -0500
@@ -0,0 +1,61 @@
+/*
+ *  Copyright (C) 2006 James Simmons <jsimmons@infradead.org>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#ifndef _LINUX_DISPLAY_H
+#define _LINUX_DISPLAY_H
+
+#include <linux/device.h>
+
+struct display_device;
+
+/* This structure defines all the properties of a Display. */
+struct display_driver {
+	int  (*set_contrast)(struct display_device *, unsigned int);
+	int  (*get_contrast)(struct display_device *);
+	void (*suspend)(struct display_device *, pm_message_t state);
+	void (*resume)(struct display_device *);
+	int  (*probe)(struct display_device *, void *);
+	int  (*remove)(struct display_device *);
+	int  max_contrast;
+};
+
+struct display_device {
+	struct module *owner;			/* Owner module */
+	struct display_driver *driver;
+	struct device *parent;			/* This is the parent */
+	struct device *dev;			/* This is this display device */
+	struct mutex lock;
+	void *priv_data;
+	char type[16];
+	char *name;
+	int idx;
+};
+
+extern struct display_device *display_device_register(struct display_driver *driver,
+					struct device *dev, void *devdata);
+extern void display_device_unregister(struct display_device *dev);
+
+extern int probe_edid(struct display_device *dev, void *devdata);
+
+#define to_display_device(obj) container_of(obj, struct display_device, class_dev)
+
+#endif

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
