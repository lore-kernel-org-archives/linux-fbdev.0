From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/5] Video Mode Handling - Delete entries from mode list
Date: Mon, 9 Aug 2004 09:46:01 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408090946.01213.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BtzIG-0001Vd-9l
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:44 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BtzIF-0003u0-Ny
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:44 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id AA28C776A3F
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  9 Aug 2004 00:56:18 +0000 (UTC)
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

Hi,

This is optional but applying it should enhance fbdev functionality.

The patch allows removal of entries to the mode list.  This is done by setting the
var->activate field to FB_ACTIVATE_INV_MODE.  Only modes that are not in
use by any of the console or by the current var will be deleted.

The diff is against 2.6.8-rc3-mm1 but should apply cleanly to 2.6.8-rc3-mm2
as well.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |   35 ++++++++++++++++++++++++++++++++++-
 drivers/video/fbmem.c         |   28 +++++++++++++++++++++++++---
 include/linux/fb.h            |    9 +++++++++
 3 files changed, 68 insertions(+), 4 deletions(-)

diff -uprN linux-2.6.8-rc3-mm1-orig/drivers/video/console/fbcon.c linux-2.6.8-rc3-mm1/drivers/video/console/fbcon.c
--- linux-2.6.8-rc3-mm1-orig/drivers/video/console/fbcon.c	2004-08-08 22:32:24.759309552 +0800
+++ linux-2.6.8-rc3-mm1/drivers/video/console/fbcon.c	2004-08-08 22:33:05.726081656 +0800
@@ -2671,10 +2671,39 @@ static void fbcon_modechanged(struct fb_
 	}
 }
 
+static void fbcon_mode_deleted(struct fb_info *info,
+			       struct fb_videomode *mode)
+{
+	struct fb_info *fb_info;
+	struct display *p;
+	int i, j, found = 0;
+
+	/* before deletion, ensure that mode is not in use */
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
+		j = (int) con2fb_map[i];
+		if (j == -1)
+			continue;
+		fb_info = registered_fb[j];
+		if (fb_info != info)
+			continue;
+		p = &fb_display[i];
+		if (!p || !p->mode)
+			continue;
+		if (fb_mode_is_equal(p->mode, mode)) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found)
+		fb_delete_videomode(mode, &info->monspecs.modelist);
+}
+
 static int fbcon_event_notify(struct notifier_block *self, 
 			      unsigned long action, void *data)
 {
-	struct fb_info *info = (struct fb_info *) data;
+	struct fb_event *event = (struct fb_event *) data;
+	struct fb_info *info = event->info;
+	struct fb_videomode *mode;
 
 	switch(action) {
 	case FB_EVENT_SUSPEND:
@@ -2686,6 +2715,10 @@ static int fbcon_event_notify(struct not
 	case FB_EVENT_MODE_CHANGE:
 		fbcon_modechanged(info);
 		break;
+	case FB_EVENT_MODE_DELETE:
+		mode = (struct fb_videomode *) event->data;
+		fbcon_mode_deleted(info, mode);
+		break;
 	}
 
 	return 0;
diff -uprN linux-2.6.8-rc3-mm1-orig/drivers/video/fbmem.c linux-2.6.8-rc3-mm1/drivers/video/fbmem.c
--- linux-2.6.8-rc3-mm1-orig/drivers/video/fbmem.c	2004-08-08 22:32:24.784305752 +0800
+++ linux-2.6.8-rc3-mm1/drivers/video/fbmem.c	2004-08-08 22:32:57.384349792 +0800
@@ -1083,6 +1083,22 @@ fb_set_var(struct fb_info *info, struct 
 {
 	int err;
 
+	if (var->activate & FB_ACTIVATE_INV_MODE) {
+		struct fb_videomode mode1, mode2;
+		struct fb_event event;
+
+		fb_var_to_videomode(&mode1, var);
+		fb_var_to_videomode(&mode2, &info->var);
+		/* make sure we don't delete the videomode of current var */
+		if (fb_mode_is_equal(&mode1, &mode2))
+			return -EINVAL;
+		event.info = info;
+		event.data = &mode1;
+		notifier_call_chain(&fb_notifier_list, FB_EVENT_MODE_DELETE,
+				    &event);
+		return 0;
+	}
+
 	if ((var->activate & FB_ACTIVATE_FORCE) ||
 	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
 		if (!info->fbops->fb_check_var) {
@@ -1108,9 +1124,12 @@ fb_set_var(struct fb_info *info, struct 
 			fb_add_videomode(&mode, &info->monspecs.modelist);
 
 			if (info->flags & FBINFO_MISC_MODECHANGEUSER) {
+				struct fb_event event;
+
 				info->flags &= ~FBINFO_MISC_MODECHANGEUSER;
+				event.info = info;
 				notifier_call_chain(&fb_notifier_list,
-						    FB_EVENT_MODE_CHANGE, info);
+						    FB_EVENT_MODE_CHANGE, &event);
 			}
 		}
 	}
@@ -1520,12 +1539,15 @@ int fb_unregister_client(struct notifier
  */
 void fb_set_suspend(struct fb_info *info, int state)
 {
+	struct fb_event event;
+	
+	event.info = info;
 	if (state) {
-		notifier_call_chain(&fb_notifier_list, FB_EVENT_SUSPEND, info);
+		notifier_call_chain(&fb_notifier_list, FB_EVENT_SUSPEND, &event);
 		info->state = FBINFO_STATE_SUSPENDED;
 	} else {
 		info->state = FBINFO_STATE_RUNNING;
-		notifier_call_chain(&fb_notifier_list, FB_EVENT_RESUME, info);
+		notifier_call_chain(&fb_notifier_list, FB_EVENT_RESUME, &event);
 	}
 }
 
diff -uprN linux-2.6.8-rc3-mm1-orig/include/linux/fb.h linux-2.6.8-rc3-mm1/include/linux/fb.h
--- linux-2.6.8-rc3-mm1-orig/include/linux/fb.h	2004-08-08 22:32:24.827299216 +0800
+++ linux-2.6.8-rc3-mm1/include/linux/fb.h	2004-08-08 22:32:42.715579784 +0800
@@ -159,6 +159,7 @@ struct fb_bitfield {
 #define FB_CHANGE_CMAP_VBL     32	/* change colormap on vbl	*/
 #define FB_ACTIVATE_ALL	       64	/* change all VCs on this fb	*/
 #define FB_ACTIVATE_FORCE     128	/* force apply even when no change*/
+#define FB_ACTIVATE_INV_MODE  256       /* invalidate videomode */
 
 #define FB_ACCELF_TEXT		1	/* (OBSOLETE) see fb_info.flags and vc_mode */
 
@@ -449,6 +450,14 @@ struct fb_cursor_user {
  *	if you own it
  */
 #define FB_EVENT_RESUME			0x03
+/*      An entry from the modelist was removed */
+#define FB_EVENT_MODE_DELETE            0x04
+
+struct fb_event {
+	struct fb_info *info;
+	void *data;
+};
+
 
 extern int fb_register_client(struct notifier_block *nb);
 extern int fb_unregister_client(struct notifier_block *nb);




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
