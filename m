From: James Simmons <jsimmons@infradead.org>
Subject: console fb mapping.
Date: Fri, 7 May 2004 18:23:59 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0405071822370.32441-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BM94u-0007IL-D8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 May 2004 10:24:04 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BM94t-00033g-Lo
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 May 2004 10:24:04 -0700
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


This patch cleans up the initialization code. No more calling 
fb_console_init twice.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/fbcon.c fbdev-2.6/drivers/video/console/fbcon.c
--- linus-2.6/drivers/video/console/fbcon.c	2004-05-06 20:29:10.000000000 -0700
+++ fbdev-2.6/drivers/video/console/fbcon.c	2004-05-06 20:51:18.000000000 -0700
@@ -296,15 +296,17 @@
  *	Maps a virtual console @unit to a frame buffer device
  *	@newidx.
  */
-int set_con2fb_map(int unit, int newidx)
+int set_con2fb_map(int start, int end, int newidx)
 {
-	struct vc_data *vc = vc_cons[unit].d;
-
+	struct vc_data *vc = vc_cons[start].d;
+	int i;
+	
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
 
@@ -2219,34 +2221,33 @@
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
+
 static int fbcon_event_notify(struct notifier_block *self, 
 			      unsigned long action, void *data)
 {
 	struct fb_info *info = (struct fb_info *) data;
+	struct vc_data *vc;
+
+	if (info->currcon < 0)
+		return 0;
+	vc = vc_cons[info->currcon].d;
 
 	switch(action) {
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
@@ -2282,20 +2283,15 @@
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
 
@@ -2304,10 +2300,7 @@
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
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/fbcon.h fbdev-2.6/drivers/video/console/fbcon.h
--- linus-2.6/drivers/video/console/fbcon.h	2004-05-06 20:29:10.000000000 -0700
+++ fbdev-2.6/drivers/video/console/fbcon.h	2004-05-06 20:44:56.000000000 -0700
@@ -38,7 +38,7 @@
 
 /* drivers/video/console/fbcon.c */
 extern char con2fb_map[MAX_NR_CONSOLES];
-extern int set_con2fb_map(int unit, int newidx);
+extern int set_con2fb_map(int start, int end, int newidx);
 
     /*
      *  Attribute Decoding
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
--- linus-2.6/drivers/video/fbmem.c	2004-05-06 20:29:07.000000000 -0700
+++ fbdev-2.6/drivers/video/fbmem.c	2004-05-06 20:54:32.000000000 -0700
@@ -1081,9 +1081,9 @@
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
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
