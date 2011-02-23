From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 23 Feb 2011 10:16:49 +0000
Subject: [PATCH 1/2] fbdev: sh_mobile_lcdc: Add YUV input support
Message-Id: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Supports YCbCr420sp, YCbCr422sp, and YCbCr44sp, formats (bpp = 12, 16, and 24)
respectively.
Set .nonstd = SH_FB_YUV to enable YUV mode, and use bpp to distiguish between
the 3 modes.
Due to the encoding of YUV data, the framebuffer will clear to green instead of black.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/video/sh_mobile_lcdcfb.c |  142 ++++++++++++++++++++++++++++++--------
 drivers/video/sh_mobile_lcdcfb.h |    2 +-
 include/linux/sh_mobile_fb.h     |   14 ++++
 include/video/sh_mobile_lcdc.h   |    1 +
 4 files changed, 130 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/sh_mobile_fb.h

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index bf12e53..f2814ea 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -24,6 +24,7 @@
 #include <video/sh_mobile_lcdc.h>
 #include <asm/atomic.h>
 
+#include <linux/sh_mobile_fb.h>
 #include "sh_mobile_lcdcfb.h"
 
 #define SIDE_B_OFFSET 0x1000
@@ -67,6 +68,7 @@ static unsigned long lcdc_offs_mainlcd[NR_CH_REGS] = {
 	[LDSM1R] = 0x428,
 	[LDSM2R] = 0x42c,
 	[LDSA1R] = 0x430,
+	[LDSA2R] = 0x434,
 	[LDMLSR] = 0x438,
 	[LDHCNR] = 0x448,
 	[LDHSYNR] = 0x44c,
@@ -151,6 +153,7 @@ static bool banked(int reg_nr)
 	case LDDFR:
 	case LDSM1R:
 	case LDSA1R:
+	case LDSA2R:
 	case LDMLSR:
 	case LDHCNR:
 	case LDHSYNR:
@@ -463,6 +466,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 	struct sh_mobile_lcdc_board_cfg	*board_cfg;
 	unsigned long tmp;
 	int bpp = 0;
+	unsigned long ldddsr;
 	int k, m;
 	int ret = 0;
 
@@ -541,16 +545,21 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 	}
 
 	/* word and long word swap */
-	switch (bpp) {
-	case 16:
-		lcdc_write(priv, _LDDDSR, lcdc_read(priv, _LDDDSR) | 6);
-		break;
-	case 24:
-		lcdc_write(priv, _LDDDSR, lcdc_read(priv, _LDDDSR) | 7);
-		break;
-	case 32:
-		lcdc_write(priv, _LDDDSR, lcdc_read(priv, _LDDDSR) | 4);
-		break;
+	ldddsr = lcdc_read(priv, _LDDDSR);
+	if  (priv->ch[0].info->var.nonstd & SH_FB_YUV)
+		lcdc_write(priv, _LDDDSR, ldddsr | 7);
+	else {
+		switch (bpp) {
+		case 16:
+			lcdc_write(priv, _LDDDSR, ldddsr | 6);
+			break;
+		case 24:
+			lcdc_write(priv, _LDDDSR, ldddsr | 7);
+			break;
+		case 32:
+			lcdc_write(priv, _LDDDSR, ldddsr | 4);
+			break;
+		}
 	}
 
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
@@ -561,21 +570,40 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 		/* set bpp format in PKF[4:0] */
 		tmp = lcdc_read_chan(ch, LDDFR);
-		tmp &= ~0x0001001f;
-		switch (ch->info->var.bits_per_pixel) {
-		case 16:
-			tmp |= 0x03;
-			break;
-		case 24:
-			tmp |= 0x0b;
-			break;
-		case 32:
-			break;
+		tmp &= ~0x0003031f;
+		if (ch->info->var.nonstd & SH_FB_YUV) {
+			tmp |= (ch->info->var.nonstd << 16);
+			switch (ch->info->var.bits_per_pixel) {
+			case 12:
+				break;
+			case 16:
+				tmp |= (0x1 << 8);
+				break;
+			case 24:
+				tmp |= (0x2 << 8);
+				break;
+			}
+		} else {
+			switch (ch->info->var.bits_per_pixel) {
+			case 16:
+				tmp |= 0x03;
+				break;
+			case 24:
+				tmp |= 0x0b;
+				break;
+			case 32:
+				break;
+			}
 		}
 		lcdc_write_chan(ch, LDDFR, tmp);
 
 		/* point out our frame buffer */
 		lcdc_write_chan(ch, LDSA1R, ch->info->fix.smem_start);
+		if (ch->info->var.nonstd & SH_FB_YUV)
+			lcdc_write_chan(ch, LDSA2R,
+				ch->info->fix.smem_start +
+				ch->info->var.xres *
+				ch->info->var.yres_virtual);
 
 		/* set line size */
 		lcdc_write_chan(ch, LDMLSR, ch->info->fix.line_length);
@@ -804,9 +832,15 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 	struct sh_mobile_lcdc_priv *priv = ch->lcdc;
 	unsigned long ldrcntr;
 	unsigned long new_pan_offset;
+	unsigned long base_addr_y, base_addr_c;
+	unsigned long c_offset;
 
-	new_pan_offset = (var->yoffset * info->fix.line_length) +
-		(var->xoffset * (info->var.bits_per_pixel / 8));
+	if (!(var->nonstd & SH_FB_YUV))
+		new_pan_offset = (var->yoffset * info->fix.line_length) +
+			(var->xoffset * (info->var.bits_per_pixel / 8));
+	else
+		new_pan_offset = (var->yoffset * info->fix.line_length) +
+			(var->xoffset);
 
 	if (new_pan_offset = ch->pan_offset)
 		return 0;	/* No change, do nothing */
@@ -814,7 +848,26 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 	ldrcntr = lcdc_read(priv, _LDRCNTR);
 
 	/* Set the source address for the next refresh */
-	lcdc_write_chan_mirror(ch, LDSA1R, ch->dma_handle + new_pan_offset);
+	base_addr_y = ch->dma_handle + new_pan_offset;
+	if (var->nonstd & SH_FB_YUV) {
+		/* Set y offset */
+		c_offset = (var->yoffset *
+			info->fix.line_length *
+			(info->var.bits_per_pixel - 8)) / 8;
+		base_addr_c = ch->dma_handle + var->xres * var->yres_virtual +
+			c_offset;
+		/* Set x offset */
+		if (info->var.bits_per_pixel = 24)
+			base_addr_c += 2 * var->xoffset;
+		else
+			base_addr_c += var->xoffset;
+	} else
+		base_addr_c = 0;
+
+	lcdc_write_chan_mirror(ch, LDSA1R, base_addr_y);
+	if (base_addr_c)
+		lcdc_write_chan_mirror(ch, LDSA2R, base_addr_c);
+
 	if (lcdc_chan_is_sublcd(ch))
 		lcdc_write(ch->lcdc, _LDRCNTR, ldrcntr ^ LDRCNTR_SRS);
 	else
@@ -885,7 +938,10 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 		/* Couldn't reconfigure, hopefully, can continue as before */
 		return;
 
-	info->fix.line_length = mode1.xres * (ch->cfg.bpp / 8);
+	if (info->var.nonstd & SH_FB_YUV)
+		info->fix.line_length = mode1.xres;
+	else
+		info->fix.line_length = mode1.xres * (ch->cfg.bpp / 8);
 
 	/*
 	 * fb_set_var() calls the notifier change internally, only if
@@ -980,8 +1036,22 @@ static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_check_var	= sh_mobile_check_var,
 };
 
-static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp)
+static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp,
+				   int nonstd)
 {
+	if (nonstd & SH_FB_YUV) {
+		switch (bpp) {
+		case 12:
+		case 16:
+		case 24:
+			var->bits_per_pixel = bpp;
+			var->nonstd = nonstd;
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	}
+
 	switch (bpp) {
 	case 16: /* PKF[4:0] = 00011 - RGB 565 */
 		var->red.offset = 11;
@@ -1260,6 +1330,14 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		     k < cfg->num_cfg && lcd_cfg;
 		     k++, lcd_cfg++) {
 			unsigned long size = lcd_cfg->yres * lcd_cfg->xres;
+			/* NV12 buffers must have even number of lines */
+			if ((cfg->nonstd & SH_FB_YUV) && cfg->bpp = 12 &&
+					(lcd_cfg->yres & 0x1)) {
+				dev_err(&pdev->dev, "yres must be multiple of 2"
+						" for YCbCr420 mode.\n");
+				error = -EINVAL;
+				goto err1;
+			}
 
 			if (size > max_size) {
 				max_cfg = lcd_cfg;
@@ -1274,7 +1352,11 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 				max_cfg->xres, max_cfg->yres);
 
 		info->fix = sh_mobile_lcdc_fix;
-		info->fix.smem_len = max_size * (cfg->bpp / 8) * 2;
+		info->fix.smem_len = max_size * 2 * cfg->bpp / 8;
+
+		 /* Only pan in 2 line steps for NV12 */
+		if ((cfg->nonstd & SH_FB_YUV) && cfg->bpp = 12)
+			info->fix.ypanstep = 2;
 
 		if (!mode) {
 			mode = &default_720p;
@@ -1292,7 +1374,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		var->yres_virtual = var->yres * 2;
 		var->activate = FB_ACTIVATE_NOW;
 
-		error = sh_mobile_lcdc_set_bpp(var, cfg->bpp);
+		error = sh_mobile_lcdc_set_bpp(var, cfg->bpp, cfg->nonstd);
 		if (error)
 			break;
 
@@ -1316,7 +1398,11 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		}
 
 		info->fix.smem_start = ch->dma_handle;
-		info->fix.line_length = var->xres * (cfg->bpp / 8);
+		if (var->nonstd & SH_FB_YUV)
+			info->fix.line_length = var->xres;
+		else
+			info->fix.line_length = var->xres * (cfg->bpp / 8);
+
 		info->screen_base = buf;
 		info->device = &pdev->dev;
 		ch->display_var = *var;
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 9ecee2f..c953cb0 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -8,7 +8,7 @@
 
 /* per-channel registers */
 enum { LDDCKPAT1R, LDDCKPAT2R, LDMT1R, LDMT2R, LDMT3R, LDDFR, LDSM1R,
-       LDSM2R, LDSA1R, LDMLSR, LDHCNR, LDHSYNR, LDVLNR, LDVSYNR, LDPMR,
+       LDSM2R, LDSA1R, LDSA2R, LDMLSR, LDHCNR, LDHSYNR, LDVLNR, LDVSYNR, LDPMR,
        LDHAJR,
        NR_CH_REGS };
 
diff --git a/include/linux/sh_mobile_fb.h b/include/linux/sh_mobile_fb.h
new file mode 100644
index 0000000..ec448bc
--- /dev/null
+++ b/include/linux/sh_mobile_fb.h
@@ -0,0 +1,14 @@
+/*
+ * SH-Mobile High-Definition Multimedia Interface (HDMI)
+ *
+ * Copyright (C) 2011, Damian Hobson-Garciax <dhobsong@igel.co.jp>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef SH_MOBILE_FB_H
+#define SH_MOBILE_FB_H
+
+#define SH_FB_YUV	0x1
+#endif /* SH_MOBILE_FB_H */
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index daabae5..650ff17 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -77,6 +77,7 @@ struct sh_mobile_lcdc_chan_cfg {
 	struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
 	struct sh_mobile_lcdc_board_cfg board_cfg;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
+	int nonstd;
 };
 
 struct sh_mobile_lcdc_info {
-- 
1.7.1

