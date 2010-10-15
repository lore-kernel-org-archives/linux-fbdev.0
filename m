From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Oct 2010 07:54:00 +0000
Subject: [PATCH 3/4] fbdev: sh_mobile_lcdc: relax .check_var() HSYNC test
Message-Id: <Pine.LNX.4.64.1010150951360.3945@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Some valid and supported video modes have .hsync_len > 120.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index d931382..8925e3f 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -919,7 +919,7 @@ static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *in
 	    var->right_margin < 12 || var->right_margin > 240 ||
 	    var->upper_margin < 12 || var->upper_margin > 120 ||
 	    var->lower_margin < 1 || var->lower_margin > 64 ||
-	    var->hsync_len < 32 || var->hsync_len > 120 ||
+	    var->hsync_len < 32 || var->hsync_len > 240 ||
 	    var->vsync_len < 2 || var->vsync_len > 64 ||
 	    var->pixclock < 6000 || var->pixclock > 40000 ||
 	    var->xres * var->yres * (ch->cfg.bpp / 8) * 2 > info->fix.smem_len) {
-- 
1.7.1

