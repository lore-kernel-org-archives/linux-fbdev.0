From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:48 +0000
Subject: [PATCH 17/33] fbcon: call fbcon_fb_bind directly
Message-Id: <20190528090304.9388-18-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Yisheng Xie <ysxie@foxmail.com>, Hans de Goede <hdegoede@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>, Konstantin Khorenko <khorenko@virtuozzo.com>

Also remove the error return value. That's all errors for either
driver bugs (trying to unbind something that isn't bound), or errors
of the new driver that will take over.

There's nothing the outgoing driver can do about this anyway, so
switch over to void.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Peter Rosin <peda@axentia.se>
Cc: Kees Cook <keescook@chromium.org>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcon.c | 24 +++++++-----------------
 drivers/video/fbdev/core/fbmem.c |  7 ++-----
 include/linux/fb.h               |  2 --
 include/linux/fbcon.h            |  2 ++
 4 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index a7e2d5b88914..142686953b71 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3046,7 +3046,7 @@ static int fbcon_mode_deleted(struct fb_info *info,
 }
 
 #ifdef CONFIG_VT_HW_CONSOLE_BINDING
-static int fbcon_unbind(void)
+static void fbcon_unbind(void)
 {
 	int ret;
 
@@ -3055,25 +3055,21 @@ static int fbcon_unbind(void)
 
 	if (!ret)
 		fbcon_has_console_bind = 0;
-
-	return ret;
 }
 #else
-static inline int fbcon_unbind(void)
-{
-	return -EINVAL;
-}
+static inline void fbcon_unbind(void) {}
 #endif /* CONFIG_VT_HW_CONSOLE_BINDING */
 
 /* called with console_lock held */
-static int fbcon_fb_unbind(int idx)
+void fbcon_fb_unbind(struct fb_info *info)
 {
 	int i, new_idx = -1, ret = 0;
+	int idx = info->node;
 
 	WARN_CONSOLE_UNLOCKED();
 
 	if (!fbcon_has_console_bind)
-		return 0;
+		return;
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] != idx &&
@@ -3106,15 +3102,13 @@ static int fbcon_fb_unbind(int idx)
 								     idx, 0);
 					if (ret) {
 						con2fb_map[i] = idx;
-						return ret;
+						return;
 					}
 				}
 			}
 		}
-		ret = fbcon_unbind();
+		fbcon_unbind();
 	}
-
-	return ret;
 }
 
 /* called with console_lock held */
@@ -3352,10 +3346,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		mode = event->data;
 		ret = fbcon_mode_deleted(info, mode);
 		break;
-	case FB_EVENT_FB_UNBIND:
-		idx = info->node;
-		ret = fbcon_fb_unbind(idx);
-		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
 		/* called with console lock held */
 		con2fb = event->data;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d73762324ca2..f3fc2e5b193c 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1716,8 +1716,6 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 
 static int unbind_console(struct fb_info *fb_info)
 {
-	struct fb_event event;
-	int ret;
 	int i = fb_info->node;
 
 	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
@@ -1725,12 +1723,11 @@ static int unbind_console(struct fb_info *fb_info)
 
 	console_lock();
 	lock_fb_info(fb_info);
-	event.info = fb_info;
-	ret = fb_notifier_call_chain(FB_EVENT_FB_UNBIND, &event);
+	fbcon_fb_unbind(fb_info);
 	unlock_fb_info(fb_info);
 	console_unlock();
 
-	return ret;
+	return 0;
 }
 
 static int __unlink_framebuffer(struct fb_info *fb_info);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index aa8f18163151..b6ce041d9e13 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -158,8 +158,6 @@ struct fb_cursor_user {
 #define FB_EVENT_CONBLANK               0x0C
 /*      Get drawing requirements        */
 #define FB_EVENT_GET_REQ                0x0D
-/*      Unbind from the console if possible */
-#define FB_EVENT_FB_UNBIND              0x0E
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 94a71e9e1257..38d44fdb6d14 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -6,11 +6,13 @@ void __init fb_console_init(void);
 void __exit fb_console_exit(void);
 int fbcon_fb_registered(struct fb_info *info);
 void fbcon_fb_unregistered(struct fb_info *info);
+void fbcon_fb_unbind(struct fb_info *info);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
 static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
 static inline void fbcon_fb_unregistered(struct fb_info *info) {}
+static inline void fbcon_fb_unbind(struct fb_info *info) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1
