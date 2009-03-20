From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cirrusfb: fix compilation for Amiga
Date: Fri, 20 Mar 2009 06:58:31 +0100
Message-ID: <20090320065831.bf6af5c1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LkXkB-0002N3-Qi
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Mar 2009 05:58:11 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LkXk2-0004v7-9p for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 20 Mar 2009 05:58:11 +0000
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

Fix compilation for Amiga.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 6717b49..4c61504 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -2304,8 +2304,9 @@ static int __devinit cirrusfb_zorro_register(struct zorro_dev *z,
 	zorro_set_drvdata(z, info);
 
 	/* MCLK select etc. */
-	if (bi->init_sr1f)
-		vga_wseq(cinfo->regbase, CL_SEQR1F, bi->sr1f);
+	if (cirrusfb_board_info[btype].init_sr1f)
+		vga_wseq(cinfo->regbase, CL_SEQR1F,
+			 cirrusfb_board_info[btype].sr1f);
 
 	ret = cirrusfb_register(info);
 	if (!ret)
-- 
1.5.2.2



----------------------------------------------------------------------
Doklej politykowi dymek!
Tylko dla ludzi z poczuciem humoru >>> http://link.interia.pl/f20aa


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
