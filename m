From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/9] fbcon/fbdev: Add blanking notification
Date: Wed, 22 Dec 2004 05:35:13 +0800
Message-ID: <20041221213648.89B701A0278@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cgrgo-0007WY-V7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:06 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cgrgn-0002Qd-PF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:06 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D0FD7BA0C92
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Dec 2004 21:36:52 +0000 (UTC)
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

Add blanking event to the notifier call chain.  This can be used by fbcon
to blank/unblank the console, and theoretically, by backlight drivers.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |   91 ++++++++++++++++++++++--------------------
 drivers/video/console/fbcon.h |    1
 drivers/video/fbmem.c         |   26 ++++++++----
 include/linux/fb.h            |    5 +-
 4 files changed, 70 insertions(+), 53 deletions(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-11-17 18:15:17 +08:00
+++ b/drivers/video/console/fbcon.c	2004-12-21 05:55:41 +08:00
@@ -2000,44 +2000,20 @@
 				int blank)
 {
 	if (blank) {
-		if (info->fix.visual == FB_VISUAL_DIRECTCOLOR ||
-		    info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
-			struct fb_cmap cmap;
-			u16 *black;
-
-			black = kmalloc(sizeof(u16) * info->cmap.len,
-					GFP_KERNEL);
-			if (black) {
-				memset(black, 0, info->cmap.len * sizeof(u16));
-				cmap.red = cmap.green = cmap.blue = black;
-				cmap.transp = info->cmap.transp ? black : NULL;
-				cmap.start = info->cmap.start;
-				cmap.len = info->cmap.len;
-				fb_set_cmap(&cmap, info);
-			}
-
-			kfree(black);
-		} else {
-			unsigned short charmask = vc->vc_hi_font_mask ?
-				0x1ff : 0xff;
-			unsigned short oldc;
-
-			oldc = vc->vc_video_erase_char;
-			vc->vc_video_erase_char &= charmask;
-			fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
-			vc->vc_video_erase_char = oldc;
-		}
-	} else {
-		if (info->fix.visual == FB_VISUAL_DIRECTCOLOR ||
-		    info->fix.visual == FB_VISUAL_PSEUDOCOLOR)
-			fb_set_cmap(&info->cmap, info);
+		unsigned short charmask = vc->vc_hi_font_mask ?
+			0x1ff : 0xff;
+		unsigned short oldc;
+
+		oldc = vc->vc_video_erase_char;
+		vc->vc_video_erase_char &= charmask;
+		fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
+		vc->vc_video_erase_char = oldc;
 	}
 }
 
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
 	int active = !fbcon_is_inactive(vc, info);
 
 	if (mode_switch) {
@@ -2061,19 +2037,21 @@
 	}
 
  	if (active) {
- 		int ret = -1;
+		struct fbcon_ops *ops = info->fbcon_par;
 
  		fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
  		ops->cursor_flash = (!blank);
 
- 		if (info->fbops->fb_blank)
- 			ret = info->fbops->fb_blank(blank, info);
-
- 		if (ret)
- 			fbcon_generic_blank(vc, info, blank);
+ 		if (ops->blank_state != blank) {
+ 			if (info->fbops->fb_blank &&
+ 			    info->fbops->fb_blank(blank, info))
+ 				fbcon_generic_blank(vc, info, blank);
+ 
+ 			ops->blank_state = blank;
+ 		}
 
  		if (!blank)
-  			update_screen(vc->vc_num);
+ 			update_screen(vc->vc_num);
  	}
 
  	return 0;
@@ -2580,14 +2558,12 @@
 	struct display *p;
 	int rows, cols;
 
-	if (!ops)
+	if (!ops || ops->currcon < 0 || vt_cons[ops->currcon]->vc_mode !=
+	    KD_TEXT || registered_fb[con2fb_map[ops->currcon]] != info)
 		return;
 
 	vc = vc_cons[ops->currcon].d;
 
-	if (ops->currcon < 0 || vt_cons[ops->currcon]->vc_mode !=
-	    KD_TEXT)
-		return;
 	p = &fb_display[vc->vc_num];
 
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;
@@ -2665,6 +2641,32 @@
 	return ret;
 }
 
+static void fbcon_fb_blanked(struct fb_info *info, int blank)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+	int valid = 1;
+
+	if (!ops || ops->currcon < 0 ||
+	    vt_cons[ops->currcon]->vc_mode != KD_TEXT ||
+	    registered_fb[con2fb_map[ops->currcon]] != info)
+		valid = 0;
+
+	if (valid) {
+		struct vc_data *vc;
+
+		vc = vc_cons[ops->currcon].d;
+
+		if (CON_IS_VISIBLE(vc)) {
+			ops->blank_state = blank;
+
+			if (blank)
+				do_blank_screen(0);
+			else
+				do_unblank_screen(0);
+		}
+	}
+}
+
 static int fbcon_event_notify(struct notifier_block *self, 
 			      unsigned long action, void *data)
 {
@@ -2699,6 +2701,9 @@
 	case FB_EVENT_GET_CONSOLE_MAP:
 		con2fb = event->data;
 		con2fb->framebuffer = con2fb_map[con2fb->console - 1];
+		break;
+	case FB_EVENT_BLANK:
+		fbcon_fb_blanked(info, *(int *)event->data);
 		break;
 	}
 
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2004-11-17 18:15:17 +08:00
+++ b/drivers/video/console/fbcon.h	2004-11-29 05:42:49 +08:00
@@ -66,6 +66,7 @@
         int    currcon;	                /* Current VC. */
 	int    cursor_flash;
 	int    cursor_reset;
+	int    blank_state;
 	char  *cursor_data;
 };
     /*
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-12-21 05:44:01 +08:00
+++ b/drivers/video/fbmem.c	2004-12-21 22:44:55 +08:00
@@ -730,10 +730,10 @@
 			    !list_empty(&info->modelist))
 				fb_add_videomode(&mode, &info->modelist);
 
-			if (info->flags & FBINFO_MISC_MODECHANGEUSER) {
+			if (info->flags & FBINFO_MISC_USEREVENT) {
 				struct fb_event event;
 
-				info->flags &= ~FBINFO_MISC_MODECHANGEUSER;
+				info->flags &= ~FBINFO_MISC_USEREVENT;
 				event.info = info;
 				notifier_call_chain(&fb_notifier_list,
 						    FB_EVENT_MODE_CHANGE, &event);
@@ -746,15 +746,23 @@
 int
 fb_blank(struct fb_info *info, int blank)
 {	
-	int err = -EINVAL;
-	
+ 	int ret = -EINVAL;
+ 
  	if (blank > FB_BLANK_POWERDOWN)
  		blank = FB_BLANK_POWERDOWN;
 
 	if (info->fbops->fb_blank)
- 		err = info->fbops->fb_blank(blank, info);
+ 		ret = info->fbops->fb_blank(blank, info);
+
+ 	if (!ret) {
+		struct fb_event event;
+
+		event.info = info;
+		event.data = &blank;
+		notifier_call_chain(&fb_notifier_list, FB_EVENT_BLANK, &event);
+	}
 
-	return err;
+ 	return ret;
 }
 
 static int 
@@ -782,9 +790,9 @@
 		if (copy_from_user(&var, argp, sizeof(var)))
 			return -EFAULT;
 		acquire_console_sem();
-		info->flags |= FBINFO_MISC_MODECHANGEUSER;
+		info->flags |= FBINFO_MISC_USEREVENT;
 		i = fb_set_var(info, &var);
-		info->flags &= ~FBINFO_MISC_MODECHANGEUSER;
+		info->flags &= ~FBINFO_MISC_USEREVENT;
 		release_console_sem();
 		if (i) return i;
 		if (copy_to_user(argp, &var, sizeof(var)))
@@ -846,7 +854,9 @@
 					   &event);
 	case FBIOBLANK:
 		acquire_console_sem();
+		info->flags |= FBINFO_MISC_USEREVENT;
 		i = fb_blank(info, arg);
+		info->flags &= ~FBINFO_MISC_USEREVENT;
 		release_console_sem();
 		return i;
 	default:
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2004-11-10 06:15:14 +08:00
+++ b/include/linux/fb.h	2004-12-21 05:51:16 +08:00
@@ -488,7 +488,8 @@
 #define FB_EVENT_GET_CONSOLE_MAP        0x06
 /*      set console to framebuffer mapping */
 #define FB_EVENT_SET_CONSOLE_MAP        0x07
-
+/*      A display blank is requested       */
+#define FB_EVENT_BLANK                  0x08
 
 struct fb_event {
 	struct fb_info *info;
@@ -690,7 +691,7 @@
 #define FBINFO_HWACCEL_YPAN		0x2000 /* optional */
 #define FBINFO_HWACCEL_YWRAP		0x4000 /* optional */
 
-#define FBINFO_MISC_MODECHANGEUSER     0x10000 /* mode change request
+#define FBINFO_MISC_USEREVENT          0x10000 /* event request
 						  from userspace */
 #define FBINFO_MISC_MODESWITCH         0x20000 /* mode switch */
 #define FBINFO_MISC_MODESWITCHLATE     0x40000 /* init hardware later */




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
