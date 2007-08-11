From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH 4/7] s3c2410fb: add vertical margins
 fields to s3c2410fb_display
Date: Sat, 11 Aug 2007 07:51:46 +0200
Message-ID: <20070811075146.6ba9fb0f.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJjoo-0001Dz-K8 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 22:47:22 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IJjon-0007cH-UA
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 22:47:22 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	11 Aug 2007 07:47:19 +0200
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

This patch adds vertical margins values to all 
s3c24xx platform.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

The values of the margins are not yet used by the framebuffer driver.

diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-amlm5900.c linux-2.6.23/arch/arm/mach-s3c2410/mach-amlm5900.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-amlm5900.c	2007-08-05 12:08:25.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-amlm5900.c	2007-08-05 12:05:05.000000000 +0200
@@ -179,6 +179,8 @@ static struct s3c2410fb_display __initda
 	.bpp		= 4,
 	.left_margin	= 1 << (4 + 3),
 	.right_margin	= 8 << 3,
+	.upper_margin	= 0,
+	.lower_margin	= 0,
 
 	.lcdcon1	= 0x00008225,
 	.lcdcon2	= 0x0027c000,
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-bast.c linux-2.6.23/arch/arm/mach-s3c2410/mach-bast.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-bast.c	2007-08-05 12:08:25.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-bast.c	2007-08-05 12:03:10.000000000 +0200
@@ -472,10 +472,13 @@ static struct s3c2410fb_display __initda
 		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
 		.height		= 480,
+
 		.xres		= 320,
 		.yres		= 240,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.upper_margin	= 30,
+		.lower_margin	= 32,
 
 		.bpp		= 4,
 
@@ -494,6 +497,8 @@ static struct s3c2410fb_display __initda
 		.bpp		= 4,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.upper_margin	= 30,
+		.lower_margin	= 32,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -510,6 +515,8 @@ static struct s3c2410fb_display __initda
 		.bpp		= 4,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.upper_margin	= 30,
+		.lower_margin	= 32,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -526,6 +533,8 @@ static struct s3c2410fb_display __initda
 		.bpp		= 8,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.upper_margin	= 30,
+		.lower_margin	= 32,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -542,6 +551,8 @@ static struct s3c2410fb_display __initda
 		.bpp		= 8,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.upper_margin	= 30,
+		.lower_margin	= 32,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -558,6 +569,8 @@ static struct s3c2410fb_display __initda
 		.bpp		= 8,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.upper_margin	= 30,
+		.lower_margin	= 32,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -574,6 +587,8 @@ static struct s3c2410fb_display __initda
 		.bpp		= 16,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.upper_margin	= 30,
+		.lower_margin	= 32,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -590,6 +605,8 @@ static struct s3c2410fb_display __initda
 		.bpp		= 16,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.upper_margin	= 30,
+		.lower_margin	= 32,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
@@ -606,6 +623,8 @@ static struct s3c2410fb_display __initda
 		.bpp		= 16,
 		.left_margin	= 40,
 		.right_margin	= 20,
+		.upper_margin	= 30,
+		.lower_margin	= 32,
 
 		.lcdcon1	= 0x00000176,
 		.lcdcon2	= 0x1d77c7c2,
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-h1940.c linux-2.6.23/arch/arm/mach-s3c2410/mach-h1940.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-05 12:08:25.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-h1940.c	2007-08-05 12:01:15.000000000 +0200
@@ -158,6 +158,8 @@ static struct s3c2410fb_display h1940_lc
 	.bpp =		16,
 	.left_margin =	20,
 	.right_margin =	8,
+	.upper_margin =	8,
+	.lower_margin = 7,
 };
 
 static struct s3c2410fb_mach_info h1940_fb_info __initdata = {
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2410/mach-qt2410.c linux-2.6.23/arch/arm/mach-s3c2410/mach-qt2410.c
--- linux-2.6.23.old/arch/arm/mach-s3c2410/mach-qt2410.c	2007-08-05 12:08:25.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2410/mach-qt2410.c	2007-08-05 12:04:18.000000000 +0200
@@ -125,6 +125,8 @@ static struct s3c2410fb_display qt2410_l
 		.bpp		= 16,
 		.left_margin	= 44,
 		.right_margin	= 116,
+		.upper_margin	= 19,
+		.lower_margin	= 11,
 	},
 	{
 		/* Configuration for 480x640 toppoly TD028TTEC1 */
@@ -154,6 +156,8 @@ static struct s3c2410fb_display qt2410_l
 		.bpp		= 16,
 		.left_margin	= 8,
 		.right_margin	= 24,
+		.upper_margin	= 2,
+		.lower_margin	= 4,
 	},
 	{
 		/* Config for 240x320 LCD */
@@ -183,6 +187,8 @@ static struct s3c2410fb_display qt2410_l
 		.bpp		= 16,
 		.left_margin	= 13,
 		.right_margin	= 8,
+		.upper_margin	= 2,
+		.lower_margin	= 7,
 	},
 };
 
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2440/mach-rx3715.c linux-2.6.23/arch/arm/mach-s3c2440/mach-rx3715.c
--- linux-2.6.23.old/arch/arm/mach-s3c2440/mach-rx3715.c	2007-08-05 12:08:25.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2440/mach-rx3715.c	2007-08-05 12:05:54.000000000 +0200
@@ -136,6 +136,8 @@ static struct s3c2410fb_display rx3715_l
 	.bpp		= 16,
 	.left_margin	= 36,
 	.right_margin	= 36,
+	.upper_margin	= 6,
+	.lower_margin	= 7,
 };
 
 static struct s3c2410fb_mach_info rx3715_fb_info __initdata = {
diff -urp linux-2.6.23.old/arch/arm/mach-s3c2440/mach-smdk2440.c linux-2.6.23/arch/arm/mach-s3c2440/mach-smdk2440.c
--- linux-2.6.23.old/arch/arm/mach-s3c2440/mach-smdk2440.c	2007-08-05 12:08:25.000000000 +0200
+++ linux-2.6.23/arch/arm/mach-s3c2440/mach-smdk2440.c	2007-08-05 12:06:30.000000000 +0200
@@ -133,6 +133,8 @@ static struct s3c2410fb_display smdk2440
 	.bpp		= 16,
 	.left_margin	= 20,
 	.right_margin	= 8,
+	.upper_margin	= 8,
+	.lower_margin	= 7,
 };
 
 static struct s3c2410fb_mach_info smdk2440_fb_info __initdata = {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
