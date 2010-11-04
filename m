From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 04 Nov 2010 11:06:01 +0000
Subject: [PATCH 2/5] fbdev: sh_mobile_lcdc: use the standard CEA-861 720p
Message-Id: <Pine.LNX.4.64.1011041159420.13123@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

sh_mobile_lcdcfb.c has a hard-coded 720p video mode, used as default, if none
is explicitly specified by the platform. Adjust its timing to match the CEA
standard. Also add an explicit refresh rate value, which is needed, when used
with HDMI, to be able to recognise the default 720p mode as a pre-programmed
VIC #4.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 5096373..a87dace 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -115,15 +115,16 @@ static const struct fb_videomode default_720p = {
 	.xres = 1280,
 	.yres = 720,
 
-	.left_margin = 200,
-	.right_margin = 88,
-	.hsync_len = 48,
+	.left_margin = 220,
+	.right_margin = 110,
+	.hsync_len = 40,
 
 	.upper_margin = 20,
 	.lower_margin = 5,
 	.vsync_len = 5,
 
 	.pixclock = 13468,
+	.refresh = 60,
 	.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
 };
 
-- 
1.7.2.3

