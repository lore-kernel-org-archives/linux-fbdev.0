From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/8] fbcon: Disable fbcon cursor if vt softcursor is enabled
Date: Thu, 11 Nov 2004 10:15:28 +0800
Message-ID: <20041111022443.6941F1A0228@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CS4dw-00052I-95
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:25:00 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CS4dt-0004RG-Tl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:24:58 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id EFD5B9D8353
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 11 Nov 2004 02:24:47 +0000 (UTC)
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
Cc: Gerd Knorr <kraxel@bytesex.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Problem reported by Gerd Knorr:

  (1) boot with vesafb (thats what I'm using, maybe it shows on other
      framebuffers and/or vgacon as well).
  (2) login into one terminal, then type "echo -ne '\033[?17;15;239c'".
      You should have a nice, yellow and *not* blinking cursor block.
      That is what I have in my .profile because I can't stand the
      blinking cursors.
  (3) Switch to another terminal.  The cursor goes into blinking
      underscore mode now (i.e. the default cursor).
  (4) Switch back to the first terminal.  Now you have a yellow block
      with the last two pixel lines (i.e. the underscore) blinking.

This bug is caused by both fbcon_cursor and vt softcursor being active at
the same time.

Fix:
- Disable fbcon_cursor if vt softcursor is active
  (vc->vc_cursor_type & 0x10) != 0.
- Recheck/reload fbcon cursor for each vt switch

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 bitblit.c  |   33 +++++++++++++++++++++------------
 fbcon.c    |    3 +++
 fbcon.h    |    1 +
 tileblit.c |    3 ++-
 4 files changed, 27 insertions(+), 13 deletions(-)

diff -Nru a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
--- a/drivers/video/console/bitblit.c	2004-10-23 02:52:37 +08:00
+++ b/drivers/video/console/bitblit.c	2004-11-09 10:36:30 +08:00
@@ -243,7 +243,7 @@
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.width + 7) >> 3, c;
 	int y = real_y(p, vc->vc_y);
-	int attribute;
+	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
 	char *src;
 
 	cursor.set = 0;
@@ -252,7 +252,8 @@
 	attribute = get_attribute(info, c);
 	src = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
 
-	if (ops->cursor_state.image.data != src) {
+	if (ops->cursor_state.image.data != src ||
+	    ops->cursor_reset) {
 	    ops->cursor_state.image.data = src;
 	    cursor.set |= FB_CUR_SETIMAGE;
 	}
@@ -271,34 +272,39 @@
 	}
 
 	if (ops->cursor_state.image.fg_color != fg ||
-	    ops->cursor_state.image.bg_color != bg) {
+	    ops->cursor_state.image.bg_color != bg ||
+	    ops->cursor_reset) {
 		ops->cursor_state.image.fg_color = fg;
 		ops->cursor_state.image.bg_color = bg;
 		cursor.set |= FB_CUR_SETCMAP;
 	}
 
 	if ((ops->cursor_state.image.dx != (vc->vc_font.width * vc->vc_x)) ||
-	    (ops->cursor_state.image.dy != (vc->vc_font.height * y))) {
+	    (ops->cursor_state.image.dy != (vc->vc_font.height * y)) ||
+	    ops->cursor_reset) {
 		ops->cursor_state.image.dx = vc->vc_font.width * vc->vc_x;
 		ops->cursor_state.image.dy = vc->vc_font.height * y;
 		cursor.set |= FB_CUR_SETPOS;
 	}
 
 	if (ops->cursor_state.image.height != vc->vc_font.height ||
-	    ops->cursor_state.image.width != vc->vc_font.width) {
+	    ops->cursor_state.image.width != vc->vc_font.width ||
+	    ops->cursor_reset) {
 		ops->cursor_state.image.height = vc->vc_font.height;
 		ops->cursor_state.image.width = vc->vc_font.width;
 		cursor.set |= FB_CUR_SETSIZE;
 	}
 
-	if (ops->cursor_state.hot.x || ops->cursor_state.hot.y) {
+	if (ops->cursor_state.hot.x || ops->cursor_state.hot.y ||
+	    ops->cursor_reset) {
 		ops->cursor_state.hot.x = cursor.hot.y = 0;
 		cursor.set |= FB_CUR_SETHOT;
 	}
 
-	if ((cursor.set & FB_CUR_SETSIZE) ||
-	    ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)
-	    || ops->cursor_state.mask == NULL) {
+	if (cursor.set & FB_CUR_SETSIZE ||
+	    vc->vc_cursor_type != p->cursor_shape ||
+	    ops->cursor_state.mask == NULL ||
+	    ops->cursor_reset) {
 		char *mask = kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
 		int cur_height, size, i = 0;
 		u8 msk = 0xff;
@@ -309,10 +315,11 @@
 		if (ops->cursor_state.mask)
 			kfree(ops->cursor_state.mask);
 		ops->cursor_state.mask = mask;
-		p->cursor_shape = vc->vc_cursor_type & 0x0f;
+
+		p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (vc->vc_cursor_type & 0x0f) {
+		switch (p->cursor_shape & CUR_HWMASK) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
@@ -348,7 +355,7 @@
 	case CM_DRAW:
 	case CM_MOVE:
 	default:
-		ops->cursor_state.enable = 1;
+		ops->cursor_state.enable = (use_sw) ? 0 : 1;
 		break;
 	}
 
@@ -367,6 +374,8 @@
 	cursor.rop = ROP_XOR;
 
 	info->fbops->fb_cursor(info, &cursor);
+
+	ops->cursor_reset = 0;
 }
 
 void fbcon_set_bitops(struct fbcon_ops *ops)
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-11-08 09:32:38 +08:00
+++ b/drivers/video/console/fbcon.c	2004-11-09 10:36:31 +08:00
@@ -1889,6 +1889,7 @@
 	int i, prev_console, do_set_par = 0;
 
 	info = registered_fb[con2fb_map[vc->vc_num]];
+
 	if (softback_top) {
 		int l = fbcon_softback_size / vc->vc_size_row;
 		if (softback_lines)
@@ -1904,6 +1905,7 @@
 			softback_top = 0;
 		}
 	}
+
 	if (logo_shown >= 0) {
 		struct vc_data *conp2 = vc_cons[logo_shown].d;
 
@@ -1953,6 +1955,7 @@
 	}
 
 	set_blitting_type(vc, info, p);
+	((struct fbcon_ops *)info->fbcon_par)->cursor_reset = 1;
 
 	vc->vc_can_do_color = (fb_get_color_depth(info) != 1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/console/fbcon.h	2004-11-09 10:36:31 +08:00
@@ -65,6 +65,7 @@
 	struct fb_cursor cursor_state;
         int    currcon;	                /* Current VC. */
 	int    cursor_flash;
+	int    cursor_reset;
 	char  *cursor_data;
 };
     /*
diff -Nru a/drivers/video/console/tileblit.c b/drivers/video/console/tileblit.c
--- a/drivers/video/console/tileblit.c	2004-10-19 20:23:16 +08:00
+++ b/drivers/video/console/tileblit.c	2004-11-09 16:29:13 +08:00
@@ -84,10 +84,11 @@
 			struct display *p, int mode, int fg, int bg)
 {
 	struct fb_tilecursor cursor;
+	int use_sw = (vc->vc_cursor_type & 0x01);
 
 	cursor.sx = vc->vc_x;
 	cursor.sy = vc->vc_y;
-	cursor.mode = (mode == CM_ERASE) ? 0 : 1;
+	cursor.mode = (mode == CM_ERASE || use_sw) ? 0 : 1;
 	cursor.fg = fg;
 	cursor.bg = bg;
 




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
