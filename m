From: Kronos <kronos@kronoz.cjb.net>
Subject: framebuffer_{alloc,release}
Date: Tue, 16 Sep 2003 21:27:53 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030916192753.GB14731@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zLUp-0003Ln-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 12:28:19 -0700
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zLUn-0005vR-Tp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Sep 2003 12:28:18 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Russell King <rmk@arm.linux.org.uk>

Hi,
this is a new version of the new framebuffer_alloc API. It is based on the
feedback I had (thanks to Russel King).

framebuffer_alloc  is unchanged,  driver  specific  release callback  is
gone. struct fb_info won't go away until we drop the refcount with a new
function. I think that framebuffer_free can  be misleading as it doesn't
free anything, so I named it framebuffer_release.

Drivers will do something like this:

foo_probe(...) {
        fb_info = framebuffer_alloc(...);
        register_framebuffer(fb_info);
}

foo_remove(...) {
        unregister_framebuffer(fb_info);
        /* Do clean up */
        framebuffer_release(fb_info);
}

As we already have (un)register_framebuffer I'm thinking to change names
to alloc_framebuffer and release_framebuffer.

Comments?

(patch against James Simmons tree)

===== drivers/video/fbmem.c 1.93 vs edited =====
--- 1.93/drivers/video/fbmem.c	Sun Sep 14 16:50:50 2003
+++ edited/drivers/video/fbmem.c	Tue Sep 16 21:20:06 2003
@@ -1215,81 +1215,91 @@
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
+	/* This doesn't harm */
+	fb_dealloc_cmap(&fb_info->cmap);
+	
+	kfree(fb_info);
 }
 
 static struct class fb_class = {
 	.name		= "graphics",
-	.release	= &release_fb_dev,
+	.release	= &release_fb_info,
 };
 
-static LIST_HEAD(fb_dev_list);
-static spinlock_t fb_dev_list_lock = SPIN_LOCK_UNLOCKED;
-
 static ssize_t show_dev(struct class_device *class_dev, char *buf)
 {
-	struct fb_dev *fb_dev = to_fb_dev(class_dev);
-	return print_dev_t(buf, fb_dev->dev);
+	struct fb_info *fb_info = to_fb_info(class_dev);
+	return sprintf(buf, "%u:%u\n", FB_MAJOR, fb_info->node);
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
-static void fb_add_class_device(int minor, struct device *device)
+static int fb_add_class_device(struct fb_info *fb_info)
 {
-	struct fb_dev *fb_dev = NULL;
 	int retval;
-
-	fb_dev = kmalloc(sizeof(*fb_dev), GFP_KERNEL);
-	if (!fb_dev)
-		return;
-	memset(fb_dev, 0x00, sizeof(*fb_dev));
-
-	fb_dev->dev = MKDEV(FB_MAJOR, minor);
-	fb_dev->class_dev.dev = device;
-	fb_dev->class_dev.class = &fb_class;
-	snprintf(fb_dev->class_dev.class_id, BUS_ID_SIZE, "fb%d", minor);
-	retval = class_device_register(&fb_dev->class_dev);
+	
+	fb_info->class_dev.class = &fb_class;
+	snprintf(fb_info->class_dev.class_id, BUS_ID_SIZE, "fb%d", fb_info->node);
+	retval = class_device_register(&fb_info->class_dev);
 	if (retval)
-		goto error;
-	class_device_create_file(&fb_dev->class_dev, &class_device_attr_dev);
-	spin_lock(&fb_dev_list_lock);
-	list_add(&fb_dev->node, &fb_dev_list);
-	spin_unlock(&fb_dev_list_lock);
-	return;
-error:
-	kfree(fb_dev);
+		return retval;
+	return class_device_create_file(&fb_info->class_dev, &class_device_attr_dev);
 }
 
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
+/**
+ * framebuffer_alloc - creates a new frame buffer info structure
+ *
+ * @size: size of driver private data, can be zero
+ * @dev: pointer to the device for this fb, can be NULL
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
+}
+
+/**
+ * framebuffer_release - marks the structure available for freeing
+ * 
+ * @fb_info: frame buffer info structure
+ *
+ * Drop the reference count of the class_device embedded in the
+ * framebuffer info structure.
+ * 
+ */
+void framebuffer_release(struct fb_info *fb_info) {
+	class_device_put(&fb_info->class_dev);
 }
 
 /**
@@ -1315,6 +1325,9 @@
 			break;
 	fb_info->node = i;
 	
+	if (fb_add_class_device(fb_info))
+		return -EINVAL;
+	
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
 		if (fb_info->pixmap.addr) {
@@ -1352,7 +1365,6 @@
 	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
 			S_IFCHR | S_IRUGO | S_IWUGO, "fb/%d", i);
 
-	fb_add_class_device(i, fb_info->dev);
 	return 0;
 }
 
@@ -1381,7 +1393,7 @@
 		kfree(fb_info->pixmap.addr);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
-	fb_remove_class_device(i);
+	class_device_del(&fb_info->class_dev);
 	return 0;
 }
 
@@ -1491,6 +1503,8 @@
 
 EXPORT_SYMBOL(register_framebuffer);
 EXPORT_SYMBOL(unregister_framebuffer);
+EXPORT_SYMBOL(framebuffer_alloc);
+EXPORT_SYMBOL(framebuffer_release);
 EXPORT_SYMBOL(num_registered_fb);
 EXPORT_SYMBOL(registered_fb);
 EXPORT_SYMBOL(fb_prepare_logo);


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Una donna sposa un uomo sperando che cambi, e lui non cambiera`. Un
uomo sposa una donna sperando che non cambi, e lei cambiera`.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
