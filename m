From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Patch to add mode setting to sysfs
Date: Wed, 16 Feb 2005 22:47:58 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502162238570.25965@pentafluge.infradead.org>
References: <9e4733910502161430ff1dad1@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1Xxl-0006yE-H1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:48:05 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1Xxk-000624-BZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:48:05 -0800
In-Reply-To: <9e4733910502161430ff1dad1@mail.gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


Great work!!!! I have been also working on a sysfs patch. We can merge are 
work. I have a few more features I want to add to my sysfs patch. Like 
allowing a driver to pass in special feature to be exported via sysfs.
Here is what I have currently. Eventually [un]register_framebuffer_sysfs
would become apart of framebuffer_alloc. Well I work one some more stuff.


diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
--- linus-2.6/drivers/video/fbmem.c	2005-01-24 09:43:47.000000000 -0800
+++ fbdev-2.6/drivers/video/fbmem.c	2005-02-11 12:42:35.000000000 -0800
@@ -1042,8 +1042,6 @@
 #endif
 };
 
-static struct class_simple *fb_class;
-
 /**
  *	register_framebuffer - registers a frame buffer device
  *	@fb_info: frame buffer info structure
@@ -1057,10 +1055,9 @@
 int
 register_framebuffer(struct fb_info *fb_info)
 {
-	int i;
-	struct class_device *c;
 	struct fb_event event;
-
+	int i;
+	
 	if (num_registered_fb == FB_MAX)
 		return -ENXIO;
 	num_registered_fb++;
@@ -1069,13 +1066,8 @@
 			break;
 	fb_info->node = i;
 
-	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
-				    fb_info->device, "fb%d", i);
-	if (IS_ERR(c)) {
-		/* Not fatal */
-		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(c));
-	}
-	
+	register_framebuffer_sysfs(fb_info);
+
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
 		if (fb_info->pixmap.addr) {
@@ -1134,7 +1126,7 @@
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
-	class_simple_device_remove(MKDEV(FB_MAJOR, i));
+	unregister_framebuffer_sysfs(fb_info);
 	return 0;
 }
 
@@ -1197,11 +1189,7 @@
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
 
-	fb_class = class_simple_create(THIS_MODULE, "graphics");
-	if (IS_ERR(fb_class)) {
-		printk(KERN_WARNING "Unable to create fb class; errno = %ld\n", PTR_ERR(fb_class));
-		fb_class = NULL;
-	}
+	fb_sysfs_init();
 	return 0;
 }
 subsys_initcall(fbmem_init);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbsysfs.c fbdev-2.6/drivers/video/fbsysfs.c
--- linus-2.6/drivers/video/fbsysfs.c	2005-02-11 13:37:28.000000000 -0800
+++ fbdev-2.6/drivers/video/fbsysfs.c	2005-02-11 15:04:12.000000000 -0800
@@ -15,9 +15,130 @@
  * are converted to use it a sysfsification will open OOPSable races.
  */
 
+#include <linux/config.h>
+#include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/sysfs.h>
 #include <linux/fb.h>
 
+/*
+ * Graphics Class handling
+ */
+#define to_fb_info(class) container_of(class, struct fb_info, class_dev)
+
+static void graphics_class_release(struct class_device *dev)
+{
+	// struct fb_info *info = class_get_devdata(dev);
+	struct fb_info *info = to_fb_info(dev);
+
+	fb_dealloc_cmap(&info->cmap);
+	kfree(info);
+}
+
+struct class graphics_class = {
+	.name		= "graphics",
+	.release	= &graphics_class_release,
+};
+
+int __init fb_sysfs_init(void)
+{
+	return class_register(&graphics_class);
+}
+
+/*
+ * Framebuffer Device handling
+ */
+static ssize_t show_fbdev(struct class_device *dev, char *buf)
+{
+	//struct fb_info *info = class_get_devdata(dev);
+	struct fb_info *info = to_fb_info(dev);
+
+	return sprintf(buf, "%u:%u\n", FB_MAJOR, info->node);
+}
+
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_fbdev, NULL);
+
+static ssize_t show_name(struct class_device *dev, char *buf)
+{
+	struct fb_info *info = to_fb_info(dev);
+
+	return sprintf(buf, "%s\n", info->fix.id);
+}
+
+static CLASS_DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static struct class_device_attribute *frame_class_device_attributes[] = {
+	&class_device_attr_dev,
+	&class_device_attr_name,
+};
+
+
+// Mode list handling
+/* generate a read-only statistics attribute */
+static ssize_t show_resolution(struct class_device *dev, char *buf)
+{
+	return 0;
+}
+
+static CLASS_DEVICE_ATTR(mode, S_IRUGO, show_resolution, NULL);
+
+static struct attribute *frame_attrs[] = {
+	&class_device_attr_dev.attr,
+	&class_device_attr_name.attr,
+	NULL
+};
+
+// Register sysfs.
+int register_framebuffer_sysfs(struct fb_info *info)
+{
+	struct attribute_group *modes_group;
+	int rc, size, i;
+
+	snprintf(info->class_dev.class_id, BUS_ID_SIZE, "fb%d", info->node);
+	class_set_devdata(&info->class_dev, info);
+	info->class_dev.class = &graphics_class;
+
+	rc = class_device_register(&info->class_dev);
+	if (rc)
+		return rc;
+	info->class_dev.dev = info->device;
+
+	for (i = 0; i < ARRAY_SIZE(frame_class_device_attributes); i++) {
+		rc = class_device_create_file(&info->class_dev, frame_class_device_attributes[i]);
+		if (unlikely(rc)) {
+			/* Not fatal */
+			printk(KERN_WARNING "Unable to create device file for framebuffer %d\n", info->node);
+		}
+	}
+	info->class_dev.dev = info->device;
+
+	size = sizeof(modes_group) + strlen("modes");
+	modes_group = kmalloc(size, GFP_KERNEL);
+	if (modes_group) {
+		memset(modes_group, 0, size);
+		modes_group->name = (char *)(modes_group + sizeof(modes_group));
+		sprintf(modes_group->name, "modes");
+		modes_group->attrs = frame_attrs;
+		rc = sysfs_create_group(&info->class_dev.kobj, modes_group);
+		if (rc)
+			kfree(modes_group);
+	}
+	return 0;
+}
+
+void unregister_framebuffer_sysfs(struct fb_info *info)
+{
+	int i;
+
+	if (info->class_dev.dev == info->device) {
+		//sysfs_remove_group(&info->class_dev.kobj, &modes_group);
+
+		for (i = 0; i < ARRAY_SIZE(frame_class_device_attributes); i++)
+			class_device_remove_file(&info->class_dev, frame_class_device_attributes[i]);
+		class_device_unregister(&info->class_dev);
+	}
+}
+
 /**
  * framebuffer_alloc - creates a new frame buffer info structure
  *
@@ -47,16 +168,14 @@
 		return NULL;
 	memset(p, 0, fb_info_size + size);
 	info = (struct fb_info *) p;
-
+	info->device = dev;
 	if (size)
 		info->par = p + fb_info_size;
-
-	info->device = dev;
-
 	return info;
 #undef PADDING
 #undef BYTES_PER_LONG
 }
+EXPORT_SYMBOL(framebuffer_alloc);
 
 /**
  * framebuffer_release - marks the structure available for freeing
@@ -69,8 +188,8 @@
  */
 void framebuffer_release(struct fb_info *info)
 {
-	kfree(info);
+	unregister_framebuffer_sysfs(info);
 }
-
 EXPORT_SYMBOL(framebuffer_release);
-EXPORT_SYMBOL(framebuffer_alloc);
+
+MODULE_LICENSE("GPL");
diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/linux/fb.h fbdev-2.6/include/linux/fb.h
--- linus-2.6/include/linux/fb.h	2005-02-11 16:57:25.000000000 -0800
+++ fbdev-2.6/include/linux/fb.h	2005-02-11 09:59:33.000000000 -0800
@@ -704,6 +704,7 @@
 struct fb_info {
 	int node;
 	int flags;
+	struct class_device class_dev;	/* Sysfs support */
 	struct fb_var_screeninfo var;	/* Current var */
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */
@@ -827,9 +828,22 @@
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 
+/* drivers/video/fbcmap.c */
+extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);
+extern void fb_dealloc_cmap(struct fb_cmap *cmap);
+extern int fb_copy_cmap(struct fb_cmap *from, struct fb_cmap *to);
+extern int fb_cmap_to_user(struct fb_cmap *from, struct fb_cmap_user *to);
+extern int fb_set_cmap(struct fb_cmap *cmap, struct fb_info *fb_info);
+extern int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *fb_info);
+extern struct fb_cmap *fb_default_cmap(int len);
+extern void fb_invert_cmaps(void);
+
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
+extern int register_framebuffer_sysfs(struct fb_info *info);
+extern void unregister_framebuffer_sysfs(struct fb_info *info);
+extern int fb_sysfs_init(void);
 
 /* drivers/video/fbmon.c */
 #define FB_MAXTIMINGS		0
@@ -861,35 +875,6 @@
 extern void fb_destroy_modedb(struct fb_videomode *modedb);
 
 /* drivers/video/modedb.c */
-#define VESA_MODEDB_SIZE 34
-extern const struct fb_videomode vesa_modes[];
-extern void fb_var_to_videomode(struct fb_videomode *mode,
-				struct fb_var_screeninfo *var);
-extern void fb_videomode_to_var(struct fb_var_screeninfo *var,
-				struct fb_videomode *mode);
-extern int fb_mode_is_equal(struct fb_videomode *mode1,
-			    struct fb_videomode *mode2);
-extern int fb_add_videomode(struct fb_videomode *mode, struct list_head *head);
-extern void fb_delete_videomode(struct fb_videomode *mode,
-				struct list_head *head);
-extern struct fb_videomode *fb_match_mode(struct fb_var_screeninfo *var,
-					  struct list_head *head);
-extern struct fb_videomode *fb_find_best_mode(struct fb_var_screeninfo *var,
-					      struct list_head *head);
-extern void fb_destroy_modelist(struct list_head *head);
-extern void fb_videomode_to_modelist(struct fb_videomode *modedb, int num,
-				     struct list_head *head);
-
-/* drivers/video/fbcmap.c */
-extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);
-extern void fb_dealloc_cmap(struct fb_cmap *cmap);
-extern int fb_copy_cmap(struct fb_cmap *from, struct fb_cmap *to);
-extern int fb_cmap_to_user(struct fb_cmap *from, struct fb_cmap_user *to);
-extern int fb_set_cmap(struct fb_cmap *cmap, struct fb_info *fb_info);
-extern int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *fb_info);
-extern struct fb_cmap *fb_default_cmap(int len);
-extern void fb_invert_cmaps(void);
-
 struct fb_videomode {
 	const char *name;	/* optional */
 	u32 refresh;		/* optional */
@@ -912,6 +897,25 @@
 	struct fb_videomode mode;
 };
 
+#define VESA_MODEDB_SIZE 34
+extern const struct fb_videomode vesa_modes[];
+
+extern void fb_var_to_videomode(struct fb_videomode *mode,
+				struct fb_var_screeninfo *var);
+extern void fb_videomode_to_var(struct fb_var_screeninfo *var,
+				struct fb_videomode *mode);
+extern int fb_mode_is_equal(struct fb_videomode *mode1,
+			    struct fb_videomode *mode2);
+extern int fb_add_videomode(struct fb_videomode *mode, struct list_head *head);
+extern void fb_delete_videomode(struct fb_videomode *mode,
+				struct list_head *head);
+extern struct fb_videomode *fb_match_mode(struct fb_var_screeninfo *var,
+					  struct list_head *head);
+extern struct fb_videomode *fb_find_best_mode(struct fb_var_screeninfo *var,
+					      struct list_head *head);
+extern void fb_destroy_modelist(struct list_head *head);
+extern void fb_videomode_to_modelist(struct fb_videomode *modedb, int num,
+				     struct list_head *head);
 extern int fb_find_mode(struct fb_var_screeninfo *var,
 			struct fb_info *info, const char *mode_option,
 			const struct fb_videomode *db,


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
