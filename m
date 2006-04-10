From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] drivers/video/: remove unused exports
Date: Tue, 11 Apr 2006 00:22:18 +0200
Message-ID: <20060410222218.GM2408@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FT4ms-0007cX-AX
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Apr 2006 15:23:10 -0700
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FT4mr-000422-Pl
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Apr 2006 15:23:10 -0700
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

This patch removes the following unused EXPORT_SYMBOL's:
- fbcvt.c: fb_find_mode_cvt
- fbmem.c: fb_con_duit
- fbmem.c: fb_new_modelist
- macmodes.c: mac_var_to_vmode
- modedb.c: fb_delete_videomode
- modedb.c: fb_destroy_modelist

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/fbcvt.c    |    1 -
 drivers/video/fbmem.c    |    2 --
 drivers/video/macmodes.c |    1 -
 drivers/video/modedb.c   |    2 --
 4 files changed, 6 deletions(-)

--- linux-2.6.17-rc1-mm2-full/drivers/video/fbcvt.c.old	2006-04-10 23:19:00.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/video/fbcvt.c	2006-04-10 23:19:08.000000000 +0200
@@ -376,4 +376,3 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(fb_find_mode_cvt);
--- linux-2.6.17-rc1-mm2-full/drivers/video/fbmem.c.old	2006-04-10 23:19:35.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/video/fbmem.c	2006-04-10 23:19:54.000000000 +0200
@@ -1500,7 +1500,6 @@
 
 	return blocking_notifier_call_chain(&fb_notifier_list, event, &evnt);
 }
-EXPORT_SYMBOL(fb_con_duit);
 
 static char *video_options[FB_MAX];
 static int ofonly;
@@ -1611,6 +1610,5 @@
 EXPORT_SYMBOL(fb_register_client);
 EXPORT_SYMBOL(fb_unregister_client);
 EXPORT_SYMBOL(fb_get_options);
-EXPORT_SYMBOL(fb_new_modelist);
 
 MODULE_LICENSE("GPL");
--- linux-2.6.17-rc1-mm2-full/drivers/video/macmodes.c.old	2006-04-10 23:21:51.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/video/macmodes.c	2006-04-10 23:21:59.000000000 +0200
@@ -327,7 +327,6 @@
     }
     return -EINVAL;
 }
-EXPORT_SYMBOL(mac_var_to_vmode);
 
 /**
  *	mac_map_monitor_sense - Convert monitor sense to vmode
--- linux-2.6.17-rc1-mm2-full/drivers/video/modedb.c.old	2006-04-10 23:23:12.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/video/modedb.c	2006-04-10 23:23:30.000000000 +0200
@@ -1016,8 +1016,6 @@
 EXPORT_SYMBOL(fb_var_to_videomode);
 EXPORT_SYMBOL(fb_mode_is_equal);
 EXPORT_SYMBOL(fb_add_videomode);
-EXPORT_SYMBOL(fb_delete_videomode);
-EXPORT_SYMBOL(fb_destroy_modelist);
 EXPORT_SYMBOL(fb_match_mode);
 EXPORT_SYMBOL(fb_find_best_mode);
 EXPORT_SYMBOL(fb_find_nearest_mode);



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
