From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/9] fbdev: Fix greater than 1 bit monochrome color handling
Date: Sat, 20 Aug 2005 00:43:22 +0800
Message-ID: <43060C2A.6070609@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6HHP-0002OP-Jx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:32:11 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6HHO-0000oe-Tf
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:32:11 -0700
Received: by wproxy.gmail.com with SMTP id i21so610611wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Aug 2005 17:32:05 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Currently, fbcon assumes that the visual FB_VISUAL_MONO* is always 1 bit.
    According to Geert, there are old hardware where it's possible to have
    monochrome at 8-bit, but has only 2 colors, black - 0x00 and white - 0xff.
    Fix color handlers (fb_get_color_depth, and get_color) for this special case.

    From: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/bitblit.c |    2 -
 drivers/video/console/fbcon.c   |   26 ++++++++++++++++---------
 drivers/video/fbmem.c           |   41 +++++++++++++++++++++++++++-------------
 drivers/video/nvidia/nvidia.c   |    8 +++----
 include/linux/fb.h              |    3 +-
 5 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -39,7 +39,7 @@ static inline int get_attribute(struct f
 {
 	int attribute = 0;
 
-	if (fb_get_color_depth(&info->var) == 1) {
+	if (fb_get_color_depth(&info->var, &info->fix) == 1) {
 		if (attr_underline(c))
 			attribute |= FBCON_ATTRIBUTE_UNDERLINE;
 		if (attr_reverse(c))
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -214,7 +214,7 @@ static inline int fbcon_is_inactive(stru
 static inline int get_color(struct vc_data *vc, struct fb_info *info,
 	      u16 c, int is_fg)
 {
-	int depth = fb_get_color_depth(&info->var);
+	int depth = fb_get_color_depth(&info->var, &info->fix);
 	int color = 0;
 
 	if (console_blanked) {
@@ -230,9 +230,13 @@ static inline int get_color(struct vc_da
 	switch (depth) {
 	case 1:
 	{
+		int col = ~(0xfff << (max(info->var.green.length,
+					  max(info->var.red.length,
+					      info->var.blue.length)))) & 0xff;
+
 		/* 0 or 1 */
-		int fg = (info->fix.visual != FB_VISUAL_MONO01) ? 1 : 0;
-		int bg = (info->fix.visual != FB_VISUAL_MONO01) ? 0 : 1;
+		int fg = (info->fix.visual != FB_VISUAL_MONO01) ? col : 0;
+		int bg = (info->fix.visual != FB_VISUAL_MONO01) ? 0 : col;
 
 		if (console_blanked)
 			fg = bg;
@@ -246,7 +250,6 @@ static inline int get_color(struct vc_da
 		 * is grayscale.
 		 */
 		color /= 4;
-		break;
 	case 3:
 		/*
 		 * Last 8 entries of default 16-color palette is a more intense
@@ -426,7 +429,7 @@ static void fbcon_prepare_logo(struct vc
 	 * remove underline attribute from erase character
 	 * if black and white framebuffer.
 	 */
-	if (fb_get_color_depth(&info->var) == 1)
+	if (fb_get_color_depth(&info->var, &info->fix) == 1)
 		erase &= ~0x400;
 	logo_height = fb_prepare_logo(info);
 	logo_lines = (logo_height + vc->vc_font.height - 1) /
@@ -930,7 +933,7 @@ static void fbcon_init(struct vc_data *v
 	}
 	if (p->userfont)
 		charcnt = FNTCHARCNT(p->fontdata);
-	vc->vc_can_do_color = (fb_get_color_depth(&info->var) != 1);
+	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt == 256) {
 		vc->vc_hi_font_mask = 0;
@@ -1178,7 +1181,12 @@ static void fbcon_set_disp(struct fb_inf
 	if (p->userfont)
 		charcnt = FNTCHARCNT(p->fontdata);
 
-	vc->vc_can_do_color = (fb_get_color_depth(var) != 1);
+	var->activate = FB_ACTIVATE_NOW;
+	info->var.activate = var->activate;
+	info->var.yoffset = info->var.xoffset = 0;
+	fb_set_var(info, var);
+
+	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt == 256) {
 		vc->vc_hi_font_mask = 0;
@@ -1967,7 +1975,7 @@ static int fbcon_switch(struct vc_data *
 	set_blitting_type(vc, info, p);
 	((struct fbcon_ops *)info->fbcon_par)->cursor_reset = 1;
 
-	vc->vc_can_do_color = (fb_get_color_depth(&info->var) != 1);
+	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	updatescrollmode(p, info, vc);
 
@@ -2332,7 +2340,7 @@ static int fbcon_set_palette(struct vc_d
 	if (!CON_IS_VISIBLE(vc))
 		return 0;
 
-	depth = fb_get_color_depth(&info->var);
+	depth = fb_get_color_depth(&info->var, &info->fix);
 	if (depth > 3) {
 		for (i = j = 0; i < 16; i++) {
 			k = table[i];
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -62,16 +62,26 @@ int num_registered_fb;
  * Helpers
  */
 
-int fb_get_color_depth(struct fb_var_screeninfo *var)
+int fb_get_color_depth(struct fb_var_screeninfo *var,
+		       struct fb_fix_screeninfo *fix)
 {
-	if (var->green.length == var->blue.length &&
-	    var->green.length == var->red.length &&
-	    !var->green.offset && !var->blue.offset &&
-	    !var->red.offset)
-		return var->green.length;
-	else
-		return (var->green.length + var->red.length +
-			var->blue.length);
+	int depth = 0;
+
+	if (fix->visual == FB_VISUAL_MONO01 ||
+	    fix->visual == FB_VISUAL_MONO10)
+		depth = 1;
+	else {
+		if (var->green.length == var->blue.length &&
+		    var->green.length == var->red.length &&
+		    var->green.offset == var->blue.offset &&
+		    var->green.offset == var->red.offset)
+			depth = var->green.length;
+		else
+			depth = var->green.length + var->red.length +
+				var->blue.length;
+	}
+
+	return depth;
 }
 EXPORT_SYMBOL(fb_get_color_depth);
 
@@ -249,13 +259,18 @@ static void fb_set_logo(struct fb_info *
 			       const struct linux_logo *logo, u8 *dst,
 			       int depth)
 {
-	int i, j, k, fg = 1;
+	int i, j, k;
 	const u8 *src = logo->data;
-	u8 d, xor = (info->fix.visual == FB_VISUAL_MONO01) ? 0xff : 0;
+	u8 xor = (info->fix.visual == FB_VISUAL_MONO01) ? 0xff : 0;
+	u8 fg = 1, d;
 
-	if (fb_get_color_depth(&info->var) == 3)
+	if (fb_get_color_depth(&info->var, &info->fix) == 3)
 		fg = 7;
 
+	if (info->fix.visual == FB_VISUAL_MONO01 ||
+	    info->fix.visual == FB_VISUAL_MONO10)
+		fg = ~((u8) (0xfff << info->var.green.length));
+
 	switch (depth) {
 	case 4:
 		for (i = 0; i < logo->height; i++)
@@ -318,7 +333,7 @@ static struct logo_data {
 
 int fb_prepare_logo(struct fb_info *info)
 {
-	int depth = fb_get_color_depth(&info->var);
+	int depth = fb_get_color_depth(&info->var, &info->fix);
 
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -658,7 +658,7 @@ static int nvidia_calc_regs(struct fb_in
 {
 	struct nvidia_par *par = info->par;
 	struct _riva_hw_state *state = &par->ModeReg;
-	int i, depth = fb_get_color_depth(&info->var);
+	int i, depth = fb_get_color_depth(&info->var, &info->fix);
 	int h_display = info->var.xres / 8 - 1;
 	int h_start = (info->var.xres + info->var.right_margin) / 8 - 1;
 	int h_end = (info->var.xres + info->var.right_margin +
@@ -978,6 +978,9 @@ static int nvidiafb_set_par(struct fb_in
 	    !par->twoHeads)
 		par->FPDither = 0;
 
+	info->fix.visual = (info->var.bits_per_pixel == 8) ?
+	    FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
+
 	nvidia_init_vga(info);
 	nvidia_calc_regs(info);
 	nvidia_write_regs(par);
@@ -992,9 +995,6 @@ static int nvidiafb_set_par(struct fb_in
 	NVWriteCrtc(par, 0x11, 0x00);
 	info->fix.line_length = (info->var.xres_virtual *
 				 info->var.bits_per_pixel) >> 3;
-	info->fix.visual = (info->var.bits_per_pixel == 8) ?
-	    FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
-
 	if (info->var.accel_flags) {
 		info->fbops->fb_imageblit = nvidiafb_imageblit;
 		info->fbops->fb_fillrect = nvidiafb_fillrect;
diff --git a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -823,7 +823,8 @@ extern void fb_pad_unaligned_buffer(u8 *
 				u32 height, u32 shift_high, u32 shift_low, u32 mod);
 extern void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height);
 extern void fb_set_suspend(struct fb_info *info, int state);
-extern int fb_get_color_depth(struct fb_var_screeninfo *var);
+extern int fb_get_color_depth(struct fb_var_screeninfo *var,
+			      struct fb_fix_screeninfo *fix);
 extern int fb_get_options(char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
