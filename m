From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] Fix colors in mach64 accelerator (fwd)
Date: Tue, 6 Oct 2009 12:21:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0910061219510.16200@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpatocka@redhat.com>) id 1MvCnY-0000YR-MA
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Oct 2009 16:22:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MvCnT-0006Ki-Ox for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Oct 2009 16:22:00 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: paulus@samba.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi

In the previous kernel cycle I sent you this patch, you acknowledged it 
but didn't put it to the kernel.

Did you forget it? Do you want to add it in this cycle?

The patch fixes mach64 fill rect routine for 15 and 16-bit modes.

Mikulas

---------- Forwarded message ----------
Date: Wed, 17 Jun 2009 06:00:53 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: paulus@samba.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] Fix colors in mach64 accelerator

Use the same color-calculating algorithm as in atyfb_imageblit in this driver
or in generic cfb_fillrect.

This patch fixes bad colors when using an accelerator in 15-bit and 16-bit
modes.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com

---
 drivers/video/aty/mach64_accel.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6.30-fast/drivers/video/aty/mach64_accel.c
===================================================================
--- linux-2.6.30-fast.orig/drivers/video/aty/mach64_accel.c	2009-06-15 21:42:10.000000000 +0200
+++ linux-2.6.30-fast/drivers/video/aty/mach64_accel.c	2009-06-17 08:49:01.000000000 +0200
@@ -239,7 +239,7 @@ void atyfb_copyarea(struct fb_info *info
 void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-	u32 color = rect->color, dx = rect->dx, width = rect->width, rotation = 0;
+	u32 color, dx = rect->dx, width = rect->width, rotation = 0;
 
 	if (par->asleep)
 		return;
@@ -250,8 +250,11 @@ void atyfb_fillrect(struct fb_info *info
 		return;
 	}
 
-	color |= (rect->color << 8);
-	color |= (rect->color << 16);
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
+	    info->fix.visual == FB_VISUAL_DIRECTCOLOR)
+		color = ((u32 *)(info->pseudo_palette))[rect->color];
+	else
+		color = rect->color;
 
 	if (info->var.bits_per_pixel == 24) {
 		/* In 24 bpp, the engine is in 8 bpp - this requires that all */

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
