From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/8] fbcon: Console Rotation - Prepare fbcon for console rotation
Date: Mon, 07 Nov 2005 19:02:49 +0800
Message-ID: <436F3459.9060304@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5Ad-0004RS-Qq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:28:15 -0800
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZ5Ac-0006Hq-L1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:28:15 -0800
Received: by xproxy.gmail.com with SMTP id i28so364656wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 03:28:13 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This patch prepares fbcon for console rotation and contains the following
changes:

- add rotate field in struct fbcon_ops to keep fbcon's current rotation
angle

- add con_rotate field in struct display to store per-display rotation
angle

- create a private copy of the current var to fbcon.  This will prevent
fbcon from directly manipulating info->var, especially the fields
xoffset, yoffset and vmode.

- add ability to swap pertinent axes (xres, yres; xpanstep, ypanstep; etc)
depending on the rotation angle

- change global update_var() (function that sets the screen start address)
as an fbcon method update_start.  This is required because the axes,
start offset, and/or direction can be reversed depending on the
rotation angle.

- add fbcon method rotate_font() which will rotate each character bitmap
to the correct angle of rotation.

- add fbcon boot option 'rotate' to select the angle of rotation at
bootime.  Currently does nothing until all patches are applied.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 drivers/video/console/Kconfig    |   10 +
 drivers/video/console/bitblit.c  |   46 ++----
 drivers/video/console/fbcon.c    |  283 ++++++++++++++++++++++++---------------
 drivers/video/console/fbcon.h    |   58 +++++++
 drivers/video/console/tileblit.c |   13 +
 include/linux/fb.h               |   12 +
 6 files changed, 285 insertions(+), 137 deletions(-)


diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index fadf7c5..94c5f13 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -101,6 +101,16 @@ config FRAMEBUFFER_CONSOLE
 	help
 	  Low-level framebuffer-based console driver.
 
+config FRAMEBUFFER_CONSOLE_ROTATION
+       bool "Framebuffer Console Rotation"
+       depends on FRAMEBUFFER_CONSOLE
+       help
+         Enable display rotation for the framebuffer console.  This is done
+         in software and may be significantly slower than a normally oriented
+         display.  Note that the rotation is done at the console level only
+         such that other users of the framebuffer will remain normally
+         oriented.
+
 config STI_CONSOLE
         tristate "STI text console" 
         depends on PARISC
diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
index 67857b3..e65fc3e 100644
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -22,35 +22,6 @@
 /*
  * Accelerated handlers.
  */
-#define FBCON_ATTRIBUTE_UNDERLINE 1
-#define FBCON_ATTRIBUTE_REVERSE   2
-#define FBCON_ATTRIBUTE_BOLD      4
-
-static inline int real_y(struct display *p, int ypos)
-{
-	int rows = p->vrows;
-
-	ypos += p->yscroll;
-	return ypos < rows ? ypos : ypos - rows;
-}
-
-
-static inline int get_attribute(struct fb_info *info, u16 c)
-{
-	int attribute = 0;
-
-	if (fb_get_color_depth(&info->var, &info->fix) == 1) {
-		if (attr_underline(c))
-			attribute |= FBCON_ATTRIBUTE_UNDERLINE;
-		if (attr_reverse(c))
-			attribute |= FBCON_ATTRIBUTE_REVERSE;
-		if (attr_bold(c))
-			attribute |= FBCON_ATTRIBUTE_BOLD;
-	}
-
-	return attribute;
-}
-
 static inline void update_attr(u8 *dst, u8 *src, int attribute,
 			       struct vc_data *vc)
 {
@@ -418,6 +389,18 @@ static void bit_cursor(struct vc_data *v
 	ops->cursor_reset = 0;
 }
 
+static int bit_update_start(struct fb_info *info)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+	int err;
+
+	err = fb_pan_display(info, &ops->var);
+	ops->var.xoffset = info->var.xoffset;
+	ops->var.yoffset = info->var.yoffset;
+	ops->var.vmode = info->var.vmode;
+	return err;
+}
+
 void fbcon_set_bitops(struct fbcon_ops *ops)
 {
 	ops->bmove = bit_bmove;
@@ -425,6 +408,11 @@ void fbcon_set_bitops(struct fbcon_ops *
 	ops->putcs = bit_putcs;
 	ops->clear_margins = bit_clear_margins;
 	ops->cursor = bit_cursor;
+	ops->update_start = bit_update_start;
+	ops->rotate_font = NULL;
+
+	if (ops->rotate)
+		fbcon_set_rotate(ops);
 }
 
 EXPORT_SYMBOL(fbcon_set_bitops);
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 3cf1b61..b5d678c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -107,6 +107,8 @@ enum {
 };
 
 struct display fb_display[MAX_NR_CONSOLES];
+EXPORT_SYMBOL(fb_display);
+
 static signed char con2fb_map[MAX_NR_CONSOLES];
 static signed char con2fb_map_boot[MAX_NR_CONSOLES];
 static int logo_height;
@@ -130,6 +132,9 @@ static char fontname[40];
 /* current fb_info */
 static int info_idx = -1;
 
+/* console rotation */
+static int rotate;
+
 static const struct consw fb_con;
 
 #define CM_SOFTBACK	(8)
@@ -176,7 +181,6 @@ static int fbcon_scrolldelta(struct vc_d
 /*
  *  Internal routines
  */
-static __inline__ int real_y(struct display *p, int ypos);
 static __inline__ void ywrap_up(struct vc_data *vc, int count);
 static __inline__ void ywrap_down(struct vc_data *vc, int count);
 static __inline__ void ypan_up(struct vc_data *vc, int count);
@@ -203,6 +207,13 @@ static irqreturn_t fb_vbl_detect(int irq
 }
 #endif
 
+static inline void fbcon_set_rotation(struct fb_info *info, struct display *p)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+
+	ops->rotate = FB_ROTATE_UR;
+}
+
 static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -422,6 +433,14 @@ static int __init fb_console_setup(char 
 				last_fb_vc = simple_strtoul(options, &options, 10) - 1;
 			fbcon_is_default = 0; 
 		}	
+
+		if (!strncmp(options, "rotate:", 7)) {
+			options += 7;
+			if (*options)
+				rotate = simple_strtoul(options, &options, 0);
+			if (rotate > 3)
+				rotate = 0;
+		}
 	}
 	return 0;
 }
@@ -558,16 +577,24 @@ static void set_blitting_type(struct vc_
 
 	if ((info->flags & FBINFO_MISC_TILEBLITTING))
 		fbcon_set_tileops(vc, info, p, ops);
-	else
+	else {
+		struct display *disp;
+
+		disp = (p) ? p : &fb_display[vc->vc_num];
+		fbcon_set_rotation(info, disp);
 		fbcon_set_bitops(ops);
+	}
 }
 #else
 static void set_blitting_type(struct vc_data *vc, struct fb_info *info,
 			      struct display *p)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
+	struct display *disp;
 
 	info->flags &= ~FBINFO_MISC_TILEBLITTING;
+	disp = (p) ? p : &fb_display[vc->vc_num];
+	fbcon_set_rotation(info, disp);
 	fbcon_set_bitops(ops);
 }
 #endif /* CONFIG_MISC_TILEBLITTING */
@@ -627,6 +654,7 @@ static int con2fb_release_oldinfo(struct
 		fbcon_del_cursor_timer(oldinfo);
 		kfree(ops->cursor_state.mask);
 		kfree(ops->cursor_data);
+		kfree(ops->fontbuffer);
 		kfree(oldinfo->fbcon_par);
 		oldinfo->fbcon_par = NULL;
 		module_put(oldinfo->fbops->owner);
@@ -827,7 +855,9 @@ static const char *fbcon_startup(void)
 	memset(ops, 0, sizeof(struct fbcon_ops));
 	ops->currcon = -1;
 	ops->graphics = 1;
+	ops->cur_rotate = -1;
 	info->fbcon_par = ops;
+	p->con_rotate = rotate;
 	set_blitting_type(vc, info, NULL);
 
 	if (info->fix.type != FB_TYPE_TEXT) {
@@ -866,8 +896,10 @@ static const char *fbcon_startup(void)
 		vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
 	}
 
-	cols = info->var.xres / vc->vc_font.width;
-	rows = info->var.yres / vc->vc_font.height;
+	cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
+	rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+	cols /= vc->vc_font.width;
+	rows /= vc->vc_font.height;
 	vc_resize(vc, cols, rows);
 
 	DPRINTK("mode:   %s\n", info->fix.id);
@@ -953,8 +985,6 @@ static void fbcon_init(struct vc_data *v
 	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;
 
-	info->var.xoffset = info->var.yoffset = p->yscroll = 0;	/* reset wrap/pan */
-
 	if (var_to_display(p, &info->var, info))
 		return;
 
@@ -986,13 +1016,18 @@ static void fbcon_init(struct vc_data *v
 	if (!*vc->vc_uni_pagedir_loc)
 		con_copy_unimap(vc, svc);
 
+	ops = info->fbcon_par;
+	p->con_rotate = rotate;
+	set_blitting_type(vc, info, NULL);
+
 	cols = vc->vc_cols;
 	rows = vc->vc_rows;
-	new_cols = info->var.xres / vc->vc_font.width;
-	new_rows = info->var.yres / vc->vc_font.height;
+	new_cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
+	new_rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+	new_cols /= vc->vc_font.width;
+	new_rows /= vc->vc_font.height;
 	vc_resize(vc, new_cols, new_rows);
 
-	ops = info->fbcon_par;
 	/*
 	 * We must always set the mode. The mode of the previous console
 	 * driver could be in the same resolution but we are using different
@@ -1030,6 +1065,12 @@ static void fbcon_init(struct vc_data *v
 
 	if (vc == svc && softback_buf)
 		fbcon_update_softback(vc);
+
+	if (ops->rotate_font && ops->rotate_font(info, vc, p)) {
+		ops->rotate = FB_ROTATE_UR;
+		set_blitting_type(vc, info, p);
+	}
+
 }
 
 static void fbcon_deinit(struct vc_data *vc)
@@ -1066,15 +1107,6 @@ static void fbcon_deinit(struct vc_data 
  *  restriction is simplicity & efficiency at the moment.
  */
 
-static __inline__ int real_y(struct display *p, int ypos)
-{
-	int rows = p->vrows;
-
-	ypos += p->yscroll;
-	return ypos < rows ? ypos : ypos - rows;
-}
-
-
 static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 			int width)
 {
@@ -1162,13 +1194,6 @@ static int scrollback_phys_max = 0;
 static int scrollback_max = 0;
 static int scrollback_current = 0;
 
-static int update_var(int con, struct fb_info *info)
-{
-	if (con == ((struct fbcon_ops *)info->fbcon_par)->currcon)
-		return fb_pan_display(info, &info->var);
-	return 0;
-}
-
 /*
  * If no vc is existent yet, just set struct display
  */
@@ -1178,7 +1203,6 @@ static void fbcon_preset_disp(struct fb_
 	struct display *p = &fb_display[unit];
 	struct display *t = &fb_display[fg_console];
 
-	var->xoffset = var->yoffset = p->yscroll = 0;
 	if (var_to_display(p, var, info))
 		return;
 
@@ -1194,9 +1218,9 @@ static void fbcon_set_disp(struct fb_inf
 	struct display *p = &fb_display[vc->vc_num], *t;
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct vc_data *svc = *default_mode;
+	struct fbcon_ops *ops = info->fbcon_par;
 	int rows, cols, charcnt = 256;
 
-	var->xoffset = var->yoffset = p->yscroll = 0;
 	if (var_to_display(p, var, info))
 		return;
 	t = &fb_display[svc->vc_num];
@@ -1213,9 +1237,10 @@ static void fbcon_set_disp(struct fb_inf
 
 	var->activate = FB_ACTIVATE_NOW;
 	info->var.activate = var->activate;
-	info->var.yoffset = info->var.xoffset = 0;
+	var->yoffset = info->var.yoffset;
+	var->xoffset = info->var.xoffset;
 	fb_set_var(info, var);
-
+	ops->var = info->var;
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt == 256) {
@@ -1231,9 +1256,12 @@ static void fbcon_set_disp(struct fb_inf
 	if (!*vc->vc_uni_pagedir_loc)
 		con_copy_unimap(vc, svc);
 
-	cols = var->xres / vc->vc_font.width;
-	rows = var->yres / vc->vc_font.height;
+	cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
+	rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+	cols /= vc->vc_font.width;
+	rows /= vc->vc_font.height;
 	vc_resize(vc, cols, rows);
+
 	if (CON_IS_VISIBLE(vc)) {
 		update_screen(vc);
 		if (softback_buf)
@@ -1244,15 +1272,16 @@ static void fbcon_set_disp(struct fb_inf
 static __inline__ void ywrap_up(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
 	
 	p->yscroll += count;
 	if (p->yscroll >= p->vrows)	/* Deal with wrap */
 		p->yscroll -= p->vrows;
-	info->var.xoffset = 0;
-	info->var.yoffset = p->yscroll * vc->vc_font.height;
-	info->var.vmode |= FB_VMODE_YWRAP;
-	update_var(vc->vc_num, info);
+	ops->var.xoffset = 0;
+	ops->var.yoffset = p->yscroll * vc->vc_font.height;
+	ops->var.vmode |= FB_VMODE_YWRAP;
+	ops->update_start(info);
 	scrollback_max += count;
 	if (scrollback_max > scrollback_phys_max)
 		scrollback_max = scrollback_phys_max;
@@ -1262,15 +1291,16 @@ static __inline__ void ywrap_up(struct v
 static __inline__ void ywrap_down(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
 	
 	p->yscroll -= count;
 	if (p->yscroll < 0)	/* Deal with wrap */
 		p->yscroll += p->vrows;
-	info->var.xoffset = 0;
-	info->var.yoffset = p->yscroll * vc->vc_font.height;
-	info->var.vmode |= FB_VMODE_YWRAP;
-	update_var(vc->vc_num, info);
+	ops->var.xoffset = 0;
+	ops->var.yoffset = p->yscroll * vc->vc_font.height;
+	ops->var.vmode |= FB_VMODE_YWRAP;
+	ops->update_start(info);
 	scrollback_max -= count;
 	if (scrollback_max < 0)
 		scrollback_max = 0;
@@ -1289,10 +1319,11 @@ static __inline__ void ypan_up(struct vc
 			    0, 0, 0, vc->vc_rows, vc->vc_cols);
 		p->yscroll -= p->vrows - vc->vc_rows;
 	}
-	info->var.xoffset = 0;
-	info->var.yoffset = p->yscroll * vc->vc_font.height;
-	info->var.vmode &= ~FB_VMODE_YWRAP;
-	update_var(vc->vc_num, info);
+
+	ops->var.xoffset = 0;
+	ops->var.yoffset = p->yscroll * vc->vc_font.height;
+	ops->var.vmode &= ~FB_VMODE_YWRAP;
+	ops->update_start(info);
 	fbcon_clear_margins(vc, 1);
 	scrollback_max += count;
 	if (scrollback_max > scrollback_phys_max)
@@ -1303,6 +1334,7 @@ static __inline__ void ypan_up(struct vc
 static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
 	int redraw = 0;
 
@@ -1312,12 +1344,13 @@ static __inline__ void ypan_up_redraw(st
 		redraw = 1;
 	}
 
-	info->var.xoffset = 0;
-	info->var.yoffset = p->yscroll * vc->vc_font.height;
-	info->var.vmode &= ~FB_VMODE_YWRAP;
 	if (redraw)
 		fbcon_redraw_move(vc, p, t + count, vc->vc_rows - count, t);
-	update_var(vc->vc_num, info);
+
+	ops->var.xoffset = 0;
+	ops->var.yoffset = p->yscroll * vc->vc_font.height;
+	ops->var.vmode &= ~FB_VMODE_YWRAP;
+	ops->update_start(info);
 	fbcon_clear_margins(vc, 1);
 	scrollback_max += count;
 	if (scrollback_max > scrollback_phys_max)
@@ -1337,10 +1370,11 @@ static __inline__ void ypan_down(struct 
 			    0, vc->vc_rows, vc->vc_cols);
 		p->yscroll += p->vrows - vc->vc_rows;
 	}
-	info->var.xoffset = 0;
-	info->var.yoffset = p->yscroll * vc->vc_font.height;
-	info->var.vmode &= ~FB_VMODE_YWRAP;
-	update_var(vc->vc_num, info);
+
+	ops->var.xoffset = 0;
+	ops->var.yoffset = p->yscroll * vc->vc_font.height;
+	ops->var.vmode &= ~FB_VMODE_YWRAP;
+	ops->update_start(info);
 	fbcon_clear_margins(vc, 1);
 	scrollback_max -= count;
 	if (scrollback_max < 0)
@@ -1351,6 +1385,7 @@ static __inline__ void ypan_down(struct 
 static __inline__ void ypan_down_redraw(struct vc_data *vc, int t, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
 	int redraw = 0;
 
@@ -1359,12 +1394,14 @@ static __inline__ void ypan_down_redraw(
 		p->yscroll += p->vrows - vc->vc_rows;
 		redraw = 1;
 	}
-	info->var.xoffset = 0;
-	info->var.yoffset = p->yscroll * vc->vc_font.height;
-	info->var.vmode &= ~FB_VMODE_YWRAP;
+
 	if (redraw)
 		fbcon_redraw_move(vc, p, t, vc->vc_rows - count, t + count);
-	update_var(vc->vc_num, info);
+
+	ops->var.xoffset = 0;
+	ops->var.yoffset = p->yscroll * vc->vc_font.height;
+	ops->var.vmode &= ~FB_VMODE_YWRAP;
+	ops->update_start(info);
 	fbcon_clear_margins(vc, 1);
 	scrollback_max -= count;
 	if (scrollback_max < 0)
@@ -1838,31 +1875,41 @@ static void fbcon_bmove_rec(struct vc_da
 		   height, width);
 }
 
-static __inline__ void updatescrollmode(struct display *p, struct fb_info *info,
+static __inline__ void updatescrollmode(struct display *p,
+					struct fb_info *info,
 					struct vc_data *vc)
 {
+	struct fbcon_ops *ops = info->fbcon_par;
 	int fh = vc->vc_font.height;
 	int cap = info->flags;
-	int good_pan = (cap & FBINFO_HWACCEL_YPAN)
-		 && divides(info->fix.ypanstep, vc->vc_font.height)
-		 && info->var.yres_virtual > info->var.yres;
-	int good_wrap = (cap & FBINFO_HWACCEL_YWRAP)
-		 && divides(info->fix.ywrapstep, vc->vc_font.height)
-		 && divides(vc->vc_font.height, info->var.yres_virtual);
+	u16 t = 0;
+	int ypan = FBCON_SWAP(ops->rotate, info->fix.ypanstep,
+				  info->fix.xpanstep);
+	int ywrap = FBCON_SWAP(ops->rotate, info->fix.ywrapstep, t);
+	int yres = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+	int vyres = FBCON_SWAP(ops->rotate, info->var.yres_virtual,
+				   info->var.xres_virtual);
+	int good_pan = (cap & FBINFO_HWACCEL_YPAN) &&
+		divides(ypan, vc->vc_font.height) && vyres > yres;
+	int good_wrap = (cap & FBINFO_HWACCEL_YWRAP) &&
+		divides(ywrap, vc->vc_font.height) &&
+		divides(vc->vc_font.height, vyres);
 	int reading_fast = cap & FBINFO_READS_FAST;
-	int fast_copyarea = (cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED);
-	int fast_imageblit = (cap & FBINFO_HWACCEL_IMAGEBLIT) && !(cap & FBINFO_HWACCEL_DISABLED);
-
-	p->vrows = info->var.yres_virtual/fh;
-	if (info->var.yres > (fh * (vc->vc_rows + 1)))
-		p->vrows -= (info->var.yres - (fh * vc->vc_rows)) / fh;
-	if ((info->var.yres % fh) && (info->var.yres_virtual % fh <
-				      info->var.yres % fh))
+	int fast_copyarea = (cap & FBINFO_HWACCEL_COPYAREA) &&
+		!(cap & FBINFO_HWACCEL_DISABLED);
+	int fast_imageblit = (cap & FBINFO_HWACCEL_IMAGEBLIT) &&
+		!(cap & FBINFO_HWACCEL_DISABLED);
+
+	p->vrows = vyres/fh;
+	if (yres > (fh * (vc->vc_rows + 1)))
+		p->vrows -= (yres - (fh * vc->vc_rows)) / fh;
+	if ((yres % fh) && (vyres % fh < yres % fh))
 		p->vrows--;
 
 	if (good_wrap || good_pan) {
 		if (reading_fast || fast_copyarea)
-			p->scrollmode = good_wrap ? SCROLL_WRAP_MOVE : SCROLL_PAN_MOVE;
+			p->scrollmode = good_wrap ?
+				SCROLL_WRAP_MOVE : SCROLL_PAN_MOVE;
 		else
 			p->scrollmode = good_wrap ? SCROLL_REDRAW :
 				SCROLL_PAN_REDRAW;
@@ -1878,17 +1925,23 @@ static int fbcon_resize(struct vc_data *
 			unsigned int height)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var = info->var;
-	int x_diff, y_diff;
-	int fw = vc->vc_font.width;
-	int fh = vc->vc_font.height;
+	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
-	var.xres = width * fw;
-	var.yres = height * fh;
+	virt_w = FBCON_SWAP(ops->rotate, width, height);
+	virt_h = FBCON_SWAP(ops->rotate, height, width);
+	virt_fw = FBCON_SWAP(ops->rotate, vc->vc_font.width,
+				 vc->vc_font.height);
+	virt_fh = FBCON_SWAP(ops->rotate, vc->vc_font.height,
+				 vc->vc_font.width);
+	var.xres = virt_w * virt_fw;
+	var.yres = virt_h * virt_fh;
 	x_diff = info->var.xres - var.xres;
 	y_diff = info->var.yres - var.yres;
-	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh)) {
+	if (x_diff < 0 || x_diff > virt_fw ||
+	    y_diff < 0 || y_diff > virt_fh) {
 		struct fb_videomode *mode;
 
 		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
@@ -1898,7 +1951,7 @@ static int fbcon_resize(struct vc_data *
 		display_to_var(&var, p);
 		fb_videomode_to_var(&var, mode);
 
-		if (width > var.xres/fw || height > var.yres/fh)
+		if (virt_w > var.xres/virt_fw || virt_h > var.yres/virt_fh)
 			return -EINVAL;
 
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
@@ -1908,6 +1961,7 @@ static int fbcon_resize(struct vc_data *
 			fb_set_var(info, &var);
 		}
 		var_to_display(p, &info->var, info);
+		ops->var = info->var;
 	}
 	updatescrollmode(p, info, vc);
 	return 0;
@@ -1916,11 +1970,13 @@ static int fbcon_resize(struct vc_data *
 static int fbcon_switch(struct vc_data *vc)
 {
 	struct fb_info *info, *old_info = NULL;
+	struct fbcon_ops *ops;
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var;
 	int i, prev_console;
 
 	info = registered_fb[con2fb_map[vc->vc_num]];
+	ops = info->fbcon_par;
 
 	if (softback_top) {
 		if (softback_lines)
@@ -1939,7 +1995,7 @@ static int fbcon_switch(struct vc_data *
 		logo_shown = FBCON_LOGO_CANSHOW;
 	}
 
-	prev_console = ((struct fbcon_ops *)info->fbcon_par)->currcon;
+	prev_console = ops->currcon;
 	if (prev_console != -1)
 		old_info = registered_fb[con2fb_map[prev_console]];
 	/*
@@ -1952,9 +2008,9 @@ static int fbcon_switch(struct vc_data *
 	 */
 	for (i = 0; i < FB_MAX; i++) {
 		if (registered_fb[i] != NULL && registered_fb[i]->fbcon_par) {
-			struct fbcon_ops *ops = registered_fb[i]->fbcon_par;
+			struct fbcon_ops *o = registered_fb[i]->fbcon_par;
 
-			ops->currcon = vc->vc_num;
+			o->currcon = vc->vc_num;
 		}
 	}
 	memset(&var, 0, sizeof(struct fb_var_screeninfo));
@@ -1966,8 +2022,11 @@ static int fbcon_switch(struct vc_data *
 	 * in fb_set_var()
 	 */
 	info->var.activate = var.activate;
-	info->var.yoffset = info->var.xoffset = p->yscroll = 0;
+	var.yoffset = info->var.yoffset;
+	var.xoffset = info->var.xoffset;
+	var.vmode = info->var.vmode;
 	fb_set_var(info, &var);
+	ops->var = info->var;
 
 	if (old_info != NULL && old_info != info) {
 		if (info->fbops->fb_set_par)
@@ -1977,7 +2036,12 @@ static int fbcon_switch(struct vc_data *
 	}
 
 	set_blitting_type(vc, info, p);
-	((struct fbcon_ops *)info->fbcon_par)->cursor_reset = 1;
+	ops->cursor_reset = 1;
+
+	if (ops->rotate_font && ops->rotate_font(info, vc, p)) {
+		ops->rotate = FB_ROTATE_UR;
+		set_blitting_type(vc, info, p);
+	}
 
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
@@ -1997,10 +2061,11 @@ static int fbcon_switch(struct vc_data *
 		scrollback_phys_max = 0;
 		break;
 	}
+
 	scrollback_max = 0;
 	scrollback_current = 0;
-
-	update_var(vc->vc_num, info);
+	ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
+	ops->update_start(info);
 	fbcon_set_palette(vc, color_table); 	
 	fbcon_clear_margins(vc, 0);
 
@@ -2047,6 +2112,7 @@ static int fbcon_blank(struct vc_data *v
 			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
 			fb_set_var(info, &var);
 			ops->graphics = 0;
+			ops->var = info->var;
 		}
 	}
 
@@ -2135,6 +2201,7 @@ static int fbcon_do_set_font(struct vc_d
 			     const u8 * data, int userfont)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
 	int resize;
 	int cnt;
@@ -2214,9 +2281,13 @@ static int fbcon_do_set_font(struct vc_d
 	}
 
 	if (resize) {
-		/* reset wrap/pan */
-		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
-		vc_resize(vc, info->var.xres / w, info->var.yres / h);
+		int cols, rows;
+
+		cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
+		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+		cols /= w;
+		rows /= h;
+		vc_resize(vc, cols, rows);
 		if (CON_IS_VISIBLE(vc) && softback_buf)
 			fbcon_update_softback(vc);
 	} else if (CON_IS_VISIBLE(vc)
@@ -2444,6 +2515,7 @@ static void fbcon_invert_region(struct v
 static int fbcon_scrolldelta(struct vc_data *vc, int lines)
 {
 	struct fb_info *info = registered_fb[con2fb_map[fg_console]];
+	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[fg_console];
 	int offset, limit, scrollback_old;
 
@@ -2520,9 +2592,11 @@ static int fbcon_scrolldelta(struct vc_d
 		offset += limit;
 	else if (offset >= limit)
 		offset -= limit;
-	info->var.xoffset = 0;
-	info->var.yoffset = offset * vc->vc_font.height;
-	update_var(vc->vc_num, info);
+
+	ops->var.xoffset = 0;
+	ops->var.yoffset = offset * vc->vc_font.height;
+	ops->update_start(info);
+
 	if (!scrollback_current)
 		fbcon_cursor(vc, CM_DRAW);
 	return 0;
@@ -2570,22 +2644,25 @@ static void fbcon_modechanged(struct fb_
 	if (!ops || ops->currcon < 0)
 		return;
 	vc = vc_cons[ops->currcon].d;
-	if (vc->vc_mode != KD_TEXT || registered_fb[con2fb_map[ops->currcon]] != info)
+	if (vc->vc_mode != KD_TEXT ||
+	    registered_fb[con2fb_map[ops->currcon]] != info)
 		return;
 
 	p = &fb_display[vc->vc_num];
-
-	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
+	set_blitting_type(vc, info, p);
 
 	if (CON_IS_VISIBLE(vc)) {
 		var_to_display(p, &info->var, info);
-		cols = info->var.xres / vc->vc_font.width;
-		rows = info->var.yres / vc->vc_font.height;
+		cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
+		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+		cols /= vc->vc_font.width;
+		rows /= vc->vc_font.height;
 		vc_resize(vc, cols, rows);
 		updatescrollmode(p, info, vc);
 		scrollback_max = 0;
 		scrollback_current = 0;
-		update_var(vc->vc_num, info);
+		ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
+		ops->update_start(info);
 		fbcon_set_palette(vc, color_table);
 		update_screen(vc);
 		if (softback_buf)
@@ -2610,18 +2687,20 @@ static void fbcon_set_all_vcs(struct fb_
 			continue;
 
 		p = &fb_display[vc->vc_num];
-
-		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
+		set_blitting_type(vc, info, p);
 		var_to_display(p, &info->var, info);
-		cols = info->var.xres / vc->vc_font.width;
-		rows = info->var.yres / vc->vc_font.height;
+		cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
+		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+		cols /= vc->vc_font.width;
+		rows /= vc->vc_font.height;
 		vc_resize(vc, cols, rows);
 
 		if (CON_IS_VISIBLE(vc)) {
 			updatescrollmode(p, info, vc);
 			scrollback_max = 0;
 			scrollback_current = 0;
-			update_var(vc->vc_num, info);
+			ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
+			ops->update_start(info);
 			fbcon_set_palette(vc, color_table);
 			update_screen(vc);
 			if (softback_buf)
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
index b68e0e2..846a5a4 100644
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -27,15 +27,15 @@
     */
 
 struct display {
-    /* Filled in by the frame buffer device */
-    u_short inverse;                /* != 0 text black on white as default */
     /* Filled in by the low-level console driver */
     const u_char *fontdata;
     int userfont;                   /* != 0 if fontdata kmalloc()ed */
     u_short scrollmode;             /* Scroll Method */
+    u_short inverse;                /* != 0 text black on white as default */
     short yscroll;                  /* Hardware scrolling */
     int vrows;                      /* number of virtual rows */
     int cursor_shape;
+    int con_rotate;
     u32 xres_virtual;
     u32 yres_virtual;
     u32 height;
@@ -52,6 +52,8 @@ struct display {
     struct fb_videomode *mode;
 };
 
+extern struct display fb_display[];
+
 struct fbcon_ops {
 	void (*bmove)(struct vc_data *vc, struct fb_info *info, int sy,
 		      int sx, int dy, int dx, int height, int width);
@@ -63,8 +65,12 @@ struct fbcon_ops {
 	void (*clear_margins)(struct vc_data *vc, struct fb_info *info,
 			      int bottom_only);
 	void (*cursor)(struct vc_data *vc, struct fb_info *info,
-		       struct display *p, int mode, int softback_lines, int fg, int bg);
-
+		       struct display *p, int mode, int softback_lines,
+		       int fg, int bg);
+	int  (*update_start)(struct fb_info *info);
+	int  (*rotate_font)(struct fb_info *info, struct vc_data *vc,
+			    struct display *p);
+	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
 	struct timer_list cursor_timer; /* Cursor timer */
 	struct fb_cursor cursor_state;
         int    currcon;	                /* Current VC. */
@@ -73,7 +79,12 @@ struct fbcon_ops {
 	int    blank_state;
 	int    graphics;
 	int    flags;
+	int    rotate;
+	int    cur_rotate;
 	char  *cursor_data;
+	u8    *fontbuffer;
+	u8    *fontdata;
+	u32    fd_size;
 };
     /*
      *  Attribute Decoding
@@ -168,4 +179,43 @@ extern void fbcon_set_tileops(struct vc_
 #endif
 extern void fbcon_set_bitops(struct fbcon_ops *ops);
 extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
+
+#define FBCON_ATTRIBUTE_UNDERLINE 1
+#define FBCON_ATTRIBUTE_REVERSE   2
+#define FBCON_ATTRIBUTE_BOLD      4
+
+static inline int real_y(struct display *p, int ypos)
+{
+	int rows = p->vrows;
+
+	ypos += p->yscroll;
+	return ypos < rows ? ypos : ypos - rows;
+}
+
+
+static inline int get_attribute(struct fb_info *info, u16 c)
+{
+	int attribute = 0;
+
+	if (fb_get_color_depth(&info->var, &info->fix) == 1) {
+		if (attr_underline(c))
+			attribute |= FBCON_ATTRIBUTE_UNDERLINE;
+		if (attr_reverse(c))
+			attribute |= FBCON_ATTRIBUTE_REVERSE;
+		if (attr_bold(c))
+			attribute |= FBCON_ATTRIBUTE_BOLD;
+	}
+
+	return attribute;
+}
+
+#define FBCON_SWAP(i,r,v) ({ \
+        typeof(r) _r = (r);  \
+        typeof(v) _v = (v);  \
+        (void) (&_r == &_v); \
+        (i == FB_ROTATE_UR || i == FB_ROTATE_UD) ? _r : _v; })
+
+#define fbcon_set_rotate(x) do {} while(0)
+
 #endif /* _VIDEO_FBCON_H */
+
diff --git a/drivers/video/console/tileblit.c b/drivers/video/console/tileblit.c
index 7f76e2c..cb25324 100644
--- a/drivers/video/console/tileblit.c
+++ b/drivers/video/console/tileblit.c
@@ -118,6 +118,18 @@ static void tile_cursor(struct vc_data *
 	info->tileops->fb_tilecursor(info, &cursor);
 }
 
+static int tile_update_start(struct fb_info *info)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+	int err;
+
+	err = fb_pan_display(info, &ops->var);
+	ops->var.xoffset = info->var.xoffset;
+	ops->var.yoffset = info->var.yoffset;
+	ops->var.vmode = info->var.vmode;
+	return err;
+}
+
 void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info,
 		       struct display *p, struct fbcon_ops *ops)
 {
@@ -128,6 +140,7 @@ void fbcon_set_tileops(struct vc_data *v
 	ops->putcs = tile_putcs;
 	ops->clear_margins = tile_clear_margins;
 	ops->cursor = tile_cursor;
+	ops->update_start = tile_update_start;
 
 	if (p) {
 		map.width = vc->vc_font.width;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index e7ff98e..51791dc 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -201,6 +201,14 @@ struct fb_bitfield {
 #define FB_VMODE_SMOOTH_XPAN	512	/* smooth xpan possible (internally used) */
 #define FB_VMODE_CONUPDATE	512	/* don't update x/yoffset	*/
 
+/*
+ * Display rotation support
+ */
+#define FB_ROTATE_UR      0
+#define FB_ROTATE_CW      1
+#define FB_ROTATE_UD      2
+#define FB_ROTATE_CCW     3
+
 #define PICOS2KHZ(a) (1000000000UL/(a))
 #define KHZ2PICOS(a) (1000000000UL/(a))
 
@@ -489,9 +497,9 @@ struct fb_cursor_user {
 #define FB_EVENT_MODE_DELETE            0x04
 /*      A driver registered itself */
 #define FB_EVENT_FB_REGISTERED          0x05
-/*      get console to framebuffer mapping */
+/*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
 #define FB_EVENT_GET_CONSOLE_MAP        0x06
-/*      set console to framebuffer mapping */
+/*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
 #define FB_EVENT_SET_CONSOLE_MAP        0x07
 /*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x08



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
