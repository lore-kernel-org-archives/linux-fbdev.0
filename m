From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/6] fbdev: edid.h cleanups
Date: Sat, 16 Apr 2005 13:16:01 +0800
Message-ID: <200504161316.01130.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMfr9-0002Aw-Or
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 22:28:35 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DMfr8-0008BA-6q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 22:28:35 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id DC3511065895
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Apr 2005 05:28:23 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Adrian Bunk <bunk@stusta.de>

  This patch removes some completely unused code.

From: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/i386/boot/compressed/misc.c |    1 -
 drivers/video/fbmon.c            |    1 -
 drivers/video/vesafb.c           |    3 ---
 include/video/edid.h             |    9 ---------
 4 files changed, 14 deletions(-)

diff -Nru a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
--- a/arch/i386/boot/compressed/misc.c	2005-04-14 12:06:31 +08:00
+++ b/arch/i386/boot/compressed/misc.c	2005-03-21 03:05:58 +08:00
@@ -12,7 +12,6 @@
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
-#include <video/edid.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
diff -Nru a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c	2005-03-22 05:48:51 +08:00
+++ b/drivers/video/fbmon.c	2005-03-21 03:04:27 +08:00
@@ -34,7 +34,6 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #endif
-#include <video/edid.h>
 #include "edid.h"
 
 /* 
diff -Nru a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c	2005-03-12 23:23:40 +08:00
+++ b/drivers/video/vesafb.c	2005-03-21 03:04:18 +08:00
@@ -19,9 +19,6 @@
 #include <linux/fb.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
-#ifdef __i386__
-#include <video/edid.h>
-#endif
 #include <asm/io.h>
 #include <asm/mtrr.h>
 
diff -Nru a/include/video/edid.h b/include/video/edid.h
--- a/include/video/edid.h	2005-03-13 00:57:14 +08:00
+++ b/include/video/edid.h	2005-03-24 08:37:27 +08:00
@@ -4,9 +4,6 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
-#ifdef CONFIG_PPC_OF
-#include <linux/pci.h>
-#endif
 
 #ifdef CONFIG_X86
 struct edid_info {
@@ -14,13 +11,7 @@
 };
 
 extern struct edid_info edid_info;
-extern char *get_EDID_from_BIOS(void *);
-
 #endif /* CONFIG_X86 */
-
-#ifdef CONFIG_PPC_OF
-extern char *get_EDID_from_OF(struct pci_dev *pdev);
-#endif
 
 #endif /* __KERNEL__ */
 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
