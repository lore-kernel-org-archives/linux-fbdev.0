From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb (2.6): RGB565 support - take 2
Date: Fri, 14 May 2004 07:58:32 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040514045832.GB2693@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOUmI-0006e4-6z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 21:58:34 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOUmH-0001sF-Oe
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 21:58:33 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id EEB081148833
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 May 2004 07:58:32 +0300 (EEST)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

My previous atyfb RGB565 patch didn't handle partial color map updates=20
correctly. This version should.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb-2.6-rgb565-v2.patch"

diff -urN linux-orig/drivers/video/aty/atyfb.h linux/drivers/video/aty/atyfb.h
--- linux-orig/drivers/video/aty/atyfb.h	2004-05-11 23:45:00.000000000 +0300
+++ linux/drivers/video/aty/atyfb.h	2004-05-14 07:17:58.233826592 +0300
@@ -116,6 +116,7 @@
 
 struct atyfb_par {
 	struct aty_cmap_regs *aty_cmap_regs;
+	struct { u8 red, green, blue; } palette[256];
 	const struct aty_dac_ops *dac_ops;
 	const struct aty_pll_ops *pll_ops;
 	unsigned long ati_regbase;
diff -urN linux-orig/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux-orig/drivers/video/aty/atyfb_base.c	2004-05-11 23:45:00.000000000 +0300
+++ linux/drivers/video/aty/atyfb_base.c	2004-05-14 07:20:53.840130376 +0300
@@ -683,6 +683,8 @@
 	xoffset = var->xoffset;
 	yoffset = var->yoffset;
 	bpp = var->bits_per_pixel;
+	if (bpp == 16)
+		bpp = (var->green.length == 5) ? 15 : 16;
 	sync = var->sync;
 	vmode = var->vmode;
 
@@ -702,12 +704,18 @@
 		    HOST_8BPP | SRC_8BPP | DST_8BPP |
 		    BYTE_ORDER_LSB_TO_MSB;
 		dp_chain_mask = DP_CHAIN_8BPP;
-	} else if (bpp <= 16) {
+	} else if (bpp <= 15) {
 		bpp = 16;
 		pix_width = CRTC_PIX_WIDTH_15BPP;
 		dp_pix_width = HOST_15BPP | SRC_15BPP | DST_15BPP |
 		    BYTE_ORDER_LSB_TO_MSB;
 		dp_chain_mask = DP_CHAIN_15BPP;
+	} else if (bpp <= 16) {
+		bpp = 16;
+		pix_width = CRTC_PIX_WIDTH_16BPP;
+		dp_pix_width = HOST_16BPP | SRC_16BPP | DST_16BPP |
+		    BYTE_ORDER_LSB_TO_MSB;
+		dp_chain_mask = DP_CHAIN_16BPP;
 	} else if (bpp <= 24 && M64_HAS(INTEGRATED)) {
 		bpp = 24;
 		pix_width = CRTC_PIX_WIDTH_24BPP;
@@ -1078,7 +1086,6 @@
 		var->transp.offset = 0;
 		var->transp.length = 0;
 		break;
-#if 0
 	case CRTC_PIX_WIDTH_16BPP:	/* RGB 565 */
 		bpp = 16;
 		var->red.offset = 11;
@@ -1090,7 +1097,6 @@
 		var->transp.offset = 0;
 		var->transp.length = 0;
 		break;
-#endif
 	case CRTC_PIX_WIDTH_24BPP:	/* RGB 888 */
 		bpp = 24;
 		var->red.offset = 16;
@@ -2511,6 +2517,22 @@
 	return 0;
 }
 
+static void aty_st_pal(u_int regno, u_int red, u_int green, u_int blue,
+		       const struct atyfb_par *par)
+{
+#ifdef CONFIG_ATARI
+	out_8(&par->aty_cmap_regs->windex, regno);
+	out_8(&par->aty_cmap_regs->lut, red);
+	out_8(&par->aty_cmap_regs->lut, green);
+	out_8(&par->aty_cmap_regs->lut, blue);
+#else
+	writeb(regno, &par->aty_cmap_regs->windex);
+	writeb(red, &par->aty_cmap_regs->lut);
+	writeb(green, &par->aty_cmap_regs->lut);
+	writeb(blue, &par->aty_cmap_regs->lut);
+#endif
+}
+
     /*
      *  Set a single color register. The values supplied are already
      *  rounded down to the hardware's capabilities (according to the
@@ -2521,38 +2543,37 @@
 	u_int transp, struct fb_info *info)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-	int i, scale;
+	int i, depth;
 	u32 *pal = info->pseudo_palette;
 
+	depth = info->var.bits_per_pixel;
+	if (depth == 16)
+		depth = (info->var.green.length == 5) ? 15 : 16;
+
 	if (par->asleep)
 		return 0;
-	if (regno > 255)
+
+	if (regno > 255 ||
+	    (depth == 16 && regno > 63) ||
+	    (depth == 15 && regno > 31))
 		return 1;
+
 	red >>= 8;
 	green >>= 8;
 	blue >>= 8;
-	i = aty_ld_8(DAC_CNTL, par) & 0xfc;
-	if (M64_HAS(EXTRA_BRIGHT))
-		i |= 0x2; /* DAC_CNTL | 0x2 turns off the extra brightness for gt */
-	aty_st_8(DAC_CNTL, i, par);
-	aty_st_8(DAC_MASK, 0xff, par);
-	scale = (M64_HAS(INTEGRATED) && info->var.bits_per_pixel == 16) ? 3 : 0;
-#ifdef CONFIG_ATARI
-	out_8(&par->aty_cmap_regs->windex, regno << scale);
-	out_8(&par->aty_cmap_regs->lut, red);
-	out_8(&par->aty_cmap_regs->lut, green);
-	out_8(&par->aty_cmap_regs->lut, blue);
-#else
-	writeb(regno << scale, &par->aty_cmap_regs->windex);
-	writeb(red, &par->aty_cmap_regs->lut);
-	writeb(green, &par->aty_cmap_regs->lut);
-	writeb(blue, &par->aty_cmap_regs->lut);
-#endif
-	if (regno < 16)
-		switch (info->var.bits_per_pixel) {
-		case 16:
+
+	par->palette[regno].red = red;
+	par->palette[regno].green = green;
+	par->palette[regno].blue = blue;
+
+	if (regno < 16) {
+		switch (depth) {
+		case 15:
 			pal[regno] = (regno << 10) | (regno << 5) | regno;
 			break;
+		case 16:
+			pal[regno] = (regno << 11) | (regno << 5) | regno;
+			break;
 		case 24:
 			pal[regno] = (regno << 16) | (regno << 8) | regno;
 			break;
@@ -2561,6 +2582,29 @@
 			pal[regno] = (i << 16) | i;
 			break;
 		}
+	}
+
+	i = aty_ld_8(DAC_CNTL, par) & 0xfc;
+	if (M64_HAS(EXTRA_BRIGHT))
+		i |= 0x2; /* DAC_CNTL | 0x2 turns off the extra brightness for gt */
+	aty_st_8(DAC_CNTL, i, par);
+	aty_st_8(DAC_MASK, 0xff, par);
+
+	if (M64_HAS(INTEGRATED)) {
+		if (depth == 16) {
+			if (regno < 32)
+				aty_st_pal(regno << 3, red,
+					   par->palette[regno<<1].green,
+					   blue, par);
+			red = par->palette[regno>>1].red;
+			blue = par->palette[regno>>1].blue;
+			regno <<= 2;
+		} else if (depth == 15) {
+			regno <<= 3;
+		}
+	}
+	aty_st_pal(regno, red, green, blue, par);
+
 	return 0;
 }
 

--tThc/1wpZn/ma/RB--


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
