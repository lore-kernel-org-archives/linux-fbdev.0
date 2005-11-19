From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbcon: Sanitize fbcon
Date: Sat, 19 Nov 2005 10:01:28 +0800
Message-ID: <437E8778.7040808@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdI5L-0007LP-SF
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 18:04:11 -0800
Received: from zproxy.gmail.com ([64.233.162.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdI5L-0003Xw-1Z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 18:04:11 -0800
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
Cc: linux-fbdev-devel@lists.sf.net

Do not pass the structure display since fbcon is already keeping the
pointer to the current display.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/bitblit.c      |   14 +++++-----
 drivers/video/console/fbcon.c        |   49 ++++++++++++++++------------------
 drivers/video/console/fbcon.h        |   11 +++-----
 drivers/video/console/fbcon_ccw.c    |   17 ++++++------
 drivers/video/console/fbcon_cw.c     |   17 ++++++------
 drivers/video/console/fbcon_rotate.c |    9 +++---
 drivers/video/console/fbcon_ud.c     |   19 ++++++-------
 drivers/video/console/tileblit.c     |   17 ++++++------
 8 files changed, 71 insertions(+), 82 deletions(-)

diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
index e65fc3e..eea422e 100644
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -234,14 +234,14 @@ static void bit_clear_margins(struct vc_
 	}
 }
 
-static void bit_cursor(struct vc_data *vc, struct fb_info *info,
-		       struct display *p, int mode, int softback_lines, int fg, int bg)
+static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
+		       int softback_lines, int fg, int bg)
 {
 	struct fb_cursor cursor;
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fbcon_ops *ops = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.width + 7) >> 3, c;
-	int y = real_y(p, vc->vc_y);
+	int y = real_y(ops->p, vc->vc_y);
 	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
 	int err = 1;
 	char *src;
@@ -310,7 +310,7 @@ static void bit_cursor(struct vc_data *v
 	}
 
 	if (cursor.set & FB_CUR_SETSIZE ||
-	    vc->vc_cursor_type != p->cursor_shape ||
+	    vc->vc_cursor_type != ops->p->cursor_shape ||
 	    ops->cursor_state.mask == NULL ||
 	    ops->cursor_reset) {
 		char *mask = kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
@@ -323,10 +323,10 @@ static void bit_cursor(struct vc_data *v
 		kfree(ops->cursor_state.mask);
 		ops->cursor_state.mask = mask;
 
-		p->cursor_shape = vc->vc_cursor_type;
+		ops->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (p->cursor_shape & CUR_HWMASK) {
+		switch (ops->p->cursor_shape & CUR_HWMASK) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index bcea87c..efb5064 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -209,13 +209,13 @@ static irqreturn_t fb_vbl_detect(int irq
 #endif
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-static inline void fbcon_set_rotation(struct fb_info *info, struct display *p)
+static inline void fbcon_set_rotation(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	if (!(info->flags & FBINFO_MISC_TILEBLITTING) &&
-	    p->con_rotate < 4)
-		ops->rotate = p->con_rotate;
+	    ops->p->con_rotate < 4)
+		ops->rotate = ops->p->con_rotate;
 	else
 		ops->rotate = 0;
 }
@@ -265,7 +265,7 @@ static void fbcon_rotate_all(struct fb_i
 	fbcon_set_all_vcs(info);
 }
 #else
-static inline void fbcon_set_rotation(struct fb_info *info, struct display *p)
+static inline void fbcon_set_rotation(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
@@ -402,7 +402,7 @@ static void fb_flashcursor(void *private
 	c = scr_readw((u16 *) vc->vc_pos);
 	mode = (!ops->cursor_flash || ops->cursor_state.enable) ?
 		CM_ERASE : CM_DRAW;
-	ops->cursor(vc, info, p, mode, softback_lines, get_color(vc, info, c, 1),
+	ops->cursor(vc, info, mode, softback_lines, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
 	release_console_sem();
 }
@@ -647,29 +647,27 @@ static void fbcon_prepare_logo(struct vc
 }
 
 #ifdef CONFIG_FB_TILEBLITTING
-static void set_blitting_type(struct vc_data *vc, struct fb_info *info,
-			      struct display *p)
+static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	ops->p = (p) ? p : &fb_display[vc->vc_num];
+	ops->p = &fb_display[vc->vc_num];
 
 	if ((info->flags & FBINFO_MISC_TILEBLITTING))
-		fbcon_set_tileops(vc, info, p, ops);
+		fbcon_set_tileops(vc, info);
 	else {
-		fbcon_set_rotation(info, ops->p);
+		fbcon_set_rotation(info);
 		fbcon_set_bitops(ops);
 	}
 }
 #else
-static void set_blitting_type(struct vc_data *vc, struct fb_info *info,
-			      struct display *p)
+static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	info->flags &= ~FBINFO_MISC_TILEBLITTING;
-	ops->p = (p) ? p : &fb_display[vc->vc_num];
-	fbcon_set_rotation(info, ops->p);
+	ops->p = &fb_display[vc->vc_num];
+	fbcon_set_rotation(info);
 	fbcon_set_bitops(ops);
 }
 #endif /* CONFIG_MISC_TILEBLITTING */
@@ -697,7 +695,7 @@ static int con2fb_acquire_newinfo(struct
 	if (!err) {
 		memset(ops, 0, sizeof(struct fbcon_ops));
 		info->fbcon_par = ops;
-		set_blitting_type(vc, info, NULL);
+		set_blitting_type(vc, info);
 	}
 
 	if (err) {
@@ -933,7 +931,7 @@ static const char *fbcon_startup(void)
 	ops->cur_rotate = -1;
 	info->fbcon_par = ops;
 	p->con_rotate = rotate;
-	set_blitting_type(vc, info, NULL);
+	set_blitting_type(vc, info);
 
 	if (info->fix.type != FB_TYPE_TEXT) {
 		if (fbcon_softback_size) {
@@ -1093,7 +1091,7 @@ static void fbcon_init(struct vc_data *v
 
 	ops = info->fbcon_par;
 	p->con_rotate = rotate;
-	set_blitting_type(vc, info, NULL);
+	set_blitting_type(vc, info);
 
 	cols = vc->vc_cols;
 	rows = vc->vc_rows;
@@ -1141,9 +1139,9 @@ static void fbcon_init(struct vc_data *v
 	if (vc == svc && softback_buf)
 		fbcon_update_softback(vc);
 
-	if (ops->rotate_font && ops->rotate_font(info, vc, p)) {
+	if (ops->rotate_font && ops->rotate_font(info, vc)) {
 		ops->rotate = FB_ROTATE_UR;
-		set_blitting_type(vc, info, p);
+		set_blitting_type(vc, info);
 	}
 
 }
@@ -1243,7 +1241,6 @@ static void fbcon_cursor(struct vc_data 
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[vc->vc_num];
 	int y;
  	int c = scr_readw((u16 *) vc->vc_pos);
 
@@ -1260,7 +1257,7 @@ static void fbcon_cursor(struct vc_data 
 		y = 0;
 	}
 
-	ops->cursor(vc, info, p, mode, y, get_color(vc, info, c, 1),
+	ops->cursor(vc, info, mode, y, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
 	vbl_cursor_cnt = CURSOR_DRAW_DELAY;
 }
@@ -2110,12 +2107,12 @@ static int fbcon_switch(struct vc_data *
 		fbcon_add_cursor_timer(info);
 	}
 
-	set_blitting_type(vc, info, p);
+	set_blitting_type(vc, info);
 	ops->cursor_reset = 1;
 
-	if (ops->rotate_font && ops->rotate_font(info, vc, p)) {
+	if (ops->rotate_font && ops->rotate_font(info, vc)) {
 		ops->rotate = FB_ROTATE_UR;
-		set_blitting_type(vc, info, p);
+		set_blitting_type(vc, info);
 	}
 
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
@@ -2724,7 +2721,7 @@ static void fbcon_modechanged(struct fb_
 		return;
 
 	p = &fb_display[vc->vc_num];
-	set_blitting_type(vc, info, p);
+	set_blitting_type(vc, info);
 
 	if (CON_IS_VISIBLE(vc)) {
 		var_to_display(p, &info->var, info);
@@ -2762,7 +2759,7 @@ static void fbcon_set_all_vcs(struct fb_
 			continue;
 
 		p = &fb_display[vc->vc_num];
-		set_blitting_type(vc, info, p);
+		set_blitting_type(vc, info);
 		var_to_display(p, &info->var, info);
 		cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
 		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
index 6892e7f..c38c3d8 100644
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -62,12 +62,10 @@ struct fbcon_ops {
 		      int fg, int bg);
 	void (*clear_margins)(struct vc_data *vc, struct fb_info *info,
 			      int bottom_only);
-	void (*cursor)(struct vc_data *vc, struct fb_info *info,
-		       struct display *p, int mode, int softback_lines,
-		       int fg, int bg);
+	void (*cursor)(struct vc_data *vc, struct fb_info *info, int mode,
+		       int softback_lines, int fg, int bg);
 	int  (*update_start)(struct fb_info *info);
-	int  (*rotate_font)(struct fb_info *info, struct vc_data *vc,
-			    struct display *p);
+	int  (*rotate_font)(struct fb_info *info, struct vc_data *vc);
 	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
 	struct timer_list cursor_timer; /* Cursor timer */
 	struct fb_cursor cursor_state;
@@ -173,8 +171,7 @@ struct fbcon_ops {
 #define SCROLL_PAN_REDRAW  0x005
 
 #ifdef CONFIG_FB_TILEBLITTING
-extern void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info,
-			      struct display *p, struct fbcon_ops *ops);
+extern void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info);
 #endif
 extern void fbcon_set_bitops(struct fbcon_ops *ops);
 extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
diff --git a/drivers/video/console/fbcon_ccw.c b/drivers/video/console/fbcon_ccw.c
index 3afd1ee..1b163a7 100644
--- a/drivers/video/console/fbcon_ccw.c
+++ b/drivers/video/console/fbcon_ccw.c
@@ -219,19 +219,18 @@ static void ccw_clear_margins(struct vc_
 	}
 }
 
-static void ccw_cursor(struct vc_data *vc, struct fb_info *info,
-		      struct display *p, int mode, int softback_lines,
-		      int fg, int bg)
+static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
+		       int softback_lines, int fg, int bg)
 {
 	struct fb_cursor cursor;
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fbcon_ops *ops = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.height + 7) >> 3, c;
-	int y = real_y(p, vc->vc_y);
+	int y = real_y(ops->p, vc->vc_y);
 	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
 	int err = 1, dx, dy;
 	char *src;
-	u32 vyres = GETVYRES(p->scrollmode, info);
+	u32 vyres = GETVYRES(ops->p->scrollmode, info);
 
 	if (!ops->fontbuffer)
 		return;
@@ -303,7 +302,7 @@ static void ccw_cursor(struct vc_data *v
 	}
 
 	if (cursor.set & FB_CUR_SETSIZE ||
-	    vc->vc_cursor_type != p->cursor_shape ||
+	    vc->vc_cursor_type != ops->p->cursor_shape ||
 	    ops->cursor_state.mask == NULL ||
 	    ops->cursor_reset) {
 		char *tmp, *mask = kmalloc(w*vc->vc_font.width, GFP_ATOMIC);
@@ -323,10 +322,10 @@ static void ccw_cursor(struct vc_data *v
 		kfree(ops->cursor_state.mask);
 		ops->cursor_state.mask = mask;
 
-		p->cursor_shape = vc->vc_cursor_type;
+		ops->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (p->cursor_shape & CUR_HWMASK) {
+		switch (ops->p->cursor_shape & CUR_HWMASK) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
diff --git a/drivers/video/console/fbcon_cw.c b/drivers/video/console/fbcon_cw.c
index 6d92b84..d44c5fa 100644
--- a/drivers/video/console/fbcon_cw.c
+++ b/drivers/video/console/fbcon_cw.c
@@ -203,19 +203,18 @@ static void cw_clear_margins(struct vc_d
 	}
 }
 
-static void cw_cursor(struct vc_data *vc, struct fb_info *info,
-		      struct display *p, int mode, int softback_lines,
-		      int fg, int bg)
+static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
+		      int softback_lines, int fg, int bg)
 {
 	struct fb_cursor cursor;
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fbcon_ops *ops = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.height + 7) >> 3, c;
-	int y = real_y(p, vc->vc_y);
+	int y = real_y(ops->p, vc->vc_y);
 	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
 	int err = 1, dx, dy;
 	char *src;
-	u32 vxres = GETVXRES(p->scrollmode, info);
+	u32 vxres = GETVXRES(ops->p->scrollmode, info);
 
 	if (!ops->fontbuffer)
 		return;
@@ -287,7 +286,7 @@ static void cw_cursor(struct vc_data *vc
 	}
 
 	if (cursor.set & FB_CUR_SETSIZE ||
-	    vc->vc_cursor_type != p->cursor_shape ||
+	    vc->vc_cursor_type != ops->p->cursor_shape ||
 	    ops->cursor_state.mask == NULL ||
 	    ops->cursor_reset) {
 		char *tmp, *mask = kmalloc(w*vc->vc_font.width, GFP_ATOMIC);
@@ -307,10 +306,10 @@ static void cw_cursor(struct vc_data *vc
 		kfree(ops->cursor_state.mask);
 		ops->cursor_state.mask = mask;
 
-		p->cursor_shape = vc->vc_cursor_type;
+		ops->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (p->cursor_shape & CUR_HWMASK) {
+		switch (ops->p->cursor_shape & CUR_HWMASK) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
diff --git a/drivers/video/console/fbcon_rotate.c b/drivers/video/console/fbcon_rotate.c
index ec0dd8f..2dc091f 100644
--- a/drivers/video/console/fbcon_rotate.c
+++ b/drivers/video/console/fbcon_rotate.c
@@ -18,8 +18,7 @@
 #include "fbcon.h"
 #include "fbcon_rotate.h"
 
-static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc,
-			     struct display *p)
+static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	int len, err = 0;
@@ -28,12 +27,12 @@ static int fbcon_rotate_font(struct fb_i
 	u8 *dst;
 
 	if (vc->vc_font.data == ops->fontdata &&
-	    p->con_rotate == ops->cur_rotate)
+	    ops->p->con_rotate == ops->cur_rotate)
 		goto finished;
 
 	src = ops->fontdata = vc->vc_font.data;
-	ops->cur_rotate = p->con_rotate;
-	len = (!p->userfont) ? 256 : FNTCHARCNT(src);
+	ops->cur_rotate = ops->p->con_rotate;
+	len = (!ops->p->userfont) ? 256 : FNTCHARCNT(src);
 	s_cellsize = ((vc->vc_font.width + 7)/8) *
 		vc->vc_font.height;
 	d_cellsize = s_cellsize;
diff --git a/drivers/video/console/fbcon_ud.c b/drivers/video/console/fbcon_ud.c
index c4d7c89..663592e 100644
--- a/drivers/video/console/fbcon_ud.c
+++ b/drivers/video/console/fbcon_ud.c
@@ -249,20 +249,19 @@ static void ud_clear_margins(struct vc_d
 	}
 }
 
-static void ud_cursor(struct vc_data *vc, struct fb_info *info,
-		      struct display *p, int mode, int softback_lines,
-		      int fg, int bg)
+static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
+		      int softback_lines, int fg, int bg)
 {
 	struct fb_cursor cursor;
-	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+	struct fbcon_ops *ops = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.width + 7) >> 3, c;
-	int y = real_y(p, vc->vc_y);
+	int y = real_y(ops->p, vc->vc_y);
 	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
 	int err = 1, dx, dy;
 	char *src;
-	u32 vyres = GETVYRES(p->scrollmode, info);
-	u32 vxres = GETVXRES(p->scrollmode, info);
+	u32 vyres = GETVYRES(ops->p->scrollmode, info);
+	u32 vxres = GETVXRES(ops->p->scrollmode, info);
 
 	if (!ops->fontbuffer)
 		return;
@@ -334,7 +333,7 @@ static void ud_cursor(struct vc_data *vc
 	}
 
 	if (cursor.set & FB_CUR_SETSIZE ||
-	    vc->vc_cursor_type != p->cursor_shape ||
+	    vc->vc_cursor_type != ops->p->cursor_shape ||
 	    ops->cursor_state.mask == NULL ||
 	    ops->cursor_reset) {
 		char *mask = kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
@@ -347,10 +346,10 @@ static void ud_cursor(struct vc_data *vc
 		kfree(ops->cursor_state.mask);
 		ops->cursor_state.mask = mask;
 
-		p->cursor_shape = vc->vc_cursor_type;
+		ops->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (p->cursor_shape & CUR_HWMASK) {
+		switch (ops->p->cursor_shape & CUR_HWMASK) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
diff --git a/drivers/video/console/tileblit.c b/drivers/video/console/tileblit.c
index cb25324..153352c 100644
--- a/drivers/video/console/tileblit.c
+++ b/drivers/video/console/tileblit.c
@@ -80,9 +80,8 @@ static void tile_clear_margins(struct vc
 	return;
 }
 
-static void tile_cursor(struct vc_data *vc, struct fb_info *info,
-			struct display *p, int mode, int softback_lines,
-			int fg, int bg)
+static void tile_cursor(struct vc_data *vc, struct fb_info *info, int mode,
+			int softback_lines, int fg, int bg)
 {
 	struct fb_tilecursor cursor;
 	int use_sw = (vc->vc_cursor_type & 0x01);
@@ -130,10 +129,10 @@ static int tile_update_start(struct fb_i
 	return err;
 }
 
-void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info,
-		       struct display *p, struct fbcon_ops *ops)
+void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info)
 {
 	struct fb_tilemap map;
+	struct fbcon_ops *ops = info->fbcon_par;
 
 	ops->bmove = tile_bmove;
 	ops->clear = tile_clear;
@@ -142,13 +141,13 @@ void fbcon_set_tileops(struct vc_data *v
 	ops->cursor = tile_cursor;
 	ops->update_start = tile_update_start;
 
-	if (p) {
+	if (ops->p) {
 		map.width = vc->vc_font.width;
 		map.height = vc->vc_font.height;
 		map.depth = 1;
-		map.length = (p->userfont) ?
-			FNTCHARCNT(p->fontdata) : 256;
-		map.data = p->fontdata;
+		map.length = (ops->p->userfont) ?
+			FNTCHARCNT(ops->p->fontdata) : 256;
+		map.data = ops->p->fontdata;
 		info->tileops->fb_settile(info, &map);
 	}
 }




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
