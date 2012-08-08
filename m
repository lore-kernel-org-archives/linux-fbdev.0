From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 08 Aug 2012 15:47:45 +0000
Subject: [PATCH v4] da8xx-fb: add 24bpp LCD configuration support
Message-Id: <1344440145-27117-1-git-send-email-prakash.pm@ti.com>
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
Patch is dependent on earlier submitted patch "video: move CNVT_TOHW to a common place"[1]
Since v3:
Minor nit, declare pseudo_palette as u32 type.
Since v2:
Fixed additional configurations for 24bpp support.
Since v1:
Simplified calculation of pseudopalette for FB_VISUAL_TRUECOLOR type.

[1] http://marc.info/?l=linux-fbdev&m4442816627846&w=2

 drivers/video/da8xx-fb.c |  124 +++++++++++++++++++++++++++++++++------------
 1 files changed, 91 insertions(+), 33 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 7ae9d53..1abcfa9 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -86,6 +86,8 @@
 #define LCD_V2_LIDD_CLK_EN		BIT(1)
 #define LCD_V2_CORE_CLK_EN		BIT(0)
 #define LCD_V2_LPP_B10			26
+#define LCD_V2_TFT_24BPP_MODE		BIT(25)
+#define LCD_V2_TFT_24BPP_UNPACK		BIT(26)
 
 /* LCD Raster Timing 2 Register */
 #define LCD_AC_BIAS_TRANSITIONS_PER_INT(x)	((x) << 16)
@@ -156,7 +158,6 @@ struct da8xx_fb_par {
 	unsigned int		dma_end;
 	struct clk *lcdc_clk;
 	int irq;
-	unsigned short pseudo_palette[16];
 	unsigned int palette_sz;
 	unsigned int pxl_clk;
 	int blank;
@@ -175,6 +176,7 @@ struct da8xx_fb_par {
 	unsigned int		lcd_fck_rate;
 #endif
 	void (*panel_power_ctrl)(int);
+	u32 pseudo_palette[16];
 };
 
 /* Variable Screen Information */
@@ -499,6 +501,9 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
 {
 	u32 reg;
 
+	if ((bpp > 16) && (lcd_revision = LCD_VERSION_1))
+		return -EINVAL;
+
 	/* Set the Panel Width */
 	/* Pixels per line = (PPL + 1)*16 */
 	if (lcd_revision = LCD_VERSION_1) {
@@ -542,6 +547,12 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
 	reg = lcdc_read(LCD_RASTER_CTRL_REG) & ~(1 << 8);
 	if (raster_order)
 		reg |= LCD_RASTER_ORDER;
+
+	if (bpp = 24)
+		reg |= LCD_V2_TFT_24BPP_MODE;
+	else if (bpp = 32)
+		reg |= (LCD_V2_TFT_24BPP_MODE | LCD_V2_TFT_24BPP_UNPACK);
+
 	lcdc_write(reg, LCD_RASTER_CTRL_REG);
 
 	switch (bpp) {
@@ -549,6 +560,8 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
 	case 2:
 	case 4:
 	case 16:
+	case 24:
+	case 32:
 		par->palette_sz = 16 * 2;
 		break;
 
@@ -578,13 +591,36 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	if (info->fix.visual = FB_VISUAL_DIRECTCOLOR)
 		return 1;
 
-	if (info->var.bits_per_pixel = 4) {
-		if (regno > 15)
-			return 1;
+	if ((info->var.bits_per_pixel > 16) && (lcd_revision = LCD_VERSION_1))
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
+		if (info->var.bits_per_pixel = 4) {
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
+				pal = (red & 0x0f00);
+				pal |= (green & 0x00f0);
+				pal |= (blue & 0x000f);
+			}
+			if (regno = 0)
+				pal |= 0x2000;
+			palette[regno] = pal;
+
+		} else if (info->var.bits_per_pixel = 8) {
 			red >>= 4;
 			green >>= 8;
 			blue >>= 12;
@@ -592,36 +628,35 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			pal = (red & 0x0f00);
 			pal |= (green & 0x00f0);
 			pal |= (blue & 0x000f);
-		}
-		if (regno = 0)
-			pal |= 0x2000;
-		palette[regno] = pal;
-
-	} else if (info->var.bits_per_pixel = 8) {
-		red >>= 4;
-		green >>= 8;
-		blue >>= 12;
 
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
@@ -842,6 +877,9 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 {
 	int err = 0;
 
+	if ((var->bits_per_pixel > 16) && (lcd_revision = LCD_VERSION_1))
+		return -EINVAL;
+
 	switch (var->bits_per_pixel) {
 	case 1:
 	case 8:
@@ -877,6 +915,26 @@ static int fb_check_var(struct fb_var_screeninfo *var,
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

