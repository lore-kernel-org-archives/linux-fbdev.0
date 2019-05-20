From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 20 May 2019 08:22:07 +0000
Subject: [PATCH 24/33] Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
Message-Id: <20190520082216.26273-25-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Richard Purdie <rpurdie@rpsys.net>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org

This reverts commit 994efacdf9a087b52f71e620b58dfa526b0cf928.

The justification is that if hw blanking fails (i.e. fbops->fb_blank)
fails, then we still want to shut down the backlight. Which is exactly
_not_ what fb_blank() does and so rather inconsistent if we end up
with different behaviour between fbcon and direct fbdev usage. Given
that the entire notifier maze is getting in the way anyway I figured
it's simplest to revert this not well justified commit.

Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/backlight/backlight.c | 2 +-
 drivers/video/fbdev/core/fbcon.c    | 9 ---------
 include/linux/fb.h                  | 4 +---
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index deb824bef6e2..c55590ec0057 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -46,7 +46,7 @@ static int fb_notifier_callback(struct notifier_block *self,
 	int fb_blank = 0;
 
 	/* If we aren't interested in this event, skip it immediately ... */
-	if (event != FB_EVENT_BLANK && event != FB_EVENT_CONBLANK)
+	if (event != FB_EVENT_BLANK)
 		return 0;
 
 	bd = container_of(self, struct backlight_device, fb_notif);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 58b876718d81..1549056a848e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2346,8 +2346,6 @@ static int fbcon_switch(struct vc_data *vc)
 static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 				int blank)
 {
-	struct fb_event event;
-
 	if (blank) {
 		unsigned short charmask = vc->vc_hi_font_mask ?
 			0x1ff : 0xff;
@@ -2358,13 +2356,6 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 		fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
 		vc->vc_video_erase_char = oldc;
 	}
-
-
-	lock_fb_info(info);
-	event.info = info;
-	event.data = &blank;
-	fb_notifier_call_chain(FB_EVENT_CONBLANK, &event);
-	unlock_fb_info(info);
 }
 
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
diff --git a/include/linux/fb.h b/include/linux/fb.h
index e76185244593..4b9b882f8f52 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -130,12 +130,10 @@ struct fb_cursor_user {
 #define FB_EVENT_GET_CONSOLE_MAP        0x07
 /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
 #define FB_EVENT_SET_CONSOLE_MAP        0x08
-/*      A hardware display blank change occurred */
+/*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x09
 /*      Private modelist is to be replaced */
 #define FB_EVENT_MODE_CHANGE_ALL	0x0B
-/*	A software display blank change occurred */
-#define FB_EVENT_CONBLANK               0x0C
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
-- 
2.20.1
