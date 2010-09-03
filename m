From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:42 +0000
Subject: [PATCH 15/15] ARM: mach-shmobile: add two more video modes for HDMI
Message-Id: <Pine.LNX.4.64.1009030917340.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add video modes for 480p and SXGA (1280x1024).

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   41 ++++++++++++++++++++++++++++-----
 1 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 0a7bab2..eca4703 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -599,18 +599,18 @@ static struct platform_device fsi_device = {
 	},
 };
 
+/*
+ * If left and right margins are not multiples of 8,
+ * LDHAJR will be adjusted accordingly by the LCDC
+ * driver. Until we start using EDID, these values
+ * might have to be adjusted for different monitors.
+ */
 const static struct fb_videomode ap4evb_hdmi_modes[] = {
 	{
 		.name = "HDMI 720p",
 		.xres = 1280,
 		.yres = 720,
 
-		/*
-		 * If left and right margins are not multiples of 8,
-		 * LDHAJR will be adjusted accordingly by the LCDC
-		 * driver. Until we start using EDID, these values
-		 * might have to be adjusted for different monitors.
-		 */
 		.left_margin = 200,
 		.right_margin = 88,
 		.hsync_len = 48,
@@ -621,6 +621,35 @@ const static struct fb_videomode ap4evb_hdmi_modes[] = {
 
 		.pixclock = 13468,
 		.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
+	}, {
+		.name = "1280x1024",
+		.xres = 1280,
+		.yres = 1024,
+
+		.left_margin = 144,
+		.right_margin = 48,
+		.hsync_len = 64,
+
+		.upper_margin = 35,
+		.lower_margin = 5,
+		.vsync_len = 3,
+
+		.pixclock = 9800,
+		.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
+	}, {
+		.name = "HDMI 480p",
+		.xres = 720,
+		.yres = 480,
+
+		.left_margin = 36,
+		.right_margin = 18,
+		.hsync_len = 68,
+
+		.upper_margin = 36,
+		.lower_margin = 3,
+		.vsync_len = 6,
+		.pixclock = 37037,
+		.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
 	},
 };
 
-- 
1.7.1

