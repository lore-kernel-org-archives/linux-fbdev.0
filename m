From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Thu, 17 Feb 2005 15:49:25 -0500
Message-ID: <9e47339105021712494955212d@mail.gmail.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com>
	 <200502172150.16256.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1sad-0004cu-BG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 12:49:35 -0800
Received: from rproxy.gmail.com ([64.233.170.207])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1saa-0002Dm-KN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 12:49:35 -0800
Received: by rproxy.gmail.com with SMTP id z35so435834rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 12:49:27 -0800 (PST)
In-Reply-To: <200502172150.16256.adaplas@hotpop.com>
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
To: adaplas@pol.net, James Simmons <jsimmons@www.infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 17 Feb 2005 21:50:16 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> Instead of hardcoding some of the fields in var, why not
> copy it from the current var?  Ie:
> 
> var = info->var;
> fb_videomode_to_var(&var, mode);

I added this change, plus more robust error handing. Add attributes
for virtual resolution and bpp.

I also fixed fb so that it works as module.

-- 
Jon Smirl
jonsmirl@gmail.com



diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-02-17 15:46:50 -05:00
+++ b/drivers/video/Kconfig	2005-02-17 15:46:50 -05:00
@@ -5,7 +5,7 @@
 menu "Graphics support"
 
 config FB
-	bool "Support for frame buffer devices"
+	tristate "Support for frame buffer devices"
 	---help---
 	  The frame buffer device provides an abstraction for the graphics
 	  hardware. It represents the frame buffer of some video hardware and
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2005-02-17 15:46:50 -05:00
+++ b/drivers/video/Makefile	2005-02-17 15:46:50 -05:00
@@ -8,11 +8,13 @@
 obj-$(CONFIG_LOGO)		  += logo/
 obj-$(CONFIG_SYSFS)		  += backlight/
 
-obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o
fbsysfs.o modedb.o softcursor.o
+obj-$(CONFIG_FB)                  += fb.o
+fb-y                              := fbmem.o fbmon.o fbcmap.o
fbsysfs.o modedb.o softcursor.o
 # Only include macmodes.o if we have FB support and are PPC
-ifeq ($(CONFIG_FB),y)
-obj-$(CONFIG_PPC)                 += macmodes.o
+ifneq ($(CONFIG_FB),n)
+fb-$(CONFIG_PPC)                  += macmodes.o
 endif
+fb-objs                           := $(fb-y)
 
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2005-02-17 15:46:50 -05:00
+++ b/drivers/video/fbmem.c	2005-02-17 15:46:50 -05:00
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
@@ -1134,6 +1135,7 @@
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
+	fb_cleanup_class_device(fb_info);
 	class_simple_device_remove(MKDEV(FB_MAJOR, i));
 	return 0;
 }
@@ -1204,7 +1206,20 @@
 	}
 	return 0;
 }
+#ifdef MODULE
+module_init(fbmem_init);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Framebuffer base");
+
+void __exit
+fbmem_exit(void)
+{
+	class_simple_destroy(fb_class);
+}
+module_exit(fbmem_exit);
+#else
 subsys_initcall(fbmem_init);
+#endif
 
 static char *video_options[FB_MAX];
 static int ofonly;
diff -Nru a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c	2005-02-17 15:46:50 -05:00
+++ b/drivers/video/fbsysfs.c	2005-02-17 15:46:50 -05:00
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
@@ -71,6 +73,187 @@
 {
 	kfree(info);
 }
-
 EXPORT_SYMBOL(framebuffer_release);
-EXPORT_SYMBOL(framebuffer_alloc);
+
+static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
+{
+	int err;
+	
+	var->activate |= FB_ACTIVATE_FORCE;
+	acquire_console_sem();
+	fb_info->flags |= FBINFO_MISC_USEREVENT;
+	err = fb_set_var(fb_info, var);
+	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
+	release_console_sem();
+	if (err)
+		return err;
+	return 0;
+}
+
+static int mode_string(char *buf, unsigned int offset, const struct
fb_videomode *mode)
+{
+	char m = 'U';
+	if (mode->flag & FB_MODE_IS_DETAILED)
+		m = 'D';
+	if (mode->flag & FB_MODE_IS_VESA)
+		m = 'V';
+	if (mode->flag & FB_MODE_IS_STANDARD)
+		m = 'S';
+	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d-%d\n",
m, mode->xres, mode->yres, mode->refresh);
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
+		i = mode_string(mstr, 0, mode);
+		if (strncmp(mstr, buf, max(count, i)) == 0) {
+
+			var = fb_info->var;
+			fb_videomode_to_var(&var, mode);
+			if ((err = activate(fb_info, &var)))
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
+	return mode_string(buf, 0, fb_info->mode);
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
+	unsigned int i;
+	struct list_head *pos;
+	struct fb_modelist *modelist;
+	const struct fb_videomode *mode;
+
+	i = 0;
+	list_for_each(pos, &fb_info->modelist) {
+		modelist = list_entry(pos, struct fb_modelist, list);
+		mode = &modelist->mode;
+		i += mode_string(buf, i, mode);
+	}
+	return i;
+}
+
+static ssize_t store_bpp(struct class_device *class_device, const
char * buf, size_t count)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	struct fb_var_screeninfo var;
+	char ** last = NULL;
+	int err;
+
+	var = fb_info->var;
+	var.bits_per_pixel = simple_strtoul(buf, last, 0);
+	if ((err = activate(fb_info, &var)))
+		return err;
+	return count;
+}
+
+static ssize_t show_bpp(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->var.bits_per_pixel);
+}
+
+static ssize_t store_virtual(struct class_device *class_device, const
char * buf, size_t count)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	struct fb_var_screeninfo var;
+	char *last = NULL;
+	int err;
+
+	var = fb_info->var;
+	var.xres_virtual = simple_strtoul(buf, &last, 0);
+	last++;
+	if (last - buf >= count)
+		return -EINVAL;
+	var.yres_virtual = simple_strtoul(last, &last, 0);
+	printk(KERN_ERR "fb: xres %d yres %d\n", var.xres_virtual, var.yres_virtual);
+	
+	if ((err = activate(fb_info, &var)))
+		return err;
+	return count;
+}
+
+static ssize_t show_virtual(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
fb_info->var.xres_virtual, fb_info->var.xres_virtual);
+}
+
+static ssize_t store_cmap(struct class_device *class_device, const
char * buf, size_t count)
+{
+//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	return 0;
+}
+
+static ssize_t show_cmap(struct class_device *class_device, char *buf)
+{
+//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	return 0;
+}
+
+CLASS_DEVICE_ATTR(mode, S_IRUGO|S_IWUSR, show_mode, store_mode);
+CLASS_DEVICE_ATTR(modes, S_IRUGO|S_IWUSR, show_modes, store_modes);
+CLASS_DEVICE_ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp);
+CLASS_DEVICE_ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual);
+CLASS_DEVICE_ATTR(color_map, S_IRUGO|S_IWUSR, show_cmap, store_cmap);
+
+int fb_init_class_device(struct fb_info *fb_info)
+{
+	class_set_devdata(fb_info->class_device, fb_info);
+	class_device_create_file(fb_info->class_device, &class_device_attr_modes);
+	class_device_create_file(fb_info->class_device, &class_device_attr_mode);
+	class_device_create_file(fb_info->class_device,
&class_device_attr_bits_per_pixel);
+	class_device_create_file(fb_info->class_device,
&class_device_attr_virtual_size);
+	class_device_create_file(fb_info->class_device, &class_device_attr_color_map);
+	return 0;
+}
+
+void fb_cleanup_class_device(struct fb_info *fb_info)
+{
+	class_device_remove_file(fb_info->class_device, &class_device_attr_modes);
+	class_device_remove_file(fb_info->class_device, &class_device_attr_mode);
+	class_device_remove_file(fb_info->class_device,
&class_device_attr_bits_per_pixel);
+	class_device_remove_file(fb_info->class_device,
&class_device_attr_virtual_size);
+	class_device_remove_file(fb_info->class_device, &class_device_attr_color_map);
+}
+
+
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2005-02-17 15:46:50 -05:00
+++ b/include/linux/fb.h	2005-02-17 15:46:50 -05:00
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
