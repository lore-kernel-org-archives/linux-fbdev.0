From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] core: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:34:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915193430.GB16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yz82-00035R-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:35:18 -0700
Received: from mail-1.tiscali.it ([195.130.225.147])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yz81-0001Ey-7w
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:35:17 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


Core changes. We don't need fb_dev anymore. Adds framebuffer_alloc,
updates struct fb_info.

======== include/linux/fb.h 1.59 ========
D 1.59 03/09/15 18:57:47+02:00 kronos@kronoz.cjb.net 73 71 0/0/597
P include/linux/fb.h
C Auto merged
------------------------------------------------

===== include/linux/fb.h 1.58 vs 1.59 =====
--- 1.58/include/linux/fb.h	Sun Sep 14 16:50:50 2003
+++ 1.59/include/linux/fb.h	Mon Sep 15 18:57:47 2003
@@ -2,6 +2,7 @@
 #define _LINUX_FB_H
 
 #include <linux/tty.h>
+#include <linux/device.h>
 #include <asm/types.h>
 #include <asm/io.h>
 
@@ -421,8 +422,10 @@
 	char *screen_base;		/* Virtual address */
 	struct vc_data *display_fg;	/* Console visible on this display */
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 
-	struct device *dev;		/* Pointer to the device for this fb */
 	int currcon;			/* Current VC. */	
+	struct class_device class_dev;
+	void (*release)(struct fb_info *);  /* Do driver specific clean up */
+	
 	/* From here on everything is device dependent */
 	void *par;	
 };
@@ -489,6 +492,7 @@
 
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
+extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);


======== drivers/video/fbmem.c 1.94 ========
D 1.94 03/09/15 19:02:33+02:00 kronos@kronoz.cjb.net 120 118 0/0/1509
P drivers/video/fbmem.c
C SCCS merged
------------------------------------------------

===== drivers/video/fbmem.c 1.93 vs 1.94 =====
--- 1.93/drivers/video/fbmem.c	Sun Sep 14 16:50:50 2003
+++ 1.94/drivers/video/fbmem.c	Mon Sep 15 19:02:33 2003
@@ -1215,81 +1215,84 @@
 #endif
 };
 
-struct fb_dev {
-	struct list_head node;
-	dev_t dev;
-	struct class_device class_dev;
-};
-#define to_fb_dev(d) container_of(d, struct fb_dev, class_dev)
+#define to_fb_info(d) container_of(d, struct fb_info, class_dev)
 
-static void release_fb_dev(struct class_device *class_dev)
+static void release_fb_info(struct class_device *class_dev)
 {
-	struct fb_dev *fb_dev = to_fb_dev(class_dev);
-	kfree(fb_dev);
+	struct fb_info *fb_info = to_fb_info(class_dev);
+
+	if (fb_info->release)
+		fb_info->release(fb_info);
+	kfree(fb_info);
 }
 
 static struct class fb_class = {
 	.name		= "graphics",
-	.release	= &release_fb_dev,
+	.release	= &release_fb_info,
 };
 
 static LIST_HEAD(fb_dev_list);
-static spinlock_t fb_dev_list_lock = SPIN_LOCK_UNLOCKED;
 
 static ssize_t show_dev(struct class_device *class_dev, char *buf)
 {
-	struct fb_dev *fb_dev = to_fb_dev(class_dev);
-	return print_dev_t(buf, fb_dev->dev);
+	struct fb_info *fb_info = to_fb_info(class_dev);
+	return sprintf(buf, "%u:%u\n", FB_MAJOR, fb_info->node);
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
-static void fb_add_class_device(int minor, struct device *device)
+static void fb_add_class_device(struct fb_info *fb_info)
 {
-	struct fb_dev *fb_dev = NULL;
 	int retval;
-
-	fb_dev = kmalloc(sizeof(*fb_dev), GFP_KERNEL);
-	if (!fb_dev)
+	
+	fb_info->class_dev.class = &fb_class;
+	snprintf(fb_info->class_dev.class_id, BUS_ID_SIZE, "fb%d", fb_info->node);
+	retval = class_device_register(&fb_info->class_dev);
+	if (retval)
 		return;
-	memset(fb_dev, 0x00, sizeof(*fb_dev));
+	class_device_create_file(&fb_info->class_dev, &class_device_attr_dev);
+}
 
-	fb_dev->dev = MKDEV(FB_MAJOR, minor);
-	fb_dev->class_dev.dev = device;
-	fb_dev->class_dev.class = &fb_class;
-	snprintf(fb_dev->class_dev.class_id, BUS_ID_SIZE, "fb%d", minor);
-	retval = class_device_register(&fb_dev->class_dev);
-	if (retval)
-		goto error;
-	class_device_create_file(&fb_dev->class_dev, &class_device_attr_dev);
-	spin_lock(&fb_dev_list_lock);
-	list_add(&fb_dev->node, &fb_dev_list);
-	spin_unlock(&fb_dev_list_lock);
-	return;
-error:
-	kfree(fb_dev);
-}
-
-void fb_remove_class_device(int minor)
-{
-	struct fb_dev *fb_dev = NULL;
-	struct list_head *tmp;
-	int found = 0;
-
-	spin_lock(&fb_dev_list_lock);
-	list_for_each(tmp, &fb_dev_list) {
-		fb_dev = list_entry(tmp, struct fb_dev, node);
-		if ((MINOR(fb_dev->dev) == minor)) {
-			found = 1;
-			break;
-		}
-	}
-	if (found) {
-		list_del(&fb_dev->node);
-		spin_unlock(&fb_dev_list_lock);
-		class_device_unregister(&fb_dev->class_dev);
-	} else {
-		spin_unlock(&fb_dev_list_lock);
-	}
+static void fb_remove_class_device(struct fb_info *fb_info)
+{
+	class_device_unregister(&fb_info->class_dev);
+}
+
+/**
+ * framebuffer_alloc - creates a new frame buffer info structure
+ *
+ * @size size of driver private data, can be zero
+ * @dev pointer to the device for this fb, can be NULL
+ *
+ * Creates a new frame buffer info structure. Also reserves @size bytes
+ * for driver private data (fb_info->par). fb_info->par (if any) will be
+ * aligned to sizeof(long).
+ * 
+ * Returns the new structure, or NULL if an error occurred.
+ *
+ */
+struct fb_info *framebuffer_alloc(size_t size, struct device *dev) {
+#define BYTES_PER_LONG (BITS_PER_LONG/8)
+#define PADDING (BYTES_PER_LONG - (sizeof(struct fb_info) % BYTES_PER_LONG))
+	struct fb_info *fb_info;
+	char *p;
+	int fb_info_size = sizeof(struct fb_info);
+
+	if (size)
+		fb_info_size += PADDING;
+
+	p = kmalloc(fb_info_size + size, GFP_KERNEL);
+	if (!p)
+		return NULL;
+	memset(p, 0, fb_info_size + size);
+	fb_info = (struct fb_info *)p;
+	fb_info->class_dev.dev = dev;
+
+	if (size)
+		fb_info->par = p + fb_info_size;
+
+	return fb_info;
+#undef PADDING
+#undef BYTES_PER_LONG
 }
 
 /**
@@ -1352,7 +1355,7 @@
 	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
 			S_IFCHR | S_IRUGO | S_IWUGO, "fb/%d", i);
 
-	fb_add_class_device(i, fb_info->dev);
+	fb_add_class_device(fb_info);
 	return 0;
 }
 
@@ -1381,7 +1384,7 @@
 		kfree(fb_info->pixmap.addr);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
-	fb_remove_class_device(i);
+	fb_remove_class_device(fb_info);
 	return 0;
 }

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Mi piace avere amici rispettabili;
Mi piace essere il peggiore della compagnia.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
