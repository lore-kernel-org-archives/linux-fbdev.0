From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/9][FBDEV]: Do the deletion of mode entries at fbdev level
Date: Sat, 21 Aug 2004 21:33:04 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408212042.48584.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByW0w-0008EH-U3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:34:34 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1ByW0w-0008La-9V
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:34:34 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B608B7B3CC3
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 13:34:25 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

If a request for deletion of an entry in the mode database is requested, do 
it at core fbdev level instead of doing it at the console level.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 console/fbcon.c |   12 ++++++------
 fbmem.c         |   24 ++++++++++++++++--------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/console/fbcon.c linux-2.6.8.1-mm3/drivers/video/console/fbcon.c
--- linux-2.6.8.1-mm3-orig/drivers/video/console/fbcon.c	2004-08-21 18:26:53.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/console/fbcon.c	2004-08-21 18:36:27.045024320 +0800
@@ -2671,8 +2671,8 @@ static void fbcon_modechanged(struct fb_
 	}
 }
 
-static void fbcon_mode_deleted(struct fb_info *info,
-			       struct fb_videomode *mode)
+static int fbcon_mode_deleted(struct fb_info *info,
+			      struct fb_videomode *mode)
 {
 	struct fb_info *fb_info;
 	struct display *p;
@@ -2694,8 +2694,7 @@ static void fbcon_mode_deleted(struct fb
 			break;
 		}
 	}
-	if (!found)
-		fb_delete_videomode(mode, &info->monspecs.modelist);
+	return found;
 }
 
 static int fbcon_event_notify(struct notifier_block *self, 
@@ -2704,6 +2703,7 @@ static int fbcon_event_notify(struct not
 	struct fb_event *event = (struct fb_event *) data;
 	struct fb_info *info = event->info;
 	struct fb_videomode *mode;
+	int ret = 0;
 
 	switch(action) {
 	case FB_EVENT_SUSPEND:
@@ -2717,11 +2717,11 @@ static int fbcon_event_notify(struct not
 		break;
 	case FB_EVENT_MODE_DELETE:
 		mode = (struct fb_videomode *) event->data;
-		fbcon_mode_deleted(info, mode);
+		ret = fbcon_mode_deleted(info, mode);
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 /*
diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/fbmem.c linux-2.6.8.1-mm3/drivers/video/fbmem.c
--- linux-2.6.8.1-mm3-orig/drivers/video/fbmem.c	2004-08-21 18:26:53.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/fbmem.c	2004-08-21 18:36:27.048023864 +0800
@@ -1089,18 +1089,26 @@ fb_set_var(struct fb_info *info, struct 
 
 	if (var->activate & FB_ACTIVATE_INV_MODE) {
 		struct fb_videomode mode1, mode2;
-		struct fb_event event;
+		int ret = 0;
 
 		fb_var_to_videomode(&mode1, var);
 		fb_var_to_videomode(&mode2, &info->var);
 		/* make sure we don't delete the videomode of current var */
-		if (fb_mode_is_equal(&mode1, &mode2))
-			return -EINVAL;
-		event.info = info;
-		event.data = &mode1;
-		notifier_call_chain(&fb_notifier_list, FB_EVENT_MODE_DELETE,
-				    &event);
-		return 0;
+		ret = fb_mode_is_equal(&mode1, &mode2);
+
+		if (!ret) {
+		    struct fb_event event;
+
+		    event.info = info;
+		    event.data = &mode1;
+		    ret = notifier_call_chain(&fb_notifier_list,
+					      FB_EVENT_MODE_DELETE, &event);
+		}
+
+		if (!ret)
+		    fb_delete_videomode(&mode1, &info->monspecs.modelist);
+
+		return ret;
 	}
 
 	if ((var->activate & FB_ACTIVATE_FORCE) ||




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
