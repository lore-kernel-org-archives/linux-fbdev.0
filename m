From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 9/15] fbdev: Add __iomem annotations to cyber2000fb
Date: Fri, 29 Oct 2004 09:58:43 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.43035.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM4p-0006YF-Pv
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 19:01:15 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM4n-0001tK-Jw
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 19:01:15 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 840CF75230
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:59:09 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Russell King <rmk@arm.linux.org.uk>

Add __iomem annotations to cyber2000fb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 cyber2000fb.c |    4 ++--
 cyber2000fb.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -Nru a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
--- a/drivers/video/cyber2000fb.c	2004-10-27 14:58:07 +08:00
+++ b/drivers/video/cyber2000fb.c	2004-10-28 22:57:58 +08:00
@@ -66,8 +66,8 @@
 	struct display_switch	*dispsw;
 	struct display		*display;
 	struct pci_dev		*dev;
-	unsigned char 		*region;
-	unsigned char		*regs;
+	unsigned char 		__iomem *region;
+	unsigned char		__iomem *regs;
 	u_int			id;
 	int			func_use_count;
 	u_long			ref_ps;
diff -Nru a/drivers/video/cyber2000fb.h b/drivers/video/cyber2000fb.h
--- a/drivers/video/cyber2000fb.h	2004-10-19 20:21:33 +08:00
+++ b/drivers/video/cyber2000fb.h	2004-10-28 22:57:58 +08:00
@@ -466,8 +466,8 @@
 
 struct cyberpro_info {
 	struct pci_dev	*dev;
-	unsigned char	*regs;
-	char		*fb;
+	unsigned char	__iomem *regs;
+	char		__iomem *fb;
 	char		dev_name[32];
 	unsigned int	fb_size;
 	unsigned int	chip_id;




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
