From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:39 +0000
Subject: [PATCH 14/15] fbdev: sh_mobile_hdmi: support hot-plugging of different
Message-Id: <Pine.LNX.4.64.1009030916560.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

With this patch hot-plugging of an HDMI or a DVI monitor can select a different
video mode and reconfigure the LCDC and HDMI controllers accordingly. Due to a
lack of a standard API to inform framebuffer users of a changed video mode, the
framebuffer configuration is preserved regardless of a specific mode, selected
for the monitor. As described in a previous patch, this leads to smaller
framebuffers being displayed on larger monitors or a part of a larger
framebuffer being displayed on a smaller resolution monitor.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c   |  203 ++++++++++++++++++++++++++++++-------
 drivers/video/sh_mobile_lcdcfb.c |   31 +-----
 2 files changed, 170 insertions(+), 64 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index e1d70e2..a6143ef 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -214,6 +214,7 @@ struct sh_hdmi {
 	struct mutex mutex;		/* Protect the info pointer */
 	struct delayed_work edid_work;
 	struct fb_var_screeninfo var;
+	struct fb_monspecs monspec;
 };
 
 static void hdmi_write(struct sh_hdmi *hdmi, u8 data, u8 reg)
@@ -716,11 +717,12 @@ static void sh_hdmi_configure(struct sh_hdmi *hdmi)
 	hdmi_write(hdmi, 0x40, HDMI_SYSTEM_CTRL);
 }
 
-static void sh_hdmi_read_edid(struct sh_hdmi *hdmi)
+static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 {
 	struct fb_var_screeninfo tmpvar;
 	/* TODO: When we are ready to use EDID, use this to fill &hdmi->var */
 	struct fb_var_screeninfo *var = &tmpvar;
+	const struct fb_videomode *mode, *found = NULL;
 	int i;
 	u8 edid[128];
 
@@ -740,20 +742,84 @@ static void sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 #ifdef DEBUG
 	printk(KERN_CONT "\n");
 #endif
-	fb_parse_edid(edid, var);
-	dev_dbg(hdmi->dev, "%u-%u-%u-%u x %u-%u-%u-%u @ %lu kHz monitor detected\n",
-		var->left_margin, var->xres, var->right_margin, var->hsync_len,
-		var->upper_margin, var->yres, var->lower_margin, var->vsync_len,
-		PICOS2KHZ(var->pixclock));
-
-	if ((hdmi->var.xres = 720 && hdmi->var.yres = 480) ||
-	    (hdmi->var.xres = 1280 && hdmi->var.yres = 720) ||
-	    (hdmi->var.xres = 1920 && hdmi->var.yres = 1080))
+
+	fb_edid_to_monspecs(edid, &hdmi->monspec);
+
+	/* First look for an exact match */
+	for (i = 0, mode = hdmi->monspec.modedb; i < hdmi->monspec.modedb_len;
+	     i++, mode++) {
+		dev_dbg(hdmi->dev, "%u-%u-%u-%u x %u-%u-%u-%u @ %lu kHz monitor detected\n",
+			mode->left_margin, mode->xres,
+			mode->right_margin, mode->hsync_len,
+			mode->upper_margin, mode->yres,
+			mode->lower_margin, mode->vsync_len,
+			PICOS2KHZ(mode->pixclock));
+		if (!found && hdmi->info) {
+			fb_videomode_to_var(var, mode);
+			found = fb_match_mode(var, &hdmi->info->modelist);
+			/*
+			 * If an exact match found, we're good to bail out, but
+			 * continue to print out all modes
+			 */
+		}
+	}
+
+	/*
+	 * The monitor might also work with a mode, that is smaller, than one of
+	 * its modes, use the first (default) one for this
+	 */
+	if (!found && hdmi->info && hdmi->monspec.modedb_len) {
+		struct fb_modelist *modelist;
+		unsigned int min_err = UINT_MAX, err;
+		const struct fb_videomode *mon_mode = hdmi->monspec.modedb;
+
+		list_for_each_entry(modelist, &hdmi->info->modelist, list) {
+			mode = &modelist->mode;
+			dev_dbg(hdmi->dev, "matching %ux%u to %ux%u\n", mode->xres, mode->yres,
+				 mon_mode->xres, mon_mode->yres);
+			if (mode->xres <= mon_mode->xres && mode->yres <= mon_mode->yres) {
+				err = mon_mode->xres - mode->xres + mon_mode->yres - mode->yres;
+				if (!err) {
+					found = mode;
+					break;
+				}
+				if (err < min_err) {
+					found = mode;
+					min_err = err;
+				}
+			}
+		}
+	}
+
+	/* Nothing suitable specified by the platform: use monitor's first mode */
+	if (!found && hdmi->monspec.modedb_len)
+		found = hdmi->monspec.modedb;
+
+	/* No valid timing info in EDID - last resort: use platform default mode */
+	if (!found && hdmi->info) {
+		struct fb_modelist *modelist = list_entry(hdmi->info->modelist.next,
+							  struct fb_modelist, list);
+		found = &modelist->mode;
+	}
+
+	/* No cookie today */
+	if (!found)
+		return -ENXIO;
+
+	dev_dbg(hdmi->dev, "best \"%s\" %ux%u@%ups\n", found->name,
+		found->xres, found->yres, found->pixclock);
+
+	if ((found->xres = 720 && found->yres = 480) ||
+	    (found->xres = 1280 && found->yres = 720) ||
+	    (found->xres = 1920 && found->yres = 1080))
 		hdmi->preprogrammed_mode = true;
 	else
 		hdmi->preprogrammed_mode = false;
 
+	fb_videomode_to_var(&hdmi->var, found);
 	sh_hdmi_external_video_param(hdmi);
+
+	return 0;
 }
 
 static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
@@ -876,12 +942,73 @@ static void sh_hdmi_display_off(void *arg)
 	hdmi_write(hdmi, 0x10, HDMI_SYSTEM_CTRL);
 }
 
+static bool sh_hdmi_must_reconfigure(struct sh_hdmi *hdmi)
+{
+	struct fb_info *info = hdmi->info;
+	struct sh_mobile_lcdc_chan *ch = info->par;
+	struct fb_var_screeninfo *new_var = &hdmi->var, *old_var = &ch->display_var;
+	struct fb_videomode mode1, mode2;
+
+	fb_var_to_videomode(&mode1, old_var);
+	fb_var_to_videomode(&mode2, new_var);
+
+	dev_dbg(info->dev, "Old %ux%u, new %ux%u\n",
+		mode1.xres, mode1.yres, mode2.xres, mode2.yres);
+
+	if (fb_mode_is_equal(&mode1, &mode2))
+		return false;
+
+	dev_dbg(info->dev, "Switching %u -> %u lines\n",
+		mode1.yres, mode2.yres);
+	*old_var = *new_var;
+
+	return true;
+}
+
+/**
+ * sh_hdmi_clk_configure() - set HDMI clock frequency and enable the clock
+ * @hdmi:	driver context
+ * @pixclock:	pixel clock period in picoseconds
+ * return:	configured positive rate if successful
+ *		0 if couldn't set the rate, but managed to enable the clock
+ *		negative error, if couldn't enable the clock
+ */
+static long sh_hdmi_clk_configure(struct sh_hdmi *hdmi, unsigned long pixclock)
+{
+	long rate;
+	int ret;
+
+	rate = PICOS2KHZ(pixclock) * 1000;
+	rate = clk_round_rate(hdmi->hdmi_clk, rate);
+	if (rate > 0) {
+		ret = clk_set_rate(hdmi->hdmi_clk, rate);
+		if (ret < 0) {
+			dev_warn(hdmi->dev, "Cannot set rate %ld: %d\n", rate, ret);
+			rate = 0;
+		} else {
+			dev_dbg(hdmi->dev, "HDMI set frequency %lu\n", rate);
+		}
+	} else {
+		rate = 0;
+		dev_warn(hdmi->dev, "Cannot get suitable rate: %ld\n", rate);
+	}
+
+	ret = clk_enable(hdmi->hdmi_clk);
+	if (ret < 0) {
+		dev_err(hdmi->dev, "Cannot enable clock: %d\n", ret);
+		return ret;
+	}
+
+	return rate;
+}
+
 /* Hotplug interrupt occurred, read EDID */
 static void sh_hdmi_edid_work_fn(struct work_struct *work)
 {
 	struct sh_hdmi *hdmi = container_of(work, struct sh_hdmi, edid_work.work);
 	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
 	struct sh_mobile_lcdc_chan *ch;
+	int ret;
 
 	dev_dbg(hdmi->dev, "%s(%p): begin, hotplug status %d\n", __func__,
 		pdata->lcd_dev, hdmi->hp_state);
@@ -892,9 +1019,19 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 	mutex_lock(&hdmi->mutex);
 
 	if (hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE) {
-		pm_runtime_get_sync(hdmi->dev);
 		/* A device has been plugged in */
-		sh_hdmi_read_edid(hdmi);
+		pm_runtime_get_sync(hdmi->dev);
+
+		ret = sh_hdmi_read_edid(hdmi);
+		if (ret < 0)
+			goto out;
+
+		/* Reconfigure the clock */
+		clk_disable(hdmi->hdmi_clk);
+		ret = sh_hdmi_clk_configure(hdmi, hdmi->var.pixclock);
+		if (ret < 0)
+			goto out;
+
 		msleep(10);
 		sh_hdmi_configure(hdmi);
 		/* Switched to another (d) power-save mode */
@@ -908,18 +1045,24 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 		acquire_console_sem();
 
 		/* HDMI plug in */
-		ch->display_var = hdmi->var;
-		if (hdmi->info->state != FBINFO_STATE_RUNNING) {
-			fb_set_suspend(hdmi->info, 0);
-		} else {
+		if (!sh_hdmi_must_reconfigure(hdmi) &&
+		    hdmi->info->state = FBINFO_STATE_RUNNING) {
+			/*
+			 * First activation with the default monitor - just turn
+			 * on, if we run a resume here, the logo disappears
+			 */
 			if (lock_fb_info(hdmi->info)) {
 				sh_hdmi_display_on(hdmi, hdmi->info);
 				unlock_fb_info(hdmi->info);
 			}
+		} else {
+			/* New monitor or have to wake up */
+			fb_set_suspend(hdmi->info, 0);
 		}
 
 		release_console_sem();
 	} else {
+		ret = 0;
 		if (!hdmi->info)
 			goto out;
 
@@ -930,9 +1073,12 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 
 		release_console_sem();
 		pm_runtime_put(hdmi->dev);
+		fb_destroy_modedb(hdmi->monspec.modedb);
 	}
 
 out:
+	if (ret < 0)
+		hdmi->hp_state = HDMI_HOTPLUG_DISCONNECTED;
 	mutex_unlock(&hdmi->mutex);
 
 	dev_dbg(hdmi->dev, "%s(%p): end\n", __func__, pdata->lcd_dev);
@@ -1011,31 +1157,13 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		goto egetclk;
 	}
 
-	/* TODO: reconfigure the clock on monitor plug in */
-	rate = PICOS2KHZ(pdata->lcd_chan->lcd_cfg[0].pixclock) * 1000;
-
-	rate = clk_round_rate(hdmi->hdmi_clk, rate);
+	rate = sh_hdmi_clk_configure(hdmi, pdata->lcd_chan->lcd_cfg[0].pixclock);
 	if (rate < 0) {
 		ret = rate;
-		dev_err(&pdev->dev, "Cannot get suitable rate: %ld\n", rate);
-		goto erate;
-	}
-
-	ret = clk_set_rate(hdmi->hdmi_clk, rate);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Cannot set rate %ld: %d\n", rate, ret);
 		goto erate;
 	}
 
-	dev_dbg(hdmi->dev, "HDMI set frequency %lu\n", rate);
-
-	ret = clk_enable(hdmi->hdmi_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Cannot enable clock: %d\n", ret);
-		goto eclkenable;
-	}
-
-	dev_info(&pdev->dev, "Enabled HDMI clock at %luHz\n", rate);
+	dev_dbg(&pdev->dev, "Enabled HDMI clock at %luHz\n", rate);
 
 	if (!request_mem_region(res->start, resource_size(res), dev_name(&pdev->dev))) {
 		dev_err(&pdev->dev, "HDMI register region already claimed\n");
@@ -1052,11 +1180,9 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hdmi);
 
-#if 1
 	/* Product and revision IDs are 0 in sh-mobile version */
 	dev_info(&pdev->dev, "Detected HDMI controller 0x%x:0x%x\n",
 		 hdmi_read(hdmi, HDMI_PRODUCT_ID), hdmi_read(hdmi, HDMI_REVISION_ID));
-#endif
 
 	/* Set up LCDC callbacks */
 	board_cfg = &pdata->lcd_chan->board_cfg;
@@ -1086,7 +1212,6 @@ emap:
 	release_mem_region(res->start, resource_size(res));
 ereqreg:
 	clk_disable(hdmi->hdmi_clk);
-eclkenable:
 erate:
 	clk_put(hdmi->hdmi_clk);
 egetclk:
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 946a810..b4a8786 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -944,6 +944,7 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
 	struct fb_var_screeninfo *var;
+	int ret;
 
 	if (&ch->lcdc->notifier != nb)
 		return NOTIFY_DONE;
@@ -958,6 +959,7 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 			module_put(board_cfg->owner);
 		}
 		pm_runtime_put(info->device);
+		sh_mobile_lcdc_stop(ch->lcdc);
 		break;
 	case FB_EVENT_RESUME:
 		var = &info->var;
@@ -968,31 +970,9 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 			module_put(board_cfg->owner);
 		}
 
-		/* Check if the new display is not in our modelist */
-		if (ch->info->modelist.next &&
-		    !fb_match_mode(var, &ch->info->modelist)) {
-			struct fb_videomode mode;
-			int ret;
-
-			/* Can we handle this display? */
-			if (var->xres > ch->cfg.lcd_cfg[0].xres ||
-			    var->yres > ch->cfg.lcd_cfg[0].yres)
-				/*
-				 * LCDC resume failed, no need to continue with
-				 * the notifier chain
-				 */
-				return notifier_from_errno(-ENOMEM);
-
-			/* Add to the modelist */
-			fb_var_to_videomode(&mode, var);
-			ret = fb_add_videomode(&mode, &ch->info->modelist);
-			if (ret < 0)
-				return notifier_from_errno(ret);
-		}
-
-		pm_runtime_get_sync(info->device);
-
-		sh_mobile_lcdc_geometry(ch);
+		ret = sh_mobile_lcdc_start(ch->lcdc);
+		if (!ret)
+			pm_runtime_get_sync(info->device);
 	}
 
 	return NOTIFY_OK;
@@ -1181,6 +1161,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			}
 		}
 
+		fb_videomode_to_modelist(ch->cfg.lcd_cfg, ch->cfg.num_cfg, &info->modelist);
 		error = register_framebuffer(info);
 		if (error < 0)
 			goto err1;
-- 
1.7.1

