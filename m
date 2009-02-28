From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cirrusfb: fix compilation of Zorro code
Date: Sat, 28 Feb 2009 16:43:04 +0100
Message-ID: <20090228164304.0ccae7c4.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LdRGD-0004dz-7k
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Feb 2009 15:37:53 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LdRG3-0003Yl-W8 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Feb 2009 15:37:53 +0000
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

Add a missing coma.

Also, push down frequencies for the SD64
card as it is based on a GD5434 chip
and cannot do more than a GD5446 chip.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
This patch is for the -mm tree and fixes compilation
error in the -mm tree.

 drivers/video/cirrusfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 9d72e1b..ec03506 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -138,7 +138,7 @@ static const struct cirrusfb_board_info_rec {
 		.maxclock		= {
 			/* guess */
 			/* the SD64/P4 have a higher max. videoclock */
-			140000, 140000, 140000, 140000, 140000,
+			135100, 135100, 85500, 85500, 0
 		},
 		.init_sr07		= true,
 		.init_sr1f		= true,
@@ -2317,7 +2317,7 @@ static int __devinit cirrusfb_zorro_register(struct zorro_dev *z,
 	cinfo->unmap = cirrusfb_zorro_unmap;
 
 	dev_info(info->device,
-		 "Cirrus Logic chipset on Zorro bus, RAM (%lu MB) at $%lx\n"
+		 "Cirrus Logic chipset on Zorro bus, RAM (%lu MB) at $%lx\n",
 		 board_size / MB_, board_addr);
 
 	zorro_set_drvdata(z, info);
-- 
1.5.2.2


----------------------------------------------------------------------
Dzien Kobiet dniem wolnym od pracy? Wypowiedz sie i wygraj nagrode! 
Sprawdz >> http://link.interia.pl/f2076 


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
