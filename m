From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/5] Video Mode Handling - Save per-display graphics/display settings
Date: Mon, 9 Aug 2004 09:45:30 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408090945.30965.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BtzID-0001VX-OU
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:41 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BtzIC-0005cC-Si
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:41 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 34C277756B4
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  9 Aug 2004 00:56:15 +0000 (UTC)
Content-Disposition: inline
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

Hi,

This patch adds the following:

a. convert struct fb_var_screeninfo to struct display and vice versa
b. save settings of graphics card to struct display
c. save settings of display to struct display as a pointer to a struct fb_videomode
d. check var in fb_set_var for modes, and if unique, add them to the mode list.

The diff is against 2.6.8-rc3-mm1 but should apply cleanly to 2.6.8-rc3-mm2
as well.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |   96 +++++++++++++++++++++++++++++++++++++-----
 drivers/video/console/fbcon.h |   13 +++++
 drivers/video/fbmem.c         |   15 ++++++
 include/linux/fb.h            |    1
 4 files changed, 114 insertions(+), 11 deletions(-)

diff -uprN linux-2.6.8-rc3-mm1-orig/drivers/video/console/fbcon.c linux-2.6.8-rc3-mm1/drivers/video/console/fbcon.c
--- linux-2.6.8-rc3-mm1-orig/drivers/video/console/fbcon.c	2004-08-08 22:03:01.688874568 +0800
+++ linux-2.6.8-rc3-mm1/drivers/video/console/fbcon.c	2004-08-08 22:00:04.036881776 +0800
@@ -625,6 +625,47 @@ void accel_clear_margins(struct vc_data 
  *  Low Level Operations
  */
 /* NOTE: fbcon cannot be __init: it may be called from take_over_console later */
+static int var_to_display(struct display *disp,
+			  struct fb_var_screeninfo *var,
+			  struct fb_info *info)
+{
+	disp->xres_virtual = var->xres_virtual;
+	disp->yres_virtual = var->yres_virtual;
+	disp->bits_per_pixel = var->bits_per_pixel;
+	disp->grayscale = var->grayscale;
+	disp->nonstd = var->nonstd;
+	disp->accel_flags = var->accel_flags;
+	disp->height = var->height;
+	disp->width = var->width;
+	disp->red = var->red;
+	disp->green = var->green;
+	disp->blue = var->blue;
+	disp->transp = var->transp;
+	disp->mode = fb_match_mode(var, &info->monspecs.modelist);
+	if (disp->mode == NULL)
+		/* This should not happen */
+		return -EINVAL;
+	return 0;
+}
+
+static void display_to_var(struct fb_var_screeninfo *var,
+			   struct display *disp)
+{
+	fb_videomode_to_var(var, disp->mode);
+	var->xres_virtual = disp->xres_virtual;
+	var->yres_virtual = disp->yres_virtual;
+	var->bits_per_pixel = disp->bits_per_pixel;
+	var->grayscale = disp->grayscale;
+	var->nonstd = disp->nonstd;
+	var->accel_flags = disp->accel_flags;
+	var->height = disp->height;
+	var->width = disp->width;
+	var->red = disp->red;
+	var->green = disp->green;
+	var->blue = disp->blue;
+	var->transp = disp->transp;
+}
+
 static const char *fbcon_startup(void)
 {
 	const char *display_desc = "frame buffer device";
@@ -798,6 +839,9 @@ static void fbcon_init(struct vc_data *v
 
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;	/* reset wrap/pan */
 
+	if (var_to_display(p, &info->var, info))
+		return;
+
 	/* If we are not the first console on this
 	   fb, copy the font from that console */
 	t = &fb_display[display_fg];
@@ -1174,6 +1218,8 @@ static void fbcon_set_disp(struct fb_inf
 	int rows, cols, charcnt = 256;
 
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
+	if (var_to_display(p, &info->var, info))
+		return;
 	t = &fb_display[display_fg];
 	if (!vc->vc_font.data) {
 		vc->vc_font.data = p->fontdata = t->fontdata;
@@ -1861,7 +1907,7 @@ static int fbcon_resize(struct vc_data *
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var = info->var;
-	int err; int x_diff, y_diff;
+	int x_diff, y_diff;
 	int fw = vc->vc_font.width;
 	int fh = vc->vc_font.height;
 
@@ -1870,15 +1916,31 @@ static int fbcon_resize(struct vc_data *
 	x_diff = info->var.xres - var.xres;
 	y_diff = info->var.yres - var.yres;
 	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh)) {
-		char mode[40];
+		struct fb_videomode *mode;
 
 		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
-		snprintf(mode, 40, "%ix%i", var.xres, var.yres);
-		err = fb_find_mode(&var, info, mode, info->monspecs.modedb,
-				   info->monspecs.modedb_len, NULL,
-				   info->var.bits_per_pixel);
-		if (!err || width > var.xres/fw || height > var.yres/fh)
+		mode = fb_find_best_mode(&var, &info->monspecs.modelist);
+		if (mode == NULL)
 			return -EINVAL;
+		fb_videomode_to_var(&var, mode);
+		if (width > var.xres/fw || height > var.yres/fh)
+			return -EINVAL;
+		/*
+		 * The following can probably have any value... Do we need to
+		 * set all of them?
+		 */
+		var.bits_per_pixel = p->bits_per_pixel;
+		var.xres_virtual = p->xres_virtual;
+		var.yres_virtual = p->yres_virtual;
+		var.accel_flags = p->accel_flags;
+		var.width = p->width;
+		var.height = p->height;
+		var.red = p->red;
+		var.green = p->green;
+		var.blue = p->blue;
+		var.transp = p->transp;
+		var.nonstd = p->nonstd;
+
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		if (CON_IS_VISIBLE(vc)) {
 			var.activate = FB_ACTIVATE_NOW |
@@ -1886,6 +1948,7 @@ static int fbcon_resize(struct vc_data *
 			fb_set_var(info, &var);
 			info->flags &= ~FBINFO_MISC_MODESWITCH;
 		}
+		var_to_display(p, &info->var, info);
 	}
 	updatescrollmode(p, info, vc);
 	return 0;
@@ -1895,6 +1958,7 @@ static int fbcon_switch(struct vc_data *
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
+	struct fb_var_screeninfo var;
 	int i;
 
 	if (softback_top) {
@@ -1920,8 +1984,6 @@ static int fbcon_switch(struct vc_data *
 			conp2->vc_top = 0;
 		logo_shown = -1;
 	}
-	if (info)
-		info->var.yoffset = p->yscroll = 0;
 
 	/*
 	 * FIXME: If we have multiple fbdev's loaded, we need to
@@ -1936,7 +1998,18 @@ static int fbcon_switch(struct vc_data *
 			registered_fb[i]->currcon = vc->vc_num;
 	}
 
- 	fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+	memset(&var, 0, sizeof(struct fb_var_screeninfo));
+	fb_videomode_to_var(&var, p->mode);
+	display_to_var(&var, p);
+	var.activate = FB_ACTIVATE_NOW;
+
+	/*
+	 * make sure we don't unnecessarily trip the memcmp()
+	 * in fb_set_var()
+	 */
+	info->var.activate = var.activate;
+	info->var.yoffset = info->var.xoffset = p->yscroll = 0;
+	fb_set_var(info, &var);
 
 	if (info->flags & FBINFO_MISC_MODESWITCH) {
 		if (info->fbops->fb_set_par)
@@ -1944,9 +2017,9 @@ static int fbcon_switch(struct vc_data *
 		info->flags &= ~FBINFO_MISC_MODESWITCH;
 	}
 
-	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
 	vc->vc_can_do_color = (fb_get_color_depth(info) != 1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
+	updatescrollmode(p, info, vc);
 
 	switch (p->scrollmode) {
 	case SCROLL_WRAP_MOVE:
@@ -2575,6 +2648,7 @@ static void fbcon_modechanged(struct fb_
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
 
 	if (CON_IS_VISIBLE(vc)) {
+		var_to_display(p, &info->var, info);
 		cols = info->var.xres / vc->vc_font.width;
 		rows = info->var.yres / vc->vc_font.height;
 		vc_resize(vc->vc_num, cols, rows);
diff -uprN linux-2.6.8-rc3-mm1-orig/drivers/video/console/fbcon.h linux-2.6.8-rc3-mm1/drivers/video/console/fbcon.h
--- linux-2.6.8-rc3-mm1-orig/drivers/video/console/fbcon.h	2004-08-08 22:03:04.249485296 +0800
+++ linux-2.6.8-rc3-mm1/drivers/video/console/fbcon.h	2004-08-08 22:00:07.188402672 +0800
@@ -33,6 +33,19 @@ struct display {
     short yscroll;                  /* Hardware scrolling */
     int vrows;                      /* number of virtual rows */
     int cursor_shape;
+    u32 xres_virtual;
+    u32 yres_virtual;
+    u32 height;
+    u32 width;
+    u32 bits_per_pixel;
+    u32 grayscale;
+    u32 nonstd;
+    u32 accel_flags;
+    struct fb_bitfield red;
+    struct fb_bitfield green;
+    struct fb_bitfield blue;
+    struct fb_bitfield transp;
+    struct fb_videomode *mode;
 };
 
 /* drivers/video/console/fbcon.c */
diff -uprN linux-2.6.8-rc3-mm1-orig/drivers/video/fbmem.c linux-2.6.8-rc3-mm1/drivers/video/fbmem.c
--- linux-2.6.8-rc3-mm1-orig/drivers/video/fbmem.c	2004-08-08 22:02:49.026799496 +0800
+++ linux-2.6.8-rc3-mm1/drivers/video/fbmem.c	2004-08-08 22:00:52.497514640 +0800
@@ -1094,6 +1094,7 @@ fb_set_var(struct fb_info *info, struct 
 			return err;
 
 		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
+			struct fb_videomode mode;
 			info->var = *var;
 
 			if (info->fbops->fb_set_par)
@@ -1103,6 +1104,9 @@ fb_set_var(struct fb_info *info, struct 
 
 			fb_set_cmap(&info->cmap, info);
 
+			fb_var_to_videomode(&mode, &info->var);
+			fb_add_videomode(&mode, &info->monspecs.modelist);
+
 			if (info->flags & FBINFO_MISC_MODECHANGEUSER) {
 				info->flags &= ~FBINFO_MISC_MODECHANGEUSER;
 				notifier_call_chain(&fb_notifier_list,
@@ -1438,6 +1442,16 @@ register_framebuffer(struct fb_info *fb_
 	}
 	fb_info->sprite.offset = 0;
 
+	if (!fb_info->monspecs.modelist.prev ||
+	    !fb_info->monspecs.modelist.next ||
+	    list_empty(&fb_info->monspecs.modelist)) {
+	        struct fb_videomode mode;
+
+		INIT_LIST_HEAD(&fb_info->monspecs.modelist);
+		fb_var_to_videomode(&mode, &fb_info->var);
+		fb_add_videomode(&mode, &fb_info->monspecs.modelist);
+	}
+
 	registered_fb[i] = fb_info;
 
 	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
@@ -1470,6 +1484,7 @@ unregister_framebuffer(struct fb_info *f
 		kfree(fb_info->pixmap.addr);
 	if (fb_info->sprite.addr && (fb_info->sprite.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->sprite.addr);
+	fb_destroy_modelist(&fb_info->monspecs.modelist);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
 	class_simple_device_remove(MKDEV(FB_MAJOR, i));
diff -uprN linux-2.6.8-rc3-mm1-orig/include/linux/fb.h linux-2.6.8-rc3-mm1/include/linux/fb.h
--- linux-2.6.8-rc3-mm1-orig/include/linux/fb.h	2004-08-08 22:03:39.162177760 +0800
+++ linux-2.6.8-rc3-mm1/include/linux/fb.h	2004-08-08 22:01:46.972233224 +0800
@@ -282,6 +282,7 @@ struct fb_chroma {
 struct fb_monspecs {
 	struct fb_chroma chroma;
 	struct fb_videomode *modedb;	/* mode database */
+	struct list_head modelist;      /* mode list */
 	__u8  manufacturer[4];		/* Manufacturer */
 	__u8  monitor[14];		/* Monitor String */
 	__u8  serial_no[14];		/* Serial Number */




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
