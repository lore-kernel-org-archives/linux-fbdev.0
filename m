From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] kill include/video/edid.h
Date: Sun, 20 Mar 2005 20:29:15 +0100
Message-ID: <20050320192915.GR4449@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD671-0002kL-Rx
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 11:29:23 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DD670-00007v-PS
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 11:29:23 -0800
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch removes some completely unused code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/boot/compressed/misc.c |    1 -
 arch/i386/kernel/setup.c         |    4 ----
 arch/x86_64/kernel/setup.c       |    3 ---
 drivers/video/fbmon.c            |    1 -
 drivers/video/vesafb.c           |    3 ---
 include/asm-i386/setup.h         |    1 -
 include/asm-x86_64/bootsetup.h   |    1 -
 include/video/edid.h             |   27 ---------------------------
 8 files changed, 41 deletions(-)

--- linux-2.6.11-mm4-full/arch/i386/kernel/setup.c.old	2005-03-20 20:06:06.000000000 +0100
+++ linux-2.6.11-mm4-full/arch/i386/kernel/setup.c	2005-03-20 20:06:45.000000000 +0100
@@ -43,8 +43,6 @@
 #include <linux/nodemask.h>
 #include <linux/kexec.h>
 
-#include <video/edid.h>
-
 #include <asm/apic.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
@@ -118,7 +116,6 @@
 	unsigned short length;
 	unsigned char table[0];
 };
-struct edid_info edid_info;
 struct ist_info ist_info;
 struct e820map e820;
 
@@ -1468,7 +1465,6 @@
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
-	edid_info = EDID_INFO;
 	apm_info.bios = APM_BIOS_INFO;
 	ist_info = IST_INFO;
 	saved_videomode = VIDEO_MODE;
--- linux-2.6.11-mm4-full/arch/x86_64/kernel/setup.c.old	2005-03-20 20:04:42.000000000 +0100
+++ linux-2.6.11-mm4-full/arch/x86_64/kernel/setup.c	2005-03-20 20:07:11.000000000 +0100
@@ -48,7 +48,6 @@
 #include <asm/smp.h>
 #include <asm/msr.h>
 #include <asm/desc.h>
-#include <video/edid.h>
 #include <asm/e820.h>
 #include <asm/dma.h>
 #include <asm/mpspec.h>
@@ -100,7 +99,6 @@
 	unsigned char table[0];
 };
 
-struct edid_info edid_info;
 struct e820map e820;
 
 extern int root_mountflags;
@@ -523,7 +521,6 @@
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
-	edid_info = EDID_INFO;
 	saved_video_mode = SAVED_VIDEO_MODE;
 	bootloader_type = LOADER_TYPE;
 
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
 
--- linux-2.6.11-mm4-full/include/asm-x86_64/bootsetup.h.old	2005-03-20 20:07:33.000000000 +0100
+++ linux-2.6.11-mm4-full/include/asm-x86_64/bootsetup.h	2005-03-20 20:07:44.000000000 +0100
@@ -25,7 +25,6 @@
 #define KERNEL_START (*(unsigned int *) (PARAM+0x214))
 #define INITRD_START (*(unsigned int *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned int *) (PARAM+0x21c))
-#define EDID_INFO (*(struct edid_info *) (PARAM+0x140))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_MBR_SIG_NR (*(unsigned char *) (PARAM+EDD_MBR_SIG_NR_BUF))
 #define EDD_MBR_SIGNATURE ((unsigned int *) (PARAM+EDD_MBR_SIG_BUF))
--- linux-2.6.11-mm4-full/include/asm-i386/setup.h.old	2005-03-20 20:07:52.000000000 +0100
+++ linux-2.6.11-mm4-full/include/asm-i386/setup.h	2005-03-20 20:07:55.000000000 +0100
@@ -55,7 +55,6 @@
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
-#define EDID_INFO   (*(struct edid_info *) (PARAM+0x140))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_MBR_SIG_NR (*(unsigned char *) (PARAM+EDD_MBR_SIG_NR_BUF))
 #define EDD_MBR_SIGNATURE ((unsigned int *) (PARAM+EDD_MBR_SIG_BUF))
--- linux-2.6.11-mm4-full/include/video/edid.h	2005-03-02 08:37:50.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,27 +0,0 @@
-#ifndef __linux_video_edid_h__
-#define __linux_video_edid_h__
-
-#ifdef __KERNEL__
-
-#include <linux/config.h>
-#ifdef CONFIG_PPC_OF
-#include <linux/pci.h>
-#endif
-
-#ifdef CONFIG_X86
-struct edid_info {
-	unsigned char dummy[128];
-};
-
-extern struct edid_info edid_info;
-extern char *get_EDID_from_BIOS(void *);
-
-#endif /* CONFIG_X86 */
-
-#ifdef CONFIG_PPC_OF
-extern char *get_EDID_from_OF(struct pci_dev *pdev);
-#endif
-
-#endif /* __KERNEL__ */
-
-#endif /* __linux_video_edid_h__ */



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
