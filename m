From: James Simmons <jsimmons@infradead.org>
Subject: [PATCH] class device cleanup for fbdev
Date: Wed, 7 Feb 2007 19:53:09 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702071950110.9071@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEsr3-0003kT-EO for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:53:21 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEsr1-0002S1-RE
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 11:53:21 -0800
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
To: Greg KH <greg@kroah.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Let me know if this is the right approach. This patch uses the class field 
in struct device.

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 3cfea31..c3a9222 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1296,14 +1296,9 @@ register_framebuffer(struct fb_info *fb_info)
 			break;
 	fb_info->node = i;
 
-	fb_info->dev = device_create(fb_class, fb_info->device,
-				     MKDEV(FB_MAJOR, i), "fb%d", i);
-	if (IS_ERR(fb_info->dev)) {
-		/* Not fatal */
+	/* Not fatal */
+	if (fb_init_device(fb_info, fb_class))
 		printk(KERN_WARNING "Unable to create device for framebuffer %d; errno = %ld\n", i, PTR_ERR(fb_info->dev));
-		fb_info->dev = NULL;
-	} else
-		fb_init_device(fb_info);
 
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 323bdf6..ce3804c 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -505,40 +505,32 @@ static struct device_attribute device_attrs[] = {
 #endif
 };
 
-int fb_init_device(struct fb_info *fb_info)
+int fb_init_device(struct fb_info *fb_info, struct class *fb_class)
 {
-	int i, error = 0;
+	int error = 0;
 
-	dev_set_drvdata(fb_info->dev, fb_info);
+	if (!fb_class->dev_attrs)
+		fb_class->dev_attrs = device_attrs;
 
-	fb_info->class_flag |= FB_SYSFS_FLAG_ATTR;
-
-	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
-		error = device_create_file(fb_info->dev, &device_attrs[i]);
-
-		if (error)
-			break;
-	}
-
-	if (error) {
-		while (--i >= 0)
-			device_remove_file(fb_info->dev, &device_attrs[i]);
+	fb_info->dev = device_create(fb_class, fb_info->device,
+                                     MKDEV(FB_MAJOR, fb_info->node),
+				     "fb%d", fb_info->node);
+        if (IS_ERR(fb_info->dev)) {
 		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
+		fb_info->dev = NULL;
+		error = -EINVAL;
+	} else {
+		dev_set_drvdata(fb_info->dev, fb_info);
+		fb_info->class_flag |= FB_SYSFS_FLAG_ATTR;
 	}
-
-	return 0;
+	return error;
 }
 
 void fb_cleanup_device(struct fb_info *fb_info)
 {
-	unsigned int i;
-
-	if (fb_info->class_flag & FB_SYSFS_FLAG_ATTR) {
-		for (i = 0; i < ARRAY_SIZE(device_attrs); i++)
-			device_remove_file(fb_info->dev, &device_attrs[i]);
-
-		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
-	}
+	fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
+	dev_set_drvdata(fb_info->dev, NULL);
+	device_unregister(fb_info->dev);
 }
 
 #ifdef CONFIG_FB_BACKLIGHT
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 64177ec..37c4819 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -910,7 +910,7 @@ static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
-extern int fb_init_device(struct fb_info *fb_info);
+extern int fb_init_device(struct fb_info *fb_info, struct class *fb_class);
 extern void fb_cleanup_device(struct fb_info *head);
 extern void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max);
 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
