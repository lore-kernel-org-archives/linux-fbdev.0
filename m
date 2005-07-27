From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/2] fbdev: Add fbset -a support
Date: Wed, 27 Jul 2005 08:33:27 +0800
Message-ID: <42E6D657.1060704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxZwM-0001rs-Ic
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Jul 2005 17:38:30 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DxZwK-0007Tr-I7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Jul 2005 17:38:30 -0700
Received: by wproxy.gmail.com with SMTP id i20so60284wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 26 Jul 2005 17:38:22 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Add capability to fbdev to listen to the FB_ACTIVATE_ALL flag.
    If set, it notifies fbcon that all consoles must be set to
    the current var.

    From: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 drivers/video/console/fbcon.c |   48 ++++++++++++++++++++++++++++++++++++++++++
 drivers/video/fbmem.c         |    6 +++--
 include/linux/fb.h            |    3 ++
 3 files changed, 55 insertions(+), 2 deletions(-)


Index: drivers/video/console/fbcon.c
===================================================================
--- 5ab26ac17f9da3181ac77da24d40bf1c3447cf6a/drivers/video/console/fbcon.c  (mode:100644)
+++ b6ae21b3932b059ce4bf95d0254f9a90650b49f9/drivers/video/console/fbcon.c  (mode:100644)
@@ -2592,6 +2592,51 @@
 	}
 }
 
+static void fbcon_set_all_vcs(struct fb_info *info)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+	struct vc_data *vc;
+	struct display *p;
+	int i, rows, cols;
+
+	if (!ops || ops->currcon < 0)
+		return;
+
+	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+		vc = vc_cons[i].d;
+		if (!vc || vc->vc_mode != KD_TEXT ||
+		    registered_fb[con2fb_map[i]] != info)
+			continue;
+
+		p = &fb_display[vc->vc_num];
+
+		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
+		var_to_display(p, &info->var, info);
+		cols = info->var.xres / vc->vc_font.width;
+		rows = info->var.yres / vc->vc_font.height;
+		vc_resize(vc, cols, rows);
+
+		if (CON_IS_VISIBLE(vc)) {
+			updatescrollmode(p, info, vc);
+			scrollback_max = 0;
+			scrollback_current = 0;
+			update_var(vc->vc_num, info);
+			fbcon_set_palette(vc, color_table);
+			update_screen(vc);
+			if (softback_buf) {
+				int l = fbcon_softback_size / vc->vc_size_row;
+				if (l > 5)
+					softback_end = softback_buf + l * vc->vc_size_row;
+				else {
+					/* Smaller scrollback makes no sense, and 0
+					   would screw the operation totally */
+					softback_top = 0;
+				}
+			}
+		}
+	}
+}
+
 static int fbcon_mode_deleted(struct fb_info *info,
 			      struct fb_videomode *mode)
 {
@@ -2707,6 +2752,9 @@
 	case FB_EVENT_MODE_CHANGE:
 		fbcon_modechanged(info);
 		break;
+	case FB_EVENT_MODE_CHANGE_ALL:
+		fbcon_set_all_vcs(info);
+		break;
 	case FB_EVENT_MODE_DELETE:
 		mode = event->data;
 		ret = fbcon_mode_deleted(info, mode);
Index: drivers/video/fbmem.c
===================================================================
--- 5ab26ac17f9da3181ac77da24d40bf1c3447cf6a/drivers/video/fbmem.c  (mode:100644)
+++ b6ae21b3932b059ce4bf95d0254f9a90650b49f9/drivers/video/fbmem.c  (mode:100644)
@@ -682,11 +682,13 @@
 
 			if (!err && info->flags & FBINFO_MISC_USEREVENT) {
 				struct fb_event event;
+				int evnt = (var->activate & FB_ACTIVATE_ALL) ?
+					FB_EVENT_MODE_CHANGE_ALL :
+					FB_EVENT_MODE_CHANGE;
 
 				info->flags &= ~FBINFO_MISC_USEREVENT;
 				event.info = info;
-				notifier_call_chain(&fb_notifier_list,
-						    FB_EVENT_MODE_CHANGE,
+				notifier_call_chain(&fb_notifier_list, evnt,
 						    &event);
 			}
 		}
Index: include/linux/fb.h
===================================================================
--- 5ab26ac17f9da3181ac77da24d40bf1c3447cf6a/include/linux/fb.h  (mode:100644)
+++ b6ae21b3932b059ce4bf95d0254f9a90650b49f9/include/linux/fb.h  (mode:100644)
@@ -495,6 +495,9 @@
 #define FB_EVENT_BLANK                  0x08
 /*      Private modelist is to be replaced */
 #define FB_EVENT_NEW_MODELIST           0x09
+/*	The resolution of the passed in fb_info about to change and
+        all vc's should be changed         */
+#define FB_EVENT_MODE_CHANGE_ALL	0x0A
 
 struct fb_event {
 	struct fb_info *info;



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
