From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:28 +0000
Subject: [PATCH 33/57] fbdev: sh_mobile_lcdc: Add sh_mobile_format_info() function
Message-Id: <1323784972-24205-34-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The function returns a pointer to a structure describing a format based
on its fourcc. Use the function where applicable instead of hardcoded
switch-case statements.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |  174 ++++++++++++++++++++++----------------
 1 files changed, 102 insertions(+), 72 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 3bc82ae..c6b6b9d 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -447,6 +447,75 @@ static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
  * Format helpers
  */
 
+struct sh_mobile_lcdc_format_info {
+	u32 fourcc;
+	unsigned int bpp;
+	bool yuv;
+	u32 lddfr;
+};
+
+static const struct sh_mobile_lcdc_format_info sh_mobile_format_infos[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_RGB565,
+		.bpp = 12,
+		.yuv = false,
+		.lddfr = LDDFR_PKF_RGB16,
+	}, {
+		.fourcc = V4L2_PIX_FMT_BGR24,
+		.bpp = 24,
+		.yuv = false,
+		.lddfr = LDDFR_PKF_RGB24,
+	}, {
+		.fourcc = V4L2_PIX_FMT_BGR32,
+		.bpp = 32,
+		.yuv = false,
+		.lddfr = LDDFR_PKF_ARGB32,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV12,
+		.bpp = 12,
+		.yuv = true,
+		.lddfr = LDDFR_CC | LDDFR_YF_420,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV21,
+		.bpp = 12,
+		.yuv = true,
+		.lddfr = LDDFR_CC | LDDFR_YF_420,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV16,
+		.bpp = 16,
+		.yuv = true,
+		.lddfr = LDDFR_CC | LDDFR_YF_422,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV61,
+		.bpp = 16,
+		.yuv = true,
+		.lddfr = LDDFR_CC | LDDFR_YF_422,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV24,
+		.bpp = 24,
+		.yuv = true,
+		.lddfr = LDDFR_CC | LDDFR_YF_444,
+	}, {
+		.fourcc = V4L2_PIX_FMT_NV42,
+		.bpp = 24,
+		.yuv = true,
+		.lddfr = LDDFR_CC | LDDFR_YF_444,
+	},
+};
+
+static const struct sh_mobile_lcdc_format_info *
+sh_mobile_format_info(u32 fourcc)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sh_mobile_format_infos); ++i) {
+		if (sh_mobile_format_infos[i].fourcc = fourcc)
+			return &sh_mobile_format_infos[i];
+	}
+
+	return NULL;
+}
+
 static int sh_mobile_format_fourcc(const struct fb_var_screeninfo *var)
 {
 	if (var->grayscale > 1)
@@ -471,21 +540,13 @@ static int sh_mobile_format_is_fourcc(const struct fb_var_screeninfo *var)
 
 static bool sh_mobile_format_is_yuv(const struct fb_var_screeninfo *var)
 {
+	const struct sh_mobile_lcdc_format_info *format;
+
 	if (var->grayscale <= 1)
 		return false;
 
-	switch (var->grayscale) {
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-	case V4L2_PIX_FMT_NV24:
-	case V4L2_PIX_FMT_NV42:
-		return true;
-
-	default:
-		return false;
-	}
+	format = sh_mobile_format_info(var->grayscale);
+	return format ? format->yuv : false;
 }
 
 /* -----------------------------------------------------------------------------
@@ -665,37 +726,20 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 	/* Setup geometry, format, frame buffer memory and operation mode. */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
+		const struct sh_mobile_lcdc_format_info *format;
+		u32 fourcc;
+
 		ch = &priv->ch[k];
 		if (!ch->enabled)
 			continue;
 
 		sh_mobile_lcdc_geometry(ch);
 
-		switch (sh_mobile_format_fourcc(&ch->info->var)) {
-		case V4L2_PIX_FMT_RGB565:
-			tmp = LDDFR_PKF_RGB16;
-			break;
-		case V4L2_PIX_FMT_BGR24:
-			tmp = LDDFR_PKF_RGB24;
-			break;
-		case V4L2_PIX_FMT_BGR32:
-			tmp = LDDFR_PKF_ARGB32;
-			break;
-		case V4L2_PIX_FMT_NV12:
-		case V4L2_PIX_FMT_NV21:
-			tmp = LDDFR_CC | LDDFR_YF_420;
-			break;
-		case V4L2_PIX_FMT_NV16:
-		case V4L2_PIX_FMT_NV61:
-			tmp = LDDFR_CC | LDDFR_YF_422;
-			break;
-		case V4L2_PIX_FMT_NV24:
-		case V4L2_PIX_FMT_NV42:
-			tmp = LDDFR_CC | LDDFR_YF_444;
-			break;
-		}
+		fourcc = sh_mobile_format_fourcc(&ch->info->var);
+		format = sh_mobile_format_info(fourcc);
+		tmp = format->lddfr;
 
-		if (sh_mobile_format_is_yuv(&ch->info->var)) {
+		if (format->yuv) {
 			switch (ch->info->var.colorspace) {
 			case V4L2_COLORSPACE_REC709:
 				tmp |= LDDFR_CF1;
@@ -709,7 +753,7 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		lcdc_write_chan(ch, LDDFR, tmp);
 		lcdc_write_chan(ch, LDMLSR, ch->pitch);
 		lcdc_write_chan(ch, LDSA1R, ch->base_addr_y);
-		if (sh_mobile_format_is_yuv(&ch->info->var))
+		if (format->yuv)
 			lcdc_write_chan(ch, LDSA2R, ch->base_addr_c);
 
 		/* When using deferred I/O mode, configure the LCDC for one-shot
@@ -1225,32 +1269,17 @@ static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *in
 		var->yres_virtual = var->yres;
 
 	if (sh_mobile_format_is_fourcc(var)) {
-		switch (var->grayscale) {
-		case V4L2_PIX_FMT_NV12:
-		case V4L2_PIX_FMT_NV21:
-			var->bits_per_pixel = 12;
-			break;
-		case V4L2_PIX_FMT_RGB565:
-		case V4L2_PIX_FMT_NV16:
-		case V4L2_PIX_FMT_NV61:
-			var->bits_per_pixel = 16;
-			break;
-		case V4L2_PIX_FMT_BGR24:
-		case V4L2_PIX_FMT_NV24:
-		case V4L2_PIX_FMT_NV42:
-			var->bits_per_pixel = 24;
-			break;
-		case V4L2_PIX_FMT_BGR32:
-			var->bits_per_pixel = 32;
-			break;
-		default:
+		const struct sh_mobile_lcdc_format_info *format;
+
+		format = sh_mobile_format_info(var->grayscale);
+		if (format = NULL)
 			return -EINVAL;
-		}
+		var->bits_per_pixel = format->bpp;
 
 		/* Default to RGB and JPEG color-spaces for RGB and YUV formats
 		 * respectively.
 		 */
-		if (!sh_mobile_format_is_yuv(var))
+		if (!format->yuv)
 			var->colorspace = V4L2_COLORSPACE_SRGB;
 		else if (var->colorspace != V4L2_COLORSPACE_REC709)
 			var->colorspace = V4L2_COLORSPACE_JPEG;
@@ -1663,6 +1692,7 @@ static int __devinit
 sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 			    struct sh_mobile_lcdc_chan *ch)
 {
+	const struct sh_mobile_lcdc_format_info *format;
 	struct sh_mobile_lcdc_chan_cfg *cfg = &ch->cfg;
 	const struct fb_videomode *max_mode;
 	const struct fb_videomode *mode;
@@ -1677,6 +1707,13 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	mutex_init(&ch->open_lock);
 	ch->notify = sh_mobile_lcdc_display_notify;
 
+	/* Validate the format. */
+	format = sh_mobile_format_info(cfg->fourcc);
+	if (format = NULL) {
+		dev_err(priv->dev, "Invalid FOURCC %08x.\n", cfg->fourcc);
+		return -EINVAL;
+	}
+
 	/* Allocate the frame buffer device. */
 	ch->info = framebuffer_alloc(0, priv->dev);
 	if (!ch->info) {
@@ -1754,20 +1791,13 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	var->yres_virtual = var->yres * 2;
 	var->activate = FB_ACTIVATE_NOW;
 
-	switch (cfg->fourcc) {
-	case V4L2_PIX_FMT_RGB565:
-		var->bits_per_pixel = 16;
-		break;
-	case V4L2_PIX_FMT_BGR24:
-		var->bits_per_pixel = 24;
-		break;
-	case V4L2_PIX_FMT_BGR32:
-		var->bits_per_pixel = 32;
-		break;
-	default:
+	/* Use the legacy API by default for RGB formats, and the FOURCC API
+	 * for YUV formats.
+	 */
+	if (!format->yuv)
+		var->bits_per_pixel = format->bpp;
+	else
 		var->grayscale = cfg->fourcc;
-		break;
-	}
 
 	/* Make sure the memory size check won't fail. smem_len is initialized
 	 * later based on var.
@@ -1804,7 +1834,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	    cfg->fourcc = V4L2_PIX_FMT_NV21)
 		info->fix.ypanstep = 2;
 
-	if (sh_mobile_format_is_yuv(var)) {
+	if (format->yuv) {
 		info->fix.line_length = var->xres;
 		info->fix.visual = FB_VISUAL_FOURCC;
 	} else {
-- 
1.7.3.4

