From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/7] fbcon: Call set_par per fb_info once during init
Date: Sun, 20 Mar 2005 21:09:01 +0800
Message-ID: <200503202109.01132.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD0CW-0001Ff-Ff
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:10:40 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DD0CV-0002EW-LB
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:10:40 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 70CD014CE652
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Mar 2005 13:10:32 +0000 (UTC)
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

  Currently, fbcon will unconditionally do set_par's
  on all info's mapped to each console.  This results in
  repetetive hardware initialization when one is enough. Fix
  this by skipping all fbdev's that already underwent
  initialization.

From: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c |   16 ++++++++++++----
 fbcon.h |    3 +++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-03-16 07:07:15 +08:00
+++ b/drivers/video/console/fbcon.c	2005-03-16 07:39:24 +08:00
@@ -599,9 +599,10 @@
 
 	ops->currcon = fg_console;
 
-	if (info->fbops->fb_set_par)
+	if (info->fbops->fb_set_par && !(ops->flags & FBCON_FLAGS_INIT))
 		info->fbops->fb_set_par(info);
 
+	ops->flags |= FBCON_FLAGS_INIT;
 	ops->graphics = 0;
 
 	if (vc)
@@ -900,6 +901,7 @@
 static void fbcon_init(struct vc_data *vc, int init)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops;
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct vc_data *svc = *default_mode;
 	struct display *t, *p = &fb_display[vc->vc_num];
@@ -950,6 +952,8 @@
 	new_cols = info->var.xres / vc->vc_font.width;
 	new_rows = info->var.yres / vc->vc_font.height;
 	vc_resize(vc, new_cols, new_rows);
+
+	ops = info->fbcon_par;
 	/*
 	 * We must always set the mode. The mode of the previous console
 	 * driver could be in the same resolution but we are using different
@@ -957,10 +961,14 @@
 	 *
 	 * We need to do it in fbcon_init() to prevent screen corruption.
 	 */
-	if (CON_IS_VISIBLE(vc) && info->fbops->fb_set_par)
-		info->fbops->fb_set_par(info);
+	if (CON_IS_VISIBLE(vc)) {
+		if (info->fbops->fb_set_par &&
+		    !(ops->flags & FBCON_FLAGS_INIT))
+			info->fbops->fb_set_par(info);
+		ops->flags |= FBCON_FLAGS_INIT;
+	}
 
-	((struct fbcon_ops *) info->fbcon_par)->graphics = 0;
+	ops->graphics = 0;
 
 	if ((cap & FBINFO_HWACCEL_COPYAREA) &&
 	    !(cap & FBINFO_HWACCEL_DISABLED))
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2005-03-16 07:07:15 +08:00
+++ b/drivers/video/console/fbcon.h	2005-03-16 07:39:24 +08:00
@@ -18,6 +18,8 @@
 
 #include <asm/io.h>
 
+#define FBCON_FLAGS_INIT 1
+
    /*
     *    This is the interface between the low-level console driver and the
     *    low-level frame buffer device
@@ -69,6 +71,7 @@
 	int    cursor_reset;
 	int    blank_state;
 	int    graphics;
+	int    flags;
 	char  *cursor_data;
 };
     /*




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
