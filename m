From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/8] fbcon: Split set_con2fb_map()
Date: Mon, 8 Nov 2004 05:26:07 +0800
Message-ID: <20041107213328.E2B8411C60B2@smtp-3.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQufW-00042S-3q
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:33:50 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQufU-0008If-U3
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:33:50 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9CDA89BF095
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  7 Nov 2004 21:33:34 +0000 (UTC)
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

The function set_con2fb_map() is getting very big.  Split it into its component
functions.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c |  225 ++++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 127 insertions(+), 98 deletions(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/console/fbcon.c	2004-11-07 21:37:05 +08:00
@@ -503,6 +503,115 @@
 }
 #endif /* CONFIG_MISC_TILEBLITTING */
 
+
+static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
+				  int unit, int oldidx)
+{
+	struct fbcon_ops *ops = NULL;
+	int err = 0;
+
+	if (!try_module_get(info->fbops->owner))
+		err = -ENODEV;
+
+	if (!err && info->fbops->fb_open &&
+	    info->fbops->fb_open(info, 0))
+		err = -ENODEV;
+
+	if (!err) {
+		ops = kmalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
+		if (!ops)
+			err = -ENOMEM;
+	}
+
+	if (!err) {
+		memset(ops, 0, sizeof(struct fbcon_ops));
+		info->fbcon_par = ops;
+		set_blitting_type(vc, info, NULL);
+	}
+
+	if (err) {
+		con2fb_map[unit] = oldidx;
+		module_put(info->fbops->owner);
+	}
+
+	return err;
+}
+
+static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
+				  struct fb_info *newinfo, int unit,
+				  int oldidx, int found)
+{
+	struct fbcon_ops *ops = oldinfo->fbcon_par;
+	int err = 0;
+
+	if (oldinfo->fbops->fb_release &&
+	    oldinfo->fbops->fb_release(oldinfo, 0)) {
+		con2fb_map[unit] = oldidx;
+		if (!found && newinfo->fbops->fb_release)
+			newinfo->fbops->fb_release(newinfo, 0);
+		if (!found)
+			module_put(newinfo->fbops->owner);
+		err = -ENODEV;
+	}
+
+	if (!err) {
+		if (oldinfo->queue.func == fb_flashcursor)
+			del_timer_sync(&ops->cursor_timer);
+
+		kfree(ops->cursor_state.mask);
+		kfree(ops->cursor_data);
+		kfree(oldinfo->fbcon_par);
+		oldinfo->fbcon_par = NULL;
+		module_put(oldinfo->fbops->owner);
+	}
+
+	return err;
+}
+
+static void con2fb_init_newinfo(struct fb_info *info)
+{
+	if (!info->queue.func || info->queue.func == fb_flashcursor) {
+		struct fbcon_ops *ops = info->fbcon_par;
+
+		if (!info->queue.func)
+			INIT_WORK(&info->queue, fb_flashcursor, info);
+
+		init_timer(&ops->cursor_timer);
+		ops->cursor_timer.function = cursor_timer_handler;
+		ops->cursor_timer.expires = jiffies + HZ / 5;
+		ops->cursor_timer.data = (unsigned long ) info;
+		add_timer(&ops->cursor_timer);
+	}
+}
+
+static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
+				int unit, int show_logo)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+
+	ops->currcon = fg_console;
+
+	if (info->fbops->fb_set_par)
+		info->fbops->fb_set_par(info);
+
+	if (vc)
+		fbcon_set_disp(info, vc);
+	else
+		fbcon_preset_disp(info, unit);
+
+	if (show_logo) {
+		struct vc_data *fg_vc = vc_cons[fg_console].d;
+		struct fb_info *fg_info =
+			registered_fb[con2fb_map[fg_console]];
+
+		fbcon_prepare_logo(fg_vc, fg_info, fg_vc->vc_cols,
+				   fg_vc->vc_rows, fg_vc->vc_cols,
+				   fg_vc->vc_rows);
+	}
+
+	switch_screen(fg_console);
+}
+
 /**
  *	set_con2fb_map - map console to frame buffer device
  *	@unit: virtual console number to map
@@ -518,16 +627,15 @@
 	int oldidx = con2fb_map[unit];
 	struct fb_info *info = registered_fb[newidx];
 	struct fb_info *oldinfo = NULL;
-	struct fbcon_ops *ops;
-	int found;
+ 	int found, err = 0;
 
 	if (oldidx == newidx)
 		return 0;
 
 	if (!info)
-		return -EINVAL;
+ 		err =  -EINVAL;
 
-	if (!search_for_mapped_con()) {
+ 	if (!err && !search_for_mapped_con()) {
 		info_idx = newidx;
 		return fbcon_takeover(0);
 	}
@@ -539,109 +647,30 @@
 
 	acquire_console_sem();
 	con2fb_map[unit] = newidx;
+	if (!err && !found)
+ 		err = con2fb_acquire_newinfo(vc, info, unit, oldidx);
 
-	if (!found) {
-		int err = 0;
-
-		ops = NULL;
-
-		if (!try_module_get(info->fbops->owner)) {
-			err = -ENODEV;
-		}
-
-		if (!err && info->fbops->fb_open &&
-		    info->fbops->fb_open(info, 0)) {
-			err = -ENODEV;
-		}
-
-		if (!err) {
-			ops = kmalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
-			if (!ops)
-				err = -ENOMEM;
-		}
-
-		if (!err) {
-			memset(ops, 0, sizeof(struct fbcon_ops));
-			info->fbcon_par = ops;
-			set_blitting_type(vc, info, NULL);
-		}
-
-		if (err) {
-			con2fb_map[unit] = oldidx;
-			module_put(info->fbops->owner);
-			release_console_sem();
-			return err;
-		}
-	}
 
 	/*
 	 * If old fb is not mapped to any of the consoles,
 	 * fbcon should release it.
 	 */
-	if (oldinfo && !search_fb_in_map(oldidx)) {
-
-		ops = oldinfo->fbcon_par;
-
-		if (oldinfo->fbops->fb_release &&
-		    oldinfo->fbops->fb_release(oldinfo, 0)) {
-			con2fb_map[unit] = oldidx;
-			if (!found && info->fbops->fb_release)
-				info->fbops->fb_release(info, 0);
-			if (!found)
-				module_put(info->fbops->owner);
-			release_console_sem();
-			return -ENODEV;
-		}
-
-		if (oldinfo->queue.func == fb_flashcursor)
-			del_timer_sync(&ops->cursor_timer);
-
-		kfree(ops->cursor_state.mask);
-		kfree(ops->cursor_data);
-		kfree(oldinfo->fbcon_par);
-		oldinfo->fbcon_par = NULL;
-		module_put(oldinfo->fbops->owner);
-	}
-
-	if (!found) {
-		if (!info->queue.func || info->queue.func == fb_flashcursor) {
-
-			ops = info->fbcon_par;
-
-			if (!info->queue.func)
-				INIT_WORK(&info->queue, fb_flashcursor, info);
-
-			init_timer(&ops->cursor_timer);
-			ops->cursor_timer.function = cursor_timer_handler;
-			ops->cursor_timer.expires = jiffies + HZ / 5;
-			ops->cursor_timer.data = (unsigned long ) info;
-			add_timer(&ops->cursor_timer);
-		}
-	}
-
-	ops = info->fbcon_par;
-	ops->currcon = fg_console;
-	con2fb_map_boot[unit] = newidx;
-
-	if (info->fbops->fb_set_par)
-		info->fbops->fb_set_par(info);
-
-	if (vc)
-		fbcon_set_disp(info, vc);
-	else
-		fbcon_preset_disp(info, unit);
-
-	if (fg_console == 0 && !user && logo_shown != FBCON_LOGO_DONTSHOW) {
-		struct vc_data *vc = vc_cons[fg_console].d;
-		struct fb_info *fg_info = registered_fb[con2fb_map[fg_console]];
-
-		fbcon_prepare_logo(vc, fg_info, vc->vc_cols, vc->vc_rows,
-				   vc->vc_cols, vc->vc_rows);
+ 	if (!err && oldinfo && !search_fb_in_map(oldidx))
+ 		err = con2fb_release_oldinfo(vc, oldinfo, info, unit, oldidx,
+ 					     found);
+ 
+ 	if (!err) {
+ 		int show_logo = (fg_console == 0 && !user &&
+ 				 logo_shown != FBCON_LOGO_DONTSHOW);
+ 
+ 		if (!found)
+ 			con2fb_init_newinfo(info);
+ 		con2fb_map_boot[unit] = newidx;
+ 		con2fb_init_display(vc, info, unit, show_logo);
 	}
 
-	switch_screen(fg_console);
 	release_console_sem();
-	return 0;
+ 	return err;
 }
 
 /*




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
