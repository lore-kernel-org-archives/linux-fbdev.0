From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] atyfb: speed up Mach64 cursor
Date: Tue, 17 Mar 2009 22:04:43 +0100
Message-ID: <20090317220443.d8dd67bb.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LjgN4-0006PZ-BW
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Mar 2009 20:58:46 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LjgMi-0007CO-Fo for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Mar 2009 20:58:33 +0000
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

Save one fifo entry on cursor
enabling and disabling.

Save another fifo entry for
FB_CUR_SETPOS operation
by removing redundant one.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/aty/mach64_cursor.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/video/aty/mach64_cursor.c b/drivers/video/aty/mach64_cursor.c
index faf95da..2eb3926 100644
--- a/drivers/video/aty/mach64_cursor.c
+++ b/drivers/video/aty/mach64_cursor.c
@@ -77,9 +77,13 @@ static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	if (par->asleep)
 		return -EPERM;
 
-	/* Hide cursor */
 	wait_for_fifo(1, par);
-	aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par) & ~HWCURSOR_ENABLE, par);
+	if (cursor->enable)
+		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
+			    | HWCURSOR_ENABLE, par);
+	else 
+		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
+				& ~HWCURSOR_ENABLE, par);
 
 	/* set position */
 	if (cursor->set & FB_CUR_SETPOS) {
@@ -109,7 +113,7 @@ static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 			y<<=1;
 			h<<=1;
 		}
-		wait_for_fifo(4, par);
+		wait_for_fifo(3, par);
 		aty_st_le32(CUR_OFFSET, (info->fix.smem_len >> 3) + (yoff << 1), par);
 		aty_st_le32(CUR_HORZ_VERT_OFF,
 			    ((u32) (64 - h + yoff) << 16) | xoff, par);
@@ -177,11 +181,6 @@ static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	    }
 	}
 
-	if (cursor->enable) {
-		wait_for_fifo(1, par);
-		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
-			    | HWCURSOR_ENABLE, par);
-	}
 	return 0;
 }
 
-- 
1.5.2.2


----------------------------------------------------------------------
Dzwon taniej na zagraniczne komorki!
Sprawdz >>  http://link.interia.pl/f20a2 


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
