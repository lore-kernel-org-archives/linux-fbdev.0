From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:44 +0000
Subject: [PATCH 09/19] fbdev: sh_mipi_dsi: Remove last reference to LCDC platform data
Message-Id: <1345122054-16013-10-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The format check that references LCDC platform data isn't needed, as the
mismatch between LCDC and MIPI-DSI platform it detects would result in a
badly displayed image, which isn't worse than a complete failure to
setup the transmitter.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mipi_dsi.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index f88b204..f496229 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -131,10 +131,8 @@ static int sh_mipi_setup(struct sh_mipi *mipi, const struct fb_videomode *mode)
 {
 	void __iomem *base = mipi->base;
 	struct sh_mipi_dsi_info *pdata = mipi->pdev->dev.platform_data;
-	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
 	u32 pctype, datatype, pixfmt, linelength, vmctr2;
 	u32 tmp, top, bottom, delay, div;
-	bool yuv;
 	int bpp;
 
 	/*
@@ -148,77 +146,66 @@ static int sh_mipi_setup(struct sh_mipi *mipi, const struct fb_videomode *mode)
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_24;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
 		linelength = mode->xres * 3;
-		yuv = false;
 		break;
 	case MIPI_RGB565:
 		pctype = 1;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
 		linelength = mode->xres * 2;
-		yuv = false;
 		break;
 	case MIPI_RGB666_LP:
 		pctype = 2;
 		datatype = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
 		linelength = mode->xres * 3;
-		yuv = false;
 		break;
 	case MIPI_RGB666:
 		pctype = 3;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_18BIT;
 		linelength = (mode->xres * 18 + 7) / 8;
-		yuv = false;
 		break;
 	case MIPI_BGR888:
 		pctype = 8;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_24;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
 		linelength = mode->xres * 3;
-		yuv = false;
 		break;
 	case MIPI_BGR565:
 		pctype = 9;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
 		linelength = mode->xres * 2;
-		yuv = false;
 		break;
 	case MIPI_BGR666_LP:
 		pctype = 0xa;
 		datatype = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
 		linelength = mode->xres * 3;
-		yuv = false;
 		break;
 	case MIPI_BGR666:
 		pctype = 0xb;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_18BIT;
 		linelength = (mode->xres * 18 + 7) / 8;
-		yuv = false;
 		break;
 	case MIPI_YUYV:
 		pctype = 4;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
 		linelength = mode->xres * 2;
-		yuv = true;
 		break;
 	case MIPI_UYVY:
 		pctype = 5;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
 		linelength = mode->xres * 2;
-		yuv = true;
 		break;
 	case MIPI_YUV420_L:
 		pctype = 6;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR12;
 		pixfmt = MIPI_DCS_PIXEL_FMT_12BIT;
 		linelength = (mode->xres * 12 + 7) / 8;
-		yuv = true;
 		break;
 	case MIPI_YUV420:
 		pctype = 7;
@@ -226,16 +213,11 @@ static int sh_mipi_setup(struct sh_mipi *mipi, const struct fb_videomode *mode)
 		pixfmt = MIPI_DCS_PIXEL_FMT_12BIT;
 		/* Length of U/V line */
 		linelength = (mode->xres + 1) / 2;
-		yuv = true;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	if ((yuv && ch->interface_type != YUV422) ||
-	    (!yuv && ch->interface_type != RGB24))
-		return -EINVAL;
-
 	if (!pdata->lane)
 		return -EINVAL;
 
-- 
1.7.8.6

