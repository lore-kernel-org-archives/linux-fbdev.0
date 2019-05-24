From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 24 May 2019 08:53:50 +0000
Subject: [PATCH 29/33] vgaswitcheroo: call fbcon_remap_all directly
Message-Id: <20190524085354.27411-30-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org

While at it, clean up the interface a bit and push the console locking
into fbcon.c.

v2: Remove now outdated comment (Lukas).

v3: Forgot to add static inline to the dummy function.

Acked-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/gpu/vga/vga_switcheroo.c | 11 +++--------
 drivers/video/fbdev/core/fbcon.c | 14 +++++---------
 include/linux/fb.h               |  2 --
 include/linux/fbcon.h            |  2 ++
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index a132c37d7334..65d7541c413a 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -35,6 +35,7 @@
 #include <linux/debugfs.h>
 #include <linux/fb.h>
 #include <linux/fs.h>
+#include <linux/fbcon.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pm_domain.h>
@@ -736,14 +737,8 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
 	if (!active->driver_power_control)
 		set_audio_state(active->id, VGA_SWITCHEROO_OFF);
 
-	if (new_client->fb_info) {
-		struct fb_event event;
-
-		console_lock();
-		event.info = new_client->fb_info;
-		fb_notifier_call_chain(FB_EVENT_REMAP_ALL_CONSOLE, &event);
-		console_unlock();
-	}
+	if (new_client->fb_info)
+		fbcon_remap_all(new_client->fb_info);
 
 	mutex_lock(&vgasr_priv.mux_hw_lock);
 	ret = vgasr_priv.handler->switchto(new_client->id);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index a07c261da53a..e08e984e2511 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3149,17 +3149,16 @@ void fbcon_fb_unregistered(struct fb_info *info)
 		do_unregister_con_driver(&fb_con);
 }
 
-/* called with console_lock held */
-static void fbcon_remap_all(int idx)
+void fbcon_remap_all(struct fb_info *info)
 {
-	int i;
-
-	WARN_CONSOLE_UNLOCKED();
+	int i, idx = info->node;
 
+	console_lock();
 	if (deferred_takeover) {
 		for (i = first_fb_vc; i <= last_fb_vc; i++)
 			con2fb_map_boot[i] = idx;
 		fbcon_map_override();
+		console_unlock();
 		return;
 	}
 
@@ -3172,6 +3171,7 @@ static void fbcon_remap_all(int idx)
 		       first_fb_vc + 1, last_fb_vc + 1);
 		info_idx = idx;
 	}
+	console_unlock();
 }
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
@@ -3337,10 +3337,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		con2fb = event->data;
 		con2fb->framebuffer = con2fb_map[con2fb->console - 1];
 		break;
-	case FB_EVENT_REMAP_ALL_CONSOLE:
-		idx = info->node;
-		fbcon_remap_all(idx);
-		break;
 	}
 	return ret;
 }
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f9c212f9b661..25e4b885f5b3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -139,8 +139,6 @@ struct fb_cursor_user {
 #define FB_EVENT_SET_CONSOLE_MAP        0x08
 /*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x09
-/*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
-#define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
 #define FB_EARLY_EVENT_BLANK		0x10
 /*      A hardware display blank revert early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index de31eeb22c97..69f900d289b2 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -16,6 +16,7 @@ void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps);
 void fbcon_fb_blanked(struct fb_info *info, int blank);
 void fbcon_update_vcs(struct fb_info *info, bool all);
+void fbcon_remap_all(struct fb_info *info);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
@@ -31,6 +32,7 @@ static inline void fbcon_get_requirement(struct fb_info *info,
 					 struct fb_blit_caps *caps) {}
 static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
 static inline void fbcon_update_vcs(struct fb_info *info, bool all) {}
+static inline void fbcon_remap_all(struct fb_info *info) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1
