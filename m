From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] sysfs support for fbdev
Date: Tue, 1 Mar 2005 05:00:39 -0500
Message-ID: <9e47339105030102003ee47879@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_294_31718270.1109671239236"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D64Bh-0006JT-TE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 02:01:09 -0800
Received: from rproxy.gmail.com ([64.233.170.203])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D64Be-0008Kh-8e
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 02:01:09 -0800
Received: by rproxy.gmail.com with SMTP id z35so2121560rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Mar 2005 02:01:05 -0800 (PST)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

------=_Part_294_31718270.1109671239236
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Not finished yet but here's an update.

Merges Antonio's fbcon support
Creates monitor device inside of fbdev
Creates two fbdev devices for radeonfb

The changes in class.c are temporary GregKH promises a real fix soon.
Patch is 1000+ lines so I made it an attachment.

Making the monitor device inside of the fbdev allows hotplug to work
for monitors. Now all I need to do is hook up the radeon interrupt.
When finished, unplug the monitor, get interrupt, build monitor
device, get hotplug event, helper builds modelist, set modelist to
fbdev, this causes sysfs attribute change event, hal then dbus hears
this, X rebuilds the display. Still a few weeks of work to go.

If anyone wants to help implement some of the other attributes, send
me a patch and I will incorporate it.

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_294_31718270.1109671239236
Content-Type: text/x-diff; name="sysfs.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sysfs.patch"

diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c=092005-03-01 04:49:39 -05:00
+++ b/drivers/base/class.c=092005-03-01 04:49:39 -05:00
@@ -417,8 +417,9 @@
=20
 =09/* first, register with generic layer. */
 =09kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
-=09if (parent)
+=09if (parent && !class_dev->kobj.parent)
 =09=09class_dev->kobj.parent =3D &parent->subsys.kset.kobj;
+=09class_dev->kobj.parent =3D kobject_get(class_dev->kobj.parent);
=20
 =09if ((error =3D kobject_add(&class_dev->kobj)))
 =09=09goto register_done;
@@ -467,6 +468,7 @@
 =09class_device_driver_unlink(class_dev);
 =09class_device_remove_attrs(class_dev);
=20
+=09kobject_put(class_dev->kobj.parent);
 =09kobject_del(&class_dev->kobj);
=20
 =09if (parent)
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base=
.c
--- a/drivers/video/aty/radeon_base.c=092005-03-01 04:49:39 -05:00
+++ b/drivers/video/aty/radeon_base.c=092005-03-01 04:49:39 -05:00
@@ -1802,10 +1802,8 @@
 };
=20
=20
-static int __devinit radeon_set_fbinfo (struct radeonfb_info *rinfo)
+static int __devinit radeon_set_fbinfo (struct radeonfb_info *rinfo, struc=
t fb_info *info)
 {
-=09struct fb_info *info =3D rinfo->info;
-
 =09info->par =3D rinfo;
 =09info->pseudo_palette =3D rinfo->pseudo_palette;
 =09info->flags =3D FBINFO_DEFAULT
@@ -2147,13 +2145,12 @@
 =09return count;
 }
=20
+#define to_class_device(x) container_of((x), struct class_device, kobj)
=20
 static ssize_t radeon_show_edid1(struct kobject *kobj, char *buf, loff_t o=
ff, size_t count)
 {
-=09struct device *dev =3D container_of(kobj, struct device, kobj);
-=09struct pci_dev *pdev =3D to_pci_dev(dev);
-        struct fb_info *info =3D pci_get_drvdata(pdev);
-        struct radeonfb_info *rinfo =3D info->par;
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(to_clas=
s_device(kobj));
+        struct radeonfb_info *rinfo =3D fb_info->par;
=20
 =09return radeon_show_one_edid(buf, off, count, rinfo->mon1_EDID);
 }
@@ -2161,17 +2158,15 @@
=20
 static ssize_t radeon_show_edid2(struct kobject *kobj, char *buf, loff_t o=
ff, size_t count)
 {
-=09struct device *dev =3D container_of(kobj, struct device, kobj);
-=09struct pci_dev *pdev =3D to_pci_dev(dev);
-        struct fb_info *info =3D pci_get_drvdata(pdev);
-        struct radeonfb_info *rinfo =3D info->par;
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(to_clas=
s_device(kobj));
+=09struct radeonfb_info *rinfo =3D fb_info->par;
=20
 =09return radeon_show_one_edid(buf, off, count, rinfo->mon2_EDID);
 }
=20
 static struct bin_attribute edid1_attr =3D {
 =09.attr   =3D {
-=09=09.name=09=3D "edid1",
+=09=09.name=09=3D "edid",
 =09=09.owner=09=3D THIS_MODULE,
 =09=09.mode=09=3D 0444,
 =09},
@@ -2181,7 +2176,7 @@
=20
 static struct bin_attribute edid2_attr =3D {
 =09.attr   =3D {
-=09=09.name=09=3D "edid2",
+=09=09.name=09=3D "edid",
 =09=09.owner=09=3D THIS_MODULE,
 =09=09.mode=09=3D 0444,
 =09},
@@ -2189,7 +2184,6 @@
 =09.read=09=3D radeon_show_edid2,
 };
=20
-
 static int radeonfb_pci_register (struct pci_dev *pdev,
 =09=09=09=09  const struct pci_device_id *ent)
 {
@@ -2217,6 +2211,7 @@
 =09rinfo =3D info->par;
 =09rinfo->info =3D info;=09
 =09rinfo->pdev =3D pdev;
+=09rinfo->info2.device =3D &pdev->dev;
 =09
 =09spin_lock_init(&rinfo->reg_lock);
 =09init_timer(&rinfo->lvds_timer);
@@ -2339,7 +2334,8 @@
 #endif
=20
 =09/* set all the vital stuff */
-=09radeon_set_fbinfo (rinfo);
+=09radeon_set_fbinfo (rinfo, rinfo->info);
+=09radeon_set_fbinfo (rinfo, &rinfo->info2);
=20
 =09/* Probe screen types */
 =09radeon_probe_screens(rinfo, monitor_layout, ignore_edid);
@@ -2347,12 +2343,6 @@
 =09/* Build mode list, check out panel native model */
 =09radeon_check_modes(rinfo, mode_option);
=20
-=09/* Register some sysfs stuff (should be done better) */
-=09if (rinfo->mon1_EDID)
-=09=09sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
-=09if (rinfo->mon2_EDID)
-=09=09sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
-
 =09/* save current mode regs before we switch into the new one
 =09 * so we can restore this upon __exit
 =09 */
@@ -2364,10 +2354,26 @@
 =09/* Register with fbdev layer */
 =09ret =3D register_framebuffer(info);
 =09if (ret < 0) {
-=09=09printk (KERN_ERR "radeonfb (%s): could not register framebuffer\n",
+=09=09printk (KERN_ERR "radeonfb (%s): could not register framebuffer 1\n"=
,
 =09=09=09pci_name(rinfo->pdev));
 =09=09goto err_unmap_fb;
 =09}
+=09ret =3D register_framebuffer(&rinfo->info2);
+=09if (ret < 0) {
+=09=09printk (KERN_ERR "radeonfb (%s): could not register framebuffer 2\n"=
,
+=09=09=09pci_name(rinfo->pdev));
+=09=09goto err_unmap_fb;
+=09}
+
+=09/* Register some sysfs stuff (should be done better) */
+=09if (rinfo->mon1_EDID) {
+=09=09rinfo->monitor1 =3D fb_add_child(info->class_device, info, "monitor"=
);
+=09=09class_device_create_bin_file(rinfo->monitor1, &edid1_attr);
+=09}
+=09if (rinfo->mon2_EDID) {
+=09=09rinfo->monitor2 =3D fb_add_child(rinfo->info2.class_device, &rinfo->=
info2, "monitor");
+=09=09class_device_create_bin_file(rinfo->monitor2, &edid2_attr);
+=09}
=20
 =09/* Setup Power Management capabilities */
 =09if (default_dynclk < -1) {
@@ -2424,8 +2430,6 @@
 =09return ret;
 }
=20
-
-
 static void __devexit radeonfb_pci_unregister (struct pci_dev *pdev)
 {
         struct fb_info *info =3D pci_get_drvdata(pdev);
@@ -2452,8 +2456,15 @@
 =09if (rinfo->mtrr_hdl >=3D 0)
 =09=09mtrr_del(rinfo->mtrr_hdl, 0, 0);
 #endif
-
-        unregister_framebuffer(info);
+=09if (rinfo->mon1_EDID)
+=09=09class_device_remove_bin_file(rinfo->monitor1, &edid1_attr);
+=09if (rinfo->mon2_EDID)
+=09=09class_device_remove_bin_file(rinfo->monitor1, &edid2_attr);
+=09class_device_unregister(rinfo->monitor1);
+=09class_device_unregister(rinfo->monitor2);
+=09
+=09unregister_framebuffer(info);
+        unregister_framebuffer(&rinfo->info2);
=20
         iounmap(rinfo->mmio_base);
         iounmap(rinfo->fb_base);
diff -Nru a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
--- a/drivers/video/aty/radeonfb.h=092005-03-01 04:49:39 -05:00
+++ b/drivers/video/aty/radeonfb.h=092005-03-01 04:49:39 -05:00
@@ -270,7 +270,11 @@
 };
=20
 struct radeonfb_info {
+=09struct fb_info=09=09info2;
 =09struct fb_info=09=09*info;
+=09
+=09struct class_device =09*monitor1;
+=09struct class_device =09*monitor2;
=20
 =09struct radeon_regs =09state;
 =09struct radeon_regs=09init_state;
diff -Nru a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit=
.c
--- a/drivers/video/console/bitblit.c=092005-03-01 04:49:39 -05:00
+++ b/drivers/video/console/bitblit.c=092005-03-01 04:49:39 -05:00
@@ -39,7 +39,7 @@
 {
 =09int attribute =3D 0;
=20
-=09if (fb_get_color_depth(info) =3D=3D 1) {
+=09if (fb_get_color_depth(&info->var) =3D=3D 1) {
 =09=09if (attr_underline(c))
 =09=09=09attribute |=3D FBCON_ATTRIBUTE_UNDERLINE;
 =09=09if (attr_reverse(c))
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c=092005-03-01 04:49:39 -05:00
+++ b/drivers/video/console/fbcon.c=092005-03-01 04:49:39 -05:00
@@ -182,8 +182,10 @@
 static __inline__ void ypan_down(struct vc_data *vc, int count);
 static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy,=
 int sx,
 =09=09=09    int dy, int dx, int height, int width, u_int y_break);
-static void fbcon_set_disp(struct fb_info *info, struct vc_data *vc);
-static void fbcon_preset_disp(struct fb_info *info, int unit);
+static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo =
*var,
+=09=09=09   struct vc_data *vc);
+static void fbcon_preset_disp(struct fb_info *info, struct fb_var_screenin=
fo *var,
+=09=09=09      int unit);
 static void fbcon_redraw_move(struct vc_data *vc, struct display *p,
 =09=09=09      int line, int count, int dy);
=20
@@ -209,7 +211,7 @@
 static inline int get_color(struct vc_data *vc, struct fb_info *info,
 =09      u16 c, int is_fg)
 {
-=09int depth =3D fb_get_color_depth(info);
+=09int depth =3D fb_get_color_depth(&info->var);
 =09int color =3D 0;
=20
 =09if (console_blanked) {
@@ -418,7 +420,7 @@
 =09 * remove underline attribute from erase character
 =09 * if black and white framebuffer.
 =09 */
-=09if (fb_get_color_depth(info) =3D=3D 1)
+=09if (fb_get_color_depth(&info->var) =3D=3D 1)
 =09=09erase &=3D ~0x400;
 =09logo_height =3D fb_prepare_logo(info);
 =09logo_lines =3D (logo_height + vc->vc_font.height - 1) /
@@ -595,9 +597,9 @@
 =09=09info->fbops->fb_set_par(info);
=20
 =09if (vc)
-=09=09fbcon_set_disp(info, vc);
+=09=09fbcon_set_disp(info, &info->var, vc);
 =09else
-=09=09fbcon_preset_disp(info, unit);
+=09=09fbcon_preset_disp(info, &info->var, unit);
=20
 =09if (show_logo) {
 =09=09struct vc_data *fg_vc =3D vc_cons[fg_console].d;
@@ -681,6 +683,8 @@
 =09=09=09  struct fb_var_screeninfo *var,
 =09=09=09  struct fb_info *info)
 {
+=09struct fb_videomode *mode;
+
 =09disp->xres_virtual =3D var->xres_virtual;
 =09disp->yres_virtual =3D var->yres_virtual;
 =09disp->bits_per_pixel =3D var->bits_per_pixel;
@@ -693,10 +697,11 @@
 =09disp->green =3D var->green;
 =09disp->blue =3D var->blue;
 =09disp->transp =3D var->transp;
-=09disp->mode =3D fb_match_mode(var, &info->modelist);
-=09if (disp->mode =3D=3D NULL)
+=09mode =3D fb_match_mode(var, &info->modelist);
+=09if (mode =3D=3D NULL)
 =09=09/* This should not happen */
 =09=09return -EINVAL;
+=09disp->mode =3D mode;
 =09return 0;
 }
=20
@@ -918,7 +923,7 @@
 =09}
 =09if (p->userfont)
 =09=09charcnt =3D FNTCHARCNT(p->fontdata);
-=09vc->vc_can_do_color =3D (fb_get_color_depth(info) !=3D 1);
+=09vc->vc_can_do_color =3D (fb_get_color_depth(&info->var) !=3D 1);
 =09vc->vc_complement_mask =3D vc->vc_can_do_color ? 0x7700 : 0x0800;
 =09if (charcnt =3D=3D 256) {
 =09=09vc->vc_hi_font_mask =3D 0;
@@ -1124,13 +1129,14 @@
 /*
  * If no vc is existent yet, just set struct display
  */
-static void fbcon_preset_disp(struct fb_info *info, int unit)
+static void fbcon_preset_disp(struct fb_info *info, struct fb_var_screenin=
fo *var,
+=09=09=09      int unit)
 {
 =09struct display *p =3D &fb_display[unit];
 =09struct display *t =3D &fb_display[fg_console];
=20
-=09info->var.xoffset =3D info->var.yoffset =3D p->yscroll =3D 0;
-=09if (var_to_display(p, &info->var, info))
+=09var->xoffset =3D var->yoffset =3D p->yscroll =3D 0;
+=09if (var_to_display(p, var, info))
 =09=09return;
=20
 =09p->fontdata =3D t->fontdata;
@@ -1139,7 +1145,8 @@
 =09=09REFCOUNT(p->fontdata)++;
 }
=20
-static void fbcon_set_disp(struct fb_info *info, struct vc_data *vc)
+static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo =
*var,
+=09=09=09   struct vc_data *vc)
 {
 =09struct display *p =3D &fb_display[vc->vc_num], *t;
 =09struct vc_data **default_mode =3D vc->vc_display_fg;
@@ -1147,8 +1154,8 @@
 =09int display_fg =3D (*default_mode)->vc_num;
 =09int rows, cols, charcnt =3D 256;
=20
-=09info->var.xoffset =3D info->var.yoffset =3D p->yscroll =3D 0;
-=09if (var_to_display(p, &info->var, info))
+=09var->xoffset =3D var->yoffset =3D p->yscroll =3D 0;
+=09if (var_to_display(p, var, info))
 =09=09return;
 =09t =3D &fb_display[display_fg];
 =09if (!vc->vc_font.data) {
@@ -1162,7 +1169,7 @@
 =09if (p->userfont)
 =09=09charcnt =3D FNTCHARCNT(p->fontdata);
=20
-=09vc->vc_can_do_color =3D (fb_get_color_depth(info) !=3D 1);
+=09vc->vc_can_do_color =3D (fb_get_color_depth(var) !=3D 1);
 =09vc->vc_complement_mask =3D vc->vc_can_do_color ? 0x7700 : 0x0800;
 =09if (charcnt =3D=3D 256) {
 =09=09vc->vc_hi_font_mask =3D 0;
@@ -1177,8 +1184,8 @@
 =09if (!*vc->vc_uni_pagedir_loc)
 =09=09con_copy_unimap(vc->vc_num, display_fg);
=20
-=09cols =3D info->var.xres / vc->vc_font.width;
-=09rows =3D info->var.yres / vc->vc_font.height;
+=09cols =3D var->xres / vc->vc_font.width;
+=09rows =3D var->yres / vc->vc_font.height;
 =09vc_resize(vc->vc_num, cols, rows);
 =09if (CON_IS_VISIBLE(vc)) {
 =09=09update_screen(vc->vc_num);
@@ -1957,7 +1964,7 @@
 =09set_blitting_type(vc, info, p);
 =09((struct fbcon_ops *)info->fbcon_par)->cursor_reset =3D 1;
=20
-=09vc->vc_can_do_color =3D (fb_get_color_depth(info) !=3D 1);
+=09vc->vc_can_do_color =3D (fb_get_color_depth(&info->var) !=3D 1);
 =09vc->vc_complement_mask =3D vc->vc_can_do_color ? 0x7700 : 0x0800;
 =09updatescrollmode(p, info, vc);
=20
@@ -2328,7 +2335,7 @@
 =09if (fbcon_is_inactive(vc, info))
 =09=09return -EINVAL;
=20
-=09depth =3D fb_get_color_depth(info);
+=09depth =3D fb_get_color_depth(&info->var);
 =09if (depth > 3) {
 =09=09for (i =3D j =3D 0; i < 16; i++) {
 =09=09=09k =3D table[i];
@@ -2605,7 +2612,7 @@
 =09=09if (fb_info !=3D info)
 =09=09=09continue;
 =09=09p =3D &fb_display[i];
-=09=09if (!p || !p->mode)
+=09=09if (!p)
 =09=09=09continue;
 =09=09if (fb_mode_is_equal(p->mode, mode)) {
 =09=09=09found =3D 1;
@@ -2663,6 +2670,31 @@
 =09}
 }
=20
+static void fbcon_new_modelist(struct fb_info *info)
+{
+=09int i;
+=09struct vc_data *vc;
+=09struct fb_var_screeninfo var;
+=09struct fb_videomode *mode;
+
+=09for (i =3D 0; i < MAX_NR_CONSOLES; i++) {
+=09=09if (registered_fb[con2fb_map[i]] !=3D info)
+=09=09=09continue;
+=09=09if (!fb_display[i].mode)
+=09=09=09continue;
+=09=09vc =3D vc_cons[i].d;
+=09=09display_to_var(&var, &fb_display[i]);
+=09=09mode =3D fb_find_nearest_mode(&var, &info->modelist);
+=09=09fb_videomode_to_var(&var, mode);
+
+=09=09if (vc)
+=09=09=09fbcon_set_disp(info, &var, vc);
+=09=09else
+=09=09=09fbcon_preset_disp(info, &var, i);
+
+=09}
+}
+
 static int fbcon_event_notify(struct notifier_block *self,=20
 =09=09=09      unsigned long action, void *data)
 {
@@ -2700,6 +2732,9 @@
 =09=09break;
 =09case FB_EVENT_BLANK:
 =09=09fbcon_fb_blanked(info, *(int *)event->data);
+=09=09break;
+=09case FB_EVENT_NEW_MODELIST:
+=09=09fbcon_new_modelist(info);
 =09=09break;
 =09}
=20
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c=092005-03-01 04:49:39 -05:00
+++ b/drivers/video/fbmem.c=092005-03-01 04:49:39 -05:00
@@ -62,10 +62,8 @@
  * Helpers
  */
=20
-int fb_get_color_depth(struct fb_info *info)
+int fb_get_color_depth(struct fb_var_screeninfo *var)
 {
-=09struct fb_var_screeninfo *var =3D &info->var;
-
 =09if (var->green.length =3D=3D var->blue.length &&
 =09    var->green.length =3D=3D var->red.length &&
 =09    !var->green.offset && !var->blue.offset &&
@@ -300,7 +298,7 @@
 =09const u8 *src =3D logo->data;
 =09u8 d, xor =3D (info->fix.visual =3D=3D FB_VISUAL_MONO01) ? 0xff : 0;
=20
-=09if (fb_get_color_depth(info) =3D=3D 3)
+=09if (fb_get_color_depth(&info->var) =3D=3D 3)
 =09=09fg =3D 7;
=20
 =09switch (depth) {
@@ -365,7 +363,7 @@
=20
 int fb_prepare_logo(struct fb_info *info)
 {
-=09int depth =3D fb_get_color_depth(info);
+=09int depth =3D fb_get_color_depth(&info->var);
=20
 =09memset(&fb_logo, 0, sizeof(struct logo_data));
=20
@@ -1042,7 +1040,7 @@
 #endif
 };
=20
-static struct class_simple *fb_class;
+struct class *fb_class;
=20
 /**
  *=09register_framebuffer - registers a frame buffer device
@@ -1058,7 +1056,6 @@
 register_framebuffer(struct fb_info *fb_info)
 {
 =09int i;
-=09struct class_device *c;
 =09struct fb_event event;
=20
 =09if (num_registered_fb =3D=3D FB_MAX)
@@ -1069,13 +1066,13 @@
 =09=09=09break;
 =09fb_info->node =3D i;
=20
-=09c =3D class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
-=09=09=09=09    fb_info->device, "fb%d", i);
-=09if (IS_ERR(c)) {
+=09fb_info->class_device =3D fb_device_add(fb_class, fb_info);
+=09if (IS_ERR(fb_info->class_device)) {
 =09=09/* Not fatal */
-=09=09printk(KERN_WARNING "Unable to create class_device for framebuffer %=
d; errno =3D %ld\n", i, PTR_ERR(c));
+=09=09printk(KERN_WARNING "Unable to create class_device for framebuffer %=
d; errno =3D %ld\n", i, PTR_ERR(fb_info->class_device));
+=09=09fb_info->class_device =3D NULL;
 =09}
-=09
+
 =09if (fb_info->pixmap.addr =3D=3D NULL) {
 =09=09fb_info->pixmap.addr =3D kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
 =09=09if (fb_info->pixmap.addr) {
@@ -1134,7 +1131,7 @@
 =09fb_destroy_modelist(&fb_info->modelist);
 =09registered_fb[i]=3DNULL;
 =09num_registered_fb--;
-=09class_simple_device_remove(MKDEV(FB_MAJOR, i));
+=09class_device_unregister(fb_info->class_device);
 =09return 0;
 }
=20
@@ -1197,7 +1194,7 @@
 =09if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 =09=09printk("unable to get major %d for fb devs\n", FB_MAJOR);
=20
-=09fb_class =3D class_simple_create(THIS_MODULE, "graphics");
+=09fb_class =3D fb_create_class(THIS_MODULE, "graphics");
 =09if (IS_ERR(fb_class)) {
 =09=09printk(KERN_WARNING "Unable to create fb class; errno =3D %ld\n", PT=
R_ERR(fb_class));
 =09=09fb_class =3D NULL;
@@ -1208,7 +1205,7 @@
 void __exit
 fbmem_exit(void)
 {
-=09class_simple_destroy(fb_class);
+=09class_unregister(fb_class);
 }
=20
 #ifdef MODULE
@@ -1221,6 +1218,40 @@
 subsys_exitcall(fbmem_exit);
 #endif
=20
+int fb_new_modelist(struct fb_info *info)
+{
+=09struct fb_event event;
+=09struct fb_var_screeninfo var =3D info->var;
+=09struct list_head *pos, *n;
+=09struct fb_modelist *modelist;
+=09struct fb_videomode *m, mode;
+=09int err =3D 1;
+
+=09list_for_each_safe(pos, n, &info->modelist) {
+=09=09modelist =3D list_entry(pos, struct fb_modelist, list);
+=09=09m =3D &modelist->mode;
+=09=09fb_videomode_to_var(&var, m);
+=09=09var.activate =3D FB_ACTIVATE_TEST;
+=09=09err =3D fb_set_var(info, &var);
+=09=09fb_var_to_videomode(&mode, &var);
+=09=09if (err || !fb_mode_is_equal(m, &mode)) {
+=09=09=09list_del(pos);
+=09=09=09kfree(pos);
+=09=09}
+=09}
+
+=09err =3D 1;
+
+=09if (!list_empty(&info->modelist)) {
+=09=09event.info =3D info;
+=09=09err =3D notifier_call_chain(&fb_notifier_list,
+=09=09=09=09=09   FB_EVENT_NEW_MODELIST,
+=09=09=09=09=09   &event);
+=09}
+
+=09return err;
+}
+
 static char *video_options[FB_MAX];
 static int ofonly;
=20
@@ -1332,5 +1363,6 @@
 EXPORT_SYMBOL(fb_register_client);
 EXPORT_SYMBOL(fb_unregister_client);
 EXPORT_SYMBOL(fb_get_options);
+EXPORT_SYMBOL(fb_new_modelist);
=20
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c=092005-03-01 04:49:39 -05:00
+++ b/drivers/video/fbsysfs.c=092005-03-01 04:49:39 -05:00
@@ -2,6 +2,7 @@
  * fbsysfs.c - framebuffer device class and attributes
  *
  * Copyright (c) 2004 James Simmons <jsimmons@infradead.org>
+ * Copyright (c) 2005 Jon Smirl <jonsmirl@gmail.com>
  *=20
  *=09This program is free software you can redistribute it and/or
  *=09modify it under the terms of the GNU General Public License
@@ -17,6 +18,7 @@
=20
 #include <linux/kernel.h>
 #include <linux/fb.h>
+#include <linux/console.h>
=20
 /**
  * framebuffer_alloc - creates a new frame buffer info structure
@@ -57,6 +59,7 @@
 #undef PADDING
 #undef BYTES_PER_LONG
 }
+EXPORT_SYMBOL(framebuffer_alloc);
=20
 /**
  * framebuffer_release - marks the structure available for freeing
@@ -71,6 +74,371 @@
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
+=09struct fb_info *fb_info =3D=20
+=09=09=09(struct fb_info *)class_get_devdata(class_device);
+=09LIST_HEAD(old_list);
+=09
+=09int i =3D count / sizeof(struct fb_videomode);
+
+=09if (i * sizeof(struct fb_videomode) !=3D count)
+=09=09return -EINVAL;
+
+=09acquire_console_sem();
+=09list_splice(&fb_info->modelist, &old_list);
+=09fb_videomode_to_modelist((struct fb_videomode *)buf, i,
+=09=09=09=09  &fb_info->modelist);
+=09if (fb_new_modelist(fb_info)) {
+=09=09fb_destroy_modelist(&fb_info->modelist);
+=09=09list_splice(&old_list, &fb_info->modelist);
+=09} else=20
+=09=09fb_destroy_modelist(&old_list);
+
+=09release_console_sem();
+
+=09return 0;
+}
+
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
+static ssize_t show_dev(struct class_device *class_device, char *buf)
+{
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09return print_dev_t(buf, MKDEV(FB_MAJOR, fb_info->node));
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
+=09__ATTR(dev, S_IRUGO, show_dev, NULL),
+=09__ATTR_NULL,
+};
+
+static void release_fb_dev(struct class_device *class_dev)
+{
+=09kfree(class_dev);
+}
+
+static void class_fb_release(struct class *class)
+{
+=09kfree(class);
+}
+
+struct class *fb_create_class(struct module *owner, char *name)
+{
+=09struct class *cs;
+=09int retval;
+
+=09cs =3D kmalloc(sizeof(*cs), GFP_KERNEL);
+=09if (!cs) {
+=09=09retval =3D -ENOMEM;
+=09=09goto error;
+=09}
+=09memset(cs, 0x00, sizeof(*cs));
+
+=09cs->name =3D name;
+=09cs->class_release =3D class_fb_release;
+=09cs->release =3D release_fb_dev;
+=09cs->class_dev_attrs =3D class_device_attrs;
+
+=09retval =3D class_register(cs);
+=09if (retval)
+=09=09goto error;
+
+=09return cs;
+
+error:
+=09kfree(cs);
+=09return ERR_PTR(retval);
+}
+
+struct class_device *fb_device_add(struct class *cs, struct fb_info *fb_in=
fo)
+{
+=09struct class_device *s_dev =3D NULL;
+=09int retval;
+
+=09if ((cs =3D=3D NULL) || (IS_ERR(cs))) {
+=09=09retval =3D -ENODEV;
+=09=09goto error;
+=09}
+
+=09s_dev =3D kmalloc(sizeof(*s_dev), GFP_KERNEL);
+=09if (!s_dev) {
+=09=09retval =3D -ENOMEM;
+=09=09goto error;
+=09}
+=09memset(s_dev, 0x00, sizeof(*s_dev));
+
+=09s_dev->dev =3D fb_info->device;
+=09s_dev->class =3D cs;
+=09class_set_devdata(s_dev, fb_info);
+
+=09snprintf(s_dev->class_id, BUS_ID_SIZE, "fb%d", fb_info->node);
+
+=09retval =3D class_device_register(s_dev);
+=09if (retval)
+=09=09goto error;
+
+=09return s_dev;
+
+error:
+=09kfree(s_dev);
+=09return ERR_PTR(retval);
+}
+
+struct class_device *fb_add_child(struct class_device *class_device, struc=
t fb_info *fb_info, const char *fmt, ...)
+{
+=09va_list args;
+=09struct class_device *fb_dev;
+=09int ret;
+=09
+=09fb_dev =3D kmalloc(sizeof(*fb_dev), GFP_KERNEL);
+=09memset(fb_dev, 0, sizeof(*fb_dev));
+=09fb_dev->class =3D class_device->class;
+=09fb_dev->kobj.parent =3D &class_device->kobj;
+=09class_set_devdata(fb_dev, fb_info);
+=09
+=09va_start(args, fmt);
+=09vsnprintf(fb_dev->class_id, sizeof(fb_dev->class_id), fmt, args);
+=09va_end(args);
+=09
+=09ret =3D class_device_register(fb_dev);
+=09return fb_dev;
+}
+EXPORT_SYMBOL(fb_add_child);
diff -Nru a/drivers/video/modedb.c b/drivers/video/modedb.c
--- a/drivers/video/modedb.c=092005-03-01 04:49:39 -05:00
+++ b/drivers/video/modedb.c=092005-03-01 04:49:39 -05:00
@@ -722,6 +722,47 @@
 }
=20
 /**
+ * fb_find_nearest_mode - find mode closest video mode
+ *
+ * @var: pointer to struct fb_var_screeninfo
+ * @head: pointer to modelist
+ *
+ * Finds best matching videomode, smaller or greater in dimension.
+ * If more than 1 videomode is found, will return the videomode with
+ * the closest refresh rate
+ */
+struct fb_videomode *fb_find_nearest_mode(struct fb_var_screeninfo *var,
+=09=09=09=09=09  struct list_head *head)
+{
+=09struct list_head *pos;
+=09struct fb_modelist *modelist;
+=09struct fb_videomode *mode, *best =3D NULL;
+=09u32 diff =3D -1, diff_refresh =3D -1;
+
+=09list_for_each(pos, head) {
+=09=09u32 d;
+
+=09=09modelist =3D list_entry(pos, struct fb_modelist, list);
+=09=09mode =3D &modelist->mode;
+
+=09=09d =3D abs(mode->xres - var->xres) +=20
+=09=09=09abs(mode->yres - var->yres);
+=09=09if (diff > d) {
+=09=09=09diff =3D d;
+=09=09=09best =3D mode;
+=09=09} else if (diff =3D=3D d) {
+=09=09=09d =3D abs(mode->refresh - best->refresh);
+=09=09=09if (diff_refresh > d) {
+=09=09=09=09diff_refresh =3D d;
+=09=09=09=09best =3D mode;
+=09=09=09}
+=09=09}
+=09}
+=09
+=09return best;
+}   =20
+
+/**
  * fb_match_mode - find a videomode which exactly matches the timings in v=
ar
  * @var: pointer to struct fb_var_screeninfo
  * @head: pointer to struct list_head of modelist
@@ -846,5 +887,6 @@
 EXPORT_SYMBOL(fb_destroy_modelist);
 EXPORT_SYMBOL(fb_match_mode);
 EXPORT_SYMBOL(fb_find_best_mode);
+EXPORT_SYMBOL(fb_find_nearest_mode);
 EXPORT_SYMBOL(fb_videomode_to_modelist);
 EXPORT_SYMBOL(fb_find_mode);
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h=092005-03-01 04:49:39 -05:00
+++ b/include/linux/fb.h=092005-03-01 04:49:39 -05:00
@@ -490,6 +490,8 @@
 #define FB_EVENT_SET_CONSOLE_MAP        0x07
 /*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x08
+/*      Private modelist is to be replaced */
+#define FB_EVENT_NEW_MODELIST           0x09
=20
 struct fb_event {
 =09struct fb_info *info;
@@ -712,8 +714,10 @@
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
@@ -821,8 +825,9 @@
 =09=09=09=09u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
 =09=09=09=09u32 height);
 extern void fb_set_suspend(struct fb_info *info, int state);
-extern int fb_get_color_depth(struct fb_info *info);
+extern int fb_get_color_depth(struct fb_var_screeninfo *var);
 extern int fb_get_options(char *name, char **option);
+extern int fb_new_modelist(struct fb_info *info);
=20
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
@@ -830,6 +835,10 @@
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
+extern void fb_cleanup_class_device(struct fb_info *head);
+extern struct class *fb_create_class(struct module *owner, char *name);
+extern struct class_device *fb_device_add(struct class *cs, struct fb_info=
 *fb_info);
+extern struct class_device *fb_add_child(struct class_device *class_device=
, struct fb_info *fb_info, const char *fmt, ...);
=20
 /* drivers/video/fbmon.c */
 #define FB_MAXTIMINGS=09=090
@@ -875,6 +884,8 @@
 =09=09=09=09=09  struct list_head *head);
 extern struct fb_videomode *fb_find_best_mode(struct fb_var_screeninfo *va=
r,
 =09=09=09=09=09      struct list_head *head);
+extern struct fb_videomode *fb_find_nearest_mode(struct fb_var_screeninfo =
*var,
+=09=09=09=09=09=09 struct list_head *head);
 extern void fb_destroy_modelist(struct list_head *head);
 extern void fb_videomode_to_modelist(struct fb_videomode *modedb, int num,
 =09=09=09=09     struct list_head *head);

------=_Part_294_31718270.1109671239236--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
