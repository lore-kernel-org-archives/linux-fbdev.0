From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] s3c2410fb: byte ordering fixes
Date: Sun, 16 Sep 2007 07:22:52 +0800
Message-ID: <46EC694C.9020906@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWgzr-0006Ai-MT for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Sep 2007 16:24:27 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWgzr-00023y-9E
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Sep 2007 16:24:19 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3913752rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 15 Sep 2007 16:24:18 -0700 (PDT)
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
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch sets correct bits related to the byte ordering
of the framebuffer. This was tested on little endian kernel
only. The big endian kernel may require different settings.

The patch also adds 32 bpp mode which is called 24 bpp by
Samsung. One pixel takes 32 bits but only 24 bits are used
in this mode.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/s3c2410fb.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 98da79c..ae08d45 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -278,8 +278,8 @@ static int s3c2410fb_check_var(struct fb
 			var->blue.length	= 5;
 		}
 		break;
-	case 24:
-		/* 24 bpp 888 */
+	case 32:
+		/* 24 bpp 888 and 8 dummy */
 		var->red.length		= 8;
 		var->red.offset		= 16;
 		var->green.length	= 8;
@@ -287,8 +287,6 @@ static int s3c2410fb_check_var(struct fb
 		var->blue.length	= 8;
 		var->blue.offset	= 0;
 		break;
-
-
 	}
 	return 0;
 }
@@ -375,11 +373,21 @@ static void s3c2410fb_calculate_tft_lcd_
 		break;
 	case 8:
 		regs->lcdcon1 |= S3C2410_LCDCON1_TFT8BPP;
+		regs->lcdcon5 |= S3C2410_LCDCON5_BSWP |
+				 S3C2410_LCDCON5_FRM565;
+		regs->lcdcon5 &= ~S3C2410_LCDCON5_HWSWP;
 		break;
 	case 16:
 		regs->lcdcon1 |= S3C2410_LCDCON1_TFT16BPP;
+		regs->lcdcon5 &= ~S3C2410_LCDCON5_BSWP;
+		regs->lcdcon5 |= S3C2410_LCDCON5_HWSWP;
+		break;
+	case 32:
+		regs->lcdcon1 |= S3C2410_LCDCON1_TFT24BPP;
+		regs->lcdcon5 &= ~(S3C2410_LCDCON5_BSWP |
+				   S3C2410_LCDCON5_HWSWP |
+				   S3C2410_LCDCON5_BPP24BL);
 		break;
-
 	default:
 		/* invalid pixel depth */
 		dev_err(fbi->dev, "invalid bpp %d\n",
@@ -467,7 +475,9 @@ static int s3c2410fb_set_par(struct fb_i
 	struct fb_var_screeninfo *var = &info->var;
 
 	switch (var->bits_per_pixel) {
+	case 32:
 	case 16:
+	case 12:
 		info->fix.visual = FB_VISUAL_TRUECOLOR;
 		break;
 	case 1:


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
