From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 20 May 2019 08:22:13 +0000
Subject: [PATCH 30/33] vgaswitcheroo: call fbcon_remap_all directly
Message-Id: <20190520082216.26273-31-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org

While at it, clean up the interface a bit and push the console locking
into fbcon.c.

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
 drivers/video/fbdev/core/fbcon.c | 13 +++++--------
 include/linux/fb.h               |  2 --
 include/linux/fbcon.h            |  2 ++
 4 files changed, 10 insertions(+), 18 deletions(-)

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
index 8cc62d340387..fd604ffb3c05 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3146,16 +3146,16 @@ void fbcon_fb_unregistered(struct fb_info *info)
 }
 
 /* called with console_lock held */
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
 
@@ -3168,6 +3168,7 @@ static void fbcon_remap_all(int idx)
 		       first_fb_vc + 1, last_fb_vc + 1);
 		info_idx = idx;
 	}
+	console_unlock();
 }
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
@@ -3333,10 +3334,6 @@ static int fbcon_event_notify(struct notifier_block *self,
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
index 54d6bee09121..acd8daa23002 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -130,8 +130,6 @@ struct fb_cursor_user {
 #define FB_EVENT_SET_CONSOLE_MAP        0x08
 /*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x09
-/*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
-#define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
 #define FB_EARLY_EVENT_BLANK		0x10
 /*      A hardware display blank revert early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index daaa97b0c9e6..3f854e803746 100644
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
@@ -31,6 +32,7 @@ void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps) {}
 void fbcon_fb_blanked(struct fb_info *info, int blank) {}
 void fbcon_update_vcs(struct fb_info *info, bool all) {}
+void fbcon_remap_all(struct fb_info *info) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1
