From: James Simmons <jsimmons@infradead.org>
Subject: Display name of fbdev device
Date: Sat, 30 Jul 2005 23:49:54 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507302347330.8398@pentafluge.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263177AbVG3Wui@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


This patch displays the name of the fbdev driver in sysfs.
Down the road this will replace the current proc handle we have.


Signed-off-by: James Simmons <jsimmons@infradead.org>

--- linus-2.6/drivers/video/fbsysfs.c	2005-07-29 12:16:08.000000000 -0700
+++ fbdev-2.6/drivers/video/fbsysfs.c	2005-07-30 12:02:22.000000000 -0700
@@ -414,6 +414,13 @@
 			fb_info->var.xoffset);
 }
 
+static ssize_t show_name(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", fb_info->fix.id);
+}
+
 static struct class_device_attribute class_device_attrs[] = {
 	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
 	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
@@ -424,6 +431,7 @@
 	__ATTR(modes, S_IRUGO|S_IWUSR, show_modes, store_modes),
 	__ATTR(pan, S_IRUGO|S_IWUSR, show_pan, store_pan),
 	__ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual),
+	__ATTR(name, S_IRUGO, show_name, NULL),
 };
 
 int fb_init_class_device(struct fb_info *fb_info)
