From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/10] fbcon: Cursor fixes
Date: Sun, 6 Mar 2005 08:16:36 +0800
Message-ID: <200503060816.36158.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7jTy-00072M-PU
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:18:54 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7jTx-0002Vg-EG
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:18:54 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0A3E1149326E
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  6 Mar 2005 00:18:43 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jiri Benc <jbenc@suse.cz>

  From Jiri Benc:

  we found several bugs in framebuffer console code in recent kernels.

  1. The escape sequence '\033[?25l' does not work (should disable cursor).

  2. When scrolling console using Shift-PgUp with cursor in the upper half
     part of the screen, cursor position is not updated.

  3. If cursor is placed at some character and console is scrolled using
     Shift-PgUp, that character remains on the screen.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 bitblit.c  |   11 ++++++++++-
 fbcon.c    |   24 ++++++++++--------------
 fbcon.h    |    2 +-
 tileblit.c |    3 ++-
 4 files changed, 23 insertions(+), 17 deletions(-)

diff -Nru a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
--- a/drivers/video/console/bitblit.c	2005-02-21 20:43:09 +08:00
+++ b/drivers/video/console/bitblit.c	2005-02-23 17:50:11 +08:00
@@ -236,7 +236,7 @@
 }
 
 static void bit_cursor(struct vc_data *vc, struct fb_info *info,
-		       struct display *p, int mode, int fg, int bg)
+		       struct display *p, int mode, int softback_lines, int fg, int bg)
 {
 	struct fb_cursor cursor;
 	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
@@ -247,6 +247,15 @@
 	char *src;
 
 	cursor.set = 0;
+
+	if (softback_lines) {
+		if (y + softback_lines >= vc->vc_rows) {
+			mode = CM_ERASE;
+			ops->cursor_flash = 0;
+			return;
+		} else
+			y += softback_lines;
+	}
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-02-21 20:43:09 +08:00
+++ b/drivers/video/console/fbcon.c	2005-02-23 17:50:11 +08:00
@@ -279,7 +279,7 @@
 	c = scr_readw((u16 *) vc->vc_pos);
 	mode = (!ops->cursor_flash || ops->cursor_state.enable) ?
 		CM_ERASE : CM_DRAW;
-	ops->cursor(vc, info, p, mode, get_color(vc, info, c, 1),
+	ops->cursor(vc, info, p, mode, softback_lines, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
 	release_console_sem();
 }
@@ -1086,27 +1086,23 @@
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
-	int y = real_y(p, vc->vc_y);
+	int y;
  	int c = scr_readw((u16 *) vc->vc_pos);
 
 	if (fbcon_is_inactive(vc, info))
 		return;
 
-	ops->cursor_flash = 1;
+	ops->cursor_flash = (mode == CM_ERASE) ? 0 : 1;
 	if (mode & CM_SOFTBACK) {
 		mode &= ~CM_SOFTBACK;
-		if (softback_lines) {
-			if (y + softback_lines >= vc->vc_rows) {
-				mode = CM_ERASE;
-				ops->cursor_flash = 0;
-			}
-			else
-				y += softback_lines;
-		}
-	} else if (softback_lines)
-		fbcon_set_origin(vc);
+		y = softback_lines;
+	} else {
+		if (softback_lines)
+			fbcon_set_origin(vc);
+		y = 0;
+	}
 
-	ops->cursor(vc, info, p, mode, get_color(vc, info, c, 1),
+	ops->cursor(vc, info, p, mode, y, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
 	vbl_cursor_cnt = CURSOR_DRAW_DELAY;
 }
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2005-01-15 04:01:47 +08:00
+++ b/drivers/video/console/fbcon.h	2005-02-23 17:50:11 +08:00
@@ -59,7 +59,7 @@
 	void (*clear_margins)(struct vc_data *vc, struct fb_info *info,
 			      int bottom_only);
 	void (*cursor)(struct vc_data *vc, struct fb_info *info,
-		       struct display *p, int mode, int fg, int bg);
+		       struct display *p, int mode, int softback_lines, int fg, int bg);
 
 	struct timer_list cursor_timer; /* Cursor timer */
 	struct fb_cursor cursor_state;
diff -Nru a/drivers/video/console/tileblit.c b/drivers/video/console/tileblit.c
--- a/drivers/video/console/tileblit.c	2004-11-17 18:15:18 +08:00
+++ b/drivers/video/console/tileblit.c	2005-02-28 08:16:45 +08:00
@@ -81,7 +81,8 @@
 }
 
 static void tile_cursor(struct vc_data *vc, struct fb_info *info,
-			struct display *p, int mode, int fg, int bg)
+			struct display *p, int mode, int softback_lines,
+			int fg, int bg)
 {
 	struct fb_tilecursor cursor;
 	int use_sw = (vc->vc_cursor_type & 0x01);




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
