From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 7/15] fbdev: Add __iomem annotations to tdfxfb
Date: Fri, 29 Oct 2004 09:58:33 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.33221.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM2m-00064U-Qv
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:08 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM2l-0001Sq-U8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:08 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 346E094628D
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:59:01 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Hannu Mallat <hmallat@cc.hut.fi>

Add __iomem annotations to tdfxfb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 tdfx.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/include/video/tdfx.h b/include/video/tdfx.h
--- a/include/video/tdfx.h	2004-10-19 22:45:05 +08:00
+++ b/include/video/tdfx.h	2004-10-28 22:43:22 +08:00
@@ -173,7 +173,7 @@
 struct tdfx_par {
   u32 max_pixclock;
 
-  void *regbase_virt;
+  void __iomem *regbase_virt;
   unsigned long iobase;
   u32 baseline;
 




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
