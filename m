From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Oct 2010 07:54:04 +0000
Subject: [PATCH 4/4] fbdev: sh_mobile_hdmi: add support for the "video="
Message-Id: <Pine.LNX.4.64.1010150952030.3945@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add support for specifying video modes on the kernel command line. Mode
selection priorities are also changed such, that only exact matches of
specified modes with monitor modes from EDID are accepted, at least in width
and height. If none found - fall back to framebuffer default setting, if
available.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |  138 +++++++++++++++++++++++++--------------
 1 files changed, 88 insertions(+), 50 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 3b2e893..b9efa06 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -684,14 +684,39 @@ static void sh_hdmi_configure(struct sh_hdmi *hdmi)
 	hdmi_write(hdmi, 0x40, HDMI_SYSTEM_CTRL);
 }
 
+static unsigned long sh_hdmi_rate_error(struct sh_hdmi *hdmi,
+					const struct fb_videomode *mode)
+{
+	long target = PICOS2KHZ(mode->pixclock) * 1000,
+		rate = clk_round_rate(hdmi->hdmi_clk, target);
+	unsigned long rate_error = rate > 0 ? abs(rate - target) : ULONG_MAX;
+
+	dev_dbg(hdmi->dev, "%u-%u-%u-%u x %u-%u-%u-%u\n",
+		mode->left_margin, mode->xres,
+		mode->right_margin, mode->hsync_len,
+		mode->upper_margin, mode->yres,
+		mode->lower_margin, mode->vsync_len);
+
+	dev_dbg(hdmi->dev, "\t@%lu(+/-%lu)Hz, e=%lu / 1000, r=%uHz\n", target,
+		 rate_error, rate_error ? 10000 / (10 * target / rate_error) : 0,
+		 mode->refresh);
+
+	return rate_error;
+}
+
 static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 {
 	struct fb_var_screeninfo tmpvar;
-	/* TODO: When we are ready to use EDID, use this to fill &hdmi->var */
 	struct fb_var_screeninfo *var = &tmpvar;
 	const struct fb_videomode *mode, *found = NULL;
-	int i;
+	struct fb_info *info = hdmi->info;
+	struct fb_modelist *modelist = NULL;
+	unsigned int f_width = 0, f_height = 0, f_refresh = 0;
+	unsigned long found_rate_error = ULONG_MAX; /* silly compiler... */
+	bool exact_match = false;
 	u8 edid[128];
+	char *forced;
+	int i;
 
 	/* Read EDID */
 	dev_dbg(hdmi->dev, "Read back EDID code:");
@@ -712,69 +737,82 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 
 	fb_edid_to_monspecs(edid, &hdmi->monspec);
 
-	/* First look for an exact match */
-	for (i = 0, mode = hdmi->monspec.modedb; i < hdmi->monspec.modedb_len;
+	fb_get_options("sh_mobile_lcdc", &forced);
+	if (forced && *forced) {
+		/* Only primitive parsing so far */
+		i = sscanf(forced, "%ux%u@%u",
+			   &f_width, &f_height, &f_refresh);
+		if (i < 2) {
+			f_width = 0;
+			f_height = 0;
+		}
+		dev_dbg(hdmi->dev, "Forced mode %ux%u@%uHz\n",
+			f_width, f_height, f_refresh);
+	}
+
+	/* Walk monitor modes to find the best or the exact match */
+	for (i = 0, mode = hdmi->monspec.modedb;
+	     f_width && f_height && i < hdmi->monspec.modedb_len && !exact_match;
 	     i++, mode++) {
-		dev_dbg(hdmi->dev, "%u-%u-%u-%u x %u-%u-%u-%u @ %lu kHz monitor detected\n",
-			mode->left_margin, mode->xres,
-			mode->right_margin, mode->hsync_len,
-			mode->upper_margin, mode->yres,
-			mode->lower_margin, mode->vsync_len,
-			PICOS2KHZ(mode->pixclock));
-		if (!found && hdmi->info) {
-			fb_videomode_to_var(var, mode);
-			found = fb_match_mode(var, &hdmi->info->modelist);
+		unsigned long rate_error = sh_hdmi_rate_error(hdmi, mode);
+
+		/* No interest in unmatching modes */
+		if (f_width != mode->xres || f_height != mode->yres)
+			continue;
+		if (f_refresh = mode->refresh || (!f_refresh && !rate_error))
+			/*
+			 * Exact match if either the refresh rate matches or it
+			 * hasn't been specified and we've found a mode, for
+			 * which we can configure the clock precisely
+			 */
+			exact_match = true;
+		else if (found && found_rate_error <= rate_error)
 			/*
-			 * If an exact match found, we're good to bail out, but
-			 * continue to print out all modes
+			 * We otherwise search for the closest matching clock
+			 * rate - either if no refresh rate has been specified
+			 * or we cannot find an exactly matching one
 			 */
+			continue;
+
+		/* Check if supported: sufficient fb memory, supported clock-rate */
+		fb_videomode_to_var(var, mode);
+
+		if (info && info->fbops->fb_check_var &&
+		    info->fbops->fb_check_var(var, info)) {
+			exact_match = false;
+			continue;
 		}
+
+		found = mode;
+		found_rate_error = rate_error;
 	}
 
 	/*
-	 * The monitor might also work with a mode, that is smaller, than one of
-	 * its modes, use the first (default) one for this
+	 * TODO 1: if no ->info is present, postpone running the config until
+	 * after ->info first gets registered.
+	 * TODO 2: consider registering the HDMI platform device from the LCDC
+	 * driver, and passing ->info with HDMI platform data.
 	 */
-	if (!found && hdmi->info && hdmi->monspec.modedb_len) {
-		struct fb_modelist *modelist;
-		unsigned int min_err = UINT_MAX, err;
-		const struct fb_videomode *mon_mode = hdmi->monspec.modedb;
-
-		list_for_each_entry(modelist, &hdmi->info->modelist, list) {
-			mode = &modelist->mode;
-			dev_dbg(hdmi->dev, "matching %ux%u to %ux%u\n", mode->xres, mode->yres,
-				 mon_mode->xres, mon_mode->yres);
-			if (mode->xres <= mon_mode->xres && mode->yres <= mon_mode->yres) {
-				err = mon_mode->xres - mode->xres + mon_mode->yres - mode->yres;
-				if (!err) {
-					found = mode;
-					break;
-				}
-				if (err < min_err) {
-					found = mode;
-					min_err = err;
-				}
-			}
+	if (info && !found) {
+		modelist = hdmi->info->modelist.next &&
+			!list_empty(&hdmi->info->modelist) ?
+			list_entry(hdmi->info->modelist.next,
+				   struct fb_modelist, list) :
+			NULL;
+
+		if (modelist) {
+			found = &modelist->mode;
+			found_rate_error = sh_hdmi_rate_error(hdmi, found);
 		}
 	}
 
-	/* Nothing suitable specified by the platform: use monitor's first mode */
-	if (!found && hdmi->monspec.modedb_len)
-		found = hdmi->monspec.modedb;
-
-	/* No valid timing info in EDID - last resort: use platform default mode */
-	if (!found && hdmi->info) {
-		struct fb_modelist *modelist = list_entry(hdmi->info->modelist.next,
-							  struct fb_modelist, list);
-		found = &modelist->mode;
-	}
-
 	/* No cookie today */
 	if (!found)
 		return -ENXIO;
 
-	dev_dbg(hdmi->dev, "best \"%s\" %ux%u@%ups\n", found->name,
-		found->xres, found->yres, found->pixclock);
+	dev_info(hdmi->dev, "Using %s mode %ux%u@%uHz (%luHz), clock error %luHz\n",
+		 modelist ? "default" : "EDID", found->xres, found->yres,
+		 found->refresh, PICOS2KHZ(found->pixclock) * 1000, found_rate_error);
 
 	if ((found->xres = 720 && found->yres = 480) ||
 	    (found->xres = 1280 && found->yres = 720) ||
-- 
1.7.1

