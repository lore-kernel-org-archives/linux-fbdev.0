From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 20 May 2019 08:22:05 +0000
Subject: [PATCH 22/33] fbcon: Call fbcon_mode_deleted/new_modelist directly
Message-Id: <20190520082216.26273-23-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Kees Cook <keescook@chromium.org>, Peter Rosin <peda@axentia.se>, Yisheng Xie <ysxie@foxmail.com>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, linux-fbdev@vger.kernel.org

I'm not entirely clear on what new_modelist actually does, it seems
exclusively for a sysfs interface. Which in the end does amount to a
normal fb_set_par to check the mode, but then takes a different path
in both fbmem.c and fbcon.c.

I have no idea why these 2 paths are different, but then I also don't
really want to find out. So just do the simple conversion to a direct
function call.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcon.c | 14 +++-----------
 drivers/video/fbdev/core/fbmem.c | 22 +++++++---------------
 include/linux/fb.h               |  5 -----
 include/linux/fbcon.h            |  6 ++++++
 4 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b056d1190788..5635acb4b11c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3015,8 +3015,8 @@ static void fbcon_set_all_vcs(struct fb_info *info)
 		fbcon_modechanged(info);
 }
 
-static int fbcon_mode_deleted(struct fb_info *info,
-			      struct fb_videomode *mode)
+int fbcon_mode_deleted(struct fb_info *info,
+		       struct fb_videomode *mode)
 {
 	struct fb_info *fb_info;
 	struct fbcon_display *p;
@@ -3258,7 +3258,7 @@ static void fbcon_fb_blanked(struct fb_info *info, int blank)
 	ops->blank_state = blank;
 }
 
-static void fbcon_new_modelist(struct fb_info *info)
+void fbcon_new_modelist(struct fb_info *info)
 {
 	int i;
 	struct vc_data *vc;
@@ -3320,7 +3320,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 {
 	struct fb_event *event = data;
 	struct fb_info *info = event->info;
-	struct fb_videomode *mode;
 	struct fb_con2fbmap *con2fb;
 	struct fb_blit_caps *caps;
 	int idx, ret = 0;
@@ -3332,10 +3331,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	case FB_EVENT_MODE_CHANGE_ALL:
 		fbcon_set_all_vcs(info);
 		break;
-	case FB_EVENT_MODE_DELETE:
-		mode = event->data;
-		ret = fbcon_mode_deleted(info, mode);
-		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
 		/* called with console lock held */
 		con2fb = event->data;
@@ -3349,9 +3344,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	case FB_EVENT_BLANK:
 		fbcon_fb_blanked(info, *(int *)event->data);
 		break;
-	case FB_EVENT_NEW_MODELIST:
-		fbcon_new_modelist(info);
-		break;
 	case FB_EVENT_GET_REQ:
 		caps = event->data;
 		fbcon_get_requirement(info, caps);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 7c55846ee5fc..96d280228746 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -966,16 +966,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 		/* make sure we don't delete the videomode of current var */
 		ret = fb_mode_is_equal(&mode1, &mode2);
 
-		if (!ret) {
-		    struct fb_event event;
-
-		    event.info = info;
-		    event.data = &mode1;
-		    ret = fb_notifier_call_chain(FB_EVENT_MODE_DELETE, &event);
-		}
+		if (!ret)
+			fbcon_mode_deleted(info, &mode1);
 
 		if (!ret)
-		    fb_delete_videomode(&mode1, &info->modelist);
+			fb_delete_videomode(&mode1, &info->modelist);
 
 
 		ret = (ret) ? -EINVAL : 0;
@@ -1956,7 +1951,6 @@ subsys_initcall(fbmem_init);
 
 int fb_new_modelist(struct fb_info *info)
 {
-	struct fb_event event;
 	struct fb_var_screeninfo var = info->var;
 	struct list_head *pos, *n;
 	struct fb_modelist *modelist;
@@ -1976,14 +1970,12 @@ int fb_new_modelist(struct fb_info *info)
 		}
 	}
 
-	err = 1;
+	if (list_empty(&info->modelist))
+		return 1;
 
-	if (!list_empty(&info->modelist)) {
-		event.info = info;
-		err = fb_notifier_call_chain(FB_EVENT_NEW_MODELIST, &event);
-	}
+	fbcon_new_modelist(info);
 
-	return err;
+	return 0;
 }
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a78bbd372cfd..e6595a381792 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -126,8 +126,6 @@ struct fb_cursor_user {
 
 /*	The resolution of the passed in fb_info about to change */ 
 #define FB_EVENT_MODE_CHANGE		0x01
-/*      An entry from the modelist was removed */
-#define FB_EVENT_MODE_DELETE            0x04
 /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
 #define FB_EVENT_GET_CONSOLE_MAP        0x07
 /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
@@ -135,9 +133,6 @@ struct fb_cursor_user {
 /*      A hardware display blank change occurred */
 #define FB_EVENT_BLANK                  0x09
 /*      Private modelist is to be replaced */
-#define FB_EVENT_NEW_MODELIST           0x0A
-/*	The resolution of the passed in fb_info about to change and
-        all vc's should be changed         */
 #define FB_EVENT_MODE_CHANGE_ALL	0x0B
 /*	A software display blank change occurred */
 #define FB_EVENT_CONBLANK               0x0C
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 61a22e6c0c64..42b06848b459 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -9,6 +9,9 @@ void fbcon_fb_unregistered(struct fb_info *info);
 void fbcon_fb_unbind(struct fb_info *info);
 void fbcon_suspended(struct fb_info *info);
 void fbcon_resumed(struct fb_info *info);
+int fbcon_mode_deleted(struct fb_info *info,
+		       struct fb_videomode *mode);
+void fbcon_new_modelist(struct fb_info *info);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
@@ -17,6 +20,9 @@ static inline void fbcon_fb_unregistered(struct fb_info *info) {}
 static inline void fbcon_fb_unbind(struct fb_info *info) {}
 static inline void fbcon_suspended(void) {}
 static inline void fbcon_resumed(void) {}
+int fbcon_mode_deleted(struct fb_info *info,
+		       struct fb_videomode *mode) { return 0; }
+void fbcon_new_modelist(struct fb_info *info) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1
