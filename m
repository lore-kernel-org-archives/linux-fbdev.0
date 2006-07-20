From: dmunsie@cecropia.com (Dennis Munsie)
Subject: [PATCH 2.6.18-rc2] intelfb: cleanup constant
	usage
Date: Thu, 20 Jul 2006 12:54:18 -0400 (EDT)
Message-ID: <20060720165418.686CD118E7E@xenon>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G3blR-0002JR-E4 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Jul 2006 09:52:41 -0700
Received: from mail1.sea5.speakeasy.net ([69.17.117.3])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G3blR-0007hP-5O
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Jul 2006 09:52:41 -0700
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
Cc: ehustvedt@cecropia.com, airlied@skynet.ie

From: Dennis Munsie <dmunsie@cecropia.com>

Uses the correct constants for shifting in the intelfb driver.  Since the
constants are the same value, this patch is only for consistency purposes.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

 drivers/video/intelfb/intelfbhw.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -Naurp -X linux-2.6.18-rc2-patched/Documentation/dontdiff linux-2.6.18-rc2-patched/drivers/video/intelfb/intelfbhw.c linux-2.6.18-rc2-cleanup/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.18-rc2-patched/drivers/video/intelfb/intelfbhw.c	2006-07-17 02:37:38.000000000 -0500
+++ linux-2.6.18-rc2-cleanup/drivers/video/intelfb/intelfbhw.c	2006-07-18 04:53:55.000000000 -0500
@@ -1187,12 +1187,12 @@ intelfbhw_mode_to_hw(struct intelfb_info
 
 	*ht = (htotal << HTOTAL_SHIFT) | (hactive << HACTIVE_SHIFT);
 	*hb = (hblank_start << HBLANKSTART_SHIFT) |
-	      (hblank_end << HSYNCEND_SHIFT);
+	      (hblank_end << HBLANKEND_SHIFT);
 	*hs = (hsync_start << HSYNCSTART_SHIFT) | (hsync_end << HSYNCEND_SHIFT);
 
 	*vt = (vtotal << VTOTAL_SHIFT) | (vactive << VACTIVE_SHIFT);
 	*vb = (vblank_start << VBLANKSTART_SHIFT) |
-	      (vblank_end << VSYNCEND_SHIFT);
+	      (vblank_end << VBLANKEND_SHIFT);
 	*vs = (vsync_start << VSYNCSTART_SHIFT) | (vsync_end << VSYNCEND_SHIFT);
 	*ss = (hactive << SRC_SIZE_HORIZ_SHIFT) |
 	      (vactive << SRC_SIZE_VERT_SHIFT);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
