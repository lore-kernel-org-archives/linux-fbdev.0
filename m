From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/7] fbdev: fbcon: Check if mode can
	handle new screen
Date: Sun, 29 Apr 2007 11:46:03 +0800
Message-ID: <463414FB.6070209@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hi0TG-0003av-5C for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:53:15 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hi0TF-000446-42
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:53:09 -0700
Received: by py-out-1112.google.com with SMTP id a29so1108343pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 28 Apr 2007 20:53:08 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Ondrej Zajicek <santiago@mail.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Check if the mode can properly display the screen.  This will be needed by
drivers where the capability is not constant with each mode. The function
fb_set_var() will query fbcon the requirement, then it will query the
driver (via a new hook fb_get_caps()) its capability.  If the driver's
capability cannot handle fbcon's requirement, then fb_set_var() will fail.

For example, if a particular driver supports 2 modes where:

mode1 = can only display 8x16 bitmaps
mode2 = can display any bitmap

then if current mode = mode2 and current font = 12x22

fbset <mode1> /* mode1 cannot handle 12x22 */
fbset will fail

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/fbcon.c |   42 +++++++++++++++++++++++++++++++++++++++++
 drivers/video/fbmem.c         |   33 ++++++++++++++++++++++++++++++++
 include/linux/fb.h            |   12 ++++++++++++
 3 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 6fc3501..34899bd 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3043,6 +3043,43 @@ static void fbcon_new_modelist(struct fb
 	}
 }
 
+static void fbcon_get_requirement(struct fb_info *info,
+				  struct fb_blit_caps *caps)
+{
+	struct vc_data *vc;
+	struct display *p;
+	int charcnt;
+
+	if (caps->flags) {
+		int i;
+
+		for (i = first_fb_vc; i <= last_fb_vc; i++) {
+			vc = vc_cons[i].d;
+			if (vc && vc->vc_mode == KD_TEXT) {
+				p = &fb_display[i];
+				caps->x |= 1 << (vc->vc_font.width - 1);
+				caps->y |= 1 << (vc->vc_font.height - 1);
+				charcnt = (p->userfont) ?
+					FNTCHARCNT(p->fontdata) : 256;
+				if (caps->len < charcnt)
+					caps->len = charcnt;
+			}
+		}
+	} else {
+		vc = vc_cons[fg_console].d;
+
+		if (vc && vc->vc_mode == KD_TEXT) {
+			p = &fb_display[fg_console];
+			caps->x |= 1 << (vc->vc_font.width - 1);
+			caps->y |= 1 << (vc->vc_font.height - 1);
+			charcnt = (p->userfont) ?
+				FNTCHARCNT(p->fontdata) : 256;
+			if (caps->len < charcnt)
+				caps->len = charcnt;
+		}
+	}
+}
+
 static int fbcon_event_notify(struct notifier_block *self, 
 			      unsigned long action, void *data)
 {
@@ -3050,6 +3087,7 @@ static int fbcon_event_notify(struct not
 	struct fb_info *info = event->info;
 	struct fb_videomode *mode;
 	struct fb_con2fbmap *con2fb;
+	struct fb_blit_caps *caps;
 	int ret = 0;
 
 	/*
@@ -3098,6 +3136,10 @@ static int fbcon_event_notify(struct not
 	case FB_EVENT_NEW_MODELIST:
 		fbcon_new_modelist(info);
 		break;
+	case FB_EVENT_GET_REQ:
+		caps = event->data;
+		fbcon_get_requirement(info, caps);
+		break;
 	}
 
 done:
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index cd14079..354711c 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -773,6 +773,29 @@ fb_pan_display(struct fb_info *info, str
         return 0;
 }
 
+static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
+			 u32 activate)
+{
+	struct fb_event event;
+	struct fb_blit_caps caps, fbcaps;
+	int err = 0;
+
+	memset(&caps, 0, sizeof(caps));
+	memset(&fbcaps, 0, sizeof(fbcaps));
+	caps.flags = (activate & FB_ACTIVATE_ALL) ? 1 : 0;
+	event.info = info;
+	event.data = &caps;
+	fb_notifier_call_chain(FB_EVENT_GET_REQ, &event);
+	info->fbops->fb_get_caps(info, &fbcaps, var);
+
+	if (((fbcaps.x ^ caps.x) & caps.x) ||
+	    ((fbcaps.y ^ caps.y) & caps.y) ||
+	    (fbcaps.len < caps.len))
+		err = -EINVAL;
+
+	return err;
+}
+
 int
 fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 {
@@ -817,7 +840,15 @@ fb_set_var(struct fb_info *info, struct 
 			struct fb_videomode mode;
 			int err = 0;
 
+			if (info->fbops->fb_get_caps) {
+				err = fb_check_caps(info, var, activate);
+
+				if (err)
+					goto done;
+			}
+
 			info->var = *var;
+
 			if (info->fbops->fb_set_par)
 				info->fbops->fb_set_par(info);
 
@@ -843,6 +874,8 @@ fb_set_var(struct fb_info *info, struct 
 			}
 		}
 	}
+
+ done:
 	return 0;
 }
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a2f382c..dff7a72 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -527,12 +527,20 @@ #define FB_EVENT_NEW_MODELIST           
 #define FB_EVENT_MODE_CHANGE_ALL	0x0B
 /*	A software display blank change occured */
 #define FB_EVENT_CONBLANK               0x0C
+/*      Get drawing requirements        */
+#define FB_EVENT_GET_REQ                0x0D
 
 struct fb_event {
 	struct fb_info *info;
 	void *data;
 };
 
+struct fb_blit_caps {
+	u32 x;
+	u32 y;
+	u32 len;
+	u32 flags;
+};
 
 extern int fb_register_client(struct notifier_block *nb);
 extern int fb_unregister_client(struct notifier_block *nb);
@@ -652,6 +660,10 @@ struct fb_ops {
 
 	/* restore saved state */
 	void (*fb_restore_state)(struct fb_info *info);
+
+	/* get capability given var */
+	void (*fb_get_caps)(struct fb_info *info, struct fb_blit_caps *caps,
+			    struct fb_var_screeninfo *var);
 };
 
 #ifdef CONFIG_FB_TILEBLITTING


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
