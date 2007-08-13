From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 12/22] s3c2410fb: use vertical margins
	values
Date: Mon, 13 Aug 2007 20:36:31 +0800
Message-ID: <46C0504F.5040505@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKaRN-0004Af-Jo for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 06:58:47 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZKV-0005O6-Tb
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:47:32 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:47:31 -0700 (PDT)
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

This patch makes use of vertical margins fields in
the s3c2410fb_display structure.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/s3c2410fb.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 27528ca..a30d538 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -325,14 +325,10 @@ static void s3c2410fb_calculate_stn_lcd_
 			var->bits_per_pixel);
 	}
 	/* update X/Y info */
-	dprintk("setting vert: up=%d, low=%d, sync=%d\n",
-		var->upper_margin, var->lower_margin, var->vsync_len);
-
 	dprintk("setting horz: lft=%d, rt=%d, sync=%d\n",
 		var->left_margin, var->right_margin, var->hsync_len);
 
-	regs->lcdcon2 &= ~S3C2410_LCDCON2_LINEVAL(0x3ff);
-	regs->lcdcon2 |=  S3C2410_LCDCON2_LINEVAL(var->yres - 1);
+	regs->lcdcon2 = S3C2410_LCDCON2_LINEVAL(var->yres - 1);
 
 	if (wdly > 3)
 		wdly = 3;
@@ -387,8 +383,10 @@ static void s3c2410fb_calculate_tft_lcd_
 	dprintk("setting horz: lft=%d, rt=%d, sync=%d\n",
 		var->left_margin, var->right_margin, var->hsync_len);
 
-	regs->lcdcon2 &= ~S3C2410_LCDCON2_LINEVAL(0x3ff);
-	regs->lcdcon2 |=  S3C2410_LCDCON2_LINEVAL(var->yres - 1);
+	regs->lcdcon2 &= S3C2410_LCDCON2_VSPW(0x3f);
+	regs->lcdcon2 |= S3C2410_LCDCON2_LINEVAL(var->yres - 1);
+	regs->lcdcon2 |= S3C2410_LCDCON2_VBPD(var->upper_margin - 1);
+	regs->lcdcon2 |= S3C2410_LCDCON2_VFPD(var->lower_margin - 1);
 
 	regs->lcdcon3 = S3C2410_LCDCON3_HBPD(var->right_margin - 1) |
 			S3C2410_LCDCON3_HFPD(var->left_margin - 1) |
@@ -416,8 +414,6 @@ static void s3c2410fb_activate_var(struc
 
 	if (!mach_info->fixed_syncs) {
 		fbi->regs.lcdcon2 =
-			S3C2410_LCDCON2_VBPD(var->upper_margin - 1) |
-			S3C2410_LCDCON2_VFPD(var->lower_margin - 1) |
 			S3C2410_LCDCON2_VSPW(var->vsync_len - 1);
 
 		fbi->regs.lcdcon4 &= ~S3C2410_LCDCON4_HSPW(0xff);
@@ -892,13 +888,10 @@ static int __init s3c2410fb_probe(struct
 	fbinfo->var.left_margin	    = display->left_margin;
 	fbinfo->var.right_margin    = display->right_margin;
 
-	fbinfo->var.upper_margin    =
-				S3C2410_LCDCON2_GET_VBPD(display->lcdcon2) + 1;
-	fbinfo->var.lower_margin    =
-				S3C2410_LCDCON2_GET_VFPD(display->lcdcon2) + 1;
+	fbinfo->var.upper_margin    = display->upper_margin;
+	fbinfo->var.lower_margin    = display->lower_margin;
 	fbinfo->var.vsync_len	    =
 				S3C2410_LCDCON2_GET_VSPW(display->lcdcon2) + 1;
-
 	fbinfo->var.hsync_len	    =
 				S3C2410_LCDCON4_GET_HSPW(display->lcdcon4) + 1;
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
