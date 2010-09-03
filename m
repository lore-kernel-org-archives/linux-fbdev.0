From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:27 +0000
Subject: [PATCH 11/15] fbdev: sh_mobile_lcdcfb: separate display variable
Message-Id: <Pine.LNX.4.64.1009030915390.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is a preparation for a patch, that shall allow displaying of a smaller
framebuffer on a bigger display and of a part of a bigger framebuffer on a
smaller display.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c   |    8 ++++++--
 drivers/video/sh_mobile_lcdcfb.c |   37 ++++++++++++++++++++-----------------
 drivers/video/sh_mobile_lcdcfb.h |    1 +
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index a645d71..9034815 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -838,6 +838,7 @@ static void hdmi_display_on(void *arg, struct fb_info *info)
 	 */
 	struct sh_hdmi *hdmi = arg;
 	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
+	struct sh_mobile_lcdc_chan *ch = info->par;
 
 	pr_debug("%s(%p): state %x\n", __func__, pdata->lcd_dev, info->state);
 
@@ -853,7 +854,7 @@ static void hdmi_display_on(void *arg, struct fb_info *info)
 	case HDMI_HOTPLUG_DISCONNECTED:
 		info->state = FBINFO_STATE_SUSPENDED;
 	default:
-		hdmi->var = info->var;
+		hdmi->var = ch->display_var;
 	}
 }
 
@@ -873,6 +874,7 @@ static void edid_work_fn(struct work_struct *work)
 {
 	struct sh_hdmi *hdmi = container_of(work, struct sh_hdmi, edid_work.work);
 	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
+	struct sh_mobile_lcdc_chan *ch;
 
 	pr_debug("%s(%p): begin, hotplug status %d\n", __func__,
 		 pdata->lcd_dev, hdmi->hp_state);
@@ -894,10 +896,12 @@ static void edid_work_fn(struct work_struct *work)
 		if (!hdmi->info)
 			goto out;
 
+		ch = hdmi->info->par;
+
 		acquire_console_sem();
 
 		/* HDMI plug in */
-		hdmi->info->var = hdmi->var;
+		ch->display_var = hdmi->var;
 		if (hdmi->info->state != FBINFO_STATE_RUNNING) {
 			fb_set_suspend(hdmi->info, 0);
 		} else {
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 29d7ce7..946a810 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -384,8 +384,8 @@ static void sh_mobile_lcdc_start_stop(struct sh_mobile_lcdc_priv *priv,
 
 static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
 {
-	struct fb_var_screeninfo *var = &ch->info->var;
-	unsigned long h_total, hsync_pos;
+	struct fb_var_screeninfo *var = &ch->info->var, *display_var = &ch->display_var;
+	unsigned long h_total, hsync_pos, display_h_total;
 	u32 tmp;
 
 	tmp = ch->ldmt1r_value;
@@ -403,31 +403,33 @@ static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
 	lcdc_write_chan(ch, LDMT3R, ch->cfg.sys_bus_cfg.ldmt3r);
 
 	/* horizontal configuration */
-	h_total = var->xres + var->hsync_len +
-		var->left_margin + var->right_margin;
+	h_total = display_var->xres + display_var->hsync_len +
+		display_var->left_margin + display_var->right_margin;
 	tmp = h_total / 8; /* HTCN */
-	tmp |= (var->xres / 8) << 16; /* HDCN */
+	tmp |= (min(display_var->xres, var->xres) / 8) << 16; /* HDCN */
 	lcdc_write_chan(ch, LDHCNR, tmp);
 
-	hsync_pos = var->xres + var->right_margin;
+	hsync_pos = display_var->xres + display_var->right_margin;
 	tmp = hsync_pos / 8; /* HSYNP */
-	tmp |= (var->hsync_len / 8) << 16; /* HSYNW */
+	tmp |= (display_var->hsync_len / 8) << 16; /* HSYNW */
 	lcdc_write_chan(ch, LDHSYNR, tmp);
 
 	/* vertical configuration */
-	tmp = var->yres + var->vsync_len +
-		var->upper_margin + var->lower_margin; /* VTLN */
-	tmp |= var->yres << 16; /* VDLN */
+	tmp = display_var->yres + display_var->vsync_len +
+		display_var->upper_margin + display_var->lower_margin; /* VTLN */
+	tmp |= min(display_var->yres, var->yres) << 16; /* VDLN */
 	lcdc_write_chan(ch, LDVLNR, tmp);
 
-	tmp = var->yres + var->lower_margin; /* VSYNP */
-	tmp |= var->vsync_len << 16; /* VSYNW */
+	tmp = display_var->yres + display_var->lower_margin; /* VSYNP */
+	tmp |= display_var->vsync_len << 16; /* VSYNW */
 	lcdc_write_chan(ch, LDVSYNR, tmp);
 
 	/* Adjust horizontal synchronisation for HDMI */
-	tmp = ((var->xres & 7) << 24) |
-		((h_total & 7) << 16) |
-		((var->hsync_len & 7) << 8) |
+	display_h_total = display_var->xres + display_var->hsync_len +
+		display_var->left_margin + display_var->right_margin;
+	tmp = ((display_var->xres & 7) << 24) |
+		((display_h_total & 7) << 16) |
+		((display_var->hsync_len & 7) << 8) |
 		hsync_pos;
 	lcdc_write_chan(ch, LDHAJR, tmp);
 }
@@ -477,7 +479,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			m = 1 << 6;
 		tmp |= m << (lcdc_chan_is_sublcd(ch) ? 8 : 0);
 
-		lcdc_write_chan(ch, LDDCKPAT1R, 0x00000000);
+		lcdc_write_chan(ch, LDDCKPAT1R, 0);
 		lcdc_write_chan(ch, LDDCKPAT2R, (1 << (m/2)) - 1);
 	}
 
@@ -520,7 +522,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 		/* set bpp format in PKF[4:0] */
 		tmp = lcdc_read_chan(ch, LDDFR);
-		tmp &= ~(0x0001001f);
+		tmp &= ~0x0001001f;
 		tmp |= (ch->info->var.bits_per_pixel = 16) ? 3 : 0;
 		lcdc_write_chan(ch, LDDFR, tmp);
 
@@ -1153,6 +1155,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		info->screen_base = buf;
 		info->device = &pdev->dev;
 		info->par = ch;
+		ch->display_var = *var;
 	}
 
 	if (error)
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 6fcfc0f..dfd3d76 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -32,6 +32,7 @@ struct sh_mobile_lcdc_chan {
 	unsigned long pan_offset;
 	wait_queue_head_t frame_end_wait;
 	struct completion vsync_completion;
+	struct fb_var_screeninfo display_var;
 };
 
 #endif
-- 
1.7.1

