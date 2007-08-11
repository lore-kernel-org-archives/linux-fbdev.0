From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH 7/7] s3c2410fb: remove lcdcon2 and
	lcdcon3 register fields
Date: Sat, 11 Aug 2007 07:52:03 +0200
Message-ID: <20070811075203.11f631ca.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJjp5-0001FJ-Ng for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 22:47:39 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IJjp4-000077-UB
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 22:47:39 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	11 Aug 2007 07:47:36 +0200
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, Ben Dooks <ben-linux@fluff.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes unused lcdcon2 and lcdcon3 register value
from the s3c2410fb_display structure.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp linux-2.6.22.base/arch/arm/mach-s3c2410/mach-amlm5900.c linux-2.6.22/arch/arm/mach-s3c2410/mach-amlm5900.c
--- linux-2.6.22.base/arch/arm/mach-s3c2410/mach-amlm5900.c	2007-08-11 07:35:50.617123581 +0200
+++ linux-2.6.22/arch/arm/mach-s3c2410/mach-amlm5900.c	2007-08-11 07:33:18.160435570 +0200
@@ -184,8 +184,6 @@ static struct s3c2410fb_display __initda
 	.lower_margin	= 0,
 
 	.lcdcon1	= 0x00008225,
-	.lcdcon2	= 0x0027c000,
-	.lcdcon4	= 0x00000002,
 	.lcdcon5	= 0x00000001,
 };
 
diff -urp linux-2.6.22.base/arch/arm/mach-s3c2410/mach-bast.c linux-2.6.22/arch/arm/mach-s3c2410/mach-bast.c
--- linux-2.6.22.base/arch/arm/mach-s3c2410/mach-bast.c	2007-08-11 07:35:50.629124267 +0200
+++ linux-2.6.22/arch/arm/mach-s3c2410/mach-bast.c	2007-08-11 07:33:18.164435799 +0200
@@ -485,8 +485,6 @@ static struct s3c2410fb_display __initda
 		.bpp		= 4,
 
 		.lcdcon1	= 0x00000176,
-		.lcdcon2	= 0x1d77c7c2,
-		.lcdcon4	= 0x00000057,
 		.lcdcon5	= 0x00014b02,
 	},
 	{
@@ -505,8 +503,6 @@ static struct s3c2410fb_display __initda
 		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
-		.lcdcon2	= 0x1d77c7c2,
-		.lcdcon4	= 0x00000057,
 		.lcdcon5	= 0x00014b02,
 	},
 	{
@@ -525,8 +521,6 @@ static struct s3c2410fb_display __initda
 		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
-		.lcdcon2	= 0x1d77c7c2,
-		.lcdcon4	= 0x00000057,
 		.lcdcon5	= 0x00014b02,
 	},
 	{
@@ -545,8 +539,6 @@ static struct s3c2410fb_display __initda
 		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
-		.lcdcon2	= 0x1d77c7c2,
-		.lcdcon4	= 0x00000057,
 		.lcdcon5	= 0x00014b02,
 	},
 	{
@@ -565,8 +557,6 @@ static struct s3c2410fb_display __initda
 		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
-		.lcdcon2	= 0x1d77c7c2,
-		.lcdcon4	= 0x00000057,
 		.lcdcon5	= 0x00014b02,
 	},
 	{
@@ -585,8 +575,6 @@ static struct s3c2410fb_display __initda
 		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
-		.lcdcon2	= 0x1d77c7c2,
-		.lcdcon4	= 0x00000057,
 		.lcdcon5	= 0x00014b02,
 	},
 	{
@@ -605,8 +593,6 @@ static struct s3c2410fb_display __initda
 		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
-		.lcdcon2	= 0x1d77c7c2,
-		.lcdcon4	= 0x00000057,
 		.lcdcon5	= 0x00014b02,
 	},
 	{
@@ -625,8 +611,6 @@ static struct s3c2410fb_display __initda
 		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
-		.lcdcon2	= 0x1d77c7c2,
-		.lcdcon4	= 0x00000057,
 		.lcdcon5	= 0x00014b02,
 	},
 	{
@@ -645,8 +629,6 @@ static struct s3c2410fb_display __initda
 		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
-		.lcdcon2	= 0x1d77c7c2,
-		.lcdcon4	= 0x00000057,
 		.lcdcon5	= 0x00014b02,
 	},
 };
diff -urp linux-2.6.22.base/arch/arm/mach-s3c2410/mach-h1940.c linux-2.6.22/arch/arm/mach-s3c2410/mach-h1940.c
--- linux-2.6.22.base/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-11 07:35:50.633124495 +0200
+++ linux-2.6.22/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-11 07:33:56.066595720 +0200
@@ -138,14 +138,6 @@ static struct s3c2410fb_display h1940_lc
 			S3C2410_LCDCON1_TFT | \
 			S3C2410_LCDCON1_CLKVAL(0x0C),
 
-	.lcdcon2=	S3C2410_LCDCON2_VBPD(7) | \
-			S3C2410_LCDCON2_LINEVAL(319) | \
-			S3C2410_LCDCON2_VFPD(6) | \
-			S3C2410_LCDCON2_VSPW(0),
-
-	.lcdcon4=	S3C2410_LCDCON4_MVAL(0) | \
-			S3C2410_LCDCON4_HSPW(3),
-
 	.lcdcon5=	S3C2410_LCDCON5_FRM565 | \
 			S3C2410_LCDCON5_INVVLINE | \
 			S3C2410_LCDCON5_HWSWP,
@@ -165,8 +157,6 @@ static struct s3c2410fb_display h1940_lc
 };
 
 static struct s3c2410fb_mach_info h1940_fb_info __initdata = {
-	.fixed_syncs =		1,
-
 	.displays = &h1940_lcd,
 	.num_displays = 1,
 	.default_display = 0,
diff -urp linux-2.6.22.base/arch/arm/mach-s3c2410/mach-qt2410.c linux-2.6.22/arch/arm/mach-s3c2410/mach-qt2410.c
--- linux-2.6.22.base/arch/arm/mach-s3c2410/mach-qt2410.c	2007-08-11 07:35:50.641124950 +0200
+++ linux-2.6.22/arch/arm/mach-s3c2410/mach-qt2410.c	2007-08-11 07:33:18.176436482 +0200
@@ -102,14 +102,6 @@ static struct s3c2410fb_display qt2410_l
 			   S3C2410_LCDCON1_TFT |
 			   S3C2410_LCDCON1_CLKVAL(0x01), /* HCLK/4 */
 
-		.lcdcon2 = S3C2410_LCDCON2_VBPD(18) |	/* 19 */
-			   S3C2410_LCDCON2_LINEVAL(479) |
-			   S3C2410_LCDCON2_VFPD(10) |	/* 11 */
-			   S3C2410_LCDCON2_VSPW(14),	/* 15 */
-
-		.lcdcon4 = S3C2410_LCDCON4_MVAL(0) |
-			   S3C2410_LCDCON4_HSPW(95),	/* 96 */
-
 		.lcdcon5 = S3C2410_LCDCON5_FRM565 |
 			   S3C2410_LCDCON5_INVVLINE |
 			   S3C2410_LCDCON5_INVVFRAME |
@@ -136,14 +128,6 @@ static struct s3c2410fb_display qt2410_l
 			   S3C2410_LCDCON1_TFT |
 			   S3C2410_LCDCON1_CLKVAL(0x01), /* HCLK/4 */
 
-		.lcdcon2 = S3C2410_LCDCON2_VBPD(1) |	/* 2 */
-			   S3C2410_LCDCON2_LINEVAL(639) |/* 640 */
-			   S3C2410_LCDCON2_VFPD(3) |	/* 4 */
-			   S3C2410_LCDCON2_VSPW(1),	/* 2 */
-
-		.lcdcon4 = S3C2410_LCDCON4_MVAL(0) |
-			   S3C2410_LCDCON4_HSPW(7),	/* 8 */
-
 		.lcdcon5 = S3C2410_LCDCON5_FRM565 |
 			   S3C2410_LCDCON5_INVVLINE |
 			   S3C2410_LCDCON5_INVVFRAME |
@@ -169,14 +153,6 @@ static struct s3c2410fb_display qt2410_l
 			   S3C2410_LCDCON1_TFT |
 			   S3C2410_LCDCON1_CLKVAL(0x04),
 
-		.lcdcon2 = S3C2410_LCDCON2_VBPD(1) |
-			   S3C2410_LCDCON2_LINEVAL(319) |
-			   S3C2410_LCDCON2_VFPD(6) |
-			   S3C2410_LCDCON2_VSPW(3),
-
-		.lcdcon4 = S3C2410_LCDCON4_MVAL(0) |
-			   S3C2410_LCDCON4_HSPW(3),
-
 		.lcdcon5 = S3C2410_LCDCON5_FRM565 |
 			   S3C2410_LCDCON5_INVVLINE |
 			   S3C2410_LCDCON5_INVVFRAME |
diff -urp linux-2.6.22.base/arch/arm/mach-s3c2440/mach-rx3715.c linux-2.6.22/arch/arm/mach-s3c2440/mach-rx3715.c
--- linux-2.6.22.base/arch/arm/mach-s3c2440/mach-rx3715.c	2007-08-11 07:35:50.645125177 +0200
+++ linux-2.6.22/arch/arm/mach-s3c2440/mach-rx3715.c	2007-08-11 07:33:18.184436939 +0200
@@ -115,14 +115,6 @@ static struct s3c2410fb_display rx3715_l
 			S3C2410_LCDCON1_TFT | \
 			S3C2410_LCDCON1_CLKVAL(0x0C),
 
-	.lcdcon2 =	S3C2410_LCDCON2_VBPD(5) | \
-			S3C2410_LCDCON2_LINEVAL(319) | \
-			S3C2410_LCDCON2_VFPD(6) | \
-			S3C2410_LCDCON2_VSPW(2),
-
-	.lcdcon4 =	S3C2410_LCDCON4_MVAL(0) | \
-			S3C2410_LCDCON4_HSPW(7),
-
 	.lcdcon5 =	S3C2410_LCDCON5_INVVLINE |
 			S3C2410_LCDCON5_FRM565 |
 			S3C2410_LCDCON5_HWSWP,
@@ -159,8 +151,6 @@ static struct s3c2410fb_mach_info rx3715
 	.gpdcon_mask =	0xffc0fff0,
 	.gpdup =	0x0000faff,
 	.gpdup_mask =	0xffffffff,
-
-	.fixed_syncs =	1,
 };
 
 static struct mtd_partition rx3715_nand_part[] = {
diff -urp linux-2.6.22.base/arch/arm/mach-s3c2440/mach-smdk2440.c linux-2.6.22/arch/arm/mach-s3c2440/mach-smdk2440.c
--- linux-2.6.22.base/arch/arm/mach-s3c2440/mach-smdk2440.c	2007-08-11 07:35:50.653125634 +0200
+++ linux-2.6.22/arch/arm/mach-s3c2440/mach-smdk2440.c	2007-08-11 07:33:18.192437395 +0200
@@ -109,14 +109,6 @@ static struct s3c2410fb_display smdk2440
 			  S3C2410_LCDCON1_TFT |
 			  S3C2410_LCDCON1_CLKVAL(0x04),
 
-	.lcdcon2	= S3C2410_LCDCON2_VBPD(7) |
-			  S3C2410_LCDCON2_LINEVAL(319) |
-			  S3C2410_LCDCON2_VFPD(6) |
-			  S3C2410_LCDCON2_VSPW(3),
-
-	.lcdcon4	= S3C2410_LCDCON4_MVAL(0) |
-			  S3C2410_LCDCON4_HSPW(3),
-
 	.lcdcon5	= S3C2410_LCDCON5_FRM565 |
 			  S3C2410_LCDCON5_INVVLINE |
 			  S3C2410_LCDCON5_INVVFRAME |
diff -urp linux-2.6.22.base/drivers/video/s3c2410fb.c linux-2.6.22/drivers/video/s3c2410fb.c
--- linux-2.6.22.base/drivers/video/s3c2410fb.c	2007-08-11 07:35:50.661126091 +0200
+++ linux-2.6.22/drivers/video/s3c2410fb.c	2007-08-11 07:33:18.196437622 +0200
@@ -341,8 +341,7 @@ static void s3c2410fb_calculate_stn_lcd_
 			S3C2410_LCDCON3_LINEBLANK(var->right_margin / 8) |
 			S3C2410_LCDCON3_HOZVAL(hs - 1);
 
-	regs->lcdcon4 &= ~S3C2410_LCDCON4_HSPW(0xff);
-	regs->lcdcon4 |=  S3C2410_LCDCON4_HSPW(wlh);
+	regs->lcdcon4 = S3C2410_LCDCON4_WLH(wlh);
 }
 
 /* s3c2410fb_calculate_tft_lcd_regs
@@ -399,8 +398,7 @@ static void s3c2410fb_calculate_tft_lcd_
 			S3C2410_LCDCON3_HFPD(var->left_margin - 1) |
 			S3C2410_LCDCON3_HOZVAL(var->xres - 1);
 
-	regs->lcdcon4 &= ~S3C2410_LCDCON4_HSPW(0xff);
-	regs->lcdcon4 |=  S3C2410_LCDCON4_HSPW(var->hsync_len - 1);
+	regs->lcdcon4 = S3C2410_LCDCON4_HSPW(var->hsync_len - 1);
 }
 
 /* s3c2410fb_activate_var
@@ -850,8 +848,6 @@ static int __init s3c2410fb_probe(struct
 	strcpy(fbinfo->fix.id, driver_name);
 
 	info->regs.lcdcon1 = display->lcdcon1;
-	info->regs.lcdcon2 = display->lcdcon2;
-	info->regs.lcdcon4 = display->lcdcon4;
 	info->regs.lcdcon5 = display->lcdcon5;
 
 	/* Stop the video and unset ENVID if set */
diff -urp linux-2.6.22.base/include/asm-arm/arch-s3c2410/fb.h linux-2.6.22/include/asm-arm/arch-s3c2410/fb.h
--- linux-2.6.22.base/include/asm-arm/arch-s3c2410/fb.h	2007-08-11 07:34:55.753997110 +0200
+++ linux-2.6.22/include/asm-arm/arch-s3c2410/fb.h	2007-08-11 07:33:18.204438078 +0200
@@ -45,13 +45,10 @@ struct s3c2410fb_display {
 
 	/* lcd configuration registers */
 	unsigned long	lcdcon1;
-	unsigned long	lcdcon2;
-	unsigned long	lcdcon4;
 	unsigned long	lcdcon5;
 };
 
 struct s3c2410fb_mach_info {
-	unsigned char	fixed_syncs;	/* do not update sync/border */
 
 	struct s3c2410fb_display *displays;	/* attached diplays info */
 	unsigned num_displays;			/* number of defined displays */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
