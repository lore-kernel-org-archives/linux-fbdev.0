From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH][FBCON]: Another batch of fbcon fixes
Date: Wed, 30 Jun 2004 10:49:05 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406301048.01700.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfVAF-0005Ff-0t
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 19:49:35 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BfVAE-0001l3-Ds
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 19:49:34 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id A1DC468D5B4
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Jun 2004 02:07:23 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi James, Andrew

Tested various code paths in fbcon that are not commonly taken, as well
as various fbdev applications and I found a few problems.  Hopefully, the
patch below should clean them up.

Diff is against linux-2.6.7-mm4:

Tony

==
Signed-off-by: Antonino Daplas <adaplas@pol.net>

1.  Update display->vrows when fbset changes certain fields in var (such
as color depth) but without changing the display resolution.  This might
produce concommitant changes in other fields such as and especially
var->yres_virtual.

2.  Clear the FBINFO_MISC_MODECHANGEUSER flag _before_
issuing a notifier_call_chain(). Clearing it after the notifier_call_chain() will
cause fbcon to go into an infinite loop.

3.  Sanitized failure path of set_con2fb_map().

diff -Naur linux-2.6.7-mm4-orig/drivers/video/console/fbcon.c linux-2.6.7-mm4/drivers/video/console/fbcon.c
--- linux-2.6.7-mm4-orig/drivers/video/console/fbcon.c	2004-06-30 01:50:29.964339496 +0000
+++ linux-2.6.7-mm4/drivers/video/console/fbcon.c	2004-06-30 01:50:08.229643672 +0000
@@ -326,30 +326,37 @@
 	struct vc_data *vc = vc_cons[unit].d;
 	int oldidx = con2fb_map[unit];
 	struct fb_info *info = registered_fb[newidx];
-	struct fb_info *oldinfo = registered_fb[oldidx];
+	struct fb_info *oldinfo = NULL;
 	int found;
 
+	if (oldidx == newidx)
+		return 0;
+
+	if (!vc)
+	    return -ENODEV;
+
 	if (!search_for_mapped_con()) {
 		info_idx = newidx;
 		fb_console_init();
 		return 0;
 	}
 
-	if (oldidx == newidx)
-		return 0;
-	if (!vc)
-	    return -ENODEV;
+	if (oldidx != -1)
+		oldinfo = registered_fb[oldidx];
+
 	found = search_fb_in_map(newidx);
 
 	acquire_console_sem();
 	con2fb_map[unit] = newidx;
 	if (!found) {
 		if (!try_module_get(info->fbops->owner)) {
+			con2fb_map[unit] = oldidx;
 			release_console_sem();
 			return -ENODEV;
 		}
 		if (info->fbops->fb_open && info->fbops->fb_open(info, 0)) {
 			module_put(info->fbops->owner);
+			con2fb_map[unit] = oldidx;
 			release_console_sem();
 			return -ENODEV;
 		}
@@ -360,18 +367,18 @@
 	 * fbcon should release it.
 	 */
 	if (oldinfo && !search_fb_in_map(oldidx)) {
-		int err;
-
-		if (info->queue.func == fb_flashcursor)
-			del_timer_sync(&oldinfo->cursor_timer);
-		if (oldinfo->fbops->fb_release) {
-			err = oldinfo->fbops->fb_release(oldinfo, 0);
-			if (err) {
-				con2fb_map[unit] = oldidx;
-				release_console_sem();
-				return err;
-			}
+		if (oldinfo->fbops->fb_release && 
+		    oldinfo->fbops->fb_release(oldinfo, 0)) {
+			con2fb_map[unit] = oldidx;
+			if (!found && info->fbops->fb_release)
+				info->fbops->fb_release(info, 0);
+			if (!found)
+				module_put(info->fbops->owner);
+			release_console_sem();
+			return -ENODEV;
 		}
+		if (oldinfo->queue.func == fb_flashcursor)
+			del_timer_sync(&oldinfo->cursor_timer);
 		module_put(oldinfo->fbops->owner);
 	}
 	info->currcon = -1;
@@ -1624,8 +1631,10 @@
 			height, width);
 }
 
-static __inline__ void updatescrollmode(struct display *p, struct fb_info *info, struct vc_data *vc)
+static __inline__ void updatescrollmode(struct display *p, struct fb_info *info, 
+					struct vc_data *vc)
 {
+	int fh = vc->vc_font.height;
 	int cap = info->flags;
 	int good_pan = (cap & FBINFO_HWACCEL_YPAN)
 		 && divides(info->fix.ypanstep, vc->vc_font.height)
@@ -1636,6 +1645,13 @@
 	int reading_fast = cap & FBINFO_READS_FAST;
 	int fast_copyarea = (cap & FBINFO_HWACCEL_COPYAREA) && !(cap & FBINFO_HWACCEL_DISABLED);
 
+	p->vrows = info->var.yres_virtual/fh;
+	if (info->var.yres > (fh * (vc->vc_rows + 1)))
+		p->vrows -= (info->var.yres - (fh * vc->vc_rows)) / fh;
+	if ((info->var.yres % fh) && (info->var.yres_virtual % fh < 
+				      info->var.yres % fh))
+		p->vrows--;
+
 	if (good_wrap || good_pan) {
 		if (reading_fast || fast_copyarea)
 			p->scrollmode = good_wrap ? SCROLL_WRAP : SCROLL_PAN;
@@ -1682,11 +1698,6 @@
 			fb_set_var(info, &var);
 		}
 	}
-	p->vrows = var.yres_virtual/fh;
-	if (var.yres > (fh * (height + 1)))
-		p->vrows -= (var.yres - (fh * height)) / fh;
-	if ((var.yres % fh) && (var.yres_virtual % fh < var.yres % fh))
-		p->vrows--;
 	updatescrollmode(p, info, vc);
 	return 0;
 }
@@ -1762,7 +1773,6 @@
 		struct fb_fillrect rect;
 		int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 
-		logo_shown = fg_console;
 		rect.color = attr_bgcol_ec(bgshift, vc);
 		rect.rop = ROP_COPY;
 		rect.dx = rect.dy = 0;
@@ -2388,19 +2398,7 @@
 		cols = info->var.xres / vc->vc_font.width;
 		rows = info->var.yres / vc->vc_font.height;
 		vc_resize(vc->vc_num, cols, rows);
-		switch (p->scrollmode) {
-		case SCROLL_WRAP:
-			scrollback_phys_max = p->vrows - vc->vc_rows;
-			break;
-		case SCROLL_PAN:
-			scrollback_phys_max = p->vrows - 2 * vc->vc_rows;
-			if (scrollback_phys_max < 0)
-				scrollback_phys_max = 0;
-			break;
-		default:
-			scrollback_phys_max = 0;
-			break;
-		}
+		updatescrollmode(p, info, vc);
 		scrollback_max = 0;
 		scrollback_current = 0;
 		update_var(vc->vc_num, info);
@@ -2471,7 +2469,8 @@
 };
 static int fbcon_event_notifier_registered;
 
-int __init fb_console_init(void)
+/* can't be __init as it can be called by set_con2fb_map() later */
+int fb_console_init(void)
 {
 	int err, i;
 
diff -Naur linux-2.6.7-mm4-orig/drivers/video/fbmem.c linux-2.6.7-mm4/drivers/video/fbmem.c
--- linux-2.6.7-mm4-orig/drivers/video/fbmem.c	2004-06-30 01:50:29.968338888 +0000
+++ linux-2.6.7-mm4/drivers/video/fbmem.c	2004-06-30 01:04:13.000000000 +0000
@@ -999,9 +999,9 @@
 			fb_set_cmap(&info->cmap, 1, info);
 
 			if (info->flags & FBINFO_MISC_MODECHANGEUSER) {
+				info->flags &= ~FBINFO_MISC_MODECHANGEUSER;
 				notifier_call_chain(&fb_notifier_list,
 						    FB_EVENT_MODE_CHANGE, info);
-				info->flags &= ~FBINFO_MISC_MODECHANGEUSER;
 			}
 		}
 	}




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
