From: James Simmons <jsimmons@infradead.org>
Subject: fb_console_init fix.
Date: Fri, 20 Feb 2004 21:58:02 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402202156340.6798-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuIkw-0007hS-7P
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Feb 2004 14:04:22 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AuIVo-0001Tv-RS
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Feb 2004 13:48:45 -0800
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
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Hi!

  This patch fixes fb_console_init from being called twice. I still need 
to fix set_con2fb but this helps but this is still important to get in.

--- linus-2.6/drivers/video/console/fbcon.c	2004-02-18 20:59:11.000000000 -0800
+++ fbdev-2.6/drivers/video/console/fbcon.c	2004-02-19 18:14:52.000000000 -0800
@@ -2335,6 +2335,7 @@
 {
 	if (!num_registered_fb)
 		return -ENODEV;
+
 	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
 	acquire_console_sem();
 	if (!fbcon_event_notifier_registered) {
@@ -2342,10 +2343,11 @@
 		fbcon_event_notifier_registered = 1;
 	} 
 	release_console_sem();
-
 	return 0;
 }
 
+#ifdef MODULE
+
 void __exit fb_console_exit(void)
 {
 	acquire_console_sem();
@@ -2360,6 +2362,8 @@
 module_init(fb_console_init);
 module_exit(fb_console_exit);
 
+#endif
+
 /*
  *  Visible symbols for modules
  */



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
