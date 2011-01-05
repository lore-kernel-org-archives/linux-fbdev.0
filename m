From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Jan 2011 10:21:00 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdcfb: Enable 32 bpp and 24 bpp support
Message-Id: <20110105102100.13620.6354.sendpatchset@t400s>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch extends the LCDC driver with 24 bpp
and 32 bpp support.

These modes have been kept disabled earlier due
to dependencies between the potential two LCDC
channels that are exported as two separate
framebuffer devices. The dependency boils down
to a byte swap register that is shared between
multiple channels.

With this patch applied all single channel LCDC
hardware can chose freely from 16, 24 and 32 bpp.
Dual channel LCDC must stick to the same setup
for both channels.

Without this patch only 16 bpp is fully supported.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Suitable for the common/fbdev branch in sh-2.6 git.

 drivers/video/sh_mobile_lcdcfb.c |   74 ++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 11 deletions(-)

--- 0004/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2011-01-05 19:03:07.000000000 +0900
@@ -139,6 +139,7 @@ struct sh_mobile_lcdc_priv {
 	struct notifier_block notifier;
 	unsigned long saved_shared_regs[NR_SHARED_REGS];
 	int started;
+	int forced_bpp; /* 2 channel LCDC must share bpp setting */
 };
 
 static bool banked(int reg_nr)
@@ -461,13 +462,18 @@ static int sh_mobile_lcdc_start(struct s
 	struct sh_mobile_lcdc_chan *ch;
 	struct sh_mobile_lcdc_board_cfg	*board_cfg;
 	unsigned long tmp;
+	int bpp = 0;
 	int k, m;
 	int ret = 0;
 
 	/* enable clocks before accessing the hardware */
-	for (k = 0; k < ARRAY_SIZE(priv->ch); k++)
-		if (priv->ch[k].enabled)
+	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
+		if (priv->ch[k].enabled) {
 			sh_mobile_lcdc_clk_on(priv);
+			if (!bpp)
+				bpp = priv->ch[k].info->var.bits_per_pixel;
+		}
+	}
 
 	/* reset */
 	lcdc_write(priv, _LDCNT2R, lcdc_read(priv, _LDCNT2R) | LCDC_RESET);
@@ -535,7 +541,17 @@ static int sh_mobile_lcdc_start(struct s
 	}
 
 	/* word and long word swap */
-	lcdc_write(priv, _LDDDSR, lcdc_read(priv, _LDDDSR) | 6);
+	switch (bpp) {
+	case 16:
+		lcdc_write(priv, _LDDDSR, lcdc_read(priv, _LDDDSR) | 6);
+		break;
+	case 24:
+		lcdc_write(priv, _LDDDSR, lcdc_read(priv, _LDDDSR) | 7);
+		break;
+	case 32:
+		lcdc_write(priv, _LDDDSR, lcdc_read(priv, _LDDDSR) | 4);
+		break;
+	}
 
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
 		ch = &priv->ch[k];
@@ -546,7 +562,16 @@ static int sh_mobile_lcdc_start(struct s
 		/* set bpp format in PKF[4:0] */
 		tmp = lcdc_read_chan(ch, LDDFR);
 		tmp &= ~0x0001001f;
-		tmp |= (ch->info->var.bits_per_pixel = 16) ? 3 : 0;
+		switch (ch->info->var.bits_per_pixel) {
+		case 16:
+			tmp |= 0x03;
+			break;
+		case 24:
+			tmp |= 0x0b;
+			break;
+		case 32:
+			break;
+		}
 		lcdc_write_chan(ch, LDDFR, tmp);
 
 		/* point out our frame buffer */
@@ -913,6 +938,7 @@ static int sh_mobile_open(struct fb_info
 static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
+	struct sh_mobile_lcdc_priv *p = ch->lcdc;
 
 	if (var->xres > MAX_XRES || var->yres > MAX_YRES ||
 	    var->xres * var->yres * (ch->cfg.bpp / 8) * 2 > info->fix.smem_len) {
@@ -922,6 +948,20 @@ static int sh_mobile_check_var(struct fb
 			 PICOS2KHZ(var->pixclock));
 		return -EINVAL;
 	}
+
+	/* only accept the forced_bpp for dual channel configurations */
+	if (p->forced_bpp && p->forced_bpp != var->bits_per_pixel)
+		return -EINVAL;
+
+	switch (var->bits_per_pixel) {
+	case 16: /* PKF[4:0] = 00011 - RGB 565 */
+	case 24: /* PKF[4:0] = 01011 - RGB 888 */
+	case 32: /* PKF[4:0] = 00000 - RGBA 888 */
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -954,19 +994,27 @@ static int sh_mobile_lcdc_set_bpp(struct
 		var->transp.length = 0;
 		break;
 
-	case 32: /* PKF[4:0] = 00000 - RGB 888
-		  * sh7722 pdf says 00RRGGBB but reality is GGBB00RR
-		  * this may be because LDDDSR has word swap enabled..
-		  */
-		var->red.offset = 0;
+	case 24: /* PKF[4:0] = 01011 - RGB 888 */
+		var->red.offset = 16;
 		var->red.length = 8;
-		var->green.offset = 24;
+		var->green.offset = 8;
 		var->green.length = 8;
-		var->blue.offset = 16;
+		var->blue.offset = 0;
 		var->blue.length = 8;
 		var->transp.offset = 0;
 		var->transp.length = 0;
 		break;
+
+	case 32: /* PKF[4:0] = 00000 - RGBA 888 */
+		var->red.offset = 16;
+		var->red.length = 8;
+		var->green.offset = 8;
+		var->green.length = 8;
+		var->blue.offset = 0;
+		var->blue.length = 8;
+		var->transp.offset = 24;
+		var->transp.length = 8;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1170,6 +1218,10 @@ static int __devinit sh_mobile_lcdc_prob
 		goto err1;
 	}
 
+	/* for dual channel LCDC (MAIN + SUB) force shared bpp setting */
+	if (j = 2)
+		priv->forced_bpp = pdata->ch[0].bpp;
+
 	priv->base = ioremap_nocache(res->start, resource_size(res));
 	if (!priv->base)
 		goto err1;
