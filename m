From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Fri, 18 Feb 2005 02:27:42 -0500
Message-ID: <9e47339105021723274951c76c@mail.gmail.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com>
	 <200502172150.16256.adaplas@hotpop.com>
	 <9e47339105021712494955212d@mail.gmail.com>
	 <200502180804.46005.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D22YC-0007UB-JU
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 23:27:44 -0800
Received: from rproxy.gmail.com ([64.233.170.200])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D22YB-0001Im-M0
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 23:27:44 -0800
Received: by rproxy.gmail.com with SMTP id z35so591112rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 23:27:42 -0800 (PST)
In-Reply-To: <200502180804.46005.adaplas@hotpop.com>
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

Next version of sysfs patch. Fills out more attributes. Feel free to
add code for missing implementations. Modifies fbcon to copy mode
structure instead of taking a reference to it. Modular fbdev is
separate patch. Ultimately we should be able to eliminate the IOCTL
code from fb_core and move it to a compatibility module.

-- 
Jon Smirl
jonsmirl@gmail.com

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-02-18 02:17:45 -05:00
+++ b/drivers/video/console/fbcon.c	2005-02-18 02:17:45 -05:00
@@ -681,6 +681,8 @@
 			  struct fb_var_screeninfo *var,
 			  struct fb_info *info)
 {
+	struct fb_videomode *mode;
+
 	disp->xres_virtual = var->xres_virtual;
 	disp->yres_virtual = var->yres_virtual;
 	disp->bits_per_pixel = var->bits_per_pixel;
@@ -693,17 +695,18 @@
 	disp->green = var->green;
 	disp->blue = var->blue;
 	disp->transp = var->transp;
-	disp->mode = fb_match_mode(var, &info->modelist);
-	if (disp->mode == NULL)
+	mode = fb_match_mode(var, &info->modelist);
+	if (mode == NULL)
 		/* This should not happen */
 		return -EINVAL;
+	disp->mode = *mode;
 	return 0;
 }
 
 static void display_to_var(struct fb_var_screeninfo *var,
 			   struct display *disp)
 {
-	fb_videomode_to_var(var, disp->mode);
+	fb_videomode_to_var(var, &disp->mode);
 	var->xres_virtual = disp->xres_virtual;
 	var->yres_virtual = disp->yres_virtual;
 	var->bits_per_pixel = disp->bits_per_pixel;
@@ -2605,9 +2608,9 @@
 		if (fb_info != info)
 			continue;
 		p = &fb_display[i];
-		if (!p || !p->mode)
+		if (!p)
 			continue;
-		if (fb_mode_is_equal(p->mode, mode)) {
+		if (fb_mode_is_equal(&p->mode, mode)) {
 			found = 1;
 			break;
 		}
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2005-02-18 02:17:45 -05:00
+++ b/drivers/video/console/fbcon.h	2005-02-18 02:17:45 -05:00
@@ -45,7 +45,7 @@
     struct fb_bitfield green;
     struct fb_bitfield blue;
     struct fb_bitfield transp;
-    struct fb_videomode *mode;
+    struct fb_videomode mode;
 };
 
 struct fbcon_ops {
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2005-02-18 02:17:45 -05:00
+++ b/drivers/video/fbmem.c	2005-02-18 02:17:45 -05:00
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
diff -Nru a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c	2005-02-18 02:17:45 -05:00
+++ b/drivers/video/fbsysfs.c	2005-02-18 02:17:45 -05:00
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
@@ -71,6 +73,276 @@
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
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	unsigned int offset = 0, i;
+	
+	if (!fb_info->cmap.red || !fb_info->cmap.blue || fb_info->cmap.green
|| fb_info->cmap.transp)
+		return -EINVAL;
+	
+	for (i = 0; i < fb_info->cmap.len; i++) {
+		offset += snprintf(buf, PAGE_SIZE - offset, "%d,%d,%d,%d,%d\n", i +
fb_info->cmap.start,
+				   fb_info->cmap.red[i], fb_info->cmap.blue[i], fb_info->cmap.green[i], 
+				   fb_info->cmap.transp[i]); 
+	}
+	return offset;
+}
+
+static ssize_t store_blank(struct class_device *class_device, const
char * buf, size_t count)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	char *last = NULL;
+	int err;
+
+	acquire_console_sem();
+	fb_info->flags |= FBINFO_MISC_USEREVENT;
+	err = fb_blank(fb_info, simple_strtoul(buf, &last, 0));
+	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
+	release_console_sem();
+	if (err < 0)
+		return err;
+	return count;
+}
+
+static ssize_t show_blank(struct class_device *class_device, char *buf)
+{
+//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	return 0;
+}
+
+static ssize_t store_console(struct class_device *class_device, const
char * buf, size_t count)
+{
+//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	return 0;
+}
+
+static ssize_t show_console(struct class_device *class_device, char *buf)
+{
+//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	return 0;
+}
+
+static ssize_t store_cursor(struct class_device *class_device, const
char * buf, size_t count)
+{
+//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	return 0;
+}
+
+static ssize_t show_cursor(struct class_device *class_device, char *buf)
+{
+//	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	return 0;
+}
+
+static ssize_t store_pan(struct class_device *class_device, const
char * buf, size_t count)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	struct fb_var_screeninfo var;
+	char *last = NULL;
+	int err;
+
+	var = fb_info->var;
+	var.xoffset = simple_strtoul(buf, &last, 0);
+	last++;
+	if (last - buf >= count)
+		return -EINVAL;
+	var.yoffset = simple_strtoul(last, &last, 0);
+	
+	acquire_console_sem();
+	err = fb_pan_display(fb_info, &var);
+	release_console_sem();
+	
+	if (err < 0)
+		return err;
+	return count;
+}
+
+static ssize_t show_pan(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+	return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xoffset,
fb_info->var.xoffset);
+}
+
+struct class_device_attribute class_device_attrs[] = {
+	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
+	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
+	__ATTR(color_map, S_IRUGO|S_IWUSR, show_cmap, store_cmap),
+	__ATTR(console, S_IRUGO|S_IWUSR, show_console, store_console),
+	__ATTR(cursor, S_IRUGO|S_IWUSR, show_cursor, store_cursor),
+	__ATTR(mode, S_IRUGO|S_IWUSR, show_mode, store_mode),
+	__ATTR(modes, S_IRUGO|S_IWUSR, show_modes, store_modes),
+	__ATTR(pan, S_IRUGO|S_IWUSR, show_pan, store_pan),
+	__ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual),
+};
+
+int fb_init_class_device(struct fb_info *fb_info)
+{
+	unsigned int i;
+	class_set_devdata(fb_info->class_device, fb_info);
+	
+	for (i = 0; i < sizeof(class_device_attrs)/sizeof(class_device_attrs[0]); i++)
+		class_device_create_file(fb_info->class_device, &class_device_attrs[i]);
+	return 0;
+}
+
+void fb_cleanup_class_device(struct fb_info *fb_info)
+{
+	unsigned int i;
+
+	for (i = 0; i < sizeof(class_device_attrs)/sizeof(class_device_attrs[0]); i++)
+		class_device_remove_file(fb_info->class_device, &class_device_attrs[i]);
+}
+
+
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2005-02-18 02:17:45 -05:00
+++ b/include/linux/fb.h	2005-02-18 02:17:45 -05:00
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
