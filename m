From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:14 +0000
Subject: [PATCH 19/57] fbdev: sh_mobile_lcdc: Move brightness ops to sh_mobile_lcdc_bl_info
Message-Id: <1323784972-24205-20-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Update board code accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    6 ++----
 arch/sh/boards/mach-ap325rxa/setup.c    |    4 ++--
 arch/sh/boards/mach-ecovec24/setup.c    |    6 ++----
 drivers/video/sh_mobile_lcdcfb.c        |    6 ++----
 include/video/sh_mobile_lcdc.h          |    4 ++--
 5 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 4446398..3460f54 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -396,13 +396,11 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.flags			= 0,
 		.lcd_size_cfg.width	= 152,
 		.lcd_size_cfg.height	= 91,
-		.board_cfg = {
-			.set_brightness = mackerel_set_brightness,
-			.get_brightness = mackerel_get_brightness,
-		},
 		.bl_info = {
 			.name = "sh_mobile_lcdc_bl",
 			.max_brightness = 1,
+			.set_brightness = mackerel_set_brightness,
+			.get_brightness = mackerel_get_brightness,
 		},
 		.meram_cfg = &lcd_meram_cfg,
 	}
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index d43a96c..1413c65 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -219,12 +219,12 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.board_cfg = {
 			.display_on = ap320_wvga_power_on,
 			.display_off = ap320_wvga_power_off,
-			.set_brightness = ap320_wvga_set_brightness,
-			.get_brightness = ap320_wvga_get_brightness,
 		},
 		.bl_info = {
 			.name = "sh_mobile_lcdc_bl",
 			.max_brightness = 1,
+			.set_brightness = ap320_wvga_set_brightness,
+			.get_brightness = ap320_wvga_get_brightness,
 		},
 	}
 };
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 24c2c14..2adc78e 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -335,13 +335,11 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.width = 152,
 			.height = 91,
 		},
-		.board_cfg = {
-			.set_brightness = ecovec24_set_brightness,
-			.get_brightness = ecovec24_get_brightness,
-		},
 		.bl_info = {
 			.name = "sh_mobile_lcdc_bl",
 			.max_brightness = 1,
+			.set_brightness = ecovec24_set_brightness,
+			.get_brightness = ecovec24_get_brightness,
 		},
 	}
 };
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 108b62d..0c358b0 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1319,22 +1319,20 @@ static struct fb_ops sh_mobile_lcdc_ops = {
 static int sh_mobile_lcdc_update_bl(struct backlight_device *bdev)
 {
 	struct sh_mobile_lcdc_chan *ch = bl_get_data(bdev);
-	struct sh_mobile_lcdc_board_cfg *cfg = &ch->cfg.board_cfg;
 	int brightness = bdev->props.brightness;
 
 	if (bdev->props.power != FB_BLANK_UNBLANK ||
 	    bdev->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
 		brightness = 0;
 
-	return cfg->set_brightness(brightness);
+	return ch->cfg.bl_info.set_brightness(brightness);
 }
 
 static int sh_mobile_lcdc_get_brightness(struct backlight_device *bdev)
 {
 	struct sh_mobile_lcdc_chan *ch = bl_get_data(bdev);
-	struct sh_mobile_lcdc_board_cfg *cfg = &ch->cfg.board_cfg;
 
-	return cfg->get_brightness();
+	return ch->cfg.bl_info.get_brightness();
 }
 
 static int sh_mobile_lcdc_check_fb(struct backlight_device *bdev,
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index a1e6596..541b2b3 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -154,8 +154,6 @@ struct sh_mobile_lcdc_board_cfg {
 			       struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 	void (*display_on)(void);
 	void (*display_off)(void);
-	int (*set_brightness)(int brightness);
-	int (*get_brightness)(void);
 };
 
 struct sh_mobile_lcdc_lcd_size_cfg { /* width and height of panel in mm */
@@ -167,6 +165,8 @@ struct sh_mobile_lcdc_lcd_size_cfg { /* width and height of panel in mm */
 struct sh_mobile_lcdc_bl_info {
 	const char *name;
 	int max_brightness;
+	int (*set_brightness)(int brightness);
+	int (*get_brightness)(void);
 };
 
 struct sh_mobile_lcdc_chan_cfg {
-- 
1.7.3.4

