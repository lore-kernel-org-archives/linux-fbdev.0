From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH] radeonfb: 16bpp copyarea() fixed!
Date: Tue, 29 Jun 2004 05:36:00 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040629093559.GA22557@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfF2t-0000v6-6f
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 02:36:55 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BfF2s-0003xd-SQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 02:36:55 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net, Jurriaan <thunder7@xs4all.nl>

Dear Andrew,

It turns out the bug was due to my mis-copying a certain set of 
flags from the x.org tree.  The fix is as follows.  Thanks for not
accepting an ugly work around :-)  Please see that this gets to 
mainline.

-dte

radeonfb: fix 16bpp copyarea() bug

Signed-off-by: David Eger <eger@havoc.gtf.org>

diff -Nru a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
--- a/drivers/video/aty/radeon_accel.c	2004-06-29 11:21:26 +02:00
+++ b/drivers/video/aty/radeon_accel.c	2004-06-29 11:21:26 +02:00
@@ -71,9 +71,10 @@
 	radeon_fifo_wait(3);
 	OUTREG(DP_GUI_MASTER_CNTL,
 		rinfo->dp_gui_master_cntl /* i.e. GMC_DST_32BPP */
+		| GMC_BRUSH_NONE
 		| GMC_SRC_DSTCOLOR
 		| ROP3_S 
-		| DP_SRC_RECT );
+		| DP_SRC_SOURCE_MEMORY );
 	OUTREG(DP_WRITE_MSK, 0xffffffff);
 	OUTREG(DP_CNTL, (xdir>=0 ? DST_X_LEFT_TO_RIGHT : 0)
 			| (ydir>=0 ? DST_Y_TOP_TO_BOTTOM : 0));


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
