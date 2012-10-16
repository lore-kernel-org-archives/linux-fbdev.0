From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 16 Oct 2012 05:05:16 +0000
Subject: [PATCH v2 2/2] da8xx-fb: cleanup LCDC configurations
Message-Id: <1350363196-9340-3-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Configure below LCDC configurations to optimal values, also have an
option configure these optional parameters for platform.
1) AC bias configuration: Required only for passive panels
2) Dma_burst_size:
3) FIFO_DMA_DELAY:
4) FIFO threshold: Does not apply for da830 LCDC.

Patch is verified for 16bpp and 24bpp configurations on da830, da850 and
am335x EVMs.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Since v1:
One of the patch in the series has changed, no change in this patch.

 arch/arm/mach-davinci/devices-da8xx.c |   22 +----------------
 drivers/video/da8xx-fb.c              |   43 +++++++++++++----------------=
----
 include/video/da8xx-fb.h              |   22 +----------------
 3 files changed, 19 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/=
devices-da8xx.c
index 783eab6..a61860a 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -524,29 +524,9 @@ void __init da8xx_register_mcasp(int id, struct snd_pl=
atform_data *pdata)
 	}
 }
=20
-static const struct display_panel disp_panel =3D {
-	QVGA,
-	16,
-	16,
-	COLOR_ACTIVE,
-};
-
 static struct lcd_ctrl_config lcd_cfg =3D {
-	&disp_panel,
-	.ac_bias		=3D 255,
-	.ac_bias_intrpt		=3D 0,
-	.dma_burst_sz		=3D 16,
+	.panel_shade		=3D COLOR_ACTIVE,
 	.bpp			=3D 16,
-	.fdd			=3D 255,
-	.tft_alt_mode		=3D 0,
-	.stn_565_mode		=3D 0,
-	.mono_8bit_mode		=3D 0,
-	.invert_line_clock	=3D 1,
-	.invert_frm_clock	=3D 1,
-	.sync_edge		=3D 0,
-	.sync_ctrl		=3D 1,
-	.raster_order		=3D 0,
-	.fifo_th		=3D 6,
 };
=20
 struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata =3D {
diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 90cf33a..f0f21c8 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -226,7 +226,8 @@ static struct fb_videomode known_lcd_panels[] =3D {
 		.lower_margin   =3D 2,
 		.hsync_len      =3D 0,
 		.vsync_len      =3D 0,
-		.sync           =3D FB_SYNC_CLK_INVERT,
+		.sync           =3D FB_SYNC_CLK_INVERT |
+			FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	},
 	/* Sharp LK043T1DG01 */
 	[1] =3D {
@@ -240,7 +241,7 @@ static struct fb_videomode known_lcd_panels[] =3D {
 		.lower_margin   =3D 2,
 		.hsync_len      =3D 41,
 		.vsync_len      =3D 10,
-		.sync           =3D 0,
+		.sync           =3D FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 		.flag           =3D 0,
 	},
 	[2] =3D {
@@ -255,7 +256,7 @@ static struct fb_videomode known_lcd_panels[] =3D {
 		.lower_margin   =3D 10,
 		.hsync_len      =3D 10,
 		.vsync_len      =3D 10,
-		.sync           =3D 0,
+		.sync           =3D FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 		.flag           =3D 0,
 	},
 };
@@ -387,10 +388,9 @@ static int lcd_cfg_dma(int burst_size, int fifo_th)
 		reg |=3D LCD_DMA_BURST_SIZE(LCD_DMA_BURST_8);
 		break;
 	case 16:
+	default:
 		reg |=3D LCD_DMA_BURST_SIZE(LCD_DMA_BURST_16);
 		break;
-	default:
-		return -EINVAL;
 	}
=20
 	reg |=3D (fifo_th << 8);
@@ -435,7 +435,8 @@ static void lcd_cfg_vertical_sync(int back_porch, int p=
ulse_width,
 	lcdc_write(reg, LCD_RASTER_TIMING_1_REG);
 }
=20
-static int lcd_cfg_display(const struct lcd_ctrl_config *cfg)
+static int lcd_cfg_display(const struct lcd_ctrl_config *cfg,
+		struct fb_videomode *panel)
 {
 	u32 reg;
 	u32 reg_int;
@@ -444,7 +445,7 @@ static int lcd_cfg_display(const struct lcd_ctrl_config=
 *cfg)
 						LCD_MONO_8BIT_MODE |
 						LCD_MONOCHROME_MODE);
=20
-	switch (cfg->p_disp_panel->panel_shade) {
+	switch (cfg->panel_shade) {
 	case MONOCHROME:
 		reg |=3D LCD_MONOCHROME_MODE;
 		if (cfg->mono_8bit_mode)
@@ -457,7 +458,9 @@ static int lcd_cfg_display(const struct lcd_ctrl_config=
 *cfg)
 		break;
=20
 	case COLOR_PASSIVE:
-		if (cfg->stn_565_mode)
+		/* AC bias applicable only for Pasive panels */
+		lcd_cfg_ac_bias(cfg->ac_bias, cfg->ac_bias_intrpt);
+		if (cfg->bpp =3D 12 && cfg->stn_565_mode)
 			reg |=3D LCD_STN_565_ENABLE;
 		break;
=20
@@ -478,22 +481,19 @@ static int lcd_cfg_display(const struct lcd_ctrl_conf=
ig *cfg)
=20
 	reg =3D lcdc_read(LCD_RASTER_TIMING_2_REG);
=20
-	if (cfg->sync_ctrl)
-		reg |=3D LCD_SYNC_CTRL;
-	else
-		reg &=3D ~LCD_SYNC_CTRL;
+	reg |=3D LCD_SYNC_CTRL;
=20
 	if (cfg->sync_edge)
 		reg |=3D LCD_SYNC_EDGE;
 	else
 		reg &=3D ~LCD_SYNC_EDGE;
=20
-	if (cfg->invert_line_clock)
+	if (panel->sync & FB_SYNC_HOR_HIGH_ACT)
 		reg |=3D LCD_INVERT_LINE_CLOCK;
 	else
 		reg &=3D ~LCD_INVERT_LINE_CLOCK;
=20
-	if (cfg->invert_frm_clock)
+	if (panel->sync & FB_SYNC_VERT_HIGH_ACT)
 		reg |=3D LCD_INVERT_FRAME_CLOCK;
 	else
 		reg &=3D ~LCD_INVERT_FRAME_CLOCK;
@@ -738,9 +738,6 @@ static int lcd_init(struct da8xx_fb_par *par, const str=
uct lcd_ctrl_config *cfg,
 	if (ret < 0)
 		return ret;
=20
-	/* Configure the AC bias properties. */
-	lcd_cfg_ac_bias(cfg->ac_bias, cfg->ac_bias_intrpt);
-
 	/* Configure the vertical and horizontal sync properties. */
 	lcd_cfg_vertical_sync(panel->lower_margin, panel->vsync_len,
 			panel->upper_margin);
@@ -748,18 +745,12 @@ static int lcd_init(struct da8xx_fb_par *par, const s=
truct lcd_ctrl_config *cfg,
 			panel->left_margin);
=20
 	/* Configure for disply */
-	ret =3D lcd_cfg_display(cfg);
+	ret =3D lcd_cfg_display(cfg, panel);
 	if (ret < 0)
 		return ret;
=20
-	if (QVGA !=3D cfg->p_disp_panel->panel_type)
-		return -EINVAL;
+	bpp =3D cfg->bpp;
=20
-	if (cfg->bpp <=3D cfg->p_disp_panel->max_bpp &&
-	    cfg->bpp >=3D cfg->p_disp_panel->min_bpp)
-		bpp =3D cfg->bpp;
-	else
-		bpp =3D cfg->p_disp_panel->max_bpp;
 	if (bpp =3D 12)
 		bpp =3D 16;
 	ret =3D lcd_cfg_frame_buffer(par, (unsigned int)panel->xres,
@@ -1381,7 +1372,7 @@ static int __devinit fb_probe(struct platform_device =
*device)
 	da8xx_fb_var.yres_virtual =3D lcdc_info->yres * LCD_NUM_BUFFERS;
=20
 	da8xx_fb_var.grayscale -	    lcd_cfg->p_disp_panel->panel_shade =3D MONOC=
HROME ? 1 : 0;
+	    lcd_cfg->panel_shade =3D MONOCHROME ? 1 : 0;
 	da8xx_fb_var.bits_per_pixel =3D lcd_cfg->bpp;
=20
 	da8xx_fb_var.hsync_len =3D lcdc_info->hsync_len;
diff --git a/include/video/da8xx-fb.h b/include/video/da8xx-fb.h
index 12e4e1d..f888259 100644
--- a/include/video/da8xx-fb.h
+++ b/include/video/da8xx-fb.h
@@ -12,10 +12,6 @@
 #ifndef DA8XX_FB_H
 #define DA8XX_FB_H
=20
-enum panel_type {
-	QVGA =3D 0
-};
-
 enum panel_shade {
 	MONOCHROME =3D 0,
 	COLOR_ACTIVE,
@@ -27,13 +23,6 @@ enum raster_load_mode {
 	LOAD_PALETTE,
 };
=20
-struct display_panel {
-	enum panel_type panel_type; /* QVGA */
-	int max_bpp;
-	int min_bpp;
-	enum panel_shade panel_shade;
-};
-
 struct da8xx_lcdc_platform_data {
 	const char manu_name[10];
 	void *controller_data;
@@ -42,7 +31,7 @@ struct da8xx_lcdc_platform_data {
 };
=20
 struct lcd_ctrl_config {
-	const struct display_panel *p_disp_panel;
+	enum panel_shade panel_shade;
=20
 	/* AC Bias Pin Frequency */
 	int ac_bias;
@@ -68,18 +57,9 @@ struct lcd_ctrl_config {
 	/* Mono 8-bit Mode: 1=D0-D7 or 0=D0-D3 */
 	unsigned char mono_8bit_mode;
=20
-	/* Invert line clock */
-	unsigned char invert_line_clock;
-
-	/* Invert frame clock  */
-	unsigned char invert_frm_clock;
-
 	/* Horizontal and Vertical Sync Edge: 0=3Drising 1=FAlling */
 	unsigned char sync_edge;
=20
-	/* Horizontal and Vertical Sync: Control: 0=3Dignore */
-	unsigned char sync_ctrl;
-
 	/* Raster Data Order Select: 1=3DMost-to-least 0=3DLeast-to-most */
 	unsigned char raster_order;
=20
--=20
1.7.0.4

