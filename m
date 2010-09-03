From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:31 +0000
Subject: [PATCH 12/15] fbdev: sh_mobile_hdmi: cosmetic improvements
Message-Id: <Pine.LNX.4.64.1009030916040.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Improve comments, unify function names, replace pr_debug with dev_dbg.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |   82 ++++++++++++++++++++++------------------
 1 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 9034815..6f6a042 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -206,7 +206,7 @@ enum hotplug_state {
 
 struct sh_hdmi {
 	void __iomem *base;
-	enum hotplug_state hp_state;
+	enum hotplug_state hp_state;	/* hot-plug status */
 	bool preprogrammed_mode;	/* use a pre-programmed VIC or the external mode */
 	struct clk *hdmi_clk;
 	struct device *dev;
@@ -227,7 +227,7 @@ static u8 hdmi_read(struct sh_hdmi *hdmi, u8 reg)
 }
 
 /* External video parameter settings */
-static void hdmi_external_video_param(struct sh_hdmi *hdmi)
+static void sh_hdmi_external_video_param(struct sh_hdmi *hdmi)
 {
 	struct fb_var_screeninfo *var = &hdmi->var;
 	u16 htotal, hblank, hdelay, vtotal, vblank, vdelay, voffset;
@@ -259,9 +259,9 @@ static void hdmi_external_video_param(struct sh_hdmi *hdmi)
 	if (var->sync & FB_SYNC_VERT_HIGH_ACT)
 		sync |= 8;
 
-	pr_debug("H: %u, %u, %u, %u; V: %u, %u, %u, %u; sync 0x%x\n",
-		 htotal, hblank, hdelay, var->hsync_len,
-		 vtotal, vblank, vdelay, var->vsync_len, sync);
+	dev_dbg(hdmi->dev, "H: %u, %u, %u, %u; V: %u, %u, %u, %u; sync 0x%x\n",
+		htotal, hblank, hdelay, var->hsync_len,
+		vtotal, vblank, vdelay, var->vsync_len, sync);
 
 	hdmi_write(hdmi, sync | (voffset << 4), HDMI_EXTERNAL_VIDEO_PARAM_SETTINGS);
 
@@ -476,9 +476,9 @@ static void sh_hdmi_avi_infoframe_setup(struct sh_hdmi *hdmi)
 	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB1);
 
 	/*
-	 * C = No Data
-	 * M = 16:9 Picture Aspect Ratio
-	 * R = Same as picture aspect ratio
+	 * [7:6] C = Colorimetry: no data
+	 * [5:4] M = 2: 16:9, 1: 4:3 Picture Aspect Ratio
+	 * [3:0] R = 8: Active Frame Aspect Ratio: same as picture aspect ratio
 	 */
 	hdmi_write(hdmi, 0x28, HDMI_CTRL_PKT_BUF_ACCESS_PB2);
 
@@ -725,7 +725,7 @@ static void sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 	u8 edid[128];
 
 	/* Read EDID */
-	pr_debug("Read back EDID code:");
+	dev_dbg(hdmi->dev, "Read back EDID code:");
 	for (i = 0; i < 128; i++) {
 		edid[i] = hdmi_read(hdmi, HDMI_EDID_KSV_FIFO_ACCESS_WINDOW);
 #ifdef DEBUG
@@ -741,10 +741,10 @@ static void sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 	printk(KERN_CONT "\n");
 #endif
 	fb_parse_edid(edid, var);
-	pr_debug("%u-%u-%u-%u x %u-%u-%u-%u @ %lu kHz monitor detected\n",
-		 var->left_margin, var->xres, var->right_margin, var->hsync_len,
-		 var->upper_margin, var->yres, var->lower_margin, var->vsync_len,
-		 PICOS2KHZ(var->pixclock));
+	dev_dbg(hdmi->dev, "%u-%u-%u-%u x %u-%u-%u-%u @ %lu kHz monitor detected\n",
+		var->left_margin, var->xres, var->right_margin, var->hsync_len,
+		var->upper_margin, var->yres, var->lower_margin, var->vsync_len,
+		PICOS2KHZ(var->pixclock));
 
 	if ((hdmi->var.xres = 720 && hdmi->var.yres = 480) ||
 	    (hdmi->var.xres = 1280 && hdmi->var.yres = 720) ||
@@ -753,7 +753,7 @@ static void sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 	else
 		hdmi->preprogrammed_mode = false;
 
-	hdmi_external_video_param(hdmi);
+	sh_hdmi_external_video_param(hdmi);
 }
 
 static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
@@ -781,8 +781,8 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 	hdmi_write(hdmi, 0xFF, HDMI_INTERRUPT_STATUS_2);
 
 	if (printk_ratelimit())
-		pr_debug("IRQ #%d: Status #1: 0x%x & 0x%x, #2: 0x%x & 0x%x\n",
-			 irq, status1, mask1, status2, mask2);
+		dev_dbg(hdmi->dev, "IRQ #%d: Status #1: 0x%x & 0x%x, #2: 0x%x & 0x%x\n",
+			irq, status1, mask1, status2, mask2);
 
 	if (!((status1 & mask1) | (status2 & mask2))) {
 		return IRQ_NONE;
@@ -793,7 +793,7 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 		udelay(500);
 
 		msens = hdmi_read(hdmi, HDMI_HOT_PLUG_MSENS_STATUS);
-		pr_debug("MSENS 0x%x\n", msens);
+		dev_dbg(hdmi->dev, "MSENS 0x%x\n", msens);
 		/* Check, if hot plug & MSENS pin status are both high */
 		if ((msens & 0xC0) = 0xC0) {
 			/* Display plug in */
@@ -830,7 +830,7 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 }
 
 /* locking:	called with info->lock held, or before register_framebuffer() */
-static void hdmi_display_on(void *arg, struct fb_info *info)
+static void sh_hdmi_display_on(void *arg, struct fb_info *info)
 {
 	/*
 	 * info is guaranteed to be valid, when we are called, because our
@@ -840,16 +840,23 @@ static void hdmi_display_on(void *arg, struct fb_info *info)
 	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
 	struct sh_mobile_lcdc_chan *ch = info->par;
 
-	pr_debug("%s(%p): state %x\n", __func__, pdata->lcd_dev, info->state);
+	dev_dbg(hdmi->dev, "%s(%p): state %x\n", __func__,
+		pdata->lcd_dev, info->state);
 
 	/* No need to lock */
 	hdmi->info = info;
 
+	/*
+	 * hp_state can be set to
+	 * HDMI_HOTPLUG_DISCONNECTED:	on monitor unplug
+	 * HDMI_HOTPLUG_CONNECTED:	on monitor plug-in
+	 * HDMI_HOTPLUG_EDID_DONE:	on EDID read completion
+	 */
 	switch (hdmi->hp_state) {
 	case HDMI_HOTPLUG_EDID_DONE:
 		/* PS mode d->e. All functions are active */
 		hdmi_write(hdmi, 0x80, HDMI_SYSTEM_CTRL);
-		pr_debug("HDMI running\n");
+		dev_dbg(hdmi->dev, "HDMI running\n");
 		break;
 	case HDMI_HOTPLUG_DISCONNECTED:
 		info->state = FBINFO_STATE_SUSPENDED;
@@ -859,25 +866,25 @@ static void hdmi_display_on(void *arg, struct fb_info *info)
 }
 
 /* locking: called with info->lock held */
-static void hdmi_display_off(void *arg)
+static void sh_hdmi_display_off(void *arg)
 {
 	struct sh_hdmi *hdmi = arg;
 	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
 
-	pr_debug("%s(%p)\n", __func__, pdata->lcd_dev);
+	dev_dbg(hdmi->dev, "%s(%p)\n", __func__, pdata->lcd_dev);
 	/* PS mode e->a */
 	hdmi_write(hdmi, 0x10, HDMI_SYSTEM_CTRL);
 }
 
 /* Hotplug interrupt occurred, read EDID */
-static void edid_work_fn(struct work_struct *work)
+static void sh_hdmi_edid_work_fn(struct work_struct *work)
 {
 	struct sh_hdmi *hdmi = container_of(work, struct sh_hdmi, edid_work.work);
 	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
 	struct sh_mobile_lcdc_chan *ch;
 
-	pr_debug("%s(%p): begin, hotplug status %d\n", __func__,
-		 pdata->lcd_dev, hdmi->hp_state);
+	dev_dbg(hdmi->dev, "%s(%p): begin, hotplug status %d\n", __func__,
+		pdata->lcd_dev, hdmi->hp_state);
 
 	if (!pdata->lcd_dev)
 		return;
@@ -906,7 +913,7 @@ static void edid_work_fn(struct work_struct *work)
 			fb_set_suspend(hdmi->info, 0);
 		} else {
 			if (lock_fb_info(hdmi->info)) {
-				hdmi_display_on(hdmi, hdmi->info);
+				sh_hdmi_display_on(hdmi, hdmi->info);
 				unlock_fb_info(hdmi->info);
 			}
 		}
@@ -928,7 +935,7 @@ static void edid_work_fn(struct work_struct *work)
 out:
 	mutex_unlock(&hdmi->mutex);
 
-	pr_debug("%s(%p): end\n", __func__, pdata->lcd_dev);
+	dev_dbg(hdmi->dev, "%s(%p): end\n", __func__, pdata->lcd_dev);
 }
 
 static int sh_hdmi_notify(struct notifier_block *nb,
@@ -952,18 +959,19 @@ static int sh_hdmi_notify(struct notifier_block *nb,
 
 	switch(action) {
 	case FB_EVENT_FB_REGISTERED:
-		/* Unneeded, activation taken care by hdmi_display_on() */
+		/* Unneeded, activation taken care by sh_hdmi_display_on() */
 		break;
 	case FB_EVENT_FB_UNREGISTERED:
 		/*
 		 * We are called from unregister_framebuffer() with the
 		 * info->lock held. This is bad for us, because we can race with
 		 * the scheduled work, which has to call fb_set_suspend(), which
-		 * takes info->lock internally, so, edid_work_fn() cannot take
-		 * and hold info->lock for the whole function duration. Using an
-		 * additional lock creates a classical AB-BA lock up. Therefore,
-		 * we have to release the info->lock temporarily, synchronise
-		 * with the work queue and re-acquire the info->lock.
+		 * takes info->lock internally, so, sh_hdmi_edid_work_fn()
+		 * cannot take and hold info->lock for the whole function
+		 * duration. Using an additional lock creates a classical AB-BA
+		 * lock up. Therefore, we have to release the info->lock
+		 * temporarily, synchronise with the work queue and re-acquire
+		 * the info->lock.
 		 */
 		unlock_fb_info(hdmi->info);
 		mutex_lock(&hdmi->mutex);
@@ -1019,7 +1027,7 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		goto erate;
 	}
 
-	pr_debug("HDMI set frequency %lu\n", rate);
+	dev_dbg(hdmi->dev, "HDMI set frequency %lu\n", rate);
 
 	ret = clk_enable(hdmi->hdmi_clk);
 	if (ret < 0) {
@@ -1054,10 +1062,10 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 	board_cfg = &pdata->lcd_chan->board_cfg;
 	board_cfg->owner = THIS_MODULE;
 	board_cfg->board_data = hdmi;
-	board_cfg->display_on = hdmi_display_on;
-	board_cfg->display_off = hdmi_display_off;
+	board_cfg->display_on = sh_hdmi_display_on;
+	board_cfg->display_off = sh_hdmi_display_off;
 
-	INIT_DELAYED_WORK(&hdmi->edid_work, edid_work_fn);
+	INIT_DELAYED_WORK(&hdmi->edid_work, sh_hdmi_edid_work_fn);
 
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_resume(&pdev->dev);
-- 
1.7.1

