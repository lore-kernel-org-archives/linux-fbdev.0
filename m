From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Close race with fbcon notifer
Date: Tue, 10 Feb 2004 15:23:18 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076386997.893.14.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqPRD-0004sE-LM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Feb 2004 20:23:55 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AqPRC-0000x9-5l
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Feb 2004 20:23:54 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

diff -urN fbdev-2.5/drivers/video/console/fbcon.c linuxppc-2.5-benh/drivers/video/console/fbcon.c
--- fbdev-2.5/drivers/video/console/fbcon.c	2004-02-09 14:48:31.000000000 +1100
+++ linuxppc-2.5-benh/drivers/video/console/fbcon.c	2004-02-10 15:21:29.754526880 +1100
@@ -602,7 +602,6 @@
 
 	/* on which frame buffer will we open this console? */
 	info = registered_fb[(int) con2fb_map[unit]];
-	
 	if (info->var.accel_flags)
 		fb_display[unit].scrollmode = SCROLL_YNOMOVE;
 	else
@@ -2255,16 +2254,24 @@
 
 static void fbcon_resumed(struct fb_info *info)
 {
-	struct vc_data *vc = vc_cons[info->currcon].d;
+	struct vc_data *vc;
+
+	if (info->currcon < 0)
+		return;
+	vc = vc_cons[info->currcon].d;
 
 	update_screen(vc->vc_num);
 }
 
 static void fbcon_mode_changed(struct fb_info *info)
 {
-	struct vc_data *vc = vc_cons[info->currcon].d;
+	struct vc_data *vc;
 	int rows, cols;
 
+	if (info->currcon < 0)
+		return;
+	vc = vc_cons[info->currcon].d;
+
 	/* This isn't perfect yet. If we change one console, we
 	 * don't change them all and we switch back to the wrong
 	 * mode on next console switch. We need to either keep a
@@ -2339,6 +2346,7 @@
 	.notifier_call	= fbcon_event_notify,
 };
 
+static int fbcon_event_notifier_registered;
 
 int __init fb_console_init(void)
 {
@@ -2349,14 +2357,24 @@
 	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
 	info = registered_fb[num_registered_fb-1];	
 
-	fb_register_client(&fbcon_event_notifer);
+	acquire_console_semaphore();
+	if (!fbcon_event_notifier_registered) {
+		fb_register_client(&fbcon_event_notifer);
+		fbcon_event_notifier_registered = 1;
+	} 
+	release_console_semaphore();
 
 	return 0;
 }
 
 void __exit fb_console_exit(void)
 {
-	fb_unregister_client(&fbcon_event_notifer);
+	acquire_console_semaphore();
+	if (fbcon_event_notifier_registered) {
+		fb_unregister_client(&fbcon_event_notifer);
+		fbcon_event_notifier_registered = 0;
+	}
+	release_console_semaphore();
 	give_up_console(&fb_con);
 }	
 




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
