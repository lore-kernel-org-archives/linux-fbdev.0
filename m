From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] fb: sm501fb off-by-1 sysfs store
Date: Thu, 1 Mar 2007 17:24:56 +0900
Message-ID: <20070301082456.GA3701@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMgdO-0007Gc-K6 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 00:27:30 -0800
Received: from smtp.ocgnet.org ([64.20.243.3])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMgdN-0006lo-8J
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 00:27:30 -0800
Content-Disposition: inline
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
To: Ben Dooks <ben@fluff.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Currently sm501fb_crtsrc_store() won't allow the routing to be changed
via echos from userspace in to the sysfs file. The reason for this is
that the strnicmp() for both heads uses a sizeof() for the string length,
which ends up being strlen() + 1 (\0 in the normal case, but the echo
gives a newline, which is where the issue occurs), this then causes a
mismatch and subsequently bails with the -EINVAL.

In addition to this, the hardcoded lengths were then used for the store
length that was returned, which ended up being erroneous and resulting in
a write error. There's also no point in returning anything but the full
length since it will -EINVAL out on a mismatch well before then anyways.

sizeof("string") is great for making sure you have space in your buffer,
but rather less so for string comparisons :-)

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 drivers/video/sm501fb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index 02b290c..72b5358 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -1074,9 +1074,9 @@ static ssize_t sm501fb_crtsrc_store(struct device *dev,
 	if (len < 1)
 		return -EINVAL;
 
-	if (strnicmp(buf, "crt", sizeof("crt")) == 0)
+	if (strnicmp(buf, "crt", 3) == 0)
 		head = HEAD_CRT;
-	else if (strnicmp(buf, "panel", sizeof("panel")) == 0)
+	else if (strnicmp(buf, "panel", 5) == 0)
 		head = HEAD_PANEL;
 	else
 		return -EINVAL;
@@ -1098,7 +1098,7 @@ static ssize_t sm501fb_crtsrc_store(struct device *dev,
 	writel(ctrl, info->regs + SM501_DC_CRT_CONTROL);
 	sm501fb_sync_regs(info);
 
-	return (head == HEAD_CRT) ? 3 : 5;
+	return len;
 }
 
 /* Prepare the device_attr for registration with sysfs later */

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
