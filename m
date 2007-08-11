From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH 6/7] s3c2410fb: add pulse length fields
	to s3c2410fb_display
Date: Sat, 11 Aug 2007 07:51:59 +0200
Message-ID: <20070811075159.f4112896.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJjp1-0001Ew-Db for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 22:47:35 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IJjp0-0007g3-L8
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 22:47:35 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	11 Aug 2007 07:47:32 +0200
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

This patch adds synchronization pulse lenght fields to
the s3c2410fb_display structure and makes use of them
in the driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-amlm5900.c linux-2.6.23/arch/arm/mach-s3c2410/mach-amlm5900.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-amlm5900.c	2007-08-05 14:45:43.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-amlm5900.c	2007-08-05 14:34:00.000000000 +0200
@@ -179,6 +179,7 @@ static struct s3c2410fb_display __initda
 	.bpp		= 4,
 	.left_margin	= 1 << (4 + 3),
 	.right_margin	= 8 << 3,
+	.hsync_len	= 48,
 	.upper_margin	= 0,
 	.lower_margin	= 0,
 
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-bast.c linux-2.6.23/arch/arm/mach-s3c2410/mach-bast.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-bast.c	2007-08-05 14:45:43.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-bast.c	2007-08-05 14:36:31.000000000 +0200
@@ -477,8 +477,10 @@ static struct s3c2410fb_display __initda
 		.yres		= 240,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.hsync_len	= 88,
 		.upper_margin	= 30,
 		.lower_margin	= 32,
+		.vsync_len	= 3,
 
 		.bpp		= 4,
 
@@ -497,8 +499,10 @@ static struct s3c2410fb_display __initda
 		.bpp		= 4,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.hsync_len	= 88,
 		.upper_margin	= 30,
 		.lower_margin	= 32,
+		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -515,8 +519,10 @@ static struct s3c2410fb_display __initda
 		.bpp		= 4,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.hsync_len	= 88,
 		.upper_margin	= 30,
 		.lower_margin	= 32,
+		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -533,8 +539,10 @@ static struct s3c2410fb_display __initda
 		.bpp		= 8,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.hsync_len	= 88,
 		.upper_margin	= 30,
 		.lower_margin	= 32,
+		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -551,8 +559,10 @@ static struct s3c2410fb_display __initda
 		.bpp		= 8,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.hsync_len	= 88,
 		.upper_margin	= 30,
 		.lower_margin	= 32,
+		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -569,8 +579,10 @@ static struct s3c2410fb_display __initda
 		.bpp		= 8,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.hsync_len	= 88,
 		.upper_margin	= 30,
 		.lower_margin	= 32,
+		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -587,8 +599,10 @@ static struct s3c2410fb_display __initda
 		.bpp		= 16,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.hsync_len	= 88,
 		.upper_margin	= 30,
 		.lower_margin	= 32,
+		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -605,8 +619,10 @@ static struct s3c2410fb_display __initda
 		.bpp		= 16,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.hsync_len	= 88,
 		.upper_margin	= 30,
 		.lower_margin	= 32,
+		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -623,8 +639,10 @@ static struct s3c2410fb_display __initda
 		.bpp		= 16,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.hsync_len	= 88,
 		.upper_margin	= 30,
 		.lower_margin	= 32,
+		.vsync_len	= 3,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-h1940.c linux-2.6.23/arch/arm/mach-s3c2410/mach-h1940.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-05 14:45:43.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-05 14:35:16.000000000 +0200
@@ -158,8 +158,10 @@ static struct s3c2410fb_display h1940_lc
 	.bpp =		16,
 	.left_margin =	20,
 	.right_margin =	8,
+	.hsync_len =	4,
 	.upper_margin =	8,
 	.lower_margin = 7,
+	.vsync_len =	1,
 };
 
 static struct s3c2410fb_mach_info h1940_fb_info __initdata = {
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-qt2410.c linux-2.6.23/arch/arm/mach-s3c2410/mach-qt2410.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-qt2410.c	2007-08-05 14:45:43.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-qt2410.c	2007-08-05 14:34:58.000000000 +0200
@@ -125,8 +125,10 @@ static struct s3c2410fb_display qt2410_l
 		.bpp		= 16,
 		.left_margin	= 44,
 		.right_margin	= 116,
+		.hsync_len	= 96,
 		.upper_margin	= 19,
 		.lower_margin	= 11,
+		.vsync_len	= 15,
 	},
 	{
 		/* Configuration for 480x640 toppoly TD028TTEC1 */
@@ -156,8 +158,10 @@ static struct s3c2410fb_display qt2410_l
 		.bpp		= 16,
 		.left_margin	= 8,
 		.right_margin	= 24,
+		.hsync_len	= 8,
 		.upper_margin	= 2,
 		.lower_margin	= 4,
+		.vsync_len	= 2,
 	},
 	{
 		/* Config for 240x320 LCD */
@@ -187,8 +191,10 @@ static struct s3c2410fb_display qt2410_l
 		.bpp		= 16,
 		.left_margin	= 13,
 		.right_margin	= 8,
+		.hsync_len	= 4,
 		.upper_margin	= 2,
 		.lower_margin	= 7,
+		.vsync_len	= 4,
 	},
 };
 
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2440/mach-rx3715.c linux-2.6.23/arch/arm/mach-s3c2440/mach-rx3715.c
--- linux-2.6.23.old/arch/arm/mach-s3c2440/mach-rx3715.c	2007-08-05 14:45:43.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2440/mach-rx3715.c	2007-08-05 14:37:03.000000000 +0200
@@ -136,8 +136,10 @@ static struct s3c2410fb_display rx3715_l
 	.bpp		= 16,
 	.left_margin	= 36,
 	.right_margin	= 36,
+	.hsync_len	= 8,
 	.upper_margin	= 6,
 	.lower_margin	= 7,
+	.vsync_len	= 3,
 };
 
 static struct s3c2410fb_mach_info rx3715_fb_info __initdata = {
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2440/mach-smdk2440.c linux-2.6.23/arch/arm/mach-s3c2440/mach-smdk2440.c
--- linux-2.6.23.old/arch/arm/mach-s3c2440/mach-smdk2440.c	2007-08-05 14:45:43.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2440/mach-smdk2440.c	2007-08-05 14:37:24.000000000 +0200
@@ -133,8 +133,10 @@ static struct s3c2410fb_display smdk2440
 	.bpp		= 16,
 	.left_margin	= 20,
 	.right_margin	= 8,
+	.hsync_len	= 4,
 	.upper_margin	= 8,
 	.lower_margin	= 7,
+	.vsync_len	= 4,
 };
 
 static struct s3c2410fb_mach_info smdk2440_fb_info __initdata = {
--- linux-2.6.23.old/drivers/video/s3c2410fb.c	2007-08-05 15:01:51.000000000 +0200
+++ linux-2.6.23/drivers/video/s3c2410fb.c	2007-08-05 15:01:09.000000000 +0200
@@ -290,6 +290,7 @@ static void s3c2410fb_calculate_stn_lcd_
 	int type = regs->lcdcon1 & ~S3C2410_LCDCON1_TFT;
 	int hs = var->xres >> 2;
 	unsigned wdly = (var->left_margin >> 4) - 1;
+	unsigned wlh = (var->hsync_len >> 4) - 1;
 
 	dprintk("%s: var->xres  = %d\n", __FUNCTION__, var->xres);
 	dprintk("%s: var->yres  = %d\n", __FUNCTION__, var->yres);
@@ -333,9 +334,15 @@ static void s3c2410fb_calculate_stn_lcd_
 	if (wdly > 3)
 		wdly = 3;
 
+	if (wlh > 3)
+		wlh = 3;
+
 	regs->lcdcon3 =	S3C2410_LCDCON3_WDLY(wdly) |
 			S3C2410_LCDCON3_LINEBLANK(var->right_margin / 8) |
 			S3C2410_LCDCON3_HOZVAL(hs - 1);
+
+	regs->lcdcon4 &= ~S3C2410_LCDCON4_HSPW(0xff);
+	regs->lcdcon4 |=  S3C2410_LCDCON4_HSPW(wlh);
 }
 
 /* s3c2410fb_calculate_tft_lcd_regs
@@ -383,14 +390,17 @@ static void s3c2410fb_calculate_tft_lcd_
 	dprintk("setting horz: lft=%d, rt=%d, sync=%d\n",
 		var->left_margin, var->right_margin, var->hsync_len);
 
-	regs->lcdcon2 &= S3C2410_LCDCON2_VSPW(0x3f);
-	regs->lcdcon2 |= S3C2410_LCDCON2_LINEVAL(var->yres - 1);
-	regs->lcdcon2 |= S3C2410_LCDCON2_VBPD(var->upper_margin - 1);
-	regs->lcdcon2 |= S3C2410_LCDCON2_VFPD(var->lower_margin - 1);
+	regs->lcdcon2 = S3C2410_LCDCON2_LINEVAL(var->yres - 1) |
+			S3C2410_LCDCON2_VBPD(var->upper_margin - 1) |
+			S3C2410_LCDCON2_VFPD(var->lower_margin - 1) |
+			S3C2410_LCDCON2_VSPW(var->vsync_len - 1);
 
 	regs->lcdcon3 = S3C2410_LCDCON3_HBPD(var->right_margin - 1) |
 			S3C2410_LCDCON3_HFPD(var->left_margin - 1) |
 			S3C2410_LCDCON3_HOZVAL(var->xres - 1);
+
+	regs->lcdcon4 &= ~S3C2410_LCDCON4_HSPW(0xff);
+	regs->lcdcon4 |=  S3C2410_LCDCON4_HSPW(var->hsync_len - 1);
 }
 
 /* s3c2410fb_activate_var
@@ -410,16 +420,6 @@ static void s3c2410fb_activate_var(struc
 	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_TFT;
 	fbi->regs.lcdcon1 |= display->type;
 
-	/* check to see if we need to update sync/borders */
-
-	if (!mach_info->fixed_syncs) {
-		fbi->regs.lcdcon2 =
-			S3C2410_LCDCON2_VSPW(var->vsync_len - 1);
-
-		fbi->regs.lcdcon4 &= ~S3C2410_LCDCON4_HSPW(0xff);
-		fbi->regs.lcdcon4 |=  S3C2410_LCDCON4_HSPW(var->hsync_len - 1);
-	}
-
 	if (var->pixclock > 0) {
 		int clkdiv = s3c2410fb_calc_pixclk(fbi, var->pixclock);
 
@@ -890,10 +890,8 @@ static int __init s3c2410fb_probe(struct
 
 	fbinfo->var.upper_margin    = display->upper_margin;
 	fbinfo->var.lower_margin    = display->lower_margin;
-	fbinfo->var.vsync_len	    =
-				S3C2410_LCDCON2_GET_VSPW(display->lcdcon2) + 1;
-	fbinfo->var.hsync_len	    =
-				S3C2410_LCDCON4_GET_HSPW(display->lcdcon4) + 1;
+	fbinfo->var.vsync_len	    = display->vsync_len;
+	fbinfo->var.hsync_len	    = display->hsync_len;
 
 	fbinfo->var.red.offset      = 11;
 	fbinfo->var.green.offset    = 5;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
