From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 14 Sep 2010 14:48:54 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdc: reconfigure the framebuffer, when
Message-Id: <Pine.LNX.4.64.1009141644130.31947@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Currently the sh_mobile_lcdc driver only reconfigures the hardware interface,
when a new monitor is plugged in. This patch adds support for dynamic
framebuffer reconfiguration, when no user is holding the framebuffer device
node open.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |  112 +++++++++++++++++++++++++++++++++++++-
 drivers/video/sh_mobile_lcdcfb.h |    3 +
 2 files changed, 114 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index b4a8786..d6e9ff5 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -20,6 +20,7 @@
 #include <linux/vmalloc.h>
 #include <linux/ioctl.h>
 #include <linux/slab.h>
+#include <linux/console.h>
 #include <video/sh_mobile_lcdc.h>
 #include <asm/atomic.h>
 
@@ -479,6 +480,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			m = 1 << 6;
 		tmp |= m << (lcdc_chan_is_sublcd(ch) ? 8 : 0);
 
+		/* FIXME: sh7724 can only use 42, 48, 54 and 60 for the divider denominator */
 		lcdc_write_chan(ch, LDDCKPAT1R, 0);
 		lcdc_write_chan(ch, LDDCKPAT2R, (1 << (m/2)) - 1);
 	}
@@ -815,6 +817,103 @@ static int sh_mobile_ioctl(struct fb_info *info, unsigned int cmd,
 	return retval;
 }
 
+static void sh_mobile_fb_reconfig(struct fb_info *info)
+{
+	struct sh_mobile_lcdc_chan *ch = info->par;
+	struct fb_videomode mode1, mode2;
+	struct fb_event event;
+	int evnt = FB_EVENT_MODE_CHANGE_ALL;
+
+	if (ch->use_count > 1 || (ch->use_count = 1 && !info->fbcon_par))
+		/* More framebuffer users are active */
+		return;
+
+	fb_var_to_videomode(&mode1, &ch->display_var);
+	fb_var_to_videomode(&mode2, &info->var);
+
+	if (fb_mode_is_equal(&mode1, &mode2))
+		return;
+
+	/* Display has been re-plugged, framebuffer is free now, reconfigure */
+	if (fb_set_var(info, &ch->display_var) < 0)
+		/* Couldn't reconfigure, hopefully, can continue as before */
+		return;
+
+	info->fix.line_length = mode2.xres * (ch->cfg.bpp / 8);
+
+	/*
+	 * fb_set_var() calls the notifier change internally, only if
+	 * FBINFO_MISC_USEREVENT flag is set. Since we do not want to fake a
+	 * user event, we have to call the chain ourselves.
+	 */
+	event.info = info;
+	event.data = &mode2;
+	fb_notifier_call_chain(evnt, &event);
+}
+
+/*
+ * Locking: both .fb_release() and .fb_open() are called with info->lock held if
+ * user = 1, or with console sem held, if user = 0.
+ */
+static int sh_mobile_release(struct fb_info *info, int user)
+{
+	struct sh_mobile_lcdc_chan *ch = info->par;
+
+	mutex_lock(&ch->open_lock);
+	dev_dbg(info->dev, "%s(): %d users\n", __func__, ch->use_count);
+
+	ch->use_count--;
+
+	/* Nothing to reconfigure, when called from fbcon */
+	if (user) {
+		acquire_console_sem();
+		sh_mobile_fb_reconfig(info);
+		release_console_sem();
+	}
+
+	mutex_unlock(&ch->open_lock);
+
+	return 0;
+}
+
+static int sh_mobile_open(struct fb_info *info, int user)
+{
+	struct sh_mobile_lcdc_chan *ch = info->par;
+
+	mutex_lock(&ch->open_lock);
+	ch->use_count++;
+
+	dev_dbg(info->dev, "%s(): %d users\n", __func__, ch->use_count);
+	mutex_unlock(&ch->open_lock);
+
+	return 0;
+}
+
+static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct sh_mobile_lcdc_chan *ch = info->par;
+
+	if (var->xres < 160 || var->xres > 1920 ||
+	    var->yres < 120 || var->yres > 1080 ||
+	    var->left_margin < 32 || var->left_margin > 320 ||
+	    var->right_margin < 12 || var->right_margin > 240 ||
+	    var->upper_margin < 12 || var->upper_margin > 120 ||
+	    var->lower_margin < 1 || var->lower_margin > 64 ||
+	    var->hsync_len < 32 || var->hsync_len > 120 ||
+	    var->vsync_len < 2 || var->vsync_len > 64 ||
+	    var->pixclock < 6000 || var->pixclock > 40000 ||
+	    var->xres * var->yres * (ch->cfg.bpp / 8) * 2 > info->fix.smem_len) {
+		dev_warn(info->dev, "Invalid info: %u %u %u %u %u %u %u %u %u!\n",
+			 var->xres, var->yres,
+			 var->left_margin, var->right_margin,
+			 var->upper_margin, var->lower_margin,
+			 var->hsync_len, var->vsync_len,
+			 var->pixclock);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static struct fb_ops sh_mobile_lcdc_ops = {
 	.owner          = THIS_MODULE,
 	.fb_setcolreg	= sh_mobile_lcdc_setcolreg,
@@ -825,6 +924,9 @@ static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_imageblit	= sh_mobile_lcdc_imageblit,
 	.fb_pan_display = sh_mobile_fb_pan_display,
 	.fb_ioctl       = sh_mobile_ioctl,
+	.fb_open	= sh_mobile_open,
+	.fb_release	= sh_mobile_release,
+	.fb_check_var	= sh_mobile_check_var,
 };
 
 static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp)
@@ -964,9 +1066,13 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 	case FB_EVENT_RESUME:
 		var = &info->var;
 
+		mutex_lock(&ch->open_lock);
+		sh_mobile_fb_reconfig(info);
+		mutex_unlock(&ch->open_lock);
+
 		/* HDMI must be enabled before LCDC configuration */
 		if (try_module_get(board_cfg->owner) && board_cfg->display_on) {
-			board_cfg->display_on(board_cfg->board_data, ch->info);
+			board_cfg->display_on(board_cfg->board_data, info);
 			module_put(board_cfg->owner);
 		}
 
@@ -1086,9 +1192,13 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		info = ch->info;
 		var = &info->var;
 		info->fbops = &sh_mobile_lcdc_ops;
+
+		mutex_init(&ch->open_lock);
+
 		fb_videomode_to_var(var, &cfg->lcd_cfg[0]);
 		/* Default Y virtual resolution is 2x panel size */
 		var->yres_virtual = var->yres * 2;
+		var->activate = FB_ACTIVATE_NOW;
 
 		error = sh_mobile_lcdc_set_bpp(var, cfg->bpp);
 		if (error)
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index dfd3d76..9ecee2f 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -3,6 +3,7 @@
 
 #include <linux/completion.h>
 #include <linux/fb.h>
+#include <linux/mutex.h>
 #include <linux/wait.h>
 
 /* per-channel registers */
@@ -33,6 +34,8 @@ struct sh_mobile_lcdc_chan {
 	wait_queue_head_t frame_end_wait;
 	struct completion vsync_completion;
 	struct fb_var_screeninfo display_var;
+	int use_count;
+	struct mutex open_lock;		/* protects the use counter */
 };
 
 #endif
-- 
1.7.1

