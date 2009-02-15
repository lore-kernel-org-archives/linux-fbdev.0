From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] uvesafb: Fix misplaced parentheses
Date: Sun, 15 Feb 2009 17:49:20 +0100
Message-ID: <49984790.3060208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LYkBH-0002bf-3P
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Feb 2009 16:49:23 +0000
Received: from mail-ew0-f15.google.com ([209.85.219.15])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LYkBF-0004yj-MP for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Feb 2009 16:49:22 +0000
Received: by ewy8 with SMTP id 8so1638464ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 15 Feb 2009 08:49:20 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: spock@gentoo.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

Fix misplaced parentheses

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
// vi include/linux/fb.h +755
#define FBINFO_MODULE           0x0001  /* Low-level driver is a module */

// ... :778
#define FBINFO_HWACCEL_YPAN             0x2000 /* optional */

// ... :855
#ifdef MODULE
#define FBINFO_DEFAULT  FBINFO_MODULE
#else
#define FBINFO_DEFAULT  0
#endif

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 6c2d37f..29dd4c3 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -1549,7 +1549,7 @@ static void __devinit uvesafb_init_info(struct fb_info *info,
 	}
 
 	info->flags = FBINFO_FLAG_DEFAULT |
-			(par->ypan) ? FBINFO_HWACCEL_YPAN : 0;
+			(par->ypan ? FBINFO_HWACCEL_YPAN : 0);
 
 	if (!par->ypan)
 		info->fbops->fb_pan_display = NULL;

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
