From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:25 +0000
Subject: [PATCH 30/57] fbdev: sh_mobile_lcdc: Store display mode in a struct fb_videomode
Message-Id: <1323784972-24205-31-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Embed struct fb_videomode instead of struct fb_var_screeninfo in struct
sh_mobile_lcdc_chan to store the display mode.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   73 ++++++++++++++++++++------------------
 drivers/video/sh_mobile_lcdcfb.h |    6 +++-
 2 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index c5acae7..d672a3f 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -367,21 +367,17 @@ static bool
 sh_mobile_lcdc_must_reconfigure(struct sh_mobile_lcdc_chan *ch,
 				const struct fb_videomode *new_mode)
 {
-	struct fb_var_screeninfo *old_var = &ch->display_var;
-	struct fb_videomode old_mode;
-
-	fb_var_to_videomode(&old_mode, old_var);
-
 	dev_dbg(ch->info->dev, "Old %ux%u, new %ux%u\n",
-		old_mode.xres, old_mode.yres, new_mode->xres, new_mode->yres);
+		ch->display.mode.xres, ch->display.mode.yres,
+		new_mode->xres, new_mode->yres);
 
 	/* It can be a different monitor with an equal video-mode */
-	if (fb_mode_is_equal(&old_mode, new_mode))
+	if (fb_mode_is_equal(&ch->display.mode, new_mode))
 		return false;
 
 	dev_dbg(ch->info->dev, "Switching %u -> %u lines\n",
-		old_mode.yres, new_mode->yres);
-	fb_videomode_to_var(old_var, new_mode);
+		ch->display.mode.yres, new_mode->yres);
+	ch->display.mode = *new_mode;
 
 	return true;
 }
@@ -400,8 +396,8 @@ static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
 		if (lock_fb_info(info)) {
 			console_lock();
 
-			ch->display_var.width = monspec->max_x * 10;
-			ch->display_var.height = monspec->max_y * 10;
+			ch->display.width = monspec->max_x * 10;
+			ch->display.height = monspec->max_y * 10;
 
 			if (!sh_mobile_lcdc_must_reconfigure(ch, mode) &&
 			    info->state = FBINFO_STATE_RUNNING) {
@@ -567,7 +563,8 @@ static void sh_mobile_lcdc_start_stop(struct sh_mobile_lcdc_priv *priv,
 
 static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
 {
-	struct fb_var_screeninfo *var = &ch->info->var, *display_var = &ch->display_var;
+	const struct fb_var_screeninfo *var = &ch->info->var;
+	const struct fb_videomode *mode = &ch->display.mode;
 	unsigned long h_total, hsync_pos, display_h_total;
 	u32 tmp;
 
@@ -586,34 +583,32 @@ static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
 	lcdc_write_chan(ch, LDMT3R, ch->cfg.sys_bus_cfg.ldmt3r);
 
 	/* horizontal configuration */
-	h_total = display_var->xres + display_var->hsync_len +
-		display_var->left_margin + display_var->right_margin;
+	h_total = mode->xres + mode->hsync_len + mode->left_margin
+		+ mode->right_margin;
 	tmp = h_total / 8; /* HTCN */
-	tmp |= (min(display_var->xres, var->xres) / 8) << 16; /* HDCN */
+	tmp |= (min(mode->xres, var->xres) / 8) << 16; /* HDCN */
 	lcdc_write_chan(ch, LDHCNR, tmp);
 
-	hsync_pos = display_var->xres + display_var->right_margin;
+	hsync_pos = mode->xres + mode->right_margin;
 	tmp = hsync_pos / 8; /* HSYNP */
-	tmp |= (display_var->hsync_len / 8) << 16; /* HSYNW */
+	tmp |= (mode->hsync_len / 8) << 16; /* HSYNW */
 	lcdc_write_chan(ch, LDHSYNR, tmp);
 
 	/* vertical configuration */
-	tmp = display_var->yres + display_var->vsync_len +
-		display_var->upper_margin + display_var->lower_margin; /* VTLN */
-	tmp |= min(display_var->yres, var->yres) << 16; /* VDLN */
+	tmp = mode->yres + mode->vsync_len + mode->upper_margin
+	    + mode->lower_margin; /* VTLN */
+	tmp |= min(mode->yres, var->yres) << 16; /* VDLN */
 	lcdc_write_chan(ch, LDVLNR, tmp);
 
-	tmp = display_var->yres + display_var->lower_margin; /* VSYNP */
-	tmp |= display_var->vsync_len << 16; /* VSYNW */
+	tmp = mode->yres + mode->lower_margin; /* VSYNP */
+	tmp |= mode->vsync_len << 16; /* VSYNW */
 	lcdc_write_chan(ch, LDVSYNR, tmp);
 
 	/* Adjust horizontal synchronisation for HDMI */
-	display_h_total = display_var->xres + display_var->hsync_len +
-		display_var->left_margin + display_var->right_margin;
-	tmp = ((display_var->xres & 7) << 24) |
-		((display_h_total & 7) << 16) |
-		((display_var->hsync_len & 7) << 8) |
-		(hsync_pos & 7);
+	display_h_total = mode->xres + mode->hsync_len + mode->left_margin
+			+ mode->right_margin;
+	tmp = ((mode->xres & 7) << 24) | ((display_h_total & 7) << 16)
+	    | ((mode->hsync_len & 7) << 8) | (hsync_pos & 7);
 	lcdc_write_chan(ch, LDHAJR, tmp);
 }
 
@@ -1104,7 +1099,8 @@ static int sh_mobile_ioctl(struct fb_info *info, unsigned int cmd,
 static void sh_mobile_fb_reconfig(struct fb_info *info)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
-	struct fb_videomode mode1, mode2;
+	struct fb_var_screeninfo var;
+	struct fb_videomode mode;
 	struct fb_event event;
 	int evnt = FB_EVENT_MODE_CHANGE_ALL;
 
@@ -1112,14 +1108,18 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 		/* More framebuffer users are active */
 		return;
 
-	fb_var_to_videomode(&mode1, &ch->display_var);
-	fb_var_to_videomode(&mode2, &info->var);
+	fb_var_to_videomode(&mode, &info->var);
 
-	if (fb_mode_is_equal(&mode1, &mode2))
+	if (fb_mode_is_equal(&ch->display.mode, &mode))
 		return;
 
 	/* Display has been re-plugged, framebuffer is free now, reconfigure */
-	if (fb_set_var(info, &ch->display_var) < 0)
+	fb_videomode_to_var(&var, &ch->display.mode);
+	var.width = ch->display.width;
+	var.height = ch->display.height;
+	var.activate = FB_ACTIVATE_NOW;
+
+	if (fb_set_var(info, &var) < 0)
 		/* Couldn't reconfigure, hopefully, can continue as before */
 		return;
 
@@ -1129,7 +1129,7 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 	 * user event, we have to call the chain ourselves.
 	 */
 	event.info = info;
-	event.data = &mode1;
+	event.data = &ch->display.mode;
 	fb_notifier_call_chain(evnt, &event);
 }
 
@@ -1814,7 +1814,10 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 
 	info->screen_base = buf;
 	info->device = priv->dev;
-	ch->display_var = *var;
+
+	ch->display.width = cfg->panel_cfg.width;
+	ch->display.height = cfg->panel_cfg.height;
+	ch->display.mode = *mode;
 
 	return 0;
 }
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 9c91fae..c175387 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -68,7 +68,11 @@ struct sh_mobile_lcdc_chan {
 	unsigned long pan_offset;
 	wait_queue_head_t frame_end_wait;
 	struct completion vsync_completion;
-	struct fb_var_screeninfo display_var;
+	struct {
+		unsigned int width;
+		unsigned int height;
+		struct fb_videomode mode;
+	} display;
 	int use_count;
 	int blank_status;
 	struct mutex open_lock;		/* protects the use counter */
-- 
1.7.3.4

