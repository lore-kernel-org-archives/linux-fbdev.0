From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] s3c2410fb: Add support for STN displays
Date: Mon, 25 Sep 2006 23:17:55 +0200
Message-ID: <85odt3odbw.fsf@orfeo.duckcorp.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRxq8-0002nX-0f for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 14:18:12 -0700
Received: from orfeo.duckcorp.org
	([195.5.254.194] helo=mx.duckcorp.org ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GRxq5-0003kt-3M
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 14:18:11 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: ben-fbdev@fluff.org

--=-=-=

Hi,

This patch add support for STN displays for the s3c2410 ARM SoCs. This
patch introduces some changes in the machine definition files but this
will go through RMK's queue once this patch is merged.

Please consider applying it :)


Regards,
Arnaud


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=stn_support.patch

This patch adds support for stn displays on the s3c2410 arm SoC.

The LCD type is choosen by a new field in the s3c2410fb_mach_info structure and
its value is the value of the PNRMODE bits. This worth to be noted as a value
of 0 means that you configure a 4 bit dual scan stn display.

Signed-Off-By: Arnaud Patard <arnaud.patard@rtp-net.org>
---
 drivers/video/s3c2410fb.c         |  213 	170 +	43 -	0 !
 include/asm-arm/arch-s3c2410/fb.h |    3 	3 +	0 -	0 !
 2 files changed, 173 insertions(+), 43 deletions(-)

Index: linux-2.6/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.orig/drivers/video/s3c2410fb.c	2006-09-25 22:20:05.000000000 +0200
+++ linux-2.6/drivers/video/s3c2410fb.c	2006-09-25 22:20:18.000000000 +0200
@@ -131,7 +131,7 @@ static void s3c2410fb_set_lcdaddr(struct
 	saddr2 += (var->xres * var->yres * var->bits_per_pixel)/8;
 	saddr2>>= 1;
 
-	saddr3 =  S3C2410_OFFSIZE(0) | S3C2410_PAGEWIDTH(var->xres);
+	saddr3 =  S3C2410_OFFSIZE(0) | S3C2410_PAGEWIDTH((var->xres * var->bits_per_pixel / 16) & 0x3ff);
 
 	dprintk("LCDSADDR1 = 0x%08lx\n", saddr1);
 	dprintk("LCDSADDR2 = 0x%08lx\n", saddr2);
@@ -199,28 +199,86 @@ static int s3c2410fb_check_var(struct fb
 		var->bits_per_pixel = fbi->mach_info->bpp.min;
 
 	/* set r/g/b positions */
+	switch (var->bits_per_pixel) {
+		case 1:
+		case 2:
+		case 4:
+			var->red.offset    	= 0;
+			var->red.length    	= var->bits_per_pixel;
+			var->green         	= var->red;
+			var->blue          	= var->red;
+			var->transp.offset 	= 0;
+			var->transp.length 	= 0;
+			break;
+		case 8:
+			if ( fbi->mach_info->type != S3C2410_LCDCON1_TFT ) {
+				/* 8 bpp 332 */
+				var->red.length		= 3;
+				var->red.offset		= 5;
+				var->green.length	= 3;
+				var->green.offset	= 2;
+				var->blue.length	= 2;
+				var->blue.offset	= 0;
+				var->transp.length	= 0;
+			} else {
+				var->red.offset    	= 0;
+				var->red.length    	= var->bits_per_pixel;
+				var->green         	= var->red;
+				var->blue          	= var->red;
+				var->transp.offset 	= 0;
+				var->transp.length 	= 0;
+			}
+			break;
+		case 12:
+			/* 12 bpp 444 */
+			var->red.length		= 4;
+			var->red.offset		= 8;
+			var->green.length	= 4;
+			var->green.offset	= 4;
+			var->blue.length	= 4;
+			var->blue.offset	= 0;
+			var->transp.length	= 0;
+			break;
+
+		default:
+		case 16:
+			if (fbi->regs.lcdcon5 & S3C2410_LCDCON5_FRM565 ) {
+				/* 16 bpp, 565 format */
+				var->red.offset		= 11;
+				var->green.offset	= 5;
+				var->blue.offset	= 0;
+				var->red.length		= 5;
+				var->green.length	= 6;
+				var->blue.length	= 5;
+				var->transp.length	= 0;
+			} else {
+				/* 16 bpp, 5551 format */
+				var->red.offset		= 11;
+				var->green.offset	= 6;
+				var->blue.offset	= 1;
+				var->red.length		= 5;
+				var->green.length	= 5;
+				var->blue.length	= 5;
+				var->transp.length	= 0;
+			}
+			break;
+		case 24:
+			/* 24 bpp 888 */
+			var->red.length		= 8;
+			var->red.offset		= 16;
+			var->green.length	= 8;
+			var->green.offset	= 8;
+			var->blue.length	= 8;
+			var->blue.offset	= 0;
+			var->transp.length	= 0;
+			break;
 
-	if (var->bits_per_pixel == 16) {
-		var->red.offset		= 11;
-		var->green.offset	= 5;
-		var->blue.offset	= 0;
-		var->red.length		= 5;
-		var->green.length	= 6;
-		var->blue.length	= 5;
-		var->transp.length	= 0;
-	} else {
-		var->red.length		= var->bits_per_pixel;
-		var->red.offset		= 0;
-		var->green.length	= var->bits_per_pixel;
-		var->green.offset	= 0;
-		var->blue.length	= var->bits_per_pixel;
-		var->blue.offset	= 0;
-		var->transp.length	= 0;
-	}
 
+	}
 	return 0;
 }
 
+
 /* s3c2410fb_activate_var
  *
  * activate (set) the controller from the given framebuffer
@@ -230,29 +288,61 @@ static int s3c2410fb_check_var(struct fb
 static void s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
 				   struct fb_var_screeninfo *var)
 {
+	int hs;
+
 	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_MODEMASK;
+	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_TFT;
 
 	dprintk("%s: var->xres  = %d\n", __FUNCTION__, var->xres);
 	dprintk("%s: var->yres  = %d\n", __FUNCTION__, var->yres);
 	dprintk("%s: var->bpp   = %d\n", __FUNCTION__, var->bits_per_pixel);
 
-	switch (var->bits_per_pixel) {
-	case 1:
-		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT1BPP;
-		break;
-	case 2:
-		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT2BPP;
-		break;
-	case 4:
-		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT4BPP;
-		break;
-	case 8:
-		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT8BPP;
-		break;
-	case 16:
-		fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT16BPP;
-		break;
-	}
+	fbi->regs.lcdcon1 |= fbi->mach_info->type;
+
+	if (fbi->mach_info->type == S3C2410_LCDCON1_TFT)
+		switch (var->bits_per_pixel) {
+		case 1:
+			fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT1BPP;
+			break;
+		case 2:
+			fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT2BPP;
+			break;
+		case 4:
+			fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT4BPP;
+			break;
+		case 8:
+			fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT8BPP;
+			break;
+		case 16:
+			fbi->regs.lcdcon1 |= S3C2410_LCDCON1_TFT16BPP;
+			break;
+
+		default:
+			/* invalid pixel depth */
+			dev_err(fbi->dev, "invalid bpp %d\n", var->bits_per_pixel);
+		}
+	else
+		switch (var->bits_per_pixel) {
+		case 1:
+			fbi->regs.lcdcon1 |= S3C2410_LCDCON1_STN1BPP;
+			break;
+		case 2:
+			fbi->regs.lcdcon1 |= S3C2410_LCDCON1_STN2GREY;
+			break;
+		case 4:
+			fbi->regs.lcdcon1 |= S3C2410_LCDCON1_STN4GREY;
+			break;
+		case 8:
+			fbi->regs.lcdcon1 |= S3C2410_LCDCON1_STN8BPP;
+			break;
+		case 12:
+			fbi->regs.lcdcon1 |= S3C2410_LCDCON1_STN12BPP;
+			break;
+
+		default:
+			/* invalid pixel depth */
+			dev_err(fbi->dev, "invalid bpp %d\n", var->bits_per_pixel);
+		}
 
 	/* check to see if we need to update sync/borders */
 
@@ -283,15 +373,44 @@ static void s3c2410fb_activate_var(struc
 	fbi->regs.lcdcon2 &= ~S3C2410_LCDCON2_LINEVAL(0x3ff);
 	fbi->regs.lcdcon2 |=  S3C2410_LCDCON2_LINEVAL(var->yres - 1);
 
+	switch(fbi->mach_info->type) {
+		case S3C2410_LCDCON1_DSCAN4:
+		case S3C2410_LCDCON1_STN8:
+			hs = var->xres / 8;
+			break;
+		case S3C2410_LCDCON1_STN4:
+			hs = var->xres / 4;
+			break;
+		default:
+		case S3C2410_LCDCON1_TFT:
+			hs = var->xres;
+			break;
+
+	}
+
+	/* Special cases : STN color displays */
+	if ( ((fbi->regs.lcdcon1 & S3C2410_LCDCON1_MODEMASK) == S3C2410_LCDCON1_STN8BPP) \
+	  || ((fbi->regs.lcdcon1 & S3C2410_LCDCON1_MODEMASK) == S3C2410_LCDCON1_STN12BPP) ) {
+		hs = hs * 3;
+	}
+
+
 	fbi->regs.lcdcon3 &= ~S3C2410_LCDCON3_HOZVAL(0x7ff);
-	fbi->regs.lcdcon3 |=  S3C2410_LCDCON3_HOZVAL(var->xres - 1);
+	fbi->regs.lcdcon3 |=  S3C2410_LCDCON3_HOZVAL(hs - 1);
 
 	if (var->pixclock > 0) {
 		int clkdiv = s3c2410fb_calc_pixclk(fbi, var->pixclock);
 
-		clkdiv = (clkdiv / 2) -1;
-		if (clkdiv < 0)
-			clkdiv = 0;
+		if (fbi->mach_info->type == S3C2410_LCDCON1_TFT) {
+			clkdiv = (clkdiv / 2) -1;
+			if (clkdiv < 0)
+				clkdiv = 0;
+		}
+		else {
+			clkdiv = (clkdiv / 2);
+			if (clkdiv < 2)
+				clkdiv = 2;
+		}
 
 		fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_CLKVAL(0x3ff);
 		fbi->regs.lcdcon1 |=  S3C2410_LCDCON1_CLKVAL(clkdiv);
@@ -329,10 +448,18 @@ static int s3c2410fb_set_par(struct fb_i
 	struct s3c2410fb_info *fbi = info->par;
 	struct fb_var_screeninfo *var = &info->var;
 
-	if (var->bits_per_pixel == 16)
-		fbi->fb->fix.visual = FB_VISUAL_TRUECOLOR;
-	else
-		fbi->fb->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+	switch (var->bits_per_pixel)
+	{
+		case 16:
+			fbi->fb->fix.visual = FB_VISUAL_TRUECOLOR;
+			break;
+		case 1:
+			 fbi->fb->fix.visual = FB_VISUAL_MONO01;
+			 break;
+		default:
+			 fbi->fb->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+			 break;
+	}
 
 	fbi->fb->fix.line_length     = (var->width*var->bits_per_pixel)/8;
 
Index: linux-2.6/include/asm-arm/arch-s3c2410/fb.h
===================================================================
--- linux-2.6.orig/include/asm-arm/arch-s3c2410/fb.h	2006-09-25 22:20:05.000000000 +0200
+++ linux-2.6/include/asm-arm/arch-s3c2410/fb.h	2006-09-25 22:20:18.000000000 +0200
@@ -31,6 +31,9 @@ struct s3c2410fb_hw {
 struct s3c2410fb_mach_info {
 	unsigned char	fixed_syncs;	/* do not update sync/border */
 
+	/* LCD types */
+	int		type;
+
 	/* Screen size */
 	int		width;
 	int		height;

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--=-=-=--
