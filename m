From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 27 Oct 2010 16:24:10 +0000
Subject: [PATCH 1/3] fbdev: sh_mobile_hdmi: add support for more precise HDMI
Message-Id: <Pine.LNX.4.64.1010271819370.11687@axis700.grange>
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
 drivers/video/sh_mobile_hdmi.c |  102 ++++++++++++++++++++++++---------------
 include/video/sh_mobile_hdmi.h |    5 ++
 2 files changed, 68 insertions(+), 39 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index f0ff284..7ece656 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -612,11 +612,21 @@ static void sh_hdmi_configure(struct sh_hdmi *hdmi)
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
+	else if (pdata->clk_get_rate_parent)
+		*parent_rate = pdata->clk_get_rate_parent(hdmi->hdmi_clk);
 
 	dev_dbg(hdmi->dev, "%u-%u-%u-%u x %u-%u-%u-%u\n",
 		mode->left_margin, mode->xres,
@@ -624,14 +634,15 @@ static unsigned long sh_hdmi_rate_error(struct sh_hdmi *hdmi,
 		mode->upper_margin, mode->yres,
 		mode->lower_margin, mode->vsync_len);
 
-	dev_dbg(hdmi->dev, "\t@%lu(+/-%lu)Hz, e=%lu / 1000, r=%uHz\n", target,
+	dev_dbg(hdmi->dev, "\t@%lu(+/-%lu)Hz, e=%lu / 1000, r=%uHz, p=%luHz\n", target,
 		 rate_error, rate_error ? 10000 / (10 * target / rate_error) : 0,
-		 mode->refresh);
+		 mode->refresh, *parent_rate);
 
 	return rate_error;
 }
 
-static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
+static int sh_hdmi_read_edid(struct sh_hdmi *hdmi, unsigned long *hdmi_rate,
+			     unsigned long *parent_rate)
 {
 	struct fb_var_screeninfo tmpvar;
 	struct fb_var_screeninfo *var = &tmpvar;
@@ -681,11 +692,14 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
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
@@ -729,7 +743,7 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 
 		if (modelist) {
 			found = &modelist->mode;
-			found_rate_error = sh_hdmi_rate_error(hdmi, found);
+			found_rate_error = sh_hdmi_rate_error(hdmi, found, hdmi_rate, parent_rate);
 		}
 	}
 
@@ -737,10 +751,6 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 	if (!found)
 		return -ENXIO;
 
-	dev_info(hdmi->dev, "Using %s mode %ux%u@%uHz (%luHz), clock error %luHz\n",
-		 modelist ? "default" : "EDID", found->xres, found->yres,
-		 found->refresh, PICOS2KHZ(found->pixclock) * 1000, found_rate_error);
-
 	if ((found->xres = 720 && found->yres = 480) ||
 	    (found->xres = 1280 && found->yres = 720) ||
 	    (found->xres = 1920 && found->yres = 1080))
@@ -748,6 +758,11 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 	else
 		hdmi->preprogrammed_mode = false;
 
+	dev_dbg(hdmi->dev, "Using %s %s mode %ux%u@%uHz (%luHz), clock error %luHz\n",
+		modelist ? "default" : "EDID", hdmi->preprogrammed_mode ? "VIC" : "external",
+		found->xres, found->yres, found->refresh,
+		PICOS2KHZ(found->pixclock) * 1000, found_rate_error);
+
 	fb_videomode_to_var(&hdmi->var, found);
 	sh_hdmi_external_video_param(hdmi);
 
@@ -899,39 +914,38 @@ static bool sh_hdmi_must_reconfigure(struct sh_hdmi *hdmi)
 
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
+ *			clock negative error, if couldn't enable the clock
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
+	if (parent_rate && pdata->clk_set_rate_parent) {
+		ret = pdata->clk_set_rate_parent(hdmi->hdmi_clk, parent_rate);
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
@@ -951,16 +965,17 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
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
 
@@ -1089,13 +1104,22 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
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
diff --git a/include/video/sh_mobile_hdmi.h b/include/video/sh_mobile_hdmi.h
index 577cf18..aff2d98 100644
--- a/include/video/sh_mobile_hdmi.h
+++ b/include/video/sh_mobile_hdmi.h
@@ -13,10 +13,15 @@
 
 struct sh_mobile_lcdc_chan_cfg;
 struct device;
+struct clk;
 
 struct sh_mobile_hdmi_info {
 	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
 	struct device			*lcd_dev;
+	long (*clk_optimize_parent)(unsigned long target, unsigned long *best_freq,
+				    unsigned long *parent_freq);
+	int (*clk_set_rate_parent)(struct clk *clk, unsigned long rate);
+	unsigned long (*clk_get_rate_parent)(struct clk *clk);
 };
 
 #endif
-- 
1.7.1

