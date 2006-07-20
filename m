From: dmunsie@cecropia.com (Dennis Munsie)
Subject: [PATCH 2.6.18-rc2] intelfb: fix vblank_end
	calculation
Date: Thu, 20 Jul 2006 12:24:49 -0400 (EDT)
Message-ID: <20060720162449.061B6118E23@xenon>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G3bIu-00088F-WB for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Jul 2006 09:23:13 -0700
Received: from mail4.sea5.speakeasy.net ([69.17.117.6])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G3bIs-0008Gv-IO
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Jul 2006 09:23:12 -0700
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

Removes bad vblank_end calculation in favor of the correct one on the line 
above.  This makes the vblank_end now include both the upper and lower margin,
and the vsync.  Before, the upper margin was not being included which caused 
problems with DVI monitors.  This patch shouldn't affect analog monitors,
but vertical adjustments may need to be made.

This now brings the vblank_end value to be consistent with what the BIOS is
setting when using VBE calls.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

 drivers/video/intelfb/intelfbhw.c |    1 -
 1 file changed, 1 deletion(-)

diff -Naurp -X linux-2.6.18-rc2-patched/Documentation/dontdiff linux-2.6.18-rc2-patched/drivers/video/intelfb/intelfbhw.c linux-2.6.18-rc2-debugging/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.18-rc2-patched/drivers/video/intelfb/intelfbhw.c	2006-07-18 05:15:21.000000000 -0500
+++ linux-2.6.18-rc2-debugging/drivers/video/intelfb/intelfbhw.c	2006-07-20 03:39:52.000000000 -0500
@@ -1140,7 +1140,6 @@ intelfbhw_mode_to_hw(struct intelfb_info
 	vtotal = vsync_end + var->upper_margin;
 	vblank_start = vactive;
 	vblank_end = vtotal;
-	vblank_end = vsync_end + 1;
 
 	DBG_MSG("V: act %d, ss %d, se %d, tot %d bs %d, be %d\n",
 		vactive, vsync_start, vsync_end, vtotal, vblank_start,

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
