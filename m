From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/2] cirrusfb: use 5-6-5 RGB for 16bpp
	mode
Date: Sat, 14 Feb 2009 18:52:31 +0100
Message-ID: <20090214185231.9158b170.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LYOch-0001KE-Lx
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Feb 2009 17:48:15 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LYOce-0002ab-Rd for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Feb 2009 17:48:15 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arthur Marsh <arthur.marsh@internode.on.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use the 5-6-5 RGB mode instead of the 5-5-5 mode
at 16bpp depth.
It fixes colors in the 16bpp modes on Cirrus
Laguna chips.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index c98efd0..bf3d9c3 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -499,12 +499,12 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 			var->green.offset = -3;
 			var->blue.offset = 8;
 		} else {
-			var->red.offset = 10;
+			var->red.offset = 11;
 			var->green.offset = 5;
 			var->blue.offset = 0;
 		}
 		var->red.length = 5;
-		var->green.length = 5;
+		var->green.length = 6;
 		var->blue.length = 5;
 		break;
 
@@ -1180,7 +1180,7 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 		/* pixel mask: pass-through all planes */
 		WGen(cinfo, VGA_PEL_MSK, 0xff);
 #ifdef CONFIG_PCI
-		WHDR(cinfo, 0xc0);	/* Copy Xbh */
+		WHDR(cinfo, 0xc1);	/* Copy Xbh */
 #elif defined(CONFIG_ZORRO)
 		/* FIXME: CONFIG_PCI and CONFIG_ZORRO may be defined both */
 		WHDR(cinfo, 0xa0);	/* hidden dac reg: nothing special */
-- 
1.5.2.2



----------------------------------------------------------------------
Zostan mistrzem parkowania w Bombaju!
Zagraj >> http://link.interia.pl/f204e 


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
