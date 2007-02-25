From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH RESEND 2/9] intelfb: Fix ring space
	calculation
Date: Sun, 25 Feb 2007 18:15:23 +0800
Message-ID: <45E161BB.1050403@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLGao-000667-QL for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 02:26:58 -0800
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLGao-00021L-Fs
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 02:26:58 -0800
Received: by py-out-1112.google.com with SMTP id a29so536398pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Feb 2007 02:26:57 -0800 (PST)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>, Juergen Orczykowski <juergen.orczykowski@siemens.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Orczykowski, Juergen <juergen.orczykowski@siemens.com>

If there is less then RING_MIN_FREE available in the ring buffer,
dinfo->ring_space is set to a big value forcing wait_ring to return.

Fix by making ring space = 0 if ring space < RING_MIN_FREE.

Signed-off-by: Dave Airlie <airlied@gmail.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/intelfb/intelfbhw.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/intelfbhw.c
index c1eb18b..16bc8d7 100644
--- a/drivers/video/intelfb/intelfbhw.c
+++ b/drivers/video/intelfb/intelfbhw.c
@@ -1428,6 +1428,24 @@ static void refresh_ring(struct intelfb_
 static void reset_state(struct intelfb_info *dinfo);
 static void do_flush(struct intelfb_info *dinfo);
 
+static  u32 get_ring_space(struct intelfb_info *dinfo)
+{
+	u32 ring_space;
+
+	if (dinfo->ring_tail >= dinfo->ring_head)
+		ring_space = dinfo->ring.size -
+			(dinfo->ring_tail - dinfo->ring_head);
+	else
+		ring_space = dinfo->ring_head - dinfo->ring_tail;
+
+	if (ring_space > RING_MIN_FREE)
+		ring_space -= RING_MIN_FREE;
+	else
+		ring_space = 0;
+
+	return ring_space;
+}
+
 static int
 wait_ring(struct intelfb_info *dinfo, int n)
 {
@@ -1442,13 +1460,8 @@ #endif
 	end = jiffies + (HZ * 3);
 	while (dinfo->ring_space < n) {
 		dinfo->ring_head = INREG(PRI_RING_HEAD) & RING_HEAD_MASK;
-		if (dinfo->ring_tail + RING_MIN_FREE < dinfo->ring_head)
-			dinfo->ring_space = dinfo->ring_head
-				- (dinfo->ring_tail + RING_MIN_FREE);
-		else
-			dinfo->ring_space = (dinfo->ring.size +
-					     dinfo->ring_head)
-				- (dinfo->ring_tail + RING_MIN_FREE);
+		dinfo->ring_space = get_ring_space(dinfo);
+
 		if (dinfo->ring_head != last_head) {
 			end = jiffies + (HZ * 3);
 			last_head = dinfo->ring_head;
@@ -1513,12 +1526,7 @@ #endif
 
 	dinfo->ring_head = INREG(PRI_RING_HEAD) & RING_HEAD_MASK;
 	dinfo->ring_tail = INREG(PRI_RING_TAIL) & RING_TAIL_MASK;
-	if (dinfo->ring_tail + RING_MIN_FREE < dinfo->ring_head)
-		dinfo->ring_space = dinfo->ring_head
-			- (dinfo->ring_tail + RING_MIN_FREE);
-	else
-		dinfo->ring_space = (dinfo->ring.size + dinfo->ring_head)
-			- (dinfo->ring_tail + RING_MIN_FREE);
+	dinfo->ring_space = get_ring_space(dinfo);
 }
 
 static void




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
