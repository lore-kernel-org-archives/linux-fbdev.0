From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] Add sysfs entry to disable framebuffer access
Date: Thu, 24 Nov 2005 05:09:09 +0000
Message-ID: <20051124050909.GA28015@srcf.ucam.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030597AbVKXFJb@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

What
----

The following patch adds a state file to /sys/class/graphics/fb*. 
Echoing values to it will alter the contents of fb_info->state, 
resulting in reads and writes to the framebuffer device being discarded 
and EPERM being returned.

Why
---

When resuming from ACPI suspend to RAM, video hardware is not required 
to be in a sane state. The most effective workaround is vbetool, a 
userspace application that executes video BIOS code in order to 
reinitialise the graphics hardware. Different hardware requires 
different reinitialisation, and keeping this policy in userspace is more 
sensible than putting it in the kernel.

However, since reinitialisation occurs in userspace, it happens some 
time after the kernel has restarted. During resume, the kernel attempts 
to printk all sorts of information. If a framebuffer is in use, this 
will trigger framebuffer writes. Since the hardware has not yet been 
reinitialised, this can result in system hangs.

This patch allows userspace to disable framebuffer writes immediately 
before suspend. On resume, userspace can then reinitialise the 
hardware and reenable framebuffer writes. As a result, system resiliance 
over suspend/resume is improved.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

--- a/drivers/video/fbsysfs.c	2005-11-24 02:07:07 +0000
+++ b/drivers/video/fbsysfs.c	2005-11-24 02:07:58 +0000
@@ -492,6 +492,30 @@
 	return snprintf(buf, PAGE_SIZE, "%s\n", fb_info->fix.id);
 }
 
+static ssize_t store_fbstate(struct class_device *class_device, const char * buf,
+			   size_t count)
+{
+	struct fb_info *fb_info =
+		(struct fb_info *)class_get_devdata(class_device);
+	u32 state;
+	char *last = NULL;
+
+	state = simple_strtoul(buf, &last, 0);
+
+	acquire_console_sem();
+	fb_set_suspend(fb_info, (int)state);
+	release_console_sem();
+
+	return count;
+}
+
+static ssize_t show_fbstate(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info =
+		(struct fb_info *)class_get_devdata(class_device);
+	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->state);
+}
+
 static struct class_device_attribute class_device_attrs[] = {
 	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
 	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
@@ -507,6 +531,7 @@
 	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
 	__ATTR(con_rotate, S_IRUGO|S_IWUSR, show_con_rotate, store_con_rotate),
 	__ATTR(con_rotate_all, S_IWUSR, NULL, store_con_rotate_all),
+	__ATTR(state, S_IRUGO|S_IWUSR, show_fbstate, store_fbstate),
 };
 
 int fb_init_class_device(struct fb_info *fb_info)


-- 
Matthew Garrett | mjg59@srcf.ucam.org
