From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/15] fbdev: Remove module parameter 'disabled' from savagefb
Date: Fri, 29 Oct 2004 09:58:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.10338.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM27-0005uk-NM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:58:27 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM26-0001Li-S8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:58:27 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id F0BB88B0947
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:58:18 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Denis Oliver Kropp <dok@directfb.org>, Mika Pruikkonen <mpruikko@cc.hut.fi>, Sven Neumann <neo@convergence.de>

Remove module parameter 'disabled' from savagefb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 savagefb.c |    2 --
 1 files changed, 2 deletions(-)

diff -Nru a/drivers/video/savage/savagefb.c b/drivers/video/savage/savagefb.c
--- a/drivers/video/savage/savagefb.c	2004-10-28 09:07:26 +08:00
+++ b/drivers/video/savage/savagefb.c	2004-10-28 20:46:17 +08:00
@@ -81,8 +81,6 @@
 MODULE_AUTHOR("(c) 2001-2002  Denis Oliver Kropp <dok@directfb.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FBDev driver for S3 Savage PCI/AGP Chips");
-MODULE_PARM(disabled, "i");
-MODULE_PARM_DESC(disabled, "Disable this driver's initialization.");
 
 #endif
 




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
