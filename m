From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 4/4] cirrusfb: fix error paths in
	cirrusfb_xxx_register()
Date: Tue, 24 Feb 2009 22:37:02 +0100
Message-ID: <20090224223702.86f7e129.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Lc6mr-0003hi-Mi
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Feb 2009 23:34:07 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lc6mn-0002s9-HF for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Feb 2009 23:34:05 +0000
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

Balance iomap and iounmap and alloc and free
calls in case of error druing device register
(probing).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
It is not an end to cirrusfb patches unfortunately.
I have just got a GD5446 (Picasso4) and it locks up 
my computer when the cirrusfb module is loaded.
Time to fix this model as well... 

 drivers/video/cirrusfb.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 8e39637..b96bc5d 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -2090,8 +2090,6 @@ static int __devinit cirrusfb_register(struct fb_info *info)
 
 err_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
-	cinfo->unmap(info);
-	framebuffer_release(info);
 	return err;
 }
 
@@ -2328,18 +2326,15 @@ static int __devinit cirrusfb_zorro_register(struct zorro_dev *z,
 	zorro_set_drvdata(z, info);
 
 	ret = cirrusfb_register(info);
-	if (ret) {
-		if (btype == BT_PICASSO4) {
-			iounmap(info->screen_base);
-			iounmap(cinfo->regbase - 0x600000);
-		} else if (board_addr > 0x01000000)
-			iounmap(info->screen_base);
-	}
-	return ret;
+	if (!ret)
+		return 0
+
+	if (btype == BT_PICASSO4 || board_addr > 0x01000000)
+		iounmap(info->screen_base);
 
 err_unmap_regbase:
-	/* Parental advisory: explicit hack */
-	iounmap(cinfo->regbase - 0x600000);
+	if (btype == BT_PICASSO4)
+		iounmap(cinfo->regbase - 0x600000);
 err_release_region:
 	release_region(board_addr, board_size);
 err_release_fb:
-- 
1.5.2.2



----------------------------------------------------------------------
169 stacji TV! Naziemne i satelitarne!
Sprawdz program TV w kilka sekund >> http://link.interia.pl/f2050


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
