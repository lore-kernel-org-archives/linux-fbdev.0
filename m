From: Richard Purdie <rpurdie@rpsys.net>
Subject: pxafb: Minor driver fixes
Date: Mon, 27 Mar 2006 00:08:08 +0100
Message-ID: <1143414489.18513.51.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNeLJ-0002sc-3X
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Mar 2006 15:08:17 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FNeLI-0006Rz-BB
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Mar 2006 15:08:16 -0800
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
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Fixes for the pxafb driver:

* Return -EINVAL for resolutions that are too large as per framebuffer
driver policy.
* Increase the error timeout for disabling the LCD controller. The
current timeout is sometimes too short on the Sharp Zaurus Cxx00
hardware and an extra delay in an error path shouldn't any problems.
* Fix a dev reference which causes a compile error when DEBUG is
defined.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.15/drivers/video/pxafb.c
===================================================================
--- linux-2.6.15.orig/drivers/video/pxafb.c	2006-01-28 22:48:01.000000000 +0000
+++ linux-2.6.15/drivers/video/pxafb.c	2006-01-28 22:57:01.000000000 +0000
@@ -232,9 +232,9 @@
 	if (var->yres < MIN_YRES)
 		var->yres = MIN_YRES;
 	if (var->xres > fbi->max_xres)
-		var->xres = fbi->max_xres;
+		return -EINVAL;
 	if (var->yres > fbi->max_yres)
-		var->yres = fbi->max_yres;
+		return -EINVAL;
 	var->xres_virtual =
 		max(var->xres_virtual, var->xres);
 	var->yres_virtual =
@@ -781,7 +781,7 @@
 	LCCR0 &= ~LCCR0_LDM;	/* Enable LCD Disable Done Interrupt */
 	LCCR0 |= LCCR0_DIS;	/* Disable LCD Controller */
 
-	schedule_timeout(20 * HZ / 1000);
+	schedule_timeout(200 * HZ / 1000);
 	remove_wait_queue(&fbi->ctrlr_wait, &wait);
 
 	/* disable LCD controller clock */
@@ -1274,7 +1274,7 @@
 	struct pxafb_mach_info *inf;
 	int ret;
 
-	dev_dbg(dev, "pxafb_probe\n");
+	dev_dbg(&dev->dev, "pxafb_probe\n");
 
 	inf = dev->dev.platform_data;
 	ret = -ENOMEM;




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
