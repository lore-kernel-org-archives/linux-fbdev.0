From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/11] fbdev: Fbmon cleanup
Date: Thu, 13 Jan 2005 21:01:32 +0800
Message-ID: <20050113214624.EACCA1A00A1@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCnl-00014X-Rc
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:46:45 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CpCnh-000058-VU
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:46:45 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8CB471340D01
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Jan 2005 21:46:27 +0000 (UTC)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jean Delvare <khali@linux-fr.org>

While browsing the video/fbcon.c source file (Linux 2.6.10-rc3) I found
some possible cleanups. Patch follows, feel free to apply all or parts
of it if it looks OK to you.

Remove unnecessary bit operations.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbmon.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff -Nru a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c	2005-01-13 20:12:49 +08:00
+++ b/drivers/video/fbmon.c	2005-01-13 06:00:15 +08:00
@@ -662,7 +662,7 @@
 
 	fb_get_monitor_limits(edid, specs);
 
-	c = (block[0] & 0x80) >> 7;
+	c = block[0] & 0x80;
 	specs->input = 0;
 	if (c) {
 		specs->input |= FB_DISP_DDI;
@@ -686,13 +686,10 @@
 			DPRINTK("0.700V/0.000V");
 			specs->input |= FB_DISP_ANA_700_000;
 			break;
-		default:
-			DPRINTK("unknown");
-			specs->input |= FB_DISP_UNKNOWN;
 		}
 	}
 	DPRINTK("\n      Sync: ");
-	c = (block[0] & 0x10) >> 4;
+	c = block[0] & 0x10;
 	if (c)
 		DPRINTK("      Configurable signal level\n");
 	c = block[0] & 0x0f;




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
