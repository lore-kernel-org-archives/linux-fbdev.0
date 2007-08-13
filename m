From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 11/22] s3c2410fb: add vertical margins
	fields to s3c2410fb_display
Date: Mon, 13 Aug 2007 20:35:49 +0800
Message-ID: <46C05025.9020107@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKbbO-00046D-6S for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 08:13:08 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZKL-0005O6-GO
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:47:24 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:47:21 -0700 (PDT)
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

This patch adds vertical margins values to all
s3c24xx platform.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 arch/arm/mach-s3c2410/mach-amlm5900.c |    2 ++
 arch/arm/mach-s3c2410/mach-bast.c     |   19 +++++++++++++++++++
 arch/arm/mach-s3c2410/mach-h1940.c    |    2 ++
 arch/arm/mach-s3c2410/mach-qt2410.c   |    6 ++++++
 arch/arm/mach-s3c2440/mach-rx3715.c   |    2 ++
 arch/arm/mach-s3c2440/mach-smdk2440.c |    2 ++
 6 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
index 74801ce..5f51a80 100644
--- a/arch/arm/mach-s3c2410/mach-amlm5900.c
+++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
@@ -179,6 +179,8 @@ static struct s3c2410fb_display __initda
 	.bpp		= 4,
 	.left_margin	= 1 << (4 + 3),
 	.right_margin	= 8 << 3,
+	.upper_margin	= 0,
+	.lower_margin	= 0,
 
 	.lcdcon1	= 0x00008225,
 	.lcdcon2	= 0x0027c000,
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index 6e46c20..7b54f3c 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
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
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 52d7685..1c9d6c6 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -158,6 +158,8 @@ static struct s3c2410fb_display h1940_lc
 	.bpp =		16,
 	.left_margin =	20,
 	.right_margin =	8,
+	.upper_margin =	8,
+	.lower_margin = 7,
 };
 
 static struct s3c2410fb_mach_info h1940_fb_info __initdata = {
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index 0a746f7..98fbca2 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
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
 
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index 3058272..9f87465 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -136,6 +136,8 @@ static struct s3c2410fb_display rx3715_l
 	.bpp		= 16,
 	.left_margin	= 36,
 	.right_margin	= 36,
+	.upper_margin	= 6,
+	.lower_margin	= 7,
 };
 
 static struct s3c2410fb_mach_info rx3715_fb_info __initdata = {
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index 33b3644..f400eb7 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
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
