From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH 1/7] s3c2410fb: add margin fields to
	s3c2410fb_display
Date: Sat, 11 Aug 2007 07:51:26 +0200
Message-ID: <20070811075126.e05d60b8.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJjoW-0001Al-2C for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 22:47:04 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IJjoV-0008Ls-8H
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 22:47:04 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	11 Aug 2007 07:46:59 +0200
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

This patch adds margins fields to the s3c2410fb_display
structure. It also sets display type and horizontal
margins in all platform files that use the s3c2410fb
driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

The values of the margins are not yet used by the framebuffer driver.

diff -urp linux-2.6.23.old/include/asm-arm/arch-s3c2410/fb.h linux-2.6.23/include/asm-arm/arch-s3c2410/fb.h
--- linux-2.6.23.old/include/asm-arm/arch-s3c2410/fb.h	2007-08-03 18:40:33.000000000 +0200
+++ linux-2.6.23/include/asm-arm/arch-s3c2410/fb.h	2007-08-03 17:47:26.000000000 +0200
@@ -36,6 +36,13 @@ struct s3c2410fb_display {
 	unsigned short yres;
 	unsigned short bpp;
 
+	unsigned short left_margin;  /* value in pixels (TFT) or HCLKs (STN) */
+	unsigned short right_margin; /* value in pixels (TFT) or HCLKs (STN) */
+	unsigned short hsync_len;    /* value in pixels (TFT) or HCLKs (STN) */
+	unsigned short upper_margin;	/* value in lines (TFT) or 0 (STN) */
+	unsigned short lower_margin;	/* value in lines (TFT) or 0 (STN) */
+	unsigned short vsync_len;	/* value in lines (TFT) or 0 (STN) */
+
 	/* lcd configuration registers */
 	struct s3c2410fb_hw  regs;
 };
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-amlm5900.c linux-2.6.23/arch/arm/mach-s3c2410/mach-amlm5900.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-amlm5900.c	2007-08-03 18:40:33.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-amlm5900.c	2007-08-03 18:16:03.000000000 +0200
@@ -172,12 +172,13 @@ static struct s3c2410fb_display __initda
 	.width		= 160,
 	.height		= 160,
 
-/* commented out until stn patch is submitted
-*	.type		= S3C2410_LCDCON1_STN4,
-*/
+	.type		= S3C2410_LCDCON1_STN4,
+
 	.xres		= 160,
 	.yres		= 160,
 	.bpp		= 4,
+	.left_margin	= 1 << (4 + 3),
+	.right_margin	= 8 << 3,
 
 	.regs		= {
 		.lcdcon1	= 0x00008225,
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-bast.c linux-2.6.23/arch/arm/mach-s3c2410/mach-bast.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-bast.c	2007-08-03 18:40:33.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-bast.c	2007-08-03 18:22:24.000000000 +0200
@@ -469,10 +469,13 @@ static struct platform_device bast_devic
 
 static struct s3c2410fb_display __initdata bast_lcd_info[] = {
 	{
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
 		.height		= 480,
 		.xres		= 320,
 		.yres		= 240,
+		.left_margin	= 40,
+		.right_margin	= 20,
 
 		.bpp		= 4,
 
@@ -485,12 +488,15 @@ static struct s3c2410fb_display __initda
 		}
 	},
 	{
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
 		.height		= 480,
 
 		.xres		= 640,
 		.yres		= 480,
 		.bpp		= 4,
+		.left_margin	= 40,
+		.right_margin	= 20,
 
 		.regs		= {
 			.lcdcon1	= 0x00000176,
@@ -501,12 +507,15 @@ static struct s3c2410fb_display __initda
 		}
 	},
 	{
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
 		.height		= 480,
 
 		.xres		= 800,
 		.yres		= 600,
 		.bpp		= 4,
+		.left_margin	= 40,
+		.right_margin	= 20,
 
 		.regs		= {
 			.lcdcon1	= 0x00000176,
@@ -517,12 +526,15 @@ static struct s3c2410fb_display __initda
 		}
 	},
 	{
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
 		.height		= 480,
 
 		.xres		= 320,
 		.yres		= 240,
 		.bpp		= 8,
+		.left_margin	= 40,
+		.right_margin	= 20,
 
 		.regs		= {
 			.lcdcon1	= 0x00000176,
@@ -533,12 +545,15 @@ static struct s3c2410fb_display __initda
 		}
 	},
 	{
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
 		.height		= 480,
 
 		.xres		= 640,
 		.yres		= 480,
 		.bpp		= 8,
+		.left_margin	= 40,
+		.right_margin	= 20,
 
 		.regs		= {
 			.lcdcon1	= 0x00000176,
@@ -549,12 +564,15 @@ static struct s3c2410fb_display __initda
 		}
 	},
 	{
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
 		.height		= 480,
 
 		.xres		= 800,
 		.yres		= 600,
 		.bpp		= 8,
+		.left_margin	= 40,
+		.right_margin	= 20,
 
 		.regs		= {
 			.lcdcon1	= 0x00000176,
@@ -565,12 +583,15 @@ static struct s3c2410fb_display __initda
 		}
 	},
 	{
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
 		.height		= 480,
 
 		.xres		= 320,
 		.yres		= 240,
 		.bpp		= 16,
+		.left_margin	= 40,
+		.right_margin	= 20,
 
 		.regs		= {
 			.lcdcon1	= 0x00000176,
@@ -581,12 +602,15 @@ static struct s3c2410fb_display __initda
 		}
 	},
 	{
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
 		.height		= 480,
 
 		.xres		= 640,
 		.yres		= 480,
 		.bpp		= 16,
+		.left_margin	= 40,
+		.right_margin	= 20,
 
 		.regs		= {
 			.lcdcon1	= 0x00000176,
@@ -597,12 +621,15 @@ static struct s3c2410fb_display __initda
 		}
 	},
 	{
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
 		.height		= 480,
 
 		.xres		= 800,
 		.yres		= 600,
 		.bpp		= 16,
+		.left_margin	= 40,
+		.right_margin	= 20,
 
 		.regs		= {
 			.lcdcon1	= 0x00000176,
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-h1940.c linux-2.6.23/arch/arm/mach-s3c2410/mach-h1940.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-03 18:40:33.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-03 18:18:54.000000000 +0200
@@ -156,11 +156,14 @@ static struct s3c2410fb_display h1940_lc
 				S3C2410_LCDCON5_HWSWP,
 	},
 
+	.type =		S3C2410_LCDCON1_TFT,
 	.width =	240,
 	.height =	320,
 	.xres =		240,
 	.yres =		320,
 	.bpp =		16,
+	.left_margin =	20,
+	.right_margin =	8,
 };
 
 static struct s3c2410fb_mach_info h1940_fb_info __initdata = {
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-qt2410.c linux-2.6.23/arch/arm/mach-s3c2410/mach-qt2410.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-qt2410.c	2007-08-03 18:40:33.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-qt2410.c	2007-08-03 18:24:12.000000000 +0200
@@ -123,12 +123,15 @@ static struct s3c2410fb_display qt2410_l
 				   S3C2410_LCDCON5_HWSWP,
 		},
 
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
 		.height		= 480,
 
 		.xres		= 640,
 		.yres		= 480,
 		.bpp		= 16,
+		.left_margin	= 44,
+		.right_margin	= 116,
 	},
 	{
 		/* Configuration for 480x640 toppoly TD028TTEC1 */
@@ -157,11 +160,14 @@ static struct s3c2410fb_display qt2410_l
 				   S3C2410_LCDCON5_HWSWP,
 		},
 
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 480,
 		.height		= 640,
 		.xres		= 480,
 		.yres		= 640,
 		.bpp		= 16,
+		.left_margin	= 8,
+		.right_margin	= 24,
 	},
 	{
 		/* Config for 240x320 LCD */
@@ -190,11 +196,14 @@ static struct s3c2410fb_display qt2410_l
 				   S3C2410_LCDCON5_HWSWP,
 		},
 
+		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 240,
 		.height		= 320,
 		.xres		= 240,
 		.yres		= 320,
 		.bpp		= 16,
+		.left_margin	= 13,
+		.right_margin	= 8,
 	},
 };
 
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2440/mach-rx3715.c linux-2.6.23/arch/arm/mach-s3c2440/mach-rx3715.c
--- linux-2.6.23.old/arch/arm/mach-s3c2440/mach-rx3715.c	2007-08-03 18:40:33.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2440/mach-rx3715.c	2007-08-03 18:28:16.000000000 +0200
@@ -133,12 +133,15 @@ static struct s3c2410fb_display rx3715_l
 				S3C2410_LCDCON5_HWSWP,
 	},
 
-	.width  =	240,
-	.height =	320,
-
-	.xres	= 240,
-	.yres	= 320,
-	.bpp	= 16,
+	.type		= S3C2410_LCDCON1_TFT,
+	.width		= 240,
+	.height		= 320,
+
+	.xres		= 240,
+	.yres		= 320,
+	.bpp		= 16,
+	.left_margin	= 36,
+	.right_margin	= 36,
 };
 
 static struct s3c2410fb_mach_info rx3715_fb_info __initdata = {
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2440/mach-smdk2440.c linux-2.6.23/arch/arm/mach-s3c2440/mach-smdk2440.c
--- linux-2.6.23.old/arch/arm/mach-s3c2440/mach-smdk2440.c	2007-08-03 18:40:33.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2440/mach-smdk2440.c	2007-08-03 18:28:57.000000000 +0200
@@ -137,6 +137,8 @@ static struct s3c2410fb_display smdk2440
 	.xres		= 240,
 	.yres		= 320,
 	.bpp		= 16,
+	.left_margin	= 20,
+	.right_margin	= 8,
 };
 
 static struct s3c2410fb_mach_info smdk2440_fb_info __initdata = {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
