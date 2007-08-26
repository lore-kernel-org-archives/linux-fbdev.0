From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 09/20] s3c2410fb: removes lcdcon1
	register value from s3c2410fb_display
Date: Sun, 26 Aug 2007 22:03:14 +0800
Message-ID: <46D18822.90208@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPJ1h-0005Ba-PI for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:42 -0700
Received: from nz-out-0506.google.com ([64.233.162.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPJ1h-00088d-60
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:41 -0700
Received: by nz-out-0506.google.com with SMTP id f1so2918589nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Aug 2007 07:23:41 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes lcdcon1 register field from the
s3c2410fb_display
as all bits are calculated from other fields.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 arch/arm/mach-s3c2410/mach-amlm5900.c |    1 -
 arch/arm/mach-s3c2410/mach-bast.c     |    3 ---
 arch/arm/mach-s3c2410/mach-h1940.c    |    4 ----
 arch/arm/mach-s3c2410/mach-qt2410.c   |   12 ------------
 arch/arm/mach-s3c2440/mach-rx3715.c   |    4 ----
 arch/arm/mach-s3c2440/mach-smdk2440.c |    4 ----
 drivers/video/s3c2410fb.c             |    9 +--------
 include/asm-arm/arch-s3c2410/fb.h     |    1 -
 8 files changed, 1 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
index a86d68d..a67a068 100644
--- a/arch/arm/mach-s3c2410/mach-amlm5900.c
+++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
@@ -184,7 +184,6 @@ static struct s3c2410fb_display __initda
 	.upper_margin	= 0,
 	.lower_margin	= 0,
 
-	.lcdcon1	= 0x00008225,
 	.lcdcon5	= 0x00000001,
 };
 
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index 103fc57..587864f 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -484,7 +484,6 @@ static struct s3c2410fb_display __initda
 		.lower_margin	= 32,
 		.vsync_len	= 3,
 
-		.lcdcon1	= 0x00000176,
 		.lcdcon5	= 0x00014b02,
 	},
 	{
@@ -503,7 +502,6 @@ static struct s3c2410fb_display __initda
 		.lower_margin	= 32,
 		.vsync_len	= 3,
 
-		.lcdcon1	= 0x00000176,
 		.lcdcon5	= 0x00014b02,
 	},
 	{
@@ -522,7 +520,6 @@ static struct s3c2410fb_display __initda
 		.lower_margin	= 32,
 		.vsync_len	= 3,
 
-		.lcdcon1	= 0x00000176,
 		.lcdcon5	= 0x00014b02,
 	},
 };
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 8a50842..7c1145e 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -134,10 +134,6 @@ static struct s3c2410_udc_mach_info h194
  * Set lcd on or off
  **/
 static struct s3c2410fb_display h1940_lcd __initdata = {
-	.lcdcon1=	S3C2410_LCDCON1_TFT16BPP | \
-			S3C2410_LCDCON1_TFT | \
-			S3C2410_LCDCON1_CLKVAL(0x0C),
-
 	.lcdcon5=	S3C2410_LCDCON5_FRM565 | \
 			S3C2410_LCDCON5_INVVLINE | \
 			S3C2410_LCDCON5_HWSWP,
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index 612f624..a1caf4b 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -98,10 +98,6 @@ static struct s3c2410_uartcfg smdk2410_u
 static struct s3c2410fb_display qt2410_lcd_cfg[] __initdata = {
 	{
 		/* Configuration for 640x480 SHARP LQ080V3DG01 */
-		.lcdcon1 = S3C2410_LCDCON1_TFT16BPP |
-			   S3C2410_LCDCON1_TFT |
-			   S3C2410_LCDCON1_CLKVAL(0x01), /* HCLK/4 */
-
 		.lcdcon5 = S3C2410_LCDCON5_FRM565 |
 			   S3C2410_LCDCON5_INVVLINE |
 			   S3C2410_LCDCON5_INVVFRAME |
@@ -125,10 +121,6 @@ static struct s3c2410fb_display qt2410_l
 	},
 	{
 		/* Configuration for 480x640 toppoly TD028TTEC1 */
-		.lcdcon1 = S3C2410_LCDCON1_TFT16BPP |
-			   S3C2410_LCDCON1_TFT |
-			   S3C2410_LCDCON1_CLKVAL(0x01), /* HCLK/4 */
-
 		.lcdcon5 = S3C2410_LCDCON5_FRM565 |
 			   S3C2410_LCDCON5_INVVLINE |
 			   S3C2410_LCDCON5_INVVFRAME |
@@ -151,10 +143,6 @@ static struct s3c2410fb_display qt2410_l
 	},
 	{
 		/* Config for 240x320 LCD */
-		.lcdcon1 = S3C2410_LCDCON1_TFT16BPP |
-			   S3C2410_LCDCON1_TFT |
-			   S3C2410_LCDCON1_CLKVAL(0x04),
-
 		.lcdcon5 = S3C2410_LCDCON5_FRM565 |
 			   S3C2410_LCDCON5_INVVLINE |
 			   S3C2410_LCDCON5_INVVFRAME |
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index 408337f..bac40c4 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -111,10 +111,6 @@ static struct s3c2410_uartcfg rx3715_uar
 /* framebuffer lcd controller information */
 
 static struct s3c2410fb_display rx3715_lcdcfg __initdata = {
-	.lcdcon1 =	S3C2410_LCDCON1_TFT16BPP | \
-			S3C2410_LCDCON1_TFT | \
-			S3C2410_LCDCON1_CLKVAL(0x0C),
-
 	.lcdcon5 =	S3C2410_LCDCON5_INVVLINE |
 			S3C2410_LCDCON5_FRM565 |
 			S3C2410_LCDCON5_HWSWP,
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index 561e391..4552828 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -105,10 +105,6 @@ static struct s3c2410_uartcfg smdk2440_u
 
 static struct s3c2410fb_display smdk2440_lcd_cfg __initdata = {
 
-	.lcdcon1	= S3C2410_LCDCON1_TFT16BPP |
-			  S3C2410_LCDCON1_TFT |
-			  S3C2410_LCDCON1_CLKVAL(0x04),
-
 	.lcdcon5	= S3C2410_LCDCON5_FRM565 |
 			  S3C2410_LCDCON5_INVVLINE |
 			  S3C2410_LCDCON5_INVVFRAME |
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index b2160ec..b2ba7a0 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -207,11 +207,9 @@ static int s3c2410fb_check_var(struct fb
 	var->vsync_len = display->vsync_len;
 	var->hsync_len = display->hsync_len;
 
-	fbi->regs.lcdcon1 = display->lcdcon1;
 	fbi->regs.lcdcon5 = display->lcdcon5;
 	/* set display type */
-	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_TFT;
-	fbi->regs.lcdcon1 |= display->type;
+	fbi->regs.lcdcon1 = display->type;
 
 	var->transp.offset = 0;
 	var->transp.length = 0;
@@ -303,8 +301,6 @@ static void s3c2410fb_calculate_stn_lcd_
 	if (type != S3C2410_LCDCON1_STN4)
 		hs >>= 1;
 
-	regs->lcdcon1 &= ~S3C2410_LCDCON1_MODEMASK;
-
 	switch (var->bits_per_pixel) {
 	case 1:
 		regs->lcdcon1 |= S3C2410_LCDCON1_STN1BPP;
@@ -358,8 +354,6 @@ static void s3c2410fb_calculate_tft_lcd_
 	const struct s3c2410fb_info *fbi = info->par;
 	const struct fb_var_screeninfo *var = &info->var;
 
-	regs->lcdcon1 &= ~S3C2410_LCDCON1_MODEMASK;
-
 	switch (var->bits_per_pixel) {
 	case 1:
 		regs->lcdcon1 |= S3C2410_LCDCON1_TFT1BPP;
@@ -429,7 +423,6 @@ static void s3c2410fb_activate_var(struc
 			clkdiv = 2;
 	}
 
-	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_CLKVAL(0x3ff);
 	fbi->regs.lcdcon1 |=  S3C2410_LCDCON1_CLKVAL(clkdiv);
 
 	/* write new registers */
diff --git a/include/asm-arm/arch-s3c2410/fb.h b/include/asm-arm/arch-s3c2410/fb.h
index 9abe67b..5d02626 100644
--- a/include/asm-arm/arch-s3c2410/fb.h
+++ b/include/asm-arm/arch-s3c2410/fb.h
@@ -45,7 +45,6 @@ struct s3c2410fb_display {
 	unsigned short vsync_len;	/* value in lines (TFT) or 0 (STN) */
 
 	/* lcd configuration registers */
-	unsigned long	lcdcon1;
 	unsigned long	lcdcon5;
 };
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
