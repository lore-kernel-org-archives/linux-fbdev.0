From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] s3c2410fb: code cleanup
Date: Fri, 03 Aug 2007 07:04:12 +0200
Message-ID: <46b2b74ca0baf@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46b2b74ca32ad"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGpKo-0004IC-L2 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 22:04:22 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IGpKl-0005WV-Mr
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 22:04:21 -0700
Received: from poczta-17.free.wp-sa.pl (HELO localhost) ([10.1.1.76])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 3 Aug 2007 07:04:12 +0200
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
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, Ben Dooks <ben-linux@fluff.org>

This is a multi-part message in MIME format.

--part46b2b74ca32ad
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch cleans up the driver a bit. It contains
coding style fixes (pointed by Lindent and checkpatch),
white space clean ups and few minor code improvements.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.23.old/drivers/video/s3c2410fb.c	2007-08-02 10:
21:08.000000000 +0200
+++ linux-2.6.23/drivers/video/s3c2410fb.c	2007-08-03 06:43:
19.000000000 +0200
@@ -31,8 +31,8 @@
  *	- add pixel clock divisor control
  *
  * 2004-11-11: Arnaud Patard <arnaud.patard@rtp-net.org>
- * 	- Removed the use of currcon as it no more exist
- * 	- Added LCD power sysfs interface
+ *	- Removed the use of currcon as it no more exist
+ *	- Added LCD power sysfs interface
  *
  * 2004-11-03: Ben Dooks <ben-linux@fluff.org>
  *	- minor cleanups
@@ -49,12 +49,12 @@
  *      - Suppress command line options
  *
  * 2004-09-15: Arnaud Patard <arnaud.patard@rtp-net.org>
- * 	- code cleanup
+ *	- code cleanup
  *
  * 2004-09-07: Arnaud Patard <arnaud.patard@rtp-net.org>
- * 	- Renamed from h1940fb.c to s3c2410fb.c
- * 	- Add support for different devices
- * 	- Backlight support
+ *	- Renamed from h1940fb.c to s3c2410fb.c
+ *	- Add support for different devices
+ *	- Backlight support
  *
  * 2004-09-05: Herbert P=F6tzl <herbert@13thfloor.at>
  *	- added clock (de-)allocation code
@@ -102,14 +102,13 @@
=20
 #include "s3c2410fb.h"
=20
-
 static struct s3c2410fb_mach_info *mach_info;
=20
 /* Debugging stuff */
 #ifdef CONFIG_FB_S3C2410_DEBUG
-static int debug	   =3D 1;
+static int debug	=3D 1;
 #else
-static int debug	   =3D 0;
+static int debug	=3D 0;
 #endif
=20
 #define dprintk(msg...)	if (debug) { printk(KERN_DEBUG=20
"s3c2410fb: " msg); }
@@ -119,19 +118,20 @@ static int debug	   =3D 0;
 /* s3c2410fb_set_lcdaddr
  *
  * initialise lcd controller address pointers
-*/
-
+ */
 static void s3c2410fb_set_lcdaddr(struct s3c2410fb_info *fbi)
 {
 	struct fb_var_screeninfo *var =3D &fbi->fb->var;
 	unsigned long saddr1, saddr2, saddr3;
+	int line_length =3D var->xres * var->bits_per_pixel;
=20
 	saddr1  =3D fbi->fb->fix.smem_start >> 1;
 	saddr2  =3D fbi->fb->fix.smem_start;
-	saddr2 +=3D (var->xres * var->yres * var->bits_per_pixel)/8;
-	saddr2>>=3D 1;
+	saddr2 +=3D (line_length * var->yres) / 8;
+	saddr2 >>=3D 1;
=20
-	saddr3 =3D  S3C2410_OFFSIZE(0) | S3C2410_PAGEWIDTH((var->xres=20
* var->bits_per_pixel / 16) & 0x3ff);
+	saddr3 =3D S3C2410_OFFSIZE(0) |
+		 S3C2410_PAGEWIDTH((line_length / 16) & 0x3ff);
=20
 	dprintk("LCDSADDR1 =3D 0x%08lx\n", saddr1);
 	dprintk("LCDSADDR2 =3D 0x%08lx\n", saddr2);
@@ -145,8 +145,7 @@ static void s3c2410fb_set_lcdaddr(struct
 /* s3c2410fb_calc_pixclk()
  *
  * calculate divisor for clk->pixclk
-*/
-
+ */
 static unsigned int s3c2410fb_calc_pixclk(struct s3c2410fb_info=20
*fbi,
 					  unsigned long pixclk)
 {
@@ -159,8 +158,8 @@ static unsigned int s3c2410fb_calc_pixcl
 	 */
=20
 	div =3D (unsigned long long)clk * pixclk;
-	do_div(div,1000000UL);
-	do_div(div,1000000UL);
+	do_div(div, 1000000UL);
+	do_div(div, 1000000UL);
=20
 	dprintk("pixclk %ld, divisor is %ld\n", pixclk, (long)div);
 	return div;
@@ -198,93 +197,84 @@ static int s3c2410fb_check_var(struct fb
 	else if (var->bits_per_pixel < fbi->mach_info->bpp.min)
 		var->bits_per_pixel =3D fbi->mach_info->bpp.min;
=20
+	var->transp.offset =3D 0;
+	var->transp.length =3D 0;
 	/* set r/g/b positions */
 	switch (var->bits_per_pixel) {
-		case 1:
-		case 2:
-		case 4:
-			var->red.offset    	=3D 0;
-			var->red.length    	=3D var->bits_per_pixel;
-			var->green         	=3D var->red;
-			var->blue          	=3D var->red;
-			var->transp.offset 	=3D 0;
-			var->transp.length 	=3D 0;
-			break;
-		case 8:
-			if ( fbi->mach_info->type !=3D S3C2410_LCDCON1_TFT ) {
-				/* 8 bpp 332 */
-				var->red.length		=3D 3;
-				var->red.offset		=3D 5;
-				var->green.length	=3D 3;
-				var->green.offset	=3D 2;
-				var->blue.length	=3D 2;
-				var->blue.offset	=3D 0;
-				var->transp.length	=3D 0;
-			} else {
-				var->red.offset    	=3D 0;
-				var->red.length    	=3D var->bits_per_pixel;
-				var->green         	=3D var->red;
-				var->blue          	=3D var->red;
-				var->transp.offset 	=3D 0;
-				var->transp.length 	=3D 0;
-			}
-			break;
-		case 12:
-			/* 12 bpp 444 */
-			var->red.length		=3D 4;
-			var->red.offset		=3D 8;
-			var->green.length	=3D 4;
-			var->green.offset	=3D 4;
-			var->blue.length	=3D 4;
+	case 1:
+	case 2:
+	case 4:
+		var->red.offset	=3D 0;
+		var->red.length	=3D var->bits_per_pixel;
+		var->green	=3D var->red;
+		var->blue	=3D var->red;
+		break;
+	case 8:
+		if (fbi->mach_info->type !=3D S3C2410_LCDCON1_TFT) {
+			/* 8 bpp 332 */
+			var->red.length		=3D 3;
+			var->red.offset		=3D 5;
+			var->green.length	=3D 3;
+			var->green.offset	=3D 2;
+			var->blue.length	=3D 2;
 			var->blue.offset	=3D 0;
-			var->transp.length	=3D 0;
-			break;
-
-		default:
-		case 16:
-			if (fbi->regs.lcdcon5 & S3C2410_LCDCON5_FRM565 ) {
-				/* 16 bpp, 565 format */
-				var->red.offset		=3D 11;
-				var->green.offset	=3D 5;
-				var->blue.offset	=3D 0;
-				var->red.length		=3D 5;
-				var->green.length	=3D 6;
-				var->blue.length	=3D 5;
-				var->transp.length	=3D 0;
-			} else {
-				/* 16 bpp, 5551 format */
-				var->red.offset		=3D 11;
-				var->green.offset	=3D 6;
-				var->blue.offset	=3D 1;
-				var->red.length		=3D 5;
-				var->green.length	=3D 5;
-				var->blue.length	=3D 5;
-				var->transp.length	=3D 0;
-			}
-			break;
-		case 24:
-			/* 24 bpp 888 */
+		} else {
+			var->red.offset		=3D 0;
 			var->red.length		=3D 8;
-			var->red.offset		=3D 16;
-			var->green.length	=3D 8;
-			var->green.offset	=3D 8;
-			var->blue.length	=3D 8;
+			var->green		=3D var->red;
+			var->blue		=3D var->red;
+		}
+		break;
+	case 12:
+		/* 12 bpp 444 */
+		var->red.length		=3D 4;
+		var->red.offset		=3D 8;
+		var->green.length	=3D 4;
+		var->green.offset	=3D 4;
+		var->blue.length	=3D 4;
+		var->blue.offset	=3D 0;
+		break;
+
+	default:
+	case 16:
+		if (fbi->regs.lcdcon5 & S3C2410_LCDCON5_FRM565) {
+			/* 16 bpp, 565 format */
+			var->red.offset		=3D 11;
+			var->green.offset	=3D 5;
 			var->blue.offset	=3D 0;
-			var->transp.length	=3D 0;
-			break;
+			var->red.length		=3D 5;
+			var->green.length	=3D 6;
+			var->blue.length	=3D 5;
+		} else {
+			/* 16 bpp, 5551 format */
+			var->red.offset		=3D 11;
+			var->green.offset	=3D 6;
+			var->blue.offset	=3D 1;
+			var->red.length		=3D 5;
+			var->green.length	=3D 5;
+			var->blue.length	=3D 5;
+		}
+		break;
+	case 24:
+		/* 24 bpp 888 */
+		var->red.length		=3D 8;
+		var->red.offset		=3D 16;
+		var->green.length	=3D 8;
+		var->green.offset	=3D 8;
+		var->blue.length	=3D 8;
+		var->blue.offset	=3D 0;
+		break;
=20
=20
 	}
 	return 0;
 }
=20
-
 /* s3c2410fb_activate_var
  *
  * activate (set) the controller from the given framebuffer
  * information
-*/
-
+ */
 static void s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
 				   struct fb_var_screeninfo *var)
 {
@@ -319,7 +309,8 @@ static void s3c2410fb_activate_var(struc
=20
 		default:
 			/* invalid pixel depth */
-			dev_err(fbi->dev, "invalid bpp %d\n",=20
var->bits_per_pixel);
+			dev_err(fbi->dev, "invalid bpp %d\n",
+				var->bits_per_pixel);
 		}
 	else
 		switch (var->bits_per_pixel) {
@@ -341,19 +332,18 @@ static void s3c2410fb_activate_var(struc
=20
 		default:
 			/* invalid pixel depth */
-			dev_err(fbi->dev, "invalid bpp %d\n",=20
var->bits_per_pixel);
+			dev_err(fbi->dev, "invalid bpp %d\n",
+				var->bits_per_pixel);
 		}
=20
 	/* check to see if we need to update sync/borders */
=20
 	if (!fbi->mach_info->fixed_syncs) {
 		dprintk("setting vert: up=3D%d, low=3D%d, sync=3D%d\n",
-			var->upper_margin, var->lower_margin,
-			var->vsync_len);
+			var->upper_margin, var->lower_margin, var->vsync_len)
;
=20
 		dprintk("setting horz: lft=3D%d, rt=3D%d, sync=3D%d\n",
-			var->left_margin, var->right_margin,
-			var->hsync_len);
+			var->left_margin, var->right_margin, var->hsync_len);
=20
 		fbi->regs.lcdcon2 =3D
 			S3C2410_LCDCON2_VBPD(var->upper_margin - 1) |
@@ -373,27 +363,24 @@ static void s3c2410fb_activate_var(struc
 	fbi->regs.lcdcon2 &=3D ~S3C2410_LCDCON2_LINEVAL(0x3ff);
 	fbi->regs.lcdcon2 |=3D  S3C2410_LCDCON2_LINEVAL(var->yres -=20
1);
=20
-	switch(fbi->mach_info->type) {
-		case S3C2410_LCDCON1_DSCAN4:
-		case S3C2410_LCDCON1_STN8:
-			hs =3D var->xres / 8;
-			break;
-		case S3C2410_LCDCON1_STN4:
-			hs =3D var->xres / 4;
-			break;
-		default:
-		case S3C2410_LCDCON1_TFT:
-			hs =3D var->xres;
-			break;
-
+	switch (fbi->mach_info->type) {
+	case S3C2410_LCDCON1_DSCAN4:
+	case S3C2410_LCDCON1_STN8:
+		hs =3D var->xres / 8;
+		break;
+	case S3C2410_LCDCON1_STN4:
+		hs =3D var->xres / 4;
+		break;
+	default:
+	case S3C2410_LCDCON1_TFT:
+		hs =3D var->xres;
+		break;
 	}
=20
 	/* Special cases : STN color displays */
-	if ( ((fbi->regs.lcdcon1 & S3C2410_LCDCON1_MODEMASK) =3D=3D=20
S3C2410_LCDCON1_STN8BPP) \
-	  || ((fbi->regs.lcdcon1 & S3C2410_LCDCON1_MODEMASK) =3D=3D=20
S3C2410_LCDCON1_STN12BPP) ) {
+	if (((fbi->regs.lcdcon1 & S3C2410_LCDCON1_MODEMASK) =3D=3D=20
S3C2410_LCDCON1_STN8BPP) ||
+	    ((fbi->regs.lcdcon1 & S3C2410_LCDCON1_MODEMASK) =3D=3D=20
S3C2410_LCDCON1_STN12BPP))
 		hs =3D hs * 3;
-	}
-
=20
 	fbi->regs.lcdcon3 &=3D ~S3C2410_LCDCON3_HOZVAL(0x7ff);
 	fbi->regs.lcdcon3 |=3D  S3C2410_LCDCON3_HOZVAL(hs - 1);
@@ -402,11 +389,10 @@ static void s3c2410fb_activate_var(struc
 		int clkdiv =3D s3c2410fb_calc_pixclk(fbi, var->pixclock);
=20
 		if (fbi->mach_info->type =3D=3D S3C2410_LCDCON1_TFT) {
-			clkdiv =3D (clkdiv / 2) -1;
+			clkdiv =3D (clkdiv / 2) - 1;
 			if (clkdiv < 0)
 				clkdiv =3D 0;
-		}
-		else {
+		} else {
 			clkdiv =3D (clkdiv / 2);
 			if (clkdiv < 2)
 				clkdiv =3D 2;
@@ -437,9 +423,8 @@ static void s3c2410fb_activate_var(struc
 	writel(fbi->regs.lcdcon1, S3C2410_LCDCON1);
 }
=20
-
 /*
- *      s3c2410fb_set_par - Optional function. Alters the=20
hardware state.
+ *      s3c2410fb_set_par - Alters the hardware state.
  *      @info: frame buffer structure that represents a single=20
frame buffer
  *
  */
@@ -448,20 +433,19 @@ static int s3c2410fb_set_par(struct fb_i
 	struct s3c2410fb_info *fbi =3D info->par;
 	struct fb_var_screeninfo *var =3D &info->var;
=20
-	switch (var->bits_per_pixel)
-	{
-		case 16:
-			fbi->fb->fix.visual =3D FB_VISUAL_TRUECOLOR;
-			break;
-		case 1:
-			 fbi->fb->fix.visual =3D FB_VISUAL_MONO01;
-			 break;
-		default:
-			 fbi->fb->fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
-			 break;
+	switch (var->bits_per_pixel) {
+	case 16:
+		info->fix.visual =3D FB_VISUAL_TRUECOLOR;
+		break;
+	case 1:
+		info->fix.visual =3D FB_VISUAL_MONO01;
+		break;
+	default:
+		info->fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
+		break;
 	}
=20
-	fbi->fb->fix.line_length     =3D=20
(var->width*var->bits_per_pixel)/8;
+	info->fix.line_length =3D (var->width * var->bits_per_pixel)=20
/ 8;
=20
 	/* activate this new configuration */
=20
@@ -493,7 +477,8 @@ static void schedule_palette_update(stru
 }
=20
 /* from pxafb.c */
-static inline unsigned int chan_to_field(unsigned int chan,=20
struct fb_bitfield *bf)
+static inline unsigned int chan_to_field(unsigned int chan,
+					 struct fb_bitfield *bf)
 {
 	chan &=3D 0xffff;
 	chan >>=3D 16 - bf->length;
@@ -507,18 +492,19 @@ static int s3c2410fb_setcolreg(unsigned=20
 	struct s3c2410fb_info *fbi =3D info->par;
 	unsigned int val;
=20
-	/* dprintk("setcol: regno=3D%d, rgb=3D%d,%d,%d\n", regno, red,=20
green, blue); */
+	/* dprintk("setcol: regno=3D%d, rgb=3D%d,%d,%d\n",
+		   regno, red, green, blue); */
=20
-	switch (fbi->fb->fix.visual) {
+	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
-		/* true-colour, use pseuo-palette */
+		/* true-colour, use pseudo-palette */
=20
 		if (regno < 16) {
-			u32 *pal =3D fbi->fb->pseudo_palette;
+			u32 *pal =3D info->pseudo_palette;
=20
-			val  =3D chan_to_field(red,   &fbi->fb->var.red);
-			val |=3D chan_to_field(green, &fbi->fb->var.green);
-			val |=3D chan_to_field(blue,  &fbi->fb->var.blue);
+			val  =3D chan_to_field(red,   &info->var.red);
+			val |=3D chan_to_field(green, &info->var.green);
+			val |=3D chan_to_field(blue,  &info->var.blue);
=20
 			pal[regno] =3D val;
 		}
@@ -539,14 +525,13 @@ static int s3c2410fb_setcolreg(unsigned=20
 		break;
=20
 	default:
-		return 1;   /* unknown type */
+		return 1;	/* unknown type */
 	}
=20
 	return 0;
 }
=20
-
-/**
+/*
  *      s3c2410fb_blank
  *	@blank_mode: the blank mode we want.
  *	@info: frame buffer structure that represents a single=20
frame buffer
@@ -579,12 +564,14 @@ static int s3c2410fb_blank(int blank_mod
 	return 0;
 }
=20
-static int s3c2410fb_debug_show(struct device *dev, struct=20
device_attribute *attr, char *buf)
+static int s3c2410fb_debug_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%s\n", debug ? "on" :=20
"off");
 }
-static int s3c2410fb_debug_store(struct device *dev, struct=20
device_attribute *attr,
-					   const char *buf, size_t len)
+static int s3c2410fb_debug_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t len)
 {
 	if (mach_info =3D=3D NULL)
 		return -EINVAL;
@@ -607,10 +594,7 @@ static int s3c2410fb_debug_store(struct=20
 	return len;
 }
=20
-
-static DEVICE_ATTR(debug, 0666,
-		   s3c2410fb_debug_show,
-		   s3c2410fb_debug_store);
+static DEVICE_ATTR(debug, 0666, s3c2410fb_debug_show,=20
s3c2410fb_debug_store);
=20
 static struct fb_ops s3c2410fb_ops =3D {
 	.owner		=3D THIS_MODULE,
@@ -623,7 +607,6 @@ static struct fb_ops s3c2410fb_ops =3D {
 	.fb_imageblit	=3D cfb_imageblit,
 };
=20
-
 /*
  * s3c2410fb_map_video_memory():
  *	Allocates the DRAM memory for the frame buffer.  This=20
buffer is
@@ -661,7 +644,8 @@ static int __init s3c2410fb_map_video_me
=20
 static inline void s3c2410fb_unmap_video_memory(struct=20
s3c2410fb_info *fbi)
 {
-	dma_free_writecombine(fbi->dev,fbi->map_size,fbi->map_cpu,=20
fbi->map_dma);
+	dma_free_writecombine(fbi->dev, fbi->map_size,=20
fbi->map_cpu,
+			      fbi->map_dma);
 }
=20
 static inline void modify_gpio(void __iomem *reg,
@@ -673,11 +657,9 @@ static inline void modify_gpio(void __io
 	writel(tmp | set, reg);
 }
=20
-
 /*
  * s3c2410fb_init_registers - Initialise all LCD-related=20
registers
  */
-
 static int s3c2410fb_init_registers(struct s3c2410fb_info *fbi)
 {
 	unsigned long flags;
@@ -702,7 +684,7 @@ static int s3c2410fb_init_registers(stru
 	writel(fbi->regs.lcdcon4, regs + S3C2410_LCDCON4);
 	writel(fbi->regs.lcdcon5, regs + S3C2410_LCDCON5);
=20
- 	s3c2410fb_set_lcdaddr(fbi);
+	s3c2410fb_set_lcdaddr(fbi);
=20
 	dprintk("LPCSEL    =3D 0x%08lx\n", mach_info->lpcsel);
 	writel(mach_info->lpcsel, regs + S3C2410_LPCSEL);
@@ -721,13 +703,13 @@ static int s3c2410fb_init_registers(stru
 static void s3c2410fb_write_palette(struct s3c2410fb_info *fbi)
 {
 	unsigned int i;
-	unsigned long ent;
 	void __iomem *regs =3D fbi->io;
=20
 	fbi->palette_ready =3D 0;
=20
 	for (i =3D 0; i < 256; i++) {
-		if ((ent =3D fbi->palette_buffer[i]) =3D=3D=20
PALETTE_BUFF_CLEAR)
+		unsigned long ent =3D fbi->palette_buffer[i];
+		if (ent =3D=3D PALETTE_BUFF_CLEAR)
 			continue;
=20
 		writel(ent, regs + S3C2410_TFTPAL(i));
@@ -761,12 +743,12 @@ static irqreturn_t s3c2410fb_irq(int irq
 	return IRQ_HANDLED;
 }
=20
-static char driver_name[]=3D"s3c2410fb";
+static char driver_name[] =3D "s3c2410fb";
=20
 static int __init s3c2410fb_probe(struct platform_device *pdev)
 {
 	struct s3c2410fb_info *info;
-	struct fb_info	   *fbinfo;
+	struct fb_info *fbinfo;
 	struct s3c2410fb_hw *mregs;
 	struct resource *res;
 	int ret;
@@ -777,7 +759,8 @@ static int __init s3c2410fb_probe(struct
=20
 	mach_info =3D pdev->dev.platform_data;
 	if (mach_info =3D=3D NULL) {
-		dev_err(&pdev->dev,"no platform data for lcd, cannot=20
attach\n");
+		dev_err(&pdev->dev,
+			"no platform data for lcd, cannot attach\n");
 		return -EINVAL;
 	}
=20
@@ -790,9 +773,8 @@ static int __init s3c2410fb_probe(struct
 	}
=20
 	fbinfo =3D framebuffer_alloc(sizeof(struct s3c2410fb_info),=20
&pdev->dev);
-	if (!fbinfo) {
+	if (!fbinfo)
 		return -ENOMEM;
-	}
=20
 	info =3D fbinfo->par;
 	info->fb =3D fbinfo;
@@ -800,12 +782,12 @@ static int __init s3c2410fb_probe(struct
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res =3D=3D NULL) {
-		dev_err(&pdev->dev, "failed to get memory registersn");
+		dev_err(&pdev->dev, "failed to get memory registers\n");
 		ret =3D -ENXIO;
 		goto dealloc_fb;
 	}
=20
-	size =3D (res->end - res->start)+1;
+	size =3D (res->end - res->start) + 1;
 	info->mem =3D request_mem_region(res->start, size,=20
pdev->name);
 	if (info->mem =3D=3D NULL) {
 		dev_err(&pdev->dev, "failed to get memory region\n");
@@ -859,13 +841,19 @@ static int __init s3c2410fb_probe(struct
 	fbinfo->var.yres_virtual    =3D mach_info->yres.defval;
 	fbinfo->var.bits_per_pixel  =3D mach_info->bpp.defval;
=20
-	fbinfo->var.upper_margin    =3D=20
S3C2410_LCDCON2_GET_VBPD(mregs->lcdcon2) + 1;
-	fbinfo->var.lower_margin    =3D=20
S3C2410_LCDCON2_GET_VFPD(mregs->lcdcon2) + 1;
-	fbinfo->var.vsync_len	    =3D=20
S3C2410_LCDCON2_GET_VSPW(mregs->lcdcon2) + 1;
-
-	fbinfo->var.left_margin	    =3D=20
S3C2410_LCDCON3_GET_HFPD(mregs->lcdcon3) + 1;
-	fbinfo->var.right_margin    =3D=20
S3C2410_LCDCON3_GET_HBPD(mregs->lcdcon3) + 1;
-	fbinfo->var.hsync_len	    =3D=20
S3C2410_LCDCON4_GET_HSPW(mregs->lcdcon4) + 1;
+	fbinfo->var.upper_margin    =3D
+				S3C2410_LCDCON2_GET_VBPD(mregs->lcdcon2) + 1;
+	fbinfo->var.lower_margin    =3D
+				S3C2410_LCDCON2_GET_VFPD(mregs->lcdcon2) + 1;
+	fbinfo->var.vsync_len	    =3D
+				S3C2410_LCDCON2_GET_VSPW(mregs->lcdcon2) + 1;
+
+	fbinfo->var.left_margin	    =3D
+				S3C2410_LCDCON3_GET_HFPD(mregs->lcdcon3) + 1;
+	fbinfo->var.right_margin    =3D
+				S3C2410_LCDCON3_GET_HBPD(mregs->lcdcon3) + 1;
+	fbinfo->var.hsync_len	    =3D
+				S3C2410_LCDCON4_GET_HSPW(mregs->lcdcon4) + 1;
=20
 	fbinfo->var.red.offset      =3D 11;
 	fbinfo->var.green.offset    =3D 5;
@@ -875,7 +863,7 @@ static int __init s3c2410fb_probe(struct
 	fbinfo->var.green.length    =3D 6;
 	fbinfo->var.blue.length     =3D 5;
 	fbinfo->var.transp.length   =3D 0;
-	fbinfo->fix.smem_len        =3D	mach_info->xres.max *
+	fbinfo->fix.smem_len	    =3D	mach_info->xres.max *
 					mach_info->yres.max *
 					mach_info->bpp.max / 8;
=20
@@ -904,20 +892,21 @@ static int __init s3c2410fb_probe(struct
 	/* Initialize video memory */
 	ret =3D s3c2410fb_map_video_memory(info);
 	if (ret) {
-		printk( KERN_ERR "Failed to allocate video RAM: %d\n",=20
ret);
+		printk(KERN_ERR "Failed to allocate video RAM: %d\n",=20
ret);
 		ret =3D -ENOMEM;
 		goto release_clock;
 	}
=20
 	dprintk("got video memory\n");
=20
-	ret =3D s3c2410fb_init_registers(info);
+	s3c2410fb_init_registers(info);
=20
-	ret =3D s3c2410fb_check_var(&fbinfo->var, fbinfo);
+	s3c2410fb_check_var(&fbinfo->var, fbinfo);
=20
 	ret =3D register_framebuffer(fbinfo);
 	if (ret < 0) {
-		printk(KERN_ERR "Failed to register framebuffer device:=20
%d\n", ret);
+		printk(KERN_ERR "Failed to register framebuffer device:=20
%d\n",
+			ret);
 		goto free_video_memory;
 	}
=20
@@ -935,7 +924,7 @@ release_clock:
 	clk_disable(info->clk);
 	clk_put(info->clk);
 release_irq:
-	free_irq(irq,info);
+	free_irq(irq, info);
 release_regs:
 	iounmap(info->io);
 release_mem:
@@ -949,8 +938,7 @@ dealloc_fb:
 /* s3c2410fb_stop_lcd
  *
  * shutdown the lcd controller
-*/
-
+ */
 static void s3c2410fb_stop_lcd(struct s3c2410fb_info *fbi)
 {
 	unsigned long flags;
@@ -968,7 +956,7 @@ static void s3c2410fb_stop_lcd(struct s3
  */
 static int s3c2410fb_remove(struct platform_device *pdev)
 {
-	struct fb_info	   *fbinfo =3D platform_get_drvdata(pdev);
+	struct fb_info *fbinfo =3D platform_get_drvdata(pdev);
 	struct s3c2410fb_info *info =3D fbinfo->par;
 	int irq;
=20
@@ -977,14 +965,14 @@ static int s3c2410fb_remove(struct platf
=20
 	s3c2410fb_unmap_video_memory(info);
=20
- 	if (info->clk) {
- 		clk_disable(info->clk);
- 		clk_put(info->clk);
- 		info->clk =3D NULL;
+	if (info->clk) {
+		clk_disable(info->clk);
+		clk_put(info->clk);
+		info->clk =3D NULL;
 	}
=20
 	irq =3D platform_get_irq(pdev, 0);
-	free_irq(irq,info);
+	free_irq(irq, info);
=20
 	release_resource(info->mem);
 	kfree(info->mem);
@@ -997,7 +985,6 @@ static int s3c2410fb_remove(struct platf
 #ifdef CONFIG_PM
=20
 /* suspend and resume support for the lcd controller */
-
 static int s3c2410fb_suspend(struct platform_device *dev,=20
pm_message_t state)
 {
 	struct fb_info	   *fbinfo =3D platform_get_drvdata(dev);
@@ -1054,10 +1041,10 @@ static void __exit s3c2410fb_cleanup(voi
 	platform_driver_unregister(&s3c2410fb_driver);
 }
=20
-
 module_init(s3c2410fb_init);
 module_exit(s3c2410fb_cleanup);
=20
-MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>, Ben=20
Dooks <ben-linux@fluff.org>");
+MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>, "
+	      "Ben Dooks <ben-linux@fluff.org>");
 MODULE_DESCRIPTION("Framebuffer driver for the s3c2410");
 MODULE_LICENSE("GPL");


----------------------------------------------------
Czy na wakacje warto zabra=E6 laptopa?
Zobacz gdzie dzia=B3aj=B1 strefy darmowego, bezprzewodowego Internetu!
Kliknij: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd=
128.html&sid=3D1243

--part46b2b74ca32ad
Content-Type: application/octet-stream; name="s3c2410fb-cleanup.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="s3c2410fb-cleanup.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggY2xl
YW5zIHVwIHRoZSBkcml2ZXIgYSBiaXQuIEl0IGNvbnRhaW5zCmNvZGluZyBzdHlsZSBmaXhlcyAo
cG9pbnRlZCBieSBMaW5kZW50IGFuZCBjaGVja3BhdGNoKSwKd2hpdGUgc3BhY2UgY2xlYW4gdXBz
IGFuZCBmZXcgbWlub3IgY29kZSBpbXByb3ZlbWVudHMuCgpTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0
b2YgSGVsdCA8a3J6eXN6dG9mLmgxQHdwLnBsPgoKLS0tCgotLS0gbGludXgtMi42LjIzLm9sZC9k
cml2ZXJzL3ZpZGVvL3MzYzI0MTBmYi5jCTIwMDctMDgtMDIgMTA6MjE6MDguMDAwMDAwMDAwICsw
MjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9zM2MyNDEwZmIuYwkyMDA3LTA4LTAz
IDA2OjQzOjE5LjAwMDAwMDAwMCArMDIwMApAQCAtMzEsOCArMzEsOCBAQAogICoJLSBhZGQgcGl4
ZWwgY2xvY2sgZGl2aXNvciBjb250cm9sCiAgKgogICogMjAwNC0xMS0xMTogQXJuYXVkIFBhdGFy
ZCA8YXJuYXVkLnBhdGFyZEBydHAtbmV0Lm9yZz4KLSAqIAktIFJlbW92ZWQgdGhlIHVzZSBvZiBj
dXJyY29uIGFzIGl0IG5vIG1vcmUgZXhpc3QKLSAqIAktIEFkZGVkIExDRCBwb3dlciBzeXNmcyBp
bnRlcmZhY2UKKyAqCS0gUmVtb3ZlZCB0aGUgdXNlIG9mIGN1cnJjb24gYXMgaXQgbm8gbW9yZSBl
eGlzdAorICoJLSBBZGRlZCBMQ0QgcG93ZXIgc3lzZnMgaW50ZXJmYWNlCiAgKgogICogMjAwNC0x
MS0wMzogQmVuIERvb2tzIDxiZW4tbGludXhAZmx1ZmYub3JnPgogICoJLSBtaW5vciBjbGVhbnVw
cwpAQCAtNDksMTIgKzQ5LDEyIEBACiAgKiAgICAgIC0gU3VwcHJlc3MgY29tbWFuZCBsaW5lIG9w
dGlvbnMKICAqCiAgKiAyMDA0LTA5LTE1OiBBcm5hdWQgUGF0YXJkIDxhcm5hdWQucGF0YXJkQHJ0
cC1uZXQub3JnPgotICogCS0gY29kZSBjbGVhbnVwCisgKgktIGNvZGUgY2xlYW51cAogICoKICAq
IDIwMDQtMDktMDc6IEFybmF1ZCBQYXRhcmQgPGFybmF1ZC5wYXRhcmRAcnRwLW5ldC5vcmc+Ci0g
KiAJLSBSZW5hbWVkIGZyb20gaDE5NDBmYi5jIHRvIHMzYzI0MTBmYi5jCi0gKiAJLSBBZGQgc3Vw
cG9ydCBmb3IgZGlmZmVyZW50IGRldmljZXMKLSAqIAktIEJhY2tsaWdodCBzdXBwb3J0CisgKgkt
IFJlbmFtZWQgZnJvbSBoMTk0MGZiLmMgdG8gczNjMjQxMGZiLmMKKyAqCS0gQWRkIHN1cHBvcnQg
Zm9yIGRpZmZlcmVudCBkZXZpY2VzCisgKgktIEJhY2tsaWdodCBzdXBwb3J0CiAgKgogICogMjAw
NC0wOS0wNTogSGVyYmVydCBQ9nR6bCA8aGVyYmVydEAxM3RoZmxvb3IuYXQ+CiAgKgktIGFkZGVk
IGNsb2NrIChkZS0pYWxsb2NhdGlvbiBjb2RlCkBAIC0xMDIsMTQgKzEwMiwxMyBAQAogCiAjaW5j
bHVkZSAiczNjMjQxMGZiLmgiCiAKLQogc3RhdGljIHN0cnVjdCBzM2MyNDEwZmJfbWFjaF9pbmZv
ICptYWNoX2luZm87CiAKIC8qIERlYnVnZ2luZyBzdHVmZiAqLwogI2lmZGVmIENPTkZJR19GQl9T
M0MyNDEwX0RFQlVHCi1zdGF0aWMgaW50IGRlYnVnCSAgID0gMTsKK3N0YXRpYyBpbnQgZGVidWcJ
PSAxOwogI2Vsc2UKLXN0YXRpYyBpbnQgZGVidWcJICAgPSAwOworc3RhdGljIGludCBkZWJ1Zwk9
IDA7CiAjZW5kaWYKIAogI2RlZmluZSBkcHJpbnRrKG1zZy4uLikJaWYgKGRlYnVnKSB7IHByaW50
ayhLRVJOX0RFQlVHICJzM2MyNDEwZmI6ICIgbXNnKTsgfQpAQCAtMTE5LDE5ICsxMTgsMjAgQEAg
c3RhdGljIGludCBkZWJ1ZwkgICA9IDA7CiAvKiBzM2MyNDEwZmJfc2V0X2xjZGFkZHIKICAqCiAg
KiBpbml0aWFsaXNlIGxjZCBjb250cm9sbGVyIGFkZHJlc3MgcG9pbnRlcnMKLSovCi0KKyAqLwog
c3RhdGljIHZvaWQgczNjMjQxMGZiX3NldF9sY2RhZGRyKHN0cnVjdCBzM2MyNDEwZmJfaW5mbyAq
ZmJpKQogewogCXN0cnVjdCBmYl92YXJfc2NyZWVuaW5mbyAqdmFyID0gJmZiaS0+ZmItPnZhcjsK
IAl1bnNpZ25lZCBsb25nIHNhZGRyMSwgc2FkZHIyLCBzYWRkcjM7CisJaW50IGxpbmVfbGVuZ3Ro
ID0gdmFyLT54cmVzICogdmFyLT5iaXRzX3Blcl9waXhlbDsKIAogCXNhZGRyMSAgPSBmYmktPmZi
LT5maXguc21lbV9zdGFydCA+PiAxOwogCXNhZGRyMiAgPSBmYmktPmZiLT5maXguc21lbV9zdGFy
dDsKLQlzYWRkcjIgKz0gKHZhci0+eHJlcyAqIHZhci0+eXJlcyAqIHZhci0+Yml0c19wZXJfcGl4
ZWwpLzg7Ci0Jc2FkZHIyPj49IDE7CisJc2FkZHIyICs9IChsaW5lX2xlbmd0aCAqIHZhci0+eXJl
cykgLyA4OworCXNhZGRyMiA+Pj0gMTsKIAotCXNhZGRyMyA9ICBTM0MyNDEwX09GRlNJWkUoMCkg
fCBTM0MyNDEwX1BBR0VXSURUSCgodmFyLT54cmVzICogdmFyLT5iaXRzX3Blcl9waXhlbCAvIDE2
KSAmIDB4M2ZmKTsKKwlzYWRkcjMgPSBTM0MyNDEwX09GRlNJWkUoMCkgfAorCQkgUzNDMjQxMF9Q
QUdFV0lEVEgoKGxpbmVfbGVuZ3RoIC8gMTYpICYgMHgzZmYpOwogCiAJZHByaW50aygiTENEU0FE
RFIxID0gMHglMDhseFxuIiwgc2FkZHIxKTsKIAlkcHJpbnRrKCJMQ0RTQUREUjIgPSAweCUwOGx4
XG4iLCBzYWRkcjIpOwpAQCAtMTQ1LDggKzE0NSw3IEBAIHN0YXRpYyB2b2lkIHMzYzI0MTBmYl9z
ZXRfbGNkYWRkcihzdHJ1Y3QKIC8qIHMzYzI0MTBmYl9jYWxjX3BpeGNsaygpCiAgKgogICogY2Fs
Y3VsYXRlIGRpdmlzb3IgZm9yIGNsay0+cGl4Y2xrCi0qLwotCisgKi8KIHN0YXRpYyB1bnNpZ25l
ZCBpbnQgczNjMjQxMGZiX2NhbGNfcGl4Y2xrKHN0cnVjdCBzM2MyNDEwZmJfaW5mbyAqZmJpLAog
CQkJCQkgIHVuc2lnbmVkIGxvbmcgcGl4Y2xrKQogewpAQCAtMTU5LDggKzE1OCw4IEBAIHN0YXRp
YyB1bnNpZ25lZCBpbnQgczNjMjQxMGZiX2NhbGNfcGl4Y2wKIAkgKi8KIAogCWRpdiA9ICh1bnNp
Z25lZCBsb25nIGxvbmcpY2xrICogcGl4Y2xrOwotCWRvX2RpdihkaXYsMTAwMDAwMFVMKTsKLQlk
b19kaXYoZGl2LDEwMDAwMDBVTCk7CisJZG9fZGl2KGRpdiwgMTAwMDAwMFVMKTsKKwlkb19kaXYo
ZGl2LCAxMDAwMDAwVUwpOwogCiAJZHByaW50aygicGl4Y2xrICVsZCwgZGl2aXNvciBpcyAlbGRc
biIsIHBpeGNsaywgKGxvbmcpZGl2KTsKIAlyZXR1cm4gZGl2OwpAQCAtMTk4LDkzICsxOTcsODQg
QEAgc3RhdGljIGludCBzM2MyNDEwZmJfY2hlY2tfdmFyKHN0cnVjdCBmYgogCWVsc2UgaWYgKHZh
ci0+Yml0c19wZXJfcGl4ZWwgPCBmYmktPm1hY2hfaW5mby0+YnBwLm1pbikKIAkJdmFyLT5iaXRz
X3Blcl9waXhlbCA9IGZiaS0+bWFjaF9pbmZvLT5icHAubWluOwogCisJdmFyLT50cmFuc3Aub2Zm
c2V0ID0gMDsKKwl2YXItPnRyYW5zcC5sZW5ndGggPSAwOwogCS8qIHNldCByL2cvYiBwb3NpdGlv
bnMgKi8KIAlzd2l0Y2ggKHZhci0+Yml0c19wZXJfcGl4ZWwpIHsKLQkJY2FzZSAxOgotCQljYXNl
IDI6Ci0JCWNhc2UgNDoKLQkJCXZhci0+cmVkLm9mZnNldCAgICAJPSAwOwotCQkJdmFyLT5yZWQu
bGVuZ3RoICAgIAk9IHZhci0+Yml0c19wZXJfcGl4ZWw7Ci0JCQl2YXItPmdyZWVuICAgICAgICAg
CT0gdmFyLT5yZWQ7Ci0JCQl2YXItPmJsdWUgICAgICAgICAgCT0gdmFyLT5yZWQ7Ci0JCQl2YXIt
PnRyYW5zcC5vZmZzZXQgCT0gMDsKLQkJCXZhci0+dHJhbnNwLmxlbmd0aCAJPSAwOwotCQkJYnJl
YWs7Ci0JCWNhc2UgODoKLQkJCWlmICggZmJpLT5tYWNoX2luZm8tPnR5cGUgIT0gUzNDMjQxMF9M
Q0RDT04xX1RGVCApIHsKLQkJCQkvKiA4IGJwcCAzMzIgKi8KLQkJCQl2YXItPnJlZC5sZW5ndGgJ
CT0gMzsKLQkJCQl2YXItPnJlZC5vZmZzZXQJCT0gNTsKLQkJCQl2YXItPmdyZWVuLmxlbmd0aAk9
IDM7Ci0JCQkJdmFyLT5ncmVlbi5vZmZzZXQJPSAyOwotCQkJCXZhci0+Ymx1ZS5sZW5ndGgJPSAy
OwotCQkJCXZhci0+Ymx1ZS5vZmZzZXQJPSAwOwotCQkJCXZhci0+dHJhbnNwLmxlbmd0aAk9IDA7
Ci0JCQl9IGVsc2UgewotCQkJCXZhci0+cmVkLm9mZnNldCAgICAJPSAwOwotCQkJCXZhci0+cmVk
Lmxlbmd0aCAgICAJPSB2YXItPmJpdHNfcGVyX3BpeGVsOwotCQkJCXZhci0+Z3JlZW4gICAgICAg
ICAJPSB2YXItPnJlZDsKLQkJCQl2YXItPmJsdWUgICAgICAgICAgCT0gdmFyLT5yZWQ7Ci0JCQkJ
dmFyLT50cmFuc3Aub2Zmc2V0IAk9IDA7Ci0JCQkJdmFyLT50cmFuc3AubGVuZ3RoIAk9IDA7Ci0J
CQl9Ci0JCQlicmVhazsKLQkJY2FzZSAxMjoKLQkJCS8qIDEyIGJwcCA0NDQgKi8KLQkJCXZhci0+
cmVkLmxlbmd0aAkJPSA0OwotCQkJdmFyLT5yZWQub2Zmc2V0CQk9IDg7Ci0JCQl2YXItPmdyZWVu
Lmxlbmd0aAk9IDQ7Ci0JCQl2YXItPmdyZWVuLm9mZnNldAk9IDQ7Ci0JCQl2YXItPmJsdWUubGVu
Z3RoCT0gNDsKKwljYXNlIDE6CisJY2FzZSAyOgorCWNhc2UgNDoKKwkJdmFyLT5yZWQub2Zmc2V0
CT0gMDsKKwkJdmFyLT5yZWQubGVuZ3RoCT0gdmFyLT5iaXRzX3Blcl9waXhlbDsKKwkJdmFyLT5n
cmVlbgk9IHZhci0+cmVkOworCQl2YXItPmJsdWUJPSB2YXItPnJlZDsKKwkJYnJlYWs7CisJY2Fz
ZSA4OgorCQlpZiAoZmJpLT5tYWNoX2luZm8tPnR5cGUgIT0gUzNDMjQxMF9MQ0RDT04xX1RGVCkg
eworCQkJLyogOCBicHAgMzMyICovCisJCQl2YXItPnJlZC5sZW5ndGgJCT0gMzsKKwkJCXZhci0+
cmVkLm9mZnNldAkJPSA1OworCQkJdmFyLT5ncmVlbi5sZW5ndGgJPSAzOworCQkJdmFyLT5ncmVl
bi5vZmZzZXQJPSAyOworCQkJdmFyLT5ibHVlLmxlbmd0aAk9IDI7CiAJCQl2YXItPmJsdWUub2Zm
c2V0CT0gMDsKLQkJCXZhci0+dHJhbnNwLmxlbmd0aAk9IDA7Ci0JCQlicmVhazsKLQotCQlkZWZh
dWx0OgotCQljYXNlIDE2OgotCQkJaWYgKGZiaS0+cmVncy5sY2Rjb241ICYgUzNDMjQxMF9MQ0RD
T041X0ZSTTU2NSApIHsKLQkJCQkvKiAxNiBicHAsIDU2NSBmb3JtYXQgKi8KLQkJCQl2YXItPnJl
ZC5vZmZzZXQJCT0gMTE7Ci0JCQkJdmFyLT5ncmVlbi5vZmZzZXQJPSA1OwotCQkJCXZhci0+Ymx1
ZS5vZmZzZXQJPSAwOwotCQkJCXZhci0+cmVkLmxlbmd0aAkJPSA1OwotCQkJCXZhci0+Z3JlZW4u
bGVuZ3RoCT0gNjsKLQkJCQl2YXItPmJsdWUubGVuZ3RoCT0gNTsKLQkJCQl2YXItPnRyYW5zcC5s
ZW5ndGgJPSAwOwotCQkJfSBlbHNlIHsKLQkJCQkvKiAxNiBicHAsIDU1NTEgZm9ybWF0ICovCi0J
CQkJdmFyLT5yZWQub2Zmc2V0CQk9IDExOwotCQkJCXZhci0+Z3JlZW4ub2Zmc2V0CT0gNjsKLQkJ
CQl2YXItPmJsdWUub2Zmc2V0CT0gMTsKLQkJCQl2YXItPnJlZC5sZW5ndGgJCT0gNTsKLQkJCQl2
YXItPmdyZWVuLmxlbmd0aAk9IDU7Ci0JCQkJdmFyLT5ibHVlLmxlbmd0aAk9IDU7Ci0JCQkJdmFy
LT50cmFuc3AubGVuZ3RoCT0gMDsKLQkJCX0KLQkJCWJyZWFrOwotCQljYXNlIDI0OgotCQkJLyog
MjQgYnBwIDg4OCAqLworCQl9IGVsc2UgeworCQkJdmFyLT5yZWQub2Zmc2V0CQk9IDA7CiAJCQl2
YXItPnJlZC5sZW5ndGgJCT0gODsKLQkJCXZhci0+cmVkLm9mZnNldAkJPSAxNjsKLQkJCXZhci0+
Z3JlZW4ubGVuZ3RoCT0gODsKLQkJCXZhci0+Z3JlZW4ub2Zmc2V0CT0gODsKLQkJCXZhci0+Ymx1
ZS5sZW5ndGgJPSA4OworCQkJdmFyLT5ncmVlbgkJPSB2YXItPnJlZDsKKwkJCXZhci0+Ymx1ZQkJ
PSB2YXItPnJlZDsKKwkJfQorCQlicmVhazsKKwljYXNlIDEyOgorCQkvKiAxMiBicHAgNDQ0ICov
CisJCXZhci0+cmVkLmxlbmd0aAkJPSA0OworCQl2YXItPnJlZC5vZmZzZXQJCT0gODsKKwkJdmFy
LT5ncmVlbi5sZW5ndGgJPSA0OworCQl2YXItPmdyZWVuLm9mZnNldAk9IDQ7CisJCXZhci0+Ymx1
ZS5sZW5ndGgJPSA0OworCQl2YXItPmJsdWUub2Zmc2V0CT0gMDsKKwkJYnJlYWs7CisKKwlkZWZh
dWx0OgorCWNhc2UgMTY6CisJCWlmIChmYmktPnJlZ3MubGNkY29uNSAmIFMzQzI0MTBfTENEQ09O
NV9GUk01NjUpIHsKKwkJCS8qIDE2IGJwcCwgNTY1IGZvcm1hdCAqLworCQkJdmFyLT5yZWQub2Zm
c2V0CQk9IDExOworCQkJdmFyLT5ncmVlbi5vZmZzZXQJPSA1OwogCQkJdmFyLT5ibHVlLm9mZnNl
dAk9IDA7Ci0JCQl2YXItPnRyYW5zcC5sZW5ndGgJPSAwOwotCQkJYnJlYWs7CisJCQl2YXItPnJl
ZC5sZW5ndGgJCT0gNTsKKwkJCXZhci0+Z3JlZW4ubGVuZ3RoCT0gNjsKKwkJCXZhci0+Ymx1ZS5s
ZW5ndGgJPSA1OworCQl9IGVsc2UgeworCQkJLyogMTYgYnBwLCA1NTUxIGZvcm1hdCAqLworCQkJ
dmFyLT5yZWQub2Zmc2V0CQk9IDExOworCQkJdmFyLT5ncmVlbi5vZmZzZXQJPSA2OworCQkJdmFy
LT5ibHVlLm9mZnNldAk9IDE7CisJCQl2YXItPnJlZC5sZW5ndGgJCT0gNTsKKwkJCXZhci0+Z3Jl
ZW4ubGVuZ3RoCT0gNTsKKwkJCXZhci0+Ymx1ZS5sZW5ndGgJPSA1OworCQl9CisJCWJyZWFrOwor
CWNhc2UgMjQ6CisJCS8qIDI0IGJwcCA4ODggKi8KKwkJdmFyLT5yZWQubGVuZ3RoCQk9IDg7CisJ
CXZhci0+cmVkLm9mZnNldAkJPSAxNjsKKwkJdmFyLT5ncmVlbi5sZW5ndGgJPSA4OworCQl2YXIt
PmdyZWVuLm9mZnNldAk9IDg7CisJCXZhci0+Ymx1ZS5sZW5ndGgJPSA4OworCQl2YXItPmJsdWUu
b2Zmc2V0CT0gMDsKKwkJYnJlYWs7CiAKIAogCX0KIAlyZXR1cm4gMDsKIH0KIAotCiAvKiBzM2My
NDEwZmJfYWN0aXZhdGVfdmFyCiAgKgogICogYWN0aXZhdGUgKHNldCkgdGhlIGNvbnRyb2xsZXIg
ZnJvbSB0aGUgZ2l2ZW4gZnJhbWVidWZmZXIKICAqIGluZm9ybWF0aW9uCi0qLwotCisgKi8KIHN0
YXRpYyB2b2lkIHMzYzI0MTBmYl9hY3RpdmF0ZV92YXIoc3RydWN0IHMzYzI0MTBmYl9pbmZvICpm
YmksCiAJCQkJICAgc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIpCiB7CkBAIC0zMTksNyAr
MzA5LDggQEAgc3RhdGljIHZvaWQgczNjMjQxMGZiX2FjdGl2YXRlX3ZhcihzdHJ1YwogCiAJCWRl
ZmF1bHQ6CiAJCQkvKiBpbnZhbGlkIHBpeGVsIGRlcHRoICovCi0JCQlkZXZfZXJyKGZiaS0+ZGV2
LCAiaW52YWxpZCBicHAgJWRcbiIsIHZhci0+Yml0c19wZXJfcGl4ZWwpOworCQkJZGV2X2Vycihm
YmktPmRldiwgImludmFsaWQgYnBwICVkXG4iLAorCQkJCXZhci0+Yml0c19wZXJfcGl4ZWwpOwog
CQl9CiAJZWxzZQogCQlzd2l0Y2ggKHZhci0+Yml0c19wZXJfcGl4ZWwpIHsKQEAgLTM0MSwxOSAr
MzMyLDE4IEBAIHN0YXRpYyB2b2lkIHMzYzI0MTBmYl9hY3RpdmF0ZV92YXIoc3RydWMKIAogCQlk
ZWZhdWx0OgogCQkJLyogaW52YWxpZCBwaXhlbCBkZXB0aCAqLwotCQkJZGV2X2VycihmYmktPmRl
diwgImludmFsaWQgYnBwICVkXG4iLCB2YXItPmJpdHNfcGVyX3BpeGVsKTsKKwkJCWRldl9lcnIo
ZmJpLT5kZXYsICJpbnZhbGlkIGJwcCAlZFxuIiwKKwkJCQl2YXItPmJpdHNfcGVyX3BpeGVsKTsK
IAkJfQogCiAJLyogY2hlY2sgdG8gc2VlIGlmIHdlIG5lZWQgdG8gdXBkYXRlIHN5bmMvYm9yZGVy
cyAqLwogCiAJaWYgKCFmYmktPm1hY2hfaW5mby0+Zml4ZWRfc3luY3MpIHsKIAkJZHByaW50aygi
c2V0dGluZyB2ZXJ0OiB1cD0lZCwgbG93PSVkLCBzeW5jPSVkXG4iLAotCQkJdmFyLT51cHBlcl9t
YXJnaW4sIHZhci0+bG93ZXJfbWFyZ2luLAotCQkJdmFyLT52c3luY19sZW4pOworCQkJdmFyLT51
cHBlcl9tYXJnaW4sIHZhci0+bG93ZXJfbWFyZ2luLCB2YXItPnZzeW5jX2xlbik7CiAKIAkJZHBy
aW50aygic2V0dGluZyBob3J6OiBsZnQ9JWQsIHJ0PSVkLCBzeW5jPSVkXG4iLAotCQkJdmFyLT5s
ZWZ0X21hcmdpbiwgdmFyLT5yaWdodF9tYXJnaW4sCi0JCQl2YXItPmhzeW5jX2xlbik7CisJCQl2
YXItPmxlZnRfbWFyZ2luLCB2YXItPnJpZ2h0X21hcmdpbiwgdmFyLT5oc3luY19sZW4pOwogCiAJ
CWZiaS0+cmVncy5sY2Rjb24yID0KIAkJCVMzQzI0MTBfTENEQ09OMl9WQlBEKHZhci0+dXBwZXJf
bWFyZ2luIC0gMSkgfApAQCAtMzczLDI3ICszNjMsMjQgQEAgc3RhdGljIHZvaWQgczNjMjQxMGZi
X2FjdGl2YXRlX3ZhcihzdHJ1YwogCWZiaS0+cmVncy5sY2Rjb24yICY9IH5TM0MyNDEwX0xDRENP
TjJfTElORVZBTCgweDNmZik7CiAJZmJpLT5yZWdzLmxjZGNvbjIgfD0gIFMzQzI0MTBfTENEQ09O
Ml9MSU5FVkFMKHZhci0+eXJlcyAtIDEpOwogCi0Jc3dpdGNoKGZiaS0+bWFjaF9pbmZvLT50eXBl
KSB7Ci0JCWNhc2UgUzNDMjQxMF9MQ0RDT04xX0RTQ0FONDoKLQkJY2FzZSBTM0MyNDEwX0xDRENP
TjFfU1ROODoKLQkJCWhzID0gdmFyLT54cmVzIC8gODsKLQkJCWJyZWFrOwotCQljYXNlIFMzQzI0
MTBfTENEQ09OMV9TVE40OgotCQkJaHMgPSB2YXItPnhyZXMgLyA0OwotCQkJYnJlYWs7Ci0JCWRl
ZmF1bHQ6Ci0JCWNhc2UgUzNDMjQxMF9MQ0RDT04xX1RGVDoKLQkJCWhzID0gdmFyLT54cmVzOwot
CQkJYnJlYWs7Ci0KKwlzd2l0Y2ggKGZiaS0+bWFjaF9pbmZvLT50eXBlKSB7CisJY2FzZSBTM0My
NDEwX0xDRENPTjFfRFNDQU40OgorCWNhc2UgUzNDMjQxMF9MQ0RDT04xX1NUTjg6CisJCWhzID0g
dmFyLT54cmVzIC8gODsKKwkJYnJlYWs7CisJY2FzZSBTM0MyNDEwX0xDRENPTjFfU1RONDoKKwkJ
aHMgPSB2YXItPnhyZXMgLyA0OworCQlicmVhazsKKwlkZWZhdWx0OgorCWNhc2UgUzNDMjQxMF9M
Q0RDT04xX1RGVDoKKwkJaHMgPSB2YXItPnhyZXM7CisJCWJyZWFrOwogCX0KIAogCS8qIFNwZWNp
YWwgY2FzZXMgOiBTVE4gY29sb3IgZGlzcGxheXMgKi8KLQlpZiAoICgoZmJpLT5yZWdzLmxjZGNv
bjEgJiBTM0MyNDEwX0xDRENPTjFfTU9ERU1BU0spID09IFMzQzI0MTBfTENEQ09OMV9TVE44QlBQ
KSBcCi0JICB8fCAoKGZiaS0+cmVncy5sY2Rjb24xICYgUzNDMjQxMF9MQ0RDT04xX01PREVNQVNL
KSA9PSBTM0MyNDEwX0xDRENPTjFfU1ROMTJCUFApICkgeworCWlmICgoKGZiaS0+cmVncy5sY2Rj
b24xICYgUzNDMjQxMF9MQ0RDT04xX01PREVNQVNLKSA9PSBTM0MyNDEwX0xDRENPTjFfU1ROOEJQ
UCkgfHwKKwkgICAgKChmYmktPnJlZ3MubGNkY29uMSAmIFMzQzI0MTBfTENEQ09OMV9NT0RFTUFT
SykgPT0gUzNDMjQxMF9MQ0RDT04xX1NUTjEyQlBQKSkKIAkJaHMgPSBocyAqIDM7Ci0JfQotCiAK
IAlmYmktPnJlZ3MubGNkY29uMyAmPSB+UzNDMjQxMF9MQ0RDT04zX0hPWlZBTCgweDdmZik7CiAJ
ZmJpLT5yZWdzLmxjZGNvbjMgfD0gIFMzQzI0MTBfTENEQ09OM19IT1pWQUwoaHMgLSAxKTsKQEAg
LTQwMiwxMSArMzg5LDEwIEBAIHN0YXRpYyB2b2lkIHMzYzI0MTBmYl9hY3RpdmF0ZV92YXIoc3Ry
dWMKIAkJaW50IGNsa2RpdiA9IHMzYzI0MTBmYl9jYWxjX3BpeGNsayhmYmksIHZhci0+cGl4Y2xv
Y2spOwogCiAJCWlmIChmYmktPm1hY2hfaW5mby0+dHlwZSA9PSBTM0MyNDEwX0xDRENPTjFfVEZU
KSB7Ci0JCQljbGtkaXYgPSAoY2xrZGl2IC8gMikgLTE7CisJCQljbGtkaXYgPSAoY2xrZGl2IC8g
MikgLSAxOwogCQkJaWYgKGNsa2RpdiA8IDApCiAJCQkJY2xrZGl2ID0gMDsKLQkJfQotCQllbHNl
IHsKKwkJfSBlbHNlIHsKIAkJCWNsa2RpdiA9IChjbGtkaXYgLyAyKTsKIAkJCWlmIChjbGtkaXYg
PCAyKQogCQkJCWNsa2RpdiA9IDI7CkBAIC00MzcsOSArNDIzLDggQEAgc3RhdGljIHZvaWQgczNj
MjQxMGZiX2FjdGl2YXRlX3ZhcihzdHJ1YwogCXdyaXRlbChmYmktPnJlZ3MubGNkY29uMSwgUzND
MjQxMF9MQ0RDT04xKTsKIH0KIAotCiAvKgotICogICAgICBzM2MyNDEwZmJfc2V0X3BhciAtIE9w
dGlvbmFsIGZ1bmN0aW9uLiBBbHRlcnMgdGhlIGhhcmR3YXJlIHN0YXRlLgorICogICAgICBzM2My
NDEwZmJfc2V0X3BhciAtIEFsdGVycyB0aGUgaGFyZHdhcmUgc3RhdGUuCiAgKiAgICAgIEBpbmZv
OiBmcmFtZSBidWZmZXIgc3RydWN0dXJlIHRoYXQgcmVwcmVzZW50cyBhIHNpbmdsZSBmcmFtZSBi
dWZmZXIKICAqCiAgKi8KQEAgLTQ0OCwyMCArNDMzLDE5IEBAIHN0YXRpYyBpbnQgczNjMjQxMGZi
X3NldF9wYXIoc3RydWN0IGZiX2kKIAlzdHJ1Y3QgczNjMjQxMGZiX2luZm8gKmZiaSA9IGluZm8t
PnBhcjsKIAlzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciA9ICZpbmZvLT52YXI7CiAKLQlz
d2l0Y2ggKHZhci0+Yml0c19wZXJfcGl4ZWwpCi0JewotCQljYXNlIDE2OgotCQkJZmJpLT5mYi0+
Zml4LnZpc3VhbCA9IEZCX1ZJU1VBTF9UUlVFQ09MT1I7Ci0JCQlicmVhazsKLQkJY2FzZSAxOgot
CQkJIGZiaS0+ZmItPmZpeC52aXN1YWwgPSBGQl9WSVNVQUxfTU9OTzAxOwotCQkJIGJyZWFrOwot
CQlkZWZhdWx0OgotCQkJIGZiaS0+ZmItPmZpeC52aXN1YWwgPSBGQl9WSVNVQUxfUFNFVURPQ09M
T1I7Ci0JCQkgYnJlYWs7CisJc3dpdGNoICh2YXItPmJpdHNfcGVyX3BpeGVsKSB7CisJY2FzZSAx
NjoKKwkJaW5mby0+Zml4LnZpc3VhbCA9IEZCX1ZJU1VBTF9UUlVFQ09MT1I7CisJCWJyZWFrOwor
CWNhc2UgMToKKwkJaW5mby0+Zml4LnZpc3VhbCA9IEZCX1ZJU1VBTF9NT05PMDE7CisJCWJyZWFr
OworCWRlZmF1bHQ6CisJCWluZm8tPmZpeC52aXN1YWwgPSBGQl9WSVNVQUxfUFNFVURPQ09MT1I7
CisJCWJyZWFrOwogCX0KIAotCWZiaS0+ZmItPmZpeC5saW5lX2xlbmd0aCAgICAgPSAodmFyLT53
aWR0aCp2YXItPmJpdHNfcGVyX3BpeGVsKS84OworCWluZm8tPmZpeC5saW5lX2xlbmd0aCA9ICh2
YXItPndpZHRoICogdmFyLT5iaXRzX3Blcl9waXhlbCkgLyA4OwogCiAJLyogYWN0aXZhdGUgdGhp
cyBuZXcgY29uZmlndXJhdGlvbiAqLwogCkBAIC00OTMsNyArNDc3LDggQEAgc3RhdGljIHZvaWQg
c2NoZWR1bGVfcGFsZXR0ZV91cGRhdGUoc3RydQogfQogCiAvKiBmcm9tIHB4YWZiLmMgKi8KLXN0
YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGNoYW5fdG9fZmllbGQodW5zaWduZWQgaW50IGNoYW4s
IHN0cnVjdCBmYl9iaXRmaWVsZCAqYmYpCitzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBjaGFu
X3RvX2ZpZWxkKHVuc2lnbmVkIGludCBjaGFuLAorCQkJCQkgc3RydWN0IGZiX2JpdGZpZWxkICpi
ZikKIHsKIAljaGFuICY9IDB4ZmZmZjsKIAljaGFuID4+PSAxNiAtIGJmLT5sZW5ndGg7CkBAIC01
MDcsMTggKzQ5MiwxOSBAQCBzdGF0aWMgaW50IHMzYzI0MTBmYl9zZXRjb2xyZWcodW5zaWduZWQg
CiAJc3RydWN0IHMzYzI0MTBmYl9pbmZvICpmYmkgPSBpbmZvLT5wYXI7CiAJdW5zaWduZWQgaW50
IHZhbDsKIAotCS8qIGRwcmludGsoInNldGNvbDogcmVnbm89JWQsIHJnYj0lZCwlZCwlZFxuIiwg
cmVnbm8sIHJlZCwgZ3JlZW4sIGJsdWUpOyAqLworCS8qIGRwcmludGsoInNldGNvbDogcmVnbm89
JWQsIHJnYj0lZCwlZCwlZFxuIiwKKwkJICAgcmVnbm8sIHJlZCwgZ3JlZW4sIGJsdWUpOyAqLwog
Ci0Jc3dpdGNoIChmYmktPmZiLT5maXgudmlzdWFsKSB7CisJc3dpdGNoIChpbmZvLT5maXgudmlz
dWFsKSB7CiAJY2FzZSBGQl9WSVNVQUxfVFJVRUNPTE9SOgotCQkvKiB0cnVlLWNvbG91ciwgdXNl
IHBzZXVvLXBhbGV0dGUgKi8KKwkJLyogdHJ1ZS1jb2xvdXIsIHVzZSBwc2V1ZG8tcGFsZXR0ZSAq
LwogCiAJCWlmIChyZWdubyA8IDE2KSB7Ci0JCQl1MzIgKnBhbCA9IGZiaS0+ZmItPnBzZXVkb19w
YWxldHRlOworCQkJdTMyICpwYWwgPSBpbmZvLT5wc2V1ZG9fcGFsZXR0ZTsKIAotCQkJdmFsICA9
IGNoYW5fdG9fZmllbGQocmVkLCAgICZmYmktPmZiLT52YXIucmVkKTsKLQkJCXZhbCB8PSBjaGFu
X3RvX2ZpZWxkKGdyZWVuLCAmZmJpLT5mYi0+dmFyLmdyZWVuKTsKLQkJCXZhbCB8PSBjaGFuX3Rv
X2ZpZWxkKGJsdWUsICAmZmJpLT5mYi0+dmFyLmJsdWUpOworCQkJdmFsICA9IGNoYW5fdG9fZmll
bGQocmVkLCAgICZpbmZvLT52YXIucmVkKTsKKwkJCXZhbCB8PSBjaGFuX3RvX2ZpZWxkKGdyZWVu
LCAmaW5mby0+dmFyLmdyZWVuKTsKKwkJCXZhbCB8PSBjaGFuX3RvX2ZpZWxkKGJsdWUsICAmaW5m
by0+dmFyLmJsdWUpOwogCiAJCQlwYWxbcmVnbm9dID0gdmFsOwogCQl9CkBAIC01MzksMTQgKzUy
NSwxMyBAQCBzdGF0aWMgaW50IHMzYzI0MTBmYl9zZXRjb2xyZWcodW5zaWduZWQgCiAJCWJyZWFr
OwogCiAJZGVmYXVsdDoKLQkJcmV0dXJuIDE7ICAgLyogdW5rbm93biB0eXBlICovCisJCXJldHVy
biAxOwkvKiB1bmtub3duIHR5cGUgKi8KIAl9CiAKIAlyZXR1cm4gMDsKIH0KIAotCi0vKioKKy8q
CiAgKiAgICAgIHMzYzI0MTBmYl9ibGFuawogICoJQGJsYW5rX21vZGU6IHRoZSBibGFuayBtb2Rl
IHdlIHdhbnQuCiAgKglAaW5mbzogZnJhbWUgYnVmZmVyIHN0cnVjdHVyZSB0aGF0IHJlcHJlc2Vu
dHMgYSBzaW5nbGUgZnJhbWUgYnVmZmVyCkBAIC01NzksMTIgKzU2NCwxNCBAQCBzdGF0aWMgaW50
IHMzYzI0MTBmYl9ibGFuayhpbnQgYmxhbmtfbW9kCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBp
bnQgczNjMjQxMGZiX2RlYnVnX3Nob3coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNl
X2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQorc3RhdGljIGludCBzM2MyNDEwZmJfZGVidWdf
c2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0
dHIsIGNoYXIgKmJ1ZikKIHsKIAlyZXR1cm4gc25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlc1xu
IiwgZGVidWcgPyAib24iIDogIm9mZiIpOwogfQotc3RhdGljIGludCBzM2MyNDEwZmJfZGVidWdf
c3RvcmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwK
LQkJCQkJICAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgbGVuKQorc3RhdGljIGludCBzM2MyNDEw
ZmJfZGVidWdfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LAorCQkJCSBzdHJ1Y3QgZGV2aWNlX2F0
dHJpYnV0ZSAqYXR0ciwKKwkJCQkgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgbGVuKQogewogCWlm
IChtYWNoX2luZm8gPT0gTlVMTCkKIAkJcmV0dXJuIC1FSU5WQUw7CkBAIC02MDcsMTAgKzU5NCw3
IEBAIHN0YXRpYyBpbnQgczNjMjQxMGZiX2RlYnVnX3N0b3JlKHN0cnVjdCAKIAlyZXR1cm4gbGVu
OwogfQogCi0KLXN0YXRpYyBERVZJQ0VfQVRUUihkZWJ1ZywgMDY2NiwKLQkJICAgczNjMjQxMGZi
X2RlYnVnX3Nob3csCi0JCSAgIHMzYzI0MTBmYl9kZWJ1Z19zdG9yZSk7CitzdGF0aWMgREVWSUNF
X0FUVFIoZGVidWcsIDA2NjYsIHMzYzI0MTBmYl9kZWJ1Z19zaG93LCBzM2MyNDEwZmJfZGVidWdf
c3RvcmUpOwogCiBzdGF0aWMgc3RydWN0IGZiX29wcyBzM2MyNDEwZmJfb3BzID0gewogCS5vd25l
cgkJPSBUSElTX01PRFVMRSwKQEAgLTYyMyw3ICs2MDcsNiBAQCBzdGF0aWMgc3RydWN0IGZiX29w
cyBzM2MyNDEwZmJfb3BzID0gewogCS5mYl9pbWFnZWJsaXQJPSBjZmJfaW1hZ2VibGl0LAogfTsK
IAotCiAvKgogICogczNjMjQxMGZiX21hcF92aWRlb19tZW1vcnkoKToKICAqCUFsbG9jYXRlcyB0
aGUgRFJBTSBtZW1vcnkgZm9yIHRoZSBmcmFtZSBidWZmZXIuICBUaGlzIGJ1ZmZlciBpcwpAQCAt
NjYxLDcgKzY0NCw4IEBAIHN0YXRpYyBpbnQgX19pbml0IHMzYzI0MTBmYl9tYXBfdmlkZW9fbWUK
IAogc3RhdGljIGlubGluZSB2b2lkIHMzYzI0MTBmYl91bm1hcF92aWRlb19tZW1vcnkoc3RydWN0
IHMzYzI0MTBmYl9pbmZvICpmYmkpCiB7Ci0JZG1hX2ZyZWVfd3JpdGVjb21iaW5lKGZiaS0+ZGV2
LGZiaS0+bWFwX3NpemUsZmJpLT5tYXBfY3B1LCBmYmktPm1hcF9kbWEpOworCWRtYV9mcmVlX3dy
aXRlY29tYmluZShmYmktPmRldiwgZmJpLT5tYXBfc2l6ZSwgZmJpLT5tYXBfY3B1LAorCQkJICAg
ICAgZmJpLT5tYXBfZG1hKTsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkIG1vZGlmeV9ncGlvKHZv
aWQgX19pb21lbSAqcmVnLApAQCAtNjczLDExICs2NTcsOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
bW9kaWZ5X2dwaW8odm9pZCBfX2lvCiAJd3JpdGVsKHRtcCB8IHNldCwgcmVnKTsKIH0KIAotCiAv
KgogICogczNjMjQxMGZiX2luaXRfcmVnaXN0ZXJzIC0gSW5pdGlhbGlzZSBhbGwgTENELXJlbGF0
ZWQgcmVnaXN0ZXJzCiAgKi8KLQogc3RhdGljIGludCBzM2MyNDEwZmJfaW5pdF9yZWdpc3RlcnMo
c3RydWN0IHMzYzI0MTBmYl9pbmZvICpmYmkpCiB7CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKQEAg
LTcwMiw3ICs2ODQsNyBAQCBzdGF0aWMgaW50IHMzYzI0MTBmYl9pbml0X3JlZ2lzdGVycyhzdHJ1
CiAJd3JpdGVsKGZiaS0+cmVncy5sY2Rjb240LCByZWdzICsgUzNDMjQxMF9MQ0RDT040KTsKIAl3
cml0ZWwoZmJpLT5yZWdzLmxjZGNvbjUsIHJlZ3MgKyBTM0MyNDEwX0xDRENPTjUpOwogCi0gCXMz
YzI0MTBmYl9zZXRfbGNkYWRkcihmYmkpOworCXMzYzI0MTBmYl9zZXRfbGNkYWRkcihmYmkpOwog
CiAJZHByaW50aygiTFBDU0VMICAgID0gMHglMDhseFxuIiwgbWFjaF9pbmZvLT5scGNzZWwpOwog
CXdyaXRlbChtYWNoX2luZm8tPmxwY3NlbCwgcmVncyArIFMzQzI0MTBfTFBDU0VMKTsKQEAgLTcy
MSwxMyArNzAzLDEzIEBAIHN0YXRpYyBpbnQgczNjMjQxMGZiX2luaXRfcmVnaXN0ZXJzKHN0cnUK
IHN0YXRpYyB2b2lkIHMzYzI0MTBmYl93cml0ZV9wYWxldHRlKHN0cnVjdCBzM2MyNDEwZmJfaW5m
byAqZmJpKQogewogCXVuc2lnbmVkIGludCBpOwotCXVuc2lnbmVkIGxvbmcgZW50OwogCXZvaWQg
X19pb21lbSAqcmVncyA9IGZiaS0+aW87CiAKIAlmYmktPnBhbGV0dGVfcmVhZHkgPSAwOwogCiAJ
Zm9yIChpID0gMDsgaSA8IDI1NjsgaSsrKSB7Ci0JCWlmICgoZW50ID0gZmJpLT5wYWxldHRlX2J1
ZmZlcltpXSkgPT0gUEFMRVRURV9CVUZGX0NMRUFSKQorCQl1bnNpZ25lZCBsb25nIGVudCA9IGZi
aS0+cGFsZXR0ZV9idWZmZXJbaV07CisJCWlmIChlbnQgPT0gUEFMRVRURV9CVUZGX0NMRUFSKQog
CQkJY29udGludWU7CiAKIAkJd3JpdGVsKGVudCwgcmVncyArIFMzQzI0MTBfVEZUUEFMKGkpKTsK
QEAgLTc2MSwxMiArNzQzLDEyIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBzM2MyNDEwZmJfaXJxKGlu
dCBpcnEKIAlyZXR1cm4gSVJRX0hBTkRMRUQ7CiB9CiAKLXN0YXRpYyBjaGFyIGRyaXZlcl9uYW1l
W109InMzYzI0MTBmYiI7CitzdGF0aWMgY2hhciBkcml2ZXJfbmFtZVtdID0gInMzYzI0MTBmYiI7
CiAKIHN0YXRpYyBpbnQgX19pbml0IHMzYzI0MTBmYl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQogewogCXN0cnVjdCBzM2MyNDEwZmJfaW5mbyAqaW5mbzsKLQlzdHJ1Y3QgZmJf
aW5mbwkgICAqZmJpbmZvOworCXN0cnVjdCBmYl9pbmZvICpmYmluZm87CiAJc3RydWN0IHMzYzI0
MTBmYl9odyAqbXJlZ3M7CiAJc3RydWN0IHJlc291cmNlICpyZXM7CiAJaW50IHJldDsKQEAgLTc3
Nyw3ICs3NTksOCBAQCBzdGF0aWMgaW50IF9faW5pdCBzM2MyNDEwZmJfcHJvYmUoc3RydWN0CiAK
IAltYWNoX2luZm8gPSBwZGV2LT5kZXYucGxhdGZvcm1fZGF0YTsKIAlpZiAobWFjaF9pbmZvID09
IE5VTEwpIHsKLQkJZGV2X2VycigmcGRldi0+ZGV2LCJubyBwbGF0Zm9ybSBkYXRhIGZvciBsY2Qs
IGNhbm5vdCBhdHRhY2hcbiIpOworCQlkZXZfZXJyKCZwZGV2LT5kZXYsCisJCQkibm8gcGxhdGZv
cm0gZGF0YSBmb3IgbGNkLCBjYW5ub3QgYXR0YWNoXG4iKTsKIAkJcmV0dXJuIC1FSU5WQUw7CiAJ
fQogCkBAIC03OTAsOSArNzczLDggQEAgc3RhdGljIGludCBfX2luaXQgczNjMjQxMGZiX3Byb2Jl
KHN0cnVjdAogCX0KIAogCWZiaW5mbyA9IGZyYW1lYnVmZmVyX2FsbG9jKHNpemVvZihzdHJ1Y3Qg
czNjMjQxMGZiX2luZm8pLCAmcGRldi0+ZGV2KTsKLQlpZiAoIWZiaW5mbykgeworCWlmICghZmJp
bmZvKQogCQlyZXR1cm4gLUVOT01FTTsKLQl9CiAKIAlpbmZvID0gZmJpbmZvLT5wYXI7CiAJaW5m
by0+ZmIgPSBmYmluZm87CkBAIC04MDAsMTIgKzc4MiwxMiBAQCBzdGF0aWMgaW50IF9faW5pdCBz
M2MyNDEwZmJfcHJvYmUoc3RydWN0CiAKIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRl
diwgSU9SRVNPVVJDRV9NRU0sIDApOwogCWlmIChyZXMgPT0gTlVMTCkgewotCQlkZXZfZXJyKCZw
ZGV2LT5kZXYsICJmYWlsZWQgdG8gZ2V0IG1lbW9yeSByZWdpc3RlcnNuIik7CisJCWRldl9lcnIo
JnBkZXYtPmRldiwgImZhaWxlZCB0byBnZXQgbWVtb3J5IHJlZ2lzdGVyc1xuIik7CiAJCXJldCA9
IC1FTlhJTzsKIAkJZ290byBkZWFsbG9jX2ZiOwogCX0KIAotCXNpemUgPSAocmVzLT5lbmQgLSBy
ZXMtPnN0YXJ0KSsxOworCXNpemUgPSAocmVzLT5lbmQgLSByZXMtPnN0YXJ0KSArIDE7CiAJaW5m
by0+bWVtID0gcmVxdWVzdF9tZW1fcmVnaW9uKHJlcy0+c3RhcnQsIHNpemUsIHBkZXYtPm5hbWUp
OwogCWlmIChpbmZvLT5tZW0gPT0gTlVMTCkgewogCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWls
ZWQgdG8gZ2V0IG1lbW9yeSByZWdpb25cbiIpOwpAQCAtODU5LDEzICs4NDEsMTkgQEAgc3RhdGlj
IGludCBfX2luaXQgczNjMjQxMGZiX3Byb2JlKHN0cnVjdAogCWZiaW5mby0+dmFyLnlyZXNfdmly
dHVhbCAgICA9IG1hY2hfaW5mby0+eXJlcy5kZWZ2YWw7CiAJZmJpbmZvLT52YXIuYml0c19wZXJf
cGl4ZWwgID0gbWFjaF9pbmZvLT5icHAuZGVmdmFsOwogCi0JZmJpbmZvLT52YXIudXBwZXJfbWFy
Z2luICAgID0gUzNDMjQxMF9MQ0RDT04yX0dFVF9WQlBEKG1yZWdzLT5sY2Rjb24yKSArIDE7Ci0J
ZmJpbmZvLT52YXIubG93ZXJfbWFyZ2luICAgID0gUzNDMjQxMF9MQ0RDT04yX0dFVF9WRlBEKG1y
ZWdzLT5sY2Rjb24yKSArIDE7Ci0JZmJpbmZvLT52YXIudnN5bmNfbGVuCSAgICA9IFMzQzI0MTBf
TENEQ09OMl9HRVRfVlNQVyhtcmVncy0+bGNkY29uMikgKyAxOwotCi0JZmJpbmZvLT52YXIubGVm
dF9tYXJnaW4JICAgID0gUzNDMjQxMF9MQ0RDT04zX0dFVF9IRlBEKG1yZWdzLT5sY2Rjb24zKSAr
IDE7Ci0JZmJpbmZvLT52YXIucmlnaHRfbWFyZ2luICAgID0gUzNDMjQxMF9MQ0RDT04zX0dFVF9I
QlBEKG1yZWdzLT5sY2Rjb24zKSArIDE7Ci0JZmJpbmZvLT52YXIuaHN5bmNfbGVuCSAgICA9IFMz
QzI0MTBfTENEQ09ONF9HRVRfSFNQVyhtcmVncy0+bGNkY29uNCkgKyAxOworCWZiaW5mby0+dmFy
LnVwcGVyX21hcmdpbiAgICA9CisJCQkJUzNDMjQxMF9MQ0RDT04yX0dFVF9WQlBEKG1yZWdzLT5s
Y2Rjb24yKSArIDE7CisJZmJpbmZvLT52YXIubG93ZXJfbWFyZ2luICAgID0KKwkJCQlTM0MyNDEw
X0xDRENPTjJfR0VUX1ZGUEQobXJlZ3MtPmxjZGNvbjIpICsgMTsKKwlmYmluZm8tPnZhci52c3lu
Y19sZW4JICAgID0KKwkJCQlTM0MyNDEwX0xDRENPTjJfR0VUX1ZTUFcobXJlZ3MtPmxjZGNvbjIp
ICsgMTsKKworCWZiaW5mby0+dmFyLmxlZnRfbWFyZ2luCSAgICA9CisJCQkJUzNDMjQxMF9MQ0RD
T04zX0dFVF9IRlBEKG1yZWdzLT5sY2Rjb24zKSArIDE7CisJZmJpbmZvLT52YXIucmlnaHRfbWFy
Z2luICAgID0KKwkJCQlTM0MyNDEwX0xDRENPTjNfR0VUX0hCUEQobXJlZ3MtPmxjZGNvbjMpICsg
MTsKKwlmYmluZm8tPnZhci5oc3luY19sZW4JICAgID0KKwkJCQlTM0MyNDEwX0xDRENPTjRfR0VU
X0hTUFcobXJlZ3MtPmxjZGNvbjQpICsgMTsKIAogCWZiaW5mby0+dmFyLnJlZC5vZmZzZXQgICAg
ICA9IDExOwogCWZiaW5mby0+dmFyLmdyZWVuLm9mZnNldCAgICA9IDU7CkBAIC04NzUsNyArODYz
LDcgQEAgc3RhdGljIGludCBfX2luaXQgczNjMjQxMGZiX3Byb2JlKHN0cnVjdAogCWZiaW5mby0+
dmFyLmdyZWVuLmxlbmd0aCAgICA9IDY7CiAJZmJpbmZvLT52YXIuYmx1ZS5sZW5ndGggICAgID0g
NTsKIAlmYmluZm8tPnZhci50cmFuc3AubGVuZ3RoICAgPSAwOwotCWZiaW5mby0+Zml4LnNtZW1f
bGVuICAgICAgICA9CW1hY2hfaW5mby0+eHJlcy5tYXggKgorCWZiaW5mby0+Zml4LnNtZW1fbGVu
CSAgICA9CW1hY2hfaW5mby0+eHJlcy5tYXggKgogCQkJCQltYWNoX2luZm8tPnlyZXMubWF4ICoK
IAkJCQkJbWFjaF9pbmZvLT5icHAubWF4IC8gODsKIApAQCAtOTA0LDIwICs4OTIsMjEgQEAgc3Rh
dGljIGludCBfX2luaXQgczNjMjQxMGZiX3Byb2JlKHN0cnVjdAogCS8qIEluaXRpYWxpemUgdmlk
ZW8gbWVtb3J5ICovCiAJcmV0ID0gczNjMjQxMGZiX21hcF92aWRlb19tZW1vcnkoaW5mbyk7CiAJ
aWYgKHJldCkgewotCQlwcmludGsoIEtFUk5fRVJSICJGYWlsZWQgdG8gYWxsb2NhdGUgdmlkZW8g
UkFNOiAlZFxuIiwgcmV0KTsKKwkJcHJpbnRrKEtFUk5fRVJSICJGYWlsZWQgdG8gYWxsb2NhdGUg
dmlkZW8gUkFNOiAlZFxuIiwgcmV0KTsKIAkJcmV0ID0gLUVOT01FTTsKIAkJZ290byByZWxlYXNl
X2Nsb2NrOwogCX0KIAogCWRwcmludGsoImdvdCB2aWRlbyBtZW1vcnlcbiIpOwogCi0JcmV0ID0g
czNjMjQxMGZiX2luaXRfcmVnaXN0ZXJzKGluZm8pOworCXMzYzI0MTBmYl9pbml0X3JlZ2lzdGVy
cyhpbmZvKTsKIAotCXJldCA9IHMzYzI0MTBmYl9jaGVja192YXIoJmZiaW5mby0+dmFyLCBmYmlu
Zm8pOworCXMzYzI0MTBmYl9jaGVja192YXIoJmZiaW5mby0+dmFyLCBmYmluZm8pOwogCiAJcmV0
ID0gcmVnaXN0ZXJfZnJhbWVidWZmZXIoZmJpbmZvKTsKIAlpZiAocmV0IDwgMCkgewotCQlwcmlu
dGsoS0VSTl9FUlIgIkZhaWxlZCB0byByZWdpc3RlciBmcmFtZWJ1ZmZlciBkZXZpY2U6ICVkXG4i
LCByZXQpOworCQlwcmludGsoS0VSTl9FUlIgIkZhaWxlZCB0byByZWdpc3RlciBmcmFtZWJ1ZmZl
ciBkZXZpY2U6ICVkXG4iLAorCQkJcmV0KTsKIAkJZ290byBmcmVlX3ZpZGVvX21lbW9yeTsKIAl9
CiAKQEAgLTkzNSw3ICs5MjQsNyBAQCByZWxlYXNlX2Nsb2NrOgogCWNsa19kaXNhYmxlKGluZm8t
PmNsayk7CiAJY2xrX3B1dChpbmZvLT5jbGspOwogcmVsZWFzZV9pcnE6Ci0JZnJlZV9pcnEoaXJx
LGluZm8pOworCWZyZWVfaXJxKGlycSwgaW5mbyk7CiByZWxlYXNlX3JlZ3M6CiAJaW91bm1hcChp
bmZvLT5pbyk7CiByZWxlYXNlX21lbToKQEAgLTk0OSw4ICs5MzgsNyBAQCBkZWFsbG9jX2ZiOgog
LyogczNjMjQxMGZiX3N0b3BfbGNkCiAgKgogICogc2h1dGRvd24gdGhlIGxjZCBjb250cm9sbGVy
Ci0qLwotCisgKi8KIHN0YXRpYyB2b2lkIHMzYzI0MTBmYl9zdG9wX2xjZChzdHJ1Y3QgczNjMjQx
MGZiX2luZm8gKmZiaSkKIHsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwpAQCAtOTY4LDcgKzk1Niw3
IEBAIHN0YXRpYyB2b2lkIHMzYzI0MTBmYl9zdG9wX2xjZChzdHJ1Y3QgczMKICAqLwogc3RhdGlj
IGludCBzM2MyNDEwZmJfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7Ci0J
c3RydWN0IGZiX2luZm8JICAgKmZiaW5mbyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOwor
CXN0cnVjdCBmYl9pbmZvICpmYmluZm8gPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKIAlz
dHJ1Y3QgczNjMjQxMGZiX2luZm8gKmluZm8gPSBmYmluZm8tPnBhcjsKIAlpbnQgaXJxOwogCkBA
IC05NzcsMTQgKzk2NSwxNCBAQCBzdGF0aWMgaW50IHMzYzI0MTBmYl9yZW1vdmUoc3RydWN0IHBs
YXRmCiAKIAlzM2MyNDEwZmJfdW5tYXBfdmlkZW9fbWVtb3J5KGluZm8pOwogCi0gCWlmIChpbmZv
LT5jbGspIHsKLSAJCWNsa19kaXNhYmxlKGluZm8tPmNsayk7Ci0gCQljbGtfcHV0KGluZm8tPmNs
ayk7Ci0gCQlpbmZvLT5jbGsgPSBOVUxMOworCWlmIChpbmZvLT5jbGspIHsKKwkJY2xrX2Rpc2Fi
bGUoaW5mby0+Y2xrKTsKKwkJY2xrX3B1dChpbmZvLT5jbGspOworCQlpbmZvLT5jbGsgPSBOVUxM
OwogCX0KIAogCWlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7Ci0JZnJlZV9pcnEoaXJx
LGluZm8pOworCWZyZWVfaXJxKGlycSwgaW5mbyk7CiAKIAlyZWxlYXNlX3Jlc291cmNlKGluZm8t
Pm1lbSk7CiAJa2ZyZWUoaW5mby0+bWVtKTsKQEAgLTk5Nyw3ICs5ODUsNiBAQCBzdGF0aWMgaW50
IHMzYzI0MTBmYl9yZW1vdmUoc3RydWN0IHBsYXRmCiAjaWZkZWYgQ09ORklHX1BNCiAKIC8qIHN1
c3BlbmQgYW5kIHJlc3VtZSBzdXBwb3J0IGZvciB0aGUgbGNkIGNvbnRyb2xsZXIgKi8KLQogc3Rh
dGljIGludCBzM2MyNDEwZmJfc3VzcGVuZChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYsIHBt
X21lc3NhZ2VfdCBzdGF0ZSkKIHsKIAlzdHJ1Y3QgZmJfaW5mbwkgICAqZmJpbmZvID0gcGxhdGZv
cm1fZ2V0X2RydmRhdGEoZGV2KTsKQEAgLTEwNTQsMTAgKzEwNDEsMTAgQEAgc3RhdGljIHZvaWQg
X19leGl0IHMzYzI0MTBmYl9jbGVhbnVwKHZvaQogCXBsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVy
KCZzM2MyNDEwZmJfZHJpdmVyKTsKIH0KIAotCiBtb2R1bGVfaW5pdChzM2MyNDEwZmJfaW5pdCk7
CiBtb2R1bGVfZXhpdChzM2MyNDEwZmJfY2xlYW51cCk7CiAKLU1PRFVMRV9BVVRIT1IoIkFybmF1
ZCBQYXRhcmQgPGFybmF1ZC5wYXRhcmRAcnRwLW5ldC5vcmc+LCBCZW4gRG9va3MgPGJlbi1saW51
eEBmbHVmZi5vcmc+Iik7CitNT0RVTEVfQVVUSE9SKCJBcm5hdWQgUGF0YXJkIDxhcm5hdWQucGF0
YXJkQHJ0cC1uZXQub3JnPiwgIgorCSAgICAgICJCZW4gRG9va3MgPGJlbi1saW51eEBmbHVmZi5v
cmc+Iik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIkZyYW1lYnVmZmVyIGRyaXZlciBmb3IgdGhlIHMz
YzI0MTAiKTsKIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsK

--part46b2b74ca32ad
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46b2b74ca32ad
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46b2b74ca32ad--
