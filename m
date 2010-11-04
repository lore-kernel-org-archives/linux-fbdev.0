From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 04 Nov 2010 11:06:06 +0000
Subject: [PATCH 3/5] fbdev: sh_mobile_lcdc: increase maximum framebuffer size
Message-Id: <Pine.LNX.4.64.1011041200050.13123@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

LCDC hardware can support 1920x1080 formats, adjust the driver to cover them.
Besides, instead of guessing some "reasonable" validity checks, only verify
values in .fb_check_var(), that we are sure, we cannot support.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |   26 ++++++++------------------
 1 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index a87dace..8e8d698 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -54,8 +54,8 @@ static int lcdc_shared_regs[] = {
 };
 #define NR_SHARED_REGS ARRAY_SIZE(lcdc_shared_regs)
 
-#define DEFAULT_XRES 1280
-#define DEFAULT_YRES 1024
+#define MAX_XRES 1920
+#define MAX_YRES 1080
 
 static unsigned long lcdc_offs_mainlcd[NR_CH_REGS] = {
 	[LDDCKPAT1R] = 0x400,
@@ -914,22 +914,12 @@ static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *in
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
 
-	if (var->xres < 160 || var->xres > 1920 ||
-	    var->yres < 120 || var->yres > 1080 ||
-	    var->left_margin < 32 || var->left_margin > 320 ||
-	    var->right_margin < 12 || var->right_margin > 240 ||
-	    var->upper_margin < 12 || var->upper_margin > 120 ||
-	    var->lower_margin < 1 || var->lower_margin > 64 ||
-	    var->hsync_len < 32 || var->hsync_len > 240 ||
-	    var->vsync_len < 2 || var->vsync_len > 64 ||
-	    var->pixclock < 6000 || var->pixclock > 40000 ||
+	if (var->xres > MAX_XRES || var->yres > MAX_YRES ||
 	    var->xres * var->yres * (ch->cfg.bpp / 8) * 2 > info->fix.smem_len) {
-		dev_warn(info->dev, "Invalid info: %u %u %u %u %u %u %u %u %u!\n",
-			 var->xres, var->yres,
-			 var->left_margin, var->right_margin,
-			 var->upper_margin, var->lower_margin,
-			 var->hsync_len, var->vsync_len,
-			 var->pixclock);
+		dev_warn(info->dev, "Invalid info: %u-%u-%u-%u x %u-%u-%u-%u @ %ukHz!\n",
+			 var->left_margin, var->xres, var->right_margin, var->hsync_len,
+			 var->upper_margin, var->yres, var->lower_margin, var->vsync_len,
+			 PICOS2KHZ(var->pixclock));
 		return -EINVAL;
 	}
 	return 0;
@@ -1225,7 +1215,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		}
 
 		if (!mode)
-			max_size = DEFAULT_XRES * DEFAULT_YRES;
+			max_size = MAX_XRES * MAX_YRES;
 		else if (max_cfg)
 			dev_dbg(&pdev->dev, "Found largest videomode %ux%u\n",
 				max_cfg->xres, max_cfg->yres);
-- 
1.7.2.3

