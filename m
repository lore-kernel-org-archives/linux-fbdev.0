From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] cyber2000fb: code cleanup
Date: Fri, 17 Aug 2007 18:48:15 +0200
Message-ID: <46c5d14f399a2@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46c5d14f3c10f"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IM4zl-0004WV-Tv for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 09:48:24 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IM4zj-0004mx-DC
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 09:48:21 -0700
Received: from poczta-5.free.wp-sa.pl (HELO localhost) ([10.1.1.10])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	17 Aug 2007 18:48:15 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--part46c5d14f3c10f
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes errors and warnings pointed
out by the checkpatch.pl script.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.23.old/drivers/video/cyber2000fb.c	2007-08-17=20
18:25:11.000000000 +0200
--- linux-2.6.23.old/drivers/video/cyber2000fb.c	2007-08-17=20
18:26:59.000000000 +0200
+++ linux-2.6.23/drivers/video/cyber2000fb.c	2007-08-17 18:
30:13.000000000 +0200
@@ -62,7 +62,7 @@ struct cfb_info {
 	struct display_switch	*dispsw;
 	struct display		*display;
 	struct pci_dev		*dev;
-	unsigned char 		__iomem *region;
+	unsigned char		__iomem *region;
 	unsigned char		__iomem *regs;
 	u_int			id;
 	int			func_use_count;
@@ -97,11 +97,11 @@ MODULE_PARM_DESC(default_font, "Default=20
 /*
  * Our access methods.
  */
-#define cyber2000fb_writel(val,reg,cfb)	writel(val, (cfb)
->regs + (reg))
-#define cyber2000fb_writew(val,reg,cfb)	writew(val, (cfb)
->regs + (reg))
-#define cyber2000fb_writeb(val,reg,cfb)	writeb(val, (cfb)
->regs + (reg))
+#define cyber2000fb_writel(val, reg, cfb)	writel(val, (cfb)
->regs + (reg))
+#define cyber2000fb_writew(val, reg, cfb)	writew(val, (cfb)
->regs + (reg))
+#define cyber2000fb_writeb(val, reg, cfb)	writeb(val, (cfb)
->regs + (reg))
=20
-#define cyber2000fb_readb(reg,cfb)	readb((cfb)->regs + (reg)
)
+#define cyber2000fb_readb(reg, cfb)		readb((cfb)->regs +=20
(reg))
=20
 static inline void
 cyber2000_crtcw(unsigned int reg, unsigned int val, struct=20
cfb_info *cfb)
@@ -221,12 +221,8 @@ cyber2000fb_copyarea(struct fb_info *inf
 static void
 cyber2000fb_imageblit(struct fb_info *info, const struct=20
fb_image *image)
 {
-//	struct cfb_info *cfb =3D (struct cfb_info *)info;
-
-//	if (!(cfb->fb.var.accel_flags & FB_ACCELF_TEXT)) {
-		cfb_imageblit(info, image);
-		return;
-//	}
+	cfb_imageblit(info, image);
+	return;
 }
=20
 static int cyber2000fb_sync(struct fb_info *info)
@@ -277,12 +273,12 @@ cyber2000fb_setcolreg(u_int regno, u_int
=20
 	/*
 	 * Pseudocolour:
-	 *         8     8
+	 *	   8     8
 	 * pixel --/--+--/-->  red lut  --> red dac
-	 *            |  8
-	 *            +--/--> green lut --> green dac
-	 *            |  8
-	 *            +--/-->  blue lut --> blue dac
+	 *	      |  8
+	 *	      +--/--> green lut --> green dac
+	 *	      |  8
+	 *	      +--/-->  blue lut --> blue dac
 	 */
 	case FB_VISUAL_PSEUDOCOLOR:
 		if (regno >=3D NR_PALETTE)
@@ -292,9 +288,9 @@ cyber2000fb_setcolreg(u_int regno, u_int
 		green >>=3D 8;
 		blue >>=3D 8;
=20
-		cfb->palette[regno].red   =3D red;
+		cfb->palette[regno].red =3D red;
 		cfb->palette[regno].green =3D green;
-		cfb->palette[regno].blue  =3D blue;
+		cfb->palette[regno].blue =3D blue;
=20
 		cyber2000fb_writeb(regno, 0x3c8, cfb);
 		cyber2000fb_writeb(red, 0x3c9, cfb);
@@ -304,12 +300,12 @@ cyber2000fb_setcolreg(u_int regno, u_int
=20
 	/*
 	 * Direct colour:
-	 *          n     rl
-	 *  pixel --/--+--/-->  red lut  --> red dac
-	 *             |  gl
-	 *             +--/--> green lut --> green dac
-	 *             |  bl
-	 *             +--/-->  blue lut --> blue dac
+	 *	   n     rl
+	 * pixel --/--+--/-->  red lut  --> red dac
+	 *	      |  gl
+	 *	      +--/--> green lut --> green dac
+	 *	      |  bl
+	 *	      +--/-->  blue lut --> blue dac
 	 * n =3D bpp, rl =3D red length, gl =3D green length, bl =3D blue=20
length
 	 */
 	case FB_VISUAL_DIRECTCOLOR:
@@ -325,9 +321,11 @@ cyber2000fb_setcolreg(u_int regno, u_int
 			 * to the high 6 bits of the LUT.
 			 */
 			cyber2000fb_writeb(regno << 2, 0x3c8, cfb);
-			cyber2000fb_writeb(cfb->palette[regno >> 1].red,=20
0x3c9, cfb);
+			cyber2000fb_writeb(cfb->palette[regno >> 1].red,
+					   0x3c9, cfb);
 			cyber2000fb_writeb(green, 0x3c9, cfb);
-			cyber2000fb_writeb(cfb->palette[regno >> 1].blue,=20
0x3c9, cfb);
+			cyber2000fb_writeb(cfb->palette[regno >> 1].blue,
+					   0x3c9, cfb);
=20
 			green =3D cfb->palette[regno << 3].green;
=20
@@ -335,9 +333,9 @@ cyber2000fb_setcolreg(u_int regno, u_int
 		}
=20
 		if (var->green.length >=3D 5 && regno < 32) {
-			cfb->palette[regno << 3].red   =3D red;
+			cfb->palette[regno << 3].red =3D red;
 			cfb->palette[regno << 3].green =3D green;
-			cfb->palette[regno << 3].blue  =3D blue;
+			cfb->palette[regno << 3].blue =3D blue;
=20
 			/*
 			 * The 5 bits of each colour component are
@@ -351,9 +349,9 @@ cyber2000fb_setcolreg(u_int regno, u_int
 		}
=20
 		if (var->green.length =3D=3D 4 && regno < 16) {
-			cfb->palette[regno << 4].red   =3D red;
+			cfb->palette[regno << 4].red =3D red;
 			cfb->palette[regno << 4].green =3D green;
-			cfb->palette[regno << 4].blue  =3D blue;
+			cfb->palette[regno << 4].blue =3D blue;
=20
 			/*
 			 * The 5 bits of each colour component are
@@ -377,12 +375,12 @@ cyber2000fb_setcolreg(u_int regno, u_int
=20
 	/*
 	 * True colour:
-	 *          n     rl
-	 *  pixel --/--+--/--> red dac
-	 *             |  gl
-	 *             +--/--> green dac
-	 *             |  bl
-	 *             +--/--> blue dac
+	 *	   n     rl
+	 * pixel --/--+--/--> red dac
+	 *	      |  gl
+	 *	      +--/--> green dac
+	 *	      |  bl
+	 *	      +--/--> blue dac
 	 * n =3D bpp, rl =3D red length, gl =3D green length, bl =3D blue=20
length
 	 */
 	case FB_VISUAL_TRUECOLOR:
@@ -494,9 +492,9 @@ static void cyber2000fb_set_timing(struc
=20
 	/* PLL registers */
 	cyber2000_grphw(EXT_DCLK_MULT, hw->clock_mult, cfb);
-	cyber2000_grphw(EXT_DCLK_DIV,  hw->clock_div, cfb);
+	cyber2000_grphw(EXT_DCLK_DIV, hw->clock_div, cfb);
 	cyber2000_grphw(EXT_MCLK_MULT, cfb->mclk_mult, cfb);
-	cyber2000_grphw(EXT_MCLK_DIV,  cfb->mclk_div, cfb);
+	cyber2000_grphw(EXT_MCLK_DIV, cfb->mclk_div, cfb);
 	cyber2000_grphw(0x90, 0x01, cfb);
 	cyber2000_grphw(0xb9, 0x80, cfb);
 	cyber2000_grphw(0xb9, 0x00, cfb);
@@ -515,8 +513,8 @@ static void cyber2000fb_set_timing(struc
 	/*
 	 * Set up accelerator registers
 	 */
-	cyber2000fb_writew(hw->width,     CO_REG_SRC_WIDTH,  cfb);
-	cyber2000fb_writew(hw->width,     CO_REG_DEST_WIDTH, cfb);
+	cyber2000fb_writew(hw->width, CO_REG_SRC_WIDTH, cfb);
+	cyber2000fb_writew(hw->width, CO_REG_DEST_WIDTH, cfb);
 	cyber2000fb_writeb(hw->co_pixfmt, CO_REG_PIXFMT, cfb);
 }
=20
@@ -549,15 +547,15 @@ cyber2000fb_decode_crtc(struct par_info=20
 {
 	u_int Htotal, Hblankend, Hsyncend;
 	u_int Vtotal, Vdispend, Vblankstart, Vblankend, Vsyncstart,=20
Vsyncend;
-#define BIT(v,b1,m,b2) (((v >> b1) & m) << b2)
+#define BIT(v, b1, m, b2) ((((v) >> (b1)) & (m)) << (b2))
=20
 	hw->crtc[13] =3D hw->pitch;
 	hw->crtc[17] =3D 0xe3;
 	hw->crtc[14] =3D 0;
 	hw->crtc[8]  =3D 0;
=20
-	Htotal      =3D var->xres + var->right_margin +
-		      var->hsync_len + var->left_margin;
+	Htotal     =3D var->xres + var->right_margin +
+		     var->hsync_len + var->left_margin;
=20
 	if (Htotal > 2080)
 		return -EINVAL;
@@ -567,15 +565,15 @@ cyber2000fb_decode_crtc(struct par_info=20
 	hw->crtc[2] =3D var->xres >> 3;
 	hw->crtc[4] =3D (var->xres + var->right_margin) >> 3;
=20
-	Hblankend   =3D (Htotal - 4*8) >> 3;
+	Hblankend   =3D (Htotal - 4 * 8) >> 3;
=20
-	hw->crtc[3] =3D BIT(Hblankend,  0, 0x1f,  0) |
-		      BIT(1,          0, 0x01,  7);
+	hw->crtc[3] =3D BIT(Hblankend, 0, 0x1f, 0) |
+		      BIT(1, 0, 0x01, 7);
=20
 	Hsyncend    =3D (var->xres + var->right_margin +=20
var->hsync_len) >> 3;
=20
-	hw->crtc[5] =3D BIT(Hsyncend,   0, 0x1f,  0) |
-		      BIT(Hblankend,  5, 0x01,  7);
+	hw->crtc[5] =3D BIT(Hsyncend, 0, 0x1f, 0) |
+		      BIT(Hblankend, 5, 0x01, 7);
=20
 	Vdispend    =3D var->yres - 1;
 	Vsyncstart  =3D var->yres + var->lower_margin;
@@ -590,20 +588,20 @@ cyber2000fb_decode_crtc(struct par_info=20
 	Vblankend   =3D Vtotal - 10;
=20
 	hw->crtc[6]  =3D Vtotal;
-	hw->crtc[7]  =3D BIT(Vtotal,     8, 0x01,  0) |
-			BIT(Vdispend,   8, 0x01,  1) |
-			BIT(Vsyncstart, 8, 0x01,  2) |
-			BIT(Vblankstart,8, 0x01,  3) |
-			BIT(1,          0, 0x01,  4) |
-	        	BIT(Vtotal,     9, 0x01,  5) |
-			BIT(Vdispend,   9, 0x01,  6) |
-			BIT(Vsyncstart, 9, 0x01,  7);
-	hw->crtc[9]  =3D BIT(0,          0, 0x1f,  0) |
-		        BIT(Vblankstart,9, 0x01,  5) |
-			BIT(1,          0, 0x01,  6);
+	hw->crtc[7]  =3D BIT(Vtotal, 8, 0x01, 0) |
+			BIT(Vdispend, 8, 0x01, 1) |
+			BIT(Vsyncstart, 8, 0x01, 2) |
+			BIT(Vblankstart, 8, 0x01, 3) |
+			BIT(1, 0, 0x01, 4) |
+			BIT(Vtotal, 9, 0x01, 5) |
+			BIT(Vdispend, 9, 0x01, 6) |
+			BIT(Vsyncstart, 9, 0x01, 7);
+	hw->crtc[9]  =3D BIT(0, 0, 0x1f, 0) |
+			BIT(Vblankstart, 9, 0x01, 5) |
+			BIT(1, 0, 0x01, 6);
 	hw->crtc[10] =3D Vsyncstart;
-	hw->crtc[11] =3D BIT(Vsyncend,   0, 0x0f,  0) |
-		       BIT(1,          0, 0x01,  7);
+	hw->crtc[11] =3D BIT(Vsyncend, 0, 0x0f, 0) |
+		       BIT(1, 0, 0x01, 7);
 	hw->crtc[12] =3D Vdispend;
 	hw->crtc[15] =3D Vblankstart;
 	hw->crtc[16] =3D Vblankend;
@@ -615,10 +613,10 @@ cyber2000fb_decode_crtc(struct par_info=20
 	 * 4=3DLINECOMP:10 5-IVIDEO 6=3DFIXCNT
 	 */
 	hw->crtc_ofl =3D
-		BIT(Vtotal,     10, 0x01,  0) |
-		BIT(Vdispend,   10, 0x01,  1) |
-		BIT(Vsyncstart, 10, 0x01,  2) |
-		BIT(Vblankstart,10, 0x01,  3) |
+		BIT(Vtotal, 10, 0x01, 0) |
+		BIT(Vdispend, 10, 0x01, 1) |
+		BIT(Vsyncstart, 10, 0x01, 2) |
+		BIT(Vblankstart, 10, 0x01, 3) |
 		EXT_CRT_VRTOFL_LINECOMP10;
=20
 	/* woody: set the interlaced bit... */
@@ -750,11 +748,11 @@ cyber2000fb_check_var(struct fb_var_scre
 	var->red.msb_right	=3D 0;
 	var->green.msb_right	=3D 0;
 	var->blue.msb_right	=3D 0;
+	var->transp.offset	=3D 0;
+	var->transp.length	=3D 0;
=20
 	switch (var->bits_per_pixel) {
 	case 8:	/* PSEUDOCOLOUR, 256 */
-		var->transp.offset	=3D 0;
-		var->transp.length	=3D 0;
 		var->red.offset		=3D 0;
 		var->red.length		=3D 8;
 		var->green.offset	=3D 0;
@@ -766,8 +764,6 @@ cyber2000fb_check_var(struct fb_var_scre
 	case 16:/* DIRECTCOLOUR, 64k or 32k */
 		switch (var->green.length) {
 		case 6: /* RGB565, 64k */
-			var->transp.offset	=3D 0;
-			var->transp.length	=3D 0;
 			var->red.offset		=3D 11;
 			var->red.length		=3D 5;
 			var->green.offset	=3D 5;
@@ -778,8 +774,6 @@ cyber2000fb_check_var(struct fb_var_scre
=20
 		default:
 		case 5: /* RGB555, 32k */
-			var->transp.offset	=3D 0;
-			var->transp.length	=3D 0;
 			var->red.offset		=3D 10;
 			var->red.length		=3D 5;
 			var->green.offset	=3D 5;
@@ -802,8 +796,6 @@ cyber2000fb_check_var(struct fb_var_scre
 		break;
=20
 	case 24:/* TRUECOLOUR, 16m */
-		var->transp.offset	=3D 0;
-		var->transp.length	=3D 0;
 		var->red.offset		=3D 16;
 		var->red.length		=3D 8;
 		var->green.offset	=3D 8;
@@ -830,7 +822,7 @@ cyber2000fb_check_var(struct fb_var_scre
 	mem =3D var->xres_virtual * var->yres_virtual *=20
(var->bits_per_pixel / 8);
 	if (mem > cfb->fb.fix.smem_len)
 		var->yres_virtual =3D cfb->fb.fix.smem_len * 8 /
-			(var->bits_per_pixel * var->xres_virtual);
+				    (var->bits_per_pixel * var->xres_virtual);
=20
 	if (var->yres > var->yres_virtual)
 		var->yres =3D var->yres_virtual;
@@ -921,7 +913,7 @@ static int cyber2000fb_set_par(struct fb
 		hw.fetch <<=3D 1;
 	hw.fetch +=3D 1;
=20
-	cfb->fb.fix.line_length	=3D var->xres_virtual *=20
var->bits_per_pixel / 8;
+	cfb->fb.fix.line_length =3D var->xres_virtual *=20
var->bits_per_pixel / 8;
=20
 	/*
 	 * Same here - if the size of the video mode exceeds the
@@ -952,7 +944,6 @@ static int cyber2000fb_set_par(struct fb
 	return 0;
 }
=20
-
 /*
  *    Pan or Wrap the Display
  */
@@ -1002,15 +993,15 @@ static int cyber2000fb_blank(int blank,=20
 	switch (blank) {
 	case FB_BLANK_POWERDOWN:	/* powerdown - both sync lines=20
down */
 		sync =3D EXT_SYNC_CTL_VS_0 | EXT_SYNC_CTL_HS_0;
-		break;=09
+		break;
 	case FB_BLANK_HSYNC_SUSPEND:	/* hsync off */
 		sync =3D EXT_SYNC_CTL_VS_NORMAL | EXT_SYNC_CTL_HS_0;
-		break;=09
+		break;
 	case FB_BLANK_VSYNC_SUSPEND:	/* vsync off */
 		sync =3D EXT_SYNC_CTL_VS_0 | EXT_SYNC_CTL_HS_NORMAL;
 		break;
-	case FB_BLANK_NORMAL:	        /* soft blank */
-	default: /* unblank */
+	case FB_BLANK_NORMAL:		/* soft blank */
+	default:			/* unblank */
 		break;
 	}
=20
@@ -1018,7 +1009,8 @@ static int cyber2000fb_blank(int blank,=20
=20
 	if (blank <=3D 1) {
 		/* turn on ramdacs */
-		cfb->ramdac_powerdown &=3D ~(RAMDAC_DACPWRDN |=20
RAMDAC_BYPASS | RAMDAC_RAMPWRDN);
+		cfb->ramdac_powerdown &=3D ~(RAMDAC_DACPWRDN |=20
RAMDAC_BYPASS |
+					   RAMDAC_RAMPWRDN);
 		cyber2000fb_write_ramdac_ctrl(cfb);
 	}
=20
@@ -1043,7 +1035,8 @@ static int cyber2000fb_blank(int blank,=20
=20
 	if (blank >=3D 2) {
 		/* turn off ramdacs */
-		cfb->ramdac_powerdown |=3D RAMDAC_DACPWRDN | RAMDAC_BYPASS=20
| RAMDAC_RAMPWRDN;
+		cfb->ramdac_powerdown |=3D RAMDAC_DACPWRDN | RAMDAC_BYPASS=20
|
+					 RAMDAC_RAMPWRDN;
 		cyber2000fb_write_ramdac_ctrl(cfb);
 	}
=20
@@ -1068,7 +1061,7 @@ static struct fb_ops cyber2000fb_ops =3D {
  * of this driver.  It is here solely at the moment to support=20
the other
  * CyberPro modules external to this driver.
  */
-static struct cfb_info		*int_cfb_info;
+static struct cfb_info *int_cfb_info;
=20
 /*
  * Enable access to the extended registers
@@ -1085,6 +1078,7 @@ void cyber2000fb_enable_extregs(struct c
 		cyber2000_grphw(EXT_FUNC_CTL, old, cfb);
 	}
 }
+EXPORT_SYMBOL(cyber2000fb_enable_extregs);
=20
 /*
  * Disable access to the extended registers
@@ -1104,11 +1098,13 @@ void cyber2000fb_disable_extregs(struct=20
 	else
 		cfb->func_use_count -=3D 1;
 }
+EXPORT_SYMBOL(cyber2000fb_disable_extregs);
=20
 void cyber2000fb_get_fb_var(struct cfb_info *cfb, struct=20
fb_var_screeninfo *var)
 {
 	memcpy(var, &cfb->fb.var, sizeof(struct fb_var_screeninfo))
;
 }
+EXPORT_SYMBOL(cyber2000fb_get_fb_var);
=20
 /*
  * Attach a capture/tv driver to the core CyberX0X0 driver.
@@ -1122,13 +1118,15 @@ int cyber2000fb_attach(struct cyberpro_i
 		info->fb_size	      =3D int_cfb_info->fb.fix.smem_len;
 		info->enable_extregs  =3D cyber2000fb_enable_extregs;
 		info->disable_extregs =3D cyber2000fb_disable_extregs;
-		info->info            =3D int_cfb_info;
+		info->info	      =3D int_cfb_info;
=20
-		strlcpy(info->dev_name, int_cfb_info->fb.fix.id,=20
sizeof(info->dev_name));
+		strlcpy(info->dev_name, int_cfb_info->fb.fix.id,
+			sizeof(info->dev_name));
 	}
=20
 	return int_cfb_info !=3D NULL;
 }
+EXPORT_SYMBOL(cyber2000fb_attach);
=20
 /*
  * Detach a capture/tv driver from the core CyberX0X0 driver.
@@ -1136,12 +1134,7 @@ int cyber2000fb_attach(struct cyberpro_i
 void cyber2000fb_detach(int idx)
 {
 }
-
-EXPORT_SYMBOL(cyber2000fb_attach);
 EXPORT_SYMBOL(cyber2000fb_detach);
-EXPORT_SYMBOL(cyber2000fb_enable_extregs);
-EXPORT_SYMBOL(cyber2000fb_disable_extregs);
-EXPORT_SYMBOL(cyber2000fb_get_fb_var);
=20
 /*
  * These parameters give
@@ -1205,7 +1198,7 @@ static void cyberpro_init_hw(struct cfb_
 	int i;
=20
 	for (i =3D 0; i < sizeof(igs_regs); i +=3D 2)
-		cyber2000_grphw(igs_regs[i], igs_regs[i+1], cfb);
+		cyber2000_grphw(igs_regs[i], igs_regs[i + 1], cfb);
=20
 	if (cfb->id =3D=3D ID_CYBERPRO_5000) {
 		unsigned char val;
@@ -1215,8 +1208,8 @@ static void cyberpro_init_hw(struct cfb_
 	}
 }
=20
-static struct cfb_info * __devinit
-cyberpro_alloc_fb_info(unsigned int id, char *name)
+static struct cfb_info __devinit=20
*cyberpro_alloc_fb_info(unsigned int id,
+							 char *name)
 {
 	struct cfb_info *cfb;
=20
@@ -1228,9 +1221,9 @@ cyberpro_alloc_fb_info(unsigned int id,=20
 	cfb->id			=3D id;
=20
 	if (id =3D=3D ID_CYBERPRO_5000)
-		cfb->ref_ps	=3D 40690; // 24.576 MHz
+		cfb->ref_ps	=3D 40690; /* 24.576 MHz */
 	else
-		cfb->ref_ps	=3D 69842; // 14.31818 MHz (69841?)
+		cfb->ref_ps	=3D 69842; /* 14.31818 MHz (69841?) */
=20
 	cfb->divisors[0]	=3D 1;
 	cfb->divisors[1]	=3D 2;
@@ -1282,8 +1275,7 @@ cyberpro_alloc_fb_info(unsigned int id,=20
 	return cfb;
 }
=20
-static void
-cyberpro_free_fb_info(struct cfb_info *cfb)
+static void cyberpro_free_fb_info(struct cfb_info *cfb)
 {
 	if (cfb) {
 		/*
@@ -1300,8 +1292,7 @@ cyberpro_free_fb_info(struct cfb_info *c
  *  video=3Dcyber2000:font:fontname
  */
 #ifndef MODULE
-static int
-cyber2000fb_setup(char *options)
+static int cyber2000fb_setup(char *options)
 {
 	char *opt;
=20
@@ -1315,7 +1306,8 @@ cyber2000fb_setup(char *options)
 		if (strncmp(opt, "font:", 5) =3D=3D 0) {
 			static char default_font_storage[40];
=20
-			strlcpy(default_font_storage, opt + 5,=20
sizeof(default_font_storage));
+			strlcpy(default_font_storage, opt + 5,
+				sizeof(default_font_storage));
 			default_font =3D default_font_storage;
 			continue;
 		}
@@ -1354,10 +1346,18 @@ static int __devinit cyberpro_common_pro
 	 * Determine the size of the memory.
 	 */
 	switch (cfb->mem_ctl2 & MEM_CTL2_SIZE_MASK) {
-	case MEM_CTL2_SIZE_4MB:	smem_size =3D 0x00400000; break;
-	case MEM_CTL2_SIZE_2MB:	smem_size =3D 0x00200000; break;
-	case MEM_CTL2_SIZE_1MB: smem_size =3D 0x00100000; break;
-	default:		smem_size =3D 0x00100000; break;
+	case MEM_CTL2_SIZE_4MB:
+		smem_size =3D 0x00400000;
+		break;
+	case MEM_CTL2_SIZE_2MB:
+		smem_size =3D 0x00200000;
+		break;
+	case MEM_CTL2_SIZE_1MB:
+		smem_size =3D 0x00100000;
+		break;
+	default:
+		smem_size =3D 0x00100000;
+		break;
 	}
=20
 	cfb->fb.fix.smem_len   =3D smem_size;
@@ -1366,8 +1366,8 @@ static int __devinit cyberpro_common_pro
=20
 	err =3D -EINVAL;
 	if (!fb_find_mode(&cfb->fb.var, &cfb->fb, NULL, NULL, 0,
-	    		  &cyber2000fb_default_mode, 8)) {
-		printk("%s: no valid mode found\n", cfb->fb.fix.id);
+			  &cyber2000fb_default_mode, 8)) {
+		printk(KERN_ERR "%s: no valid mode found\n", cfb->fb.
fix.id);
 		goto failed;
 	}
=20
@@ -1377,7 +1377,7 @@ static int __devinit cyberpro_common_pro
 	if (cfb->fb.var.yres_virtual < cfb->fb.var.yres)
 		cfb->fb.var.yres_virtual =3D cfb->fb.var.yres;
=20
-//	fb_set_var(&cfb->fb.var, -1, &cfb->fb);
+/*	fb_set_var(&cfb->fb.var, -1, &cfb->fb); */
=20
 	/*
 	 * Calculate the hsync and vsync frequencies.  Note that
@@ -1425,20 +1425,20 @@ static void cyberpro_common_resume(struc
=20
 #include <asm/arch/hardware.h>
=20
-static int __devinit
-cyberpro_vl_probe(void)
+static int __devinit cyberpro_vl_probe(void)
 {
 	struct cfb_info *cfb;
 	int err =3D -ENOMEM;
=20
-	if (!request_mem_region(FB_START,FB_SIZE,"CyberPro2010"))=20
return err;
+	if (!request_mem_region(FB_START, FB_SIZE, "CyberPro2010"))
+		return err;
=20
 	cfb =3D cyberpro_alloc_fb_info(ID_CYBERPRO_2010,=20
"CyberPro2010");
 	if (!cfb)
 		goto failed_release;
=20
 	cfb->dev =3D NULL;
-	cfb->region =3D ioremap(FB_START,FB_SIZE);
+	cfb->region =3D ioremap(FB_START, FB_SIZE);
 	if (!cfb->region)
 		goto failed_ioremap;
=20
@@ -1475,7 +1475,7 @@ failed:
 failed_ioremap:
 	cyberpro_free_fb_info(cfb);
 failed_release:
-	release_mem_region(FB_START,FB_SIZE);
+	release_mem_region(FB_START, FB_SIZE);
=20
 	return err;
 }
@@ -1538,7 +1538,8 @@ static int cyberpro_pci_enable_mmio(stru
 	 * Allow the CyberPro to accept PCI burst accesses
 	 */
 	if (cfb->id =3D=3D ID_CYBERPRO_2010) {
-		printk(KERN_INFO "%s: NOT enabling PCI bursts\n",=20
cfb->fb.fix.id);
+		printk(KERN_INFO "%s: NOT enabling PCI bursts\n",
+		       cfb->fb.fix.id);
 	} else {
 		val =3D cyber2000_grphr(EXT_BUS_CTL, cfb);
 		if (!(val & EXT_BUS_CTL_PCIBURST_WRITE)) {
@@ -1688,9 +1689,10 @@ static int cyberpro_pci_resume(struct pc
 }
=20
 static struct pci_device_id cyberpro_pci_table[] =3D {
-//	Not yet
-//	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
-//		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
+/*	Not yet
+ *	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
+ * 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
+ */
 	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2000,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_CYBERPRO_2000 },
 	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2010,
@@ -1700,7 +1702,7 @@ static struct pci_device_id cyberpro_pci
 	{ 0, }
 };
=20
-MODULE_DEVICE_TABLE(pci,cyberpro_pci_table);
+MODULE_DEVICE_TABLE(pci, cyberpro_pci_table);
=20
 static struct pci_driver cyberpro_driver =3D {
 	.name		=3D "CyberPro",


----------------------------------------------------
Producenci filmu SEZON NA MISIA przedstawiaj=B1
surfuj=B1ce pingwiny w nowej, animowanej komedii
NA FALI -  w kinach od 10 sierpnia!=20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fnafali_zwi=
astun.html&sid=3D1256

--part46c5d14f3c10f
Content-Type: application/octet-stream; name="cyber2000-cleanup.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cyber2000-cleanup.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggZml4
ZXMgZXJyb3JzIGFuZCB3YXJuaW5ncyBwb2ludGVkCm91dCBieSB0aGUgY2hlY2twYXRjaC5wbCBz
Y3JpcHQuCgpTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgSGVsdCA8a3J6eXN6dG9mLmgxQHdwLnBs
PgoKLS0tCgotLS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2N5YmVyMjAwMGZiLmMJ
MjAwNy0wOC0xNyAxODoyNToxMS4wMDAwMDAwMDAgKzAyMDAKLS0tIGxpbnV4LTIuNi4yMy5vbGQv
ZHJpdmVycy92aWRlby9jeWJlcjIwMDBmYi5jCTIwMDctMDgtMTcgMTg6MjY6NTkuMDAwMDAwMDAw
ICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9jeWJlcjIwMDBmYi5jCTIwMDct
MDgtMTcgMTg6MzA6MTMuMDAwMDAwMDAwICswMjAwCkBAIC02Miw3ICs2Miw3IEBAIHN0cnVjdCBj
ZmJfaW5mbyB7CiAJc3RydWN0IGRpc3BsYXlfc3dpdGNoCSpkaXNwc3c7CiAJc3RydWN0IGRpc3Bs
YXkJCSpkaXNwbGF5OwogCXN0cnVjdCBwY2lfZGV2CQkqZGV2OwotCXVuc2lnbmVkIGNoYXIgCQlf
X2lvbWVtICpyZWdpb247CisJdW5zaWduZWQgY2hhcgkJX19pb21lbSAqcmVnaW9uOwogCXVuc2ln
bmVkIGNoYXIJCV9faW9tZW0gKnJlZ3M7CiAJdV9pbnQJCQlpZDsKIAlpbnQJCQlmdW5jX3VzZV9j
b3VudDsKQEAgLTk3LDExICs5NywxMSBAQCBNT0RVTEVfUEFSTV9ERVNDKGRlZmF1bHRfZm9udCwg
IkRlZmF1bHQgCiAvKgogICogT3VyIGFjY2VzcyBtZXRob2RzLgogICovCi0jZGVmaW5lIGN5YmVy
MjAwMGZiX3dyaXRlbCh2YWwscmVnLGNmYikJd3JpdGVsKHZhbCwgKGNmYiktPnJlZ3MgKyAocmVn
KSkKLSNkZWZpbmUgY3liZXIyMDAwZmJfd3JpdGV3KHZhbCxyZWcsY2ZiKQl3cml0ZXcodmFsLCAo
Y2ZiKS0+cmVncyArIChyZWcpKQotI2RlZmluZSBjeWJlcjIwMDBmYl93cml0ZWIodmFsLHJlZyxj
ZmIpCXdyaXRlYih2YWwsIChjZmIpLT5yZWdzICsgKHJlZykpCisjZGVmaW5lIGN5YmVyMjAwMGZi
X3dyaXRlbCh2YWwsIHJlZywgY2ZiKQl3cml0ZWwodmFsLCAoY2ZiKS0+cmVncyArIChyZWcpKQor
I2RlZmluZSBjeWJlcjIwMDBmYl93cml0ZXcodmFsLCByZWcsIGNmYikJd3JpdGV3KHZhbCwgKGNm
YiktPnJlZ3MgKyAocmVnKSkKKyNkZWZpbmUgY3liZXIyMDAwZmJfd3JpdGViKHZhbCwgcmVnLCBj
ZmIpCXdyaXRlYih2YWwsIChjZmIpLT5yZWdzICsgKHJlZykpCiAKLSNkZWZpbmUgY3liZXIyMDAw
ZmJfcmVhZGIocmVnLGNmYikJcmVhZGIoKGNmYiktPnJlZ3MgKyAocmVnKSkKKyNkZWZpbmUgY3li
ZXIyMDAwZmJfcmVhZGIocmVnLCBjZmIpCQlyZWFkYigoY2ZiKS0+cmVncyArIChyZWcpKQogCiBz
dGF0aWMgaW5saW5lIHZvaWQKIGN5YmVyMjAwMF9jcnRjdyh1bnNpZ25lZCBpbnQgcmVnLCB1bnNp
Z25lZCBpbnQgdmFsLCBzdHJ1Y3QgY2ZiX2luZm8gKmNmYikKQEAgLTIyMSwxMiArMjIxLDggQEAg
Y3liZXIyMDAwZmJfY29weWFyZWEoc3RydWN0IGZiX2luZm8gKmluZgogc3RhdGljIHZvaWQKIGN5
YmVyMjAwMGZiX2ltYWdlYmxpdChzdHJ1Y3QgZmJfaW5mbyAqaW5mbywgY29uc3Qgc3RydWN0IGZi
X2ltYWdlICppbWFnZSkKIHsKLS8vCXN0cnVjdCBjZmJfaW5mbyAqY2ZiID0gKHN0cnVjdCBjZmJf
aW5mbyAqKWluZm87Ci0KLS8vCWlmICghKGNmYi0+ZmIudmFyLmFjY2VsX2ZsYWdzICYgRkJfQUND
RUxGX1RFWFQpKSB7Ci0JCWNmYl9pbWFnZWJsaXQoaW5mbywgaW1hZ2UpOwotCQlyZXR1cm47Ci0v
Lwl9CisJY2ZiX2ltYWdlYmxpdChpbmZvLCBpbWFnZSk7CisJcmV0dXJuOwogfQogCiBzdGF0aWMg
aW50IGN5YmVyMjAwMGZiX3N5bmMoc3RydWN0IGZiX2luZm8gKmluZm8pCkBAIC0yNzcsMTIgKzI3
MywxMiBAQCBjeWJlcjIwMDBmYl9zZXRjb2xyZWcodV9pbnQgcmVnbm8sIHVfaW50CiAKIAkvKgog
CSAqIFBzZXVkb2NvbG91cjoKLQkgKiAgICAgICAgIDggICAgIDgKKwkgKgkgICA4ICAgICA4CiAJ
ICogcGl4ZWwgLS0vLS0rLS0vLS0+ICByZWQgbHV0ICAtLT4gcmVkIGRhYwotCSAqICAgICAgICAg
ICAgfCAgOAotCSAqICAgICAgICAgICAgKy0tLy0tPiBncmVlbiBsdXQgLS0+IGdyZWVuIGRhYwot
CSAqICAgICAgICAgICAgfCAgOAotCSAqICAgICAgICAgICAgKy0tLy0tPiAgYmx1ZSBsdXQgLS0+
IGJsdWUgZGFjCisJICoJICAgICAgfCAgOAorCSAqCSAgICAgICstLS8tLT4gZ3JlZW4gbHV0IC0t
PiBncmVlbiBkYWMKKwkgKgkgICAgICB8ICA4CisJICoJICAgICAgKy0tLy0tPiAgYmx1ZSBsdXQg
LS0+IGJsdWUgZGFjCiAJICovCiAJY2FzZSBGQl9WSVNVQUxfUFNFVURPQ09MT1I6CiAJCWlmIChy
ZWdubyA+PSBOUl9QQUxFVFRFKQpAQCAtMjkyLDkgKzI4OCw5IEBAIGN5YmVyMjAwMGZiX3NldGNv
bHJlZyh1X2ludCByZWdubywgdV9pbnQKIAkJZ3JlZW4gPj49IDg7CiAJCWJsdWUgPj49IDg7CiAK
LQkJY2ZiLT5wYWxldHRlW3JlZ25vXS5yZWQgICA9IHJlZDsKKwkJY2ZiLT5wYWxldHRlW3JlZ25v
XS5yZWQgPSByZWQ7CiAJCWNmYi0+cGFsZXR0ZVtyZWdub10uZ3JlZW4gPSBncmVlbjsKLQkJY2Zi
LT5wYWxldHRlW3JlZ25vXS5ibHVlICA9IGJsdWU7CisJCWNmYi0+cGFsZXR0ZVtyZWdub10uYmx1
ZSA9IGJsdWU7CiAKIAkJY3liZXIyMDAwZmJfd3JpdGViKHJlZ25vLCAweDNjOCwgY2ZiKTsKIAkJ
Y3liZXIyMDAwZmJfd3JpdGViKHJlZCwgMHgzYzksIGNmYik7CkBAIC0zMDQsMTIgKzMwMCwxMiBA
QCBjeWJlcjIwMDBmYl9zZXRjb2xyZWcodV9pbnQgcmVnbm8sIHVfaW50CiAKIAkvKgogCSAqIERp
cmVjdCBjb2xvdXI6Ci0JICogICAgICAgICAgbiAgICAgcmwKLQkgKiAgcGl4ZWwgLS0vLS0rLS0v
LS0+ICByZWQgbHV0ICAtLT4gcmVkIGRhYwotCSAqICAgICAgICAgICAgIHwgIGdsCi0JICogICAg
ICAgICAgICAgKy0tLy0tPiBncmVlbiBsdXQgLS0+IGdyZWVuIGRhYwotCSAqICAgICAgICAgICAg
IHwgIGJsCi0JICogICAgICAgICAgICAgKy0tLy0tPiAgYmx1ZSBsdXQgLS0+IGJsdWUgZGFjCisJ
ICoJICAgbiAgICAgcmwKKwkgKiBwaXhlbCAtLS8tLSstLS8tLT4gIHJlZCBsdXQgIC0tPiByZWQg
ZGFjCisJICoJICAgICAgfCAgZ2wKKwkgKgkgICAgICArLS0vLS0+IGdyZWVuIGx1dCAtLT4gZ3Jl
ZW4gZGFjCisJICoJICAgICAgfCAgYmwKKwkgKgkgICAgICArLS0vLS0+ICBibHVlIGx1dCAtLT4g
Ymx1ZSBkYWMKIAkgKiBuID0gYnBwLCBybCA9IHJlZCBsZW5ndGgsIGdsID0gZ3JlZW4gbGVuZ3Ro
LCBibCA9IGJsdWUgbGVuZ3RoCiAJICovCiAJY2FzZSBGQl9WSVNVQUxfRElSRUNUQ09MT1I6CkBA
IC0zMjUsOSArMzIxLDExIEBAIGN5YmVyMjAwMGZiX3NldGNvbHJlZyh1X2ludCByZWdubywgdV9p
bnQKIAkJCSAqIHRvIHRoZSBoaWdoIDYgYml0cyBvZiB0aGUgTFVULgogCQkJICovCiAJCQljeWJl
cjIwMDBmYl93cml0ZWIocmVnbm8gPDwgMiwgMHgzYzgsIGNmYik7Ci0JCQljeWJlcjIwMDBmYl93
cml0ZWIoY2ZiLT5wYWxldHRlW3JlZ25vID4+IDFdLnJlZCwgMHgzYzksIGNmYik7CisJCQljeWJl
cjIwMDBmYl93cml0ZWIoY2ZiLT5wYWxldHRlW3JlZ25vID4+IDFdLnJlZCwKKwkJCQkJICAgMHgz
YzksIGNmYik7CiAJCQljeWJlcjIwMDBmYl93cml0ZWIoZ3JlZW4sIDB4M2M5LCBjZmIpOwotCQkJ
Y3liZXIyMDAwZmJfd3JpdGViKGNmYi0+cGFsZXR0ZVtyZWdubyA+PiAxXS5ibHVlLCAweDNjOSwg
Y2ZiKTsKKwkJCWN5YmVyMjAwMGZiX3dyaXRlYihjZmItPnBhbGV0dGVbcmVnbm8gPj4gMV0uYmx1
ZSwKKwkJCQkJICAgMHgzYzksIGNmYik7CiAKIAkJCWdyZWVuID0gY2ZiLT5wYWxldHRlW3JlZ25v
IDw8IDNdLmdyZWVuOwogCkBAIC0zMzUsOSArMzMzLDkgQEAgY3liZXIyMDAwZmJfc2V0Y29scmVn
KHVfaW50IHJlZ25vLCB1X2ludAogCQl9CiAKIAkJaWYgKHZhci0+Z3JlZW4ubGVuZ3RoID49IDUg
JiYgcmVnbm8gPCAzMikgewotCQkJY2ZiLT5wYWxldHRlW3JlZ25vIDw8IDNdLnJlZCAgID0gcmVk
OworCQkJY2ZiLT5wYWxldHRlW3JlZ25vIDw8IDNdLnJlZCA9IHJlZDsKIAkJCWNmYi0+cGFsZXR0
ZVtyZWdubyA8PCAzXS5ncmVlbiA9IGdyZWVuOwotCQkJY2ZiLT5wYWxldHRlW3JlZ25vIDw8IDNd
LmJsdWUgID0gYmx1ZTsKKwkJCWNmYi0+cGFsZXR0ZVtyZWdubyA8PCAzXS5ibHVlID0gYmx1ZTsK
IAogCQkJLyoKIAkJCSAqIFRoZSA1IGJpdHMgb2YgZWFjaCBjb2xvdXIgY29tcG9uZW50IGFyZQpA
QCAtMzUxLDkgKzM0OSw5IEBAIGN5YmVyMjAwMGZiX3NldGNvbHJlZyh1X2ludCByZWdubywgdV9p
bnQKIAkJfQogCiAJCWlmICh2YXItPmdyZWVuLmxlbmd0aCA9PSA0ICYmIHJlZ25vIDwgMTYpIHsK
LQkJCWNmYi0+cGFsZXR0ZVtyZWdubyA8PCA0XS5yZWQgICA9IHJlZDsKKwkJCWNmYi0+cGFsZXR0
ZVtyZWdubyA8PCA0XS5yZWQgPSByZWQ7CiAJCQljZmItPnBhbGV0dGVbcmVnbm8gPDwgNF0uZ3Jl
ZW4gPSBncmVlbjsKLQkJCWNmYi0+cGFsZXR0ZVtyZWdubyA8PCA0XS5ibHVlICA9IGJsdWU7CisJ
CQljZmItPnBhbGV0dGVbcmVnbm8gPDwgNF0uYmx1ZSA9IGJsdWU7CiAKIAkJCS8qCiAJCQkgKiBU
aGUgNSBiaXRzIG9mIGVhY2ggY29sb3VyIGNvbXBvbmVudCBhcmUKQEAgLTM3NywxMiArMzc1LDEy
IEBAIGN5YmVyMjAwMGZiX3NldGNvbHJlZyh1X2ludCByZWdubywgdV9pbnQKIAogCS8qCiAJICog
VHJ1ZSBjb2xvdXI6Ci0JICogICAgICAgICAgbiAgICAgcmwKLQkgKiAgcGl4ZWwgLS0vLS0rLS0v
LS0+IHJlZCBkYWMKLQkgKiAgICAgICAgICAgICB8ICBnbAotCSAqICAgICAgICAgICAgICstLS8t
LT4gZ3JlZW4gZGFjCi0JICogICAgICAgICAgICAgfCAgYmwKLQkgKiAgICAgICAgICAgICArLS0v
LS0+IGJsdWUgZGFjCisJICoJICAgbiAgICAgcmwKKwkgKiBwaXhlbCAtLS8tLSstLS8tLT4gcmVk
IGRhYworCSAqCSAgICAgIHwgIGdsCisJICoJICAgICAgKy0tLy0tPiBncmVlbiBkYWMKKwkgKgkg
ICAgICB8ICBibAorCSAqCSAgICAgICstLS8tLT4gYmx1ZSBkYWMKIAkgKiBuID0gYnBwLCBybCA9
IHJlZCBsZW5ndGgsIGdsID0gZ3JlZW4gbGVuZ3RoLCBibCA9IGJsdWUgbGVuZ3RoCiAJICovCiAJ
Y2FzZSBGQl9WSVNVQUxfVFJVRUNPTE9SOgpAQCAtNDk0LDkgKzQ5Miw5IEBAIHN0YXRpYyB2b2lk
IGN5YmVyMjAwMGZiX3NldF90aW1pbmcoc3RydWMKIAogCS8qIFBMTCByZWdpc3RlcnMgKi8KIAlj
eWJlcjIwMDBfZ3JwaHcoRVhUX0RDTEtfTVVMVCwgaHctPmNsb2NrX211bHQsIGNmYik7Ci0JY3li
ZXIyMDAwX2dycGh3KEVYVF9EQ0xLX0RJViwgIGh3LT5jbG9ja19kaXYsIGNmYik7CisJY3liZXIy
MDAwX2dycGh3KEVYVF9EQ0xLX0RJViwgaHctPmNsb2NrX2RpdiwgY2ZiKTsKIAljeWJlcjIwMDBf
Z3JwaHcoRVhUX01DTEtfTVVMVCwgY2ZiLT5tY2xrX211bHQsIGNmYik7Ci0JY3liZXIyMDAwX2dy
cGh3KEVYVF9NQ0xLX0RJViwgIGNmYi0+bWNsa19kaXYsIGNmYik7CisJY3liZXIyMDAwX2dycGh3
KEVYVF9NQ0xLX0RJViwgY2ZiLT5tY2xrX2RpdiwgY2ZiKTsKIAljeWJlcjIwMDBfZ3JwaHcoMHg5
MCwgMHgwMSwgY2ZiKTsKIAljeWJlcjIwMDBfZ3JwaHcoMHhiOSwgMHg4MCwgY2ZiKTsKIAljeWJl
cjIwMDBfZ3JwaHcoMHhiOSwgMHgwMCwgY2ZiKTsKQEAgLTUxNSw4ICs1MTMsOCBAQCBzdGF0aWMg
dm9pZCBjeWJlcjIwMDBmYl9zZXRfdGltaW5nKHN0cnVjCiAJLyoKIAkgKiBTZXQgdXAgYWNjZWxl
cmF0b3IgcmVnaXN0ZXJzCiAJICovCi0JY3liZXIyMDAwZmJfd3JpdGV3KGh3LT53aWR0aCwgICAg
IENPX1JFR19TUkNfV0lEVEgsICBjZmIpOwotCWN5YmVyMjAwMGZiX3dyaXRldyhody0+d2lkdGgs
ICAgICBDT19SRUdfREVTVF9XSURUSCwgY2ZiKTsKKwljeWJlcjIwMDBmYl93cml0ZXcoaHctPndp
ZHRoLCBDT19SRUdfU1JDX1dJRFRILCBjZmIpOworCWN5YmVyMjAwMGZiX3dyaXRldyhody0+d2lk
dGgsIENPX1JFR19ERVNUX1dJRFRILCBjZmIpOwogCWN5YmVyMjAwMGZiX3dyaXRlYihody0+Y29f
cGl4Zm10LCBDT19SRUdfUElYRk1ULCBjZmIpOwogfQogCkBAIC01NDksMTUgKzU0NywxNSBAQCBj
eWJlcjIwMDBmYl9kZWNvZGVfY3J0YyhzdHJ1Y3QgcGFyX2luZm8gCiB7CiAJdV9pbnQgSHRvdGFs
LCBIYmxhbmtlbmQsIEhzeW5jZW5kOwogCXVfaW50IFZ0b3RhbCwgVmRpc3BlbmQsIFZibGFua3N0
YXJ0LCBWYmxhbmtlbmQsIFZzeW5jc3RhcnQsIFZzeW5jZW5kOwotI2RlZmluZSBCSVQodixiMSxt
LGIyKSAoKCh2ID4+IGIxKSAmIG0pIDw8IGIyKQorI2RlZmluZSBCSVQodiwgYjEsIG0sIGIyKSAo
KCgodikgPj4gKGIxKSkgJiAobSkpIDw8IChiMikpCiAKIAlody0+Y3J0Y1sxM10gPSBody0+cGl0
Y2g7CiAJaHctPmNydGNbMTddID0gMHhlMzsKIAlody0+Y3J0Y1sxNF0gPSAwOwogCWh3LT5jcnRj
WzhdICA9IDA7CiAKLQlIdG90YWwgICAgICA9IHZhci0+eHJlcyArIHZhci0+cmlnaHRfbWFyZ2lu
ICsKLQkJICAgICAgdmFyLT5oc3luY19sZW4gKyB2YXItPmxlZnRfbWFyZ2luOworCUh0b3RhbCAg
ICAgPSB2YXItPnhyZXMgKyB2YXItPnJpZ2h0X21hcmdpbiArCisJCSAgICAgdmFyLT5oc3luY19s
ZW4gKyB2YXItPmxlZnRfbWFyZ2luOwogCiAJaWYgKEh0b3RhbCA+IDIwODApCiAJCXJldHVybiAt
RUlOVkFMOwpAQCAtNTY3LDE1ICs1NjUsMTUgQEAgY3liZXIyMDAwZmJfZGVjb2RlX2NydGMoc3Ry
dWN0IHBhcl9pbmZvIAogCWh3LT5jcnRjWzJdID0gdmFyLT54cmVzID4+IDM7CiAJaHctPmNydGNb
NF0gPSAodmFyLT54cmVzICsgdmFyLT5yaWdodF9tYXJnaW4pID4+IDM7CiAKLQlIYmxhbmtlbmQg
ICA9IChIdG90YWwgLSA0KjgpID4+IDM7CisJSGJsYW5rZW5kICAgPSAoSHRvdGFsIC0gNCAqIDgp
ID4+IDM7CiAKLQlody0+Y3J0Y1szXSA9IEJJVChIYmxhbmtlbmQsICAwLCAweDFmLCAgMCkgfAot
CQkgICAgICBCSVQoMSwgICAgICAgICAgMCwgMHgwMSwgIDcpOworCWh3LT5jcnRjWzNdID0gQklU
KEhibGFua2VuZCwgMCwgMHgxZiwgMCkgfAorCQkgICAgICBCSVQoMSwgMCwgMHgwMSwgNyk7CiAK
IAlIc3luY2VuZCAgICA9ICh2YXItPnhyZXMgKyB2YXItPnJpZ2h0X21hcmdpbiArIHZhci0+aHN5
bmNfbGVuKSA+PiAzOwogCi0JaHctPmNydGNbNV0gPSBCSVQoSHN5bmNlbmQsICAgMCwgMHgxZiwg
IDApIHwKLQkJICAgICAgQklUKEhibGFua2VuZCwgIDUsIDB4MDEsICA3KTsKKwlody0+Y3J0Y1s1
XSA9IEJJVChIc3luY2VuZCwgMCwgMHgxZiwgMCkgfAorCQkgICAgICBCSVQoSGJsYW5rZW5kLCA1
LCAweDAxLCA3KTsKIAogCVZkaXNwZW5kICAgID0gdmFyLT55cmVzIC0gMTsKIAlWc3luY3N0YXJ0
ICA9IHZhci0+eXJlcyArIHZhci0+bG93ZXJfbWFyZ2luOwpAQCAtNTkwLDIwICs1ODgsMjAgQEAg
Y3liZXIyMDAwZmJfZGVjb2RlX2NydGMoc3RydWN0IHBhcl9pbmZvIAogCVZibGFua2VuZCAgID0g
VnRvdGFsIC0gMTA7CiAKIAlody0+Y3J0Y1s2XSAgPSBWdG90YWw7Ci0JaHctPmNydGNbN10gID0g
QklUKFZ0b3RhbCwgICAgIDgsIDB4MDEsICAwKSB8Ci0JCQlCSVQoVmRpc3BlbmQsICAgOCwgMHgw
MSwgIDEpIHwKLQkJCUJJVChWc3luY3N0YXJ0LCA4LCAweDAxLCAgMikgfAotCQkJQklUKFZibGFu
a3N0YXJ0LDgsIDB4MDEsICAzKSB8Ci0JCQlCSVQoMSwgICAgICAgICAgMCwgMHgwMSwgIDQpIHwK
LQkgICAgICAgIAlCSVQoVnRvdGFsLCAgICAgOSwgMHgwMSwgIDUpIHwKLQkJCUJJVChWZGlzcGVu
ZCwgICA5LCAweDAxLCAgNikgfAotCQkJQklUKFZzeW5jc3RhcnQsIDksIDB4MDEsICA3KTsKLQlo
dy0+Y3J0Y1s5XSAgPSBCSVQoMCwgICAgICAgICAgMCwgMHgxZiwgIDApIHwKLQkJICAgICAgICBC
SVQoVmJsYW5rc3RhcnQsOSwgMHgwMSwgIDUpIHwKLQkJCUJJVCgxLCAgICAgICAgICAwLCAweDAx
LCAgNik7CisJaHctPmNydGNbN10gID0gQklUKFZ0b3RhbCwgOCwgMHgwMSwgMCkgfAorCQkJQklU
KFZkaXNwZW5kLCA4LCAweDAxLCAxKSB8CisJCQlCSVQoVnN5bmNzdGFydCwgOCwgMHgwMSwgMikg
fAorCQkJQklUKFZibGFua3N0YXJ0LCA4LCAweDAxLCAzKSB8CisJCQlCSVQoMSwgMCwgMHgwMSwg
NCkgfAorCQkJQklUKFZ0b3RhbCwgOSwgMHgwMSwgNSkgfAorCQkJQklUKFZkaXNwZW5kLCA5LCAw
eDAxLCA2KSB8CisJCQlCSVQoVnN5bmNzdGFydCwgOSwgMHgwMSwgNyk7CisJaHctPmNydGNbOV0g
ID0gQklUKDAsIDAsIDB4MWYsIDApIHwKKwkJCUJJVChWYmxhbmtzdGFydCwgOSwgMHgwMSwgNSkg
fAorCQkJQklUKDEsIDAsIDB4MDEsIDYpOwogCWh3LT5jcnRjWzEwXSA9IFZzeW5jc3RhcnQ7Ci0J
aHctPmNydGNbMTFdID0gQklUKFZzeW5jZW5kLCAgIDAsIDB4MGYsICAwKSB8Ci0JCSAgICAgICBC
SVQoMSwgICAgICAgICAgMCwgMHgwMSwgIDcpOworCWh3LT5jcnRjWzExXSA9IEJJVChWc3luY2Vu
ZCwgMCwgMHgwZiwgMCkgfAorCQkgICAgICAgQklUKDEsIDAsIDB4MDEsIDcpOwogCWh3LT5jcnRj
WzEyXSA9IFZkaXNwZW5kOwogCWh3LT5jcnRjWzE1XSA9IFZibGFua3N0YXJ0OwogCWh3LT5jcnRj
WzE2XSA9IFZibGFua2VuZDsKQEAgLTYxNSwxMCArNjEzLDEwIEBAIGN5YmVyMjAwMGZiX2RlY29k
ZV9jcnRjKHN0cnVjdCBwYXJfaW5mbyAKIAkgKiA0PUxJTkVDT01QOjEwIDUtSVZJREVPIDY9RklY
Q05UCiAJICovCiAJaHctPmNydGNfb2ZsID0KLQkJQklUKFZ0b3RhbCwgICAgIDEwLCAweDAxLCAg
MCkgfAotCQlCSVQoVmRpc3BlbmQsICAgMTAsIDB4MDEsICAxKSB8Ci0JCUJJVChWc3luY3N0YXJ0
LCAxMCwgMHgwMSwgIDIpIHwKLQkJQklUKFZibGFua3N0YXJ0LDEwLCAweDAxLCAgMykgfAorCQlC
SVQoVnRvdGFsLCAxMCwgMHgwMSwgMCkgfAorCQlCSVQoVmRpc3BlbmQsIDEwLCAweDAxLCAxKSB8
CisJCUJJVChWc3luY3N0YXJ0LCAxMCwgMHgwMSwgMikgfAorCQlCSVQoVmJsYW5rc3RhcnQsIDEw
LCAweDAxLCAzKSB8CiAJCUVYVF9DUlRfVlJUT0ZMX0xJTkVDT01QMTA7CiAKIAkvKiB3b29keTog
c2V0IHRoZSBpbnRlcmxhY2VkIGJpdC4uLiAqLwpAQCAtNzUwLDExICs3NDgsMTEgQEAgY3liZXIy
MDAwZmJfY2hlY2tfdmFyKHN0cnVjdCBmYl92YXJfc2NyZQogCXZhci0+cmVkLm1zYl9yaWdodAk9
IDA7CiAJdmFyLT5ncmVlbi5tc2JfcmlnaHQJPSAwOwogCXZhci0+Ymx1ZS5tc2JfcmlnaHQJPSAw
OworCXZhci0+dHJhbnNwLm9mZnNldAk9IDA7CisJdmFyLT50cmFuc3AubGVuZ3RoCT0gMDsKIAog
CXN3aXRjaCAodmFyLT5iaXRzX3Blcl9waXhlbCkgewogCWNhc2UgODoJLyogUFNFVURPQ09MT1VS
LCAyNTYgKi8KLQkJdmFyLT50cmFuc3Aub2Zmc2V0CT0gMDsKLQkJdmFyLT50cmFuc3AubGVuZ3Ro
CT0gMDsKIAkJdmFyLT5yZWQub2Zmc2V0CQk9IDA7CiAJCXZhci0+cmVkLmxlbmd0aAkJPSA4Owog
CQl2YXItPmdyZWVuLm9mZnNldAk9IDA7CkBAIC03NjYsOCArNzY0LDYgQEAgY3liZXIyMDAwZmJf
Y2hlY2tfdmFyKHN0cnVjdCBmYl92YXJfc2NyZQogCWNhc2UgMTY6LyogRElSRUNUQ09MT1VSLCA2
NGsgb3IgMzJrICovCiAJCXN3aXRjaCAodmFyLT5ncmVlbi5sZW5ndGgpIHsKIAkJY2FzZSA2OiAv
KiBSR0I1NjUsIDY0ayAqLwotCQkJdmFyLT50cmFuc3Aub2Zmc2V0CT0gMDsKLQkJCXZhci0+dHJh
bnNwLmxlbmd0aAk9IDA7CiAJCQl2YXItPnJlZC5vZmZzZXQJCT0gMTE7CiAJCQl2YXItPnJlZC5s
ZW5ndGgJCT0gNTsKIAkJCXZhci0+Z3JlZW4ub2Zmc2V0CT0gNTsKQEAgLTc3OCw4ICs3NzQsNiBA
QCBjeWJlcjIwMDBmYl9jaGVja192YXIoc3RydWN0IGZiX3Zhcl9zY3JlCiAKIAkJZGVmYXVsdDoK
IAkJY2FzZSA1OiAvKiBSR0I1NTUsIDMyayAqLwotCQkJdmFyLT50cmFuc3Aub2Zmc2V0CT0gMDsK
LQkJCXZhci0+dHJhbnNwLmxlbmd0aAk9IDA7CiAJCQl2YXItPnJlZC5vZmZzZXQJCT0gMTA7CiAJ
CQl2YXItPnJlZC5sZW5ndGgJCT0gNTsKIAkJCXZhci0+Z3JlZW4ub2Zmc2V0CT0gNTsKQEAgLTgw
Miw4ICs3OTYsNiBAQCBjeWJlcjIwMDBmYl9jaGVja192YXIoc3RydWN0IGZiX3Zhcl9zY3JlCiAJ
CWJyZWFrOwogCiAJY2FzZSAyNDovKiBUUlVFQ09MT1VSLCAxNm0gKi8KLQkJdmFyLT50cmFuc3Au
b2Zmc2V0CT0gMDsKLQkJdmFyLT50cmFuc3AubGVuZ3RoCT0gMDsKIAkJdmFyLT5yZWQub2Zmc2V0
CQk9IDE2OwogCQl2YXItPnJlZC5sZW5ndGgJCT0gODsKIAkJdmFyLT5ncmVlbi5vZmZzZXQJPSA4
OwpAQCAtODMwLDcgKzgyMiw3IEBAIGN5YmVyMjAwMGZiX2NoZWNrX3ZhcihzdHJ1Y3QgZmJfdmFy
X3NjcmUKIAltZW0gPSB2YXItPnhyZXNfdmlydHVhbCAqIHZhci0+eXJlc192aXJ0dWFsICogKHZh
ci0+Yml0c19wZXJfcGl4ZWwgLyA4KTsKIAlpZiAobWVtID4gY2ZiLT5mYi5maXguc21lbV9sZW4p
CiAJCXZhci0+eXJlc192aXJ0dWFsID0gY2ZiLT5mYi5maXguc21lbV9sZW4gKiA4IC8KLQkJCSh2
YXItPmJpdHNfcGVyX3BpeGVsICogdmFyLT54cmVzX3ZpcnR1YWwpOworCQkJCSAgICAodmFyLT5i
aXRzX3Blcl9waXhlbCAqIHZhci0+eHJlc192aXJ0dWFsKTsKIAogCWlmICh2YXItPnlyZXMgPiB2
YXItPnlyZXNfdmlydHVhbCkKIAkJdmFyLT55cmVzID0gdmFyLT55cmVzX3ZpcnR1YWw7CkBAIC05
MjEsNyArOTEzLDcgQEAgc3RhdGljIGludCBjeWJlcjIwMDBmYl9zZXRfcGFyKHN0cnVjdCBmYgog
CQlody5mZXRjaCA8PD0gMTsKIAlody5mZXRjaCArPSAxOwogCi0JY2ZiLT5mYi5maXgubGluZV9s
ZW5ndGgJPSB2YXItPnhyZXNfdmlydHVhbCAqIHZhci0+Yml0c19wZXJfcGl4ZWwgLyA4OworCWNm
Yi0+ZmIuZml4LmxpbmVfbGVuZ3RoID0gdmFyLT54cmVzX3ZpcnR1YWwgKiB2YXItPmJpdHNfcGVy
X3BpeGVsIC8gODsKIAogCS8qCiAJICogU2FtZSBoZXJlIC0gaWYgdGhlIHNpemUgb2YgdGhlIHZp
ZGVvIG1vZGUgZXhjZWVkcyB0aGUKQEAgLTk1Miw3ICs5NDQsNiBAQCBzdGF0aWMgaW50IGN5YmVy
MjAwMGZiX3NldF9wYXIoc3RydWN0IGZiCiAJcmV0dXJuIDA7CiB9CiAKLQogLyoKICAqICAgIFBh
biBvciBXcmFwIHRoZSBEaXNwbGF5CiAgKi8KQEAgLTEwMDIsMTUgKzk5MywxNSBAQCBzdGF0aWMg
aW50IGN5YmVyMjAwMGZiX2JsYW5rKGludCBibGFuaywgCiAJc3dpdGNoIChibGFuaykgewogCWNh
c2UgRkJfQkxBTktfUE9XRVJET1dOOgkvKiBwb3dlcmRvd24gLSBib3RoIHN5bmMgbGluZXMgZG93
biAqLwogCQlzeW5jID0gRVhUX1NZTkNfQ1RMX1ZTXzAgfCBFWFRfU1lOQ19DVExfSFNfMDsKLQkJ
YnJlYWs7CQorCQlicmVhazsKIAljYXNlIEZCX0JMQU5LX0hTWU5DX1NVU1BFTkQ6CS8qIGhzeW5j
IG9mZiAqLwogCQlzeW5jID0gRVhUX1NZTkNfQ1RMX1ZTX05PUk1BTCB8IEVYVF9TWU5DX0NUTF9I
U18wOwotCQlicmVhazsJCisJCWJyZWFrOwogCWNhc2UgRkJfQkxBTktfVlNZTkNfU1VTUEVORDoJ
LyogdnN5bmMgb2ZmICovCiAJCXN5bmMgPSBFWFRfU1lOQ19DVExfVlNfMCB8IEVYVF9TWU5DX0NU
TF9IU19OT1JNQUw7CiAJCWJyZWFrOwotCWNhc2UgRkJfQkxBTktfTk9STUFMOgkgICAgICAgIC8q
IHNvZnQgYmxhbmsgKi8KLQlkZWZhdWx0OiAvKiB1bmJsYW5rICovCisJY2FzZSBGQl9CTEFOS19O
T1JNQUw6CQkvKiBzb2Z0IGJsYW5rICovCisJZGVmYXVsdDoJCQkvKiB1bmJsYW5rICovCiAJCWJy
ZWFrOwogCX0KIApAQCAtMTAxOCw3ICsxMDA5LDggQEAgc3RhdGljIGludCBjeWJlcjIwMDBmYl9i
bGFuayhpbnQgYmxhbmssIAogCiAJaWYgKGJsYW5rIDw9IDEpIHsKIAkJLyogdHVybiBvbiByYW1k
YWNzICovCi0JCWNmYi0+cmFtZGFjX3Bvd2VyZG93biAmPSB+KFJBTURBQ19EQUNQV1JETiB8IFJB
TURBQ19CWVBBU1MgfCBSQU1EQUNfUkFNUFdSRE4pOworCQljZmItPnJhbWRhY19wb3dlcmRvd24g
Jj0gfihSQU1EQUNfREFDUFdSRE4gfCBSQU1EQUNfQllQQVNTIHwKKwkJCQkJICAgUkFNREFDX1JB
TVBXUkROKTsKIAkJY3liZXIyMDAwZmJfd3JpdGVfcmFtZGFjX2N0cmwoY2ZiKTsKIAl9CiAKQEAg
LTEwNDMsNyArMTAzNSw4IEBAIHN0YXRpYyBpbnQgY3liZXIyMDAwZmJfYmxhbmsoaW50IGJsYW5r
LCAKIAogCWlmIChibGFuayA+PSAyKSB7CiAJCS8qIHR1cm4gb2ZmIHJhbWRhY3MgKi8KLQkJY2Zi
LT5yYW1kYWNfcG93ZXJkb3duIHw9IFJBTURBQ19EQUNQV1JETiB8IFJBTURBQ19CWVBBU1MgfCBS
QU1EQUNfUkFNUFdSRE47CisJCWNmYi0+cmFtZGFjX3Bvd2VyZG93biB8PSBSQU1EQUNfREFDUFdS
RE4gfCBSQU1EQUNfQllQQVNTIHwKKwkJCQkJIFJBTURBQ19SQU1QV1JETjsKIAkJY3liZXIyMDAw
ZmJfd3JpdGVfcmFtZGFjX2N0cmwoY2ZiKTsKIAl9CiAKQEAgLTEwNjgsNyArMTA2MSw3IEBAIHN0
YXRpYyBzdHJ1Y3QgZmJfb3BzIGN5YmVyMjAwMGZiX29wcyA9IHsKICAqIG9mIHRoaXMgZHJpdmVy
LiAgSXQgaXMgaGVyZSBzb2xlbHkgYXQgdGhlIG1vbWVudCB0byBzdXBwb3J0IHRoZSBvdGhlcgog
ICogQ3liZXJQcm8gbW9kdWxlcyBleHRlcm5hbCB0byB0aGlzIGRyaXZlci4KICAqLwotc3RhdGlj
IHN0cnVjdCBjZmJfaW5mbwkJKmludF9jZmJfaW5mbzsKK3N0YXRpYyBzdHJ1Y3QgY2ZiX2luZm8g
KmludF9jZmJfaW5mbzsKIAogLyoKICAqIEVuYWJsZSBhY2Nlc3MgdG8gdGhlIGV4dGVuZGVkIHJl
Z2lzdGVycwpAQCAtMTA4NSw2ICsxMDc4LDcgQEAgdm9pZCBjeWJlcjIwMDBmYl9lbmFibGVfZXh0
cmVncyhzdHJ1Y3QgYwogCQljeWJlcjIwMDBfZ3JwaHcoRVhUX0ZVTkNfQ1RMLCBvbGQsIGNmYik7
CiAJfQogfQorRVhQT1JUX1NZTUJPTChjeWJlcjIwMDBmYl9lbmFibGVfZXh0cmVncyk7CiAKIC8q
CiAgKiBEaXNhYmxlIGFjY2VzcyB0byB0aGUgZXh0ZW5kZWQgcmVnaXN0ZXJzCkBAIC0xMTA0LDEx
ICsxMDk4LDEzIEBAIHZvaWQgY3liZXIyMDAwZmJfZGlzYWJsZV9leHRyZWdzKHN0cnVjdCAKIAll
bHNlCiAJCWNmYi0+ZnVuY191c2VfY291bnQgLT0gMTsKIH0KK0VYUE9SVF9TWU1CT0woY3liZXIy
MDAwZmJfZGlzYWJsZV9leHRyZWdzKTsKIAogdm9pZCBjeWJlcjIwMDBmYl9nZXRfZmJfdmFyKHN0
cnVjdCBjZmJfaW5mbyAqY2ZiLCBzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhcikKIHsKIAlt
ZW1jcHkodmFyLCAmY2ZiLT5mYi52YXIsIHNpemVvZihzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8p
KTsKIH0KK0VYUE9SVF9TWU1CT0woY3liZXIyMDAwZmJfZ2V0X2ZiX3Zhcik7CiAKIC8qCiAgKiBB
dHRhY2ggYSBjYXB0dXJlL3R2IGRyaXZlciB0byB0aGUgY29yZSBDeWJlclgwWDAgZHJpdmVyLgpA
QCAtMTEyMiwxMyArMTExOCwxNSBAQCBpbnQgY3liZXIyMDAwZmJfYXR0YWNoKHN0cnVjdCBjeWJl
cnByb19pCiAJCWluZm8tPmZiX3NpemUJICAgICAgPSBpbnRfY2ZiX2luZm8tPmZiLmZpeC5zbWVt
X2xlbjsKIAkJaW5mby0+ZW5hYmxlX2V4dHJlZ3MgID0gY3liZXIyMDAwZmJfZW5hYmxlX2V4dHJl
Z3M7CiAJCWluZm8tPmRpc2FibGVfZXh0cmVncyA9IGN5YmVyMjAwMGZiX2Rpc2FibGVfZXh0cmVn
czsKLQkJaW5mby0+aW5mbyAgICAgICAgICAgID0gaW50X2NmYl9pbmZvOworCQlpbmZvLT5pbmZv
CSAgICAgID0gaW50X2NmYl9pbmZvOwogCi0JCXN0cmxjcHkoaW5mby0+ZGV2X25hbWUsIGludF9j
ZmJfaW5mby0+ZmIuZml4LmlkLCBzaXplb2YoaW5mby0+ZGV2X25hbWUpKTsKKwkJc3RybGNweShp
bmZvLT5kZXZfbmFtZSwgaW50X2NmYl9pbmZvLT5mYi5maXguaWQsCisJCQlzaXplb2YoaW5mby0+
ZGV2X25hbWUpKTsKIAl9CiAKIAlyZXR1cm4gaW50X2NmYl9pbmZvICE9IE5VTEw7CiB9CitFWFBP
UlRfU1lNQk9MKGN5YmVyMjAwMGZiX2F0dGFjaCk7CiAKIC8qCiAgKiBEZXRhY2ggYSBjYXB0dXJl
L3R2IGRyaXZlciBmcm9tIHRoZSBjb3JlIEN5YmVyWDBYMCBkcml2ZXIuCkBAIC0xMTM2LDEyICsx
MTM0LDcgQEAgaW50IGN5YmVyMjAwMGZiX2F0dGFjaChzdHJ1Y3QgY3liZXJwcm9faQogdm9pZCBj
eWJlcjIwMDBmYl9kZXRhY2goaW50IGlkeCkKIHsKIH0KLQotRVhQT1JUX1NZTUJPTChjeWJlcjIw
MDBmYl9hdHRhY2gpOwogRVhQT1JUX1NZTUJPTChjeWJlcjIwMDBmYl9kZXRhY2gpOwotRVhQT1JU
X1NZTUJPTChjeWJlcjIwMDBmYl9lbmFibGVfZXh0cmVncyk7Ci1FWFBPUlRfU1lNQk9MKGN5YmVy
MjAwMGZiX2Rpc2FibGVfZXh0cmVncyk7Ci1FWFBPUlRfU1lNQk9MKGN5YmVyMjAwMGZiX2dldF9m
Yl92YXIpOwogCiAvKgogICogVGhlc2UgcGFyYW1ldGVycyBnaXZlCkBAIC0xMjA1LDcgKzExOTgs
NyBAQCBzdGF0aWMgdm9pZCBjeWJlcnByb19pbml0X2h3KHN0cnVjdCBjZmJfCiAJaW50IGk7CiAK
IAlmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKGlnc19yZWdzKTsgaSArPSAyKQotCQljeWJlcjIwMDBf
Z3JwaHcoaWdzX3JlZ3NbaV0sIGlnc19yZWdzW2krMV0sIGNmYik7CisJCWN5YmVyMjAwMF9ncnBo
dyhpZ3NfcmVnc1tpXSwgaWdzX3JlZ3NbaSArIDFdLCBjZmIpOwogCiAJaWYgKGNmYi0+aWQgPT0g
SURfQ1lCRVJQUk9fNTAwMCkgewogCQl1bnNpZ25lZCBjaGFyIHZhbDsKQEAgLTEyMTUsOCArMTIw
OCw4IEBAIHN0YXRpYyB2b2lkIGN5YmVycHJvX2luaXRfaHcoc3RydWN0IGNmYl8KIAl9CiB9CiAK
LXN0YXRpYyBzdHJ1Y3QgY2ZiX2luZm8gKiBfX2RldmluaXQKLWN5YmVycHJvX2FsbG9jX2ZiX2lu
Zm8odW5zaWduZWQgaW50IGlkLCBjaGFyICpuYW1lKQorc3RhdGljIHN0cnVjdCBjZmJfaW5mbyBf
X2RldmluaXQgKmN5YmVycHJvX2FsbG9jX2ZiX2luZm8odW5zaWduZWQgaW50IGlkLAorCQkJCQkJ
CSBjaGFyICpuYW1lKQogewogCXN0cnVjdCBjZmJfaW5mbyAqY2ZiOwogCkBAIC0xMjI4LDkgKzEy
MjEsOSBAQCBjeWJlcnByb19hbGxvY19mYl9pbmZvKHVuc2lnbmVkIGludCBpZCwgCiAJY2ZiLT5p
ZAkJCT0gaWQ7CiAKIAlpZiAoaWQgPT0gSURfQ1lCRVJQUk9fNTAwMCkKLQkJY2ZiLT5yZWZfcHMJ
PSA0MDY5MDsgLy8gMjQuNTc2IE1IegorCQljZmItPnJlZl9wcwk9IDQwNjkwOyAvKiAyNC41NzYg
TUh6ICovCiAJZWxzZQotCQljZmItPnJlZl9wcwk9IDY5ODQyOyAvLyAxNC4zMTgxOCBNSHogKDY5
ODQxPykKKwkJY2ZiLT5yZWZfcHMJPSA2OTg0MjsgLyogMTQuMzE4MTggTUh6ICg2OTg0MT8pICov
CiAKIAljZmItPmRpdmlzb3JzWzBdCT0gMTsKIAljZmItPmRpdmlzb3JzWzFdCT0gMjsKQEAgLTEy
ODIsOCArMTI3NSw3IEBAIGN5YmVycHJvX2FsbG9jX2ZiX2luZm8odW5zaWduZWQgaW50IGlkLCAK
IAlyZXR1cm4gY2ZiOwogfQogCi1zdGF0aWMgdm9pZAotY3liZXJwcm9fZnJlZV9mYl9pbmZvKHN0
cnVjdCBjZmJfaW5mbyAqY2ZiKQorc3RhdGljIHZvaWQgY3liZXJwcm9fZnJlZV9mYl9pbmZvKHN0
cnVjdCBjZmJfaW5mbyAqY2ZiKQogewogCWlmIChjZmIpIHsKIAkJLyoKQEAgLTEzMDAsOCArMTI5
Miw3IEBAIGN5YmVycHJvX2ZyZWVfZmJfaW5mbyhzdHJ1Y3QgY2ZiX2luZm8gKmMKICAqICB2aWRl
bz1jeWJlcjIwMDA6Zm9udDpmb250bmFtZQogICovCiAjaWZuZGVmIE1PRFVMRQotc3RhdGljIGlu
dAotY3liZXIyMDAwZmJfc2V0dXAoY2hhciAqb3B0aW9ucykKK3N0YXRpYyBpbnQgY3liZXIyMDAw
ZmJfc2V0dXAoY2hhciAqb3B0aW9ucykKIHsKIAljaGFyICpvcHQ7CiAKQEAgLTEzMTUsNyArMTMw
Niw4IEBAIGN5YmVyMjAwMGZiX3NldHVwKGNoYXIgKm9wdGlvbnMpCiAJCWlmIChzdHJuY21wKG9w
dCwgImZvbnQ6IiwgNSkgPT0gMCkgewogCQkJc3RhdGljIGNoYXIgZGVmYXVsdF9mb250X3N0b3Jh
Z2VbNDBdOwogCi0JCQlzdHJsY3B5KGRlZmF1bHRfZm9udF9zdG9yYWdlLCBvcHQgKyA1LCBzaXpl
b2YoZGVmYXVsdF9mb250X3N0b3JhZ2UpKTsKKwkJCXN0cmxjcHkoZGVmYXVsdF9mb250X3N0b3Jh
Z2UsIG9wdCArIDUsCisJCQkJc2l6ZW9mKGRlZmF1bHRfZm9udF9zdG9yYWdlKSk7CiAJCQlkZWZh
dWx0X2ZvbnQgPSBkZWZhdWx0X2ZvbnRfc3RvcmFnZTsKIAkJCWNvbnRpbnVlOwogCQl9CkBAIC0x
MzU0LDEwICsxMzQ2LDE4IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGN5YmVycHJvX2NvbW1vbl9w
cm8KIAkgKiBEZXRlcm1pbmUgdGhlIHNpemUgb2YgdGhlIG1lbW9yeS4KIAkgKi8KIAlzd2l0Y2gg
KGNmYi0+bWVtX2N0bDIgJiBNRU1fQ1RMMl9TSVpFX01BU0spIHsKLQljYXNlIE1FTV9DVEwyX1NJ
WkVfNE1COglzbWVtX3NpemUgPSAweDAwNDAwMDAwOyBicmVhazsKLQljYXNlIE1FTV9DVEwyX1NJ
WkVfMk1COglzbWVtX3NpemUgPSAweDAwMjAwMDAwOyBicmVhazsKLQljYXNlIE1FTV9DVEwyX1NJ
WkVfMU1COiBzbWVtX3NpemUgPSAweDAwMTAwMDAwOyBicmVhazsKLQlkZWZhdWx0OgkJc21lbV9z
aXplID0gMHgwMDEwMDAwMDsgYnJlYWs7CisJY2FzZSBNRU1fQ1RMMl9TSVpFXzRNQjoKKwkJc21l
bV9zaXplID0gMHgwMDQwMDAwMDsKKwkJYnJlYWs7CisJY2FzZSBNRU1fQ1RMMl9TSVpFXzJNQjoK
KwkJc21lbV9zaXplID0gMHgwMDIwMDAwMDsKKwkJYnJlYWs7CisJY2FzZSBNRU1fQ1RMMl9TSVpF
XzFNQjoKKwkJc21lbV9zaXplID0gMHgwMDEwMDAwMDsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJ
c21lbV9zaXplID0gMHgwMDEwMDAwMDsKKwkJYnJlYWs7CiAJfQogCiAJY2ZiLT5mYi5maXguc21l
bV9sZW4gICA9IHNtZW1fc2l6ZTsKQEAgLTEzNjYsOCArMTM2Niw4IEBAIHN0YXRpYyBpbnQgX19k
ZXZpbml0IGN5YmVycHJvX2NvbW1vbl9wcm8KIAogCWVyciA9IC1FSU5WQUw7CiAJaWYgKCFmYl9m
aW5kX21vZGUoJmNmYi0+ZmIudmFyLCAmY2ZiLT5mYiwgTlVMTCwgTlVMTCwgMCwKLQkgICAgCQkg
ICZjeWJlcjIwMDBmYl9kZWZhdWx0X21vZGUsIDgpKSB7Ci0JCXByaW50aygiJXM6IG5vIHZhbGlk
IG1vZGUgZm91bmRcbiIsIGNmYi0+ZmIuZml4LmlkKTsKKwkJCSAgJmN5YmVyMjAwMGZiX2RlZmF1
bHRfbW9kZSwgOCkpIHsKKwkJcHJpbnRrKEtFUk5fRVJSICIlczogbm8gdmFsaWQgbW9kZSBmb3Vu
ZFxuIiwgY2ZiLT5mYi5maXguaWQpOwogCQlnb3RvIGZhaWxlZDsKIAl9CiAKQEAgLTEzNzcsNyAr
MTM3Nyw3IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IGN5YmVycHJvX2NvbW1vbl9wcm8KIAlpZiAo
Y2ZiLT5mYi52YXIueXJlc192aXJ0dWFsIDwgY2ZiLT5mYi52YXIueXJlcykKIAkJY2ZiLT5mYi52
YXIueXJlc192aXJ0dWFsID0gY2ZiLT5mYi52YXIueXJlczsKIAotLy8JZmJfc2V0X3ZhcigmY2Zi
LT5mYi52YXIsIC0xLCAmY2ZiLT5mYik7CisvKglmYl9zZXRfdmFyKCZjZmItPmZiLnZhciwgLTEs
ICZjZmItPmZiKTsgKi8KIAogCS8qCiAJICogQ2FsY3VsYXRlIHRoZSBoc3luYyBhbmQgdnN5bmMg
ZnJlcXVlbmNpZXMuICBOb3RlIHRoYXQKQEAgLTE0MjUsMjAgKzE0MjUsMjAgQEAgc3RhdGljIHZv
aWQgY3liZXJwcm9fY29tbW9uX3Jlc3VtZShzdHJ1YwogCiAjaW5jbHVkZSA8YXNtL2FyY2gvaGFy
ZHdhcmUuaD4KIAotc3RhdGljIGludCBfX2RldmluaXQKLWN5YmVycHJvX3ZsX3Byb2JlKHZvaWQp
CitzdGF0aWMgaW50IF9fZGV2aW5pdCBjeWJlcnByb192bF9wcm9iZSh2b2lkKQogewogCXN0cnVj
dCBjZmJfaW5mbyAqY2ZiOwogCWludCBlcnIgPSAtRU5PTUVNOwogCi0JaWYgKCFyZXF1ZXN0X21l
bV9yZWdpb24oRkJfU1RBUlQsRkJfU0laRSwiQ3liZXJQcm8yMDEwIikpIHJldHVybiBlcnI7CisJ
aWYgKCFyZXF1ZXN0X21lbV9yZWdpb24oRkJfU1RBUlQsIEZCX1NJWkUsICJDeWJlclBybzIwMTAi
KSkKKwkJcmV0dXJuIGVycjsKIAogCWNmYiA9IGN5YmVycHJvX2FsbG9jX2ZiX2luZm8oSURfQ1lC
RVJQUk9fMjAxMCwgIkN5YmVyUHJvMjAxMCIpOwogCWlmICghY2ZiKQogCQlnb3RvIGZhaWxlZF9y
ZWxlYXNlOwogCiAJY2ZiLT5kZXYgPSBOVUxMOwotCWNmYi0+cmVnaW9uID0gaW9yZW1hcChGQl9T
VEFSVCxGQl9TSVpFKTsKKwljZmItPnJlZ2lvbiA9IGlvcmVtYXAoRkJfU1RBUlQsIEZCX1NJWkUp
OwogCWlmICghY2ZiLT5yZWdpb24pCiAJCWdvdG8gZmFpbGVkX2lvcmVtYXA7CiAKQEAgLTE0NzUs
NyArMTQ3NSw3IEBAIGZhaWxlZDoKIGZhaWxlZF9pb3JlbWFwOgogCWN5YmVycHJvX2ZyZWVfZmJf
aW5mbyhjZmIpOwogZmFpbGVkX3JlbGVhc2U6Ci0JcmVsZWFzZV9tZW1fcmVnaW9uKEZCX1NUQVJU
LEZCX1NJWkUpOworCXJlbGVhc2VfbWVtX3JlZ2lvbihGQl9TVEFSVCwgRkJfU0laRSk7CiAKIAly
ZXR1cm4gZXJyOwogfQpAQCAtMTUzOCw3ICsxNTM4LDggQEAgc3RhdGljIGludCBjeWJlcnByb19w
Y2lfZW5hYmxlX21taW8oc3RydQogCSAqIEFsbG93IHRoZSBDeWJlclBybyB0byBhY2NlcHQgUENJ
IGJ1cnN0IGFjY2Vzc2VzCiAJICovCiAJaWYgKGNmYi0+aWQgPT0gSURfQ1lCRVJQUk9fMjAxMCkg
ewotCQlwcmludGsoS0VSTl9JTkZPICIlczogTk9UIGVuYWJsaW5nIFBDSSBidXJzdHNcbiIsIGNm
Yi0+ZmIuZml4LmlkKTsKKwkJcHJpbnRrKEtFUk5fSU5GTyAiJXM6IE5PVCBlbmFibGluZyBQQ0kg
YnVyc3RzXG4iLAorCQkgICAgICAgY2ZiLT5mYi5maXguaWQpOwogCX0gZWxzZSB7CiAJCXZhbCA9
IGN5YmVyMjAwMF9ncnBocihFWFRfQlVTX0NUTCwgY2ZiKTsKIAkJaWYgKCEodmFsICYgRVhUX0JV
U19DVExfUENJQlVSU1RfV1JJVEUpKSB7CkBAIC0xNjg4LDkgKzE2ODksMTAgQEAgc3RhdGljIGlu
dCBjeWJlcnByb19wY2lfcmVzdW1lKHN0cnVjdCBwYwogfQogCiBzdGF0aWMgc3RydWN0IHBjaV9k
ZXZpY2VfaWQgY3liZXJwcm9fcGNpX3RhYmxlW10gPSB7Ci0vLwlOb3QgeWV0Ci0vLwl7IFBDSV9W
RU5ET1JfSURfSU5URVJHLCBQQ0lfREVWSUNFX0lEX0lOVEVSR18xNjgyLAotLy8JCVBDSV9BTllf
SUQsIFBDSV9BTllfSUQsIDAsIDAsIElEX0lHQV8xNjgyIH0sCisvKglOb3QgeWV0CisgKgl7IFBD
SV9WRU5ET1JfSURfSU5URVJHLCBQQ0lfREVWSUNFX0lEX0lOVEVSR18xNjgyLAorICogCQlQQ0lf
QU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCBJRF9JR0FfMTY4MiB9LAorICovCiAJeyBQQ0lfVkVO
RE9SX0lEX0lOVEVSRywgUENJX0RFVklDRV9JRF9JTlRFUkdfMjAwMCwKIAkJUENJX0FOWV9JRCwg
UENJX0FOWV9JRCwgMCwgMCwgSURfQ1lCRVJQUk9fMjAwMCB9LAogCXsgUENJX1ZFTkRPUl9JRF9J
TlRFUkcsIFBDSV9ERVZJQ0VfSURfSU5URVJHXzIwMTAsCkBAIC0xNzAwLDcgKzE3MDIsNyBAQCBz
dGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQgY3liZXJwcm9fcGNpCiAJeyAwLCB9CiB9OwogCi1N
T0RVTEVfREVWSUNFX1RBQkxFKHBjaSxjeWJlcnByb19wY2lfdGFibGUpOworTU9EVUxFX0RFVklD
RV9UQUJMRShwY2ksIGN5YmVycHJvX3BjaV90YWJsZSk7CiAKIHN0YXRpYyBzdHJ1Y3QgcGNpX2Ry
aXZlciBjeWJlcnByb19kcml2ZXIgPSB7CiAJLm5hbWUJCT0gIkN5YmVyUHJvIiwK

--part46c5d14f3c10f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46c5d14f3c10f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46c5d14f3c10f--
