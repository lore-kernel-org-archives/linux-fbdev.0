From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 8/15] fbdev: Do not memset the framebuffer memory in asiliantfb
Date: Fri, 29 Oct 2004 09:58:39 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.39751.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM2t-00065t-Fu
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:15 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM2q-0001UU-Ov
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:15 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 04494922DCE
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:59:06 +0000 (UTC)
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

Do not memset the framebuffer memory in asiliantfb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 asiliantfb.c |    3 ---
 1 files changed, 3 deletions(-)

diff -Nru a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
--- a/drivers/video/asiliantfb.c	2004-10-19 20:21:16 +08:00
+++ b/drivers/video/asiliantfb.c	2004-10-28 22:56:44 +08:00
@@ -575,9 +575,6 @@
 
 	init_asiliant(p, addr);
 
-	/* Clear the entire framebuffer */
-	memset(p->screen_base, 0, 0x200000);
-
 	pci_set_drvdata(dp, p);
 	return 0;
 }




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
