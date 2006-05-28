From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/5] fbdev: Remove unused exports
Date: Sun, 28 May 2006 08:33:13 +0800
Message-ID: <4478EFC9.5020703@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fk9NJ-0001oh-TH
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 17:43:21 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fk9NH-0008KM-HW
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 17:43:22 -0700
Received: by py-out-1112.google.com with SMTP id b29so208814pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 May 2006 17:43:17 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Adrian Bunk <bunk@stusta.de>

From: Adrian Bunk <bunk@stusta.de>

This patch removes the following unused EXPORT_SYMBOL's:
- fbcvt.c: fb_find_mode_cvt
- fbmem.c: fb_con_duit
- fbmem.c: fb_new_modelist
- macmodes.c: mac_var_to_vmode
- modedb.c: fb_delete_videomode
- modedb.c: fb_destroy_modelist

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbcvt.c    |    1 -
 drivers/video/fbmem.c    |    2 --
 drivers/video/macmodes.c |    1 -
 drivers/video/modedb.c   |    2 --
 4 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbcvt.c b/drivers/video/fbcvt.c
index ac90883..b549899 100644
--- a/drivers/video/fbcvt.c
+++ b/drivers/video/fbcvt.c
@@ -376,4 +376,3 @@ int fb_find_mode_cvt(struct fb_videomode
 
 	return 0;
 }
-EXPORT_SYMBOL(fb_find_mode_cvt);
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 2529805..2279d14 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1509,7 +1509,6 @@ int fb_con_duit(struct fb_info *info, in
 
 	return blocking_notifier_call_chain(&fb_notifier_list, event, &evnt);
 }
-EXPORT_SYMBOL(fb_con_duit);
 
 static char *video_options[FB_MAX];
 static int ofonly;
@@ -1620,6 +1619,5 @@ EXPORT_SYMBOL(fb_set_suspend);
 EXPORT_SYMBOL(fb_register_client);
 EXPORT_SYMBOL(fb_unregister_client);
 EXPORT_SYMBOL(fb_get_options);
-EXPORT_SYMBOL(fb_new_modelist);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/macmodes.c b/drivers/video/macmodes.c
index c0385c6..95f5fc6 100644
--- a/drivers/video/macmodes.c
+++ b/drivers/video/macmodes.c
@@ -327,7 +327,6 @@ int mac_var_to_vmode(const struct fb_var
     }
     return -EINVAL;
 }
-EXPORT_SYMBOL(mac_var_to_vmode);
 
 /**
  *	mac_map_monitor_sense - Convert monitor sense to vmode
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 7e539b6..ff54546 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -1021,8 +1021,6 @@ EXPORT_SYMBOL(fb_videomode_to_var);
 EXPORT_SYMBOL(fb_var_to_videomode);
 EXPORT_SYMBOL(fb_mode_is_equal);
 EXPORT_SYMBOL(fb_add_videomode);
-EXPORT_SYMBOL(fb_delete_videomode);
-EXPORT_SYMBOL(fb_destroy_modelist);
 EXPORT_SYMBOL(fb_match_mode);
 EXPORT_SYMBOL(fb_find_best_mode);
 EXPORT_SYMBOL(fb_find_nearest_mode);



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
