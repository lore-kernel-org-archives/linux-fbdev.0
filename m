From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: bug in intelfbhw.c
Date: Thu, 22 Feb 2007 17:27:58 +0800
Message-ID: <1172136478.4086.19.camel@daplas>
References: <3E56BFF2E134A44A98D9FFDB710688DF011D3DF7@ERLD151A.ww004.siemens.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xDEzhBQxNEOnZdgM8goU"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKACN-0007ac-7r for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 01:25:11 -0800
Received: from nz-out-0506.google.com ([64.233.162.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKACM-0002Rg-TY
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 01:25:11 -0800
Received: by nz-out-0506.google.com with SMTP id i11so164489nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Feb 2007 01:25:10 -0800 (PST)
In-Reply-To: <3E56BFF2E134A44A98D9FFDB710688DF011D3DF7@ERLD151A.ww004.siemens.net>
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
Cc: "Orczykowski, Juergen" <juergen.orczykowski@siemens.com>, Dave Airlie <airlied@gmail.com>


--=-xDEzhBQxNEOnZdgM8goU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-02-22 at 09:14 +0100, Orczykowski, Juergen wrote:
> Hello,
> 
> we would like to use your drivers in our software. While debugging we
> found a bug in calculating the ring_space.
> 
> If there is less then RING_MIN_FREE available in the ring buffer,
> dinfo->ring_space is set to a big value forcing wait_ring to return.
> 
> We have attached a possible solution to solve this bug.
> 

Dave,

I created a patch based on the source.  I don't have the hardware so do
you want to look at this?

Tony

--=-xDEzhBQxNEOnZdgM8goU
Content-Disposition: attachment; filename=intelfb_fix_ring_space_bug
Content-Type: text/plain; name=intelfb_fix_ring_space_bug; charset=UTF-8
Content-Transfer-Encoding: 7bit

intelfb: Fix ring space calculation

From: Orczykowski, Juergen <juergen.orczykowski@siemens.com>

If there is less then RING_MIN_FREE available in the ring buffer,
dinfo->ring_space is set to a big value forcing wait_ring to return.

Fix by making ring space = 0 if ring space < RING_MIN_FREE.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/intelfb/intelfbhw.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/intelfbhw.c
index c1eb18b..05d07c1 100644
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

--=-xDEzhBQxNEOnZdgM8goU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-xDEzhBQxNEOnZdgM8goU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--=-xDEzhBQxNEOnZdgM8goU--
