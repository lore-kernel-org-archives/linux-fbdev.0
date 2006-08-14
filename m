From: Raphael Assenat <raph@8d.com>
Subject: [PATCH 2/2] mbxfb: Fix framebuffer size smaller
	than requested
Date: Mon, 14 Aug 2006 14:40:12 -0400
Message-ID: <44E0C38C.4030001@8d.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000605060404010603080101"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GChL6-0004CG-8a for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 11:39:04 -0700
Received: from roc.holo.8d.com ([64.254.227.115])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GChL4-0003De-S3
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 11:39:04 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000605060404010603080101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a bug where we obtain a smaller resolution than requested.
(eg: in 640x480, only 639x479 usable pixels).

This was due to 1 being substracted from the xres and yres vars
two times: first in mbxfb.c and then in the macros from reg_bits.h.

This patch removes the minus ones from the mbxfb.c file. Tested and works.


--------------000605060404010603080101
Content-Type: text/plain;
 name="mbxfb-size.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mbxfb-size.diff"

This patch fixes a bug where we obtain a smaller resolution than requested. 
(eg: in 640x480, only 639x479 usable pixels). 

This was due to 1 being substracted from the xres and yres vars 
two times: first in mbxfb.c and then in the macros from reg_bits.h.

This patch removes the minus ones from the mbxfb.c file. Tested and works.

Signed-off-by: Raphael Assenat <raph@8d.com>

--- mbxfb.c-disppll-workaound	2006-08-14 14:08:56.000000000 -0400
+++ ../linux-2.6.18-rc2-8d/drivers/video/mbx/mbxfb.c	2006-08-14 14:23:40.000000000 -0400
@@ -255,8 +255,8 @@
 
 	/* setup resolution */
 	gsctrl &= ~(FMsk(GSCTRL_GSWIDTH) | FMsk(GSCTRL_GSHEIGHT));
-	gsctrl |= Gsctrl_Width(info->var.xres - 1) |
-		Gsctrl_Height(info->var.yres - 1);
+	gsctrl |= Gsctrl_Width(info->var.xres) |
+		Gsctrl_Height(info->var.yres);
 	writel(gsctrl, GSCTRL);
 	udelay(1000);
 
@@ -413,8 +413,8 @@
 {
 	unsigned long gsctrl;
 
-	gsctrl = GSCTRL_GAMMA_EN | Gsctrl_Width(fbi->var.xres - 1) |
-		Gsctrl_Height(fbi->var.yres - 1);
+	gsctrl = GSCTRL_GAMMA_EN | Gsctrl_Width(fbi->var.xres) |
+		Gsctrl_Height(fbi->var.yres);
 	switch (fbi->var.bits_per_pixel) {
 	case 16:
 		if (fbi->var.green.length == 5)

--------------000605060404010603080101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------000605060404010603080101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------000605060404010603080101--
