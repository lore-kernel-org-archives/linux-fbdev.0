From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:39 +0000
Subject: [PATCH 08/33] fbcon: s/struct display/struct fbcon_display/
Message-Id: <20190528090304.9388-9-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Prarit Bhargava <prarit@redhat.com>, Konstantin Khorenko <khorenko@virtuozzo.com>, Peter Rosin <peda@axentia.se>, Yisheng Xie <ysxie@foxmail.com>

This was formerly used in fbdev drivers (not sure why, predates most
git history), but now it's entirely an fbcon internal thing. Give it a
more specific name.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Peter Rosin <peda@axentia.se>
Cc: Yisheng Xie <ysxie@foxmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 74 ++++++++++++++++----------------
 drivers/video/fbdev/core/fbcon.h |  6 +--
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 786f9aab55df..5424051c8e1a 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -93,7 +93,7 @@ enum {
 	FBCON_LOGO_DONTSHOW	= -3	/* do not show the logo */
 };
 
-static struct display fb_display[MAX_NR_CONSOLES];
+static struct fbcon_display fb_display[MAX_NR_CONSOLES];
 
 static signed char con2fb_map[MAX_NR_CONSOLES];
 static signed char con2fb_map_boot[MAX_NR_CONSOLES];
@@ -185,11 +185,11 @@ static __inline__ void ywrap_up(struct vc_data *vc, int count);
 static __inline__ void ywrap_down(struct vc_data *vc, int count);
 static __inline__ void ypan_up(struct vc_data *vc, int count);
 static __inline__ void ypan_down(struct vc_data *vc, int count);
-static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy, int sx,
+static void fbcon_bmove_rec(struct vc_data *vc, struct fbcon_display *p, int sy, int sx,
 			    int dy, int dx, int height, int width, u_int y_break);
 static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 			   int unit);
-static void fbcon_redraw_move(struct vc_data *vc, struct display *p,
+static void fbcon_redraw_move(struct vc_data *vc, struct fbcon_display *p,
 			      int line, int count, int dy);
 static void fbcon_modechanged(struct fb_info *info);
 static void fbcon_set_all_vcs(struct fb_info *info);
@@ -220,7 +220,7 @@ static void fbcon_rotate(struct fb_info *info, u32 rotate)
 	fb_info = registered_fb[con2fb_map[ops->currcon]];
 
 	if (info = fb_info) {
-		struct display *p = &fb_display[ops->currcon];
+		struct fbcon_display *p = &fb_display[ops->currcon];
 
 		if (rotate < 4)
 			p->con_rotate = rotate;
@@ -235,7 +235,7 @@ static void fbcon_rotate_all(struct fb_info *info, u32 rotate)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct vc_data *vc;
-	struct display *p;
+	struct fbcon_display *p;
 	int i;
 
 	if (!ops || ops->currcon < 0 || rotate > 3)
@@ -900,7 +900,7 @@ static int set_con2fb_map(int unit, int newidx, int user)
  *  Low Level Operations
  */
 /* NOTE: fbcon cannot be __init: it may be called from do_take_over_console later */
-static int var_to_display(struct display *disp,
+static int var_to_display(struct fbcon_display *disp,
 			  struct fb_var_screeninfo *var,
 			  struct fb_info *info)
 {
@@ -925,7 +925,7 @@ static int var_to_display(struct display *disp,
 }
 
 static void display_to_var(struct fb_var_screeninfo *var,
-			   struct display *disp)
+			   struct fbcon_display *disp)
 {
 	fb_videomode_to_var(var, disp->mode);
 	var->xres_virtual = disp->xres_virtual;
@@ -946,7 +946,7 @@ static void display_to_var(struct fb_var_screeninfo *var,
 static const char *fbcon_startup(void)
 {
 	const char *display_desc = "frame buffer device";
-	struct display *p = &fb_display[fg_console];
+	struct fbcon_display *p = &fb_display[fg_console];
 	struct vc_data *vc = vc_cons[fg_console].d;
 	const struct font_desc *font = NULL;
 	struct module *owner;
@@ -1060,7 +1060,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 	struct fbcon_ops *ops;
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct vc_data *svc = *default_mode;
-	struct display *t, *p = &fb_display[vc->vc_num];
+	struct fbcon_display *t, *p = &fb_display[vc->vc_num];
 	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
 	int cap, ret;
 
@@ -1203,7 +1203,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 	ops->p = &fb_display[fg_console];
 }
 
-static void fbcon_free_font(struct display *p, bool freefont)
+static void fbcon_free_font(struct fbcon_display *p, bool freefont)
 {
 	if (freefont && p->userfont && p->fontdata && (--REFCOUNT(p->fontdata) = 0))
 		kfree(p->fontdata - FONT_EXTRA_WORDS * sizeof(int));
@@ -1215,7 +1215,7 @@ static void set_vc_hi_font(struct vc_data *vc, bool set);
 
 static void fbcon_deinit(struct vc_data *vc)
 {
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fb_info *info;
 	struct fbcon_ops *ops;
 	int idx;
@@ -1288,7 +1288,7 @@ static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	u_int y_break;
 
 	if (fbcon_is_inactive(vc, info))
@@ -1324,7 +1324,7 @@ static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
 			int count, int ypos, int xpos)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	if (!fbcon_is_inactive(vc, info))
@@ -1388,7 +1388,7 @@ static int scrollback_current = 0;
 static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 			   int unit)
 {
-	struct display *p, *t;
+	struct fbcon_display *p, *t;
 	struct vc_data **default_mode, *vc;
 	struct vc_data *svc;
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -1457,7 +1457,7 @@ static __inline__ void ywrap_up(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	
 	p->yscroll += count;
 	if (p->yscroll >= p->vrows)	/* Deal with wrap */
@@ -1476,7 +1476,7 @@ static __inline__ void ywrap_down(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	
 	p->yscroll -= count;
 	if (p->yscroll < 0)	/* Deal with wrap */
@@ -1494,7 +1494,7 @@ static __inline__ void ywrap_down(struct vc_data *vc, int count)
 static __inline__ void ypan_up(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	p->yscroll += count;
@@ -1519,7 +1519,7 @@ static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 
 	p->yscroll += count;
 
@@ -1542,7 +1542,7 @@ static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
 static __inline__ void ypan_down(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 	
 	p->yscroll -= count;
@@ -1567,7 +1567,7 @@ static __inline__ void ypan_down_redraw(struct vc_data *vc, int t, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 
 	p->yscroll -= count;
 
@@ -1587,7 +1587,7 @@ static __inline__ void ypan_down_redraw(struct vc_data *vc, int t, int count)
 	scrollback_current = 0;
 }
 
-static void fbcon_redraw_softback(struct vc_data *vc, struct display *p,
+static void fbcon_redraw_softback(struct vc_data *vc, struct fbcon_display *p,
 				  long delta)
 {
 	int count = vc->vc_rows;
@@ -1680,7 +1680,7 @@ static void fbcon_redraw_softback(struct vc_data *vc, struct display *p,
 	}
 }
 
-static void fbcon_redraw_move(struct vc_data *vc, struct display *p,
+static void fbcon_redraw_move(struct vc_data *vc, struct fbcon_display *p,
 			      int line, int count, int dy)
 {
 	unsigned short *s = (unsigned short *)
@@ -1715,7 +1715,7 @@ static void fbcon_redraw_move(struct vc_data *vc, struct display *p,
 }
 
 static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info *info,
-			struct display *p, int line, int count, int ycount)
+			struct fbcon_display *p, int line, int count, int ycount)
 {
 	int offset = ycount * vc->vc_cols;
 	unsigned short *d = (unsigned short *)
@@ -1764,7 +1764,7 @@ static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info *info,
 	}
 }
 
-static void fbcon_redraw(struct vc_data *vc, struct display *p,
+static void fbcon_redraw(struct vc_data *vc, struct fbcon_display *p,
 			 int line, int count, int offset)
 {
 	unsigned short *d = (unsigned short *)
@@ -1848,7 +1848,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 		enum con_scroll dir, unsigned int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int scroll_partial = info->flags & FBINFO_PARTIAL_PAN_OK;
 
 	if (fbcon_is_inactive(vc, info))
@@ -2052,7 +2052,7 @@ static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 			int height, int width)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	
 	if (fbcon_is_inactive(vc, info))
 		return;
@@ -2071,7 +2071,7 @@ static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 			p->vrows - p->yscroll);
 }
 
-static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy, int sx, 
+static void fbcon_bmove_rec(struct vc_data *vc, struct fbcon_display *p, int sy, int sx,
 			    int dy, int dx, int height, int width, u_int y_break)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
@@ -2113,7 +2113,7 @@ static void fbcon_bmove_rec(struct vc_data *vc, struct display *p, int sy, int s
 		   height, width);
 }
 
-static void updatescrollmode(struct display *p,
+static void updatescrollmode(struct fbcon_display *p,
 					struct fb_info *info,
 					struct vc_data *vc)
 {
@@ -2165,7 +2165,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
@@ -2210,7 +2210,7 @@ static int fbcon_switch(struct vc_data *vc)
 {
 	struct fb_info *info, *old_info = NULL;
 	struct fbcon_ops *ops;
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var;
 	int i, ret, prev_console, charcnt = 256;
 
@@ -2553,7 +2553,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize;
 	int cnt;
 	char *old_data = NULL;
@@ -2601,7 +2601,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
 
 static int fbcon_copy_font(struct vc_data *vc, int con)
 {
-	struct display *od = &fb_display[con];
+	struct fbcon_display *od = &fb_display[con];
 	struct console_font *f = &vc->vc_font;
 
 	if (od->fontdata = f->data)
@@ -2826,7 +2826,7 @@ static void fbcon_scrolldelta(struct vc_data *vc, int lines)
 {
 	struct fb_info *info = registered_fb[con2fb_map[fg_console]];
 	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *disp = &fb_display[fg_console];
+	struct fbcon_display *disp = &fb_display[fg_console];
 	int offset, limit, scrollback_old;
 
 	if (softback_top) {
@@ -2947,7 +2947,7 @@ static void fbcon_modechanged(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct vc_data *vc;
-	struct display *p;
+	struct fbcon_display *p;
 	int rows, cols;
 
 	if (!ops || ops->currcon < 0)
@@ -2987,7 +2987,7 @@ static void fbcon_set_all_vcs(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct vc_data *vc;
-	struct display *p;
+	struct fbcon_display *p;
 	int i, rows, cols, fg = -1;
 
 	if (!ops || ops->currcon < 0)
@@ -3022,7 +3022,7 @@ static int fbcon_mode_deleted(struct fb_info *info,
 			      struct fb_videomode *mode)
 {
 	struct fb_info *fb_info;
-	struct display *p;
+	struct fbcon_display *p;
 	int i, j, found = 0;
 
 	/* before deletion, ensure that mode is not in use */
@@ -3294,7 +3294,7 @@ static void fbcon_get_requirement(struct fb_info *info,
 				  struct fb_blit_caps *caps)
 {
 	struct vc_data *vc;
-	struct display *p;
+	struct fbcon_display *p;
 
 	if (caps->flags) {
 		int i, charcnt;
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 21912a3ba32f..20dea853765f 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -25,7 +25,7 @@
     *    low-level frame buffer device
     */
 
-struct display {
+struct fbcon_display {
     /* Filled in by the low-level console driver */
     const u_char *fontdata;
     int userfont;                   /* != 0 if fontdata kmalloc()ed */
@@ -68,7 +68,7 @@ struct fbcon_ops {
 	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
 	struct timer_list cursor_timer; /* Cursor timer */
 	struct fb_cursor cursor_state;
-	struct display *p;
+	struct fbcon_display *p;
 	struct fb_info *info;
         int    currcon;	                /* Current VC. */
 	int    cur_blink_jiffies;
@@ -225,7 +225,7 @@ extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
 #define FBCON_ATTRIBUTE_REVERSE   2
 #define FBCON_ATTRIBUTE_BOLD      4
 
-static inline int real_y(struct display *p, int ypos)
+static inline int real_y(struct fbcon_display *p, int ypos)
 {
 	int rows = p->vrows;
 
-- 
2.20.1
