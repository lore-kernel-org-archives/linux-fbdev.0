From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH 5/7] s3c2410fb: use vertical margins
	values
Date: Sat, 11 Aug 2007 07:51:52 +0200
Message-ID: <20070811075152.b5ba5917.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJjou-0001EL-Qa for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 22:47:28 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1IJjou-0007eT-Dv
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 22:47:28 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	11 Aug 2007 07:47:26 +0200
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

This patch makes use of vertical margins fields in
the s3c2410fb_display structure.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.23.old/drivers/video/s3c2410fb.c	2007-08-05 13:39:19.000000000 +0200
+++ linux-2.6.23/drivers/video/s3c2410fb.c	2007-08-05 13:59:48.000000000 +0200
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
