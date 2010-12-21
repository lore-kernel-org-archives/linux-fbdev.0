From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 21 Dec 2010 10:46:35 +0000
Subject: [PATCH 2/3] fbdev: sh-mobile: retrieve and propagate display sizes
Message-Id: <Pine.LNX.4.64.1012211054060.32347@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Monitor EDID contains information about physical display sizes. Retrieve 
it and propagate to the framebuffer driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index d7df103..fcda0e9 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -787,6 +787,9 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi)
 		found_rate_error = rate_error;
 	}
 
+	hdmi->var.width = hdmi->monspec.max_x * 10;
+	hdmi->var.height = hdmi->monspec.max_y * 10;
+
 	/*
 	 * TODO 1: if no ->info is present, postpone running the config until
 	 * after ->info first gets registered.
@@ -960,8 +963,12 @@ static bool sh_hdmi_must_reconfigure(struct sh_hdmi *hdmi)
 	dev_dbg(info->dev, "Old %ux%u, new %ux%u\n",
 		mode1.xres, mode1.yres, mode2.xres, mode2.yres);
 
-	if (fb_mode_is_equal(&mode1, &mode2))
+	if (fb_mode_is_equal(&mode1, &mode2)) {
+		/* It can be a different monitor with an equal video-mode */
+		old_var->width = new_var->width;
+		old_var->height = new_var->height;
 		return false;
+	}
 
 	dev_dbg(info->dev, "Switching %u -> %u lines\n",
 		mode1.yres, mode2.yres);
@@ -1057,8 +1064,11 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 			 * on, if we run a resume here, the logo disappears
 			 */
 			if (lock_fb_info(hdmi->info)) {
-				sh_hdmi_display_on(hdmi, hdmi->info);
-				unlock_fb_info(hdmi->info);
+				struct fb_info *info = hdmi->info;
+				info->var.width = hdmi->var.width;
+				info->var.height = hdmi->var.height;
+				sh_hdmi_display_on(hdmi, info);
+				unlock_fb_info(info);
 			}
 		} else {
 			/* New monitor or have to wake up */
