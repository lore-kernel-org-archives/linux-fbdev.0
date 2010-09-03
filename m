From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:19:53 +0000
Subject: [PATCH 02/15] fbdev: sh_mobile_hdmi: simplify the EDID reading
Message-Id: <Pine.LNX.4.64.1009030910350.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The present SH-Mobile HDMI driver reads and parses the EDID block into a
variable screeninfo object, but since it is still unable to dynamically
reconfigure the framebuffer, it overwrites the EDID information with preset
values again. This patch just uses a temporary variable to store the EDID
timing information instead.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |   23 +++--------------------
 1 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 2fde08c..03bcb20 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -663,10 +663,9 @@ static void sh_hdmi_configure(struct sh_hdmi *hdmi)
 
 static void sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 {
-	struct fb_var_screeninfo *var = &hdmi->var;
-	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
-	struct fb_videomode *lcd_cfg = &pdata->lcd_chan->lcd_cfg;
-	unsigned long height = var->height, width = var->width;
+	struct fb_var_screeninfo tmpvar;
+	/* TODO: When we are ready to use EDID, use this to fill &hdmi->var */
+	struct fb_var_screeninfo *var = &tmpvar;
 	int i;
 	u8 edid[128];
 
@@ -692,22 +691,6 @@ static void sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 		 var->upper_margin, var->yres, var->lower_margin, var->vsync_len,
 		 PICOS2KHZ(var->pixclock));
 
-	/* FIXME: Use user-provided configuration instead of EDID */
-	var->width		= width;
-	var->xres		= lcd_cfg->xres;
-	var->xres_virtual	= lcd_cfg->xres;
-	var->left_margin	= lcd_cfg->left_margin;
-	var->right_margin	= lcd_cfg->right_margin;
-	var->hsync_len		= lcd_cfg->hsync_len;
-	var->height		= height;
-	var->yres		= lcd_cfg->yres;
-	var->yres_virtual	= lcd_cfg->yres * 2;
-	var->upper_margin	= lcd_cfg->upper_margin;
-	var->lower_margin	= lcd_cfg->lower_margin;
-	var->vsync_len		= lcd_cfg->vsync_len;
-	var->sync		= lcd_cfg->sync;
-	var->pixclock		= lcd_cfg->pixclock;
-
 	hdmi_external_video_param(hdmi);
 }
 
-- 
1.7.1

