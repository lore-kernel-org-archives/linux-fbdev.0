From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 02 Nov 2010 11:27:20 +0000
Subject: [PATCH 2/4 v2] fbdev: sh_mobile_hdmi: improve support for more video
Message-Id: <Pine.LNX.4.64.1011021221190.4552@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Configure pre-programmed VIC modes for VGA (640x480@60) and 720x576@50
modes, change PHY mode selection to be based on pixel clock frequency.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: no change

 drivers/video/sh_mobile_hdmi.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index ff7f785..c474b0bd 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -466,7 +466,7 @@ static void sh_hdmi_audio_config(struct sh_hdmi *hdmi)
  */
 static void sh_hdmi_phy_config(struct sh_hdmi *hdmi)
 {
-	if (hdmi->var.yres > 480) {
+	if (hdmi->var.pixclock < 30000) {
 		/* 720p, 8bit, 74.25MHz. Might need to be adjusted for other formats */
 		/*
 		 * [1:0]	Speed_A
@@ -570,8 +570,12 @@ static void sh_hdmi_avi_infoframe_setup(struct sh_hdmi *hdmi)
 	 */
 	if (hdmi->var.yres = 1080 && hdmi->var.xres = 1920)
 		vic = 16;
+	else if (hdmi->var.yres = 576 && hdmi->var.xres = 720)
+		vic = 17;
 	else if (hdmi->var.yres = 480 && hdmi->var.xres = 720)
 		vic = 2;
+	else if (hdmi->var.yres = 480 && hdmi->var.xres = 640)
+		vic = 1;
 	else
 		vic = 4;
 	hdmi_write(hdmi, vic, HDMI_CTRL_PKT_BUF_ACCESS_PB4);
@@ -824,9 +828,11 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi, unsigned long *hdmi_rate,
 	if (!found)
 		return -ENXIO;
 
-	if ((found->xres = 720 && found->yres = 480) ||
-	    (found->xres = 1280 && found->yres = 720) ||
-	    (found->xres = 1920 && found->yres = 1080))
+	if ((found->xres = 640 && found->yres = 480 && found->refresh = 60) ||
+	    (found->xres = 720 && found->yres = 480 && found->refresh = 60) ||
+	    (found->xres = 720 && found->yres = 576 && found->refresh = 50) ||
+	    (found->xres = 1280 && found->yres = 720 && found->refresh = 60) ||
+	    (found->xres = 1920 && found->yres = 1080 && found->refresh = 60))
 		hdmi->preprogrammed_mode = true;
 	else
 		hdmi->preprogrammed_mode = false;
-- 
1.7.2.3

