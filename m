From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:42 +0000
Subject: [PATCH 11/33] fbdev/sh_mobile: remove sh_mobile_lcdc_display_notify
Message-Id: <20190528090304.9388-12-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>, Sam Ravnborg <sam@ravnborg.org>

It's dead code, and removing it avoids me having to understand
what it's doing with lock_fb_info.

v2: Also remove sh_mobile_lcdc_must_reconfigure, now unused (Sam).

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> (v1)
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 82 --------------------------
 drivers/video/fbdev/sh_mobile_lcdcfb.h |  5 --
 2 files changed, 87 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index dc46be38c970..1437695415c9 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -534,89 +534,9 @@ static void sh_mobile_lcdc_display_off(struct sh_mobile_lcdc_chan *ch)
 		ch->tx_dev->ops->display_off(ch->tx_dev);
 }
 
-static bool
-sh_mobile_lcdc_must_reconfigure(struct sh_mobile_lcdc_chan *ch,
-				const struct fb_videomode *new_mode)
-{
-	dev_dbg(ch->info->dev, "Old %ux%u, new %ux%u\n",
-		ch->display.mode.xres, ch->display.mode.yres,
-		new_mode->xres, new_mode->yres);
-
-	/* It can be a different monitor with an equal video-mode */
-	if (fb_mode_is_equal(&ch->display.mode, new_mode))
-		return false;
-
-	dev_dbg(ch->info->dev, "Switching %u -> %u lines\n",
-		ch->display.mode.yres, new_mode->yres);
-	ch->display.mode = *new_mode;
-
-	return true;
-}
-
 static int sh_mobile_lcdc_check_var(struct fb_var_screeninfo *var,
 				    struct fb_info *info);
 
-static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
-					 enum sh_mobile_lcdc_entity_event event,
-					 const struct fb_videomode *mode,
-					 const struct fb_monspecs *monspec)
-{
-	struct fb_info *info = ch->info;
-	struct fb_var_screeninfo var;
-	int ret = 0;
-
-	switch (event) {
-	case SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT:
-		/* HDMI plug in */
-		console_lock();
-		if (lock_fb_info(info)) {
-
-
-			ch->display.width = monspec->max_x * 10;
-			ch->display.height = monspec->max_y * 10;
-
-			if (!sh_mobile_lcdc_must_reconfigure(ch, mode) &&
-			    info->state = FBINFO_STATE_RUNNING) {
-				/* First activation with the default monitor.
-				 * Just turn on, if we run a resume here, the
-				 * logo disappears.
-				 */
-				info->var.width = ch->display.width;
-				info->var.height = ch->display.height;
-				sh_mobile_lcdc_display_on(ch);
-			} else {
-				/* New monitor or have to wake up */
-				fb_set_suspend(info, 0);
-			}
-
-
-			unlock_fb_info(info);
-		}
-		console_unlock();
-		break;
-
-	case SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT:
-		/* HDMI disconnect */
-		console_lock();
-		if (lock_fb_info(info)) {
-			fb_set_suspend(info, 1);
-			unlock_fb_info(info);
-		}
-		console_unlock();
-		break;
-
-	case SH_MOBILE_LCDC_EVENT_DISPLAY_MODE:
-		/* Validate a proposed new mode */
-		fb_videomode_to_var(&var, mode);
-		var.bits_per_pixel = info->var.bits_per_pixel;
-		var.grayscale = info->var.grayscale;
-		ret = sh_mobile_lcdc_check_var(&var, info);
-		break;
-	}
-
-	return ret;
-}
-
 /* -----------------------------------------------------------------------------
  * Format helpers
  */
@@ -2540,8 +2460,6 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch)
 	unsigned int max_size;
 	unsigned int i;
 
-	ch->notify = sh_mobile_lcdc_display_notify;
-
 	/* Validate the format. */
 	format = sh_mobile_format_info(cfg->fourcc);
 	if (format = NULL) {
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.h b/drivers/video/fbdev/sh_mobile_lcdcfb.h
index b8e47a8bd8ab..589400372098 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.h
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.h
@@ -87,11 +87,6 @@ struct sh_mobile_lcdc_chan {
 	unsigned long base_addr_c;
 	unsigned int line_size;
 
-	int (*notify)(struct sh_mobile_lcdc_chan *ch,
-		      enum sh_mobile_lcdc_entity_event event,
-		      const struct fb_videomode *mode,
-		      const struct fb_monspecs *monspec);
-
 	/* Backlight */
 	struct backlight_device *bl;
 	unsigned int bl_brightness;
-- 
2.20.1
