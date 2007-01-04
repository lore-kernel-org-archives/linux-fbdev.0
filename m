From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] s3c2410fb: Misc fixes
Date: Fri, 05 Jan 2007 00:32:03 +0100
Message-ID: <85irfms70s.fsf@orfeo.duckcorp.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2c4D-0004CU-WF for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Jan 2007 15:32:14 -0800
Received: from orfeo.duckcorp.org
	([195.5.254.194] helo=mx.duckcorp.org ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H2c4C-0000X6-JI
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Jan 2007 15:32:13 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Ben Dooks <ben-linux@fluff.org>

--=-=-=

Hi,

This patch fix the following issues:

- In one place "var->width" is used, instead of "var->xres"
- add "pixclock" field to "s3c2410fb_mach_info", so
  "s3c2410fb_calc_pixclk" can be used
- check the parameters before initializing the controller

From: David Muller <d.mueller@elsoft.ch>
Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=s3c2410fb_fixes.patch

---
 drivers/video/s3c2410fb.c         |    7 	4 +	3 -	0 !
 include/asm-arm/arch-s3c2410/fb.h |    1 	1 +	0 -	0 !
 2 files changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.orig/drivers/video/s3c2410fb.c	2007-01-04 22:02:58.000000000 +0100
+++ linux-2.6/drivers/video/s3c2410fb.c	2007-01-04 22:15:17.000000000 +0100
@@ -461,7 +461,7 @@ static int s3c2410fb_set_par(struct fb_i
 			 break;
 	}
 
-	fbi->fb->fix.line_length     = (var->width*var->bits_per_pixel)/8;
+	fbi->fb->fix.line_length     = (var->xres*var->bits_per_pixel)/8;
 
 	/* activate this new configuration */
 
@@ -829,6 +829,7 @@ static int __init s3c2410fb_probe(struct
 	fbinfo->var.yres	    = mach_info->yres.defval;
 	fbinfo->var.yres_virtual    = mach_info->yres.defval;
 	fbinfo->var.bits_per_pixel  = mach_info->bpp.defval;
+	fbinfo->var.pixclock        = mach_info->pixclock;
 
 	fbinfo->var.upper_margin    = S3C2410_LCDCON2_GET_VBPD(mregs->lcdcon2) + 1;
 	fbinfo->var.lower_margin    = S3C2410_LCDCON2_GET_VFPD(mregs->lcdcon2) + 1;
@@ -889,10 +890,10 @@ static int __init s3c2410fb_probe(struct
 	}
 	dprintk("got video memory\n");
 
-	ret = s3c2410fb_init_registers(info);
-
 	ret = s3c2410fb_check_var(&fbinfo->var, fbinfo);
 
+	ret = s3c2410fb_init_registers(info);
+
 	ret = register_framebuffer(fbinfo);
 	if (ret < 0) {
 		printk(KERN_ERR "Failed to register framebuffer device: %d\n", ret);
Index: linux-2.6/include/asm-arm/arch-s3c2410/fb.h
===================================================================
--- linux-2.6.orig/include/asm-arm/arch-s3c2410/fb.h	2007-01-04 22:02:59.000000000 +0100
+++ linux-2.6/include/asm-arm/arch-s3c2410/fb.h	2007-01-04 22:13:07.000000000 +0100
@@ -30,6 +30,7 @@ struct s3c2410fb_hw {
 
 struct s3c2410fb_mach_info {
 	unsigned char	fixed_syncs;	/* do not update sync/border */
+	unsigned int	pixclock;
 
 	/* LCD types */
 	int		type;

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--=-=-=--
