From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/15] fbdev: Convert MODULE_PARM to module_param in neofb
Date: Fri, 29 Oct 2004 09:58:20 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.20606.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM2J-0005wD-6x
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:58:39 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM2I-0001Nj-L6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:58:39 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id CB15D1176F00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:58:25 +0000 (UTC)
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
Cc: Denis Oliver Kropp <dok@directfb.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Convert MODULE_PARM to module_param in neofb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 neofb.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	2004-10-19 20:21:57 +08:00
+++ b/drivers/video/neofb.c	2004-10-28 21:01:11 +08:00
@@ -100,18 +100,18 @@
 MODULE_AUTHOR("(c) 2001-2002  Denis Oliver Kropp <dok@convergence.de>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FBDev driver for NeoMagic PCI Chips");
-MODULE_PARM(internal, "i");
+module_param(internal, bool, 0);
 MODULE_PARM_DESC(internal, "Enable output on internal LCD Display.");
-MODULE_PARM(external, "i");
+module_param(external, bool, 0);
 MODULE_PARM_DESC(external, "Enable output on external CRT.");
-MODULE_PARM(libretto, "i");
+module_param(libretto, bool, 0);
 MODULE_PARM_DESC(libretto, "Force Libretto 100/110 800x480 LCD.");
-MODULE_PARM(nostretch, "i");
+module_param(nostretch, bool, 0);
 MODULE_PARM_DESC(nostretch,
 		 "Disable stretching of modes smaller than LCD.");
-MODULE_PARM(nopciburst, "i");
+module_param(nopciburst, bool, 0);
 MODULE_PARM_DESC(nopciburst, "Disable PCI burst mode.");
-MODULE_PARM(mode_option, "s");
+module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Preferred video mode ('640x480-8@60', etc)");
 
 #endif




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
