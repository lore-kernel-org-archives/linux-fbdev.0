From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] pm3fb: various fixes
Date: Sat, 12 May 2007 19:58:40 +0200
Message-ID: <464600501490d@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part4646005017024"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hmvrh-0006ov-NO for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 May 2007 10:58:45 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hmvrf-0007dO-Eu
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 May 2007 10:58:45 -0700
Received: from poczta-5.free.wp-sa.pl (HELO localhost) ([10.1.1.10])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	12 May 2007 19:58:40 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--part4646005017024
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch:
- fixes 16-bit RGBA 4444 and 5551 modes (use fbset -rgba to set=20
them)
- kills wmb() after each register write by PM3_SLOW_WRITE_REG
- kills inaccurate comments (leftovers from skeletonfb.c)
- kills PCI class restriction, now it is more general and shorter
- white spaces and other minor fixes and source reducing

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch contains also the fix send by Antonino today. Should I=20
redo the patch?

--- linux-2.6.21.orig/drivers/video/pm3fb.c	2007-05-12 08:41:
22.913392000 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-05-12 19:41:14.
041212701 +0200
@@ -52,11 +52,6 @@
 static char *mode_option __devinitdata;
=20
 /*
- *  If your driver supports multiple boards, you should make the
- *  below data types arrays, or allocate them dynamically (using=20
kmalloc()).
- */
-
-/*
  * This structure defines the hardware state of the graphics=20
card. Normally
  * you place this in a header file in linux/include/video. This=20
file usually
  * also includes register information. That allows other driver=20
subsystems
@@ -67,7 +62,7 @@ struct pm3_par {
 	unsigned char	__iomem *v_regs;/* virtual address of=20
p_regs */
 	u32		video;		/* video flags before blanking */
 	u32		base;		/* screen base (xoffset+yoffset) in=20
128 bits unit */
-	u32 		palette[16];
+	u32		palette[16];
 };
=20
 /*
@@ -104,36 +99,28 @@ static inline void PM3_WAIT(struct pm3_p
 	while (PM3_READ_REG(par, PM3InFIFOSpace) < n);
 }
=20
-static inline void PM3_SLOW_WRITE_REG(struct pm3_par *par, s32=20
off, u32 v)
-{
-	if (par->v_regs) {
-		mb();
-		PM3_WAIT(par, 1);
-		wmb();
-		PM3_WRITE_REG(par, off, v);
-	}
-}
-
-static inline void PM3_SET_INDEX(struct pm3_par *par, unsigned=20
index)
-{
-	PM3_SLOW_WRITE_REG(par, PM3RD_IndexHigh, (index >> 8) &=20
0xff);
-	PM3_SLOW_WRITE_REG(par, PM3RD_IndexLow, index & 0xff);
-}
-
 static inline void PM3_WRITE_DAC_REG(struct pm3_par *par,=20
unsigned r, u8 v)
 {
-	PM3_SET_INDEX(par, r);
+	PM3_WAIT(par, 3);
+	PM3_WRITE_REG(par, PM3RD_IndexHigh, (r >> 8) & 0xff);
+	PM3_WRITE_REG(par, PM3RD_IndexLow, r & 0xff);
 	wmb();
 	PM3_WRITE_REG(par, PM3RD_IndexedData, v);
+	wmb();
 }
=20
 static inline void pm3fb_set_color(struct pm3_par *par, unsigned=20
char regno,
 			unsigned char r, unsigned char g, unsigned char b)
 {
-	PM3_SLOW_WRITE_REG(par, PM3RD_PaletteWriteAddress, regno);
-	PM3_SLOW_WRITE_REG(par, PM3RD_PaletteData, r);
-	PM3_SLOW_WRITE_REG(par, PM3RD_PaletteData, g);
-	PM3_SLOW_WRITE_REG(par, PM3RD_PaletteData, b);
+	PM3_WAIT(par, 4);
+	PM3_WRITE_REG(par, PM3RD_PaletteWriteAddress, regno);
+	wmb();
+	PM3_WRITE_REG(par, PM3RD_PaletteData, r);
+	wmb();
+	PM3_WRITE_REG(par, PM3RD_PaletteData, g);
+	wmb();
+	PM3_WRITE_REG(par, PM3RD_PaletteData, b);
+	wmb();
 }
=20
 static void pm3fb_clear_colormap(struct pm3_par *par,
@@ -141,7 +128,7 @@ static void pm3fb_clear_colormap(struct=20
 {
 	int i;
=20
-	for (i =3D 0; i < 256 ; i++) /* fill color map with white */
+	for (i =3D 0; i < 256 ; i++)
 		pm3fb_set_color(par, i, r, g, b);
=20
 }
@@ -175,19 +162,26 @@ static void pm3fb_calculate_clock(unsign
 	}
 }
=20
-static inline int pm3fb_shift_bpp(unsigned long depth, int v)
+static inline int pm3fb_depth(const struct fb_var_screeninfo=20
*var)
+{
+	if ( var->bits_per_pixel =3D=3D 16 )
+		return var->red.length + var->green.length
+			+ var->blue.length;
+
+	return var->bits_per_pixel;
+}
+
+static inline int pm3fb_shift_bpp(unsigned bpp, int v)
 {
-	switch (depth) {
+	switch (bpp) {
 	case 8:
 		return (v >> 4);
-	case 12:
-	case 15:
 	case 16:
 		return (v >> 3);
 	case 32:
 		return (v >> 2);
 	}
-	DPRINTK("Unsupported depth %ld\n", depth);
+	DPRINTK("Unsupported depth %u\n", bpp);
 	return 0;
 }
=20
@@ -206,56 +200,50 @@ static void pm3fb_write_mode(struct fb_i
 	const u32 vbend =3D vsend + info->var.upper_margin;
 	const u32 vtotal =3D info->var.yres + vbend;
 	const u32 width =3D (info->var.xres_virtual + 7) & ~7;
+	const unsigned bpp =3D info->var.bits_per_pixel;
=20
-	PM3_SLOW_WRITE_REG(par, PM3MemBypassWriteMask, 0xffffffff);
-	PM3_SLOW_WRITE_REG(par, PM3Aperture0, 0x00000000);
-	PM3_SLOW_WRITE_REG(par, PM3Aperture1, 0x00000000);
-	PM3_SLOW_WRITE_REG(par, PM3FIFODis, 0x00000007);
-
-	PM3_SLOW_WRITE_REG(par, PM3HTotal,
-			   pm3fb_shift_bpp(info->var.bits_per_pixel,
-					  htotal - 1));
-	PM3_SLOW_WRITE_REG(par, PM3HsEnd,
-			   pm3fb_shift_bpp(info->var.bits_per_pixel,
-					  hsend));
-	PM3_SLOW_WRITE_REG(par, PM3HsStart,
-			   pm3fb_shift_bpp(info->var.bits_per_pixel,
-					  hsstart));
-	PM3_SLOW_WRITE_REG(par, PM3HbEnd,
-			   pm3fb_shift_bpp(info->var.bits_per_pixel,
-					  hbend));
-	PM3_SLOW_WRITE_REG(par, PM3HgEnd,
-			   pm3fb_shift_bpp(info->var.bits_per_pixel,
-					  hbend));
-	PM3_SLOW_WRITE_REG(par, PM3ScreenStride,
-			   pm3fb_shift_bpp(info->var.bits_per_pixel,
-					  width));
-	PM3_SLOW_WRITE_REG(par, PM3VTotal, vtotal - 1);
-	PM3_SLOW_WRITE_REG(par, PM3VsEnd, vsend - 1);
-	PM3_SLOW_WRITE_REG(par, PM3VsStart, vsstart - 1);
-	PM3_SLOW_WRITE_REG(par, PM3VbEnd, vbend);
+	PM3_WAIT(par, 20);
+	PM3_WRITE_REG(par, PM3MemBypassWriteMask, 0xffffffff);
+	PM3_WRITE_REG(par, PM3Aperture0, 0x00000000);
+	PM3_WRITE_REG(par, PM3Aperture1, 0x00000000);
+	PM3_WRITE_REG(par, PM3FIFODis, 0x00000007);
+
+	PM3_WRITE_REG(par, PM3HTotal,
+			   pm3fb_shift_bpp(bpp, htotal - 1));
+	PM3_WRITE_REG(par, PM3HsEnd,
+			   pm3fb_shift_bpp(bpp, hsend));
+	PM3_WRITE_REG(par, PM3HsStart,
+			   pm3fb_shift_bpp(bpp, hsstart));
+	PM3_WRITE_REG(par, PM3HbEnd,
+			   pm3fb_shift_bpp(bpp, hbend));
+	PM3_WRITE_REG(par, PM3HgEnd,
+			   pm3fb_shift_bpp(bpp, hbend));
+	PM3_WRITE_REG(par, PM3ScreenStride,
+			   pm3fb_shift_bpp(bpp, width));
+	PM3_WRITE_REG(par, PM3VTotal, vtotal - 1);
+	PM3_WRITE_REG(par, PM3VsEnd, vsend - 1);
+	PM3_WRITE_REG(par, PM3VsStart, vsstart - 1);
+	PM3_WRITE_REG(par, PM3VbEnd, vbend);
=20
-	switch (info->var.bits_per_pixel) {
+	switch (bpp) {
 	case 8:
-		PM3_SLOW_WRITE_REG(par, PM3ByAperture1Mode,
+		PM3_WRITE_REG(par, PM3ByAperture1Mode,
 				   PM3ByApertureMode_PIXELSIZE_8BIT);
-		PM3_SLOW_WRITE_REG(par, PM3ByAperture2Mode,
+		PM3_WRITE_REG(par, PM3ByAperture2Mode,
 				   PM3ByApertureMode_PIXELSIZE_8BIT);
 		break;
=20
-	case 12:
-	case 15:
 	case 16:
 #ifndef __BIG_ENDIAN
-		PM3_SLOW_WRITE_REG(par, PM3ByAperture1Mode,
+		PM3_WRITE_REG(par, PM3ByAperture1Mode,
 				   PM3ByApertureMode_PIXELSIZE_16BIT);
-		PM3_SLOW_WRITE_REG(par, PM3ByAperture2Mode,
+		PM3_WRITE_REG(par, PM3ByAperture2Mode,
 				   PM3ByApertureMode_PIXELSIZE_16BIT);
 #else
-		PM3_SLOW_WRITE_REG(par, PM3ByAperture1Mode,
+		PM3_WRITE_REG(par, PM3ByAperture1Mode,
 				   PM3ByApertureMode_PIXELSIZE_16BIT |
 				   PM3ByApertureMode_BYTESWAP_BADC);
-		PM3_SLOW_WRITE_REG(par, PM3ByAperture2Mode,
+		PM3_WRITE_REG(par, PM3ByAperture2Mode,
 				   PM3ByApertureMode_PIXELSIZE_16BIT |
 				   PM3ByApertureMode_BYTESWAP_BADC);
 #endif /* ! __BIG_ENDIAN */
@@ -263,23 +251,22 @@ static void pm3fb_write_mode(struct fb_i
=20
 	case 32:
 #ifndef __BIG_ENDIAN
-		PM3_SLOW_WRITE_REG(par, PM3ByAperture1Mode,
+		PM3_WRITE_REG(par, PM3ByAperture1Mode,
 				   PM3ByApertureMode_PIXELSIZE_32BIT);
-		PM3_SLOW_WRITE_REG(par, PM3ByAperture2Mode,
+		PM3_WRITE_REG(par, PM3ByAperture2Mode,
 				   PM3ByApertureMode_PIXELSIZE_32BIT);
 #else
-		PM3_SLOW_WRITE_REG(par, PM3ByAperture1Mode,
+		PM3_WRITE_REG(par, PM3ByAperture1Mode,
 				   PM3ByApertureMode_PIXELSIZE_32BIT |
 				   PM3ByApertureMode_BYTESWAP_DCBA);
-		PM3_SLOW_WRITE_REG(par, PM3ByAperture2Mode,
+		PM3_WRITE_REG(par, PM3ByAperture2Mode,
 				   PM3ByApertureMode_PIXELSIZE_32BIT |
 				   PM3ByApertureMode_BYTESWAP_DCBA);
 #endif /* ! __BIG_ENDIAN */
 		break;
=20
 	default:
-		DPRINTK("Unsupported depth %d\n",
-			info->var.bits_per_pixel);
+		DPRINTK("Unsupported depth %d\n", bpp);
 		break;
 	}
=20
@@ -296,14 +283,15 @@ static void pm3fb_write_mode(struct fb_i
 			   PM3VideoControl_VSYNC_MASK);
 		video |=3D PM3VideoControl_HSYNC_ACTIVE_HIGH |
 			 PM3VideoControl_VSYNC_ACTIVE_HIGH;
-		PM3_SLOW_WRITE_REG(par, PM3VideoControl, video);
+		PM3_WRITE_REG(par, PM3VideoControl, video);
 	}
-	PM3_SLOW_WRITE_REG(par, PM3VClkCtl,
+	PM3_WRITE_REG(par, PM3VClkCtl,
 			   (PM3_READ_REG(par, PM3VClkCtl) & 0xFFFFFFFC));
-	PM3_SLOW_WRITE_REG(par, PM3ScreenBase, par->base);
-	PM3_SLOW_WRITE_REG(par, PM3ChipConfig,
+	PM3_WRITE_REG(par, PM3ScreenBase, par->base);
+	PM3_WRITE_REG(par, PM3ChipConfig,
 			   (PM3_READ_REG(par, PM3ChipConfig) & 0xFFFFFFFD));
=20
+	wmb();
 	{
 		unsigned char uninitialized_var(m);	/* ClkPreScale=20
*/
 		unsigned char uninitialized_var(n);	/*=20
ClkFeedBackScale */
@@ -337,7 +325,7 @@ static void pm3fb_write_mode(struct fb_i
=20
 	PM3_WRITE_DAC_REG(par, PM3RD_DACControl, 0x00);
=20
-	switch (info->var.bits_per_pixel) {
+	switch (pm3fb_depth(&info->var)) {
 	case 8:
 		PM3_WRITE_DAC_REG(par, PM3RD_PixelSize,
 				  PM3RD_PixelSize_8_BIT_PIXELS);
@@ -393,57 +381,44 @@ static void pm3fb_write_mode(struct fb_i
  * hardware independent functions
  */
 int pm3fb_init(void);
-int pm3fb_setup(char*);
=20
 static int pm3fb_check_var(struct fb_var_screeninfo *var, struct=20
fb_info *info)
 {
 	u32 lpitch;
+	unsigned bpp =3D var->red.length + var->green.length
+			+ var->blue.length + var->transp.length;
=20
-	var->transp.offset =3D 0;
-	var->transp.length =3D 0;
-	switch(var->bits_per_pixel) {
-	case 8:
-		var->red.length =3D var->green.length =3D var->blue.length =3D=20
8;
-		var->red.offset =3D var->green.offset =3D var->blue.offset =3D=20
0;
-		break;
-	case 12:
-		var->red.offset   =3D 8;
-		var->red.length   =3D 4;
-		var->green.offset =3D 4;
-		var->green.length =3D 4;
-		var->blue.offset  =3D 0;
-		var->blue.length  =3D 4;
-		var->transp.offset =3D 12;
-		var->transp.length =3D 4;
-	case 15:
-		var->red.offset   =3D 10;
-		var->red.length   =3D 5;
-		var->green.offset =3D 5;
-		var->green.length =3D 5;
-		var->blue.offset  =3D 0;
-		var->blue.length  =3D 5;
-		var->transp.offset =3D 15;
-		var->transp.length =3D 1;
-		break;
-	case 16:
-		var->red.offset   =3D 11;
-		var->red.length   =3D 5;
-		var->green.offset =3D 5;
-		var->green.length =3D 6;
-		var->blue.offset  =3D 0;
-		var->blue.length  =3D 5;
-		break;
-	case 32:
-		var->transp.offset =3D 24;
-		var->transp.length =3D 8;
-		var->red.offset	  =3D 16;
-		var->green.offset =3D 8;
-		var->blue.offset  =3D 0;
-		var->red.length =3D var->green.length =3D var->blue.length =3D=20
8;
-		break;
-	default:
-		DPRINTK("depth not supported: %u\n",=20
var->bits_per_pixel);
-		return -EINVAL;
+	if ( bpp !=3D var->bits_per_pixel ) {
+		/* set predefined mode for bits_per_pixel settings */
+
+		switch(var->bits_per_pixel) {
+		case 8:
+			var->red.length =3D var->green.length =3D var->blue.
length =3D 8;
+			var->red.offset =3D var->green.offset =3D var->blue.
offset =3D 0;
+			var->transp.offset =3D 0;
+			var->transp.length =3D 0;
+			break;
+		case 16:
+			var->red.length =3D var->blue.length =3D 5;
+			var->green.length =3D 6;
+			var->transp.length =3D 0;
+			break;
+		case 32:
+			var->red.length =3D var->green.length =3D var->blue.
length =3D 8;
+			var->transp.length =3D 8;
+			break;
+		default:
+			DPRINTK("depth not supported: %u\n",=20
var->bits_per_pixel);
+			return -EINVAL;
+		}
+	}
+	/* it is assumed BGRA order */
+	if (var->bits_per_pixel > 8 )
+	{
+		var->blue.offset =3D 0;
+		var->green.offset =3D var->blue.length;
+		var->red.offset =3D var->green.offset + var->green.length;
+		var->transp.offset =3D var->red.offset + var->red.length;
 	}
 	var->height =3D var->width =3D -1;
=20
@@ -502,10 +477,9 @@ static int pm3fb_set_par(struct fb_info=20
 {
 	struct pm3_par *par =3D info->par;
 	const u32 xres =3D (info->var.xres + 31) & ~31;
-	const int depth =3D (info->var.bits_per_pixel + 7) & ~7;
+	const unsigned bpp =3D info->var.bits_per_pixel;
=20
-	par->base =3D pm3fb_shift_bpp(info->var.bits_per_pixel,
-					(info->var.yoffset * xres)
+	par->base =3D pm3fb_shift_bpp(bpp,(info->var.yoffset * xres)
 					+ info->var.xoffset);
 	par->video =3D 0;
=20
@@ -530,12 +504,10 @@ static int pm3fb_set_par(struct fb_info=20
 		par->video |=3D PM3VideoControl_DISABLE;
 		DPRINTK("PM3Video disabled\n");
 	}
-	switch (depth) {
+	switch (bpp) {
 	case 8:
 		par->video |=3D PM3VideoControl_PIXELSIZE_8BIT;
 		break;
-	case 12:
-	case 15:
 	case 16:
 		par->video |=3D PM3VideoControl_PIXELSIZE_16BIT;
 		break;
@@ -548,11 +520,10 @@ static int pm3fb_set_par(struct fb_info=20
 	}
=20
 	info->fix.visual =3D
-		(depth =3D=3D 8) ? FB_VISUAL_PSEUDOCOLOR :=20
FB_VISUAL_TRUECOLOR;
+		(bpp =3D=3D 8) ? FB_VISUAL_PSEUDOCOLOR :=20
FB_VISUAL_TRUECOLOR;
 	info->fix.line_length =3D ((info->var.xres_virtual + 7)  &=20
~7)
-					* depth / 8;
+					* bpp / 8;
=20
-/*	pm3fb_clear_memory(info, 0);*/
 	pm3fb_clear_colormap(par, 0, 0, 0);
 	PM3_WRITE_DAC_REG(par, PM3RD_CursorMode,
 			  PM3RD_CursorMode_CURSOR_DISABLE);
@@ -580,8 +551,8 @@ static int pm3fb_setcolreg(unsigned regn
 	 *   var->{color}.length contains length of bitfield
 	 *   {hardwarespecific} contains width of DAC
 	 *   pseudo_palette[X] is programmed to (X << red.offset) |
-	 *				      (X << green.offset) |
-	 *				      (X << blue.offset)
+	 *					(X << green.offset) |
+	 *					(X << blue.offset)
 	 *   RAMDAC[X] is programmed to (red, green, blue)
 	 *   color depth =3D SUM(var->{color}.length)
 	 *
@@ -621,7 +592,6 @@ static int pm3fb_setcolreg(unsigned regn
 		case 8:
 			break;
 		case 16:
-		case 24:
 		case 32:
 			((u32*)(info->pseudo_palette))[regno] =3D v;
 			break;
@@ -643,7 +613,8 @@ static int pm3fb_pan_display(struct fb_v
 	par->base =3D pm3fb_shift_bpp(var->bits_per_pixel,
 					(var->yoffset * xres)
 					+ var->xoffset);
-	PM3_SLOW_WRITE_REG(par, PM3ScreenBase, par->base);
+	PM3_WAIT(par, 1);
+	PM3_WRITE_REG(par, PM3ScreenBase, par->base);
 	return 0;
 }
=20
@@ -665,30 +636,31 @@ static int pm3fb_blank(int blank_mode, s
=20
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
-		video =3D video | PM3VideoControl_ENABLE;
+		video |=3D PM3VideoControl_ENABLE;
 		break;
-	case FB_BLANK_NORMAL:	/* FIXME */
-		video =3D video & ~(PM3VideoControl_ENABLE);
+	case FB_BLANK_NORMAL:
+		video &=3D ~(PM3VideoControl_ENABLE);
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
-		video =3D video & ~(PM3VideoControl_HSYNC_MASK |
-				  PM3VideoControl_BLANK_ACTIVE_LOW);
+		video &=3D ~(PM3VideoControl_HSYNC_MASK |
+			  PM3VideoControl_BLANK_ACTIVE_LOW);
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
-		video =3D video & ~(PM3VideoControl_VSYNC_MASK |
-				  PM3VideoControl_BLANK_ACTIVE_LOW);
+		video &=3D ~(PM3VideoControl_VSYNC_MASK |
+			  PM3VideoControl_BLANK_ACTIVE_LOW);
 		break;
 	case FB_BLANK_POWERDOWN:
-		video =3D video & ~(PM3VideoControl_HSYNC_MASK |
-				  PM3VideoControl_VSYNC_MASK |
-				  PM3VideoControl_BLANK_ACTIVE_LOW);
+		video &=3D ~(PM3VideoControl_HSYNC_MASK |
+			  PM3VideoControl_VSYNC_MASK |
+			  PM3VideoControl_BLANK_ACTIVE_LOW);
 		break;
 	default:
 		DPRINTK("Unsupported blanking %d\n", blank_mode);
 		return 1;
 	}
=20
-	PM3_SLOW_WRITE_REG(par,PM3VideoControl, video);
+	PM3_WAIT(par, 1);
+	PM3_WRITE_REG(par,PM3VideoControl, video);
=20
 	return 0;
 }
@@ -703,9 +675,9 @@ static struct fb_ops pm3fb_ops =3D {
 	.fb_set_par	=3D pm3fb_set_par,
 	.fb_setcolreg	=3D pm3fb_setcolreg,
 	.fb_pan_display	=3D pm3fb_pan_display,
-	.fb_fillrect	=3D cfb_fillrect,		/* Needed !!! */
-	.fb_copyarea	=3D cfb_copyarea,		/* Needed !!! */
-	.fb_imageblit	=3D cfb_imageblit,	/* Needed !!! */
+	.fb_fillrect	=3D cfb_fillrect,
+	.fb_copyarea	=3D cfb_copyarea,
+	.fb_imageblit	=3D cfb_imageblit,
 	.fb_blank	=3D pm3fb_blank,
 };
=20
@@ -722,7 +694,7 @@ static unsigned long pm3fb_size_memory(s
 	unsigned long	memsize =3D 0, tempBypass, i, temp1, temp2;
 	unsigned char	__iomem *screen_mem;
=20
-	pm3fb_fix.smem_len =3D 64 * 1024 * 1024; /* request full=20
aperture size */
+	pm3fb_fix.smem_len =3D 64 * 1024l * 1024; /* request full=20
aperture size */
 	/* Linear frame buffer - request region and map it. */
 	if (!request_mem_region(pm3fb_fix.smem_start, pm3fb_fix.
smem_len,
 				 "pm3fb smem")) {
@@ -744,7 +716,8 @@ static unsigned long pm3fb_size_memory(s
=20
 	DPRINTK("PM3MemBypassWriteMask was: 0x%08lx\n", tempBypass)
;
=20
-	PM3_SLOW_WRITE_REG(par, PM3MemBypassWriteMask, 0xFFFFFFFF);
+	PM3_WAIT(par, 1);
+	PM3_WRITE_REG(par, PM3MemBypassWriteMask, 0xFFFFFFFF);
=20
 	/* pm3 split up memory, replicates, and do a lot of nasty=20
stuff IMHO ;-) */
 	for (i =3D 0; i < 32; i++) {
@@ -765,10 +738,9 @@ static unsigned long pm3fb_size_memory(s
 	if (memsize + 1 =3D=3D i) {
 		for (i =3D 0; i < 32; i++) {
 			/* Clear first 32MB ; 0 is 0, no need to byteswap */
-			writel(0x0000000,
-			       (screen_mem + (i * 1048576)));
-			mb();
+			writel(0x0000000, (screen_mem + (i * 1048576)));
 		}
+		wmb();
=20
 		for (i =3D 32; i < 64; i++) {
 			fb_writel(i * 0x00345678,
@@ -787,7 +759,8 @@ static unsigned long pm3fb_size_memory(s
 	}
 	DPRINTK("Second detect pass got %ld MB\n", memsize + 1);
=20
-	PM3_SLOW_WRITE_REG(par, PM3MemBypassWriteMask, tempBypass);
+	PM3_WAIT(par, 1);
+	PM3_WRITE_REG(par, PM3MemBypassWriteMask, tempBypass);
=20
 	iounmap(screen_mem);
 	release_mem_region(pm3fb_fix.smem_start, pm3fb_fix.
smem_len);
@@ -890,7 +863,6 @@ static int __devinit pm3fb_probe(struct=20
 		goto err_exit_both;
 	}
=20
-	/* This has to been done !!! */
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		retval =3D -ENOMEM;
 		goto err_exit_both;
@@ -907,7 +879,7 @@ static int __devinit pm3fb_probe(struct=20
 	}
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",=20
info->node,
 	   info->fix.id);
-	pci_set_drvdata(dev, info); /* or dev_set_drvdata(device,=20
info) */
+	pci_set_drvdata(dev, info);
 	return 0;
=20
  err_exit_all:
@@ -949,8 +921,7 @@ static void __devexit pm3fb_remove(struc
=20
 static struct pci_device_id pm3fb_id_table[] =3D {
 	{ PCI_VENDOR_ID_3DLABS, 0x0a,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
-	  0xff0000, 0 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, }
 };
=20
@@ -964,6 +935,22 @@ static struct pci_driver pm3fb_driver =3D=20
=20
 MODULE_DEVICE_TABLE(pci, pm3fb_id_table);
=20
+#ifndef MODULE
+	/*
+	 *  Setup
+	 */
+
+/*
+ * Only necessary if your driver takes special options,
+ * otherwise we fall back on the generic fb_setup().
+ */
+static int __init pm3fb_setup(char *options)
+{
+	/* Parse user speficied options (`video=3Dpm3fb:') */
+	return 0;
+}
+#endif /* MODULE */
+
 int __init pm3fb_init(void)
 {
 	/*
@@ -985,22 +972,6 @@ static void __exit pm3fb_exit(void)
 	pci_unregister_driver(&pm3fb_driver);
 }
=20
-#ifdef MODULE
-	/*
-	 *  Setup
-	 */
-
-/*
- * Only necessary if your driver takes special options,
- * otherwise we fall back on the generic fb_setup().
- */
-int __init pm3fb_setup(char *options)
-{
-	/* Parse user speficied options (`video=3Dpm3fb:') */
-	return 0;
-}
-#endif /* MODULE */
-
 module_init(pm3fb_init);
 module_exit(pm3fb_exit);
=20


----------------------------------------------------
Juwenalia Krakowskie 2007. Hey, Coma, Myslovitz,=20
Vavamuffin. Kabaretony i wielki korow=F3d
7-13 maja Klub =AFaczek, Studio, Rotunda i Stadion Wis=B3y
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fjuwenaliak=
rakow.html&sid=3D1136

--part4646005017024
Content-Type: application/octet-stream; name="pm3fb-fixes.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm3fb-fixes.diff"

LS0tIGxpbnV4LTIuNi4yMS5vcmlnL2RyaXZlcnMvdmlkZW8vcG0zZmIuYwkyMDA3LTA1LTEyIDA4
OjQxOjIyLjkxMzM5MjAwMCArMDIwMAorKysgbGludXgtMi42LjIxL2RyaXZlcnMvdmlkZW8vcG0z
ZmIuYwkyMDA3LTA1LTEyIDE5OjQxOjE0LjA0MTIxMjcwMSArMDIwMApAQCAtNTIsMTEgKzUyLDYg
QEAKIHN0YXRpYyBjaGFyICptb2RlX29wdGlvbiBfX2RldmluaXRkYXRhOwogCiAvKgotICogIElm
IHlvdXIgZHJpdmVyIHN1cHBvcnRzIG11bHRpcGxlIGJvYXJkcywgeW91IHNob3VsZCBtYWtlIHRo
ZQotICogIGJlbG93IGRhdGEgdHlwZXMgYXJyYXlzLCBvciBhbGxvY2F0ZSB0aGVtIGR5bmFtaWNh
bGx5ICh1c2luZyBrbWFsbG9jKCkpLgotICovCi0KLS8qCiAgKiBUaGlzIHN0cnVjdHVyZSBkZWZp
bmVzIHRoZSBoYXJkd2FyZSBzdGF0ZSBvZiB0aGUgZ3JhcGhpY3MgY2FyZC4gTm9ybWFsbHkKICAq
IHlvdSBwbGFjZSB0aGlzIGluIGEgaGVhZGVyIGZpbGUgaW4gbGludXgvaW5jbHVkZS92aWRlby4g
VGhpcyBmaWxlIHVzdWFsbHkKICAqIGFsc28gaW5jbHVkZXMgcmVnaXN0ZXIgaW5mb3JtYXRpb24u
IFRoYXQgYWxsb3dzIG90aGVyIGRyaXZlciBzdWJzeXN0ZW1zCkBAIC02Nyw3ICs2Miw3IEBAIHN0
cnVjdCBwbTNfcGFyIHsKIAl1bnNpZ25lZCBjaGFyCV9faW9tZW0gKnZfcmVnczsvKiB2aXJ0dWFs
IGFkZHJlc3Mgb2YgcF9yZWdzICovCiAJdTMyCQl2aWRlbzsJCS8qIHZpZGVvIGZsYWdzIGJlZm9y
ZSBibGFua2luZyAqLwogCXUzMgkJYmFzZTsJCS8qIHNjcmVlbiBiYXNlICh4b2Zmc2V0K3lvZmZz
ZXQpIGluIDEyOCBiaXRzIHVuaXQgKi8KLQl1MzIgCQlwYWxldHRlWzE2XTsKKwl1MzIJCXBhbGV0
dGVbMTZdOwogfTsKIAogLyoKQEAgLTEwNCwzNiArOTksMjggQEAgc3RhdGljIGlubGluZSB2b2lk
IFBNM19XQUlUKHN0cnVjdCBwbTNfcAogCXdoaWxlIChQTTNfUkVBRF9SRUcocGFyLCBQTTNJbkZJ
Rk9TcGFjZSkgPCBuKTsKIH0KIAotc3RhdGljIGlubGluZSB2b2lkIFBNM19TTE9XX1dSSVRFX1JF
RyhzdHJ1Y3QgcG0zX3BhciAqcGFyLCBzMzIgb2ZmLCB1MzIgdikKLXsKLQlpZiAocGFyLT52X3Jl
Z3MpIHsKLQkJbWIoKTsKLQkJUE0zX1dBSVQocGFyLCAxKTsKLQkJd21iKCk7Ci0JCVBNM19XUklU
RV9SRUcocGFyLCBvZmYsIHYpOwotCX0KLX0KLQotc3RhdGljIGlubGluZSB2b2lkIFBNM19TRVRf
SU5ERVgoc3RydWN0IHBtM19wYXIgKnBhciwgdW5zaWduZWQgaW5kZXgpCi17Ci0JUE0zX1NMT1df
V1JJVEVfUkVHKHBhciwgUE0zUkRfSW5kZXhIaWdoLCAoaW5kZXggPj4gOCkgJiAweGZmKTsKLQlQ
TTNfU0xPV19XUklURV9SRUcocGFyLCBQTTNSRF9JbmRleExvdywgaW5kZXggJiAweGZmKTsKLX0K
LQogc3RhdGljIGlubGluZSB2b2lkIFBNM19XUklURV9EQUNfUkVHKHN0cnVjdCBwbTNfcGFyICpw
YXIsIHVuc2lnbmVkIHIsIHU4IHYpCiB7Ci0JUE0zX1NFVF9JTkRFWChwYXIsIHIpOworCVBNM19X
QUlUKHBhciwgMyk7CisJUE0zX1dSSVRFX1JFRyhwYXIsIFBNM1JEX0luZGV4SGlnaCwgKHIgPj4g
OCkgJiAweGZmKTsKKwlQTTNfV1JJVEVfUkVHKHBhciwgUE0zUkRfSW5kZXhMb3csIHIgJiAweGZm
KTsKIAl3bWIoKTsKIAlQTTNfV1JJVEVfUkVHKHBhciwgUE0zUkRfSW5kZXhlZERhdGEsIHYpOwor
CXdtYigpOwogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQgcG0zZmJfc2V0X2NvbG9yKHN0cnVjdCBw
bTNfcGFyICpwYXIsIHVuc2lnbmVkIGNoYXIgcmVnbm8sCiAJCQl1bnNpZ25lZCBjaGFyIHIsIHVu
c2lnbmVkIGNoYXIgZywgdW5zaWduZWQgY2hhciBiKQogewotCVBNM19TTE9XX1dSSVRFX1JFRyhw
YXIsIFBNM1JEX1BhbGV0dGVXcml0ZUFkZHJlc3MsIHJlZ25vKTsKLQlQTTNfU0xPV19XUklURV9S
RUcocGFyLCBQTTNSRF9QYWxldHRlRGF0YSwgcik7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwg
UE0zUkRfUGFsZXR0ZURhdGEsIGcpOwotCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM1JEX1Bh
bGV0dGVEYXRhLCBiKTsKKwlQTTNfV0FJVChwYXIsIDQpOworCVBNM19XUklURV9SRUcocGFyLCBQ
TTNSRF9QYWxldHRlV3JpdGVBZGRyZXNzLCByZWdubyk7CisJd21iKCk7CisJUE0zX1dSSVRFX1JF
RyhwYXIsIFBNM1JEX1BhbGV0dGVEYXRhLCByKTsKKwl3bWIoKTsKKwlQTTNfV1JJVEVfUkVHKHBh
ciwgUE0zUkRfUGFsZXR0ZURhdGEsIGcpOworCXdtYigpOworCVBNM19XUklURV9SRUcocGFyLCBQ
TTNSRF9QYWxldHRlRGF0YSwgYik7CisJd21iKCk7CiB9CiAKIHN0YXRpYyB2b2lkIHBtM2ZiX2Ns
ZWFyX2NvbG9ybWFwKHN0cnVjdCBwbTNfcGFyICpwYXIsCkBAIC0xNDEsNyArMTI4LDcgQEAgc3Rh
dGljIHZvaWQgcG0zZmJfY2xlYXJfY29sb3JtYXAoc3RydWN0IAogewogCWludCBpOwogCi0JZm9y
IChpID0gMDsgaSA8IDI1NiA7IGkrKykgLyogZmlsbCBjb2xvciBtYXAgd2l0aCB3aGl0ZSAqLwor
CWZvciAoaSA9IDA7IGkgPCAyNTYgOyBpKyspCiAJCXBtM2ZiX3NldF9jb2xvcihwYXIsIGksIHIs
IGcsIGIpOwogCiB9CkBAIC0xNzUsMTkgKzE2MiwyNiBAQCBzdGF0aWMgdm9pZCBwbTNmYl9jYWxj
dWxhdGVfY2xvY2sodW5zaWduCiAJfQogfQogCi1zdGF0aWMgaW5saW5lIGludCBwbTNmYl9zaGlm
dF9icHAodW5zaWduZWQgbG9uZyBkZXB0aCwgaW50IHYpCitzdGF0aWMgaW5saW5lIGludCBwbTNm
Yl9kZXB0aChjb25zdCBzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhcikKK3sKKwlpZiAoIHZh
ci0+Yml0c19wZXJfcGl4ZWwgPT0gMTYgKQorCQlyZXR1cm4gdmFyLT5yZWQubGVuZ3RoICsgdmFy
LT5ncmVlbi5sZW5ndGgKKwkJCSsgdmFyLT5ibHVlLmxlbmd0aDsKKworCXJldHVybiB2YXItPmJp
dHNfcGVyX3BpeGVsOworfQorCitzdGF0aWMgaW5saW5lIGludCBwbTNmYl9zaGlmdF9icHAodW5z
aWduZWQgYnBwLCBpbnQgdikKIHsKLQlzd2l0Y2ggKGRlcHRoKSB7CisJc3dpdGNoIChicHApIHsK
IAljYXNlIDg6CiAJCXJldHVybiAodiA+PiA0KTsKLQljYXNlIDEyOgotCWNhc2UgMTU6CiAJY2Fz
ZSAxNjoKIAkJcmV0dXJuICh2ID4+IDMpOwogCWNhc2UgMzI6CiAJCXJldHVybiAodiA+PiAyKTsK
IAl9Ci0JRFBSSU5USygiVW5zdXBwb3J0ZWQgZGVwdGggJWxkXG4iLCBkZXB0aCk7CisJRFBSSU5U
SygiVW5zdXBwb3J0ZWQgZGVwdGggJXVcbiIsIGJwcCk7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTIw
Niw1NiArMjAwLDUwIEBAIHN0YXRpYyB2b2lkIHBtM2ZiX3dyaXRlX21vZGUoc3RydWN0IGZiX2kK
IAljb25zdCB1MzIgdmJlbmQgPSB2c2VuZCArIGluZm8tPnZhci51cHBlcl9tYXJnaW47CiAJY29u
c3QgdTMyIHZ0b3RhbCA9IGluZm8tPnZhci55cmVzICsgdmJlbmQ7CiAJY29uc3QgdTMyIHdpZHRo
ID0gKGluZm8tPnZhci54cmVzX3ZpcnR1YWwgKyA3KSAmIH43OworCWNvbnN0IHVuc2lnbmVkIGJw
cCA9IGluZm8tPnZhci5iaXRzX3Blcl9waXhlbDsKIAotCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIs
IFBNM01lbUJ5cGFzc1dyaXRlTWFzaywgMHhmZmZmZmZmZik7Ci0JUE0zX1NMT1dfV1JJVEVfUkVH
KHBhciwgUE0zQXBlcnR1cmUwLCAweDAwMDAwMDAwKTsKLQlQTTNfU0xPV19XUklURV9SRUcocGFy
LCBQTTNBcGVydHVyZTEsIDB4MDAwMDAwMDApOwotCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBN
M0ZJRk9EaXMsIDB4MDAwMDAwMDcpOwotCi0JUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zSFRv
dGFsLAotCQkJICAgcG0zZmJfc2hpZnRfYnBwKGluZm8tPnZhci5iaXRzX3Blcl9waXhlbCwKLQkJ
CQkJICBodG90YWwgLSAxKSk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zSHNFbmQsCi0J
CQkgICBwbTNmYl9zaGlmdF9icHAoaW5mby0+dmFyLmJpdHNfcGVyX3BpeGVsLAotCQkJCQkgIGhz
ZW5kKSk7Ci0JUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zSHNTdGFydCwKLQkJCSAgIHBtM2Zi
X3NoaWZ0X2JwcChpbmZvLT52YXIuYml0c19wZXJfcGl4ZWwsCi0JCQkJCSAgaHNzdGFydCkpOwot
CVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM0hiRW5kLAotCQkJICAgcG0zZmJfc2hpZnRfYnBw
KGluZm8tPnZhci5iaXRzX3Blcl9waXhlbCwKLQkJCQkJICBoYmVuZCkpOwotCVBNM19TTE9XX1dS
SVRFX1JFRyhwYXIsIFBNM0hnRW5kLAotCQkJICAgcG0zZmJfc2hpZnRfYnBwKGluZm8tPnZhci5i
aXRzX3Blcl9waXhlbCwKLQkJCQkJICBoYmVuZCkpOwotCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIs
IFBNM1NjcmVlblN0cmlkZSwKLQkJCSAgIHBtM2ZiX3NoaWZ0X2JwcChpbmZvLT52YXIuYml0c19w
ZXJfcGl4ZWwsCi0JCQkJCSAgd2lkdGgpKTsKLQlQTTNfU0xPV19XUklURV9SRUcocGFyLCBQTTNW
VG90YWwsIHZ0b3RhbCAtIDEpOwotCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM1ZzRW5kLCB2
c2VuZCAtIDEpOwotCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM1ZzU3RhcnQsIHZzc3RhcnQg
LSAxKTsKLQlQTTNfU0xPV19XUklURV9SRUcocGFyLCBQTTNWYkVuZCwgdmJlbmQpOworCVBNM19X
QUlUKHBhciwgMjApOworCVBNM19XUklURV9SRUcocGFyLCBQTTNNZW1CeXBhc3NXcml0ZU1hc2ss
IDB4ZmZmZmZmZmYpOworCVBNM19XUklURV9SRUcocGFyLCBQTTNBcGVydHVyZTAsIDB4MDAwMDAw
MDApOworCVBNM19XUklURV9SRUcocGFyLCBQTTNBcGVydHVyZTEsIDB4MDAwMDAwMDApOworCVBN
M19XUklURV9SRUcocGFyLCBQTTNGSUZPRGlzLCAweDAwMDAwMDA3KTsKKworCVBNM19XUklURV9S
RUcocGFyLCBQTTNIVG90YWwsCisJCQkgICBwbTNmYl9zaGlmdF9icHAoYnBwLCBodG90YWwgLSAx
KSk7CisJUE0zX1dSSVRFX1JFRyhwYXIsIFBNM0hzRW5kLAorCQkJICAgcG0zZmJfc2hpZnRfYnBw
KGJwcCwgaHNlbmQpKTsKKwlQTTNfV1JJVEVfUkVHKHBhciwgUE0zSHNTdGFydCwKKwkJCSAgIHBt
M2ZiX3NoaWZ0X2JwcChicHAsIGhzc3RhcnQpKTsKKwlQTTNfV1JJVEVfUkVHKHBhciwgUE0zSGJF
bmQsCisJCQkgICBwbTNmYl9zaGlmdF9icHAoYnBwLCBoYmVuZCkpOworCVBNM19XUklURV9SRUco
cGFyLCBQTTNIZ0VuZCwKKwkJCSAgIHBtM2ZiX3NoaWZ0X2JwcChicHAsIGhiZW5kKSk7CisJUE0z
X1dSSVRFX1JFRyhwYXIsIFBNM1NjcmVlblN0cmlkZSwKKwkJCSAgIHBtM2ZiX3NoaWZ0X2JwcChi
cHAsIHdpZHRoKSk7CisJUE0zX1dSSVRFX1JFRyhwYXIsIFBNM1ZUb3RhbCwgdnRvdGFsIC0gMSk7
CisJUE0zX1dSSVRFX1JFRyhwYXIsIFBNM1ZzRW5kLCB2c2VuZCAtIDEpOworCVBNM19XUklURV9S
RUcocGFyLCBQTTNWc1N0YXJ0LCB2c3N0YXJ0IC0gMSk7CisJUE0zX1dSSVRFX1JFRyhwYXIsIFBN
M1ZiRW5kLCB2YmVuZCk7CiAKLQlzd2l0Y2ggKGluZm8tPnZhci5iaXRzX3Blcl9waXhlbCkgewor
CXN3aXRjaCAoYnBwKSB7CiAJY2FzZSA4OgotCQlQTTNfU0xPV19XUklURV9SRUcocGFyLCBQTTNC
eUFwZXJ0dXJlMU1vZGUsCisJCVBNM19XUklURV9SRUcocGFyLCBQTTNCeUFwZXJ0dXJlMU1vZGUs
CiAJCQkJICAgUE0zQnlBcGVydHVyZU1vZGVfUElYRUxTSVpFXzhCSVQpOwotCQlQTTNfU0xPV19X
UklURV9SRUcocGFyLCBQTTNCeUFwZXJ0dXJlMk1vZGUsCisJCVBNM19XUklURV9SRUcocGFyLCBQ
TTNCeUFwZXJ0dXJlMk1vZGUsCiAJCQkJICAgUE0zQnlBcGVydHVyZU1vZGVfUElYRUxTSVpFXzhC
SVQpOwogCQlicmVhazsKIAotCWNhc2UgMTI6Ci0JY2FzZSAxNToKIAljYXNlIDE2OgogI2lmbmRl
ZiBfX0JJR19FTkRJQU4KLQkJUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zQnlBcGVydHVyZTFN
b2RlLAorCQlQTTNfV1JJVEVfUkVHKHBhciwgUE0zQnlBcGVydHVyZTFNb2RlLAogCQkJCSAgIFBN
M0J5QXBlcnR1cmVNb2RlX1BJWEVMU0laRV8xNkJJVCk7Ci0JCVBNM19TTE9XX1dSSVRFX1JFRyhw
YXIsIFBNM0J5QXBlcnR1cmUyTW9kZSwKKwkJUE0zX1dSSVRFX1JFRyhwYXIsIFBNM0J5QXBlcnR1
cmUyTW9kZSwKIAkJCQkgICBQTTNCeUFwZXJ0dXJlTW9kZV9QSVhFTFNJWkVfMTZCSVQpOwogI2Vs
c2UKLQkJUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zQnlBcGVydHVyZTFNb2RlLAorCQlQTTNf
V1JJVEVfUkVHKHBhciwgUE0zQnlBcGVydHVyZTFNb2RlLAogCQkJCSAgIFBNM0J5QXBlcnR1cmVN
b2RlX1BJWEVMU0laRV8xNkJJVCB8CiAJCQkJICAgUE0zQnlBcGVydHVyZU1vZGVfQllURVNXQVBf
QkFEQyk7Ci0JCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM0J5QXBlcnR1cmUyTW9kZSwKKwkJ
UE0zX1dSSVRFX1JFRyhwYXIsIFBNM0J5QXBlcnR1cmUyTW9kZSwKIAkJCQkgICBQTTNCeUFwZXJ0
dXJlTW9kZV9QSVhFTFNJWkVfMTZCSVQgfAogCQkJCSAgIFBNM0J5QXBlcnR1cmVNb2RlX0JZVEVT
V0FQX0JBREMpOwogI2VuZGlmIC8qICEgX19CSUdfRU5ESUFOICovCkBAIC0yNjMsMjMgKzI1MSwy
MiBAQCBzdGF0aWMgdm9pZCBwbTNmYl93cml0ZV9tb2RlKHN0cnVjdCBmYl9pCiAKIAljYXNlIDMy
OgogI2lmbmRlZiBfX0JJR19FTkRJQU4KLQkJUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zQnlB
cGVydHVyZTFNb2RlLAorCQlQTTNfV1JJVEVfUkVHKHBhciwgUE0zQnlBcGVydHVyZTFNb2RlLAog
CQkJCSAgIFBNM0J5QXBlcnR1cmVNb2RlX1BJWEVMU0laRV8zMkJJVCk7Ci0JCVBNM19TTE9XX1dS
SVRFX1JFRyhwYXIsIFBNM0J5QXBlcnR1cmUyTW9kZSwKKwkJUE0zX1dSSVRFX1JFRyhwYXIsIFBN
M0J5QXBlcnR1cmUyTW9kZSwKIAkJCQkgICBQTTNCeUFwZXJ0dXJlTW9kZV9QSVhFTFNJWkVfMzJC
SVQpOwogI2Vsc2UKLQkJUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zQnlBcGVydHVyZTFNb2Rl
LAorCQlQTTNfV1JJVEVfUkVHKHBhciwgUE0zQnlBcGVydHVyZTFNb2RlLAogCQkJCSAgIFBNM0J5
QXBlcnR1cmVNb2RlX1BJWEVMU0laRV8zMkJJVCB8CiAJCQkJICAgUE0zQnlBcGVydHVyZU1vZGVf
QllURVNXQVBfRENCQSk7Ci0JCVBNM19TTE9XX1dSSVRFX1JFRyhwYXIsIFBNM0J5QXBlcnR1cmUy
TW9kZSwKKwkJUE0zX1dSSVRFX1JFRyhwYXIsIFBNM0J5QXBlcnR1cmUyTW9kZSwKIAkJCQkgICBQ
TTNCeUFwZXJ0dXJlTW9kZV9QSVhFTFNJWkVfMzJCSVQgfAogCQkJCSAgIFBNM0J5QXBlcnR1cmVN
b2RlX0JZVEVTV0FQX0RDQkEpOwogI2VuZGlmIC8qICEgX19CSUdfRU5ESUFOICovCiAJCWJyZWFr
OwogCiAJZGVmYXVsdDoKLQkJRFBSSU5USygiVW5zdXBwb3J0ZWQgZGVwdGggJWRcbiIsCi0JCQlp
bmZvLT52YXIuYml0c19wZXJfcGl4ZWwpOworCQlEUFJJTlRLKCJVbnN1cHBvcnRlZCBkZXB0aCAl
ZFxuIiwgYnBwKTsKIAkJYnJlYWs7CiAJfQogCkBAIC0yOTYsMTQgKzI4MywxNSBAQCBzdGF0aWMg
dm9pZCBwbTNmYl93cml0ZV9tb2RlKHN0cnVjdCBmYl9pCiAJCQkgICBQTTNWaWRlb0NvbnRyb2xf
VlNZTkNfTUFTSyk7CiAJCXZpZGVvIHw9IFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19BQ1RJVkVfSElH
SCB8CiAJCQkgUE0zVmlkZW9Db250cm9sX1ZTWU5DX0FDVElWRV9ISUdIOwotCQlQTTNfU0xPV19X
UklURV9SRUcocGFyLCBQTTNWaWRlb0NvbnRyb2wsIHZpZGVvKTsKKwkJUE0zX1dSSVRFX1JFRyhw
YXIsIFBNM1ZpZGVvQ29udHJvbCwgdmlkZW8pOwogCX0KLQlQTTNfU0xPV19XUklURV9SRUcocGFy
LCBQTTNWQ2xrQ3RsLAorCVBNM19XUklURV9SRUcocGFyLCBQTTNWQ2xrQ3RsLAogCQkJICAgKFBN
M19SRUFEX1JFRyhwYXIsIFBNM1ZDbGtDdGwpICYgMHhGRkZGRkZGQykpOwotCVBNM19TTE9XX1dS
SVRFX1JFRyhwYXIsIFBNM1NjcmVlbkJhc2UsIHBhci0+YmFzZSk7Ci0JUE0zX1NMT1dfV1JJVEVf
UkVHKHBhciwgUE0zQ2hpcENvbmZpZywKKwlQTTNfV1JJVEVfUkVHKHBhciwgUE0zU2NyZWVuQmFz
ZSwgcGFyLT5iYXNlKTsKKwlQTTNfV1JJVEVfUkVHKHBhciwgUE0zQ2hpcENvbmZpZywKIAkJCSAg
IChQTTNfUkVBRF9SRUcocGFyLCBQTTNDaGlwQ29uZmlnKSAmIDB4RkZGRkZGRkQpKTsKIAorCXdt
YigpOwogCXsKIAkJdW5zaWduZWQgY2hhciB1bmluaXRpYWxpemVkX3ZhcihtKTsJLyogQ2xrUHJl
U2NhbGUgKi8KIAkJdW5zaWduZWQgY2hhciB1bmluaXRpYWxpemVkX3ZhcihuKTsJLyogQ2xrRmVl
ZEJhY2tTY2FsZSAqLwpAQCAtMzM3LDcgKzMyNSw3IEBAIHN0YXRpYyB2b2lkIHBtM2ZiX3dyaXRl
X21vZGUoc3RydWN0IGZiX2kKIAogCVBNM19XUklURV9EQUNfUkVHKHBhciwgUE0zUkRfREFDQ29u
dHJvbCwgMHgwMCk7CiAKLQlzd2l0Y2ggKGluZm8tPnZhci5iaXRzX3Blcl9waXhlbCkgeworCXN3
aXRjaCAocG0zZmJfZGVwdGgoJmluZm8tPnZhcikpIHsKIAljYXNlIDg6CiAJCVBNM19XUklURV9E
QUNfUkVHKHBhciwgUE0zUkRfUGl4ZWxTaXplLAogCQkJCSAgUE0zUkRfUGl4ZWxTaXplXzhfQklU
X1BJWEVMUyk7CkBAIC0zOTMsNTcgKzM4MSw0NCBAQCBzdGF0aWMgdm9pZCBwbTNmYl93cml0ZV9t
b2RlKHN0cnVjdCBmYl9pCiAgKiBoYXJkd2FyZSBpbmRlcGVuZGVudCBmdW5jdGlvbnMKICAqLwog
aW50IHBtM2ZiX2luaXQodm9pZCk7Ci1pbnQgcG0zZmJfc2V0dXAoY2hhciopOwogCiBzdGF0aWMg
aW50IHBtM2ZiX2NoZWNrX3ZhcihzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciwgc3RydWN0
IGZiX2luZm8gKmluZm8pCiB7CiAJdTMyIGxwaXRjaDsKKwl1bnNpZ25lZCBicHAgPSB2YXItPnJl
ZC5sZW5ndGggKyB2YXItPmdyZWVuLmxlbmd0aAorCQkJKyB2YXItPmJsdWUubGVuZ3RoICsgdmFy
LT50cmFuc3AubGVuZ3RoOwogCi0JdmFyLT50cmFuc3Aub2Zmc2V0ID0gMDsKLQl2YXItPnRyYW5z
cC5sZW5ndGggPSAwOwotCXN3aXRjaCh2YXItPmJpdHNfcGVyX3BpeGVsKSB7Ci0JY2FzZSA4Ogot
CQl2YXItPnJlZC5sZW5ndGggPSB2YXItPmdyZWVuLmxlbmd0aCA9IHZhci0+Ymx1ZS5sZW5ndGgg
PSA4OwotCQl2YXItPnJlZC5vZmZzZXQgPSB2YXItPmdyZWVuLm9mZnNldCA9IHZhci0+Ymx1ZS5v
ZmZzZXQgPSAwOwotCQlicmVhazsKLQljYXNlIDEyOgotCQl2YXItPnJlZC5vZmZzZXQgICA9IDg7
Ci0JCXZhci0+cmVkLmxlbmd0aCAgID0gNDsKLQkJdmFyLT5ncmVlbi5vZmZzZXQgPSA0OwotCQl2
YXItPmdyZWVuLmxlbmd0aCA9IDQ7Ci0JCXZhci0+Ymx1ZS5vZmZzZXQgID0gMDsKLQkJdmFyLT5i
bHVlLmxlbmd0aCAgPSA0OwotCQl2YXItPnRyYW5zcC5vZmZzZXQgPSAxMjsKLQkJdmFyLT50cmFu
c3AubGVuZ3RoID0gNDsKLQljYXNlIDE1OgotCQl2YXItPnJlZC5vZmZzZXQgICA9IDEwOwotCQl2
YXItPnJlZC5sZW5ndGggICA9IDU7Ci0JCXZhci0+Z3JlZW4ub2Zmc2V0ID0gNTsKLQkJdmFyLT5n
cmVlbi5sZW5ndGggPSA1OwotCQl2YXItPmJsdWUub2Zmc2V0ICA9IDA7Ci0JCXZhci0+Ymx1ZS5s
ZW5ndGggID0gNTsKLQkJdmFyLT50cmFuc3Aub2Zmc2V0ID0gMTU7Ci0JCXZhci0+dHJhbnNwLmxl
bmd0aCA9IDE7Ci0JCWJyZWFrOwotCWNhc2UgMTY6Ci0JCXZhci0+cmVkLm9mZnNldCAgID0gMTE7
Ci0JCXZhci0+cmVkLmxlbmd0aCAgID0gNTsKLQkJdmFyLT5ncmVlbi5vZmZzZXQgPSA1OwotCQl2
YXItPmdyZWVuLmxlbmd0aCA9IDY7Ci0JCXZhci0+Ymx1ZS5vZmZzZXQgID0gMDsKLQkJdmFyLT5i
bHVlLmxlbmd0aCAgPSA1OwotCQlicmVhazsKLQljYXNlIDMyOgotCQl2YXItPnRyYW5zcC5vZmZz
ZXQgPSAyNDsKLQkJdmFyLT50cmFuc3AubGVuZ3RoID0gODsKLQkJdmFyLT5yZWQub2Zmc2V0CSAg
PSAxNjsKLQkJdmFyLT5ncmVlbi5vZmZzZXQgPSA4OwotCQl2YXItPmJsdWUub2Zmc2V0ICA9IDA7
Ci0JCXZhci0+cmVkLmxlbmd0aCA9IHZhci0+Z3JlZW4ubGVuZ3RoID0gdmFyLT5ibHVlLmxlbmd0
aCA9IDg7Ci0JCWJyZWFrOwotCWRlZmF1bHQ6Ci0JCURQUklOVEsoImRlcHRoIG5vdCBzdXBwb3J0
ZWQ6ICV1XG4iLCB2YXItPmJpdHNfcGVyX3BpeGVsKTsKLQkJcmV0dXJuIC1FSU5WQUw7CisJaWYg
KCBicHAgIT0gdmFyLT5iaXRzX3Blcl9waXhlbCApIHsKKwkJLyogc2V0IHByZWRlZmluZWQgbW9k
ZSBmb3IgYml0c19wZXJfcGl4ZWwgc2V0dGluZ3MgKi8KKworCQlzd2l0Y2godmFyLT5iaXRzX3Bl
cl9waXhlbCkgeworCQljYXNlIDg6CisJCQl2YXItPnJlZC5sZW5ndGggPSB2YXItPmdyZWVuLmxl
bmd0aCA9IHZhci0+Ymx1ZS5sZW5ndGggPSA4OworCQkJdmFyLT5yZWQub2Zmc2V0ID0gdmFyLT5n
cmVlbi5vZmZzZXQgPSB2YXItPmJsdWUub2Zmc2V0ID0gMDsKKwkJCXZhci0+dHJhbnNwLm9mZnNl
dCA9IDA7CisJCQl2YXItPnRyYW5zcC5sZW5ndGggPSAwOworCQkJYnJlYWs7CisJCWNhc2UgMTY6
CisJCQl2YXItPnJlZC5sZW5ndGggPSB2YXItPmJsdWUubGVuZ3RoID0gNTsKKwkJCXZhci0+Z3Jl
ZW4ubGVuZ3RoID0gNjsKKwkJCXZhci0+dHJhbnNwLmxlbmd0aCA9IDA7CisJCQlicmVhazsKKwkJ
Y2FzZSAzMjoKKwkJCXZhci0+cmVkLmxlbmd0aCA9IHZhci0+Z3JlZW4ubGVuZ3RoID0gdmFyLT5i
bHVlLmxlbmd0aCA9IDg7CisJCQl2YXItPnRyYW5zcC5sZW5ndGggPSA4OworCQkJYnJlYWs7CisJ
CWRlZmF1bHQ6CisJCQlEUFJJTlRLKCJkZXB0aCBub3Qgc3VwcG9ydGVkOiAldVxuIiwgdmFyLT5i
aXRzX3Blcl9waXhlbCk7CisJCQlyZXR1cm4gLUVJTlZBTDsKKwkJfQorCX0KKwkvKiBpdCBpcyBh
c3N1bWVkIEJHUkEgb3JkZXIgKi8KKwlpZiAodmFyLT5iaXRzX3Blcl9waXhlbCA+IDggKQorCXsK
KwkJdmFyLT5ibHVlLm9mZnNldCA9IDA7CisJCXZhci0+Z3JlZW4ub2Zmc2V0ID0gdmFyLT5ibHVl
Lmxlbmd0aDsKKwkJdmFyLT5yZWQub2Zmc2V0ID0gdmFyLT5ncmVlbi5vZmZzZXQgKyB2YXItPmdy
ZWVuLmxlbmd0aDsKKwkJdmFyLT50cmFuc3Aub2Zmc2V0ID0gdmFyLT5yZWQub2Zmc2V0ICsgdmFy
LT5yZWQubGVuZ3RoOwogCX0KIAl2YXItPmhlaWdodCA9IHZhci0+d2lkdGggPSAtMTsKIApAQCAt
NTAyLDEwICs0NzcsOSBAQCBzdGF0aWMgaW50IHBtM2ZiX3NldF9wYXIoc3RydWN0IGZiX2luZm8g
CiB7CiAJc3RydWN0IHBtM19wYXIgKnBhciA9IGluZm8tPnBhcjsKIAljb25zdCB1MzIgeHJlcyA9
IChpbmZvLT52YXIueHJlcyArIDMxKSAmIH4zMTsKLQljb25zdCBpbnQgZGVwdGggPSAoaW5mby0+
dmFyLmJpdHNfcGVyX3BpeGVsICsgNykgJiB+NzsKKwljb25zdCB1bnNpZ25lZCBicHAgPSBpbmZv
LT52YXIuYml0c19wZXJfcGl4ZWw7CiAKLQlwYXItPmJhc2UgPSBwbTNmYl9zaGlmdF9icHAoaW5m
by0+dmFyLmJpdHNfcGVyX3BpeGVsLAotCQkJCQkoaW5mby0+dmFyLnlvZmZzZXQgKiB4cmVzKQor
CXBhci0+YmFzZSA9IHBtM2ZiX3NoaWZ0X2JwcChicHAsKGluZm8tPnZhci55b2Zmc2V0ICogeHJl
cykKIAkJCQkJKyBpbmZvLT52YXIueG9mZnNldCk7CiAJcGFyLT52aWRlbyA9IDA7CiAKQEAgLTUz
MCwxMiArNTA0LDEwIEBAIHN0YXRpYyBpbnQgcG0zZmJfc2V0X3BhcihzdHJ1Y3QgZmJfaW5mbyAK
IAkJcGFyLT52aWRlbyB8PSBQTTNWaWRlb0NvbnRyb2xfRElTQUJMRTsKIAkJRFBSSU5USygiUE0z
VmlkZW8gZGlzYWJsZWRcbiIpOwogCX0KLQlzd2l0Y2ggKGRlcHRoKSB7CisJc3dpdGNoIChicHAp
IHsKIAljYXNlIDg6CiAJCXBhci0+dmlkZW8gfD0gUE0zVmlkZW9Db250cm9sX1BJWEVMU0laRV84
QklUOwogCQlicmVhazsKLQljYXNlIDEyOgotCWNhc2UgMTU6CiAJY2FzZSAxNjoKIAkJcGFyLT52
aWRlbyB8PSBQTTNWaWRlb0NvbnRyb2xfUElYRUxTSVpFXzE2QklUOwogCQlicmVhazsKQEAgLTU0
OCwxMSArNTIwLDEwIEBAIHN0YXRpYyBpbnQgcG0zZmJfc2V0X3BhcihzdHJ1Y3QgZmJfaW5mbyAK
IAl9CiAKIAlpbmZvLT5maXgudmlzdWFsID0KLQkJKGRlcHRoID09IDgpID8gRkJfVklTVUFMX1BT
RVVET0NPTE9SIDogRkJfVklTVUFMX1RSVUVDT0xPUjsKKwkJKGJwcCA9PSA4KSA/IEZCX1ZJU1VB
TF9QU0VVRE9DT0xPUiA6IEZCX1ZJU1VBTF9UUlVFQ09MT1I7CiAJaW5mby0+Zml4LmxpbmVfbGVu
Z3RoID0gKChpbmZvLT52YXIueHJlc192aXJ0dWFsICsgNykgICYgfjcpCi0JCQkJCSogZGVwdGgg
LyA4OworCQkJCQkqIGJwcCAvIDg7CiAKLS8qCXBtM2ZiX2NsZWFyX21lbW9yeShpbmZvLCAwKTsq
LwogCXBtM2ZiX2NsZWFyX2NvbG9ybWFwKHBhciwgMCwgMCwgMCk7CiAJUE0zX1dSSVRFX0RBQ19S
RUcocGFyLCBQTTNSRF9DdXJzb3JNb2RlLAogCQkJICBQTTNSRF9DdXJzb3JNb2RlX0NVUlNPUl9E
SVNBQkxFKTsKQEAgLTU4MCw4ICs1NTEsOCBAQCBzdGF0aWMgaW50IHBtM2ZiX3NldGNvbHJlZyh1
bnNpZ25lZCByZWduCiAJICogICB2YXItPntjb2xvcn0ubGVuZ3RoIGNvbnRhaW5zIGxlbmd0aCBv
ZiBiaXRmaWVsZAogCSAqICAge2hhcmR3YXJlc3BlY2lmaWN9IGNvbnRhaW5zIHdpZHRoIG9mIERB
QwogCSAqICAgcHNldWRvX3BhbGV0dGVbWF0gaXMgcHJvZ3JhbW1lZCB0byAoWCA8PCByZWQub2Zm
c2V0KSB8Ci0JICoJCQkJICAgICAgKFggPDwgZ3JlZW4ub2Zmc2V0KSB8Ci0JICoJCQkJICAgICAg
KFggPDwgYmx1ZS5vZmZzZXQpCisJICoJCQkJCShYIDw8IGdyZWVuLm9mZnNldCkgfAorCSAqCQkJ
CQkoWCA8PCBibHVlLm9mZnNldCkKIAkgKiAgIFJBTURBQ1tYXSBpcyBwcm9ncmFtbWVkIHRvIChy
ZWQsIGdyZWVuLCBibHVlKQogCSAqICAgY29sb3IgZGVwdGggPSBTVU0odmFyLT57Y29sb3J9Lmxl
bmd0aCkKIAkgKgpAQCAtNjIxLDcgKzU5Miw2IEBAIHN0YXRpYyBpbnQgcG0zZmJfc2V0Y29scmVn
KHVuc2lnbmVkIHJlZ24KIAkJY2FzZSA4OgogCQkJYnJlYWs7CiAJCWNhc2UgMTY6Ci0JCWNhc2Ug
MjQ6CiAJCWNhc2UgMzI6CiAJCQkoKHUzMiopKGluZm8tPnBzZXVkb19wYWxldHRlKSlbcmVnbm9d
ID0gdjsKIAkJCWJyZWFrOwpAQCAtNjQzLDcgKzYxMyw4IEBAIHN0YXRpYyBpbnQgcG0zZmJfcGFu
X2Rpc3BsYXkoc3RydWN0IGZiX3YKIAlwYXItPmJhc2UgPSBwbTNmYl9zaGlmdF9icHAodmFyLT5i
aXRzX3Blcl9waXhlbCwKIAkJCQkJKHZhci0+eW9mZnNldCAqIHhyZXMpCiAJCQkJCSsgdmFyLT54
b2Zmc2V0KTsKLQlQTTNfU0xPV19XUklURV9SRUcocGFyLCBQTTNTY3JlZW5CYXNlLCBwYXItPmJh
c2UpOworCVBNM19XQUlUKHBhciwgMSk7CisJUE0zX1dSSVRFX1JFRyhwYXIsIFBNM1NjcmVlbkJh
c2UsIHBhci0+YmFzZSk7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTY2NSwzMCArNjM2LDMxIEBAIHN0
YXRpYyBpbnQgcG0zZmJfYmxhbmsoaW50IGJsYW5rX21vZGUsIHMKIAogCXN3aXRjaCAoYmxhbmtf
bW9kZSkgewogCWNhc2UgRkJfQkxBTktfVU5CTEFOSzoKLQkJdmlkZW8gPSB2aWRlbyB8IFBNM1Zp
ZGVvQ29udHJvbF9FTkFCTEU7CisJCXZpZGVvIHw9IFBNM1ZpZGVvQ29udHJvbF9FTkFCTEU7CiAJ
CWJyZWFrOwotCWNhc2UgRkJfQkxBTktfTk9STUFMOgkvKiBGSVhNRSAqLwotCQl2aWRlbyA9IHZp
ZGVvICYgfihQTTNWaWRlb0NvbnRyb2xfRU5BQkxFKTsKKwljYXNlIEZCX0JMQU5LX05PUk1BTDoK
KwkJdmlkZW8gJj0gfihQTTNWaWRlb0NvbnRyb2xfRU5BQkxFKTsKIAkJYnJlYWs7CiAJY2FzZSBG
Ql9CTEFOS19IU1lOQ19TVVNQRU5EOgotCQl2aWRlbyA9IHZpZGVvICYgfihQTTNWaWRlb0NvbnRy
b2xfSFNZTkNfTUFTSyB8Ci0JCQkJICBQTTNWaWRlb0NvbnRyb2xfQkxBTktfQUNUSVZFX0xPVyk7
CisJCXZpZGVvICY9IH4oUE0zVmlkZW9Db250cm9sX0hTWU5DX01BU0sgfAorCQkJICBQTTNWaWRl
b0NvbnRyb2xfQkxBTktfQUNUSVZFX0xPVyk7CiAJCWJyZWFrOwogCWNhc2UgRkJfQkxBTktfVlNZ
TkNfU1VTUEVORDoKLQkJdmlkZW8gPSB2aWRlbyAmIH4oUE0zVmlkZW9Db250cm9sX1ZTWU5DX01B
U0sgfAotCQkJCSAgUE0zVmlkZW9Db250cm9sX0JMQU5LX0FDVElWRV9MT1cpOworCQl2aWRlbyAm
PSB+KFBNM1ZpZGVvQ29udHJvbF9WU1lOQ19NQVNLIHwKKwkJCSAgUE0zVmlkZW9Db250cm9sX0JM
QU5LX0FDVElWRV9MT1cpOwogCQlicmVhazsKIAljYXNlIEZCX0JMQU5LX1BPV0VSRE9XTjoKLQkJ
dmlkZW8gPSB2aWRlbyAmIH4oUE0zVmlkZW9Db250cm9sX0hTWU5DX01BU0sgfAotCQkJCSAgUE0z
VmlkZW9Db250cm9sX1ZTWU5DX01BU0sgfAotCQkJCSAgUE0zVmlkZW9Db250cm9sX0JMQU5LX0FD
VElWRV9MT1cpOworCQl2aWRlbyAmPSB+KFBNM1ZpZGVvQ29udHJvbF9IU1lOQ19NQVNLIHwKKwkJ
CSAgUE0zVmlkZW9Db250cm9sX1ZTWU5DX01BU0sgfAorCQkJICBQTTNWaWRlb0NvbnRyb2xfQkxB
TktfQUNUSVZFX0xPVyk7CiAJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCURQUklOVEsoIlVuc3VwcG9y
dGVkIGJsYW5raW5nICVkXG4iLCBibGFua19tb2RlKTsKIAkJcmV0dXJuIDE7CiAJfQogCi0JUE0z
X1NMT1dfV1JJVEVfUkVHKHBhcixQTTNWaWRlb0NvbnRyb2wsIHZpZGVvKTsKKwlQTTNfV0FJVChw
YXIsIDEpOworCVBNM19XUklURV9SRUcocGFyLFBNM1ZpZGVvQ29udHJvbCwgdmlkZW8pOwogCiAJ
cmV0dXJuIDA7CiB9CkBAIC03MDMsOSArNjc1LDkgQEAgc3RhdGljIHN0cnVjdCBmYl9vcHMgcG0z
ZmJfb3BzID0gewogCS5mYl9zZXRfcGFyCT0gcG0zZmJfc2V0X3BhciwKIAkuZmJfc2V0Y29scmVn
CT0gcG0zZmJfc2V0Y29scmVnLAogCS5mYl9wYW5fZGlzcGxheQk9IHBtM2ZiX3Bhbl9kaXNwbGF5
LAotCS5mYl9maWxscmVjdAk9IGNmYl9maWxscmVjdCwJCS8qIE5lZWRlZCAhISEgKi8KLQkuZmJf
Y29weWFyZWEJPSBjZmJfY29weWFyZWEsCQkvKiBOZWVkZWQgISEhICovCi0JLmZiX2ltYWdlYmxp
dAk9IGNmYl9pbWFnZWJsaXQsCS8qIE5lZWRlZCAhISEgKi8KKwkuZmJfZmlsbHJlY3QJPSBjZmJf
ZmlsbHJlY3QsCisJLmZiX2NvcHlhcmVhCT0gY2ZiX2NvcHlhcmVhLAorCS5mYl9pbWFnZWJsaXQJ
PSBjZmJfaW1hZ2VibGl0LAogCS5mYl9ibGFuawk9IHBtM2ZiX2JsYW5rLAogfTsKIApAQCAtNzIy
LDcgKzY5NCw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHBtM2ZiX3NpemVfbWVtb3J5KHMKIAl1
bnNpZ25lZCBsb25nCW1lbXNpemUgPSAwLCB0ZW1wQnlwYXNzLCBpLCB0ZW1wMSwgdGVtcDI7CiAJ
dW5zaWduZWQgY2hhcglfX2lvbWVtICpzY3JlZW5fbWVtOwogCi0JcG0zZmJfZml4LnNtZW1fbGVu
ID0gNjQgKiAxMDI0ICogMTAyNDsgLyogcmVxdWVzdCBmdWxsIGFwZXJ0dXJlIHNpemUgKi8KKwlw
bTNmYl9maXguc21lbV9sZW4gPSA2NCAqIDEwMjRsICogMTAyNDsgLyogcmVxdWVzdCBmdWxsIGFw
ZXJ0dXJlIHNpemUgKi8KIAkvKiBMaW5lYXIgZnJhbWUgYnVmZmVyIC0gcmVxdWVzdCByZWdpb24g
YW5kIG1hcCBpdC4gKi8KIAlpZiAoIXJlcXVlc3RfbWVtX3JlZ2lvbihwbTNmYl9maXguc21lbV9z
dGFydCwgcG0zZmJfZml4LnNtZW1fbGVuLAogCQkJCSAicG0zZmIgc21lbSIpKSB7CkBAIC03NDQs
NyArNzE2LDggQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgcG0zZmJfc2l6ZV9tZW1vcnkocwogCiAJ
RFBSSU5USygiUE0zTWVtQnlwYXNzV3JpdGVNYXNrIHdhczogMHglMDhseFxuIiwgdGVtcEJ5cGFz
cyk7CiAKLQlQTTNfU0xPV19XUklURV9SRUcocGFyLCBQTTNNZW1CeXBhc3NXcml0ZU1hc2ssIDB4
RkZGRkZGRkYpOworCVBNM19XQUlUKHBhciwgMSk7CisJUE0zX1dSSVRFX1JFRyhwYXIsIFBNM01l
bUJ5cGFzc1dyaXRlTWFzaywgMHhGRkZGRkZGRik7CiAKIAkvKiBwbTMgc3BsaXQgdXAgbWVtb3J5
LCByZXBsaWNhdGVzLCBhbmQgZG8gYSBsb3Qgb2YgbmFzdHkgc3R1ZmYgSU1ITyA7LSkgKi8KIAlm
b3IgKGkgPSAwOyBpIDwgMzI7IGkrKykgewpAQCAtNzY1LDEwICs3MzgsOSBAQCBzdGF0aWMgdW5z
aWduZWQgbG9uZyBwbTNmYl9zaXplX21lbW9yeShzCiAJaWYgKG1lbXNpemUgKyAxID09IGkpIHsK
IAkJZm9yIChpID0gMDsgaSA8IDMyOyBpKyspIHsKIAkJCS8qIENsZWFyIGZpcnN0IDMyTUIgOyAw
IGlzIDAsIG5vIG5lZWQgdG8gYnl0ZXN3YXAgKi8KLQkJCXdyaXRlbCgweDAwMDAwMDAsCi0JCQkg
ICAgICAgKHNjcmVlbl9tZW0gKyAoaSAqIDEwNDg1NzYpKSk7Ci0JCQltYigpOworCQkJd3JpdGVs
KDB4MDAwMDAwMCwgKHNjcmVlbl9tZW0gKyAoaSAqIDEwNDg1NzYpKSk7CiAJCX0KKwkJd21iKCk7
CiAKIAkJZm9yIChpID0gMzI7IGkgPCA2NDsgaSsrKSB7CiAJCQlmYl93cml0ZWwoaSAqIDB4MDAz
NDU2NzgsCkBAIC03ODcsNyArNzU5LDggQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgcG0zZmJfc2l6
ZV9tZW1vcnkocwogCX0KIAlEUFJJTlRLKCJTZWNvbmQgZGV0ZWN0IHBhc3MgZ290ICVsZCBNQlxu
IiwgbWVtc2l6ZSArIDEpOwogCi0JUE0zX1NMT1dfV1JJVEVfUkVHKHBhciwgUE0zTWVtQnlwYXNz
V3JpdGVNYXNrLCB0ZW1wQnlwYXNzKTsKKwlQTTNfV0FJVChwYXIsIDEpOworCVBNM19XUklURV9S
RUcocGFyLCBQTTNNZW1CeXBhc3NXcml0ZU1hc2ssIHRlbXBCeXBhc3MpOwogCiAJaW91bm1hcChz
Y3JlZW5fbWVtKTsKIAlyZWxlYXNlX21lbV9yZWdpb24ocG0zZmJfZml4LnNtZW1fc3RhcnQsIHBt
M2ZiX2ZpeC5zbWVtX2xlbik7CkBAIC04OTAsNyArODYzLDYgQEAgc3RhdGljIGludCBfX2Rldmlu
aXQgcG0zZmJfcHJvYmUoc3RydWN0IAogCQlnb3RvIGVycl9leGl0X2JvdGg7CiAJfQogCi0JLyog
VGhpcyBoYXMgdG8gYmVlbiBkb25lICEhISAqLwogCWlmIChmYl9hbGxvY19jbWFwKCZpbmZvLT5j
bWFwLCAyNTYsIDApIDwgMCkgewogCQlyZXR2YWwgPSAtRU5PTUVNOwogCQlnb3RvIGVycl9leGl0
X2JvdGg7CkBAIC05MDcsNyArODc5LDcgQEAgc3RhdGljIGludCBfX2RldmluaXQgcG0zZmJfcHJv
YmUoc3RydWN0IAogCX0KIAlwcmludGsoS0VSTl9JTkZPICJmYiVkOiAlcyBmcmFtZSBidWZmZXIg
ZGV2aWNlXG4iLCBpbmZvLT5ub2RlLAogCSAgIGluZm8tPmZpeC5pZCk7Ci0JcGNpX3NldF9kcnZk
YXRhKGRldiwgaW5mbyk7IC8qIG9yIGRldl9zZXRfZHJ2ZGF0YShkZXZpY2UsIGluZm8pICovCisJ
cGNpX3NldF9kcnZkYXRhKGRldiwgaW5mbyk7CiAJcmV0dXJuIDA7CiAKICBlcnJfZXhpdF9hbGw6
CkBAIC05NDksOCArOTIxLDcgQEAgc3RhdGljIHZvaWQgX19kZXZleGl0IHBtM2ZiX3JlbW92ZShz
dHJ1YwogCiBzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQgcG0zZmJfaWRfdGFibGVbXSA9IHsK
IAl7IFBDSV9WRU5ET1JfSURfM0RMQUJTLCAweDBhLAotCSAgUENJX0FOWV9JRCwgUENJX0FOWV9J
RCwgUENJX0JBU0VfQ0xBU1NfRElTUExBWSA8PCAxNiwKLQkgIDB4ZmYwMDAwLCAwIH0sCisJICBQ
Q0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCAwIH0sCiAJeyAwLCB9CiB9OwogCkBAIC05NjQs
NiArOTM1LDIyIEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2RyaXZlciBwbTNmYl9kcml2ZXIgPSAKIAog
TU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIHBtM2ZiX2lkX3RhYmxlKTsKIAorI2lmbmRlZiBNT0RV
TEUKKwkvKgorCSAqICBTZXR1cAorCSAqLworCisvKgorICogT25seSBuZWNlc3NhcnkgaWYgeW91
ciBkcml2ZXIgdGFrZXMgc3BlY2lhbCBvcHRpb25zLAorICogb3RoZXJ3aXNlIHdlIGZhbGwgYmFj
ayBvbiB0aGUgZ2VuZXJpYyBmYl9zZXR1cCgpLgorICovCitzdGF0aWMgaW50IF9faW5pdCBwbTNm
Yl9zZXR1cChjaGFyICpvcHRpb25zKQoreworCS8qIFBhcnNlIHVzZXIgc3BlZmljaWVkIG9wdGlv
bnMgKGB2aWRlbz1wbTNmYjonKSAqLworCXJldHVybiAwOworfQorI2VuZGlmIC8qIE1PRFVMRSAq
LworCiBpbnQgX19pbml0IHBtM2ZiX2luaXQodm9pZCkKIHsKIAkvKgpAQCAtOTg1LDIyICs5NzIs
NiBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgcG0zZmJfZXhpdCh2b2lkKQogCXBjaV91bnJlZ2lzdGVy
X2RyaXZlcigmcG0zZmJfZHJpdmVyKTsKIH0KIAotI2lmZGVmIE1PRFVMRQotCS8qCi0JICogIFNl
dHVwCi0JICovCi0KLS8qCi0gKiBPbmx5IG5lY2Vzc2FyeSBpZiB5b3VyIGRyaXZlciB0YWtlcyBz
cGVjaWFsIG9wdGlvbnMsCi0gKiBvdGhlcndpc2Ugd2UgZmFsbCBiYWNrIG9uIHRoZSBnZW5lcmlj
IGZiX3NldHVwKCkuCi0gKi8KLWludCBfX2luaXQgcG0zZmJfc2V0dXAoY2hhciAqb3B0aW9ucykK
LXsKLQkvKiBQYXJzZSB1c2VyIHNwZWZpY2llZCBvcHRpb25zIChgdmlkZW89cG0zZmI6JykgKi8K
LQlyZXR1cm4gMDsKLX0KLSNlbmRpZiAvKiBNT0RVTEUgKi8KLQogbW9kdWxlX2luaXQocG0zZmJf
aW5pdCk7CiBtb2R1bGVfZXhpdChwbTNmYl9leGl0KTsKIAo=

--part4646005017024
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--part4646005017024
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part4646005017024--
