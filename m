From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/10] fbdev: Add mode changing via sysfs
Date: Sun, 6 Mar 2005 08:16:25 +0800
Message-ID: <200503060816.28615.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7jTn-00071k-RT
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:18:43 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7jTk-00009Q-GB
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:18:43 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 12D2F736C1
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  6 Mar 2005 00:18:33 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@gmail.com>

=46rom Jon Smirl <jonsmirl@gmail.com>:

 This is a first pass at adding two new sysfs attributes to
  /sys/class/graphics/fb0 for setting modes. There are two attributes:
  modes which contains a list of valid modes, and mode which is the
  current mode. To switch modes echo one of the entries from the modes
  list to the mode attribute.
  The D,V,S on the modes represents Detailed, Vesa, Standard from the DDC i=
nfo.

  modes is root writable. It can also be used to set the list of modes.
  For example a /etc file could add modes that are not in the monitor's
  DDC.

  mode is user writable. PAM would set ownership of mode at user login
  time. This provides a safe way  for a user to set the mode without
  being root. You can only set the mode to one of the modes on the list.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
=2D--

 drivers/video/fbmem.c   |   14 +-
 drivers/video/fbsysfs.c |  307 +++++++++++++++++++++++++++++++++++++++++++=
++++-
 include/linux/fb.h      |    4
 3 files changed, 317 insertions(+), 8 deletions(-)

diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
=2D-- a/drivers/video/fbmem.c	2005-03-05 00:18:24 +08:00
+++ b/drivers/video/fbmem.c	2005-02-18 15:17:45 +08:00
@@ -1059,7 +1059,6 @@
 register_framebuffer(struct fb_info *fb_info)
 {
 	int i;
=2D	struct class_device *c;
 	struct fb_event event;
=20
 	if (num_registered_fb =3D=3D FB_MAX)
@@ -1070,13 +1069,15 @@
 			break;
 	fb_info->node =3D i;
=20
=2D	c =3D class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
+	fb_info->class_device =3D class_simple_device_add(fb_class, MKDEV(FB_MAJO=
R, i),
 				    fb_info->device, "fb%d", i);
=2D	if (IS_ERR(c)) {
+	if (IS_ERR(fb_info->class_device)) {
 		/* Not fatal */
=2D		printk(KERN_WARNING "Unable to create class_device for framebuffer %d;=
 errno =3D %ld\n", i, PTR_ERR(c));
=2D	}
=2D=09
+		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; e=
rrno =3D %ld\n", i, PTR_ERR(fb_info->class_device));
+		fb_info->class_device =3D NULL;
+	} else
+		fb_init_class_device(fb_info);
+
 	if (fb_info->pixmap.addr =3D=3D NULL) {
 		fb_info->pixmap.addr =3D kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
 		if (fb_info->pixmap.addr) {
@@ -1135,6 +1136,7 @@
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[i]=3DNULL;
 	num_registered_fb--;
+	fb_cleanup_class_device(fb_info);
 	class_simple_device_remove(MKDEV(FB_MAJOR, i));
 	return 0;
 }
diff -Nru a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
=2D-- a/drivers/video/fbsysfs.c	2004-10-19 20:21:42 +08:00
+++ b/drivers/video/fbsysfs.c	2005-02-20 07:56:25 +08:00
@@ -17,6 +17,7 @@
=20
 #include <linux/kernel.h>
 #include <linux/fb.h>
+#include <linux/console.h>
=20
 /**
  * framebuffer_alloc - creates a new frame buffer info structure
@@ -57,6 +58,7 @@
 #undef PADDING
 #undef BYTES_PER_LONG
 }
+EXPORT_SYMBOL(framebuffer_alloc);
=20
 /**
  * framebuffer_release - marks the structure available for freeing
@@ -71,6 +73,307 @@
 {
 	kfree(info);
 }
=2D
 EXPORT_SYMBOL(framebuffer_release);
=2DEXPORT_SYMBOL(framebuffer_alloc);
+
+static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
+{
+	int err;
+
+	var->activate |=3D FB_ACTIVATE_FORCE;
+	acquire_console_sem();
+	fb_info->flags |=3D FBINFO_MISC_USEREVENT;
+	err =3D fb_set_var(fb_info, var);
+	fb_info->flags &=3D ~FBINFO_MISC_USEREVENT;
+	release_console_sem();
+	if (err)
+		return err;
+	return 0;
+}
+
+static int mode_string(char *buf, unsigned int offset,
+		       const struct fb_videomode *mode)
+{
+	char m =3D 'U';
+	if (mode->flag & FB_MODE_IS_DETAILED)
+		m =3D 'D';
+	if (mode->flag & FB_MODE_IS_VESA)
+		m =3D 'V';
+	if (mode->flag & FB_MODE_IS_STANDARD)
+		m =3D 'S';
+	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d-%d\n", m, mod=
e->xres, mode->yres, mode->refresh);
+}
+
+static ssize_t store_mode(struct class_device *class_device, const char * =
buf,
+			  size_t count)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
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
+		modelist =3D list_entry(pos, struct fb_modelist, list);
+		mode =3D &modelist->mode;
+		i =3D mode_string(mstr, 0, mode);
+		if (strncmp(mstr, buf, max(count, i)) =3D=3D 0) {
+
+			var =3D fb_info->var;
+			fb_videomode_to_var(&var, mode);
+			if ((err =3D activate(fb_info, &var)))
+				return err;
+			fb_info->mode =3D mode;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+
+static ssize_t show_mode(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
+
+	if (!fb_info->mode)
+		return 0;
+
+	return mode_string(buf, 0, fb_info->mode);
+}
+
+static ssize_t store_modes(struct class_device *class_device, const char *=
 buf,
+			   size_t count)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
+	int i =3D count / sizeof(struct fb_videomode);
+	if (i * sizeof(struct fb_videomode) !=3D count)
+		return -EINVAL;
+
+	fb_destroy_modelist(&fb_info->modelist);
+	fb_videomode_to_modelist((struct fb_videomode *)buf, i,
+				 &fb_info->modelist);
+
+	return 0;
+}
+
+static ssize_t show_modes(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
+	unsigned int i;
+	struct list_head *pos;
+	struct fb_modelist *modelist;
+	const struct fb_videomode *mode;
+
+	i =3D 0;
+	list_for_each(pos, &fb_info->modelist) {
+		modelist =3D list_entry(pos, struct fb_modelist, list);
+		mode =3D &modelist->mode;
+		i +=3D mode_string(buf, i, mode);
+	}
+	return i;
+}
+
+static ssize_t store_bpp(struct class_device *class_device, const char * b=
uf,
+			 size_t count)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_var_screeninfo var;
+	char ** last =3D NULL;
+	int err;
+
+	var =3D fb_info->var;
+	var.bits_per_pixel =3D simple_strtoul(buf, last, 0);
+	if ((err =3D activate(fb_info, &var)))
+		return err;
+	return count;
+}
+
+static ssize_t show_bpp(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
+	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->var.bits_per_pixel);
+}
+
+static ssize_t store_virtual(struct class_device *class_device,
+			     const char * buf, size_t count)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_var_screeninfo var;
+	char *last =3D NULL;
+	int err;
+
+	var =3D fb_info->var;
+	var.xres_virtual =3D simple_strtoul(buf, &last, 0);
+	last++;
+	if (last - buf >=3D count)
+		return -EINVAL;
+	var.yres_virtual =3D simple_strtoul(last, &last, 0);
+	printk(KERN_ERR "fb: xres %d yres %d\n", var.xres_virtual,
+	       var.yres_virtual);
+
+	if ((err =3D activate(fb_info, &var)))
+		return err;
+	return count;
+}
+
+static ssize_t show_virtual(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
+	return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xres_virtual,
+			fb_info->var.xres_virtual);
+}
+
+static ssize_t store_cmap(struct class_device *class_device, const char * =
buf,
+			  size_t count)
+{
+//	struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+	return 0;
+}
+
+static ssize_t show_cmap(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
+	unsigned int offset =3D 0, i;
+
+	if (!fb_info->cmap.red || !fb_info->cmap.blue ||
+	    fb_info->cmap.green || fb_info->cmap.transp)
+		return -EINVAL;
+
+	for (i =3D 0; i < fb_info->cmap.len; i++) {
+		offset +=3D snprintf(buf, PAGE_SIZE - offset,
+				   "%d,%d,%d,%d,%d\n", i + fb_info->cmap.start,
+				   fb_info->cmap.red[i], fb_info->cmap.blue[i],
+				   fb_info->cmap.green[i],
+				   fb_info->cmap.transp[i]);
+	}
+	return offset;
+}
+
+static ssize_t store_blank(struct class_device *class_device, const char *=
 buf,
+			   size_t count)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
+	char *last =3D NULL;
+	int err;
+
+	acquire_console_sem();
+	fb_info->flags |=3D FBINFO_MISC_USEREVENT;
+	err =3D fb_blank(fb_info, simple_strtoul(buf, &last, 0));
+	fb_info->flags &=3D ~FBINFO_MISC_USEREVENT;
+	release_console_sem();
+	if (err < 0)
+		return err;
+	return count;
+}
+
+static ssize_t show_blank(struct class_device *class_device, char *buf)
+{
+//	struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+	return 0;
+}
+
+static ssize_t store_console(struct class_device *class_device,
+			     const char * buf, size_t count)
+{
+//	struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+	return 0;
+}
+
+static ssize_t show_console(struct class_device *class_device, char *buf)
+{
+//	struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+	return 0;
+}
+
+static ssize_t store_cursor(struct class_device *class_device,
+			    const char * buf, size_t count)
+{
+//	struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+	return 0;
+}
+
+static ssize_t show_cursor(struct class_device *class_device, char *buf)
+{
+//	struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+	return 0;
+}
+
+static ssize_t store_pan(struct class_device *class_device, const char * b=
uf,
+			 size_t count)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
+	struct fb_var_screeninfo var;
+	char *last =3D NULL;
+	int err;
+
+	var =3D fb_info->var;
+	var.xoffset =3D simple_strtoul(buf, &last, 0);
+	last++;
+	if (last - buf >=3D count)
+		return -EINVAL;
+	var.yoffset =3D simple_strtoul(last, &last, 0);
+
+	acquire_console_sem();
+	err =3D fb_pan_display(fb_info, &var);
+	release_console_sem();
+
+	if (err < 0)
+		return err;
+	return count;
+}
+
+static ssize_t show_pan(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info =3D
+		(struct fb_info *)class_get_devdata(class_device);
+	return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xoffset,
+			fb_info->var.xoffset);
+}
+
+struct class_device_attribute class_device_attrs[] =3D {
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
+	for (i =3D 0; i < ARRAY_SIZE(class_device_attrs); i++)
+		class_device_create_file(fb_info->class_device,
+					 &class_device_attrs[i]);
+	return 0;
+}
+
+void fb_cleanup_class_device(struct fb_info *fb_info)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(class_device_attrs); i++)
+		class_device_remove_file(fb_info->class_device,
+					 &class_device_attrs[i]);
+}
+
+
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
=2D-- a/include/linux/fb.h	2005-03-05 00:18:26 +08:00
+++ b/include/linux/fb.h	2005-02-18 15:17:45 +08:00
@@ -715,8 +715,10 @@
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
@@ -833,6 +835,8 @@
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
+extern int fb_init_class_device(struct fb_info *fb_info);
+extern void fb_cleanup_class_device(struct fb_info *head);
=20
 /* drivers/video/fbmon.c */
 #define FB_MAXTIMINGS		0




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
