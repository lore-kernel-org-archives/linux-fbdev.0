From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Fri, 05 Oct 2012 14:03:23 +0000
Subject: [PATCH 1/2] da8xx-fb: move panel information from driver to platform file
Message-Id: <1349445084-9857-2-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Moving panel information from driver to platform file, patch also made
compliant to fb_videomode data.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |   32 +++++++-
 drivers/video/da8xx-fb.c              |  127 ++++++++-------------------------
 include/video/da8xx-fb.h              |    8 ++-
 3 files changed, 64 insertions(+), 103 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 783eab6..12a47cd 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -550,15 +550,39 @@ static struct lcd_ctrl_config lcd_cfg = {
 };
 
 struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata = {
-	.manu_name		= "sharp",
 	.controller_data	= &lcd_cfg,
-	.type			= "Sharp_LCD035Q3DG01",
+	.fb_videomode           = {
+		.name		= "Sharp_LCD035Q3DG01",
+		.xres		= 320,
+		.yres		= 240,
+		.pixclock	= 4608000,
+		.left_margin	= 6,
+		.right_margin	= 8,
+		.upper_margin	= 2,
+		.lower_margin	= 2,
+		.hsync_len	= 0,
+		.vsync_len	= 0,
+		.sync		= FB_SYNC_CLK_INVERT,
+		.flag		= 0,
+	},
 };
 
 struct da8xx_lcdc_platform_data sharp_lk043t1dg01_pdata = {
-	.manu_name		= "sharp",
 	.controller_data	= &lcd_cfg,
-	.type			= "Sharp_LK043T1DG01",
+	.fb_videomode		= {
+		.name		= "Sharp_LK043T1DG01",
+		.xres		= 480,
+		.yres		= 272,
+		.pixclock	= 7833600,
+		.left_margin	= 2,
+		.right_margin	= 2,
+		.upper_margin	= 2,
+		.lower_margin	= 2,
+		.hsync_len	= 41,
+		.vsync_len	= 10,
+		.sync		= 0,
+		.flag		= 0,
+	},
 };
 
 static struct resource da8xx_lcdc_resources[] = {
diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 65a11ef..bacf82b 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -21,7 +21,6 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/fb.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
@@ -213,65 +212,6 @@ static struct fb_fix_screeninfo da8xx_fb_fix __devinitdata = {
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
-	/* Sharp LCD035Q3DG01 */
-	[0] = {
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
-	},
-	/* Sharp LK043T1DG01 */
-	[1] = {
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
-	},
-	[2] = {
-		/* Hitachi SP10Q010 */
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
-	},
-};
-
 /* Enable the Raster Engine of the LCD Controller */
 static inline void lcd_enable_raster(void)
 {
@@ -728,7 +668,7 @@ static void lcd_calc_clk_divider(struct da8xx_fb_par *par)
 }
 
 static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
-		struct da8xx_panel *panel)
+		struct fb_videomode *panel)
 {
 	u32 bpp;
 	int ret = 0;
@@ -738,7 +678,7 @@ static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
 	/* Calculate the divider */
 	lcd_calc_clk_divider(par);
 
-	if (panel->invert_pxl_clk)
+	if (panel->sync & FB_SYNC_CLK_INVERT)
 		lcdc_write((lcdc_read(LCD_RASTER_TIMING_2_REG) |
 			LCD_INVERT_PIXEL_CLOCK), LCD_RASTER_TIMING_2_REG);
 	else
@@ -754,8 +694,10 @@ static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
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
@@ -772,8 +714,8 @@ static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
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
@@ -1235,12 +1177,12 @@ static int __devinit fb_probe(struct platform_device *device)
 	struct da8xx_lcdc_platform_data *fb_pdata  						device->dev.platform_data;
 	struct lcd_ctrl_config *lcd_cfg;
-	struct da8xx_panel *lcdc_info;
+	struct fb_videomode *lcd_panel_info;
 	struct fb_info *da8xx_fb_info;
 	struct clk *fb_clk = NULL;
 	struct da8xx_fb_par *par;
 	resource_size_t len;
-	int ret, i;
+	int ret;
 	unsigned long ulcm;
 
 	if (fb_pdata = NULL) {
@@ -1293,20 +1235,10 @@ static int __devinit fb_probe(struct platform_device *device)
 		break;
 	}
 
-	for (i = 0, lcdc_info = known_lcd_panels;
-		i < ARRAY_SIZE(known_lcd_panels);
-		i++, lcdc_info++) {
-		if (strcmp(fb_pdata->type, lcdc_info->name) = 0)
-			break;
-	}
+	lcd_panel_info = &fb_pdata->fb_videomode;
 
-	if (i = ARRAY_SIZE(known_lcd_panels)) {
-		dev_err(&device->dev, "GLCD: No valid panel found\n");
-		ret = -ENODEV;
-		goto err_pm_runtime_disable;
-	} else
-		dev_info(&device->dev, "GLCD: Found %s panel\n",
-					fb_pdata->type);
+	dev_info(&device->dev, "Configuring GLCD %s panel\n",
+			lcd_panel_info->name);
 
 	lcd_cfg = (struct lcd_ctrl_config *)fb_pdata->controller_data;
 
@@ -1323,21 +1255,22 @@ static int __devinit fb_probe(struct platform_device *device)
 #ifdef CONFIG_CPU_FREQ
 	par->lcd_fck_rate = clk_get_rate(fb_clk);
 #endif
-	par->pxl_clk = lcdc_info->pxl_clk;
+	par->pxl_clk = lcd_panel_info->pixclock;
 	if (fb_pdata->panel_power_ctrl) {
 		par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
 		par->panel_power_ctrl(1);
 	}
 
-	if (lcd_init(par, lcd_cfg, lcdc_info) < 0) {
+	if (lcd_init(par, lcd_cfg, lcd_panel_info) < 0) {
 		dev_err(&device->dev, "lcd_init failed\n");
 		ret = -EFAULT;
 		goto err_release_fb;
 	}
 
 	/* allocate frame buffer */
-	par->vram_size = lcdc_info->width * lcdc_info->height * lcd_cfg->bpp;
-	ulcm = lcm((lcdc_info->width * lcd_cfg->bpp)/8, PAGE_SIZE);
+	par->vram_size +		lcd_panel_info->xres * lcd_panel_info->yres * lcd_cfg->bpp;
+	ulcm = lcm((lcd_panel_info->xres * lcd_cfg->bpp)/8, PAGE_SIZE);
 	par->vram_size = roundup(par->vram_size/8, ulcm);
 	par->vram_size = par->vram_size * LCD_NUM_BUFFERS;
 
@@ -1355,10 +1288,10 @@ static int __devinit fb_probe(struct platform_device *device)
 	da8xx_fb_info->screen_base = (char __iomem *) par->vram_virt;
 	da8xx_fb_fix.smem_start    = par->vram_phys;
 	da8xx_fb_fix.smem_len      = par->vram_size;
-	da8xx_fb_fix.line_length   = (lcdc_info->width * lcd_cfg->bpp) / 8;
+	da8xx_fb_fix.line_length   = (lcd_panel_info->xres * lcd_cfg->bpp) / 8;
 
 	par->dma_start = par->vram_phys;
-	par->dma_end   = par->dma_start + lcdc_info->height *
+	par->dma_end   = par->dma_start + lcd_panel_info->yres *
 		da8xx_fb_fix.line_length - 1;
 
 	/* allocate palette buffer */
@@ -1384,22 +1317,22 @@ static int __devinit fb_probe(struct platform_device *device)
 	/* Initialize par */
 	da8xx_fb_info->var.bits_per_pixel = lcd_cfg->bpp;
 
-	da8xx_fb_var.xres = lcdc_info->width;
-	da8xx_fb_var.xres_virtual = lcdc_info->width;
+	da8xx_fb_var.xres = lcd_panel_info->xres;
+	da8xx_fb_var.xres_virtual = lcd_panel_info->yres;
 
-	da8xx_fb_var.yres         = lcdc_info->height;
-	da8xx_fb_var.yres_virtual = lcdc_info->height * LCD_NUM_BUFFERS;
+	da8xx_fb_var.yres         = lcd_panel_info->yres;
+	da8xx_fb_var.yres_virtual = lcd_panel_info->yres * LCD_NUM_BUFFERS;
 
 	da8xx_fb_var.grayscale  	    lcd_cfg->p_disp_panel->panel_shade = MONOCHROME ? 1 : 0;
 	da8xx_fb_var.bits_per_pixel = lcd_cfg->bpp;
 
-	da8xx_fb_var.hsync_len = lcdc_info->hsw;
-	da8xx_fb_var.vsync_len = lcdc_info->vsw;
-	da8xx_fb_var.right_margin = lcdc_info->hfp;
-	da8xx_fb_var.left_margin  = lcdc_info->hbp;
-	da8xx_fb_var.lower_margin = lcdc_info->vfp;
-	da8xx_fb_var.upper_margin = lcdc_info->vbp;
+	da8xx_fb_var.hsync_len = lcd_panel_info->hsync_len;
+	da8xx_fb_var.vsync_len = lcd_panel_info->vsync_len;
+	da8xx_fb_var.right_margin = lcd_panel_info->left_margin;
+	da8xx_fb_var.left_margin  = lcd_panel_info->right_margin;
+	da8xx_fb_var.lower_margin = lcd_panel_info->upper_margin;
+	da8xx_fb_var.upper_margin = lcd_panel_info->lower_margin;
 	da8xx_fb_var.pixclock = da8xxfb_pixel_clk_period(par);
 
 	/* Initialize fbinfo */
diff --git a/include/video/da8xx-fb.h b/include/video/da8xx-fb.h
index 5a0e4f9..a6796ff 100644
--- a/include/video/da8xx-fb.h
+++ b/include/video/da8xx-fb.h
@@ -12,6 +12,8 @@
 #ifndef DA8XX_FB_H
 #define DA8XX_FB_H
 
+#include <linux/fb.h>
+
 enum panel_type {
 	QVGA = 0
 };
@@ -35,10 +37,9 @@ struct display_panel {
 };
 
 struct da8xx_lcdc_platform_data {
-	const char manu_name[10];
 	void *controller_data;
-	const char type[25];
 	void (*panel_power_ctrl)(int);
+	struct fb_videomode fb_videomode;
 };
 
 struct lcd_ctrl_config {
@@ -103,5 +104,8 @@ struct lcd_sync_arg {
 #define FBIPUT_HSYNC		_IOW('F', 9, int)
 #define FBIPUT_VSYNC		_IOW('F', 10, int)
 
+/* Proprietary FB_SYNC_ flags */
+#define FB_SYNC_CLK_INVERT 0x40000000
+
 #endif  /* ifndef DA8XX_FB_H */
 
-- 
1.7.0.4

