From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] Sysfs for framebuffer
Date: Sat, 20 Mar 2004 18:49:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040320174956.GA3177@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

Hi,
the following patch (against 2.6.5-rc2) teaches fb to use class_simple.
With this patch udev will automagically create device nodes for each
framebuffer registered. Once all drivers are converted to
framebuffer_{alloc,release} we can switch to our own class.

This is what sysfs dir looks like:

notebook:~# tree /sys/class/graphics/
/sys/class/graphics/
`-- fb0
    `-- dev

1 directory, 1 file


--- a/drivers/video/fbmem.c	2004-03-20 15:57:53.000000000 +0100
+++ b/drivers/video/fbmem.c	2004-03-20 16:17:26.000000000 +0100
@@ -32,6 +32,9 @@
 #include <linux/kmod.h>
 #endif
 #include <linux/devfs_fs_kernel.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
 
 #if defined(__mc68000__) || defined(CONFIG_APUS)
 #include <asm/setup.h>
@@ -1251,6 +1254,8 @@
 #endif
 };
 
+static struct class_simple *fb_class;
+
 /**
  *	register_framebuffer - registers a frame buffer device
  *	@fb_info: frame buffer info structure
@@ -1265,6 +1270,7 @@
 register_framebuffer(struct fb_info *fb_info)
 {
 	int i;
+	struct class_device *c;
 
 	if (num_registered_fb == FB_MAX)
 		return -ENXIO;
@@ -1273,6 +1279,12 @@
 		if (!registered_fb[i])
 			break;
 	fb_info->node = i;
+
+	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
+	if (IS_ERR(c)) {
+		/* Not fatal */
+		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(c));
+	}
 	
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
@@ -1338,6 +1350,7 @@
 		kfree(fb_info->sprite.addr);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
+	class_simple_device_remove(MKDEV(FB_MAJOR, i));
 	return 0;
 }
 
@@ -1399,6 +1412,12 @@
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
 
+	fb_class = class_simple_create(THIS_MODULE, "graphics");
+	if (IS_ERR(fb_class)) {
+		printk(KERN_WARNING "Unable to create fb class; errno = %ld\n", PTR_ERR(fb_class));
+		fb_class = NULL;
+	}
+
 #ifdef CONFIG_FB_OF
 	if (ofonly) {
 		offb_init();


Luca
-- 
Home: http://kronoz.cjb.net
La differenza fra l'intelligenza e la stupidita`?
All'intelligenza c'e` un limite.
