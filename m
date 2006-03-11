From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/18] neofb: Fix uninitialized value
Date: Sat, 11 Mar 2006 09:49:05 +0800
Message-ID: <44122C91.8050107@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHtN8-0002V0-TG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:58:22 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtN6-0003lQ-Q7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:58:22 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:58:11 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Denis Oliver Kropp <dok@directfb.org>

Remove insignificant and unitialized variable "waitcycles"
from neo2200_sync.

Coverity Bug 895

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/neofb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index a2e201d..b961d56 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -486,10 +486,8 @@ static void vgaHWRestore(const struct fb
 static inline int neo2200_sync(struct fb_info *info)
 {
 	struct neofb_par *par = info->par;
-	int waitcycles;
 
-	while (readl(&par->neo2200->bltStat) & 1)
-		waitcycles++;
+	while (readl(&par->neo2200->bltStat) & 1);
 	return 0;
 }
 





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
