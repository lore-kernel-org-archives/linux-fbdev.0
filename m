From: Thomas Pfaff <tpfaff@pcs.com>
Subject: [PATCH] fbcon: Fix color generation for
 monochrome framebuffer devices
Date: Wed, 28 Nov 2007 12:27:42 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711281201220.4293@lxtpfaff.pcs.ditec.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxL57-00088y-EB for Linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 03:27:53 -0800
Received: from mail.pcs.de ([145.253.69.50] helo=mail.pcs.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IxL54-000614-KJ
	for Linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 03:27:53 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel@lists.sourceforge.net

I missed an attr_fgcol_ec in tileblit.c, therefore i send updated patch. Sorry.

The current attr_fgcol_ec / attr_bgcol_ec macros do a simple shift of bits to 
get the color from vc_video_erase_char. For a monochrome display however the 
attribute does not contain any color, only attribute bits. Furthermore the 
reverse bit is lost because it is shifted out, the resulting color is always 0.

This can bee seen on a monochrome console either directly or by setting it to
inverse mode via "setterm -inversescreen on" . Text is written with correct
color, fb_fillrects from a bit_clear / bit_clear_margins will get wrong colors.

Kind Regards,
Thomas Pfaff

Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
---
diff -urp a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
--- a/drivers/video/console/bitblit.c	2007-10-09 22:31:38.000000000 +0200
+++ b/drivers/video/console/bitblit.c	2007-11-28 12:25:39.000000000 +0100
@@ -63,7 +63,7 @@ static void bit_clear(struct vc_data *vc
  	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
  	struct fb_fillrect region;

-	region.color = attr_bgcol_ec(bgshift, vc);
+	region.color = attr_bgcol_ec(bgshift, vc, info);
  	region.dx = sx * vc->vc_font.width;
  	region.dy = sy * vc->vc_font.height;
  	region.width = width * vc->vc_font.width;
@@ -213,7 +213,7 @@ static void bit_clear_margins(struct vc_
  	unsigned int bs = info->var.yres - bh;
  	struct fb_fillrect region;

-	region.color = attr_bgcol_ec(bgshift, vc);
+	region.color = attr_bgcol_ec(bgshift, vc, info);
  	region.rop = ROP_COPY;

  	if (rw && !bottom_only) {
diff -urp a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2007-10-09 22:31:38.000000000 +0200
+++ b/drivers/video/console/fbcon.c	2007-11-27 11:53:03.000000000 +0100
@@ -335,10 +335,7 @@ static inline int get_color(struct vc_da
  	switch (depth) {
  	case 1:
  	{
-		int col = ~(0xfff << (max(info->var.green.length,
-					  max(info->var.red.length,
-					      info->var.blue.length)))) & 0xff;
-
+		int col = mono_col(info);
  		/* 0 or 1 */
  		int fg = (info->fix.visual != FB_VISUAL_MONO01) ? col : 0;
  		int bg = (info->fix.visual != FB_VISUAL_MONO01) ? 0 : col;
diff -urp a/drivers/video/console/fbcon_ccw.c b/drivers/video/console/fbcon_ccw.c
--- a/drivers/video/console/fbcon_ccw.c	2007-10-09 22:31:38.000000000 +0200
+++ b/drivers/video/console/fbcon_ccw.c	2007-11-26 17:45:58.000000000 +0100
@@ -84,7 +84,7 @@ static void ccw_clear(struct vc_data *vc
  	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
  	u32 vyres = GETVYRES(ops->p->scrollmode, info);

-	region.color = attr_bgcol_ec(bgshift,vc);
+	region.color = attr_bgcol_ec(bgshift,vc,info);
  	region.dx = sy * vc->vc_font.height;
  	region.dy = vyres - ((sx + width) * vc->vc_font.width);
  	region.height = width * vc->vc_font.width;
@@ -198,7 +198,7 @@ static void ccw_clear_margins(struct vc_
  	struct fb_fillrect region;
  	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;

-	region.color = attr_bgcol_ec(bgshift,vc);
+	region.color = attr_bgcol_ec(bgshift,vc,info);
  	region.rop = ROP_COPY;

  	if (rw && !bottom_only) {
diff -urp a/drivers/video/console/fbcon_cw.c b/drivers/video/console/fbcon_cw.c
--- a/drivers/video/console/fbcon_cw.c	2007-10-09 22:31:38.000000000 +0200
+++ b/drivers/video/console/fbcon_cw.c	2007-11-26 17:46:39.000000000 +0100
@@ -70,7 +70,7 @@ static void cw_clear(struct vc_data *vc,
  	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
  	u32 vxres = GETVXRES(ops->p->scrollmode, info);

-	region.color = attr_bgcol_ec(bgshift,vc);
+	region.color = attr_bgcol_ec(bgshift,vc,info);
  	region.dx = vxres - ((sy + height) * vc->vc_font.height);
  	region.dy = sx *  vc->vc_font.width;
  	region.height = width * vc->vc_font.width;
@@ -182,7 +182,7 @@ static void cw_clear_margins(struct vc_d
  	struct fb_fillrect region;
  	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;

-	region.color = attr_bgcol_ec(bgshift,vc);
+	region.color = attr_bgcol_ec(bgshift,vc,info);
  	region.rop = ROP_COPY;

  	if (rw && !bottom_only) {
diff -urp a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2007-10-09 22:31:38.000000000 +0200
+++ b/drivers/video/console/fbcon.h	2007-11-27 14:36:39.000000000 +0100
@@ -93,10 +93,6 @@ struct fbcon_ops {
  	(((s) >> (fgshift)) & 0x0f)
  #define attr_bgcol(bgshift,s)    \
  	(((s) >> (bgshift)) & 0x0f)
-#define	attr_bgcol_ec(bgshift,vc) \
-	((vc) ? (((vc)->vc_video_erase_char >> (bgshift)) & 0x0f) : 0)
-#define attr_fgcol_ec(fgshift,vc) \
-	((vc) ? (((vc)->vc_video_erase_char >> (fgshift)) & 0x0f) : 0)

  /* Monochrome */
  #define attr_bold(s) \
@@ -108,6 +104,49 @@ struct fbcon_ops {
  #define attr_blink(s) \
  	((s) & 0x8000)

+#define mono_col(info)							\
+	(~(0xfff << (max((info)->var.green.length,			\
+			 max((info)->var.red.length,			\
+			     (info)->var.blue.length)))) & 0xff) 
+
+static inline int attr_col_ec(int shift, struct vc_data *vc,
+			      struct fb_info *info, int is_fg)
+{
+	int is_mono01;
+	int col;
+	int fg;
+	int bg;
+
+	if (!vc)
+		return 0;
+
+	if (vc->vc_can_do_color)
+		return is_fg ? attr_fgcol(shift,vc->vc_video_erase_char)
+			: attr_bgcol(shift,vc->vc_video_erase_char);
+
+	if (!info)
+		return 0;
+
+	col = mono_col(info);
+	is_mono01 = info->fix.visual == FB_VISUAL_MONO01;
+
+	if (attr_reverse(vc->vc_video_erase_char)) {
+		fg = is_mono01 ? col : 0;
+		bg = is_mono01 ? 0 : col;
+	}
+	else {
+		fg = is_mono01 ? 0 : col;
+		bg = is_mono01 ? col : 0;
+	}
+
+	return is_fg ? fg : bg;
+}
+
+#define attr_bgcol_ec(bgshift,vc,info)		\
+	attr_col_ec(bgshift,vc,info,0);
+#define attr_fgcol_ec(fgshift,vc,info)		\
+	attr_col_ec(fgshift,vc,info,1);
+
  /* Font */
  #define REFCOUNT(fd)	(((int *)(fd))[-1])
  #define FNTSIZE(fd)	(((int *)(fd))[-2])
diff -urp a/drivers/video/console/fbcon_ud.c b/drivers/video/console/fbcon_ud.c
--- a/drivers/video/console/fbcon_ud.c	2007-10-09 22:31:38.000000000 +0200
+++ b/drivers/video/console/fbcon_ud.c	2007-11-26 17:47:05.000000000 +0100
@@ -71,7 +71,7 @@ static void ud_clear(struct vc_data *vc,
  	u32 vyres = GETVYRES(ops->p->scrollmode, info);
  	u32 vxres = GETVXRES(ops->p->scrollmode, info);

-	region.color = attr_bgcol_ec(bgshift,vc);
+	region.color = attr_bgcol_ec(bgshift,vc,info);
  	region.dy = vyres - ((sy + height) * vc->vc_font.height);
  	region.dx = vxres - ((sx + width) *  vc->vc_font.width);
  	region.width = width * vc->vc_font.width;
@@ -228,7 +228,7 @@ static void ud_clear_margins(struct vc_d
  	struct fb_fillrect region;
  	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;

-	region.color = attr_bgcol_ec(bgshift,vc);
+	region.color = attr_bgcol_ec(bgshift,vc,info);
  	region.rop = ROP_COPY;

  	if (rw && !bottom_only) {
diff -urp a/drivers/video/console/tileblit.c b/drivers/video/console/tileblit.c
--- a/drivers/video/console/tileblit.c	2007-10-09 22:31:38.000000000 +0200
+++ b/drivers/video/console/tileblit.c	2007-11-28 11:59:57.000000000 +0100
@@ -40,8 +40,8 @@ static void tile_clear(struct vc_data *v

  	rect.index = vc->vc_video_erase_char &
  		((vc->vc_hi_font_mask) ? 0x1ff : 0xff);
-	rect.fg = attr_fgcol_ec(fgshift, vc);
-	rect.bg = attr_bgcol_ec(bgshift, vc);
+	rect.fg = attr_fgcol_ec(fgshift, vc, info);
+	rect.bg = attr_bgcol_ec(bgshift, vc, info);
  	rect.sx = sx;
  	rect.sy = sy;
  	rect.width = width;
diff -urp a/drivers/video/pmag-aa-fb.c b/drivers/video/pmag-aa-fb.c
--- a/drivers/video/pmag-aa-fb.c	2007-10-09 22:31:38.000000000 +0200
+++ b/drivers/video/pmag-aa-fb.c	2007-11-26 17:52:31.000000000 +0100
@@ -150,7 +150,7 @@ static int aafbcon_set_font(struct displ
  {
  	struct aafb_info *info = (struct aafb_info *)disp->fb_info;
  	struct aafb_cursor *c = &info->cursor;
-	u8 fgc = ~attr_bgcol_ec(disp, disp->conp);
+	u8 fgc = ~attr_bgcol_ec(disp, disp->conp, &info->info);

  	if (width > 64 || height > 64 || width < 0 || height < 0)
  		return -EINVAL;

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
