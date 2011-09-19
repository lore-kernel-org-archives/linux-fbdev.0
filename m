From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:28:02 +0000
Subject: [WIP/RFC 24/31] sh_mobile_lcdc: Add display notify callback to sh_mobile_lcdc_chan
Message-Id: <1316392089-27598-25-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The callback implements 3 notification events:

- SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT notifies the LCDC that the
  display has been connected
- SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT notifies the LCDC that the
  display has been disconnected
- SH_MOBILE_LCDC_EVENT_DISPLAY_MODE notifies that LCDC that a display
  mode has been detected

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   77 ++++++++++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_lcdcfb.h |   10 +++++
 2 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index d6c117b..19ac3c5 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -359,6 +359,82 @@ static void sh_mobile_lcdc_display_off(struct sh_mobile_lcdc_chan *ch)
 		ch->tx_dev->ops->display_off(ch->tx_dev);
 }
 
+static bool
+sh_mobile_lcdc_must_reconfigure(struct sh_mobile_lcdc_chan *ch,
+				const struct fb_var_screeninfo *new_var)
+{
+	struct fb_var_screeninfo *old_var = &ch->display_var;
+	struct fb_videomode old_mode;
+	struct fb_videomode new_mode;
+
+	fb_var_to_videomode(&old_mode, old_var);
+	fb_var_to_videomode(&new_mode, new_var);
+
+	dev_dbg(ch->info->dev, "Old %ux%u, new %ux%u\n",
+		old_mode.xres, old_mode.yres, new_mode.xres, new_mode.yres);
+
+	if (fb_mode_is_equal(&old_mode, &new_mode)) {
+		/* It can be a different monitor with an equal video-mode */
+		old_var->width = new_var->width;
+		old_var->height = new_var->height;
+		return false;
+	}
+
+	dev_dbg(ch->info->dev, "Switching %u -> %u lines\n",
+		old_mode.yres, new_mode.yres);
+	*old_var = *new_var;
+
+	return true;
+}
+
+static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
+					 enum sh_mobile_lcdc_entity_event event,
+					 struct fb_var_screeninfo *var)
+{
+	struct fb_info *info = ch->info;
+	int ret = 0;
+
+	switch (event) {
+	case SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT:
+		/* HDMI plug in */
+		console_lock();
+
+		if (!sh_mobile_lcdc_must_reconfigure(ch, var) &&
+		    info->state = FBINFO_STATE_RUNNING) {
+			/* First activation with the default monitor - just turn
+			 * on, if we run a resume here, the logo disappears.
+			 */
+			if (lock_fb_info(info)) {
+				info->var.width = var->width;
+				info->var.height = var->height;
+				sh_mobile_lcdc_display_on(ch);
+				unlock_fb_info(info);
+			}
+		} else {
+			/* New monitor or have to wake up */
+			fb_set_suspend(info, 0);
+		}
+
+		console_unlock();
+		break;
+
+	case SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT:
+		/* HDMI disconnect */
+		console_lock();
+		fb_set_suspend(info, 1);
+		console_unlock();
+		break;
+
+	case SH_MOBILE_LCDC_EVENT_DISPLAY_MODE:
+		/* Validate a proposed new mode */
+		var->bits_per_pixel = info->var.bits_per_pixel;
+		ret = info->fbops->fb_check_var(var, info);
+		break;
+	}
+
+	return ret;
+}
+
 /* -----------------------------------------------------------------------------
  * Format helpers
  */
@@ -1589,6 +1665,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	int i;
 
 	mutex_init(&ch->open_lock);
+	ch->notify = sh_mobile_lcdc_display_notify;
 
 	/* Allocate the frame buffer device. */
 	ch->info = framebuffer_alloc(0, priv->dev);
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 8f1e007..ec57533 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -27,6 +27,12 @@ struct sh_mobile_lcdc_entity_ops {
 	void (*display_off)(struct sh_mobile_lcdc_entity *entity);
 };
 
+enum sh_mobile_lcdc_entity_event {
+	SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT,
+	SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT,
+	SH_MOBILE_LCDC_EVENT_DISPLAY_MODE,
+};
+
 struct sh_mobile_lcdc_entity {
 	struct module *owner;
 	const struct sh_mobile_lcdc_entity_ops *ops;
@@ -67,6 +73,10 @@ struct sh_mobile_lcdc_chan {
 	unsigned long base_addr_y;
 	unsigned long base_addr_c;
 	unsigned int pitch;
+
+	int (*notify)(struct sh_mobile_lcdc_chan *ch,
+		      enum sh_mobile_lcdc_entity_event event,
+		      struct fb_var_screeninfo *var);
 };
 
 #endif
-- 
1.7.3.4

