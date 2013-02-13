From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:19:05 +0000
Subject: [PATCH 02/11] OMAPDSS: ls037v7dw01: remove platform backlight calls
Message-Id: <1360764434-18788-3-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

Sharp ls037v7dw01 driver contains support to call platform backlight
functions. These are not used by any board, and can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   62 --------------------
 1 file changed, 62 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index cada8c6..eb6bd81 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -20,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/backlight.h>
 #include <linux/fb.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -28,7 +27,6 @@
 #include <video/omapdss.h>
 
 struct sharp_data {
-	struct backlight_device *bl;
 };
 
 static struct omap_video_timings sharp_ls_timings = {
@@ -52,45 +50,10 @@ static struct omap_video_timings sharp_ls_timings = {
 	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
 };
 
-static int sharp_ls_bl_update_status(struct backlight_device *bl)
-{
-	struct omap_dss_device *dssdev = dev_get_drvdata(&bl->dev);
-	int level;
-
-	if (!dssdev->set_backlight)
-		return -EINVAL;
-
-	if (bl->props.fb_blank = FB_BLANK_UNBLANK &&
-			bl->props.power = FB_BLANK_UNBLANK)
-		level = bl->props.brightness;
-	else
-		level = 0;
-
-	return dssdev->set_backlight(dssdev, level);
-}
-
-static int sharp_ls_bl_get_brightness(struct backlight_device *bl)
-{
-	if (bl->props.fb_blank = FB_BLANK_UNBLANK &&
-			bl->props.power = FB_BLANK_UNBLANK)
-		return bl->props.brightness;
-
-	return 0;
-}
-
-static const struct backlight_ops sharp_ls_bl_ops = {
-	.get_brightness = sharp_ls_bl_get_brightness,
-	.update_status  = sharp_ls_bl_update_status,
-};
-
-
 
 static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
 {
-	struct backlight_properties props;
-	struct backlight_device *bl;
 	struct sharp_data *sd;
-	int r;
 
 	dssdev->panel.timings = sharp_ls_timings;
 
@@ -100,37 +63,12 @@ static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
 
 	dev_set_drvdata(&dssdev->dev, sd);
 
-	memset(&props, 0, sizeof(struct backlight_properties));
-	props.max_brightness = dssdev->max_backlight_level;
-	props.type = BACKLIGHT_RAW;
-
-	bl = backlight_device_register("sharp-ls", &dssdev->dev, dssdev,
-			&sharp_ls_bl_ops, &props);
-	if (IS_ERR(bl)) {
-		r = PTR_ERR(bl);
-		kfree(sd);
-		return r;
-	}
-	sd->bl = bl;
-
-	bl->props.fb_blank = FB_BLANK_UNBLANK;
-	bl->props.power = FB_BLANK_UNBLANK;
-	bl->props.brightness = dssdev->max_backlight_level;
-	r = sharp_ls_bl_update_status(bl);
-	if (r < 0)
-		dev_err(&dssdev->dev, "failed to set lcd brightness\n");
-
 	return 0;
 }
 
 static void __exit sharp_ls_panel_remove(struct omap_dss_device *dssdev)
 {
 	struct sharp_data *sd = dev_get_drvdata(&dssdev->dev);
-	struct backlight_device *bl = sd->bl;
-
-	bl->props.power = FB_BLANK_POWERDOWN;
-	sharp_ls_bl_update_status(bl);
-	backlight_device_unregister(bl);
 
 	kfree(sd);
 }
-- 
1.7.9.5

