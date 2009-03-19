From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/2] cirrusfb: fix threshold register
	mask for Laguna chips
Date: Thu, 19 Mar 2009 21:48:16 +0100
Message-ID: <20090319214816.f3925f18.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LkP9X-0003cd-G6
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Mar 2009 20:47:47 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LkP9U-0007Xk-GR for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Mar 2009 20:47:47 +0000
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
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Fix threshold register mask for Laguna chips
otherwise some 8bpp modes are garbled
after selecting a 24bpp mode.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
This and the previous patch are for the -mm tree.

 drivers/video/cirrusfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 145bad3..6717b49 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -873,7 +873,7 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 		threshold = fb_readw(cinfo->laguna_mmio + 0xea);
 		control &= ~0x6800;
 		format = 0;
-		threshold &= 0xffe0 & 0x3fbf;
+		threshold &= 0xffc0 & 0x3fbf;
 	}
 	if (nom) {
 		tmp = den << 1;
-- 
1.5.2.2



----------------------------------------------------------------------
Udar sloneczny prezesa Kaczynskiego... >>> http://link.interia.pl/f2083


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
