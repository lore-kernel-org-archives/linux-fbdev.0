From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/10] fbdev: Capture modelist change event
Date: Sun, 6 Mar 2005 08:16:32 +0800
Message-ID: <200503060816.32253.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7jTp-000721-NS
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:18:45 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7jTo-0002V5-QH
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:18:45 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8A1D2736C9
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  6 Mar 2005 00:18:38 +0000 (UTC)
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

  Add capability to change private modelist.  It checks if the entries in the
  new modelist are acceptable, and if not, trimmed from the modelist.

  Also added a new event, FB_EVENT_NEW_MODELIST, sent by fbmem, and captured
  by fbcon to resize all consoles, if need be.

  Requires minor changes to new functions, ie, fb_get_color_depth().

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/bitblit.c |    2 -
 drivers/video/console/fbcon.c   |   68 +++++++++++++++++++++++++++++-----------
 drivers/video/fbmem.c           |   43 ++++++++++++++++++++++---
 drivers/video/fbsysfs.c         |   12 ++++++-
 drivers/video/modedb.c          |   42 ++++++++++++++++++++++++
 drivers/video/nvidia/nvidia.c   |    2 -
 include/linux/fb.h              |    7 +++-
 7 files changed, 149 insertions(+), 27 deletions(-)

diff -Nru a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
--- a/drivers/video/console/bitblit.c	2004-11-17 18:15:17 +08:00
+++ b/drivers/video/console/bitblit.c	2005-02-21 20:43:09 +08:00
@@ -39,7 +39,7 @@
 {
 	int attribute = 0;
 
-	if (fb_get_color_depth(info) == 1) {
+	if (fb_get_color_depth(&info->var) == 1) {
 		if (attr_underline(c))
 			attribute |= FBCON_ATTRIBUTE_UNDERLINE;
 		if (attr_reverse(c))
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-02-01 23:21:27 +08:00
+++ b/drivers/video/console/fbcon.c	2005-02-21 20:43:09 +08:00
@@ -182,8 +182,10 @@
 static __inline__ void ypan_down(struct vc_data *vc, int count);
 static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy, int sx,
 			    int dy, int dx, int height, int width, u_int y_break);
-static void fbcon_set_disp(struct fb_info *info, struct vc_data *vc);
-static void fbcon_preset_disp(struct fb_info *info, int unit);
+static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
+			   struct vc_data *vc);
+static void fbcon_preset_disp(struct fb_info *info, struct fb_var_screeninfo *var,
+			      int unit);
 static void fbcon_redraw_move(struct vc_data *vc, struct display *p,
 			      int line, int count, int dy);
 
@@ -209,7 +211,7 @@
 static inline int get_color(struct vc_data *vc, struct fb_info *info,
 	      u16 c, int is_fg)
 {
-	int depth = fb_get_color_depth(info);
+	int depth = fb_get_color_depth(&info->var);
 	int color = 0;
 
 	if (console_blanked) {
@@ -418,7 +420,7 @@
 	 * remove underline attribute from erase character
 	 * if black and white framebuffer.
 	 */
-	if (fb_get_color_depth(info) == 1)
+	if (fb_get_color_depth(&info->var) == 1)
 		erase &= ~0x400;
 	logo_height = fb_prepare_logo(info);
 	logo_lines = (logo_height + vc->vc_font.height - 1) /
@@ -595,9 +597,9 @@
 		info->fbops->fb_set_par(info);
 
 	if (vc)
-		fbcon_set_disp(info, vc);
+		fbcon_set_disp(info, &info->var, vc);
 	else
-		fbcon_preset_disp(info, unit);
+		fbcon_preset_disp(info, &info->var, unit);
 
 	if (show_logo) {
 		struct vc_data *fg_vc = vc_cons[fg_console].d;
@@ -917,7 +919,7 @@
 	}
 	if (p->userfont)
 		charcnt = FNTCHARCNT(p->fontdata);
-	vc->vc_can_do_color = (fb_get_color_depth(info) != 1);
+	vc->vc_can_do_color = (fb_get_color_depth(&info->var) != 1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt == 256) {
 		vc->vc_hi_font_mask = 0;
@@ -1123,13 +1125,14 @@
 /*
  * If no vc is existent yet, just set struct display
  */
-static void fbcon_preset_disp(struct fb_info *info, int unit)
+static void fbcon_preset_disp(struct fb_info *info, struct fb_var_screeninfo *var,
+			      int unit)
 {
 	struct display *p = &fb_display[unit];
 	struct display *t = &fb_display[fg_console];
 
-	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
-	if (var_to_display(p, &info->var, info))
+	var->xoffset = var->yoffset = p->yscroll = 0;
+	if (var_to_display(p, var, info))
 		return;
 
 	p->fontdata = t->fontdata;
@@ -1138,15 +1141,16 @@
 		REFCOUNT(p->fontdata)++;
 }
 
-static void fbcon_set_disp(struct fb_info *info, struct vc_data *vc)
+static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
+			   struct vc_data *vc)
 {
 	struct display *p = &fb_display[vc->vc_num], *t;
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct vc_data *svc = *default_mode;
 	int rows, cols, charcnt = 256;
 
-	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
-	if (var_to_display(p, &info->var, info))
+	var->xoffset = var->yoffset = p->yscroll = 0;
+	if (var_to_display(p, var, info))
 		return;
 	t = &fb_display[svc->vc_num];
 	if (!vc->vc_font.data) {
@@ -1160,7 +1164,7 @@
 	if (p->userfont)
 		charcnt = FNTCHARCNT(p->fontdata);
 
-	vc->vc_can_do_color = (fb_get_color_depth(info) != 1);
+	vc->vc_can_do_color = (fb_get_color_depth(var) != 1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt == 256) {
 		vc->vc_hi_font_mask = 0;
@@ -1175,8 +1179,8 @@
 	if (!*vc->vc_uni_pagedir_loc)
 		con_copy_unimap(vc, svc);
 
-	cols = info->var.xres / vc->vc_font.width;
-	rows = info->var.yres / vc->vc_font.height;
+	cols = var->xres / vc->vc_font.width;
+	rows = var->yres / vc->vc_font.height;
 	vc_resize(vc, cols, rows);
 	if (CON_IS_VISIBLE(vc)) {
 		update_screen(vc);
@@ -1955,7 +1959,7 @@
 	set_blitting_type(vc, info, p);
 	((struct fbcon_ops *)info->fbcon_par)->cursor_reset = 1;
 
-	vc->vc_can_do_color = (fb_get_color_depth(info) != 1);
+	vc->vc_can_do_color = (fb_get_color_depth(&info->var) != 1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	updatescrollmode(p, info, vc);
 
@@ -2326,7 +2330,7 @@
 	if (fbcon_is_inactive(vc, info))
 		return -EINVAL;
 
-	depth = fb_get_color_depth(info);
+	depth = fb_get_color_depth(&info->var);
 	if (depth > 3) {
 		for (i = j = 0; i < 16; i++) {
 			k = table[i];
@@ -2658,6 +2662,31 @@
 	ops->blank_state = blank;
 }
 
+static void fbcon_new_modelist(struct fb_info *info)
+{
+	int i;
+	struct vc_data *vc;
+	struct fb_var_screeninfo var;
+	struct fb_videomode *mode;
+
+	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+		if (registered_fb[con2fb_map[i]] != info)
+			continue;
+		if (!fb_display[i].mode)
+			continue;
+		vc = vc_cons[i].d;
+		display_to_var(&var, &fb_display[i]);
+		mode = fb_find_nearest_mode(&var, &info->modelist);
+		fb_videomode_to_var(&var, mode);
+
+		if (vc)
+			fbcon_set_disp(info, &var, vc);
+		else
+			fbcon_preset_disp(info, &var, i);
+
+	}
+}
+
 static int fbcon_event_notify(struct notifier_block *self, 
 			      unsigned long action, void *data)
 {
@@ -2695,6 +2724,9 @@
 		break;
 	case FB_EVENT_BLANK:
 		fbcon_fb_blanked(info, *(int *)event->data);
+		break;
+	case FB_EVENT_NEW_MODELIST:
+		fbcon_new_modelist(info);
 		break;
 	}
 
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2005-02-18 15:17:45 +08:00
+++ b/drivers/video/fbmem.c	2005-02-21 20:43:10 +08:00
@@ -62,10 +62,8 @@
  * Helpers
  */
 
-int fb_get_color_depth(struct fb_info *info)
+int fb_get_color_depth(struct fb_var_screeninfo *var)
 {
-	struct fb_var_screeninfo *var = &info->var;
-
 	if (var->green.length == var->blue.length &&
 	    var->green.length == var->red.length &&
 	    !var->green.offset && !var->blue.offset &&
@@ -300,7 +298,7 @@
 	const u8 *src = logo->data;
 	u8 d, xor = (info->fix.visual == FB_VISUAL_MONO01) ? 0xff : 0;
 
-	if (fb_get_color_depth(info) == 3)
+	if (fb_get_color_depth(&info->var) == 3)
 		fg = 7;
 
 	switch (depth) {
@@ -365,7 +363,7 @@
 
 int fb_prepare_logo(struct fb_info *info)
 {
-	int depth = fb_get_color_depth(info);
+	int depth = fb_get_color_depth(&info->var);
 
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
@@ -1209,6 +1207,40 @@
 }
 subsys_initcall(fbmem_init);
 
+int fb_new_modelist(struct fb_info *info)
+{
+	struct fb_event event;
+	struct fb_var_screeninfo var = info->var;
+	struct list_head *pos, *n;
+	struct fb_modelist *modelist;
+	struct fb_videomode *m, mode;
+	int err = 1;
+
+	list_for_each_safe(pos, n, &info->modelist) {
+		modelist = list_entry(pos, struct fb_modelist, list);
+		m = &modelist->mode;
+		fb_videomode_to_var(&var, m);
+		var.activate = FB_ACTIVATE_TEST;
+		err = fb_set_var(info, &var);
+		fb_var_to_videomode(&mode, &var);
+		if (err || !fb_mode_is_equal(m, &mode)) {
+			list_del(pos);
+			kfree(pos);
+		}
+	}
+
+	err = 1;
+
+	if (!list_empty(&info->modelist)) {
+		event.info = info;
+		err = notifier_call_chain(&fb_notifier_list,
+					   FB_EVENT_NEW_MODELIST,
+					   &event);
+	}
+
+	return err;
+}
+
 static char *video_options[FB_MAX];
 static int ofonly;
 
@@ -1321,5 +1353,6 @@
 EXPORT_SYMBOL(fb_register_client);
 EXPORT_SYMBOL(fb_unregister_client);
 EXPORT_SYMBOL(fb_get_options);
+EXPORT_SYMBOL(fb_new_modelist);
 
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c	2005-02-20 07:56:25 +08:00
+++ b/drivers/video/fbsysfs.c	2005-02-21 20:43:10 +08:00
@@ -151,13 +151,23 @@
 {
 	struct fb_info *fb_info =
 		(struct fb_info *)class_get_devdata(class_device);
+	LIST_HEAD(old_list);
 	int i = count / sizeof(struct fb_videomode);
+	
 	if (i * sizeof(struct fb_videomode) != count)
 		return -EINVAL;
 
-	fb_destroy_modelist(&fb_info->modelist);
+	acquire_console_sem();
+	list_splice(&fb_info->modelist, &old_list);
 	fb_videomode_to_modelist((struct fb_videomode *)buf, i,
 				 &fb_info->modelist);
+	if (fb_new_modelist(fb_info)) {
+		fb_destroy_modelist(&fb_info->modelist);
+		list_splice(&old_list, &fb_info->modelist);
+	} else 
+		fb_destroy_modelist(&old_list);
+
+	release_console_sem();
 
 	return 0;
 }
diff -Nru a/drivers/video/modedb.c b/drivers/video/modedb.c
--- a/drivers/video/modedb.c	2005-03-05 00:13:32 +08:00
+++ b/drivers/video/modedb.c	2005-02-21 20:43:10 +08:00
@@ -722,6 +722,47 @@
 }
 
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
+					  struct list_head *head)
+{
+	struct list_head *pos;
+	struct fb_modelist *modelist;
+	struct fb_videomode *mode, *best = NULL;
+	u32 diff = -1, diff_refresh = -1;
+
+	list_for_each(pos, head) {
+		u32 d;
+
+		modelist = list_entry(pos, struct fb_modelist, list);
+		mode = &modelist->mode;
+
+		d = abs(mode->xres - var->xres) + 
+			abs(mode->yres - var->yres);
+		if (diff > d) {
+			diff = d;
+			best = mode;
+		} else if (diff == d) {
+			d = abs(mode->refresh - best->refresh);
+			if (diff_refresh > d) {
+				diff_refresh = d;
+				best = mode;
+			}
+		}
+	}
+	
+	return best;
+}    
+
+/**
  * fb_match_mode - find a videomode which exactly matches the timings in var
  * @var: pointer to struct fb_var_screeninfo
  * @head: pointer to struct list_head of modelist
@@ -846,5 +887,6 @@
 EXPORT_SYMBOL(fb_destroy_modelist);
 EXPORT_SYMBOL(fb_match_mode);
 EXPORT_SYMBOL(fb_find_best_mode);
+EXPORT_SYMBOL(fb_find_nearest_mode);
 EXPORT_SYMBOL(fb_videomode_to_modelist);
 EXPORT_SYMBOL(fb_find_mode);
diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2005-03-05 00:35:05 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2005-02-21 20:43:10 +08:00
@@ -657,7 +657,7 @@
 {
 	struct nvidia_par *par = info->par;
 	struct _riva_hw_state *state = &par->ModeReg;
-	int i, depth = fb_get_color_depth(info);
+	int i, depth = fb_get_color_depth(&info->var);
 	int h_display = info->var.xres / 8 - 1;
 	int h_start = (info->var.xres + info->var.right_margin) / 8 - 1;
 	int h_end = (info->var.xres + info->var.right_margin +
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2005-02-18 15:17:45 +08:00
+++ b/include/linux/fb.h	2005-03-06 07:06:39 +08:00
@@ -493,6 +493,8 @@
 #define FB_EVENT_SET_CONSOLE_MAP        0x07
 /*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x08
+/*      Private modelist is to be replaced */
+#define FB_EVENT_NEW_MODELIST           0x09
 
 struct fb_event {
 	struct fb_info *info;
@@ -826,8 +828,9 @@
 				u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
 				u32 height);
 extern void fb_set_suspend(struct fb_info *info, int state);
-extern int fb_get_color_depth(struct fb_info *info);
+extern int fb_get_color_depth(struct fb_var_screeninfo *var);
 extern int fb_get_options(char *name, char **option);
+extern int fb_new_modelist(struct fb_info *info);
 
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
@@ -882,6 +885,8 @@
 					  struct list_head *head);
 extern struct fb_videomode *fb_find_best_mode(struct fb_var_screeninfo *var,
 					      struct list_head *head);
+extern struct fb_videomode *fb_find_nearest_mode(struct fb_var_screeninfo *var,
+						 struct list_head *head);
 extern void fb_destroy_modelist(struct list_head *head);
 extern void fb_videomode_to_modelist(struct fb_videomode *modedb, int num,
 				     struct list_head *head);




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
