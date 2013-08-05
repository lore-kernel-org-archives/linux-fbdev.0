From: Darren Etheridge <detheridge@ti.com>
Date: Mon, 05 Aug 2013 22:02:22 +0000
Subject: [PATCH v3 03/20] video: da8xx-fb: use modedb helper to update var
Message-Id: <1375740159-1045-4-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Afzal Mohammed <afzal@ti.com>

modedb structure is now used to store panel information, run modedb
helper over it for initial update of "var" information instead of
equating each fields.

While at it, remove redundant update of bits_per_pixel.

Note: pixclock is overridden with proper value using an existing code
as currently modedb is having it in Hz instead of ps, this would be
fixed in a later change and this overide would be removed.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 52977b1..a1f6544 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1329,6 +1329,8 @@ static int fb_probe(struct platform_device *device)
 		par->panel_power_ctrl(1);
 	}
 
+	fb_videomode_to_var(&da8xx_fb_var, lcdc_info);
+
 	if (lcd_init(par, lcd_cfg, lcdc_info) < 0) {
 		dev_err(&device->dev, "lcd_init failed\n");
 		ret = -EFAULT;
@@ -1381,25 +1383,9 @@ static int fb_probe(struct platform_device *device)
 		goto err_release_pl_mem;
 	}
 
-	/* Initialize par */
-	da8xx_fb_info->var.bits_per_pixel = lcd_cfg->bpp;
-
-	da8xx_fb_var.xres = lcdc_info->xres;
-	da8xx_fb_var.xres_virtual = lcdc_info->xres;
-
-	da8xx_fb_var.yres         = lcdc_info->yres;
-	da8xx_fb_var.yres_virtual = lcdc_info->yres * LCD_NUM_BUFFERS;
-
 	da8xx_fb_var.grayscale  	    lcd_cfg->panel_shade = MONOCHROME ? 1 : 0;
 	da8xx_fb_var.bits_per_pixel = lcd_cfg->bpp;
-
-	da8xx_fb_var.hsync_len = lcdc_info->hsync_len;
-	da8xx_fb_var.vsync_len = lcdc_info->vsync_len;
-	da8xx_fb_var.right_margin = lcdc_info->right_margin;
-	da8xx_fb_var.left_margin  = lcdc_info->left_margin;
-	da8xx_fb_var.lower_margin = lcdc_info->lower_margin;
-	da8xx_fb_var.upper_margin = lcdc_info->upper_margin;
 	da8xx_fb_var.pixclock = da8xxfb_pixel_clk_period(par);
 
 	/* Initialize fbinfo */
-- 
1.7.0.4

