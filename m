From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: [RFC] Setting default virtual fb geometry
Date: Wed, 12 Aug 2009 09:59:54 +0100
Message-ID: <4A82848A.6020108@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpfj-list@mimc.co.uk>) id 1Mb9wj-0004gm-LS
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Aug 2009 09:16:37 +0000
Received: from mercuryimc.plus.com ([80.229.200.144] helo=mimc.mimc.co.uk)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mb9wZ-0001eC-Ch for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Aug 2009 09:16:37 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

At the moment you can set fbmem from the kernel bootargs, and
xres / yres are usually setup in the board init files.

However, there doesn;t seem to be any simple way to specify
the virtual size of the display (eg. for double buffering).

I have "hacked" the Atmel display driver in a quick and dirty
way to fulfil my needs, but I guess it needs a more formal
approach.

Anyone care to comment on how this "issue" might be resolved ?

Regards
Mark
---
 drivers/video/atmel_lcdfb.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 2864e05..54df737 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -353,6 +353,11 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
+	/* Calculate virtual yres based on fbmem size */
+	var->yres_virtual = info->fix.smem_len /
+				(var->xres * var->yres * (var->bits_per_pixel / 8));
+	var->yres_virtual *= var->yres;
+
 	/* Do not allow to have real resoulution larger than virtual */
 	if (var->xres > var->xres_virtual)
 		var->xres_virtual = var->xres;

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
