From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Thu, 24 Feb 2005 19:04:44 -0500
Message-ID: <9e47339105022416047f90a805@mail.gmail.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com>
	 <200502190559.07162.adaplas@hotpop.com>
	 <200502220713.15937.adaplas@hotpop.com>
	 <200502220715.13335.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_685_25548725.1109289884980"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4Syh-0003rE-GJ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Feb 2005 16:05:07 -0800
Received: from rproxy.gmail.com ([64.233.170.201])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D4SyL-00084N-OK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Feb 2005 16:05:07 -0800
Received: by rproxy.gmail.com with SMTP id z35so975363rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 24 Feb 2005 16:04:45 -0800 (PST)
In-Reply-To: <200502220715.13335.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@www.infradead.org>

------=_Part_685_25548725.1109289884980
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 22 Feb 2005 07:15:13 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> > Attached are 2 test patches.  The first (fbsysfs.diff) is Jon's practically
> > unmodified code, but with cosmetic changes and the mode copy reverted back
> > to mode pointer (I prefer the pointer since it will crash rather than
> > silently fail if there's a bug, besides consuming less memory).
> >
> > The second patch (fbcon-new-modelist.diff) adds a new event,
> > FB_EVENT_NEW_MODELIST.  This is sent by store_modes() via
> > fb_new_modelist(). The event is captured by fbcon and resizes all consoles
> > based on the new modelist.

What are you diffing this against? I don't have an nvidia fbdev driver
in my Linus bk tree.

Can you regenerate against Linus bk plus my sysfs.patch?

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_685_25548725.1109289884980
Content-Type: text/x-diff; name="sysfs.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sysfs.patch"

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c=092005-02-18 02:17:45 -05:00
+++ b/drivers/video/console/fbcon.c=092005-02-18 02:17:45 -05:00
@@ -681,6 +681,8 @@
 =09=09=09  struct fb_var_screeninfo *var,
 =09=09=09  struct fb_info *info)
 {
+=09struct fb_videomode *mode;
+
 =09disp->xres_virtual =3D var->xres_virtual;
 =09disp->yres_virtual =3D var->yres_virtual;
 =09disp->bits_per_pixel =3D var->bits_per_pixel;
@@ -693,17 +695,18 @@
 =09disp->green =3D var->green;
 =09disp->blue =3D var->blue;
 =09disp->transp =3D var->transp;
-=09disp->mode =3D fb_match_mode(var, &info->modelist);
-=09if (disp->mode =3D=3D NULL)
+=09mode =3D fb_match_mode(var, &info->modelist);
+=09if (mode =3D=3D NULL)
 =09=09/* This should not happen */
 =09=09return -EINVAL;
+=09disp->mode =3D *mode;
 =09return 0;
 }
=20
 static void display_to_var(struct fb_var_screeninfo *var,
 =09=09=09   struct display *disp)
 {
-=09fb_videomode_to_var(var, disp->mode);
+=09fb_videomode_to_var(var, &disp->mode);
 =09var->xres_virtual =3D disp->xres_virtual;
 =09var->yres_virtual =3D disp->yres_virtual;
 =09var->bits_per_pixel =3D disp->bits_per_pixel;
@@ -2605,9 +2608,9 @@
 =09=09if (fb_info !=3D info)
 =09=09=09continue;
 =09=09p =3D &fb_display[i];
-=09=09if (!p || !p->mode)
+=09=09if (!p)
 =09=09=09continue;
-=09=09if (fb_mode_is_equal(p->mode, mode)) {
+=09=09if (fb_mode_is_equal(&p->mode, mode)) {
 =09=09=09found =3D 1;
 =09=09=09break;
 =09=09}
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h=092005-02-18 02:17:45 -05:00
+++ b/drivers/video/console/fbcon.h=092005-02-18 02:17:45 -05:00
@@ -45,7 +45,7 @@
     struct fb_bitfield green;
     struct fb_bitfield blue;
     struct fb_bitfield transp;
-    struct fb_videomode *mode;
+    struct fb_videomode mode;
 };
=20
 struct fbcon_ops {
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c=092005-02-18 02:17:45 -05:00
+++ b/drivers/video/fbmem.c=092005-02-18 02:17:45 -05:00
@@ -1058,7 +1058,6 @@
 register_framebuffer(struct fb_info *fb_info)
 {
 =09int i;
-=09struct class_device *c;
 =09struct fb_event event;
=20
 =09if (num_registered_fb =3D=3D FB_MAX)
@@ -1069,13 +1068,15 @@
 =09=09=09break;
 =09fb_info->node =3D i;
=20
-=09c =3D class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
+=09fb_info->class_device =3D class_simple_device_add(fb_class, MKDEV(FB_MA=
JOR, i),
 =09=09=09=09    fb_info->device, "fb%d", i);
-=09if (IS_ERR(c)) {
+=09if (IS_ERR(fb_info->class_device)) {
 =09=09/* Not fatal */
-=09=09printk(KERN_WARNING "Unable to create class_device for framebuffer %=
d; errno =3D %ld\n", i, PTR_ERR(c));
-=09}
-=09
+=09=09printk(KERN_WARNING "Unable to create class_device for framebuffer %=
d; errno =3D %ld\n", i, PTR_ERR(fb_info->class_device));
+=09=09fb_info->class_device =3D NULL;
+=09} else
+=09=09fb_init_class_device(fb_info);
+
 =09if (fb_info->pixmap.addr =3D=3D NULL) {
 =09=09fb_info->pixmap.addr =3D kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
 =09=09if (fb_info->pixmap.addr) {
@@ -1134,6 +1135,7 @@
 =09fb_destroy_modelist(&fb_info->modelist);
 =09registered_fb[i]=3DNULL;
 =09num_registered_fb--;
+=09fb_cleanup_class_device(fb_info);
 =09class_simple_device_remove(MKDEV(FB_MAJOR, i));
 =09return 0;
 }
diff -Nru a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c=092005-02-18 02:17:45 -05:00
+++ b/drivers/video/fbsysfs.c=092005-02-18 02:17:45 -05:00
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
@@ -71,6 +73,276 @@
 {
 =09kfree(info);
 }
-
 EXPORT_SYMBOL(framebuffer_release);
-EXPORT_SYMBOL(framebuffer_alloc);
+
+static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var=
)
+{
+=09int err;
+=09
+=09var->activate |=3D FB_ACTIVATE_FORCE;
+=09acquire_console_sem();
+=09fb_info->flags |=3D FBINFO_MISC_USEREVENT;
+=09err =3D fb_set_var(fb_info, var);
+=09fb_info->flags &=3D ~FBINFO_MISC_USEREVENT;
+=09release_console_sem();
+=09if (err)
+=09=09return err;
+=09return 0;
+}
+
+static int mode_string(char *buf, unsigned int offset, const struct fb_vid=
eomode *mode)
+{
+=09char m =3D 'U';
+=09if (mode->flag & FB_MODE_IS_DETAILED)
+=09=09m =3D 'D';
+=09if (mode->flag & FB_MODE_IS_VESA)
+=09=09m =3D 'V';
+=09if (mode->flag & FB_MODE_IS_STANDARD)
+=09=09m =3D 'S';
+=09return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d-%d\n", m, m=
ode->xres, mode->yres, mode->refresh);
+}
+
+static ssize_t store_mode(struct class_device *class_device, const char * =
buf, size_t count)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09char mstr[100];
+=09struct fb_var_screeninfo var;
+=09struct fb_modelist *modelist;
+=09struct fb_videomode *mode;
+=09struct list_head *pos;
+=09size_t i;
+=09int err;
+
+=09memset(&var, 0, sizeof(var));
+
+=09list_for_each(pos, &fb_info->modelist) {
+=09=09modelist =3D list_entry(pos, struct fb_modelist, list);
+=09=09mode =3D &modelist->mode;
+=09=09i =3D mode_string(mstr, 0, mode);
+=09=09if (strncmp(mstr, buf, max(count, i)) =3D=3D 0) {
+
+=09=09=09var =3D fb_info->var;
+=09=09=09fb_videomode_to_var(&var, mode);
+=09=09=09if ((err =3D activate(fb_info, &var)))
+=09=09=09=09return err;
+=09=09=09fb_info->mode =3D mode;
+=09=09=09return count;
+=09=09}
+=09}
+=09return -EINVAL;
+}
+
+static ssize_t show_mode(struct class_device *class_device, char *buf)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+
+=09if (!fb_info->mode)
+=09=09return 0;
+
+=09return mode_string(buf, 0, fb_info->mode);
+}
+
+static ssize_t store_modes(struct class_device *class_device, const char *=
 buf, size_t count)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09int i =3D count / sizeof(struct fb_videomode);
+=09if (i * sizeof(struct fb_videomode) !=3D count)
+=09=09return -EINVAL;
+
+=09fb_destroy_modelist(&fb_info->modelist);
+=09fb_videomode_to_modelist((struct fb_videomode *)buf, i, &fb_info->model=
ist);
+
+=09return 0;
+}
+
+static ssize_t show_modes(struct class_device *class_device, char *buf)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09unsigned int i;
+=09struct list_head *pos;
+=09struct fb_modelist *modelist;
+=09const struct fb_videomode *mode;
+
+=09i =3D 0;
+=09list_for_each(pos, &fb_info->modelist) {
+=09=09modelist =3D list_entry(pos, struct fb_modelist, list);
+=09=09mode =3D &modelist->mode;
+=09=09i +=3D mode_string(buf, i, mode);
+=09}
+=09return i;
+}
+
+static ssize_t store_bpp(struct class_device *class_device, const char * b=
uf, size_t count)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09struct fb_var_screeninfo var;
+=09char ** last =3D NULL;
+=09int err;
+
+=09var =3D fb_info->var;
+=09var.bits_per_pixel =3D simple_strtoul(buf, last, 0);
+=09if ((err =3D activate(fb_info, &var)))
+=09=09return err;
+=09return count;
+}
+
+static ssize_t show_bpp(struct class_device *class_device, char *buf)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->var.bits_per_pixel);
+}
+
+static ssize_t store_virtual(struct class_device *class_device, const char=
 * buf, size_t count)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09struct fb_var_screeninfo var;
+=09char *last =3D NULL;
+=09int err;
+
+=09var =3D fb_info->var;
+=09var.xres_virtual =3D simple_strtoul(buf, &last, 0);
+=09last++;
+=09if (last - buf >=3D count)
+=09=09return -EINVAL;
+=09var.yres_virtual =3D simple_strtoul(last, &last, 0);
+=09printk(KERN_ERR "fb: xres %d yres %d\n", var.xres_virtual, var.yres_vir=
tual);
+=09
+=09if ((err =3D activate(fb_info, &var)))
+=09=09return err;
+=09return count;
+}
+
+static ssize_t show_virtual(struct class_device *class_device, char *buf)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xres_virtual, f=
b_info->var.xres_virtual);
+}
+
+static ssize_t store_cmap(struct class_device *class_device, const char * =
buf, size_t count)
+{
+//=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class=
_device);
+=09return 0;
+}
+
+static ssize_t show_cmap(struct class_device *class_device, char *buf)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09unsigned int offset =3D 0, i;
+=09
+=09if (!fb_info->cmap.red || !fb_info->cmap.blue || fb_info->cmap.green ||=
 fb_info->cmap.transp)
+=09=09return -EINVAL;
+=09
+=09for (i =3D 0; i < fb_info->cmap.len; i++) {
+=09=09offset +=3D snprintf(buf, PAGE_SIZE - offset, "%d,%d,%d,%d,%d\n", i =
+ fb_info->cmap.start,
+=09=09=09=09   fb_info->cmap.red[i], fb_info->cmap.blue[i], fb_info->cmap.=
green[i],=20
+=09=09=09=09   fb_info->cmap.transp[i]);=20
+=09}
+=09return offset;
+}
+
+static ssize_t store_blank(struct class_device *class_device, const char *=
 buf, size_t count)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09char *last =3D NULL;
+=09int err;
+
+=09acquire_console_sem();
+=09fb_info->flags |=3D FBINFO_MISC_USEREVENT;
+=09err =3D fb_blank(fb_info, simple_strtoul(buf, &last, 0));
+=09fb_info->flags &=3D ~FBINFO_MISC_USEREVENT;
+=09release_console_sem();
+=09if (err < 0)
+=09=09return err;
+=09return count;
+}
+
+static ssize_t show_blank(struct class_device *class_device, char *buf)
+{
+//=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class=
_device);
+=09return 0;
+}
+
+static ssize_t store_console(struct class_device *class_device, const char=
 * buf, size_t count)
+{
+//=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class=
_device);
+=09return 0;
+}
+
+static ssize_t show_console(struct class_device *class_device, char *buf)
+{
+//=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class=
_device);
+=09return 0;
+}
+
+static ssize_t store_cursor(struct class_device *class_device, const char =
* buf, size_t count)
+{
+//=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class=
_device);
+=09return 0;
+}
+
+static ssize_t show_cursor(struct class_device *class_device, char *buf)
+{
+//=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class=
_device);
+=09return 0;
+}
+
+static ssize_t store_pan(struct class_device *class_device, const char * b=
uf, size_t count)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09struct fb_var_screeninfo var;
+=09char *last =3D NULL;
+=09int err;
+
+=09var =3D fb_info->var;
+=09var.xoffset =3D simple_strtoul(buf, &last, 0);
+=09last++;
+=09if (last - buf >=3D count)
+=09=09return -EINVAL;
+=09var.yoffset =3D simple_strtoul(last, &last, 0);
+=09
+=09acquire_console_sem();
+=09err =3D fb_pan_display(fb_info, &var);
+=09release_console_sem();
+=09
+=09if (err < 0)
+=09=09return err;
+=09return count;
+}
+
+static ssize_t show_pan(struct class_device *class_device, char *buf)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xoffset, fb_inf=
o->var.xoffset);
+}
+
+struct class_device_attribute class_device_attrs[] =3D {
+=09__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
+=09__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
+=09__ATTR(color_map, S_IRUGO|S_IWUSR, show_cmap, store_cmap),
+=09__ATTR(console, S_IRUGO|S_IWUSR, show_console, store_console),
+=09__ATTR(cursor, S_IRUGO|S_IWUSR, show_cursor, store_cursor),
+=09__ATTR(mode, S_IRUGO|S_IWUSR, show_mode, store_mode),
+=09__ATTR(modes, S_IRUGO|S_IWUSR, show_modes, store_modes),
+=09__ATTR(pan, S_IRUGO|S_IWUSR, show_pan, store_pan),
+=09__ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual),
+};
+
+int fb_init_class_device(struct fb_info *fb_info)
+{
+=09unsigned int i;
+=09class_set_devdata(fb_info->class_device, fb_info);
+=09
+=09for (i =3D 0; i < sizeof(class_device_attrs)/sizeof(class_device_attrs[=
0]); i++)
+=09=09class_device_create_file(fb_info->class_device, &class_device_attrs[=
i]);
+=09return 0;
+}
+
+void fb_cleanup_class_device(struct fb_info *fb_info)
+{
+=09unsigned int i;
+
+=09for (i =3D 0; i < sizeof(class_device_attrs)/sizeof(class_device_attrs[=
0]); i++)
+=09=09class_device_remove_file(fb_info->class_device, &class_device_attrs[=
i]);
+}
+
+
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h=092005-02-18 02:17:45 -05:00
+++ b/include/linux/fb.h=092005-02-18 02:17:45 -05:00
@@ -712,8 +712,10 @@
 =09struct fb_pixmap sprite;=09/* Cursor hardware mapper */
 =09struct fb_cmap cmap;=09=09/* Current cmap */
 =09struct list_head modelist;      /* mode list */
+=09struct fb_videomode *mode;=09/* current mode */
 =09struct fb_ops *fbops;
 =09struct device *device;
+=09struct class_device *class_device; /* sysfs per device attrs */
 #ifdef CONFIG_FB_TILEBLITTING
 =09struct fb_tile_ops *tileops;    /* Tile Blitting */
 #endif
@@ -830,6 +832,8 @@
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
+extern int fb_init_class_device(struct fb_info *fb_info);
+extern void fb_cleanup_class_device(struct fb_info *head);
=20
 /* drivers/video/fbmon.c */
 #define FB_MAXTIMINGS=09=090

------=_Part_685_25548725.1109289884980--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
