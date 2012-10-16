From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 16 Oct 2012 05:05:15 +0000
Subject: [PATCH v2 1/2] da8xx-fb: adopt fb_videomode data for panel information
Message-Id: <1350363196-9340-2-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Adopt fb_videomode data instead of defining driver private
structure to hold panel information. This is the way standard FB
drivers maintain the panel information.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Since v1:
Do not move panel information out of driver, adopt only fb_videomode data.

 drivers/video/da8xx-fb.c |  130 +++++++++++++++++++++-------------------------
 include/video/da8xx-fb.h |    3 +
 2 files changed, 63 insertions(+), 70 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 65a11ef..90cf33a 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -213,62 +213,50 @@ static struct fb_fix_screeninfo da8xx_fb_fix __devinitdata = {
 	.accel = FB_ACCEL_NONE
 };
 
-struct da8xx_panel {
-	const char	name[25];	/* Full name <vendor>_<model> */
-	unsigned short	width;
-	unsigned short	height;
-	int		hfp;		/* Horizontal front porch */
-	int		hbp;		/* Horizontal back porch */
-	int		hsw;		/* Horizontal Sync Pulse Width */
-	int		vfp;		/* Vertical front porch */
-	int		vbp;		/* Vertical back porch */
-	int		vsw;		/* Vertical Sync Pulse Width */
-	unsigned int	pxl_clk;	/* Pixel clock */
-	unsigned char	invert_pxl_clk;	/* Invert Pixel clock */
-};
-
-static struct da8xx_panel known_lcd_panels[] = {
+static struct fb_videomode known_lcd_panels[] = {
 	/* Sharp LCD035Q3DG01 */
 	[0] = {
-		.name = "Sharp_LCD035Q3DG01",
-		.width = 320,
-		.height = 240,
-		.hfp = 8,
-		.hbp = 6,
-		.hsw = 0,
-		.vfp = 2,
-		.vbp = 2,
-		.vsw = 0,
-		.pxl_clk = 4608000,
-		.invert_pxl_clk = 1,
+		.name           = "Sharp_LCD035Q3DG01",
+		.xres           = 320,
+		.yres           = 240,
+		.pixclock       = 4608000,
+		.left_margin    = 6,
+		.right_margin   = 8,
+		.upper_margin   = 2,
+		.lower_margin   = 2,
+		.hsync_len      = 0,
+		.vsync_len      = 0,
+		.sync           = FB_SYNC_CLK_INVERT,
 	},
 	/* Sharp LK043T1DG01 */
 	[1] = {
-		.name = "Sharp_LK043T1DG01",
-		.width = 480,
-		.height = 272,
-		.hfp = 2,
-		.hbp = 2,
-		.hsw = 41,
-		.vfp = 2,
-		.vbp = 2,
-		.vsw = 10,
-		.pxl_clk = 7833600,
-		.invert_pxl_clk = 0,
+		.name           = "Sharp_LK043T1DG01",
+		.xres           = 480,
+		.yres           = 272,
+		.pixclock       = 7833600,
+		.left_margin    = 2,
+		.right_margin   = 2,
+		.upper_margin   = 2,
+		.lower_margin   = 2,
+		.hsync_len      = 41,
+		.vsync_len      = 10,
+		.sync           = 0,
+		.flag           = 0,
 	},
 	[2] = {
 		/* Hitachi SP10Q010 */
-		.name = "SP10Q010",
-		.width = 320,
-		.height = 240,
-		.hfp = 10,
-		.hbp = 10,
-		.hsw = 10,
-		.vfp = 10,
-		.vbp = 10,
-		.vsw = 10,
-		.pxl_clk = 7833600,
-		.invert_pxl_clk = 0,
+		.name           = "SP10Q010",
+		.xres           = 320,
+		.yres           = 240,
+		.pixclock       = 7833600,
+		.left_margin    = 10,
+		.right_margin   = 10,
+		.upper_margin   = 10,
+		.lower_margin   = 10,
+		.hsync_len      = 10,
+		.vsync_len      = 10,
+		.sync           = 0,
+		.flag           = 0,
 	},
 };
 
@@ -728,7 +716,7 @@ static void lcd_calc_clk_divider(struct da8xx_fb_par *par)
 }
 
 static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
-		struct da8xx_panel *panel)
+		struct fb_videomode *panel)
 {
 	u32 bpp;
 	int ret = 0;
@@ -738,7 +726,7 @@ static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
 	/* Calculate the divider */
 	lcd_calc_clk_divider(par);
 
-	if (panel->invert_pxl_clk)
+	if (panel->sync & FB_SYNC_CLK_INVERT)
 		lcdc_write((lcdc_read(LCD_RASTER_TIMING_2_REG) |
 			LCD_INVERT_PIXEL_CLOCK), LCD_RASTER_TIMING_2_REG);
 	else
@@ -754,8 +742,10 @@ static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
 	lcd_cfg_ac_bias(cfg->ac_bias, cfg->ac_bias_intrpt);
 
 	/* Configure the vertical and horizontal sync properties. */
-	lcd_cfg_vertical_sync(panel->vbp, panel->vsw, panel->vfp);
-	lcd_cfg_horizontal_sync(panel->hbp, panel->hsw, panel->hfp);
+	lcd_cfg_vertical_sync(panel->lower_margin, panel->vsync_len,
+			panel->upper_margin);
+	lcd_cfg_horizontal_sync(panel->right_margin, panel->hsync_len,
+			panel->left_margin);
 
 	/* Configure for disply */
 	ret = lcd_cfg_display(cfg);
@@ -772,8 +762,8 @@ static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
 		bpp = cfg->p_disp_panel->max_bpp;
 	if (bpp = 12)
 		bpp = 16;
-	ret = lcd_cfg_frame_buffer(par, (unsigned int)panel->width,
-				(unsigned int)panel->height, bpp,
+	ret = lcd_cfg_frame_buffer(par, (unsigned int)panel->xres,
+				(unsigned int)panel->yres, bpp,
 				cfg->raster_order);
 	if (ret < 0)
 		return ret;
@@ -1235,7 +1225,7 @@ static int __devinit fb_probe(struct platform_device *device)
 	struct da8xx_lcdc_platform_data *fb_pdata  						device->dev.platform_data;
 	struct lcd_ctrl_config *lcd_cfg;
-	struct da8xx_panel *lcdc_info;
+	struct fb_videomode *lcdc_info;
 	struct fb_info *da8xx_fb_info;
 	struct clk *fb_clk = NULL;
 	struct da8xx_fb_par *par;
@@ -1323,7 +1313,7 @@ static int __devinit fb_probe(struct platform_device *device)
 #ifdef CONFIG_CPU_FREQ
 	par->lcd_fck_rate = clk_get_rate(fb_clk);
 #endif
-	par->pxl_clk = lcdc_info->pxl_clk;
+	par->pxl_clk = lcdc_info->pixclock;
 	if (fb_pdata->panel_power_ctrl) {
 		par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
 		par->panel_power_ctrl(1);
@@ -1336,8 +1326,8 @@ static int __devinit fb_probe(struct platform_device *device)
 	}
 
 	/* allocate frame buffer */
-	par->vram_size = lcdc_info->width * lcdc_info->height * lcd_cfg->bpp;
-	ulcm = lcm((lcdc_info->width * lcd_cfg->bpp)/8, PAGE_SIZE);
+	par->vram_size = lcdc_info->xres * lcdc_info->yres * lcd_cfg->bpp;
+	ulcm = lcm((lcdc_info->xres * lcd_cfg->bpp)/8, PAGE_SIZE);
 	par->vram_size = roundup(par->vram_size/8, ulcm);
 	par->vram_size = par->vram_size * LCD_NUM_BUFFERS;
 
@@ -1355,10 +1345,10 @@ static int __devinit fb_probe(struct platform_device *device)
 	da8xx_fb_info->screen_base = (char __iomem *) par->vram_virt;
 	da8xx_fb_fix.smem_start    = par->vram_phys;
 	da8xx_fb_fix.smem_len      = par->vram_size;
-	da8xx_fb_fix.line_length   = (lcdc_info->width * lcd_cfg->bpp) / 8;
+	da8xx_fb_fix.line_length   = (lcdc_info->xres * lcd_cfg->bpp) / 8;
 
 	par->dma_start = par->vram_phys;
-	par->dma_end   = par->dma_start + lcdc_info->height *
+	par->dma_end   = par->dma_start + lcdc_info->yres *
 		da8xx_fb_fix.line_length - 1;
 
 	/* allocate palette buffer */
@@ -1384,22 +1374,22 @@ static int __devinit fb_probe(struct platform_device *device)
 	/* Initialize par */
 	da8xx_fb_info->var.bits_per_pixel = lcd_cfg->bpp;
 
-	da8xx_fb_var.xres = lcdc_info->width;
-	da8xx_fb_var.xres_virtual = lcdc_info->width;
+	da8xx_fb_var.xres = lcdc_info->xres;
+	da8xx_fb_var.xres_virtual = lcdc_info->xres;
 
-	da8xx_fb_var.yres         = lcdc_info->height;
-	da8xx_fb_var.yres_virtual = lcdc_info->height * LCD_NUM_BUFFERS;
+	da8xx_fb_var.yres         = lcdc_info->yres;
+	da8xx_fb_var.yres_virtual = lcdc_info->yres * LCD_NUM_BUFFERS;
 
 	da8xx_fb_var.grayscale  	    lcd_cfg->p_disp_panel->panel_shade = MONOCHROME ? 1 : 0;
 	da8xx_fb_var.bits_per_pixel = lcd_cfg->bpp;
 
-	da8xx_fb_var.hsync_len = lcdc_info->hsw;
-	da8xx_fb_var.vsync_len = lcdc_info->vsw;
-	da8xx_fb_var.right_margin = lcdc_info->hfp;
-	da8xx_fb_var.left_margin  = lcdc_info->hbp;
-	da8xx_fb_var.lower_margin = lcdc_info->vfp;
-	da8xx_fb_var.upper_margin = lcdc_info->vbp;
+	da8xx_fb_var.hsync_len = lcdc_info->hsync_len;
+	da8xx_fb_var.vsync_len = lcdc_info->vsync_len;
+	da8xx_fb_var.right_margin = lcdc_info->right_margin;
+	da8xx_fb_var.left_margin  = lcdc_info->left_margin;
+	da8xx_fb_var.lower_margin = lcdc_info->lower_margin;
+	da8xx_fb_var.upper_margin = lcdc_info->upper_margin;
 	da8xx_fb_var.pixclock = da8xxfb_pixel_clk_period(par);
 
 	/* Initialize fbinfo */
diff --git a/include/video/da8xx-fb.h b/include/video/da8xx-fb.h
index 5a0e4f9..12e4e1d 100644
--- a/include/video/da8xx-fb.h
+++ b/include/video/da8xx-fb.h
@@ -103,5 +103,8 @@ struct lcd_sync_arg {
 #define FBIPUT_HSYNC		_IOW('F', 9, int)
 #define FBIPUT_VSYNC		_IOW('F', 10, int)
 
+/* Proprietary FB_SYNC_ flags */
+#define FB_SYNC_CLK_INVERT 0x40000000
+
 #endif  /* ifndef DA8XX_FB_H */
 
-- 
1.7.0.4

