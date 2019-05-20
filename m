From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 20 May 2019 08:22:06 +0000
Subject: [PATCH 23/33] fbdev: Call fbcon_get_requirement directly
Message-Id: <20190520082216.26273-24-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Prarit Bhargava <prarit@redhat.com>, Kees Cook <keescook@chromium.org>, Yisheng Xie <ysxie@foxmail.com>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Peter Rosin <peda@axentia.se>, Mikulas Patocka <mpatocka@redhat.com>, linux-fbdev@vger.kernel.org

Pretty simple case really.

v2: Forgot to remove a break;

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcon.c | 9 ++-------
 drivers/video/fbdev/core/fbmem.c | 5 +----
 include/linux/fb.h               | 2 --
 include/linux/fbcon.h            | 4 ++++
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5635acb4b11c..58b876718d81 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3279,8 +3279,8 @@ void fbcon_new_modelist(struct fb_info *info)
 	}
 }
 
-static void fbcon_get_requirement(struct fb_info *info,
-				  struct fb_blit_caps *caps)
+void fbcon_get_requirement(struct fb_info *info,
+			   struct fb_blit_caps *caps)
 {
 	struct vc_data *vc;
 	struct fbcon_display *p;
@@ -3321,7 +3321,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	struct fb_event *event = data;
 	struct fb_info *info = event->info;
 	struct fb_con2fbmap *con2fb;
-	struct fb_blit_caps *caps;
 	int idx, ret = 0;
 
 	switch(action) {
@@ -3344,10 +3343,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	case FB_EVENT_BLANK:
 		fbcon_fb_blanked(info, *(int *)event->data);
 		break;
-	case FB_EVENT_GET_REQ:
-		caps = event->data;
-		fbcon_get_requirement(info, caps);
-		break;
 	case FB_EVENT_REMAP_ALL_CONSOLE:
 		idx = info->node;
 		fbcon_remap_all(idx);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 96d280228746..d428d08c358a 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -932,16 +932,13 @@ EXPORT_SYMBOL(fb_pan_display);
 static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
 			 u32 activate)
 {
-	struct fb_event event;
 	struct fb_blit_caps caps, fbcaps;
 	int err = 0;
 
 	memset(&caps, 0, sizeof(caps));
 	memset(&fbcaps, 0, sizeof(fbcaps));
 	caps.flags = (activate & FB_ACTIVATE_ALL) ? 1 : 0;
-	event.info = info;
-	event.data = &caps;
-	fb_notifier_call_chain(FB_EVENT_GET_REQ, &event);
+	fbcon_get_requirement(info, &caps);
 	info->fbops->fb_get_caps(info, &fbcaps, var);
 
 	if (((fbcaps.x ^ caps.x) & caps.x) ||
diff --git a/include/linux/fb.h b/include/linux/fb.h
index e6595a381792..e76185244593 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -136,8 +136,6 @@ struct fb_cursor_user {
 #define FB_EVENT_MODE_CHANGE_ALL	0x0B
 /*	A software display blank change occurred */
 #define FB_EVENT_CONBLANK               0x0C
-/*      Get drawing requirements        */
-#define FB_EVENT_GET_REQ                0x0D
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 42b06848b459..7f0a530a913c 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -12,6 +12,8 @@ void fbcon_resumed(struct fb_info *info);
 int fbcon_mode_deleted(struct fb_info *info,
 		       struct fb_videomode *mode);
 void fbcon_new_modelist(struct fb_info *info);
+void fbcon_get_requirement(struct fb_info *info,
+			   struct fb_blit_caps *caps);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
@@ -23,6 +25,8 @@ static inline void fbcon_resumed(void) {}
 int fbcon_mode_deleted(struct fb_info *info,
 		       struct fb_videomode *mode) { return 0; }
 void fbcon_new_modelist(struct fb_info *info) {}
+void fbcon_get_requirement(struct fb_info *info,
+			   struct fb_blit_caps *caps) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1
