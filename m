From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Oct 2010 07:53:56 +0000
Subject: [PATCH 2/4] ARM: mach-shmobile: remove videomodes from ap4evb platform
Message-Id: <Pine.LNX.4.64.1010150951100.3945@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Now that HDMI videomodes have become optional, they can be safely removed from
ap4evb platform data, since anyway 720p seems to be the best supported mode.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   56 ---------------------------------
 1 files changed, 0 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index b8a55fc..324875d 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -614,60 +614,6 @@ static struct platform_device fsi_device = {
 	},
 };
 
-/*
- * If left and right margins are not multiples of 8,
- * LDHAJR will be adjusted accordingly by the LCDC
- * driver. Until we start using EDID, these values
- * might have to be adjusted for different monitors.
- */
-const static struct fb_videomode ap4evb_hdmi_modes[] = {
-	{
-		.name = "HDMI 720p",
-		.xres = 1280,
-		.yres = 720,
-
-		.left_margin = 200,
-		.right_margin = 88,
-		.hsync_len = 48,
-
-		.upper_margin = 20,
-		.lower_margin = 5,
-		.vsync_len = 5,
-
-		.pixclock = 13468,
-		.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
-	}, {
-		.name = "1280x1024",
-		.xres = 1280,
-		.yres = 1024,
-
-		.left_margin = 144,
-		.right_margin = 48,
-		.hsync_len = 64,
-
-		.upper_margin = 35,
-		.lower_margin = 5,
-		.vsync_len = 3,
-
-		.pixclock = 9800,
-		.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
-	}, {
-		.name = "HDMI 480p",
-		.xres = 720,
-		.yres = 480,
-
-		.left_margin = 36,
-		.right_margin = 18,
-		.hsync_len = 68,
-
-		.upper_margin = 36,
-		.lower_margin = 3,
-		.vsync_len = 6,
-		.pixclock = 37037,
-		.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
-	},
-};
-
 static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
 	.clock_source = LCDC_CLK_EXTERNAL,
 	.ch[0] = {
@@ -676,8 +622,6 @@ static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
 		.interface_type = RGB24,
 		.clock_divider = 1,
 		.flags = LCDC_FLAGS_DWPOL,
-		.lcd_cfg = ap4evb_hdmi_modes,
-		.num_cfg = ARRAY_SIZE(ap4evb_hdmi_modes),
 	}
 };
 
-- 
1.7.1

