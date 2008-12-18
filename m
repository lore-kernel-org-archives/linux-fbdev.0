From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 2/2] pxafb: cleanup of the color format
	manipulation code
Date: Thu, 18 Dec 2008 22:46:19 +0800
Message-ID: <f17812d70812180646t69a3f07y702e9caab7ebe584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LDK8r-0002HX-Vw
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Dec 2008 14:46:21 +0000
Received: from rv-out-0708.google.com ([209.85.198.250])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LDK8p-0001x4-NL for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Dec 2008 14:46:21 +0000
Received: by rv-out-0708.google.com with SMTP id f25so421676rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 18 Dec 2008 06:46:19 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

1. introduce var_to_depth() to calculate the color depth including the
   transparency bit

2. the conversion from 'fb_var_screeninfo' to LCCR3 BPP bits can be re-
   used by overlays (in OVLxC1), thus an individual pxafb_var_to_bpp()
   has been separated out.

3. pxafb_setmode() should really set the color bitfields correctly at
   begining, introduce a pxafb_set_pixfmt() for this

4. allow user apps to specify color formats within fb_var_screeninfo,
   and checking of this in pxafb_check_var() has been simplified as
   below:

   a) pxafb_var_to_bpp() should pass - which means a basically correct
      bits_per_pixel and color depth setting
   b) the RGBT bitfields are then forced into supported values by
      pxafb_set_pixfmt()

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/include/mach/regs-lcd.h |   15 +---
 drivers/video/pxafb.c                     |  180 ++++++++++++++++------------
 2 files changed, 104 insertions(+), 91 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h
b/arch/arm/mach-pxa/include/mach/regs-lcd.h
index 5c52226..aff3b87 100644
--- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
+++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
@@ -28,17 +28,7 @@
 #define CMDCR		(0x100)	/* Command Control Register */
 #define PRSR		(0x104)	/* Panel Read Status Register */

-#define LCCR3_1BPP	(0 << 24)
-#define LCCR3_2BPP	(1 << 24)
-#define LCCR3_4BPP	(2 << 24)
-#define LCCR3_8BPP	(3 << 24)
-#define LCCR3_16BPP	(4 << 24)
-#define LCCR3_18BPP	(5 << 24)
-#define LCCR3_18BPP_P	(6 << 24)
-#define LCCR3_19BPP	(7 << 24)
-#define LCCR3_19BPP_P	(1 << 29)
-#define LCCR3_24BPP	((1 << 29) | (1 << 24))
-#define LCCR3_25BPP	((1 << 29) | (2 << 24))
+#define LCCR3_BPP(x)	((((x) & 0x7) << 24) | (((x) & 0x8) ? (1 << 29) : 0))

 #define LCCR3_PDFOR_0	(0 << 30)
 #define LCCR3_PDFOR_1	(1 << 30)
@@ -133,9 +123,6 @@
 #define LCCR3_PCD	Fld (8, 0)	/* Pixel Clock Divisor */
 #define LCCR3_PixClkDiv(Div)	(((Div) << FShft (LCCR3_PCD)))

-#define LCCR3_BPP	Fld (3, 24)	/* Bit Per Pixel */
-#define LCCR3_Bpp(Bpp)	(((Bpp) << FShft (LCCR3_BPP)))
-
 #define LCCR3_ACB	Fld (8, 8)	/* AC Bias */
 #define LCCR3_Acb(Acb)	(((Acb) << FShft (LCCR3_ACB)))

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 438928e..a322374 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -66,7 +66,7 @@
 					 LCCR0_SFM | LCCR0_LDM | LCCR0_ENB)

 #define LCCR3_INVALID_CONFIG_MASK	(LCCR3_HSP | LCCR3_VSP |\
-					 LCCR3_PCD | LCCR3_BPP)
+					 LCCR3_PCD | LCCR3_BPP(0xf))

 static int pxafb_activate_var(struct fb_var_screeninfo *var,
 				struct pxafb_info *);
@@ -221,37 +221,107 @@ pxafb_setcolreg(u_int regno, u_int red, u_int
green, u_int blue,
 	return ret;
 }

-/*
- *  pxafb_bpp_to_lccr3():
- *    Convert a bits per pixel value to the correct bit pattern for LCCR3
- */
-static int pxafb_bpp_to_lccr3(struct fb_var_screeninfo *var)
+/* calculate pixel depth, transparency bit included, >=16bpp formats _only_ */
+static inline int var_to_depth(struct fb_var_screeninfo *var)
 {
-	int ret = 0;
+	return var->red.length + var->green.length +
+		var->blue.length + var->transp.length;
+}
+
+/* calculate 4-bit BPP value for LCCR3 and OVLxC1 */
+static int pxafb_var_to_bpp(struct fb_var_screeninfo *var)
+{
+	int bpp = -EINVAL;
+
 	switch (var->bits_per_pixel) {
-	case 1:  ret = LCCR3_1BPP; break;
-	case 2:  ret = LCCR3_2BPP; break;
-	case 4:  ret = LCCR3_4BPP; break;
-	case 8:  ret = LCCR3_8BPP; break;
-	case 16: ret = LCCR3_16BPP; break;
+	case 1:  bpp = 0; break;
+	case 2:  bpp = 1; break;
+	case 4:  bpp = 2; break;
+	case 8:  bpp = 3; break;
+	case 16: bpp = 4; break;
 	case 24:
-		switch (var->red.length + var->green.length +
-				var->blue.length + var->transp.length) {
-		case 18: ret = LCCR3_18BPP_P | LCCR3_PDFOR_3; break;
-		case 19: ret = LCCR3_19BPP_P; break;
+		switch (var_to_depth(var)) {
+		case 18: bpp = 6; break; /* 18-bits/pixel packed */
+		case 19: bpp = 8; break; /* 19-bits/pixel packed */
+		case 24: bpp = 9; break;
 		}
 		break;
 	case 32:
-		switch (var->red.length + var->green.length +
-				var->blue.length + var->transp.length) {
-		case 18: ret = LCCR3_18BPP | LCCR3_PDFOR_3; break;
-		case 19: ret = LCCR3_19BPP; break;
-		case 24: ret = LCCR3_24BPP | LCCR3_PDFOR_3; break;
-		case 25: ret = LCCR3_25BPP; break;
+		switch (var_to_depth(var)) {
+		case 18: bpp = 5; break; /* 18-bits/pixel unpacked */
+		case 19: bpp = 7; break; /* 19-bits/pixel unpacked */
+		case 25: bpp = 10; break;
 		}
 		break;
 	}
-	return ret;
+	return bpp;
+}
+
+/*
+ *  pxafb_var_to_lccr3():
+ *    Convert a bits per pixel value to the correct bit pattern for LCCR3
+ *
+ *  NOTE: for PXA27x with overlays support, the LCCR3_PDFOR_x bits have an
+ *  implication of the acutal use of transparency bit,  which we handle it
+ *  here separatedly. See PXA27x Developer's Manual, Section <<7.4.6 Pixel
+ *  Formats>> for the valid combination of PDFOR, PAL_FOR for various BPP.
+ *
+ *  Transparency for palette pixel formats is not supported at the moment.
+ */
+static uint32_t pxafb_var_to_lccr3(struct fb_var_screeninfo *var)
+{
+	int bpp = pxafb_var_to_bpp(var);
+	uint32_t lccr3;
+
+	if (bpp < 0)
+		return 0;
+
+	lccr3 = LCCR3_BPP(bpp);
+
+	switch (var_to_depth(var)) {
+	case 16: lccr3 |= var->transp.length ? LCCR3_PDFOR_3 : 0; break;
+	case 18: lccr3 |= LCCR3_PDFOR_3; break;
+	case 24: lccr3 |= var->transp.length ? LCCR3_PDFOR_2 : LCCR3_PDFOR_3;
+		 break;
+	case 19:
+	case 25: lccr3 |= LCCR3_PDFOR_0; break;
+	}
+	return lccr3;
+}
+
+#define SET_PIXFMT(v, r, g, b, t)				\
+({								\
+	(v)->transp.offset = (t) ? (r) + (g) + (b) : 0;		\
+	(v)->transp.length = (t) ? (t) : 0;			\
+	(v)->blue.length   = (b); (v)->blue.offset = 0;		\
+	(v)->green.length  = (g); (v)->green.offset = (b);	\
+	(v)->red.length    = (r); (v)->red.offset = (b) + (g);	\
+})
+
+/* set the RGBT bitfields of fb_var_screeninf according to
+ * var->bits_per_pixel and given depth
+ */
+static void pxafb_set_pixfmt(struct fb_var_screeninfo *var, int depth)
+{
+	if (var->bits_per_pixel < 16) {
+		/* indexed pixel formats */
+		var->red.offset    = 0; var->red.length    = 8;
+		var->green.offset  = 0; var->green.length  = 8;
+		var->blue.offset   = 0; var->blue.length   = 8;
+		var->transp.offset = 0; var->transp.length = 8;
+	}
+
+	switch (depth) {
+	case 16: var->transp.length ?
+		 SET_PIXFMT(var, 5, 5, 5, 1) :		/* RGBT555 */
+		 SET_PIXFMT(var, 5, 6, 5, 0); break;	/* RGB565 */
+	case 18: SET_PIXFMT(var, 6, 6, 6, 0); break;	/* RGB666 */
+	case 19: SET_PIXFMT(var, 6, 6, 6, 1); break;	/* RGBT666 */
+	case 24: var->transp.length ?
+		 SET_PIXFMT(var, 8, 8, 7, 1) :		/* RGBT887 */
+		 SET_PIXFMT(var, 8, 8, 8, 0); break;	/* RGB888 */
+	case 25: SET_PIXFMT(var, 8, 8, 8, 1); break;	/* RGBT888 */
+	}
 }

 #ifdef CONFIG_CPU_FREQ
@@ -313,6 +383,9 @@ static void pxafb_setmode(struct fb_var_screeninfo *var,
 	var->lower_margin	= mode->lower_margin;
 	var->sync		= mode->sync;
 	var->grayscale		= mode->cmap_greyscale;
+
+	/* set the initial RGBA bitfields */
+	pxafb_set_pixfmt(var, mode->depth);
 }

 /*
@@ -328,6 +401,7 @@ static int pxafb_check_var(struct
fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct pxafb_info *fbi = (struct pxafb_info *)info;
 	struct pxafb_mach_info *inf = fbi->dev->platform_data;
+	int err;

 	if (var->xres < MIN_XRES)
 		var->xres = MIN_XRES;
@@ -359,60 +433,12 @@ static int pxafb_check_var(struct
fb_var_screeninfo *var, struct fb_info *info)
 	else
 		var->yres_virtual = max(var->yres_virtual, var->yres);

-	/*
-	 * Setup the RGB parameters for this display.
-	 *
-	 * The pixel packing format is described on page 7-11 of the
-	 * PXA2XX Developer's Manual.
-	 */
-	if (var->bits_per_pixel == 16) {
-		var->red.offset   = 11; var->red.length   = 5;
-		var->green.offset = 5;  var->green.length = 6;
-		var->blue.offset  = 0;  var->blue.length  = 5;
-		var->transp.offset = var->transp.length = 0;
-	} else if (var->bits_per_pixel > 16) {
-		struct pxafb_mode_info *mode;
+	/* do a test conversion to BPP fields to check the color formats */
+	err = pxafb_var_to_bpp(var);
+	if (err < 0)
+		return err;

-		mode = pxafb_getmode(inf, var);
-		if (!mode)
-			return -EINVAL;
-
-		switch (mode->depth) {
-		case 18: /* RGB666 */
-			var->transp.offset = var->transp.length     = 0;
-			var->red.offset	   = 12; var->red.length    = 6;
-			var->green.offset  = 6;  var->green.length  = 6;
-			var->blue.offset   = 0;  var->blue.length   = 6;
-			break;
-		case 19: /* RGBT666 */
-			var->transp.offset = 18; var->transp.length = 1;
-			var->red.offset	   = 12; var->red.length    = 6;
-			var->green.offset  = 6;  var->green.length  = 6;
-			var->blue.offset   = 0;  var->blue.length   = 6;
-			break;
-		case 24: /* RGB888 */
-			var->transp.offset = var->transp.length     = 0;
-			var->red.offset	   = 16; var->red.length    = 8;
-			var->green.offset  = 8;  var->green.length  = 8;
-			var->blue.offset   = 0;  var->blue.length   = 8;
-			break;
-		case 25: /* RGBT888 */
-			var->transp.offset = 24; var->transp.length = 1;
-			var->red.offset	   = 16; var->red.length    = 8;
-			var->green.offset  = 8;  var->green.length  = 8;
-			var->blue.offset   = 0;  var->blue.length   = 8;
-			break;
-		default:
-			return -EINVAL;
-		}
-	} else {
-		var->red.offset = var->green.offset = 0;
-		var->blue.offset = var->transp.offset = 0;
-		var->red.length   = 8;
-		var->green.length = 8;
-		var->blue.length  = 8;
-		var->transp.length = 0;
-	}
+	pxafb_set_pixfmt(var, var_to_depth(var));

 #ifdef CONFIG_CPU_FREQ
 	pr_debug("pxafb: dma period = %d ps\n",
@@ -988,7 +1014,7 @@ static int pxafb_activate_var(struct
fb_var_screeninfo *var,
 		(LCCR0_LDM | LCCR0_SFM | LCCR0_IUM | LCCR0_EFM |
 		 LCCR0_QDM | LCCR0_BM  | LCCR0_OUM);

-	fbi->reg_lccr3 |= pxafb_bpp_to_lccr3(var);
+	fbi->reg_lccr3 |= pxafb_var_to_lccr3(var);

 	fbi->reg_lccr4 = lcd_readl(fbi, LCCR4) & ~LCCR4_PAL_FOR_MASK;
 	fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
