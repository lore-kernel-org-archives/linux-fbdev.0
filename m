From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 13/15] fbdev: Add __iomem annotations to vfb
Date: Fri, 29 Oct 2004 09:58:54 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.54861.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM3F-0006Af-8k
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:37 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM3E-0001bc-FW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:37 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9DA6394CE6F
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:59:24 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add __iomem annotations to vfb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 vfb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/drivers/video/vfb.c b/drivers/video/vfb.c
--- a/drivers/video/vfb.c	2004-10-27 14:58:08 +08:00
+++ b/drivers/video/vfb.c	2004-10-28 23:43:08 +08:00
@@ -430,7 +430,7 @@
 	if (!info)
 		goto err;
 
-	info->screen_base = videomemory;
+	info->screen_base = (char __iomem *)videomemory;
 	info->fbops = &vfb_ops;
 
 	retval = fb_find_mode(&info->var, info, NULL,




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
