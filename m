From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: [PATCH 2/3] fb accel capabilities (james' fbcon init cleanup)
Date: Thu, 13 May 2004 01:49:03 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405130148110.2282@rosencrantz.theboonies.us>
References: <Pine.LNX.4.58.0405130131460.2282@rosencrantz.theboonies.us>
	<Pine.LNX.4.58.0405130146300.2282@rosencrantz.theboonies.us>
Reply-To: David Eger <eger-dated-1085010260.2f2af1@theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BO3Og-0002U0-CD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 16:44:22 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BO3Of-0000A6-TJ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 16:44:22 -0700
In-Reply-To: <Pine.LNX.4.58.0405130146300.2282@rosencrantz.theboonies.us>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, jsimmons@infradead.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/12 14:43:14+02:00 eger@rosencrantz.theboonies.us 
#   fbcon init sequence cleanup (James Simmon / May 2004)
# 
# drivers/video/fbmem.c
#   2004/05/12 14:42:59+02:00 eger@rosencrantz.theboonies.us +2 -2
#   fbcon init cleanup
# 
# drivers/video/console/fbcon.h
#   2004/05/12 14:42:59+02:00 eger@rosencrantz.theboonies.us +1 -1
#   fbcon init cleanup
# 
# drivers/video/console/fbcon.c
#   2004/05/12 14:42:59+02:00 eger@rosencrantz.theboonies.us +22 -35
#   fbcon init cleanup:
#   factor out retrieving the vc_data from the fbcon_event_notify path
#   remove fbcon_event_notifier_registered cruft
# 
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Wed May 12 15:51:14 2004
+++ b/drivers/video/console/fbcon.c	Wed May 12 15:51:14 2004
@@ -296,15 +296,17 @@
  *	Maps a virtual console @unit to a frame buffer device
  *	@newidx.
  */
-int set_con2fb_map(int unit, int newidx)
+int set_con2fb_map(int start, int end, int newidx)
 {
-	struct vc_data *vc = vc_cons[unit].d;
+	struct vc_data *vc = vc_cons[start].d;
+	int i;
 
 	if (!vc)
 		return -ENODEV;
-	con2fb_map[unit] = newidx;
+	for (i = start; i < end; i++)
+		con2fb_map[i] = newidx;
 	fbcon_is_default = (vc->vc_sw == &fb_con) ? 1 : 0;
-	take_over_console(&fb_con, unit, unit, fbcon_is_default);
+	take_over_console(&fb_con, start, end, fbcon_is_default);
 	return 0;
 }
 
@@ -2235,33 +2237,21 @@
 	return 0;
 }
 
-static void fbcon_suspended(struct fb_info *info)
+static void fbcon_suspended(struct fb_info *info, struct vc_data *vc)
 {
 	/* Clear cursor, restore saved data */
-	info->cursor.enable = 0;
-	info->fbops->fb_cursor(info, &info->cursor);
+	fbcon_cursor(vc, CM_ERASE);
 }
 
-static void fbcon_resumed(struct fb_info *info)
+static void fbcon_resumed(struct fb_info *info, struct vc_data *vc)
 {
-	struct vc_data *vc;
-
-	if (info->currcon < 0)
-		return;
-	vc = vc_cons[info->currcon].d;
-
 	update_screen(vc->vc_num);
 }
 
-static void fbcon_mode_changed(struct fb_info *info)
+static void fbcon_mode_changed(struct fb_info *info, struct vc_data *vc)
 {
-	struct vc_data *vc;
 	int rows, cols;
 
-	if (info->currcon < 0)
-		return;
-	vc = vc_cons[info->currcon].d;
-
 	/* This isn't perfect yet. If we change one console, we
 	 * don't change them all and we switch back to the wrong
 	 * mode on next console switch. We need to either keep a
@@ -2291,16 +2281,21 @@
 			      unsigned long action, void *data)
 {
 	struct fb_info *info = (struct fb_info *) data;
+	struct vc_data *vc;
+
+	if (info->currcon < 0)
+		return 0;
+	vc = vc_cons[info->currcon].d;
 
 	switch(action) {
 	case FB_EVENT_MODE_CHANGE:
-		fbcon_mode_changed(info);
+		fbcon_mode_changed(info, vc);
 		break;
 	case FB_EVENT_SUSPEND:
-		fbcon_suspended(info);
+		fbcon_suspended(info, vc);
 		break;
 	case FB_EVENT_RESUME:
-		fbcon_resumed(info);
+		fbcon_resumed(info, vc);
 		break;
 	}
 	return 0;
@@ -2336,20 +2331,15 @@
 	.notifier_call	= fbcon_event_notify,
 };
 
-static int fbcon_event_notifier_registered;
-
 int __init fb_console_init(void)
 {
+	acquire_console_sem();
+	fb_register_client(&fbcon_event_notifer);
+	release_console_sem();
+
 	if (!num_registered_fb)
 		return -ENODEV;
-
 	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
-	acquire_console_sem();
-	if (!fbcon_event_notifier_registered) {
-		fb_register_client(&fbcon_event_notifer);
-		fbcon_event_notifier_registered = 1;
-	} 
-	release_console_sem();
 	return 0;
 }
 
@@ -2358,10 +2348,7 @@
 void __exit fb_console_exit(void)
 {
 	acquire_console_sem();
-	if (fbcon_event_notifier_registered) {
-		fb_unregister_client(&fbcon_event_notifer);
-		fbcon_event_notifier_registered = 0;
-	}
+	fb_unregister_client(&fbcon_event_notifer);
 	release_console_sem();
 	give_up_console(&fb_con);
 }	
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	Wed May 12 15:51:14 2004
+++ b/drivers/video/console/fbcon.h	Wed May 12 15:51:14 2004
@@ -38,7 +38,7 @@
 
 /* drivers/video/console/fbcon.c */
 extern char con2fb_map[MAX_NR_CONSOLES];
-extern int set_con2fb_map(int unit, int newidx);
+extern int set_con2fb_map(int start, int end, int newidx);
 
     /*
      *  Attribute Decoding
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Wed May 12 15:51:14 2004
+++ b/drivers/video/fbmem.c	Wed May 12 15:51:14 2004
@@ -1108,9 +1108,9 @@
 		if (!registered_fb[con2fb.framebuffer])
 		    return -EINVAL;
 		if (con2fb.console != 0)
-			set_con2fb_map(con2fb.console-1, con2fb.framebuffer);
+			set_con2fb_map(con2fb.console-1, con2fb.console-1, con2fb.framebuffer);
 		else
-			fb_console_init();		
+			set_con2fb_map(0, MAX_NR_CONSOLES, con2fb.framebuffer);
 		return 0;
 #endif	/* CONFIG_FRAMEBUFFER_CONSOLE */
 	case FBIOBLANK:


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
