From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:43 +0000
Subject: [PATCH 08/19] fbdev: sh_mipi_dsi: Use the LCDC entity default mode
Message-Id: <1345122054-16013-9-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Configure the MIPI-DSI transmitter using the LCDC entity default mode
instead of accessing the mode through the LCDC platform data.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mipi_dsi.c |   43 ++++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 7f6ce65..f88b204 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -127,9 +127,10 @@ static void sh_mipi_shutdown(struct platform_device *pdev)
 	sh_mipi_dsi_enable(mipi, false);
 }
 
-static int sh_mipi_setup(struct sh_mipi *mipi, struct sh_mipi_dsi_info *pdata)
+static int sh_mipi_setup(struct sh_mipi *mipi, const struct fb_videomode *mode)
 {
 	void __iomem *base = mipi->base;
+	struct sh_mipi_dsi_info *pdata = mipi->pdev->dev.platform_data;
 	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
 	u32 pctype, datatype, pixfmt, linelength, vmctr2;
 	u32 tmp, top, bottom, delay, div;
@@ -146,77 +147,77 @@ static int sh_mipi_setup(struct sh_mipi *mipi, struct sh_mipi_dsi_info *pdata)
 		pctype = 0;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_24;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
-		linelength = ch->lcd_modes[0].xres * 3;
+		linelength = mode->xres * 3;
 		yuv = false;
 		break;
 	case MIPI_RGB565:
 		pctype = 1;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
-		linelength = ch->lcd_modes[0].xres * 2;
+		linelength = mode->xres * 2;
 		yuv = false;
 		break;
 	case MIPI_RGB666_LP:
 		pctype = 2;
 		datatype = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
-		linelength = ch->lcd_modes[0].xres * 3;
+		linelength = mode->xres * 3;
 		yuv = false;
 		break;
 	case MIPI_RGB666:
 		pctype = 3;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_18BIT;
-		linelength = (ch->lcd_modes[0].xres * 18 + 7) / 8;
+		linelength = (mode->xres * 18 + 7) / 8;
 		yuv = false;
 		break;
 	case MIPI_BGR888:
 		pctype = 8;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_24;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
-		linelength = ch->lcd_modes[0].xres * 3;
+		linelength = mode->xres * 3;
 		yuv = false;
 		break;
 	case MIPI_BGR565:
 		pctype = 9;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
-		linelength = ch->lcd_modes[0].xres * 2;
+		linelength = mode->xres * 2;
 		yuv = false;
 		break;
 	case MIPI_BGR666_LP:
 		pctype = 0xa;
 		datatype = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
-		linelength = ch->lcd_modes[0].xres * 3;
+		linelength = mode->xres * 3;
 		yuv = false;
 		break;
 	case MIPI_BGR666:
 		pctype = 0xb;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_18BIT;
-		linelength = (ch->lcd_modes[0].xres * 18 + 7) / 8;
+		linelength = (mode->xres * 18 + 7) / 8;
 		yuv = false;
 		break;
 	case MIPI_YUYV:
 		pctype = 4;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
-		linelength = ch->lcd_modes[0].xres * 2;
+		linelength = mode->xres * 2;
 		yuv = true;
 		break;
 	case MIPI_UYVY:
 		pctype = 5;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
-		linelength = ch->lcd_modes[0].xres * 2;
+		linelength = mode->xres * 2;
 		yuv = true;
 		break;
 	case MIPI_YUV420_L:
 		pctype = 6;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR12;
 		pixfmt = MIPI_DCS_PIXEL_FMT_12BIT;
-		linelength = (ch->lcd_modes[0].xres * 12 + 7) / 8;
+		linelength = (mode->xres * 12 + 7) / 8;
 		yuv = true;
 		break;
 	case MIPI_YUV420:
@@ -224,7 +225,7 @@ static int sh_mipi_setup(struct sh_mipi *mipi, struct sh_mipi_dsi_info *pdata)
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR12;
 		pixfmt = MIPI_DCS_PIXEL_FMT_12BIT;
 		/* Length of U/V line */
-		linelength = (ch->lcd_modes[0].xres + 1) / 2;
+		linelength = (mode->xres + 1) / 2;
 		yuv = true;
 		break;
 	default:
@@ -293,7 +294,7 @@ static int sh_mipi_setup(struct sh_mipi *mipi, struct sh_mipi_dsi_info *pdata)
 	 */
 	iowrite32(0x00000006, mipi->linkbase + DTCTR);
 	/* VSYNC width = 2 (<< 17) */
-	iowrite32((ch->lcd_modes[0].vsync_len << pdata->vsynw_offset) |
+	iowrite32((mode->vsync_len << pdata->vsynw_offset) |
 		  (pdata->clksrc << 16) | (pctype << 12) | datatype,
 		  mipi->linkbase + VMCTR1);
 
@@ -327,7 +328,7 @@ static int sh_mipi_setup(struct sh_mipi *mipi, struct sh_mipi_dsi_info *pdata)
 	top = linelength << 16; /* RGBLEN */
 	bottom = 0x00000001;
 	if (pdata->flags & SH_MIPI_DSI_HSABM) /* HSALEN */
-		bottom = (pdata->lane * ch->lcd_modes[0].hsync_len) - 10;
+		bottom = (pdata->lane * mode->hsync_len) - 10;
 	iowrite32(top | bottom , mipi->linkbase + VMLEN1);
 
 	/*
@@ -347,18 +348,18 @@ static int sh_mipi_setup(struct sh_mipi *mipi, struct sh_mipi_dsi_info *pdata)
 		div = 2;
 
 	if (pdata->flags & SH_MIPI_DSI_HFPBM) {	/* HBPLEN */
-		top = ch->lcd_modes[0].hsync_len + ch->lcd_modes[0].left_margin;
+		top = mode->hsync_len + mode->left_margin;
 		top = ((pdata->lane * top / div) - 10) << 16;
 	}
 	if (pdata->flags & SH_MIPI_DSI_HBPBM) { /* HFPLEN */
-		bottom = ch->lcd_modes[0].right_margin;
+		bottom = mode->right_margin;
 		bottom = (pdata->lane * bottom / div) - 12;
 	}
 
-	bpp = linelength / ch->lcd_modes[0].xres; /* byte / pixel */
+	bpp = linelength / mode->xres; /* byte / pixel */
 	if ((pdata->lane / div) > bpp) {
-		tmp = ch->lcd_modes[0].xres / bpp; /* output cycle */
-		tmp = ch->lcd_modes[0].xres - tmp; /* (input - output) cycle */
+		tmp = mode->xres / bpp; /* output cycle */
+		tmp = mode->xres - tmp; /* (input - output) cycle */
 		delay = (pdata->lane * tmp);
 	}
 
@@ -405,7 +406,7 @@ static int mipi_display_on(struct sh_mobile_lcdc_entity *entity)
 	if (ret < 0)
 		goto mipi_display_on_fail1;
 
-	ret = sh_mipi_setup(mipi, pdata);
+	ret = sh_mipi_setup(mipi, &entity->def_mode);
 	if (ret < 0)
 		goto mipi_display_on_fail2;
 
-- 
1.7.8.6

