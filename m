From: Jon Smirl <jonsmirl@gmail.com>
Subject: Patch to add mode setting to sysfs
Date: Wed, 16 Feb 2005 17:30:56 -0500
Message-ID: <9e4733910502161430ff1dad1@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1XhN-00060p-4d
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:31:09 -0800
Received: from rproxy.gmail.com ([64.233.170.203])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1XhM-0004Ba-FB
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:31:09 -0800
Received: by rproxy.gmail.com with SMTP id z35so89222rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Feb 2005 14:30:56 -0800 (PST)
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
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

This is a first pass at adding two new sysfs attributes to
/sys/class/graphics/fb0 for setting modes. There are two attributes:
modes which contains a list of valid modes, and mode which is the
current mode. To switch modes echo one of the entries from the modes
list to the mode attribute.
The D,V,S on the modes represents Detailed, Vesa, Standard from the DDC info.

modes is root writable. It can also be used to set the list of modes.
For example a /etc file could add modes that are not in the monitor's
DDC.

mode is user writable. PAM would set ownership of mode at user login
time. This provides a safe way  for a user to set the mode without
being root. You can only set the mode to one of the modes on the list.

If this code looks good I'll do another pass that adds some more
features and makes it more robust.

-- 
Jon Smirl
jonsmirl@gmail.com


diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2005-02-16 17:20:32 -05:00
+++ b/drivers/video/fbmem.c	2005-02-16 17:20:32 -05:00
@@ -1058,7 +1058,6 @@
 register_framebuffer(struct fb_info *fb_info)
 {
 	int i;
-	struct class_device *c;
 	struct fb_event event;
 
 	if (num_registered_fb == FB_MAX)
@@ -1069,13 +1068,15 @@
 			break;
 	fb_info->node = i;
 
-	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
+	fb_info->class_device = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
 				    fb_info->device, "fb%d", i);
-	if (IS_ERR(c)) {
+	if (IS_ERR(fb_info->class_device)) {
 		/* Not fatal */
-		printk(KERN_WARNING "Unable to create class_device for framebuffer
%d; errno = %ld\n", i, PTR_ERR(c));
-	}
-	
+		printk(KERN_WARNING "Unable to create class_device for framebuffer
%d; errno = %ld\n", i, PTR_ERR(fb_info->class_device));
+		fb_info->class_device = NULL;
+	} else
+		fb_init_class_device(fb_info);
+
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
 		if (fb_info->pixmap.addr) {
diff -Nru a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c	2005-02-16 17:20:32 -05:00
+++ b/drivers/video/fbsysfs.c	2005-02-16 17:20:32 -05:00
@@ -17,6 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/fb.h>
+#include <linux/console.h>
 
 /**
  * framebuffer_alloc - creates a new frame buffer info structure
@@ -57,6 +58,7 @@
 #undef PADDING
 #undef BYTES_PER_LONG
 }
+EXPORT_SYMBOL(framebuffer_alloc);
 
 /**
  * framebuffer_release - marks the structure available for freeing
@@ -71,6 +73,118 @@
 {
 	kfree(info);
 }
-
 EXPORT_SYMBOL(framebuffer_release);
-EXPORT_SYMBOL(framebuffer_alloc);
+
+static int mode_class(char *buf, int flag)
+{
+	if (flag & FB_MODE_IS_DETAILED)
+		return sprintf(buf, "D:");
+	if (flag & FB_MODE_IS_VESA)
+		return sprintf(buf, "V:");
+	if (flag & FB_MODE_IS_STANDARD)
+		return sprintf(buf, "S:");
+	return sprintf(buf, "U:");
+}
+
+static int mode_string(char *buf, const struct fb_videomode *mode)
+{
+	int i = 0;
+	i += mode_class(buf, mode->flag);
+	return i + sprintf(&buf[i], "%dx%d-%d\n", mode->xres, mode->yres,
mode->refresh);
+}
+
+static ssize_t store_mode(struct class_device *class_device, const
char * buf, size_t count)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	char mstr[100];
+	struct fb_var_screeninfo var;
+	struct fb_modelist *modelist;
+	struct fb_videomode *mode;
+	struct list_head *pos;
+	size_t i;
+	int err;
+
+	memset(&var, 0, sizeof(var));
+	
+	list_for_each(pos, &fb_info->modelist) {
+		modelist = list_entry(pos, struct fb_modelist, list);
+		mode = &modelist->mode;
+		i = mode_string(mstr, mode);
+		if (strncmp(mstr, buf, max(count, i)) == 0) {
+
+			fb_videomode_to_var(&var, mode);
+			var.activate |= FB_ACTIVATE_FORCE;
+			var.bits_per_pixel = 32;
+			acquire_console_sem();
+			fb_info->flags |= FBINFO_MISC_USEREVENT;
+			err = fb_set_var(fb_info, &var);
+			fb_info->flags &= ~FBINFO_MISC_USEREVENT;
+			release_console_sem();
+			if (err)
+				return err;
+			fb_info->mode = mode;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+
+static ssize_t show_mode(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+
+	if (!fb_info->mode)
+		return 0;
+
+	return mode_string(buf, fb_info->mode);
+}
+
+static ssize_t store_modes(struct class_device *class_device, const
char * buf, size_t count)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	int i = count / sizeof(struct fb_videomode);
+	if (i * sizeof(struct fb_videomode) != count)
+		return -EINVAL;
+
+	fb_destroy_modelist(&fb_info->modelist);
+	fb_videomode_to_modelist((struct fb_videomode *)buf, i, &fb_info->modelist);
+
+	return 0;
+}
+
+static ssize_t show_modes(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	int i;
+	struct list_head *pos;
+	struct fb_modelist *modelist;
+	const struct fb_videomode *mode;
+	
+	i = 0;
+	list_for_each(pos, &fb_info->modelist) {
+		modelist = list_entry(pos, struct fb_modelist, list);
+		mode = &modelist->mode;
+		i += mode_string(&buf[i], mode);
+	}
+	return i;
+}
+
+CLASS_DEVICE_ATTR(mode, S_IRUGO|S_IWUSR, show_mode, store_mode);
+CLASS_DEVICE_ATTR(modes, S_IRUGO|S_IWUSR, show_modes, store_modes);
+
+int fb_init_class_device(struct fb_info *fb_info)
+{
+	//INIT_LIST_HEAD(&modelist);
+	class_set_devdata(fb_info->class_device, fb_info);
+	class_device_create_file(fb_info->class_device, &class_device_attr_modes);
+	class_device_create_file(fb_info->class_device, &class_device_attr_mode);
+	return 0;
+}
+
+void fb_cleanup_class_device(struct fb_info *fb_info)
+{
+	class_device_remove_file(fb_info->class_device, &class_device_attr_modes);
+	class_device_remove_file(fb_info->class_device, &class_device_attr_mode);
+}
+
+
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2005-02-16 17:20:32 -05:00
+++ b/include/linux/fb.h	2005-02-16 17:20:32 -05:00
@@ -712,8 +712,10 @@
 	struct fb_pixmap sprite;	/* Cursor hardware mapper */
 	struct fb_cmap cmap;		/* Current cmap */
 	struct list_head modelist;      /* mode list */
+	struct fb_videomode *mode;	/* current mode */
 	struct fb_ops *fbops;
 	struct device *device;
+	struct class_device *class_device; /* sysfs per device attrs */
 #ifdef CONFIG_FB_TILEBLITTING
 	struct fb_tile_ops *tileops;    /* Tile Blitting */
 #endif
@@ -830,6 +832,8 @@
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
+extern int fb_init_class_device(struct fb_info *fb_info);
+extern void fb_cleanup_class_device(struct fb_info *head);
 
 /* drivers/video/fbmon.c */
 #define FB_MAXTIMINGS		0


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
