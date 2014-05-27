From: <cfreeman@nvidia.com>
Date: Tue, 27 May 2014 01:17:37 +0000
Subject: [PATCH v1] fbdev: add cea modes and properties
Message-Id: <1401153457-27027-1-git-send-email-cfreeman@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Christopher Freeman <cfreeman@nvidia.com>

This is a port of two patches from Android source to fill in all
64 cea modes as well as specify the aspect ratios for those modes.

Changes were:

69f54f5 - video: fbmon: Add support for CEA pixel ratios. <Lajos Molnar>
2082e82 - video: fbmon: add remaining modes to CEA mode database <Erik Gilling>

There was one correction to CEA mode 1 which had an incorrect lower margin
(should be 10, was 1)

Signed-off-by: Christopher Freeman <cfreeman@nvidia.com>
---
 drivers/video/fbdev/core/fbmon.c  |  14 +-
 drivers/video/fbdev/core/modedb.c | 572 ++++++++++++++++++++++++++++++++++----
 include/linux/fb.h                |   3 +-
 include/uapi/linux/fb.h           |   4 +
 4 files changed, 533 insertions(+), 60 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index c204ebe..6041383 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -553,6 +553,9 @@ static int get_dst_timing(unsigned char *block,
 static void get_detailed_timing(unsigned char *block,
 				struct fb_videomode *mode)
 {
+	int v_size = V_SIZE;
+	int h_size = H_SIZE;
+
 	mode->xres = H_ACTIVE;
 	mode->yres = V_ACTIVE;
 	mode->pixclock = PIXEL_CLOCK;
@@ -581,11 +584,18 @@ static void get_detailed_timing(unsigned char *block,
 	}
 	mode->flag = FB_MODE_IS_DETAILED;
 
+	/* get aspect ratio */
+	if (h_size * 18 > v_size * 31 && h_size * 18 < v_size * 33)
+		mode->flag |= FB_FLAG_RATIO_16_9;
+	if (h_size * 18 > v_size * 23 && h_size * 18 < v_size * 25)
+		mode->flag |= FB_FLAG_RATIO_4_3;
+
 	DPRINTK("      %d MHz ",  PIXEL_CLOCK/1000000);
 	DPRINTK("%d %d %d %d ", H_ACTIVE, H_ACTIVE + H_SYNC_OFFSET,
 	       H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH, H_ACTIVE + H_BLANKING);
 	DPRINTK("%d %d %d %d ", V_ACTIVE, V_ACTIVE + V_SYNC_OFFSET,
 	       V_ACTIVE + V_SYNC_OFFSET + V_SYNC_WIDTH, V_ACTIVE + V_BLANKING);
+	DPRINTK("%dmm %dmm ", H_SIZE, V_SIZE);
 	DPRINTK("%sHSync %sVSync\n\n", (HSYNC_POSITIVE) ? "+" : "-",
 	       (VSYNC_POSITIVE) ? "+" : "-");
 }
@@ -1052,10 +1062,8 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 
 	for (i = specs->modedb_len + num; i < specs->modedb_len + num + svd_n; i++) {
 		int idx = svd[i - specs->modedb_len - num];
-		if (!idx || idx > 63) {
+		if (!idx || idx > (CEA_MODEDB_SIZE - 1)) {
 			pr_warning("Reserved SVD code %d\n", idx);
-		} else if (idx > ARRAY_SIZE(cea_modes) || !cea_modes[idx].xres) {
-			pr_warning("Unimplemented SVD code %d\n", idx);
 		} else {
 			memcpy(&m[i], cea_modes + idx, sizeof(m[i]));
 			pr_debug("Adding SVD #%d: %ux%u@%u\n", idx,
diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index a9a907c..69da1a8 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -292,64 +292,524 @@ static const struct fb_videomode modedb[] = {
 };
 
 #ifdef CONFIG_FB_MODE_HELPERS
-const struct fb_videomode cea_modes[64] = {
-	/* #1: 640x480p@59.94/60Hz */
-	[1] = {
-		NULL, 60, 640, 480, 39722, 48, 16, 33, 10, 96, 2, 0,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #3: 720x480p@59.94/60Hz */
-	[3] = {
-		NULL, 60, 720, 480, 37037, 60, 16, 30, 9, 62, 6, 0,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #5: 1920x1080i@59.94/60Hz */
-	[5] = {
-		NULL, 60, 1920, 1080, 13763, 148, 88, 15, 2, 44, 5,
-		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_INTERLACED, 0,
-	},
-	/* #7: 720(1440)x480iH@59.94/60Hz */
-	[7] = {
-		NULL, 60, 1440, 480, 18554/*37108*/, 114, 38, 15, 4, 124, 3, 0,
-		FB_VMODE_INTERLACED, 0,
-	},
-	/* #9: 720(1440)x240pH@59.94/60Hz */
-	[9] = {
-		NULL, 60, 1440, 240, 18554, 114, 38, 16, 4, 124, 3, 0,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #18: 720x576pH@50Hz */
-	[18] = {
-		NULL, 50, 720, 576, 37037, 68, 12, 39, 5, 64, 5, 0,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #19: 1280x720p@50Hz */
-	[19] = {
-		NULL, 50, 1280, 720, 13468, 220, 440, 20, 5, 40, 5,
-		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #20: 1920x1080i@50Hz */
-	[20] = {
-		NULL, 50, 1920, 1080, 13480, 148, 528, 15, 5, 528, 5,
-		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_INTERLACED, 0,
-	},
-	/* #32: 1920x1080p@23.98/24Hz */
-	[32] = {
-		NULL, 24, 1920, 1080, 13468, 148, 638, 36, 4, 44, 5,
-		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #35: (2880)x480p4x@59.94/60Hz */
-	[35] = {
-		NULL, 60, 2880, 480, 9250, 240, 64, 30, 9, 248, 6, 0,
-		FB_VMODE_NONINTERLACED, 0,
-	},
+const struct fb_videomode cea_modes[CEA_MODEDB_SIZE] = {
+	{},
+	/* 1: 640x480p @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 640, .yres = 480, .pixclock = 39721,
+	 .left_margin = 48, .right_margin = 16,
+	 .upper_margin = 33, .lower_margin = 10,
+	 .hsync_len = 96, .vsync_len = 2,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 2: 720x480p @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 720, .yres = 480, .pixclock = 37037,
+	 .left_margin = 60, .right_margin = 16,
+	 .upper_margin = 30, .lower_margin = 9,
+	 .hsync_len = 62, .vsync_len = 6,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 3: 720x480p @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 720, .yres = 480, .pixclock = 37037,
+	 .left_margin = 60, .right_margin = 16,
+	 .upper_margin = 30, .lower_margin = 9,
+	 .hsync_len = 62, .vsync_len = 6,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 4: 1280x720p @ 59.94Hz/60Hz */
+	{.refresh = 60, .xres = 1280, .yres = 720, .pixclock = 13468,
+	 .left_margin = 220, .right_margin = 110,
+	 .upper_margin = 20, .lower_margin = 5,
+	 .hsync_len = 40, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 5: 1920x1080i @ 59.94Hz/60Hz */
+	{.refresh = 60, .xres = 1920, .yres = 1080, .pixclock = 13468,
+	 .left_margin = 148, .right_margin = 88,
+	 .upper_margin = 15, .lower_margin = 2,
+	 .hsync_len = 44, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 6: 720(1440)x480i @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 1440, .yres = 480, .pixclock = 37037,
+	 .left_margin = 114, .right_margin = 38,
+	 .upper_margin = 15, .lower_margin = 4,
+	 .hsync_len = 124, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 7: 720(1440)x480i @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 1440, .yres = 480, .pixclock = 37037,
+	 .left_margin = 114, .right_margin = 38,
+	 .upper_margin = 15, .lower_margin = 4,
+	 .hsync_len = 124, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 8: 720(1440)x240p @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 1440, .yres = 240, .pixclock = 37037,
+	 .left_margin = 114, .right_margin = 38,
+	 .upper_margin = 15, .lower_margin = 5,
+	 .hsync_len = 124, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 9: 720(1440)x240p @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 1440, .yres = 240, .pixclock = 37037,
+	 .left_margin = 114, .right_margin = 38,
+	 .upper_margin = 15, .lower_margin = 5,
+	 .hsync_len = 124, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 10: 2880x480i @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 2880, .yres = 480, .pixclock = 18518,
+	 .left_margin = 228, .right_margin = 76,
+	 .upper_margin = 15, .lower_margin = 4,
+	 .hsync_len = 248, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 11: 2880x480i @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 2880, .yres = 480, .pixclock = 18518,
+	 .left_margin = 228, .right_margin = 76,
+	 .upper_margin = 15, .lower_margin = 4,
+	 .hsync_len = 248, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 12: 2880x240p @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 2880, .yres = 240, .pixclock = 18518,
+	 .left_margin = 228, .right_margin = 76,
+	 .upper_margin = 15, .lower_margin = 5,
+	 .hsync_len = 248, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 13: 2880x240p @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 2880, .yres = 240, .pixclock = 18518,
+	 .left_margin = 228, .right_margin = 76,
+	 .upper_margin = 15, .lower_margin = 5,
+	 .hsync_len = 248, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 14: 1440x480p @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 1440, .yres = 480, .pixclock = 18518,
+	 .left_margin = 120, .right_margin = 32,
+	 .upper_margin = 30, .lower_margin = 9,
+	 .hsync_len = 124, .vsync_len = 6,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 15: 1440x480p @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 1440, .yres = 480, .pixclock = 18518,
+	 .left_margin = 120, .right_margin = 32,
+	 .upper_margin = 30, .lower_margin = 9,
+	 .hsync_len = 124, .vsync_len = 6,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 16: 1920x1080p @ 59.94Hz/60Hz */
+	{.refresh = 60, .xres = 1920, .yres = 1080, .pixclock = 6734,
+	 .left_margin = 148, .right_margin = 88,
+	 .upper_margin = 36, .lower_margin = 4,
+	 .hsync_len = 44, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 17: 720x576p @ 50Hz */
+	{.refresh = 50, .xres = 720, .yres = 576, .pixclock = 37037,
+	 .left_margin = 68, .right_margin = 12,
+	 .upper_margin = 39, .lower_margin = 5,
+	 .hsync_len = 64, .vsync_len = 5,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 18: 720x576p @ 50Hz */
+	{.refresh = 50, .xres = 720, .yres = 576, .pixclock = 37037,
+	 .left_margin = 68, .right_margin = 12,
+	 .upper_margin = 39, .lower_margin = 5,
+	 .hsync_len = 64, .vsync_len = 5,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 19: 1280x720p @ 50Hz */
+	{.refresh = 50, .xres = 1280, .yres = 720, .pixclock = 13468,
+	 .left_margin = 220, .right_margin = 440,
+	 .upper_margin = 20, .lower_margin = 5,
+	 .hsync_len = 40, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 20: 1920x1080i @ 50Hz */
+	{.refresh = 50, .xres = 1920, .yres = 1080, .pixclock = 13468,
+	 .left_margin = 148, .right_margin = 528,
+	 .upper_margin = 15, .lower_margin = 2,
+	 .hsync_len = 44, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 21: 720(1440)x576i @ 50Hz */
+	{.refresh = 50, .xres = 1440, .yres = 576, .pixclock = 37037,
+	 .left_margin = 138, .right_margin = 24,
+	 .upper_margin = 19, .lower_margin = 2,
+	 .hsync_len = 126, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 22: 720(1440)x576i @ 50Hz */
+	{.refresh = 50, .xres = 1440, .yres = 576, .pixclock = 37037,
+	 .left_margin = 138, .right_margin = 24,
+	 .upper_margin = 19, .lower_margin = 2,
+	 .hsync_len = 126, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 23: 720(1440)x288p @ 50Hz */
+	{.refresh = 49, .xres = 1440, .yres = 288, .pixclock = 37037,
+	 .left_margin = 138, .right_margin = 24,
+	 .upper_margin = 19, .lower_margin = 4,
+	 .hsync_len = 126, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 24: 720(1440)x288p @ 50Hz */
+	{.refresh = 49, .xres = 1440, .yres = 288, .pixclock = 37037,
+	 .left_margin = 138, .right_margin = 24,
+	 .upper_margin = 19, .lower_margin = 4,
+	 .hsync_len = 126, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 25: 2880x576i @ 50Hz */
+	{.refresh = 50, .xres = 2880, .yres = 576, .pixclock = 18518,
+	 .left_margin = 276, .right_margin = 48,
+	 .upper_margin = 19, .lower_margin = 2,
+	 .hsync_len = 252, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 26: 2880x576i @ 50Hz */
+	{.refresh = 50, .xres = 2880, .yres = 576, .pixclock = 18518,
+	 .left_margin = 276, .right_margin = 48,
+	 .upper_margin = 19, .lower_margin = 2,
+	 .hsync_len = 252, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 27: 2880x288p @ 50Hz */
+	{.refresh = 49, .xres = 2880, .yres = 288, .pixclock = 18518,
+	 .left_margin = 276, .right_margin = 48,
+	 .upper_margin = 19, .lower_margin = 4,
+	 .hsync_len = 252, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 28: 2880x288p @ 50Hz */
+	{.refresh = 49, .xres = 2880, .yres = 288, .pixclock = 18518,
+	 .left_margin = 276, .right_margin = 48,
+	 .upper_margin = 19, .lower_margin = 4,
+	 .hsync_len = 252, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 29: 1440x576p @ 50Hz */
+	{.refresh = 50, .xres = 1440, .yres = 576, .pixclock = 18518,
+	 .left_margin = 136, .right_margin = 24,
+	 .upper_margin = 39, .lower_margin = 5,
+	 .hsync_len = 128, .vsync_len = 5,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 30: 1440x576p @ 50Hz */
+	{.refresh = 50, .xres = 1440, .yres = 576, .pixclock = 18518,
+	 .left_margin = 136, .right_margin = 24,
+	 .upper_margin = 39, .lower_margin = 5,
+	 .hsync_len = 128, .vsync_len = 5,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 31: 1920x1080p @ 50Hz */
+	{.refresh = 50, .xres = 1920, .yres = 1080, .pixclock = 6734,
+	 .left_margin = 148, .right_margin = 528,
+	 .upper_margin = 36, .lower_margin = 4,
+	 .hsync_len = 44, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 32: 1920x1080p @ 23.97Hz/24Hz */
+	{.refresh = 24, .xres = 1920, .yres = 1080, .pixclock = 13468,
+	 .left_margin = 148, .right_margin = 638,
+	 .upper_margin = 36, .lower_margin = 4,
+	 .hsync_len = 44, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 33: 1920x1080p @ 25Hz */
+	{.refresh = 25, .xres = 1920, .yres = 1080, .pixclock = 13468,
+	 .left_margin = 148, .right_margin = 528,
+	 .upper_margin = 36, .lower_margin = 4,
+	 .hsync_len = 44, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 34: 1920x1080p @ 29.97Hz/30Hz */
+	{.refresh = 30, .xres = 1920, .yres = 1080, .pixclock = 13468,
+	 .left_margin = 148, .right_margin = 88,
+	 .upper_margin = 36, .lower_margin = 4,
+	 .hsync_len = 44, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 35: 2880x480p @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 2880, .yres = 480, .pixclock = 9259,
+	 .left_margin = 240, .right_margin = 64,
+	 .upper_margin = 30, .lower_margin = 9,
+	 .hsync_len = 248, .vsync_len = 6,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 36: 2880x480p @ 59.94Hz/60Hz */
+	{.refresh = 59, .xres = 2880, .yres = 480, .pixclock = 9259,
+	 .left_margin = 240, .right_margin = 64,
+	 .upper_margin = 30, .lower_margin = 9,
+	 .hsync_len = 248, .vsync_len = 6,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 37: 2880x576p @ 50Hz */
+	{.refresh = 50, .xres = 2880, .yres = 576, .pixclock = 9259,
+	 .left_margin = 272, .right_margin = 48,
+	 .upper_margin = 39, .lower_margin = 5,
+	 .hsync_len = 256, .vsync_len = 5,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 38: 2880x576p @ 50Hz */
+	{.refresh = 50, .xres = 2880, .yres = 576, .pixclock = 9259,
+	 .left_margin = 272, .right_margin = 48,
+	 .upper_margin = 39, .lower_margin = 5,
+	 .hsync_len = 256, .vsync_len = 5,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 39: 1920x1080i @ 50Hz */
+	{.refresh = 50, .xres = 1920, .yres = 1080, .pixclock = 13888,
+	 .left_margin = 184, .right_margin = 32,
+	 .upper_margin = 57, .lower_margin = 2,
+	 .hsync_len = 168, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 40: 1920x1080i @ 100Hz */
+	{.refresh = 100, .xres = 1920, .yres = 1080, .pixclock = 6734,
+	 .left_margin = 148, .right_margin = 528,
+	 .upper_margin = 15, .lower_margin = 2,
+	 .hsync_len = 44, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 41: 1280x720p @ 100Hz */
+	{.refresh = 100, .xres = 1280, .yres = 720, .pixclock = 6734,
+	 .left_margin = 220, .right_margin = 440,
+	 .upper_margin = 20, .lower_margin = 5,
+	 .hsync_len = 40, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 42: 720x576p @ 100Hz */
+	{.refresh = 100, .xres = 720, .yres = 576, .pixclock = 18518,
+	 .left_margin = 68, .right_margin = 12,
+	 .upper_margin = 39, .lower_margin = 5,
+	 .hsync_len = 64, .vsync_len = 5,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 43: 720x576p @ 100Hz */
+	{.refresh = 100, .xres = 720, .yres = 576, .pixclock = 18518,
+	 .left_margin = 68, .right_margin = 12,
+	 .upper_margin = 39, .lower_margin = 5,
+	 .hsync_len = 64, .vsync_len = 5,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 44: 720(1440)x576i @ 100Hz */
+	{.refresh = 100, .xres = 1440, .yres = 576, .pixclock = 18518,
+	 .left_margin = 138, .right_margin = 24,
+	 .upper_margin = 19, .lower_margin = 2,
+	 .hsync_len = 126, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 45: 720(1440)x576i @ 100Hz */
+	{.refresh = 100, .xres = 1440, .yres = 576, .pixclock = 18518,
+	 .left_margin = 138, .right_margin = 24,
+	 .upper_margin = 19, .lower_margin = 2,
+	 .hsync_len = 126, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 46: 1920x1080i @ 119.88/120Hz */
+	{.refresh = 120, .xres = 1920, .yres = 1080, .pixclock = 6734,
+	 .left_margin = 148, .right_margin = 88,
+	 .upper_margin = 15, .lower_margin = 2,
+	 .hsync_len = 44, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 47: 1280x720p @ 119.88/120Hz */
+	{.refresh = 120, .xres = 1280, .yres = 720, .pixclock = 6734,
+	 .left_margin = 220, .right_margin = 110,
+	 .upper_margin = 20, .lower_margin = 5,
+	 .hsync_len = 40, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 48: 720x480p @ 119.88/120Hz */
+	{.refresh = 119, .xres = 720, .yres = 480, .pixclock = 18518,
+	 .left_margin = 60, .right_margin = 16,
+	 .upper_margin = 30, .lower_margin = 9,
+	 .hsync_len = 62, .vsync_len = 6,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 49: 720x480p @ 119.88/120Hz */
+	{.refresh = 119, .xres = 720, .yres = 480, .pixclock = 18518,
+	 .left_margin = 60, .right_margin = 16,
+	 .upper_margin = 30, .lower_margin = 9,
+	 .hsync_len = 62, .vsync_len = 6,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 50: 720(1440)x480i @ 119.88/120Hz */
+	{.refresh = 119, .xres = 1440, .yres = 480, .pixclock = 18518,
+	 .left_margin = 114, .right_margin = 38,
+	 .upper_margin = 15, .lower_margin = 4,
+	 .hsync_len = 124, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 51: 720(1440)x480i @ 119.88/120Hz */
+	{.refresh = 119, .xres = 1440, .yres = 480, .pixclock = 18518,
+	 .left_margin = 114, .right_margin = 38,
+	 .upper_margin = 15, .lower_margin = 4,
+	 .hsync_len = 124, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 52: 720x576p @ 200Hz */
+	{.refresh = 200, .xres = 720, .yres = 576, .pixclock = 9259,
+	 .left_margin = 68, .right_margin = 12,
+	 .upper_margin = 39, .lower_margin = 5,
+	 .hsync_len = 64, .vsync_len = 5,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 53: 720x576p @ 200Hz */
+	{.refresh = 200, .xres = 720, .yres = 576, .pixclock = 9259,
+	 .left_margin = 68, .right_margin = 12,
+	 .upper_margin = 39, .lower_margin = 5,
+	 .hsync_len = 64, .vsync_len = 5,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 54: 720(1440)x576i @ 200Hz */
+	{.refresh = 200, .xres = 1440, .yres = 576, .pixclock = 9259,
+	 .left_margin = 138, .right_margin = 24,
+	 .upper_margin = 19, .lower_margin = 2,
+	 .hsync_len = 126, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 55: 720(1440)x576i @ 200Hz */
+	{.refresh = 200, .xres = 1440, .yres = 576, .pixclock = 9259,
+	 .left_margin = 138, .right_margin = 24,
+	 .upper_margin = 19, .lower_margin = 2,
+	 .hsync_len = 126, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 56: 720x480p @ 239.76/240Hz */
+	{.refresh = 239, .xres = 720, .yres = 480, .pixclock = 9259,
+	 .left_margin = 60, .right_margin = 16,
+	 .upper_margin = 30, .lower_margin = 9,
+	 .hsync_len = 62, .vsync_len = 6,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 57: 720x480p @ 239.76/240Hz */
+	{.refresh = 239, .xres = 720, .yres = 480, .pixclock = 9259,
+	 .left_margin = 60, .right_margin = 16,
+	 .upper_margin = 30, .lower_margin = 9,
+	 .hsync_len = 62, .vsync_len = 6,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 58: 720(1440)x480i @ 239.76/240Hz */
+	{.refresh = 239, .xres = 1440, .yres = 480, .pixclock = 9259,
+	 .left_margin = 114, .right_margin = 38,
+	 .upper_margin = 15, .lower_margin = 4,
+	 .hsync_len = 124, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_4_3 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 59: 720(1440)x480i @ 239.76/240Hz */
+	{.refresh = 239, .xres = 1440, .yres = 480, .pixclock = 9259,
+	 .left_margin = 114, .right_margin = 38,
+	 .upper_margin = 15, .lower_margin = 4,
+	 .hsync_len = 124, .vsync_len = 3,
+	 .sync = 0,
+	 .flag = FB_FLAG_RATIO_16_9 | FB_FLAG_PIXEL_REPEAT,
+	 .vmode = FB_VMODE_INTERLACED},
+	/* 60: 1280x720p @ 23.97Hz/24Hz */
+	{.refresh = 24, .xres = 1280, .yres = 720, .pixclock = 16835,
+	 .left_margin = 220, .right_margin = 1760,
+	 .upper_margin = 20, .lower_margin = 5,
+	 .hsync_len = 40, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 61: 1280x720p @ 25Hz */
+	{.refresh = 25, .xres = 1280, .yres = 720, .pixclock = 13468,
+	 .left_margin = 220, .right_margin = 2420,
+	 .upper_margin = 20, .lower_margin = 5,
+	 .hsync_len = 40, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 62: 1280x720p @ 29.97Hz/30Hz */
+	{.refresh = 30, .xres = 1280, .yres = 720, .pixclock = 13468,
+	 .left_margin = 220, .right_margin = 1760,
+	 .upper_margin = 20, .lower_margin = 5,
+	 .hsync_len = 40, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 63: 1920x1080p @ 119.88/120Hz */
+	{.refresh = 120, .xres = 1920, .yres = 1080, .pixclock = 3367,
+	 .left_margin = 148, .right_margin = 88,
+	 .upper_margin = 36, .lower_margin = 4,
+	 .hsync_len = 44, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
+	/* 64: 1920x1080p @ 100Hz */
+	{.refresh = 100, .xres = 1920, .yres = 1080, .pixclock = 3367,
+	 .left_margin = 148, .right_margin = 528,
+	 .upper_margin = 36, .lower_margin = 4,
+	 .hsync_len = 44, .vsync_len = 5,
+	 .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	 .flag = FB_FLAG_RATIO_16_9,
+	 .vmode = FB_VMODE_NONINTERLACED},
 };
+EXPORT_SYMBOL(cea_modes);
 
-const struct fb_videomode vesa_modes[] = {
+const struct fb_videomode vesa_modes[VESA_MODEDB_SIZE] = {
 	/* 0 640x350-85 VESA */
 	{ NULL, 85, 640, 350, 31746,  96, 32, 60, 32, 64, 3,
 	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA},
diff --git a/include/linux/fb.h b/include/linux/fb.h
index fe6ac95..1035902 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -726,6 +726,7 @@ extern int fb_videomode_from_videomode(const struct videomode *vm,
 
 /* drivers/video/modedb.c */
 #define VESA_MODEDB_SIZE 34
+#define CEA_MODEDB_SIZE 65
 extern void fb_var_to_videomode(struct fb_videomode *mode,
 				const struct fb_var_screeninfo *var);
 extern void fb_videomode_to_var(struct fb_var_screeninfo *var,
@@ -778,7 +779,7 @@ struct fb_videomode {
 
 extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
-extern const struct fb_videomode cea_modes[64];
+extern const struct fb_videomode cea_modes[];
 
 struct fb_modelist {
 	struct list_head list;
diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
index fb795c3..a65a787 100644
--- a/include/uapi/linux/fb.h
+++ b/include/uapi/linux/fb.h
@@ -226,6 +226,10 @@ struct fb_bitfield {
 #define FB_VMODE_SMOOTH_XPAN	512	/* smooth xpan possible (internally used) */
 #define FB_VMODE_CONUPDATE	512	/* don't update x/yoffset	*/
 
+#define FB_FLAG_RATIO_4_3	64
+#define FB_FLAG_RATIO_16_9	128
+#define FB_FLAG_PIXEL_REPEAT	256
+
 /*
  * Display rotation support
  */
-- 
1.8.3.2


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
