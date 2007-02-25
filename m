From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/9] intelfb: Fix ring space calculation
Date: Sun, 25 Feb 2007 16:50:56 +0800
Message-ID: <1172393456.16179.30.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0737783515=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLFOr-00075A-HZ for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 01:10:33 -0800
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLFOr-0005hh-1o
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 01:10:33 -0800
Received: by py-out-1112.google.com with SMTP id a29so528629pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Feb 2007 01:10:32 -0800 (PST)
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
Cc: Dave Airlie <airlied@gmail.com>, "Orczykowski,  Juergen" <juergen.orczykowski@siemens.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--===============0737783515==
Content-Type: multipart/alternative; boundary="=-g1C5QBdqT/tZm2O+IaHT"


--=-g1C5QBdqT/tZm2O+IaHT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

From: Orczykowski, Juergen <juergen.orczykowski@siemens.com>

If there is less then RING_MIN_FREE available in the ring buffer,
dinfo->ring_space is set to a big value forcing wait_ring to return.

Fix by making ring space = 0 if ring space < RING_MIN_FREE.

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


--=-g1C5QBdqT/tZm2O+IaHT
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.2">
</HEAD>
<BODY>
<PRE>
<!--+GtkHTML:<DATA class="ClueFlow" key="orig" value="0">-->From: Orczykowski, Juergen &lt;<A HREF="mailto:juergen.orczykowski@siemens.com">juergen.orczykowski@siemens.com</A>&gt;

If there is less then RING_MIN_FREE available in the ring buffer,
dinfo-&gt;ring_space is set to a big value forcing wait_ring to return.

Fix by making ring space = 0 if ring space &lt; RING_MIN_FREE.

Signed-off-by: Antonino Daplas &lt;<A HREF="mailto:adaplas@gmail.com">adaplas@gmail.com</A>&gt;
---

 drivers/video/intelfb/intelfbhw.c |&nbsp;&nbsp; 34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/intelfbhw.c
index c1eb18b..16bc8d7 100644
--- a/drivers/video/intelfb/intelfbhw.c
+++ b/drivers/video/intelfb/intelfbhw.c
@@ -1428,6 +1428,24 @@ static void refresh_ring(struct intelfb_
 static void reset_state(struct intelfb_info *dinfo);
 static void do_flush(struct intelfb_info *dinfo);
 
+static&nbsp; u32 get_ring_space(struct intelfb_info *dinfo)
+{
+	u32 ring_space;
+
+	if (dinfo-&gt;ring_tail &gt;= dinfo-&gt;ring_head)
+		ring_space = dinfo-&gt;ring.size -
+			(dinfo-&gt;ring_tail - dinfo-&gt;ring_head);
+	else
+		ring_space = dinfo-&gt;ring_head - dinfo-&gt;ring_tail;
+
+	if (ring_space &gt; RING_MIN_FREE)
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
 	while (dinfo-&gt;ring_space &lt; n) {
 		dinfo-&gt;ring_head = INREG(PRI_RING_HEAD) &amp; RING_HEAD_MASK;
-		if (dinfo-&gt;ring_tail + RING_MIN_FREE &lt; dinfo-&gt;ring_head)
-			dinfo-&gt;ring_space = dinfo-&gt;ring_head
-				- (dinfo-&gt;ring_tail + RING_MIN_FREE);
-		else
-			dinfo-&gt;ring_space = (dinfo-&gt;ring.size +
-					&nbsp;&nbsp;&nbsp;&nbsp; dinfo-&gt;ring_head)
-				- (dinfo-&gt;ring_tail + RING_MIN_FREE);
+		dinfo-&gt;ring_space = get_ring_space(dinfo);
+
 		if (dinfo-&gt;ring_head != last_head) {
 			end = jiffies + (HZ * 3);
 			last_head = dinfo-&gt;ring_head;
@@ -1513,12 +1526,7 @@ #endif
 
 	dinfo-&gt;ring_head = INREG(PRI_RING_HEAD) &amp; RING_HEAD_MASK;
 	dinfo-&gt;ring_tail = INREG(PRI_RING_TAIL) &amp; RING_TAIL_MASK;
-	if (dinfo-&gt;ring_tail + RING_MIN_FREE &lt; dinfo-&gt;ring_head)
-		dinfo-&gt;ring_space = dinfo-&gt;ring_head
-			- (dinfo-&gt;ring_tail + RING_MIN_FREE);
-	else
-		dinfo-&gt;ring_space = (dinfo-&gt;ring.size + dinfo-&gt;ring_head)
-			- (dinfo-&gt;ring_tail + RING_MIN_FREE);
+	dinfo-&gt;ring_space = get_ring_space(dinfo);
 }
 
 static void

</PRE>
</BODY>
</HTML>

--=-g1C5QBdqT/tZm2O+IaHT--



--===============0737783515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0737783515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0737783515==--
