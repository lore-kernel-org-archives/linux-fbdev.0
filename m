From: James Simmons <jsimmons@infradead.org>
Subject: [PATCH] fbdev sysfs updates.
Date: Wed, 2 May 2007 20:45:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705022040200.28169@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjKlU-0005Fx-Ng for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 12:45:28 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HjKlT-0005kR-TF
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 12:45:28 -0700
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@gmail.com>


Andrew can you try this patch. The goal of the patch is to allow the 
hardware behind fbdev to be shared with out types of devices i.e 
backlight, drm, and display. Please give it a try.

Signed-Off: James Simmons <jsimmons@infradead.org>

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 2822526..2cff39c 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1268,8 +1268,6 @@ static const struct file_operations fb_fops = {
 #endif
 };
 
-struct class *fb_class;
-EXPORT_SYMBOL(fb_class);
 /**
  *	register_framebuffer - registers a frame buffer device
  *	@fb_info: frame buffer info structure
@@ -1295,14 +1293,9 @@ register_framebuffer(struct fb_info *fb_info)
 			break;
 	fb_info->node = i;
 
-	fb_info->dev = device_create(fb_class, fb_info->device,
-				     MKDEV(FB_MAJOR, i), "fb%d", i);
-	if (IS_ERR(fb_info->dev)) {
-		/* Not fatal */
+	/* Not fatal */
+	if (fb_init_device(fb_info))
 		printk(KERN_WARNING "Unable to create device for framebuffer %d; errno = %ld\n", i, PTR_ERR(fb_info->dev));
-		fb_info->dev = NULL;
-	} else
-		fb_init_device(fb_info);
 
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
@@ -1356,7 +1349,6 @@ unregister_framebuffer(struct fb_info *fb_info)
 	registered_fb[i]=NULL;
 	num_registered_fb--;
 	fb_cleanup_device(fb_info);
-	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 	event.info = fb_info;
 	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
 	return 0;
@@ -1402,11 +1394,7 @@ fbmem_init(void)
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
 
-	fb_class = class_create(THIS_MODULE, "graphics");
-	if (IS_ERR(fb_class)) {
-		printk(KERN_WARNING "Unable to create fb class; errno = %ld\n", PTR_ERR(fb_class));
-		fb_class = NULL;
-	}
+	fb_create_class();
 	return 0;
 }
 
@@ -1415,8 +1403,8 @@ module_init(fbmem_init);
 static void __exit
 fbmem_exit(void)
 {
-	class_destroy(fb_class);
 	unregister_chrdev(FB_MAJOR, "fb");
+	fb_destroy_class();
 }
 
 module_exit(fbmem_exit);
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 40c80c8..d3caba6 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -505,42 +505,99 @@ static struct device_attribute device_attrs[] = {
 #endif
 };
 
-int fb_init_device(struct fb_info *fb_info)
+struct class *fb_class;
+EXPORT_SYMBOL(fb_class);
+
+static void fb_device_release(struct device *dev)
 {
-	int i, error = 0;
+	struct fb_info *fb_info = dev_get_drvdata(dev);
 
-	dev_set_drvdata(fb_info->dev, fb_info);
+	if (fb_info) {
+		acquire_console_sem();
 
-	fb_info->class_flag |= FB_SYSFS_FLAG_ATTR;
+		// shutdown the hardware.
+		if (fb_info->fbops->fb_release)
+			fb_info->fbops->fb_release(fb_info, 0);
 
-	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
-		error = device_create_file(fb_info->dev, &device_attrs[i]);
+		fb_dealloc_cmap(&fb_info->cmap);
+		unregister_framebuffer(fb_info);
 
-		if (error)
-			break;
+		//framebuffer_release(info); Not every driver does this yet
+		release_console_sem();
 	}
+}
 
-	if (error) {
-		while (--i >= 0)
-			device_remove_file(fb_info->dev, &device_attrs[i]);
+int fb_init_device(struct fb_info *fb_info)
+{
+	int error = 0;
+
+	fb_info->dev = device_create(fb_class, fb_info->device,
+					MKDEV(FB_MAJOR, fb_info->node),
+					"fb%d", fb_info->node);
+	if (IS_ERR(fb_info->dev)) {
 		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
+		fb_info->dev = NULL;
+		error = -EINVAL;
+	} else {
+		dev_set_drvdata(fb_info->dev, fb_info);
+		fb_info->dev->release = fb_device_release;
+		fb_info->class_flag |= FB_SYSFS_FLAG_ATTR;
 	}
-
-	return 0;
+	return error;
 }
 
 void fb_cleanup_device(struct fb_info *fb_info)
 {
-	unsigned int i;
+	fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
+	dev_set_drvdata(fb_info->dev, NULL);
+	device_destroy(fb_class, MKDEV(FB_MAJOR, fb_info->node));
+}
 
-	if (fb_info->class_flag & FB_SYSFS_FLAG_ATTR) {
-		for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
-			device_remove_file(fb_info->dev, &device_attrs[i]);
+static int fb_class_suspend(struct device *dev, pm_message_t state)
+{
+	struct fb_info *fb_info = dev_get_drvdata(dev);
+	int ret = 0;
 
-		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
+	acquire_console_sem();
+	fb_set_suspend(fb_info, 1);
+	if (fb_info->fbops->fb_power)
+		ret = fb_info->fbops->fb_power(fb_info, state);
+	release_console_sem();
+	return ret;
+}
+
+static int fb_class_resume(struct device *dev)
+{
+	struct fb_info *fb_info = dev_get_drvdata(dev);
+	int ret = 0;
+
+	acquire_console_sem();
+	fb_set_suspend(fb_info, 0);
+	if (fb_info->fbops->fb_power)
+		ret = fb_info->fbops->fb_power(fb_info, PMSG_ON);
+	release_console_sem();
+	return ret;
+}
+
+void fb_create_class()
+{
+	fb_class = class_create(THIS_MODULE, "graphics");
+	if (IS_ERR(fb_class)) {
+		printk(KERN_WARNING "Unable to create fb class; errno = %ld\n", PTR_ERR(fb_class));
+		fb_class = NULL;
+	} else {
+		fb_class->suspend = fb_class_suspend;
+		fb_class->resume = fb_class_resume;
+		fb_class->dev_attrs = device_attrs;
 	}
 }
 
+void fb_destroy_class()
+{
+	if (fb_class)
+		class_destroy(fb_class);
+}
+
 #ifdef CONFIG_FB_BACKLIGHT
 /* This function generates a linear backlight curve
  *
diff --git a/include/linux/fb.h b/include/linux/fb.h
index be913ec..ab01e0e 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -629,6 +629,9 @@ struct fb_ops {
 	/* perform fb specific mmap */
 	int (*fb_mmap)(struct fb_info *info, struct vm_area_struct *vma);
 
+	/* Power management */
+	int (*fb_power)(struct fb_info *info, pm_message_t state);
+
 	/* save current hardware state */
 	void (*fb_save_state)(struct fb_info *info);
 
@@ -919,6 +922,8 @@ extern void framebuffer_release(struct fb_info *info);
 extern int fb_init_device(struct fb_info *fb_info);
 extern void fb_cleanup_device(struct fb_info *head);
 extern void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max);
+extern void fb_destroy_class(void);
+extern void fb_create_class(void);
 
 /* drivers/video/fbmon.c */
 #define FB_MAXTIMINGS		0

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
