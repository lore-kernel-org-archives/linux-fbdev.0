From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:03:01 +0000
Subject: [PATCH 30/33] fbcon: Call con2fb_map functions directly
Message-Id: <20190528090304.9388-31-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Peter Rosin <peda@axentia.se>, Mikulas Patocka <mpatocka@redhat.com>

These are actually fbcon ioctls which just happen to be exposed
through /dev/fb*. They completely ignore which fb_info they're called
on, and I think the userspace tool even hardcodes to /dev/fb0.

Hence just forward the entire thing to fbcon.c wholesale.

Note that this patch drops the fb_lock/unlock on the set side. Since
the ioctl can operate on any fb (as passed in through
con2fb.framebuffer) this is bogus. Also note that fbcon.c in general
never calls fb_lock on anything, so this has been badly broken
already.

With this the last user of the fbcon notifier callback is gone, and we
can garbage collect that too.

v2: add missing uaccess.h include (alpha fails to compile otherwise),
reported by kbuild.

v3: Remember to also drop the #defines (Maarten)

v4: Add the static inline to dummy functions.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/video/fbdev/core/fbcon.c | 59 +++++++++++++++++++-------------
 drivers/video/fbdev/core/fbmem.c | 34 ++----------------
 include/linux/fb.h               |  4 ---
 include/linux/fbcon.h            |  4 +++
 4 files changed, 42 insertions(+), 59 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 158b9d5233e1..fbd28aeff307 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -76,6 +76,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/crc32.h> /* For counting font checksums */
+#include <linux/uaccess.h>
 #include <asm/fb.h>
 #include <asm/irq.h>
 
@@ -3318,29 +3319,47 @@ void fbcon_get_requirement(struct fb_info *info,
 	}
 }
 
-static int fbcon_event_notify(struct notifier_block *self,
-			      unsigned long action, void *data)
+int fbcon_set_con2fb_map_ioctl(void __user *argp)
 {
-	struct fb_event *event = data;
-	struct fb_info *info = event->info;
-	struct fb_con2fbmap *con2fb;
-	int idx, ret = 0;
+	struct fb_con2fbmap con2fb;
+	int ret;
 
-	switch(action) {
-	case FB_EVENT_SET_CONSOLE_MAP:
-		/* called with console lock held */
-		con2fb = event->data;
-		ret = set_con2fb_map(con2fb->console - 1,
-				     con2fb->framebuffer, 1);
-		break;
-	case FB_EVENT_GET_CONSOLE_MAP:
-		con2fb = event->data;
-		con2fb->framebuffer = con2fb_map[con2fb->console - 1];
-		break;
+	if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
+		return -EFAULT;
+	if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
+		return -EINVAL;
+	if (con2fb.framebuffer >= FB_MAX)
+		return -EINVAL;
+	if (!registered_fb[con2fb.framebuffer])
+		request_module("fb%d", con2fb.framebuffer);
+	if (!registered_fb[con2fb.framebuffer]) {
+		return -EINVAL;
 	}
+
+	console_lock();
+	ret = set_con2fb_map(con2fb.console - 1,
+			     con2fb.framebuffer, 1);
+	console_unlock();
+
 	return ret;
 }
 
+int fbcon_get_con2fb_map_ioctl(void __user *argp)
+{
+	struct fb_con2fbmap con2fb;
+
+	if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
+		return -EFAULT;
+	if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
+		return -EINVAL;
+
+	console_lock();
+	con2fb.framebuffer = con2fb_map[con2fb.console - 1];
+	console_unlock();
+
+	return copy_to_user(argp, &con2fb, sizeof(con2fb)) ? -EFAULT : 0;
+}
+
 /*
  *  The console `switch' structure for the frame buffer based console
  */
@@ -3372,10 +3391,6 @@ static const struct consw fb_con = {
 	.con_debug_leave	= fbcon_debug_leave,
 };
 
-static struct notifier_block fbcon_event_notifier = {
-	.notifier_call	= fbcon_event_notify,
-};
-
 static ssize_t store_rotate(struct device *device,
 			    struct device_attribute *attr, const char *buf,
 			    size_t count)
@@ -3648,7 +3663,6 @@ void __init fb_console_init(void)
 	int i;
 
 	console_lock();
-	fb_register_client(&fbcon_event_notifier);
 	fbcon_device = device_create(fb_class, NULL, MKDEV(0, 0), NULL,
 				     "fbcon");
 
@@ -3684,7 +3698,6 @@ static void __exit fbcon_deinit_device(void)
 void __exit fb_console_exit(void)
 {
 	console_lock();
-	fb_unregister_client(&fbcon_event_notifier);
 	fbcon_deinit_device();
 	device_destroy(fb_class, MKDEV(0, 0));
 	fbcon_exit();
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index dd1a708df1a7..64dd732021d8 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1092,10 +1092,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	struct fb_ops *fb;
 	struct fb_var_screeninfo var;
 	struct fb_fix_screeninfo fix;
-	struct fb_con2fbmap con2fb;
 	struct fb_cmap cmap_from;
 	struct fb_cmap_user cmap;
-	struct fb_event event;
 	void __user *argp = (void __user *)arg;
 	long ret = 0;
 
@@ -1157,38 +1155,10 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		ret = -EINVAL;
 		break;
 	case FBIOGET_CON2FBMAP:
-		if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
-			return -EFAULT;
-		if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
-			return -EINVAL;
-		con2fb.framebuffer = -1;
-		event.data = &con2fb;
-		lock_fb_info(info);
-		event.info = info;
-		fb_notifier_call_chain(FB_EVENT_GET_CONSOLE_MAP, &event);
-		unlock_fb_info(info);
-		ret = copy_to_user(argp, &con2fb, sizeof(con2fb)) ? -EFAULT : 0;
+		ret = fbcon_get_con2fb_map_ioctl(argp);
 		break;
 	case FBIOPUT_CON2FBMAP:
-		if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
-			return -EFAULT;
-		if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
-			return -EINVAL;
-		if (con2fb.framebuffer >= FB_MAX)
-			return -EINVAL;
-		if (!registered_fb[con2fb.framebuffer])
-			request_module("fb%d", con2fb.framebuffer);
-		if (!registered_fb[con2fb.framebuffer]) {
-			ret = -EINVAL;
-			break;
-		}
-		event.data = &con2fb;
-		console_lock();
-		lock_fb_info(info);
-		event.info = info;
-		ret = fb_notifier_call_chain(FB_EVENT_SET_CONSOLE_MAP, &event);
-		unlock_fb_info(info);
-		console_unlock();
+		ret = fbcon_set_con2fb_map_ioctl(argp);
 		break;
 	case FBIOBLANK:
 		console_lock();
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 25e4b885f5b3..303771264644 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -133,10 +133,6 @@ struct fb_cursor_user {
 #define FB_EVENT_FB_UNREGISTERED        0x06
 #endif
 
-/*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
-#define FB_EVENT_GET_CONSOLE_MAP        0x07
-/*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
-#define FB_EVENT_SET_CONSOLE_MAP        0x08
 /*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x09
 /*      A hardware display blank early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 69f900d289b2..ff5596dd30f8 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -17,6 +17,8 @@ void fbcon_get_requirement(struct fb_info *info,
 void fbcon_fb_blanked(struct fb_info *info, int blank);
 void fbcon_update_vcs(struct fb_info *info, bool all);
 void fbcon_remap_all(struct fb_info *info);
+int fbcon_set_con2fb_map_ioctl(void __user *argp);
+int fbcon_get_con2fb_map_ioctl(void __user *argp);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
@@ -33,6 +35,8 @@ static inline void fbcon_get_requirement(struct fb_info *info,
 static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
 static inline void fbcon_update_vcs(struct fb_info *info, bool all) {}
 static inline void fbcon_remap_all(struct fb_info *info) {}
+static inline int fbcon_set_con2fb_map_ioctl(void __user *argp) { return 0; }
+static inline int fbcon_get_con2fb_map_ioctl(void __user *argp) { return 0; }
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1
