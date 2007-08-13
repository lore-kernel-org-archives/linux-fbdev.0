From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 10/22] s3c2410fb: remove lcdcon3
	register from s3c2410fb_display
Date: Mon, 13 Aug 2007 20:35:05 +0800
Message-ID: <46C04FF9.9080207@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKZKG-0004Vi-AL for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:47:16 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZKD-0005O6-0K
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:47:16 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:47:12 -0700 (PDT)
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

This patch removes unused lcdcon3 register from the
s3c2410fb_display structure.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 arch/arm/mach-s3c2410/mach-amlm5900.c |   11 +--
 arch/arm/mach-s3c2410/mach-bast.c     |   99 +++++++++++------------------
 arch/arm/mach-s3c2410/mach-h1940.c    |   36 ++++-------
 arch/arm/mach-s3c2410/mach-qt2410.c   |  111 +++++++++++++--------------------
 arch/arm/mach-s3c2440/mach-rx3715.c   |   36 ++++-------
 arch/arm/mach-s3c2440/mach-smdk2440.c |   34 ++++------
 drivers/video/s3c2410fb.c             |   17 +++--
 include/asm-arm/arch-s3c2410/fb.h     |    5 +
 8 files changed, 142 insertions(+), 207 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
index e96b413..74801ce 100644
--- a/arch/arm/mach-s3c2410/mach-amlm5900.c
+++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
@@ -180,13 +180,10 @@ static struct s3c2410fb_display __initda
 	.left_margin	= 1 << (4 + 3),
 	.right_margin	= 8 << 3,
 
-	.regs		= {
-		.lcdcon1	= 0x00008225,
-		.lcdcon2	= 0x0027c000,
-		.lcdcon3	= 0x00182708,
-		.lcdcon4	= 0x00000002,
-		.lcdcon5	= 0x00000001,
-	}
+	.lcdcon1	= 0x00008225,
+	.lcdcon2	= 0x0027c000,
+	.lcdcon4	= 0x00000002,
+	.lcdcon5	= 0x00000001,
 };
 
 static struct s3c2410fb_mach_info __initdata amlm5900_fb_info = {
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index 1b4f9f9..6e46c20 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -479,13 +479,10 @@ static struct s3c2410fb_display __initda
 
 		.bpp		= 4,
 
-		.regs		= {
-			.lcdcon1	= 0x00000176,
-			.lcdcon2	= 0x1d77c7c2,
-			.lcdcon3	= 0x013a7f13,
-			.lcdcon4	= 0x00000057,
-			.lcdcon5	= 0x00014b02,
-		}
+		.lcdcon1	= 0x00000176,
+		.lcdcon2	= 0x1d77c7c2,
+		.lcdcon4	= 0x00000057,
+		.lcdcon5	= 0x00014b02,
 	},
 	{
 		.type		= S3C2410_LCDCON1_TFT,
@@ -498,13 +495,10 @@ static struct s3c2410fb_display __initda
 		.left_margin	= 40,
 		.right_margin	= 20,
 
-		.regs		= {
-			.lcdcon1	= 0x00000176,
-			.lcdcon2	= 0x1d77c7c2,
-			.lcdcon3	= 0x013a7f13,
-			.lcdcon4	= 0x00000057,
-			.lcdcon5	= 0x00014b02,
-		}
+		.lcdcon1	= 0x00000176,
+		.lcdcon2	= 0x1d77c7c2,
+		.lcdcon4	= 0x00000057,
+		.lcdcon5	= 0x00014b02,
 	},
 	{
 		.type		= S3C2410_LCDCON1_TFT,
@@ -517,13 +511,10 @@ static struct s3c2410fb_display __initda
 		.left_margin	= 40,
 		.right_margin	= 20,
 
-		.regs		= {
-			.lcdcon1	= 0x00000176,
-			.lcdcon2	= 0x1d77c7c2,
-			.lcdcon3	= 0x013a7f13,
-			.lcdcon4	= 0x00000057,
-			.lcdcon5	= 0x00014b02,
-		}
+		.lcdcon1	= 0x00000176,
+		.lcdcon2	= 0x1d77c7c2,
+		.lcdcon4	= 0x00000057,
+		.lcdcon5	= 0x00014b02,
 	},
 	{
 		.type		= S3C2410_LCDCON1_TFT,
@@ -536,13 +527,10 @@ static struct s3c2410fb_display __initda
 		.left_margin	= 40,
 		.right_margin	= 20,
 
-		.regs		= {
-			.lcdcon1	= 0x00000176,
-			.lcdcon2	= 0x1d77c7c2,
-			.lcdcon3	= 0x013a7f13,
-			.lcdcon4	= 0x00000057,
-			.lcdcon5	= 0x00014b02,
-		}
+		.lcdcon1	= 0x00000176,
+		.lcdcon2	= 0x1d77c7c2,
+		.lcdcon4	= 0x00000057,
+		.lcdcon5	= 0x00014b02,
 	},
 	{
 		.type		= S3C2410_LCDCON1_TFT,
@@ -555,13 +543,10 @@ static struct s3c2410fb_display __initda
 		.left_margin	= 40,
 		.right_margin	= 20,
 
-		.regs		= {
-			.lcdcon1	= 0x00000176,
-			.lcdcon2	= 0x1d77c7c2,
-			.lcdcon3	= 0x013a7f13,
-			.lcdcon4	= 0x00000057,
-			.lcdcon5	= 0x00014b02,
-		}
+		.lcdcon1	= 0x00000176,
+		.lcdcon2	= 0x1d77c7c2,
+		.lcdcon4	= 0x00000057,
+		.lcdcon5	= 0x00014b02,
 	},
 	{
 		.type		= S3C2410_LCDCON1_TFT,
@@ -574,13 +559,10 @@ static struct s3c2410fb_display __initda
 		.left_margin	= 40,
 		.right_margin	= 20,
 
-		.regs		= {
-			.lcdcon1	= 0x00000176,
-			.lcdcon2	= 0x1d77c7c2,
-			.lcdcon3	= 0x013a7f13,
-			.lcdcon4	= 0x00000057,
-			.lcdcon5	= 0x00014b02,
-		}
+		.lcdcon1	= 0x00000176,
+		.lcdcon2	= 0x1d77c7c2,
+		.lcdcon4	= 0x00000057,
+		.lcdcon5	= 0x00014b02,
 	},
 	{
 		.type		= S3C2410_LCDCON1_TFT,
@@ -593,13 +575,10 @@ static struct s3c2410fb_display __initda
 		.left_margin	= 40,
 		.right_margin	= 20,
 
-		.regs		= {
-			.lcdcon1	= 0x00000176,
-			.lcdcon2	= 0x1d77c7c2,
-			.lcdcon3	= 0x013a7f13,
-			.lcdcon4	= 0x00000057,
-			.lcdcon5	= 0x00014b02,
-		}
+		.lcdcon1	= 0x00000176,
+		.lcdcon2	= 0x1d77c7c2,
+		.lcdcon4	= 0x00000057,
+		.lcdcon5	= 0x00014b02,
 	},
 	{
 		.type		= S3C2410_LCDCON1_TFT,
@@ -612,13 +591,10 @@ static struct s3c2410fb_display __initda
 		.left_margin	= 40,
 		.right_margin	= 20,
 
-		.regs		= {
-			.lcdcon1	= 0x00000176,
-			.lcdcon2	= 0x1d77c7c2,
-			.lcdcon3	= 0x013a7f13,
-			.lcdcon4	= 0x00000057,
-			.lcdcon5	= 0x00014b02,
-		}
+		.lcdcon1	= 0x00000176,
+		.lcdcon2	= 0x1d77c7c2,
+		.lcdcon4	= 0x00000057,
+		.lcdcon5	= 0x00014b02,
 	},
 	{
 		.type		= S3C2410_LCDCON1_TFT,
@@ -631,13 +607,10 @@ static struct s3c2410fb_display __initda
 		.left_margin	= 40,
 		.right_margin	= 20,
 
-		.regs		= {
-			.lcdcon1	= 0x00000176,
-			.lcdcon2	= 0x1d77c7c2,
-			.lcdcon3	= 0x013a7f13,
-			.lcdcon4	= 0x00000057,
-			.lcdcon5	= 0x00014b02,
-		}
+		.lcdcon1	= 0x00000176,
+		.lcdcon2	= 0x1d77c7c2,
+		.lcdcon4	= 0x00000057,
+		.lcdcon5	= 0x00014b02,
 	},
 };
 
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 372caa2..52d7685 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -134,27 +134,21 @@ static struct s3c2410_udc_mach_info h194
  * Set lcd on or off
  **/
 static struct s3c2410fb_display h1940_lcd __initdata = {
-	.regs={
-		.lcdcon1=	S3C2410_LCDCON1_TFT16BPP | \
-				S3C2410_LCDCON1_TFT | \
-				S3C2410_LCDCON1_CLKVAL(0x0C),
-
-		.lcdcon2=	S3C2410_LCDCON2_VBPD(7) | \
-				S3C2410_LCDCON2_LINEVAL(319) | \
-				S3C2410_LCDCON2_VFPD(6) | \
-				S3C2410_LCDCON2_VSPW(0),
-
-		.lcdcon3=	S3C2410_LCDCON3_HBPD(19) | \
-				S3C2410_LCDCON3_HOZVAL(239) | \
-				S3C2410_LCDCON3_HFPD(7),
-
-		.lcdcon4=	S3C2410_LCDCON4_MVAL(0) | \
-				S3C2410_LCDCON4_HSPW(3),
-
-		.lcdcon5=	S3C2410_LCDCON5_FRM565 | \
-				S3C2410_LCDCON5_INVVLINE | \
-				S3C2410_LCDCON5_HWSWP,
-	},
+	.lcdcon1=	S3C2410_LCDCON1_TFT16BPP | \
+			S3C2410_LCDCON1_TFT | \
+			S3C2410_LCDCON1_CLKVAL(0x0C),
+
+	.lcdcon2=	S3C2410_LCDCON2_VBPD(7) | \
+			S3C2410_LCDCON2_LINEVAL(319) | \
+			S3C2410_LCDCON2_VFPD(6) | \
+			S3C2410_LCDCON2_VSPW(0),
+
+	.lcdcon4=	S3C2410_LCDCON4_MVAL(0) | \
+			S3C2410_LCDCON4_HSPW(3),
+
+	.lcdcon5=	S3C2410_LCDCON5_FRM565 | \
+			S3C2410_LCDCON5_INVVLINE | \
+			S3C2410_LCDCON5_HWSWP,
 
 	.type =		S3C2410_LCDCON1_TFT,
 	.width =	240,
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index 0c1ff0a..0a746f7 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -98,30 +98,23 @@ static struct s3c2410_uartcfg smdk2410_u
 static struct s3c2410fb_display qt2410_lcd_cfg[] __initdata = {
 	{
 		/* Configuration for 640x480 SHARP LQ080V3DG01 */
-		.regs	= {
+		.lcdcon1 = S3C2410_LCDCON1_TFT16BPP |
+			   S3C2410_LCDCON1_TFT |
+			   S3C2410_LCDCON1_CLKVAL(0x01), /* HCLK/4 */
 
-			.lcdcon1 = S3C2410_LCDCON1_TFT16BPP |
-				   S3C2410_LCDCON1_TFT |
-				   S3C2410_LCDCON1_CLKVAL(0x01), /* HCLK/4 */
+		.lcdcon2 = S3C2410_LCDCON2_VBPD(18) |	/* 19 */
+			   S3C2410_LCDCON2_LINEVAL(479) |
+			   S3C2410_LCDCON2_VFPD(10) |	/* 11 */
+			   S3C2410_LCDCON2_VSPW(14),	/* 15 */
 
-			.lcdcon2 = S3C2410_LCDCON2_VBPD(18) |	/* 19 */
-				   S3C2410_LCDCON2_LINEVAL(479) |
-				   S3C2410_LCDCON2_VFPD(10) |	/* 11 */
-				   S3C2410_LCDCON2_VSPW(14),	/* 15 */
+		.lcdcon4 = S3C2410_LCDCON4_MVAL(0) |
+			   S3C2410_LCDCON4_HSPW(95),	/* 96 */
 
-			.lcdcon3 = S3C2410_LCDCON3_HBPD(43) |	/* 44 */
-				   S3C2410_LCDCON3_HOZVAL(639) | /* 640 */
-				   S3C2410_LCDCON3_HFPD(115),	/* 116 */
-
-			.lcdcon4 = S3C2410_LCDCON4_MVAL(0) |
-				   S3C2410_LCDCON4_HSPW(95),	/* 96 */
-
-			.lcdcon5 = S3C2410_LCDCON5_FRM565 |
-				   S3C2410_LCDCON5_INVVLINE |
-				   S3C2410_LCDCON5_INVVFRAME |
-				   S3C2410_LCDCON5_PWREN |
-				   S3C2410_LCDCON5_HWSWP,
-		},
+		.lcdcon5 = S3C2410_LCDCON5_FRM565 |
+			   S3C2410_LCDCON5_INVVLINE |
+			   S3C2410_LCDCON5_INVVFRAME |
+			   S3C2410_LCDCON5_PWREN |
+			   S3C2410_LCDCON5_HWSWP,
 
 		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 640,
@@ -135,30 +128,23 @@ static struct s3c2410fb_display qt2410_l
 	},
 	{
 		/* Configuration for 480x640 toppoly TD028TTEC1 */
-		.regs	= {
-
-			.lcdcon1 = S3C2410_LCDCON1_TFT16BPP |
-				   S3C2410_LCDCON1_TFT |
-				   S3C2410_LCDCON1_CLKVAL(0x01), /* HCLK/4 */
-
-			.lcdcon2 = S3C2410_LCDCON2_VBPD(1) |	/* 2 */
-				   S3C2410_LCDCON2_LINEVAL(639) |/* 640 */
-				   S3C2410_LCDCON2_VFPD(3) |	/* 4 */
-				   S3C2410_LCDCON2_VSPW(1),	/* 2 */
+		.lcdcon1 = S3C2410_LCDCON1_TFT16BPP |
+			   S3C2410_LCDCON1_TFT |
+			   S3C2410_LCDCON1_CLKVAL(0x01), /* HCLK/4 */
 
-			.lcdcon3 = S3C2410_LCDCON3_HBPD(7) |	/* 8 */
-				   S3C2410_LCDCON3_HOZVAL(479) | /* 479 */
-				   S3C2410_LCDCON3_HFPD(23),	/* 24 */
+		.lcdcon2 = S3C2410_LCDCON2_VBPD(1) |	/* 2 */
+			   S3C2410_LCDCON2_LINEVAL(639) |/* 640 */
+			   S3C2410_LCDCON2_VFPD(3) |	/* 4 */
+			   S3C2410_LCDCON2_VSPW(1),	/* 2 */
 
-			.lcdcon4 = S3C2410_LCDCON4_MVAL(0) |
-				   S3C2410_LCDCON4_HSPW(7),	/* 8 */
+		.lcdcon4 = S3C2410_LCDCON4_MVAL(0) |
+			   S3C2410_LCDCON4_HSPW(7),	/* 8 */
 
-			.lcdcon5 = S3C2410_LCDCON5_FRM565 |
-				   S3C2410_LCDCON5_INVVLINE |
-				   S3C2410_LCDCON5_INVVFRAME |
-				   S3C2410_LCDCON5_PWREN |
-				   S3C2410_LCDCON5_HWSWP,
-		},
+		.lcdcon5 = S3C2410_LCDCON5_FRM565 |
+			   S3C2410_LCDCON5_INVVLINE |
+			   S3C2410_LCDCON5_INVVFRAME |
+			   S3C2410_LCDCON5_PWREN |
+			   S3C2410_LCDCON5_HWSWP,
 
 		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 480,
@@ -171,30 +157,23 @@ static struct s3c2410fb_display qt2410_l
 	},
 	{
 		/* Config for 240x320 LCD */
-		.regs	= {
-
-			.lcdcon1 = S3C2410_LCDCON1_TFT16BPP |
-				   S3C2410_LCDCON1_TFT |
-				   S3C2410_LCDCON1_CLKVAL(0x04),
-
-			.lcdcon2 = S3C2410_LCDCON2_VBPD(1) |
-				   S3C2410_LCDCON2_LINEVAL(319) |
-				   S3C2410_LCDCON2_VFPD(6) |
-				   S3C2410_LCDCON2_VSPW(3),
-
-			.lcdcon3 = S3C2410_LCDCON3_HBPD(12) |
-				   S3C2410_LCDCON3_HOZVAL(239) |
-				   S3C2410_LCDCON3_HFPD(7),
-
-			.lcdcon4 = S3C2410_LCDCON4_MVAL(0) |
-				   S3C2410_LCDCON4_HSPW(3),
-
-			.lcdcon5 = S3C2410_LCDCON5_FRM565 |
-				   S3C2410_LCDCON5_INVVLINE |
-				   S3C2410_LCDCON5_INVVFRAME |
-				   S3C2410_LCDCON5_PWREN |
-				   S3C2410_LCDCON5_HWSWP,
-		},
+		.lcdcon1 = S3C2410_LCDCON1_TFT16BPP |
+			   S3C2410_LCDCON1_TFT |
+			   S3C2410_LCDCON1_CLKVAL(0x04),
+
+		.lcdcon2 = S3C2410_LCDCON2_VBPD(1) |
+			   S3C2410_LCDCON2_LINEVAL(319) |
+			   S3C2410_LCDCON2_VFPD(6) |
+			   S3C2410_LCDCON2_VSPW(3),
+
+		.lcdcon4 = S3C2410_LCDCON4_MVAL(0) |
+			   S3C2410_LCDCON4_HSPW(3),
+
+		.lcdcon5 = S3C2410_LCDCON5_FRM565 |
+			   S3C2410_LCDCON5_INVVLINE |
+			   S3C2410_LCDCON5_INVVFRAME |
+			   S3C2410_LCDCON5_PWREN |
+			   S3C2410_LCDCON5_HWSWP,
 
 		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 240,
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index dab8e7b..3058272 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -111,27 +111,21 @@ static struct s3c2410_uartcfg rx3715_uar
 /* framebuffer lcd controller information */
 
 static struct s3c2410fb_display rx3715_lcdcfg __initdata = {
-	.regs	= {
-		.lcdcon1 =	S3C2410_LCDCON1_TFT16BPP | \
-				S3C2410_LCDCON1_TFT | \
-				S3C2410_LCDCON1_CLKVAL(0x0C),
-
-		.lcdcon2 =	S3C2410_LCDCON2_VBPD(5) | \
-				S3C2410_LCDCON2_LINEVAL(319) | \
-				S3C2410_LCDCON2_VFPD(6) | \
-				S3C2410_LCDCON2_VSPW(2),
-
-		.lcdcon3 =	S3C2410_LCDCON3_HBPD(35) | \
-				S3C2410_LCDCON3_HOZVAL(239) | \
-				S3C2410_LCDCON3_HFPD(35),
-
-		.lcdcon4 =	S3C2410_LCDCON4_MVAL(0) | \
-				S3C2410_LCDCON4_HSPW(7),
-
-		.lcdcon5 =	S3C2410_LCDCON5_INVVLINE |
-				S3C2410_LCDCON5_FRM565 |
-				S3C2410_LCDCON5_HWSWP,
-	},
+	.lcdcon1 =	S3C2410_LCDCON1_TFT16BPP | \
+			S3C2410_LCDCON1_TFT | \
+			S3C2410_LCDCON1_CLKVAL(0x0C),
+
+	.lcdcon2 =	S3C2410_LCDCON2_VBPD(5) | \
+			S3C2410_LCDCON2_LINEVAL(319) | \
+			S3C2410_LCDCON2_VFPD(6) | \
+			S3C2410_LCDCON2_VSPW(2),
+
+	.lcdcon4 =	S3C2410_LCDCON4_MVAL(0) | \
+			S3C2410_LCDCON4_HSPW(7),
+
+	.lcdcon5 =	S3C2410_LCDCON5_INVVLINE |
+			S3C2410_LCDCON5_FRM565 |
+			S3C2410_LCDCON5_HWSWP,
 
 	.type		= S3C2410_LCDCON1_TFT,
 	.width		= 240,
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index 5930f17..33b3644 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -104,30 +104,24 @@ static struct s3c2410_uartcfg smdk2440_u
 /* LCD driver info */
 
 static struct s3c2410fb_display smdk2440_lcd_cfg __initdata = {
-	.regs	= {
 
-		.lcdcon1	= S3C2410_LCDCON1_TFT16BPP |
-				  S3C2410_LCDCON1_TFT |
-				  S3C2410_LCDCON1_CLKVAL(0x04),
+	.lcdcon1	= S3C2410_LCDCON1_TFT16BPP |
+			  S3C2410_LCDCON1_TFT |
+			  S3C2410_LCDCON1_CLKVAL(0x04),
 
-		.lcdcon2	= S3C2410_LCDCON2_VBPD(7) |
-				  S3C2410_LCDCON2_LINEVAL(319) |
-				  S3C2410_LCDCON2_VFPD(6) |
-				  S3C2410_LCDCON2_VSPW(3),
+	.lcdcon2	= S3C2410_LCDCON2_VBPD(7) |
+			  S3C2410_LCDCON2_LINEVAL(319) |
+			  S3C2410_LCDCON2_VFPD(6) |
+			  S3C2410_LCDCON2_VSPW(3),
 
-		.lcdcon3	= S3C2410_LCDCON3_HBPD(19) |
-				  S3C2410_LCDCON3_HOZVAL(239) |
-				  S3C2410_LCDCON3_HFPD(7),
+	.lcdcon4	= S3C2410_LCDCON4_MVAL(0) |
+			  S3C2410_LCDCON4_HSPW(3),
 
-		.lcdcon4	= S3C2410_LCDCON4_MVAL(0) |
-				  S3C2410_LCDCON4_HSPW(3),
-
-		.lcdcon5	= S3C2410_LCDCON5_FRM565 |
-				  S3C2410_LCDCON5_INVVLINE |
-				  S3C2410_LCDCON5_INVVFRAME |
-				  S3C2410_LCDCON5_PWREN |
-				  S3C2410_LCDCON5_HWSWP,
-	},
+	.lcdcon5	= S3C2410_LCDCON5_FRM565 |
+			  S3C2410_LCDCON5_INVVLINE |
+			  S3C2410_LCDCON5_INVVFRAME |
+			  S3C2410_LCDCON5_PWREN |
+			  S3C2410_LCDCON5_HWSWP,
 
 	.type		= S3C2410_LCDCON1_TFT16BPP,
 
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 04e9d7a..27528ca 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -245,7 +245,7 @@ static int s3c2410fb_check_var(struct fb
 
 	default:
 	case 16:
-		if (display->regs.lcdcon5 & S3C2410_LCDCON5_FRM565) {
+		if (display->lcdcon5 & S3C2410_LCDCON5_FRM565) {
 			/* 16 bpp, 565 format */
 			var->red.offset		= 11;
 			var->green.offset	= 5;
@@ -796,7 +796,6 @@ static int __init s3c2410fb_probe(struct
 	struct s3c2410fb_info *info;
 	struct s3c2410fb_display *display;
 	struct fb_info *fbinfo;
-	struct s3c2410fb_hw *mregs;
 	struct resource *res;
 	int ret;
 	int irq;
@@ -812,7 +811,6 @@ static int __init s3c2410fb_probe(struct
 	}
 
 	display = mach_info->displays + mach_info->default_display;
-	mregs = &display->regs;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -855,7 +853,10 @@ static int __init s3c2410fb_probe(struct
 
 	strcpy(fbinfo->fix.id, driver_name);
 
-	memcpy(&info->regs, &display->regs, sizeof(info->regs));
+	info->regs.lcdcon1 = display->lcdcon1;
+	info->regs.lcdcon2 = display->lcdcon2;
+	info->regs.lcdcon4 = display->lcdcon4;
+	info->regs.lcdcon5 = display->lcdcon5;
 
 	/* Stop the video and unset ENVID if set */
 	info->regs.lcdcon1 &= ~S3C2410_LCDCON1_ENVID;
@@ -892,14 +893,14 @@ static int __init s3c2410fb_probe(struct
 	fbinfo->var.right_margin    = display->right_margin;
 
 	fbinfo->var.upper_margin    =
-				S3C2410_LCDCON2_GET_VBPD(mregs->lcdcon2) + 1;
+				S3C2410_LCDCON2_GET_VBPD(display->lcdcon2) + 1;
 	fbinfo->var.lower_margin    =
-				S3C2410_LCDCON2_GET_VFPD(mregs->lcdcon2) + 1;
+				S3C2410_LCDCON2_GET_VFPD(display->lcdcon2) + 1;
 	fbinfo->var.vsync_len	    =
-				S3C2410_LCDCON2_GET_VSPW(mregs->lcdcon2) + 1;
+				S3C2410_LCDCON2_GET_VSPW(display->lcdcon2) + 1;
 
 	fbinfo->var.hsync_len	    =
-				S3C2410_LCDCON4_GET_HSPW(mregs->lcdcon4) + 1;
+				S3C2410_LCDCON4_GET_HSPW(display->lcdcon4) + 1;
 
 	fbinfo->var.red.offset      = 11;
 	fbinfo->var.green.offset    = 5;
diff --git a/include/asm-arm/arch-s3c2410/fb.h b/include/asm-arm/arch-s3c2410/fb.h
index a76585a..8a7fa1b 100644
--- a/include/asm-arm/arch-s3c2410/fb.h
+++ b/include/asm-arm/arch-s3c2410/fb.h
@@ -44,7 +44,10 @@ struct s3c2410fb_display {
 	unsigned short vsync_len;	/* value in lines (TFT) or 0 (STN) */
 
 	/* lcd configuration registers */
-	struct s3c2410fb_hw  regs;
+	unsigned long	lcdcon1;
+	unsigned long	lcdcon2;
+	unsigned long	lcdcon4;
+	unsigned long	lcdcon5;
 };
 
 struct s3c2410fb_mach_info {


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
