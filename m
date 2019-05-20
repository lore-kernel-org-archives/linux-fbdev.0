From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 20 May 2019 08:22:04 +0000
Subject: [PATCH 21/33] fbdev: directly call fbcon_suspended/resumed
Message-Id: <20190520082216.26273-22-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Prarit Bhargava <prarit@redhat.com>, Kees Cook <keescook@chromium.org>, Konstantin Khorenko <khorenko@virtuozzo.com>, Yisheng Xie <ysxie@foxmail.com>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Peter Rosin <peda@axentia.se>, Mikulas Patocka <mpatocka@redhat.com>, linux-fbdev@vger.kernel.org

With the sh_mobile notifier removed we can just directly call the
fbcon code here.

v2: Remove now unused local variable.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcon.c | 10 ++--------
 drivers/video/fbdev/core/fbmem.c |  7 ++-----
 include/linux/fb.h               |  8 --------
 include/linux/fbcon.h            |  4 ++++
 4 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index a8d12914b559..b056d1190788 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2915,7 +2915,7 @@ static int fbcon_set_origin(struct vc_data *vc)
 	return 0;
 }
 
-static void fbcon_suspended(struct fb_info *info)
+void fbcon_suspended(struct fb_info *info)
 {
 	struct vc_data *vc = NULL;
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -2928,7 +2928,7 @@ static void fbcon_suspended(struct fb_info *info)
 	fbcon_cursor(vc, CM_ERASE);
 }
 
-static void fbcon_resumed(struct fb_info *info)
+void fbcon_resumed(struct fb_info *info)
 {
 	struct vc_data *vc;
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -3326,12 +3326,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	int idx, ret = 0;
 
 	switch(action) {
-	case FB_EVENT_SUSPEND:
-		fbcon_suspended(info);
-		break;
-	case FB_EVENT_RESUME:
-		fbcon_resumed(info);
-		break;
 	case FB_EVENT_MODE_CHANGE:
 		fbcon_modechanged(info);
 		break;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index f059b0b1a030..7c55846ee5fc 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1881,17 +1881,14 @@ EXPORT_SYMBOL(unregister_framebuffer);
  */
 void fb_set_suspend(struct fb_info *info, int state)
 {
-	struct fb_event event;
-
 	WARN_CONSOLE_UNLOCKED();
 
-	event.info = info;
 	if (state) {
-		fb_notifier_call_chain(FB_EVENT_SUSPEND, &event);
+		fbcon_suspended(info);
 		info->state = FBINFO_STATE_SUSPENDED;
 	} else {
 		info->state = FBINFO_STATE_RUNNING;
-		fb_notifier_call_chain(FB_EVENT_RESUME, &event);
+		fbcon_resumed(info);
 	}
 }
 EXPORT_SYMBOL(fb_set_suspend);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 44021e55b15c..a78bbd372cfd 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -126,14 +126,6 @@ struct fb_cursor_user {
 
 /*	The resolution of the passed in fb_info about to change */ 
 #define FB_EVENT_MODE_CHANGE		0x01
-/*	The display on this fb_info is being suspended, no access to the
- *	framebuffer is allowed any more after that call returns
- */
-#define FB_EVENT_SUSPEND		0x02
-/*	The display on this fb_info was resumed, you can restore the display
- *	if you own it
- */
-#define FB_EVENT_RESUME			0x03
 /*      An entry from the modelist was removed */
 #define FB_EVENT_MODE_DELETE            0x04
 /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 38d44fdb6d14..61a22e6c0c64 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -7,12 +7,16 @@ void __exit fb_console_exit(void);
 int fbcon_fb_registered(struct fb_info *info);
 void fbcon_fb_unregistered(struct fb_info *info);
 void fbcon_fb_unbind(struct fb_info *info);
+void fbcon_suspended(struct fb_info *info);
+void fbcon_resumed(struct fb_info *info);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
 static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
 static inline void fbcon_fb_unregistered(struct fb_info *info) {}
 static inline void fbcon_fb_unbind(struct fb_info *info) {}
+static inline void fbcon_suspended(void) {}
+static inline void fbcon_resumed(void) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1
