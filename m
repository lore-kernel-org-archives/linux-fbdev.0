From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:47 +0000
Subject: [PATCH 12/19] fbdev: sh_mobile_lcdc: Store the backlight brightness internally
Message-Id: <1345122054-16013-13-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

There's no need to query the hardware for the currenty brightness value
through a platform data callback when we can cache the value internally
in the LCDC driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    3 ++-
 drivers/video/sh_mobile_lcdcfb.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index c169581..dd8dd41 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -2282,6 +2282,7 @@ static int sh_mobile_lcdc_update_bl(struct backlight_device *bdev)
 	    bdev->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
 		brightness = 0;
 
+	ch->bl_brightness = brightness;
 	return ch->cfg->bl_info.set_brightness(brightness);
 }
 
@@ -2289,7 +2290,7 @@ static int sh_mobile_lcdc_get_brightness(struct backlight_device *bdev)
 {
 	struct sh_mobile_lcdc_chan *ch = bl_get_data(bdev);
 
-	return ch->cfg->bl_info.get_brightness();
+	return ch->bl_brightness;
 }
 
 static int sh_mobile_lcdc_check_fb(struct backlight_device *bdev,
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 0f92f65..f839ade 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -94,6 +94,7 @@ struct sh_mobile_lcdc_chan {
 
 	/* Backlight */
 	struct backlight_device *bl;
+	unsigned int bl_brightness;
 
 	/* FB */
 	struct fb_info *info;
-- 
1.7.8.6

