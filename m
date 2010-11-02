From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 02 Nov 2010 11:27:16 +0000
Subject: [PATCH 1/4 v2] fbdev: sh_mobile_hdmi: add support for more precise
Message-Id: <Pine.LNX.4.64.1011021209580.4552@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The HDMI clock has to be reconfigured for different video modes. However, the
precision of the supplying SoC clock on SH-Mobile systems is often
insufficient. This patch allows to additionally reconfigure the parent clock
to achieve the optimal HDMI clock frequency, in case this is supported by the
platform.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2:

1. use clk_get_parent() instead of platform callbacks
2. don't access hardware before switching pm clock on

 drivers/video/sh_mobile_hdmi.c |  112 ++++++++++++++++++++++++----------------
 include/video/sh_mobile_hdmi.h |    3 +
 2 files changed, 71 insertions(+), 44 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 55b3077..ff7f785 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -685,11 +685,21 @@ static void sh_hdmi_configure(struct sh_hdmi *hdmi)
 }
 
 static unsigned long sh_hdmi_rate_error(struct sh_hdmi *hdmi,
-					const struct fb_videomode *mode)
+		const struct fb_videomode *mode,
+		unsigned long *hdmi_rate, unsigned long *parent_rate)
 {
-	long target = PICOS2KHZ(mode->pixclock) * 1000,
-		rate = clk_round_rate(hdmi->hdmi_clk, target);
-	unsigned long rate_error = rate > 0 ? abs(rate - target) : ULONG_MAX;
+	unsigned long target = PICOS2KHZ(mode->pixclock) * 1000, rate_error;
+	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
+
+	*hdmi_rate = clk_round_rate(hdmi->hdmi_clk, target);
+	if ((long)*hdmi_rate < 0)
+		*hdmi_rate = clk_get_rate(hdmi->hdmi_clk);
+
+	rate_error = (long)*hdmi_rate > 0 ? abs(*hdmi_rate - target) : ULONG_MAX;
+	if (rate_error && pdata->clk_optimize_parent)
+		rate_error = pdata->clk_optimize_parent(target, hdmi_rate, parent_rate);
+	else if (clk_get_parent(hdmi->hdmi_clk))
+		*parent_rate = clk_get_rate(clk_get_parent(hdmi->hdmi_clk));
 
 	dev_dbg(hdmi->dev, "%u-%u-%u-%u x %u-%u-%u-%u\n",
 		mode->left_margin, mode->xres,
@@ -697,14 +707,15 @@ static unsigned long sh_hdmi_rate_error(struct sh_hdmi *hdmi,
 		mode->upper_margin, mode->yres,
 		mode->lower_margin, mode->vsync_len);
 
-	dev_dbg(hdmi->dev, "\t@%lu(+/-%lu)Hz, e=%lu / 1000, r=%uHz\n", target,
-		 rate_error, rate_error ? 10000 / (10 * target / rate_error) : 0,
-		 mode->refresh);
+	dev_dbg(hdmi->dev, "\t@%lu(+/-%lu)Hz, e=%lu / 1000, r=%uHz, p=%luHz\n", target,
+		rate_error, rate_error ? 10000 / (10 * target / rate_error) : 0,
+		mode->refresh, *parent_rate);
 
 	return rate_error;
 }
 
-static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
+static int sh_hdmi_read_edid(struct sh_hdmi *hdmi, unsigned long *hdmi_rate,
+			     unsigned long *parent_rate)
 {
 	struct fb_var_screeninfo tmpvar;
 	struct fb_var_screeninfo *var = &tmpvar;
@@ -754,11 +765,14 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 	for (i = 0, mode = hdmi->monspec.modedb;
 	     f_width && f_height && i < hdmi->monspec.modedb_len && !exact_match;
 	     i++, mode++) {
-		unsigned long rate_error = sh_hdmi_rate_error(hdmi, mode);
+		unsigned long rate_error;
 
 		/* No interest in unmatching modes */
 		if (f_width != mode->xres || f_height != mode->yres)
 			continue;
+
+		rate_error = sh_hdmi_rate_error(hdmi, mode, hdmi_rate, parent_rate);
+
 		if (f_refresh = mode->refresh || (!f_refresh && !rate_error))
 			/*
 			 * Exact match if either the refresh rate matches or it
@@ -802,7 +816,7 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 
 		if (modelist) {
 			found = &modelist->mode;
-			found_rate_error = sh_hdmi_rate_error(hdmi, found);
+			found_rate_error = sh_hdmi_rate_error(hdmi, found, hdmi_rate, parent_rate);
 		}
 	}
 
@@ -810,10 +824,6 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 	if (!found)
 		return -ENXIO;
 
-	dev_info(hdmi->dev, "Using %s mode %ux%u@%uHz (%luHz), clock error %luHz\n",
-		 modelist ? "default" : "EDID", found->xres, found->yres,
-		 found->refresh, PICOS2KHZ(found->pixclock) * 1000, found_rate_error);
-
 	if ((found->xres = 720 && found->yres = 480) ||
 	    (found->xres = 1280 && found->yres = 720) ||
 	    (found->xres = 1920 && found->yres = 1080))
@@ -821,6 +831,11 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 	else
 		hdmi->preprogrammed_mode = false;
 
+	dev_dbg(hdmi->dev, "Using %s %s mode %ux%u@%uHz (%luHz), clock error %luHz\n",
+		modelist ? "default" : "EDID", hdmi->preprogrammed_mode ? "VIC" : "external",
+		found->xres, found->yres, found->refresh,
+		PICOS2KHZ(found->pixclock) * 1000, found_rate_error);
+
 	fb_videomode_to_var(&hdmi->var, found);
 	sh_hdmi_external_video_param(hdmi);
 
@@ -972,39 +987,38 @@ static bool sh_hdmi_must_reconfigure(struct sh_hdmi *hdmi)
 
 /**
  * sh_hdmi_clk_configure() - set HDMI clock frequency and enable the clock
- * @hdmi:	driver context
- * @pixclock:	pixel clock period in picoseconds
- * return:	configured positive rate if successful
- *		0 if couldn't set the rate, but managed to enable the clock
- *		negative error, if couldn't enable the clock
+ * @hdmi:		driver context
+ * @hdmi_rate:		HDMI clock frequency in Hz
+ * @parent_rate:	if != 0 - set parent clock rate for optimal precision
+ * return:		configured positive rate if successful
+ *			0 if couldn't set the rate, but managed to enable the
+ *			clock, negative error, if couldn't enable the clock
  */
-static long sh_hdmi_clk_configure(struct sh_hdmi *hdmi, unsigned long pixclock)
+static long sh_hdmi_clk_configure(struct sh_hdmi *hdmi, unsigned long hdmi_rate,
+				  unsigned long parent_rate)
 {
-	long rate;
+	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
 	int ret;
 
-	rate = PICOS2KHZ(pixclock) * 1000;
-	rate = clk_round_rate(hdmi->hdmi_clk, rate);
-	if (rate > 0) {
-		ret = clk_set_rate(hdmi->hdmi_clk, rate);
+	if (parent_rate && clk_get_parent(hdmi->hdmi_clk)) {
+		ret = clk_set_rate(clk_get_parent(hdmi->hdmi_clk), parent_rate);
 		if (ret < 0) {
-			dev_warn(hdmi->dev, "Cannot set rate %ld: %d\n", rate, ret);
-			rate = 0;
+			dev_warn(hdmi->dev, "Cannot set parent rate %ld: %d\n", parent_rate, ret);
+			hdmi_rate = clk_round_rate(hdmi->hdmi_clk, hdmi_rate);
 		} else {
-			dev_dbg(hdmi->dev, "HDMI set frequency %lu\n", rate);
+			dev_dbg(hdmi->dev, "HDMI set parent frequency %lu\n", parent_rate);
 		}
-	} else {
-		rate = 0;
-		dev_warn(hdmi->dev, "Cannot get suitable rate: %ld\n", rate);
 	}
 
-	ret = clk_enable(hdmi->hdmi_clk);
+	ret = clk_set_rate(hdmi->hdmi_clk, hdmi_rate);
 	if (ret < 0) {
-		dev_err(hdmi->dev, "Cannot enable clock: %d\n", ret);
-		return ret;
+		dev_warn(hdmi->dev, "Cannot set rate %ld: %d\n", hdmi_rate, ret);
+		hdmi_rate = 0;
+	} else {
+		dev_dbg(hdmi->dev, "HDMI set frequency %lu\n", hdmi_rate);
 	}
 
-	return rate;
+	return hdmi_rate;
 }
 
 /* Hotplug interrupt occurred, read EDID */
@@ -1024,16 +1038,17 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 	mutex_lock(&hdmi->mutex);
 
 	if (hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE) {
+		unsigned long parent_rate = 0, hdmi_rate;
+
 		/* A device has been plugged in */
 		pm_runtime_get_sync(hdmi->dev);
 
-		ret = sh_hdmi_read_edid(hdmi);
+		ret = sh_hdmi_read_edid(hdmi, &hdmi_rate, &parent_rate);
 		if (ret < 0)
 			goto out;
 
 		/* Reconfigure the clock */
-		clk_disable(hdmi->hdmi_clk);
-		ret = sh_hdmi_clk_configure(hdmi, hdmi->var.pixclock);
+		ret = sh_hdmi_clk_configure(hdmi, hdmi_rate, parent_rate);
 		if (ret < 0)
 			goto out;
 
@@ -1163,13 +1178,22 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		goto egetclk;
 	}
 
-	/* Some arbitrary relaxed pixclock just to get things started */
-	rate = sh_hdmi_clk_configure(hdmi, 37037);
+	/* An arbitrary relaxed pixclock just to get things started: from standard 480p */
+	rate = clk_round_rate(hdmi->hdmi_clk, PICOS2KHZ(37037));
+	if (rate > 0)
+		rate = sh_hdmi_clk_configure(hdmi, rate, 0);
+
 	if (rate < 0) {
 		ret = rate;
 		goto erate;
 	}
 
+	ret = clk_enable(hdmi->hdmi_clk);
+	if (ret < 0) {
+		dev_err(hdmi->dev, "Cannot enable clock: %d\n", ret);
+		goto erate;
+	}
+
 	dev_dbg(&pdev->dev, "Enabled HDMI clock at %luHz\n", rate);
 
 	if (!request_mem_region(res->start, resource_size(res), dev_name(&pdev->dev))) {
@@ -1187,10 +1211,6 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hdmi);
 
-	/* Product and revision IDs are 0 in sh-mobile version */
-	dev_info(&pdev->dev, "Detected HDMI controller 0x%x:0x%x\n",
-		 hdmi_read(hdmi, HDMI_PRODUCT_ID), hdmi_read(hdmi, HDMI_REVISION_ID));
-
 	/* Set up LCDC callbacks */
 	board_cfg = &pdata->lcd_chan->board_cfg;
 	board_cfg->owner = THIS_MODULE;
@@ -1203,6 +1223,10 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_resume(&pdev->dev);
 
+	/* Product and revision IDs are 0 in sh-mobile version */
+	dev_info(&pdev->dev, "Detected HDMI controller 0x%x:0x%x\n",
+		 hdmi_read(hdmi, HDMI_PRODUCT_ID), hdmi_read(hdmi, HDMI_REVISION_ID));
+
 	ret = request_irq(irq, sh_hdmi_hotplug, 0,
 			  dev_name(&pdev->dev), hdmi);
 	if (ret < 0) {
diff --git a/include/video/sh_mobile_hdmi.h b/include/video/sh_mobile_hdmi.h
index 1e1aa54..b569329 100644
--- a/include/video/sh_mobile_hdmi.h
+++ b/include/video/sh_mobile_hdmi.h
@@ -13,6 +13,7 @@
 
 struct sh_mobile_lcdc_chan_cfg;
 struct device;
+struct clk;
 
 /*
  * flags format
@@ -33,6 +34,8 @@ struct sh_mobile_hdmi_info {
 	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
 	struct device			*lcd_dev;
 	unsigned int			 flags;
+	long (*clk_optimize_parent)(unsigned long target, unsigned long *best_freq,
+				    unsigned long *parent_freq);
 };
 
 #endif
-- 
1.7.2.3

