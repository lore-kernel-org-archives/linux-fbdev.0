From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH] fbcon: Another fix for fbcon generic blanking code
Date: Thu, 4 Nov 2004 16:47:12 +0800
Message-ID: <200411041647.13799.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPdOA-0000kj-Mz
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 00:54:38 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPdO9-0003K6-8Y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 00:54:38 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 74423971870
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  4 Nov 2004 08:54:24 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

If the driver has no fb_blank hook, then the generic method is to clear the
screen and then disallow writes to the framebuffer.  However, if the console
is leaving graphics mode (KD_GRAPHICS), it would update the screen
first, then unblank.  However, since writes to the framebuffers are
disallowed, the update failes, and upon unblank, the screen is left empty
except for the flashing cursor.  (This happens, for example when switching
from X to console).

The fix is to allow writes to the framebuffer even if the console is blanked.
To imitate a blank screen, the get_color() function will return the
attributes of the erase character (black on black) if the console is blanked
and if the driver has no fb_blank hook.

I think this fixes the rest of the major bugs in the blanking code.  

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-11-03 10:19:37 +08:00
+++ b/drivers/video/console/fbcon.c	2004-11-04 16:26:10 +08:00
@@ -203,8 +203,7 @@
 static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
 {
 	return (info->state != FBINFO_STATE_RUNNING ||
-		vt_cons[vc->vc_num]->vc_mode != KD_TEXT ||
-		(console_blanked && info->fbops->fb_blank));
+		vt_cons[vc->vc_num]->vc_mode != KD_TEXT);
 }
 
 static inline int get_color(struct vc_data *vc, struct fb_info *info,
@@ -213,6 +212,12 @@
 	int depth = fb_get_color_depth(info);
 	int color = 0;
 
+	if (!info->fbops->fb_blank && console_blanked) {
+		unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+
+		c = vc->vc_video_erase_char & charmask;
+	}
+
 	if (depth != 1)
 		color = (is_fg) ? attr_fgcol((vc->vc_hi_font_mask) ? 9 : 8, c)
 			: attr_bgcol((vc->vc_hi_font_mask) ? 13 : 12, c);
@@ -224,6 +229,9 @@
 		int fg = (info->fix.visual != FB_VISUAL_MONO01) ? 1 : 0;
 		int bg = (info->fix.visual != FB_VISUAL_MONO01) ? 0 : 1;
 
+		if (!info->fbops->fb_blank && console_blanked)
+			fg = bg;
+
 		color = (is_fg) ? fg : bg;
 		break;
 	}
@@ -244,6 +252,7 @@
 		break;
 	}
 
+
 	return color;
 }
 
@@ -1939,9 +1948,8 @@
 
 	update_var(vc->vc_num, info);
 	fbcon_set_palette(vc, color_table); 	
+	fbcon_clear_margins(vc, 0);
 
-	if (vt_cons[vc->vc_num]->vc_mode == KD_TEXT)
-		fbcon_clear_margins(vc, 0);
 	if (logo_shown == FBCON_LOGO_DRAW) {
 
 		logo_shown = fg_console;
@@ -2478,10 +2486,9 @@
 	if (scrollback_current == scrollback_old)
 		return 0;
 
-	if (!info->fbops->fb_blank &&
-	    (console_blanked || vt_cons[vc->vc_num]->vc_mode != KD_TEXT
-	     || !lines))
+	if (fbcon_is_inactive(vc, info))
 		return 0;
+
 	fbcon_cursor(vc, CM_ERASE);
 
 	offset = p->yscroll - scrollback_current;
@@ -2510,7 +2517,7 @@
 
 static int fbcon_set_origin(struct vc_data *vc)
 {
-	if (softback_lines && !console_blanked)
+	if (softback_lines)
 		fbcon_scrolldelta(vc, softback_lines);
 	return 0;
 }






-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
