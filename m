From: yegorslists@googlemail.com
Date: Fri, 06 Jul 2012 14:01:28 +0000
Subject: [PATCH v2] da8xx-fb: add missing FB_BLANK operations
Message-Id: <1341583288-30281-1-git-send-email-yegorslists@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Yegor Yefremov <yegorslists@googlemail.com>

add FB_BLANK_NORMAL, FB_BLANK_VSYNC_SUSPEND and FB_BLANK_HSYNC_SUSPEND
modes (copy drivers/video/omap2/omapfb/omapfb-main.c implementation).
Otherwise X-server will complain about invalid parameter.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
v2: add linux-fbdev as recipient 

 drivers/video/da8xx-fb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 47118c7..8d745bf 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1026,6 +1026,9 @@ static int cfb_blank(int blank, struct fb_info *info)
 
 		lcd_enable_raster();
 		break;
+	case FB_BLANK_NORMAL:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_POWERDOWN:
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(0);
-- 
1.7.7

