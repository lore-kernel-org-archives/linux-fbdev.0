From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/8] fbcon: Do not touch hardware if vc_mode != KD_TEXT
Date: Tue, 2 Nov 2004 19:46:06 +0800
Message-ID: <200411021946.06302.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1COx7N-0002eH-4r
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:46:29 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1COx7M-00053G-44
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:46:28 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 4734D9834E1
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  2 Nov 2004 11:46:13 +0000 (UTC)
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The frambuffer console is still writing to the graphics hardware even if the
hardware is not owned anymore by the console.  This can lead to crashes with
some hardware.

A trace of the source indicates that it comes from almost anywhere, anytime.

The fix is to return immediately if vc_mode != KD_TEXT.  The test is placed in 
the following functions if not already present.

fbcon_cursor()
fbcon_putcs()
fbcon_clear()
fbcon_bmove() 
fbcon_blank() 

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

 fbcon.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-10-30 19:10:42 +08:00
+++ b/drivers/video/console/fbcon.c	2004-11-02 18:58:15 +08:00
@@ -983,6 +983,9 @@
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
 
+	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
+		return;
+
 	if (!height || !width)
 		return;
 
@@ -1007,6 +1010,7 @@
 
 	if (!info->fbops->fb_blank && console_blanked)
 		return;
+
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
 
@@ -1042,6 +1046,9 @@
 	int y = real_y(p, vc->vc_y);
  	int c = scr_readw((u16 *) vc->vc_pos);
 
+	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
+		return;
+
 	ops->cursor_flash = 1;
 	if (mode & CM_SOFTBACK) {
 		mode &= ~CM_SOFTBACK;
@@ -1690,6 +1697,9 @@
 	if (!info->fbops->fb_blank && console_blanked)
 		return;
 
+	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
+		return;
+
 	if (!width || !height)
 		return;
 
@@ -1952,6 +1962,7 @@
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
+	int retval = 0;
 
 	if (mode_switch) {
 		struct fb_var_screeninfo var = info->var;
@@ -1968,19 +1979,16 @@
 		if (info->flags & FBINFO_MISC_MODESWITCHLATE)
 			info->flags |= FBINFO_MISC_MODESWITCH;
 
-		if (blank) {
-			fbcon_cursor(vc, CM_ERASE);
-			return 0;
-		}
-
-		if (!(info->flags & FBINFO_MISC_MODESWITCHLATE)) {
+		if (!blank && !(info->flags & FBINFO_MISC_MODESWITCHLATE)) {
 			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
 			fb_set_var(info, &var);
 		}
+
+		return 0;
 	}
 
-	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 	ops->cursor_flash = (!blank);
+	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 
 	if (!info->fbops->fb_blank) {
 		if (blank) {
@@ -2001,9 +2009,10 @@
 			vc->vc_video_erase_char = oldc;
 		} else
 			update_screen(vc->vc_num);
-		return 0;
-	} else
-		return fb_blank(info, blank);
+	} else if (vt_cons[vc->vc_num]->vc_mode == KD_TEXT)
+		retval = fb_blank(info, blank);
+
+	return retval;
 }
 
 static void fbcon_free_font(struct display *p)




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
