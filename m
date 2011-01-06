From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jan 2011 18:23:54 +0000
Subject: [PATCH 1/3] fbdev: sh_mobile_hdmi: add command line option to use
Message-Id: <Pine.LNX.4.64.1101061919490.1248@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Currently, if no command-line option is specified, the sh_mobile_hdmi
will use the default 720p video mode. If a command line option of the
form "video=sh_mobile_lcdc:<width>x<height>@<refresh>" is provided,
the driver will look for that mode among those, available in the
monitor EDID. This patch adds the ability to request the driver to
use monitor's preferred mode by specifying 0 as width and hight in
the above string. If that mode is not supported by the system, the
driver will continue scanning through EDID modes, until it finds a
suitable one.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |   59 +++++++++++++++++++++++++++------------
 1 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index fcda0e9..f18a619 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -713,7 +713,7 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 	struct fb_modelist *modelist = NULL;
 	unsigned int f_width = 0, f_height = 0, f_refresh = 0;
 	unsigned long found_rate_error = ULONG_MAX; /* silly compiler... */
-	bool exact_match = false;
+	bool scanning = false, preferred_bad = false;
 	u8 edid[128];
 	char *forced;
 	int i;
@@ -745,6 +745,9 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 		if (i < 2) {
 			f_width = 0;
 			f_height = 0;
+		} else {
+			/* The user wants us to use the EDID data */
+			scanning = true;
 		}
 		dev_dbg(hdmi->dev, "Forced mode %ux%u@%uHz\n",
 			f_width, f_height, f_refresh);
@@ -752,34 +755,54 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 
 	/* Walk monitor modes to find the best or the exact match */
 	for (i = 0, mode = hdmi->monspec.modedb;
-	     f_width && f_height && i < hdmi->monspec.modedb_len && !exact_match;
+	     i < hdmi->monspec.modedb_len && scanning;
 	     i++, mode++) {
-		unsigned long rate_error = sh_hdmi_rate_error(hdmi, mode);
+		unsigned long rate_error;
 
-		/* No interest in unmatching modes */
-		if (f_width != mode->xres || f_height != mode->yres)
-			continue;
-		if (f_refresh = mode->refresh || (!f_refresh && !rate_error))
-			/*
-			 * Exact match if either the refresh rate matches or it
-			 * hasn't been specified and we've found a mode, for
-			 * which we can configure the clock precisely
-			 */
-			exact_match = true;
-		else if (found && found_rate_error <= rate_error)
+		if (!f_width && !f_height) {
 			/*
-			 * We otherwise search for the closest matching clock
-			 * rate - either if no refresh rate has been specified
-			 * or we cannot find an exactly matching one
+			 * A parameter string "video=sh_mobile_lcdc:0x0" means
+			 * use the preferred EDID mode. If it is rejected by
+			 * .fb_check_var(), keep looking, until an acceptable
+			 * one is found.
 			 */
+			if ((mode->flag & FB_MODE_IS_FIRST) || preferred_bad)
+				scanning = false;
+			else
+				continue;
+		} else if (f_width != mode->xres || f_height != mode->yres) {
+			/* No interest in unmatching modes */
 			continue;
+		}
+
+		rate_error = sh_hdmi_rate_error(hdmi, mode);
+
+		if (scanning) {
+			if (f_refresh = mode->refresh || (!f_refresh && !rate_error))
+				/*
+				 * Exact match if either the refresh rate
+				 * matches or it hasn't been specified and we've
+				 * found a mode, for which we can configure the
+				 * clock precisely
+				 */
+				scanning = false;
+			else if (found && found_rate_error <= rate_error)
+				/*
+				 * We otherwise search for the closest matching
+				 * clock rate - either if no refresh rate has
+				 * been specified or we cannot find an exactly
+				 * matching one
+				 */
+				continue;
+		}
 
 		/* Check if supported: sufficient fb memory, supported clock-rate */
 		fb_videomode_to_var(var, mode);
 
 		if (info && info->fbops->fb_check_var &&
 		    info->fbops->fb_check_var(var, info)) {
-			exact_match = false;
+			scanning = true;
+			preferred_bad = true;
 			continue;
 		}
 
-- 
1.7.2.3

