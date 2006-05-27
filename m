From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] s3c2410fb: Fix resume
Date: Sat, 27 May 2006 15:39:25 +0200
Message-ID: <85fyivr3hu.fsf@Orfeo.duckcorp.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fk1lD-0006Ts-Ez
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 09:35:31 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fk1lD-00078d-0w
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 09:35:31 -0700
Received: from orfeo.duckcorp.org
	([195.5.254.194] helo=mx.duckcorp.org ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fk1lC-0008Gm-FA
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 09:35:30 -0700
Received: from localhost (Orfeo.duckcorp.org [127.0.0.1])
	by mx.duckcorp.org (Postfix) with ESMTP id 529B45007F6
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 May 2006 18:35:25 +0200 (CEST)
Received: from mx.duckcorp.org ([127.0.0.1])
	by localhost (smtp.duckcorp.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25133-02 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 27 May 2006 18:35:10 +0200 (CEST)
Received: from Orfeo.duckcorp.org (Orfeo.duckcorp.org [127.0.0.1])
	by mx.duckcorp.org (Postfix) with ESMTP id 48794500EC5
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 May 2006 15:39:25 +0200 (CEST)
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

This patch fixes the resume of the s3c2410fb driver. This patch is not
new but I forgot to send it :(

Please apply :)

Regards,
Arnaud


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fb_suspend.patch

regs.lcdcon1 was not updated on suspend. The result was a garbaged display
on resume. This bug was first noticed by Christer Weinigel. This patch is a
modified version of the one he sent to me.


Signed-Off-By: Arnaud Patard <arnaud.patard@rtp-net.org>


---

drivers/video/s3c2410fb.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.orig/drivers/video/s3c2410fb.c	2006-05-09 22:35:20.000000000 +0200
+++ linux-2.6/drivers/video/s3c2410fb.c	2006-05-27 15:05:02.000000000 +0200
@@ -641,6 +641,7 @@ static int __init s3c2410fb_probe(struct
 	int ret;
 	int irq;
 	int i;
+	u32 lcdcon1;
 
 	mach_info = pdev->dev.platform_data;
 	if (mach_info == NULL) {
@@ -672,6 +673,11 @@ static int __init s3c2410fb_probe(struct
 
 	memcpy(&info->regs, &mach_info->regs, sizeof(info->regs));
 
+	/* Stop the video and unset ENVID if set */
+	info->regs.lcdcon1 &= ~S3C2410_LCDCON1_ENVID;
+	lcdcon1 = readl(S3C2410_LCDCON1);
+	writel(lcdcon1 & ~S3C2410_LCDCON1_ENVID, S3C2410_LCDCON1);
+
 	info->mach_info		    = pdev->dev.platform_data;
 
 	fbinfo->fix.type	    = FB_TYPE_PACKED_PIXELS;
@@ -794,15 +800,14 @@ dealloc_fb:
  * shutdown the lcd controller
 */
 
-static void s3c2410fb_stop_lcd(void)
+static void s3c2410fb_stop_lcd(struct s3c2410fb_info *fbi)
 {
 	unsigned long flags;
-	unsigned long tmp;
 
 	local_irq_save(flags);
 
-	tmp = readl(S3C2410_LCDCON1);
-	writel(tmp & ~S3C2410_LCDCON1_ENVID, S3C2410_LCDCON1);
+	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_ENVID;
+	writel(fbi->regs.lcdcon1, S3C2410_LCDCON1);
 
 	local_irq_restore(flags);
 }
@@ -816,7 +821,7 @@ static int s3c2410fb_remove(struct platf
 	struct s3c2410fb_info *info = fbinfo->par;
 	int irq;
 
-	s3c2410fb_stop_lcd();
+	s3c2410fb_stop_lcd(info);
 	msleep(1);
 
 	s3c2410fb_unmap_video_memory(info);
@@ -844,7 +849,7 @@ static int s3c2410fb_suspend(struct plat
 	struct fb_info	   *fbinfo = platform_get_drvdata(dev);
 	struct s3c2410fb_info *info = fbinfo->par;
 
-	s3c2410fb_stop_lcd();
+	s3c2410fb_stop_lcd(info);
 
 	/* sleep before disabling the clock, we need to ensure
 	 * the LCD DMA engine is not going to get back on the bus

--=-=-=--



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
