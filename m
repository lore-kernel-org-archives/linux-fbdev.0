From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 15/15] fbdev: Maintainership
Date: Fri, 29 Oct 2004 09:59:00 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290959.00049.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM3f-0006Gi-HQ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 19:00:03 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM3d-0001gf-CP
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 19:00:03 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 652AC8F1B75
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:59:53 +0000 (UTC)
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

Accepted Geert's offer to maintain the framebuffer layer.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 MAINTAINERS |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2004-10-27 14:58:19 +08:00
+++ b/MAINTAINERS	2004-10-24 18:34:47 +08:00
@@ -818,11 +818,11 @@
 S:	Supported
 
 FRAMEBUFFER LAYER
-P:	James Simmons, Geert Uytterhoeven	
-M:	jsimmons@infradead.org, geert@linux-m68k.org	
+P:	Antonino Daplas
+M:	adaplas@pol.net
 L:	linux-fbdev-devel@lists.sourceforge.net	
 W:	http://linux-fbdev.sourceforge.net/
-S:	Supported
+S:	Maintained
 
 FILE LOCKING (flock() and fcntl()/lockf())
 P:	Matthew Wilcox




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
