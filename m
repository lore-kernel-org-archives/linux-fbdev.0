From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 04 Nov 2010 11:06:17 +0000
Subject: [PATCH 5/5] fbdev: sh_mobile_hdmi: add support for 1080p modes
Message-Id: <Pine.LNX.4.64.1011041204240.13123@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add support for 3 more preprogrammed video modes: 1080p at 24, 50, and 60Hz.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |   56 +++++++++++++++++++++++++---------------
 1 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index dadb632..af101bd 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -209,7 +209,7 @@ enum hotplug_state {
 struct sh_hdmi {
 	void __iomem *base;
 	enum hotplug_state hp_state;	/* hot-plug status */
-	bool preprogrammed_mode;	/* use a pre-programmed VIC or the external mode */
+	u8 preprogrammed_vic;		/* use a pre-programmed VIC or the external mode */
 	u8 edid_block_addr;
 	u8 edid_segment_nr;
 	u8 edid_blocks;
@@ -345,7 +345,7 @@ static void sh_hdmi_external_video_param(struct sh_hdmi *hdmi)
 	hdmi_write(hdmi, var->vsync_len, HDMI_EXTERNAL_V_DURATION);
 
 	/* Set bit 0 of HDMI_EXTERNAL_VIDEO_PARAM_SETTINGS here for external mode */
-	if (!hdmi->preprogrammed_mode)
+	if (!hdmi->preprogrammed_vic)
 		hdmi_write(hdmi, sync | 1 | (voffset << 4),
 			   HDMI_EXTERNAL_VIDEO_PARAM_SETTINGS);
 }
@@ -469,7 +469,18 @@ static void sh_hdmi_audio_config(struct sh_hdmi *hdmi)
  */
 static void sh_hdmi_phy_config(struct sh_hdmi *hdmi)
 {
-	if (hdmi->var.pixclock < 30000) {
+	if (hdmi->var.pixclock < 10000) {
+		/* for 1080p8bit 148MHz */
+		hdmi_write(hdmi, 0x1d, HDMI_SLIPHDMIT_PARAM_SETTINGS_1);
+		hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_2);
+		hdmi_write(hdmi, 0x00, HDMI_SLIPHDMIT_PARAM_SETTINGS_3);
+		hdmi_write(hdmi, 0x4c, HDMI_SLIPHDMIT_PARAM_SETTINGS_5);
+		hdmi_write(hdmi, 0x1e, HDMI_SLIPHDMIT_PARAM_SETTINGS_6);
+		hdmi_write(hdmi, 0x48, HDMI_SLIPHDMIT_PARAM_SETTINGS_7);
+		hdmi_write(hdmi, 0x0e, HDMI_SLIPHDMIT_PARAM_SETTINGS_8);
+		hdmi_write(hdmi, 0x25, HDMI_SLIPHDMIT_PARAM_SETTINGS_9);
+		hdmi_write(hdmi, 0x04, HDMI_SLIPHDMIT_PARAM_SETTINGS_10);
+	} else if (hdmi->var.pixclock < 30000) {
 		/* 720p, 8bit, 74.25MHz. Might need to be adjusted for other formats */
 		/*
 		 * [1:0]	Speed_A
@@ -527,6 +538,7 @@ static void sh_hdmi_phy_config(struct sh_hdmi *hdmi)
  */
 static void sh_hdmi_avi_infoframe_setup(struct sh_hdmi *hdmi)
 {
+	struct fb_var_screeninfo *var = &hdmi->var;
 	u8 vic;
 
 	/* AVI InfoFrame */
@@ -568,17 +580,11 @@ static void sh_hdmi_avi_infoframe_setup(struct sh_hdmi *hdmi)
 	hdmi_write(hdmi, 0x00, HDMI_CTRL_PKT_BUF_ACCESS_PB3);
 
 	/*
-	 * VIC = 1280 x 720p: ignored if external config is used
-	 * Send 2 for 720 x 480p, 16 for 1080p, ignored in external mode
+	 * VIC should be ignored if external config is used, so, we could just use 0,
+	 * but play safe and use a valid value in any case just in case
 	 */
-	if (hdmi->var.yres = 1080 && hdmi->var.xres = 1920)
-		vic = 16;
-	else if (hdmi->var.yres = 576 && hdmi->var.xres = 720)
-		vic = 17;
-	else if (hdmi->var.yres = 480 && hdmi->var.xres = 720)
-		vic = 2;
-	else if (hdmi->var.yres = 480 && hdmi->var.xres = 640)
-		vic = 1;
+	if (hdmi->preprogrammed_vic)
+		vic = hdmi->preprogrammed_vic;
 	else
 		vic = 4;
 	hdmi_write(hdmi, vic, HDMI_CTRL_PKT_BUF_ACCESS_PB4);
@@ -862,17 +868,25 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi, unsigned long *hdmi_rate,
 	if (!found)
 		return -ENXIO;
 
-	if ((found->xres = 640 && found->yres = 480 && found->refresh = 60) ||
-	    (found->xres = 720 && found->yres = 480 && found->refresh = 60) ||
-	    (found->xres = 720 && found->yres = 576 && found->refresh = 50) ||
-	    (found->xres = 1280 && found->yres = 720 && found->refresh = 60) ||
-	    (found->xres = 1920 && found->yres = 1080 && found->refresh = 60))
-		hdmi->preprogrammed_mode = true;
+	if (found->xres = 640 && found->yres = 480 && found->refresh = 60)
+		hdmi->preprogrammed_vic = 1;
+	else if (found->xres = 720 && found->yres = 480 && found->refresh = 60)
+		hdmi->preprogrammed_vic = 2;
+	else if (found->xres = 720 && found->yres = 576 && found->refresh = 50)
+		hdmi->preprogrammed_vic = 17;
+	else if (found->xres = 1280 && found->yres = 720 && found->refresh = 60)
+		hdmi->preprogrammed_vic = 4;
+	else if (found->xres = 1920 && found->yres = 1080 && found->refresh = 24)
+		hdmi->preprogrammed_vic = 32;
+	else if (found->xres = 1920 && found->yres = 1080 && found->refresh = 50)
+		hdmi->preprogrammed_vic = 31;
+	else if (found->xres = 1920 && found->yres = 1080 && found->refresh = 60)
+		hdmi->preprogrammed_vic = 16;
 	else
-		hdmi->preprogrammed_mode = false;
+		hdmi->preprogrammed_vic = 0;
 
 	dev_dbg(hdmi->dev, "Using %s %s mode %ux%u@%uHz (%luHz), clock error %luHz\n",
-		modelist ? "default" : "EDID", hdmi->preprogrammed_mode ? "VIC" : "external",
+		modelist ? "default" : "EDID", hdmi->preprogrammed_vic ? "VIC" : "external",
 		found->xres, found->yres, found->refresh,
 		PICOS2KHZ(found->pixclock) * 1000, found_rate_error);
 
-- 
1.7.2.3

