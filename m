From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] edid.h cleanups
Date: Thu, 24 Mar 2005 04:10:19 +0100
Message-ID: <20050324031019.GU1948@stusta.de>
References: <20050320192915.GR4449@stusta.de> <200503210453.43894.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DEIkc-000301-TY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Mar 2005 19:11:14 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DEIkc-0000R4-5R
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Mar 2005 19:11:14 -0800
Content-Disposition: inline
In-Reply-To: <200503210453.43894.adaplas@hotpop.com>
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 04:53:43AM +0800, Antonino A. Daplas wrote:

> Not this one.  Code that grabs the EDID block using the video BIOS is in video.S.
> Currently, there's no driver that uses this but it's an acceptable backup for drivers
> that want the EDID block but has no i2c, or i2c probing fails.

OK, below are only the other parts of my patch.

> Tony

cu
Adrian



<--  snip  -->


This patch contains the following cleanups:
- remove unneeded #include <video/edid.h>'s
- include/video/edid.h: kill two stale function prototypes

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/boot/compressed/misc.c |    1 -
 drivers/video/fbmon.c            |    1 -
 drivers/video/vesafb.c           |    3 ---
 include/video/edid.h             |    9 ---------
 4 files changed, 14 deletions(-)

--- linux-2.6.11-mm4-full/drivers/video/fbmon.c.old	2005-03-20 20:03:56.000000000 +0100
+++ linux-2.6.11-mm4-full/drivers/video/fbmon.c	2005-03-20 20:04:27.000000000 +0100
@@ -34,7 +34,6 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #endif
-#include <video/edid.h>
 #include "edid.h"
 
 /* 
--- linux-2.6.11-mm4-full/drivers/video/vesafb.c.old	2005-03-20 20:04:12.000000000 +0100
+++ linux-2.6.11-mm4-full/drivers/video/vesafb.c	2005-03-20 20:04:18.000000000 +0100
@@ -19,9 +19,6 @@
 #include <linux/fb.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
-#ifdef __i386__
-#include <video/edid.h>
-#endif
 #include <asm/io.h>
 #include <asm/mtrr.h>
 
--- linux-2.6.11-mm4-full/arch/i386/boot/compressed/misc.c.old	2005-03-20 20:05:55.000000000 +0100
+++ linux-2.6.11-mm4-full/arch/i386/boot/compressed/misc.c	2005-03-20 20:05:58.000000000 +0100
@@ -12,7 +12,6 @@
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
-#include <video/edid.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
--- linux-2.6.12-rc1-mm1-full/include/video/edid.h.old	2005-03-24 01:37:07.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/include/video/edid.h	2005-03-24 01:37:27.000000000 +0100
@@ -4,9 +4,6 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
-#ifdef CONFIG_PPC_OF
-#include <linux/pci.h>
-#endif
 
 #ifdef CONFIG_X86
 struct edid_info {
@@ -14,14 +11,8 @@
 };
 
 extern struct edid_info edid_info;
-extern char *get_EDID_from_BIOS(void *);
-
 #endif /* CONFIG_X86 */
 
-#ifdef CONFIG_PPC_OF
-extern char *get_EDID_from_OF(struct pci_dev *pdev);
-#endif
-
 #endif /* __KERNEL__ */
 
 #endif /* __linux_video_edid_h__ */



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
