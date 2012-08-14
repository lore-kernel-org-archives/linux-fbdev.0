From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 14 Aug 2012 13:33:42 +0000
Subject: [PATCH v5] da8xx-fb: add 24bpp LCD configuration support
Message-Id: <1344950502-18835-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

LCD controller on am335x supports 24bpp raster configuration in addition
to ones on da850. LCDC also supports 24bpp in unpacked format having
ARGB:8888 32bpp format data in DDR, but it doesn't interpret alpha
component of the data.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Cc: Anatolij Gustschin <agust@denx.de>
---
Applies on top of fbdev-next of Florian Tobias Schandinat's tree.
Since v4:
Re-define CNVT_TOHW macro.
Since v3:
Minor nit, declare pseudo_palette as u32 type.
Since v2:
Fixed additional configurations for 24bpp support.
Since v1:
Simplified calculation of pseudopalette for FB_VISUAL_TRUECOLOR type.

 drivers/video/da8xx-fb.c |  132 +++++++++++++++++++++++++++++++++------------
 1 files changed, 97 insertions(+), 35 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index cb696ff..5c6df7b 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -87,6 +87,8 @@
 #define LCD_V2_LIDD_CLK_EN		BIT(1)
 #define LCD_V2_CORE_CLK_EN		BIT(0)
 #define LCD_V2_LPP_B10			26
+#define LCD_V2_TFT_24BPP_MODE		BIT(25)
+#define LCD_V2_TFT_24BPP_UNPACK		BIT(26)
 
 /* LCD Raster Timing 2 Register */
 #define LCD_AC_BIAS_TRANSITIONS_PER_INT(x)	((x) << 16)
@@ -157,7 +159,6 @@ struct da8xx_fb_par {
 	unsigned int		dma_end;
 	struct clk *lcdc_clk;
 	int irq;
-	unsigned short pseudo_palette[16];
 	unsigned int palette_sz;
 	unsigned int pxl_clk;
 	int blank;
@@ -176,6 +177,7 @@ struct da8xx_fb_par {
 	unsigned int		lcd_fck_rate;
 #endif
 	void (*panel_power_ctrl)(int);
+	u32 pseudo_palette[16];
 };
 
 /* Variable Screen Information */
@@ -528,6 +530,9 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
 {
 	u32 reg;
 
+	if (bpp > 16 && lcd_revision = LCD_VERSION_1)
+		return -EINVAL;
+
 	/* Set the Panel Width */
 	/* Pixels per line = (PPL + 1)*16 */
 	if (lcd_revision = LCD_VERSION_1) {
@@ -571,14 +576,19 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
 	reg = lcdc_read(LCD_RASTER_CTRL_REG) & ~(1 << 8);
 	if (raster_order)
 		reg |= LCD_RASTER_ORDER;
-	lcdc_write(reg, LCD_RASTER_CTRL_REG);
+
+	par->palette_sz = 16 * 2;
 
 	switch (bpp) {
 	case 1:
 	case 2:
 	case 4:
 	case 16:
-		par->palette_sz = 16 * 2;
+		break;
+	case 24:
+		reg |= LCD_V2_TFT_24BPP_MODE;
+	case 32:
+		reg |= LCD_V2_TFT_24BPP_UNPACK;
 		break;
 
 	case 8:
@@ -589,9 +599,12 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
 		return -EINVAL;
 	}
 
+	lcdc_write(reg, LCD_RASTER_CTRL_REG);
+
 	return 0;
 }
 
+#define CNVT_TOHW(val, width) ((((val) << (width)) + 0x7FFF - (val)) >> 16)
 static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			      unsigned blue, unsigned transp,
 			      struct fb_info *info)
@@ -607,13 +620,38 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	if (info->fix.visual = FB_VISUAL_DIRECTCOLOR)
 		return 1;
 
-	if (info->var.bits_per_pixel = 4) {
-		if (regno > 15)
-			return 1;
+	if (info->var.bits_per_pixel > 16 && lcd_revision = LCD_VERSION_1)
+		return -EINVAL;
 
-		if (info->var.grayscale) {
-			pal = regno;
-		} else {
+	switch (info->fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		red = CNVT_TOHW(red, info->var.red.length);
+		green = CNVT_TOHW(green, info->var.green.length);
+		blue = CNVT_TOHW(blue, info->var.blue.length);
+		break;
+	case FB_VISUAL_PSEUDOCOLOR:
+		switch (info->var.bits_per_pixel) {
+		case 4:
+			if (regno > 15)
+				return -EINVAL;
+
+			if (info->var.grayscale) {
+				pal = regno;
+			} else {
+				red >>= 4;
+				green >>= 8;
+				blue >>= 12;
+
+				pal = red & 0x0f00;
+				pal |= green & 0x00f0;
+				pal |= blue & 0x000f;
+			}
+			if (regno = 0)
+				pal |= 0x2000;
+			palette[regno] = pal;
+			break;
+
+		case 8:
 			red >>= 4;
 			green >>= 8;
 			blue >>= 12;
@@ -621,36 +659,36 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			pal = (red & 0x0f00);
 			pal |= (green & 0x00f0);
 			pal |= (blue & 0x000f);
-		}
-		if (regno = 0)
-			pal |= 0x2000;
-		palette[regno] = pal;
 
-	} else if (info->var.bits_per_pixel = 8) {
-		red >>= 4;
-		green >>= 8;
-		blue >>= 12;
-
-		pal = (red & 0x0f00);
-		pal |= (green & 0x00f0);
-		pal |= (blue & 0x000f);
-
-		if (palette[regno] != pal) {
-			update_hw = 1;
-			palette[regno] = pal;
+			if (palette[regno] != pal) {
+				update_hw = 1;
+				palette[regno] = pal;
+			}
+			break;
 		}
-	} else if ((info->var.bits_per_pixel = 16) && regno < 16) {
-		red >>= (16 - info->var.red.length);
-		red <<= info->var.red.offset;
+		break;
+	}
 
-		green >>= (16 - info->var.green.length);
-		green <<= info->var.green.offset;
+	/* Truecolor has hardware independent palette */
+	if (info->fix.visual = FB_VISUAL_TRUECOLOR) {
+		u32 v;
 
-		blue >>= (16 - info->var.blue.length);
-		blue <<= info->var.blue.offset;
+		if (regno > 15)
+			return -EINVAL;
 
-		par->pseudo_palette[regno] = red | green | blue;
+		v = (red << info->var.red.offset) |
+			(green << info->var.green.offset) |
+			(blue << info->var.blue.offset);
 
+		switch (info->var.bits_per_pixel) {
+		case 16:
+			((u16 *) (info->pseudo_palette))[regno] = v;
+			break;
+		case 24:
+		case 32:
+			((u32 *) (info->pseudo_palette))[regno] = v;
+			break;
+		}
 		if (palette[0] != 0x4000) {
 			update_hw = 1;
 			palette[0] = 0x4000;
@@ -663,6 +701,7 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 
 	return 0;
 }
+#undef CNVT_TOHW
 
 static void lcd_reset(struct da8xx_fb_par *par)
 {
@@ -871,6 +910,9 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 {
 	int err = 0;
 
+	if (var->bits_per_pixel > 16 && lcd_revision = LCD_VERSION_1)
+		return -EINVAL;
+
 	switch (var->bits_per_pixel) {
 	case 1:
 	case 8:
@@ -906,6 +948,26 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 		var->transp.length = 0;
 		var->nonstd = 0;
 		break;
+	case 24:
+		var->red.offset = 16;
+		var->red.length = 8;
+		var->green.offset = 8;
+		var->green.length = 8;
+		var->blue.offset = 0;
+		var->blue.length = 8;
+		var->nonstd = 0;
+		break;
+	case 32:
+		var->transp.offset = 24;
+		var->transp.length = 8;
+		var->red.offset = 16;
+		var->red.length = 8;
+		var->green.offset = 8;
+		var->green.length = 8;
+		var->blue.offset = 0;
+		var->blue.length = 8;
+		var->nonstd = 0;
+		break;
 	default:
 		err = -EINVAL;
 	}
-- 
1.7.1

