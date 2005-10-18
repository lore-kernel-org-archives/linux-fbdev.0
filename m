From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/17] fbcon: Consolidate redundant code
Date: Tue, 18 Oct 2005 17:14:01 +0800
Message-ID: <4354BCD9.7050704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyHs-0000Zv-H3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:20 -0700
Received: from zproxy.gmail.com ([64.233.162.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyHs-0002JW-3R
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:20 -0700
Received: by zproxy.gmail.com with SMTP id i11so1232857nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:42:18 -0700 (PDT)
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

Lot's of redundant code scattered throughout fbcon.c. Consolidate them all
into one function, fbcon_update_softback().

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 fbcon.c |   85 +++++++++++++++++-----------------------------------------------
 1 files changed, 23 insertions(+), 62 deletions(-)


diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -281,6 +281,18 @@ static inline int get_color(struct vc_da
 	return color;
 }
 
+static void fbcon_update_softback(struct vc_data *vc)
+{
+	int l = fbcon_softback_size / vc->vc_size_row;
+
+	if (l > 5)
+		softback_end = softback_buf + l * vc->vc_size_row;
+	else
+		/* Smaller scrollback makes no sense, and 0 would screw
+		   the operation totally */
+		softback_top = 0;
+}
+
 static void fb_flashcursor(void *private)
 {
 	struct fb_info *info = private;
@@ -1007,16 +1019,8 @@ static void fbcon_init(struct vc_data *v
 	if (logo)
 		fbcon_prepare_logo(vc, info, cols, rows, new_cols, new_rows);
 
-	if (vc == svc && softback_buf) {
-		int l = fbcon_softback_size / vc->vc_size_row;
-		if (l > 5)
-			softback_end = softback_buf + l * vc->vc_size_row;
-		else {
-			/* Smaller scrollback makes no sense, and 0 would screw
-			   the operation totally */
-			softback_top = 0;
-		}
-	}
+	if (vc == svc && softback_buf)
+		fbcon_update_softback(vc);
 }
 
 static void fbcon_deinit(struct vc_data *vc)
@@ -1223,18 +1227,8 @@ static void fbcon_set_disp(struct fb_inf
 	vc_resize(vc, cols, rows);
 	if (CON_IS_VISIBLE(vc)) {
 		update_screen(vc);
-		if (softback_buf) {
-			int l = fbcon_softback_size / vc->vc_size_row;
-
-			if (l > 5)
-				softback_end = softback_buf + l *
-					vc->vc_size_row;
-			else {
-				/* Smaller scrollback makes no sense, and 0
-				   would screw the operation totally */
-				softback_top = 0;
-			}
-		}
+		if (softback_buf)
+			fbcon_update_softback(vc);
 	}
 }
 
@@ -1933,19 +1927,11 @@ static int fbcon_switch(struct vc_data *
 	info = registered_fb[con2fb_map[vc->vc_num]];
 
 	if (softback_top) {
-		int l = fbcon_softback_size / vc->vc_size_row;
 		if (softback_lines)
 			fbcon_set_origin(vc);
 		softback_top = softback_curr = softback_in = softback_buf;
 		softback_lines = 0;
-
-		if (l > 5)
-			softback_end = softback_buf + l * vc->vc_size_row;
-		else {
-			/* Smaller scrollback makes no sense, and 0 would screw
-			   the operation totally */
-			softback_top = 0;
-		}
+		fbcon_update_softback(vc);
 	}
 
 	if (logo_shown >= 0) {
@@ -2235,17 +2221,8 @@ static int fbcon_do_set_font(struct vc_d
 		/* reset wrap/pan */
 		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
 		vc_resize(vc, info->var.xres / w, info->var.yres / h);
-		if (CON_IS_VISIBLE(vc) && softback_buf) {
-			int l = fbcon_softback_size / vc->vc_size_row;
-			if (l > 5)
-				softback_end =
-				    softback_buf + l * vc->vc_size_row;
-			else {
-				/* Smaller scrollback makes no sense, and 0 would screw
-				   the operation totally */
-				softback_top = 0;
-			}
-		}
+		if (CON_IS_VISIBLE(vc) && softback_buf)
+			fbcon_update_softback(vc);
 	} else if (CON_IS_VISIBLE(vc)
 		   && vc->vc_mode == KD_TEXT) {
 		fbcon_clear_margins(vc, 0);
@@ -2615,16 +2592,8 @@ static void fbcon_modechanged(struct fb_
 		update_var(vc->vc_num, info);
 		fbcon_set_palette(vc, color_table);
 		update_screen(vc);
-		if (softback_buf) {
-			int l = fbcon_softback_size / vc->vc_size_row;
-			if (l > 5)
-				softback_end = softback_buf + l * vc->vc_size_row;
-			else {
-				/* Smaller scrollback makes no sense, and 0
-				   would screw the operation totally */
-				softback_top = 0;
-			}
-		}
+		if (softback_buf)
+			fbcon_update_softback(vc);
 	}
 }
 
@@ -2659,16 +2628,8 @@ static void fbcon_set_all_vcs(struct fb_
 			update_var(vc->vc_num, info);
 			fbcon_set_palette(vc, color_table);
 			update_screen(vc);
-			if (softback_buf) {
-				int l = fbcon_softback_size / vc->vc_size_row;
-				if (l > 5)
-					softback_end = softback_buf + l * vc->vc_size_row;
-				else {
-					/* Smaller scrollback makes no sense, and 0
-					   would screw the operation totally */
-					softback_top = 0;
-				}
-			}
+			if (softback_buf)
+				fbcon_update_softback(vc);
 		}
 	}
 }




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
