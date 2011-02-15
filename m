From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 15 Feb 2011 01:51:48 +0000
Subject: [PATCH 1/1] sh_mobile_lcdc: Add NV12 input framebuffer support
Message-Id: <1297734708-20803-2-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Specify .bpp = 12 and .yuv = 1 when configuring the LCDC channel that you want
to you with NV12 input support.

Due to the encoding of YUV data, writing 0s to the framebuffer will clear to
green instead of black.

There is also no native framebuffer support for YUV formats,
so this mode will not work with most software rendering.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/video/sh_mobile_lcdcfb.c |   45 ++++++++++++++++++++++++++++++++-----
 drivers/video/sh_mobile_lcdcfb.h |    2 +-
 include/video/sh_mobile_lcdc.h   |    3 ++
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index bd4840a..3a3b7d6 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -67,6 +67,7 @@ static unsigned long lcdc_offs_mainlcd[NR_CH_REGS] = {
 	[LDSM1R] = 0x428,
 	[LDSM2R] = 0x42c,
 	[LDSA1R] = 0x430,
+	[LDSA2R] = 0x434,
 	[LDMLSR] = 0x438,
 	[LDHCNR] = 0x448,
 	[LDHSYNR] = 0x44c,
@@ -151,6 +152,7 @@ static bool banked(int reg_nr)
 	case LDDFR:
 	case LDSM1R:
 	case LDSA1R:
+	case LDSA2R:
 	case LDMLSR:
 	case LDHCNR:
 	case LDHSYNR:
@@ -545,6 +547,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 	case 16:
 		lcdc_write(priv, _LDDDSR, lcdc_read(priv, _LDDDSR) | 6);
 		break;
+	case 12:
 	case 24:
 		lcdc_write(priv, _LDDDSR, lcdc_read(priv, _LDDDSR) | 7);
 		break;
@@ -561,8 +564,11 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 		/* set bpp format in PKF[4:0] */
 		tmp = lcdc_read_chan(ch, LDDFR);
-		tmp &= ~0x0001001f;
+		tmp &= ~0x0003031f;
 		switch (ch->info->var.bits_per_pixel) {
+		case 12:
+			tmp |= (0x3 << 16);
+			break;
 		case 16:
 			tmp |= 0x03;
 			break;
@@ -576,6 +582,10 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 		/* point out our frame buffer */
 		lcdc_write_chan(ch, LDSA1R, ch->info->fix.smem_start);
+		if (ch->info->var.nonstd = REN_COLOR_NV12)
+			lcdc_write_chan(ch, LDSA2R,
+				ch->info->fix.smem_start +
+				ch->info->var.xres * ch->info->var.yres);
 
 		/* set line size */
 		lcdc_write_chan(ch, LDMLSR, ch->info->fix.line_length);
@@ -808,6 +818,9 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 	new_pan_offset = (var->yoffset * info->fix.line_length) +
 		(var->xoffset * (info->var.bits_per_pixel / 8));
 
+	if (var->nonstd = REN_COLOR_NV12)
+		new_pan_offset = new_pan_offset * 3 / 2;
+
 	if (new_pan_offset = ch->pan_offset)
 		return 0;	/* No change, do nothing */
 
@@ -815,6 +828,9 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 
 	/* Set the source address for the next refresh */
 	lcdc_write_chan_mirror(ch, LDSA1R, ch->dma_handle + new_pan_offset);
+	if (var->nonstd = REN_COLOR_NV12)
+		lcdc_write_chan_mirror(ch, LDSA2R, ch->dma_handle
+			+ new_pan_offset + var->xres * var->yres);
 	if (lcdc_chan_is_sublcd(ch))
 		lcdc_write(ch->lcdc, _LDRCNTR, ldrcntr ^ LDRCNTR_SRS);
 	else
@@ -885,7 +901,10 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 		/* Couldn't reconfigure, hopefully, can continue as before */
 		return;
 
-	info->fix.line_length = mode1.xres * (ch->cfg.bpp / 8);
+	if (info->var.nonstd = REN_COLOR_NV12)
+		info->fix.line_length = mode1.xres;
+	else
+		info->fix.line_length = mode1.xres * (ch->cfg.bpp / 8);
 
 	/*
 	 * fb_set_var() calls the notifier change internally, only if
@@ -980,8 +999,18 @@ static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_check_var	= sh_mobile_check_var,
 };
 
-static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp)
+static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp,
+				   int yuv)
 {
+	if (yuv) {
+		if (bpp = 12) { /*NV12*/
+			var->bits_per_pixel = 12;
+			var->nonstd = REN_COLOR_NV12;
+			return 0;
+		}
+		return -EINVAL;
+	}
+
 	switch (bpp) {
 	case 16: /* PKF[4:0] = 00011 - RGB 565 */
 		var->red.offset = 11;
@@ -1274,7 +1303,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 				max_cfg->xres, max_cfg->yres);
 
 		info->fix = sh_mobile_lcdc_fix;
-		info->fix.smem_len = max_size * (cfg->bpp / 8) * 2;
+		info->fix.smem_len = max_size * 2 * cfg->bpp / 8;
 
 		if (!mode) {
 			mode = &default_720p;
@@ -1292,7 +1321,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		var->yres_virtual = var->yres * 2;
 		var->activate = FB_ACTIVATE_NOW;
 
-		error = sh_mobile_lcdc_set_bpp(var, cfg->bpp);
+		error = sh_mobile_lcdc_set_bpp(var, cfg->bpp, cfg->yuv);
 		if (error)
 			break;
 
@@ -1316,7 +1345,11 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		}
 
 		info->fix.smem_start = ch->dma_handle;
-		info->fix.line_length = var->xres * (cfg->bpp / 8);
+		if (var->nonstd = REN_COLOR_NV12)
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
 
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index daabae5..147c80d 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -25,6 +25,8 @@ enum {
 	SYS24,  /* 24bpp */
 };
 
+#define REN_COLOR_NV12  0x1 /* Non-standard framebuffer color format - NV12 */
+
 enum { LCDC_CHAN_DISABLED = 0,
        LCDC_CHAN_MAINLCD,
        LCDC_CHAN_SUBLCD };
@@ -77,6 +79,7 @@ struct sh_mobile_lcdc_chan_cfg {
 	struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
 	struct sh_mobile_lcdc_board_cfg board_cfg;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
+	int yuv;
 };
 
 struct sh_mobile_lcdc_info {
-- 
1.7.1

