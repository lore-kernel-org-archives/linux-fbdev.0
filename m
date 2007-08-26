From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 08/20] s3c2410fb: adds pixclock to
	s3c2410fb_display
Date: Sun, 26 Aug 2007 22:01:51 +0800
Message-ID: <46D187CF.6050100@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPJ1e-0005BE-4A for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:38 -0700
Received: from nz-out-0506.google.com ([64.233.162.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPJ1b-00088d-H1
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:38 -0700
Received: by nz-out-0506.google.com with SMTP id f1so2918589nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Aug 2007 07:23:35 -0700 (PDT)
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

This patch adds pixelclock field to the s3c2410fb_display
structure and make use of it in the driver.

The Bast machine defined 9 modes but pixclock and margin
values are defined only for the 640x480 modes so I removed
other modes.

This patch also fixes wrong display type constant for the
SMDK2440 board.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 arch/arm/mach-s3c2410/mach-amlm5900.c |    1 
 arch/arm/mach-s3c2410/mach-bast.c     |  112 +--------------------------------
 arch/arm/mach-s3c2410/mach-h1940.c    |    1 
 arch/arm/mach-s3c2410/mach-qt2410.c   |    3 +
 arch/arm/mach-s3c2440/mach-rx3715.c   |    1 
 arch/arm/mach-s3c2440/mach-smdk2440.c |    3 +
 drivers/video/s3c2410fb.c             |   42 +++++-------
 include/asm-arm/arch-s3c2410/fb.h     |    1 
 8 files changed, 28 insertions(+), 136 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-amlm5900.c b/arch/arm/mach-s3c2410/mach-amlm5900.c
index c475422..a86d68d 100644
--- a/arch/arm/mach-s3c2410/mach-amlm5900.c
+++ b/arch/arm/mach-s3c2410/mach-amlm5900.c
@@ -174,6 +174,7 @@ static struct s3c2410fb_display __initda
 
 	.type		= S3C2410_LCDCON1_STN4,
 
+	.pixclock	= 680000, /* HCLK = 100MHz */
 	.xres		= 160,
 	.yres		= 160,
 	.bpp		= 4,
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index 61d5b2a..103fc57 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -473,25 +473,7 @@ static struct s3c2410fb_display __initda
 		.width		= 640,
 		.height		= 480,
 
-		.xres		= 320,
-		.yres		= 240,
-		.left_margin	= 40,
-		.right_margin	= 20,
-		.hsync_len	= 88,
-		.upper_margin	= 30,
-		.lower_margin	= 32,
-		.vsync_len	= 3,
-
-		.bpp		= 4,
-
-		.lcdcon1	= 0x00000176,
-		.lcdcon5	= 0x00014b02,
-	},
-	{
-		.type		= S3C2410_LCDCON1_TFT,
-		.width		= 640,
-		.height		= 480,
-
+		.pixclock	= 33333,
 		.xres		= 640,
 		.yres		= 480,
 		.bpp		= 4,
@@ -510,42 +492,7 @@ static struct s3c2410fb_display __initda
 		.width		= 640,
 		.height		= 480,
 
-		.xres		= 800,
-		.yres		= 600,
-		.bpp		= 4,
-		.left_margin	= 40,
-		.right_margin	= 20,
-		.hsync_len	= 88,
-		.upper_margin	= 30,
-		.lower_margin	= 32,
-		.vsync_len	= 3,
-
-		.lcdcon1	= 0x00000176,
-		.lcdcon5	= 0x00014b02,
-	},
-	{
-		.type		= S3C2410_LCDCON1_TFT,
-		.width		= 640,
-		.height		= 480,
-
-		.xres		= 320,
-		.yres		= 240,
-		.bpp		= 8,
-		.left_margin	= 40,
-		.right_margin	= 20,
-		.hsync_len	= 88,
-		.upper_margin	= 30,
-		.lower_margin	= 32,
-		.vsync_len	= 3,
-
-		.lcdcon1	= 0x00000176,
-		.lcdcon5	= 0x00014b02,
-	},
-	{
-		.type		= S3C2410_LCDCON1_TFT,
-		.width		= 640,
-		.height		= 480,
-
+		.pixclock	= 33333,
 		.xres		= 640,
 		.yres		= 480,
 		.bpp		= 8,
@@ -564,42 +511,7 @@ static struct s3c2410fb_display __initda
 		.width		= 640,
 		.height		= 480,
 
-		.xres		= 800,
-		.yres		= 600,
-		.bpp		= 8,
-		.left_margin	= 40,
-		.right_margin	= 20,
-		.hsync_len	= 88,
-		.upper_margin	= 30,
-		.lower_margin	= 32,
-		.vsync_len	= 3,
-
-		.lcdcon1	= 0x00000176,
-		.lcdcon5	= 0x00014b02,
-	},
-	{
-		.type		= S3C2410_LCDCON1_TFT,
-		.width		= 640,
-		.height		= 480,
-
-		.xres		= 320,
-		.yres		= 240,
-		.bpp		= 16,
-		.left_margin	= 40,
-		.right_margin	= 20,
-		.hsync_len	= 88,
-		.upper_margin	= 30,
-		.lower_margin	= 32,
-		.vsync_len	= 3,
-
-		.lcdcon1	= 0x00000176,
-		.lcdcon5	= 0x00014b02,
-	},
-	{
-		.type		= S3C2410_LCDCON1_TFT,
-		.width		= 640,
-		.height		= 480,
-
+		.pixclock	= 33333,
 		.xres		= 640,
 		.yres		= 480,
 		.bpp		= 16,
@@ -613,24 +525,6 @@ static struct s3c2410fb_display __initda
 		.lcdcon1	= 0x00000176,
 		.lcdcon5	= 0x00014b02,
 	},
-	{
-		.type		= S3C2410_LCDCON1_TFT,
-		.width		= 640,
-		.height		= 480,
-
-		.xres		= 800,
-		.yres		= 600,
-		.bpp		= 16,
-		.left_margin	= 40,
-		.right_margin	= 20,
-		.hsync_len	= 88,
-		.upper_margin	= 30,
-		.lower_margin	= 32,
-		.vsync_len	= 3,
-
-		.lcdcon1	= 0x00000176,
-		.lcdcon5	= 0x00014b02,
-	},
 };
 
 /* LCD/VGA controller */
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 78dfc7d..8a50842 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -145,6 +145,7 @@ static struct s3c2410fb_display h1940_lc
 	.type =		S3C2410_LCDCON1_TFT,
 	.width =	240,
 	.height =	320,
+	.pixclock =	260000,
 	.xres =		240,
 	.yres =		320,
 	.bpp =		16,
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index ac94d56..612f624 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -112,6 +112,7 @@ static struct s3c2410fb_display qt2410_l
 		.width		= 640,
 		.height		= 480,
 
+		.pixclock	= 40000, /* HCLK/4 */
 		.xres		= 640,
 		.yres		= 480,
 		.bpp		= 16,
@@ -137,6 +138,7 @@ static struct s3c2410fb_display qt2410_l
 		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 480,
 		.height		= 640,
+		.pixclock	= 40000, /* HCLK/4 */
 		.xres		= 480,
 		.yres		= 640,
 		.bpp		= 16,
@@ -162,6 +164,7 @@ static struct s3c2410fb_display qt2410_l
 		.type		= S3C2410_LCDCON1_TFT,
 		.width		= 240,
 		.height		= 320,
+		.pixclock	= 100000, /* HCLK/10 */
 		.xres		= 240,
 		.yres		= 320,
 		.bpp		= 16,
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index f26adea..408337f 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -123,6 +123,7 @@ static struct s3c2410fb_display rx3715_l
 	.width		= 240,
 	.height		= 320,
 
+	.pixclock	= 260000,
 	.xres		= 240,
 	.yres		= 320,
 	.bpp		= 16,
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index 840a480..561e391 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -115,11 +115,12 @@ static struct s3c2410fb_display smdk2440
 			  S3C2410_LCDCON5_PWREN |
 			  S3C2410_LCDCON5_HWSWP,
 
-	.type		= S3C2410_LCDCON1_TFT16BPP,
+	.type		= S3C2410_LCDCON1_TFT,
 
 	.width		= 240,
 	.height		= 320,
 
+	.pixclock	= 166667, /* HCLK 60 MHz, divisor 10 */
 	.xres		= 240,
 	.yres		= 320,
 	.bpp		= 16,
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 77da734..b2160ec 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -199,6 +199,7 @@ static int s3c2410fb_check_var(struct fb
 	var->width = display->width;
 
 	/* copy lcd settings */
+	var->pixclock = display->pixclock;
 	var->left_margin = display->left_margin;
 	var->right_margin = display->right_margin;
 	var->upper_margin = display->upper_margin;
@@ -299,10 +300,6 @@ static void s3c2410fb_calculate_stn_lcd_
 	unsigned wdly = (var->left_margin >> 4) - 1;
 	unsigned wlh = (var->hsync_len >> 4) - 1;
 
-	dprintk("%s: var->xres  = %d\n", __FUNCTION__, var->xres);
-	dprintk("%s: var->yres  = %d\n", __FUNCTION__, var->yres);
-	dprintk("%s: var->bpp   = %d\n", __FUNCTION__, var->bits_per_pixel);
-
 	if (type != S3C2410_LCDCON1_STN4)
 		hs >>= 1;
 
@@ -361,10 +358,6 @@ static void s3c2410fb_calculate_tft_lcd_
 	const struct s3c2410fb_info *fbi = info->par;
 	const struct fb_var_screeninfo *var = &info->var;
 
-	dprintk("%s: var->xres  = %d\n", __FUNCTION__, var->xres);
-	dprintk("%s: var->yres  = %d\n", __FUNCTION__, var->yres);
-	dprintk("%s: var->bpp   = %d\n", __FUNCTION__, var->bits_per_pixel);
-
 	regs->lcdcon1 &= ~S3C2410_LCDCON1_MODEMASK;
 
 	switch (var->bits_per_pixel) {
@@ -419,28 +412,25 @@ static void s3c2410fb_activate_var(struc
 	void __iomem *regs = fbi->io;
 	int type = fbi->regs.lcdcon1 & S3C2410_LCDCON1_TFT;
 	struct fb_var_screeninfo *var = &info->var;
+	int clkdiv = s3c2410fb_calc_pixclk(fbi, var->pixclock) / 2;
 
-	if (var->pixclock > 0) {
-		int clkdiv = s3c2410fb_calc_pixclk(fbi, var->pixclock);
-
-		if (type == S3C2410_LCDCON1_TFT) {
-			clkdiv = (clkdiv / 2) - 1;
-			if (clkdiv < 0)
-				clkdiv = 0;
-		} else {
-			clkdiv = (clkdiv / 2);
-			if (clkdiv < 2)
-				clkdiv = 2;
-		}
-
-		fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_CLKVAL(0x3ff);
-		fbi->regs.lcdcon1 |=  S3C2410_LCDCON1_CLKVAL(clkdiv);
-	}
+	dprintk("%s: var->xres  = %d\n", __FUNCTION__, var->xres);
+	dprintk("%s: var->yres  = %d\n", __FUNCTION__, var->yres);
+	dprintk("%s: var->bpp   = %d\n", __FUNCTION__, var->bits_per_pixel);
 
-	if (type == S3C2410_LCDCON1_TFT)
+	if (type == S3C2410_LCDCON1_TFT) {
 		s3c2410fb_calculate_tft_lcd_regs(info, &fbi->regs);
-	else
+		--clkdiv;
+		if (clkdiv < 0)
+			clkdiv = 0;
+	} else {
 		s3c2410fb_calculate_stn_lcd_regs(info, &fbi->regs);
+		if (clkdiv < 2)
+			clkdiv = 2;
+	}
+
+	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_CLKVAL(0x3ff);
+	fbi->regs.lcdcon1 |=  S3C2410_LCDCON1_CLKVAL(clkdiv);
 
 	/* write new registers */
 
diff --git a/include/asm-arm/arch-s3c2410/fb.h b/include/asm-arm/arch-s3c2410/fb.h
index 6f022bd..9abe67b 100644
--- a/include/asm-arm/arch-s3c2410/fb.h
+++ b/include/asm-arm/arch-s3c2410/fb.h
@@ -36,6 +36,7 @@ struct s3c2410fb_display {
 	unsigned short yres;
 	unsigned short bpp;
 
+	unsigned pixclock;		/* pixclock in picoseconds */
 	unsigned short left_margin;  /* value in pixels (TFT) or HCLKs (STN) */
 	unsigned short right_margin; /* value in pixels (TFT) or HCLKs (STN) */
 	unsigned short hsync_len;    /* value in pixels (TFT) or HCLKs (STN) */


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
