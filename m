From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 18 Jul 2012 05:59:21 +0000
Subject: [PATCH v2] video: da8xx-fb: add 24bpp LCD configuration support
Message-Id: <1342590441-8441-1-git-send-email-prakash.pm@ti.com>
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
Since v1:
Addressed Tobias's review comments on calculation of pseudopalette for
FB_VISUAL_TRUECOLOR type.

 drivers/video/da8xx-fb.c |   88 ++++++++++++++++++++++++++++-----------------
 1 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 47118c7..3cda461 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -153,7 +153,7 @@ struct da8xx_fb_par {
 	unsigned int		dma_end;
 	struct clk *lcdc_clk;
 	int irq;
-	unsigned short pseudo_palette[16];
+	u32 pseudo_palette[16];
 	unsigned int palette_sz;
 	unsigned int pxl_clk;
 	int blank;
@@ -546,6 +546,8 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
 	return 0;
 }
 
+
+#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)
 static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			      unsigned blue, unsigned transp,
 			      struct fb_info *info)
@@ -561,13 +563,33 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	if (info->fix.visual = FB_VISUAL_DIRECTCOLOR)
 		return 1;
 
-	if (info->var.bits_per_pixel = 4) {
-		if (regno > 15)
-			return 1;
+	switch (info->fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		red = CNVT_TOHW(red, info->var.red.length);
+		green = CNVT_TOHW(green, info->var.green.length);
+		blue = CNVT_TOHW(blue, info->var.blue.length);
+		break;
+	case FB_VISUAL_PSEUDOCOLOR:
+		if (info->var.bits_per_pixel = 4) {
+			if (regno > 15)
+				return 1;
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
 
-		if (info->var.grayscale) {
-			pal = regno;
-		} else {
+		} else if (info->var.bits_per_pixel = 8) {
 			red >>= 4;
 			green >>= 8;
 			blue >>= 12;
@@ -575,36 +597,35 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
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
-
-		pal = (red & 0x0f00);
-		pal |= (green & 0x00f0);
-		pal |= (blue & 0x000f);
 
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
@@ -617,6 +638,7 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 
 	return 0;
 }
+#undef CNVT_TOHW
 
 static void lcd_reset(struct da8xx_fb_par *par)
 {
-- 
1.7.1

