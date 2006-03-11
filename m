From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/18] kyrofb: Fix uninitialized value
Date: Sat, 11 Mar 2006 09:49:26 +0800
Message-ID: <44122CA6.1080604@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHtTj-0003EW-Kw
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:05:11 -0800
Received: from pproxy.gmail.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtTf-0006zQ-JB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:05:10 -0800
Received: by pproxy.gmail.com with SMTP id z59so420253pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 18:05:02 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Paul Mundt <lethal@linux-sh.org>

Initialize Variable 'count' in DisableVGA to zero.

Coverity Bug 874

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/kyro/STG4000VTG.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/kyro/STG4000VTG.c b/drivers/video/kyro/STG4000VTG.c
index 3690b04..bd38970 100644
--- a/drivers/video/kyro/STG4000VTG.c
+++ b/drivers/video/kyro/STG4000VTG.c
@@ -17,7 +17,7 @@
 void DisableVGA(volatile STG4000REG __iomem *pSTGReg)
 {
 	u32 tmp;
-	volatile u32 count, i;
+	volatile u32 count = 0, i;
 
 	/* Reset the VGA registers */
 	tmp = STG_READ_REG(SoftwareReset);




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
