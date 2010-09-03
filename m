From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:20 +0000
Subject: [PATCH 09/15] fbdev: sh_mobile_hdmi: enable "external" mode
Message-Id: <Pine.LNX.4.64.1009030914290.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The SH-Mobile HDMI controller supports two configuration modes: using
pre-programmed VICs and the "external" mode - specifying video parameters
explicitly. The driver already contains code, necessary to configure HDMI
manually, this patch actually enables it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index fd91204..293b16d 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -205,6 +205,7 @@ enum hotplug_state {
 struct sh_hdmi {
 	void __iomem *base;
 	enum hotplug_state hp_state;
+	bool preprogrammed_mode;	/* use a pre-programmed VIC or the external mode */
 	struct clk *hdmi_clk;
 	struct device *dev;
 	struct fb_info *info;
@@ -282,7 +283,10 @@ static void hdmi_external_video_param(struct sh_hdmi *hdmi)
 
 	hdmi_write(hdmi, var->vsync_len, HDMI_EXTERNAL_V_DURATION);
 
-	/* Set bit 0 of HDMI_EXTERNAL_VIDEO_PARAM_SETTINGS here for manual mode */
+	/* Set bit 0 of HDMI_EXTERNAL_VIDEO_PARAM_SETTINGS here for external mode */
+	if (!hdmi->preprogrammed_mode)
+		hdmi_write(hdmi, sync | 1 | (voffset << 4),
+			   HDMI_EXTERNAL_VIDEO_PARAM_SETTINGS);
 }
 
 /**
@@ -739,6 +743,13 @@ static void sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 		 var->upper_margin, var->yres, var->lower_margin, var->vsync_len,
 		 PICOS2KHZ(var->pixclock));
 
+	if ((hdmi->var.xres = 720 && hdmi->var.yres = 480) ||
+	    (hdmi->var.xres = 1280 && hdmi->var.yres = 720) ||
+	    (hdmi->var.xres = 1920 && hdmi->var.yres = 1080))
+		hdmi->preprogrammed_mode = true;
+	else
+		hdmi->preprogrammed_mode = false;
+
 	hdmi_external_video_param(hdmi);
 }
 
-- 
1.7.1

