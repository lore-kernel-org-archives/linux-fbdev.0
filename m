From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] s3c2410fb: cleanup and fix
Date: Thu, 15 Dec 2005 13:09:20 +0100
Message-ID: <85u0dazhn3.fsf@duckcorp.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmrvU-0000fE-MM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Dec 2005 04:09:36 -0800
Received: from orfeo.duckcorp.org
	([195.5.254.194] helo=mx.duckcorp.org ident=postfix)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EmrvS-0007kw-39
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Dec 2005 04:09:36 -0800
Received: from localhost (Orfeo [127.0.0.1])
	by mx.duckcorp.org (Postfix) with ESMTP id D017C5010EC
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Dec 2005 13:09:27 +0100 (CET)
Received: from mx.duckcorp.org ([127.0.0.1])
	by localhost (smtp.duckcorp.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21578-18 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 15 Dec 2005 13:09:20 +0100 (CET)
Received: from Orfeo (Orfeo [127.0.0.1])
	by mx.duckcorp.org (Postfix) with ESMTP id D8A615007FB
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Dec 2005 13:09:20 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

--=-=-=

Hi,

Here are some cleanups for the s3c2410fb drivers. It : 
* Removes a buggy call to s3c2410fb_init_registers. There was two calls
to this function but the first was done without all initialisations
done. No oops but it may confuse some LCDs.
* Makes two functions static.


Signed-Off-By: Arnaud Patard <arnaud.patard@rtp-net.org>
---
 s3c2410fb.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fb-cleanup.patch

Index: linux-2.6/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.orig/drivers/video/s3c2410fb.c	2005-12-14 23:18:59.000000000 +0100
+++ linux-2.6/drivers/video/s3c2410fb.c	2005-12-14 23:19:04.000000000 +0100
@@ -679,7 +679,7 @@
  * s3c2410fb_init_registers - Initialise all LCD-related registers
  */
 
-int s3c2410fb_init_registers(struct s3c2410fb_info *fbi)
+static int s3c2410fb_init_registers(struct s3c2410fb_info *fbi)
 {
 	unsigned long flags;
 
@@ -761,7 +761,7 @@
 
 static char driver_name[]="s3c2410fb";
 
-int __init s3c2410fb_probe(struct platform_device *pdev)
+static int __init s3c2410fb_probe(struct platform_device *pdev)
 {
 	struct s3c2410fb_info *info;
 	struct fb_info	   *fbinfo;
@@ -795,8 +795,6 @@
 	info->fb = fbinfo;
 	dev_set_drvdata(dev, fbinfo);
 
-	s3c2410fb_init_registers(info);
-
 	dprintk("devinit\n");
 
 	strcpy(fbinfo->fix.id, driver_name);
@@ -829,8 +827,8 @@
 	fbinfo->var.yres_virtual    = mach_info->yres.defval;
 	fbinfo->var.bits_per_pixel  = mach_info->bpp.defval;
 
-	fbinfo->var.upper_margin    = S3C2410_LCDCON2_GET_VBPD(mregs->lcdcon2) +1;
-	fbinfo->var.lower_margin    = S3C2410_LCDCON2_GET_VFPD(mregs->lcdcon2) +1;
+	fbinfo->var.upper_margin    = S3C2410_LCDCON2_GET_VBPD(mregs->lcdcon2) + 1;
+	fbinfo->var.lower_margin    = S3C2410_LCDCON2_GET_VFPD(mregs->lcdcon2) + 1;
 	fbinfo->var.vsync_len	    = S3C2410_LCDCON2_GET_VSPW(mregs->lcdcon2) + 1;
 
 	fbinfo->var.left_margin	    = S3C2410_LCDCON3_GET_HFPD(mregs->lcdcon3) + 1;

--=-=-=--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
