From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 08/22] s3c2410fb: add margin fields to
	s3c2410fb_display
Date: Mon, 13 Aug 2007 20:32:26 +0800
Message-ID: <46C04F5A.3090005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKZJs-0004Q7-2T for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:46:52 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZJr-0005O6-Lv
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:46:52 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:46:51 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ben Dooks <ben-linux@fluff.org>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds margins fields to the s3c2410fb_display
structure. It also sets display type and horizontal
margins in all platform files that use the s3c2410fb
driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 arch/arm/mach-s3c2410/mach-amlm5900.c |    7 ++++---
 arch/arm/mach-s3c2410/mach-bast.c     |   27 +++++++++++++++++++++++++++
 arch/arm/mach-s3c2410/mach-h1940.c    |    3 +++
 arch/arm/mach-s3c2410/mach-qt2410.c   |    9 +++++++++
 arch/arm/mach-s3c2440/mach-rx3715.c   |   15 +++++++++------
 arch/arm/mach-s3c2440/mach-smdk2440.c |    2 ++
 include/asm-arm/arch-s3c2410/fb.h     |    7 +++++++
 7 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
index 1946934..e96b413 100644
--- a/arch/arm/mach-s3c2410/mach-amlm5900.c
+++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
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
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index be50201..1b4f9f9 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
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
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index ab04b29..372caa2 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
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
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index 03ea5d7..0c1ff0a 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
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
 
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index c830788..dab8e7b 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
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
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index f7dac7d..5930f17 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -137,6 +137,8 @@ static struct s3c2410fb_display smdk2440
 	.xres		= 240,
 	.yres		= 320,
 	.bpp		= 16,
+	.left_margin	= 20,
+	.right_margin	= 8,
 };
 
 static struct s3c2410fb_mach_info smdk2440_fb_info __initdata = {
diff --git a/include/asm-arm/arch-s3c2410/fb.h b/include/asm-arm/arch-s3c2410/fb.h
index c0e18b2..a76585a 100644
--- a/include/asm-arm/arch-s3c2410/fb.h
+++ b/include/asm-arm/arch-s3c2410/fb.h
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


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
