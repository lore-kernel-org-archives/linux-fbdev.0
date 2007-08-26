From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 05/20] fbdev: change asm/uaccess.h to
	linux/uaccess.h
Date: Sun, 26 Aug 2007 21:59:12 +0800
Message-ID: <46D18730.5090701@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPJ1L-0005Ag-5x for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:19 -0700
Received: from nz-out-0506.google.com ([64.233.162.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPJ1K-00088d-AR
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:19 -0700
Received: by nz-out-0506.google.com with SMTP id f1so2918589nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Aug 2007 07:23:18 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch replaces <asm/uaccess.h> with <linux/uaccess.h>
after the checkpatch.pl hint.
The include of <asm/uaccess.h> is removed if the driver
does not use it.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/amifb.c                  |    2 +-
 drivers/video/arcfb.c                  |    2 +-
 drivers/video/atafb.c                  |    2 +-
 drivers/video/aty/aty128fb.c           |    2 +-
 drivers/video/aty/atyfb_base.c         |    2 +-
 drivers/video/aty/mach64_cursor.c      |    1 -
 drivers/video/aty/radeon_base.c        |    2 +-
 drivers/video/backlight/cr_bllcd.c     |    1 -
 drivers/video/backlight/progear_bl.c   |    1 -
 drivers/video/clps711xfb.c             |    2 +-
 drivers/video/console/fbcon.c          |    1 -
 drivers/video/console/softcursor.c     |    1 -
 drivers/video/cyber2000fb.c            |    1 -
 drivers/video/epson1355fb.c            |    2 +-
 drivers/video/fb_defio.c               |    1 -
 drivers/video/fb_sys_fops.c            |    2 +-
 drivers/video/fbcmap.c                 |    3 +--
 drivers/video/hecubafb.c               |    2 +-
 drivers/video/imsttfb.c                |    2 +-
 drivers/video/imxfb.c                  |    1 -
 drivers/video/kyro/fbdev.c             |    2 +-
 drivers/video/matrox/matroxfb_base.c   |    2 +-
 drivers/video/matrox/matroxfb_crtc2.c  |    2 +-
 drivers/video/matrox/matroxfb_g450.c   |    1 -
 drivers/video/matrox/matroxfb_maven.c  |    1 -
 drivers/video/neofb.c                  |    1 -
 drivers/video/pnx4008/pnxrgbfb.c       |    1 -
 drivers/video/ps3fb.c                  |    2 +-
 drivers/video/pvr2fb.c                 |    2 +-
 drivers/video/pxafb.c                  |    1 -
 drivers/video/sa1100fb.c               |    1 -
 drivers/video/savage/savagefb_driver.c |    1 -
 drivers/video/sis/sis_main.c           |    2 +-
 drivers/video/sstfb.c                  |    2 +-
 drivers/video/vermilion/vermilion.c    |    1 -
 drivers/video/vfb.c                    |    1 -
 36 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 1a849b8..f2e243c 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -52,7 +52,7 @@ #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/amigahw.h>
diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index db15bac..c343169 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -48,7 +48,7 @@ #include <linux/init.h>
 #include <linux/arcfb.h>
 #include <linux/platform_device.h>
 
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #define floor8(a) (a&(~0x07))
 #define floorXres(a,xres) (a&(~(xres - 1)))
diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
index 0038a05..5d4fbaa 100644
--- a/drivers/video/atafb.c
+++ b/drivers/video/atafb.c
@@ -58,7 +58,7 @@ #include <linux/init.h>
 #include <linux/interrupt.h>
 
 #include <asm/setup.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/irq.h>
 #include <asm/io.h>
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index cfcbe37..cbd3308 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -56,7 +56,7 @@ #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index b537151..abe0c43 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -68,7 +68,7 @@ #include <linux/wait.h>
 #include <linux/backlight.h>
 
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #include <video/mach64.h>
 #include "atyfb.h"
diff --git a/drivers/video/aty/mach64_cursor.c b/drivers/video/aty/mach64_cursor.c
index fe2c6ad..faf95da 100644
--- a/drivers/video/aty/mach64_cursor.c
+++ b/drivers/video/aty/mach64_cursor.c
@@ -8,7 +8,6 @@ #include <linux/init.h>
 #include <linux/string.h>
 
 #include <asm/io.h>
-#include <asm/uaccess.h>
 
 #ifdef __sparc__
 #include <asm/fbio.h>
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 47ca62f..22e46b9 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -69,7 +69,7 @@ #include <linux/vmalloc.h>
 #include <linux/device.h>
 
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #ifdef CONFIG_PPC_OF
 
diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
index 96f2307..280f9e0 100644
--- a/drivers/video/backlight/cr_bllcd.c
+++ b/drivers/video/backlight/cr_bllcd.c
@@ -37,7 +37,6 @@ #include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/lcd.h>
 #include <linux/pci.h>
-#include <asm/uaccess.h>
 
 #define MODULE_NAME "cr_bllcd"
 
diff --git a/drivers/video/backlight/progear_bl.c b/drivers/video/backlight/progear_bl.c
index 836ab4d..15fb4d5 100644
--- a/drivers/video/backlight/progear_bl.c
+++ b/drivers/video/backlight/progear_bl.c
@@ -23,7 +23,6 @@ #include <linux/mutex.h>
 #include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/pci.h>
-#include <asm/uaccess.h>
 
 #define PMU_LPCR               0xB0
 #define SB_MPS1                0x61
diff --git a/drivers/video/clps711xfb.c b/drivers/video/clps711xfb.c
index dea6579..17b5267 100644
--- a/drivers/video/clps711xfb.c
+++ b/drivers/video/clps711xfb.c
@@ -29,7 +29,7 @@ #include <linux/delay.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #include <asm/hardware/clps7111.h>
 #include <asm/arch/syspld.h>
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index e58c87b..6d0dcde 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -78,7 +78,6 @@ #include <linux/crc32.h> /* For counting
 #include <asm/fb.h>
 #include <asm/irq.h>
 #include <asm/system.h>
-#include <asm/uaccess.h>
 #ifdef CONFIG_ATARI
 #include <asm/atariints.h>
 #endif
diff --git a/drivers/video/console/softcursor.c b/drivers/video/console/softcursor.c
index 03cfb7a..25f835b 100644
--- a/drivers/video/console/softcursor.c
+++ b/drivers/video/console/softcursor.c
@@ -15,7 +15,6 @@ #include <linux/string.h>
 #include <linux/fb.h>
 #include <linux/slab.h>
 
-#include <asm/uaccess.h>
 #include <asm/io.h>
 
 #include "fbcon.h"
diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index 9e35353..5e3edf4 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -50,7 +50,6 @@ #include <linux/init.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
-#include <asm/uaccess.h>
 
 #ifdef __arm__
 #include <asm/mach-types.h>
diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
index 33be46c..cc2810e 100644
--- a/drivers/video/epson1355fb.c
+++ b/drivers/video/epson1355fb.c
@@ -57,7 +57,7 @@ #include <linux/platform_device.h>
 
 #include <asm/types.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #include <video/epson1355.h>
 
diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index 1a8643f..a0c5d9d 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -19,7 +19,6 @@ #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/fb.h>
 #include <linux/list.h>
-#include <asm/uaccess.h>
 
 /* to support deferred IO */
 #include <linux/rmap.h>
diff --git a/drivers/video/fb_sys_fops.c b/drivers/video/fb_sys_fops.c
index cf2538d..ff275d7 100644
--- a/drivers/video/fb_sys_fops.c
+++ b/drivers/video/fb_sys_fops.c
@@ -11,7 +11,7 @@
  */
 #include <linux/fb.h>
 #include <linux/module.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 ssize_t fb_sys_read(struct fb_info *info, char __user *buf, size_t count,
 		    loff_t *ppos)
diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index 148108a..91b78e6 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -15,8 +15,7 @@ #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/fb.h>
 #include <linux/slab.h>
-
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 static u16 red2[] __read_mostly = {
     0x0000, 0xaaaa
diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index abfcb50..94e0df8 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -45,7 +45,7 @@ #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/list.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 /* Apollo controller specific defines */
 #define APOLLO_START_NEW_IMG	0xA0
diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index 94f4511..3ab91bf 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -29,7 +29,7 @@ #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #if defined(CONFIG_PPC)
 #include <linux/nvram.h>
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index a125898..986ffa6 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -34,7 +34,6 @@ #include <linux/dma-mapping.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
 #include <asm/arch/imxfb.h>
 
 /*
diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index 1c55799..acb9370 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -21,7 +21,7 @@ #include <linux/ioctl.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
 #endif
diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index 86ca7b1..b25972a 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -113,7 +113,7 @@ #include "matroxfb_crtc2.h"
 #include "matroxfb_g450.h"
 #include <linux/matroxfb.h>
 #include <linux/interrupt.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
diff --git a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
index 4b3344e..a6ab5b6 100644
--- a/drivers/video/matrox/matroxfb_crtc2.c
+++ b/drivers/video/matrox/matroxfb_crtc2.c
@@ -15,7 +15,7 @@ #include "matroxfb_crtc2.h"
 #include "matroxfb_misc.h"
 #include "matroxfb_DAC1064.h"
 #include <linux/matroxfb.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 /* **************************************************** */
 
diff --git a/drivers/video/matrox/matroxfb_g450.c b/drivers/video/matrox/matroxfb_g450.c
index 4d610b4..6209a76 100644
--- a/drivers/video/matrox/matroxfb_g450.c
+++ b/drivers/video/matrox/matroxfb_g450.c
@@ -17,7 +17,6 @@ #include "matroxfb_misc.h"
 #include "matroxfb_DAC1064.h"
 #include "g450_pll.h"
 #include <linux/matroxfb.h>
-#include <asm/uaccess.h>
 #include <asm/div64.h>
 
 #include "matroxfb_g450.h"
diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
index de0d755..49cd53e 100644
--- a/drivers/video/matrox/matroxfb_maven.c
+++ b/drivers/video/matrox/matroxfb_maven.c
@@ -18,7 +18,6 @@ #include "matroxfb_DAC1064.h"
 #include <linux/i2c.h>
 #include <linux/matroxfb.h>
 #include <asm/div64.h>
-#include <asm/uaccess.h>
 
 #define MAVEN_I2CID	(0x1B)
 
diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 731d7a5..4b6a99b 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -72,7 +72,6 @@ #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
-#include <asm/uaccess.h>
 
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
diff --git a/drivers/video/pnx4008/pnxrgbfb.c b/drivers/video/pnx4008/pnxrgbfb.c
index f29e66e..685761a 100644
--- a/drivers/video/pnx4008/pnxrgbfb.c
+++ b/drivers/video/pnx4008/pnxrgbfb.c
@@ -26,7 +26,6 @@ #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 
-#include <asm/uaccess.h>
 #include "sdum.h"
 #include "fbcommon.h"
 
diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 646ec82..e0beb97 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -34,7 +34,7 @@ #include <linux/reboot.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <asm/time.h>
diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index 7d6c298..994baad 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -72,7 +72,7 @@ #include <asm/dma.h>
 #endif
 
 #ifdef CONFIG_SH_STORE_QUEUES
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/cpu/sq.h>
 #endif
 
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index fb58e15..5a273e5 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -41,7 +41,6 @@ #include <linux/dma-mapping.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <asm/arch/pxa-regs.h>
 #include <asm/arch/bitfield.h>
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index 5d2a4a4..ab2b211 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -178,7 +178,6 @@ #include <linux/dma-mapping.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
-#include <asm/uaccess.h>
 #include <asm/arch/assabet.h>
 #include <asm/arch/shannon.h>
 
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index b855f4a..37b135d 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -57,7 +57,6 @@ #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
-#include <asm/uaccess.h>
 
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index e8ccace..bc7d236 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -58,7 +58,7 @@ #include <linux/vmalloc.h>
 #include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/types.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/io.h>
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index 5eff28c..97784f9 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -88,7 +88,7 @@ #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <video/sstfb.h>
 
 
diff --git a/drivers/video/vermilion/vermilion.c b/drivers/video/vermilion/vermilion.c
index de531c9..ff9e805 100644
--- a/drivers/video/vermilion/vermilion.c
+++ b/drivers/video/vermilion/vermilion.c
@@ -39,7 +39,6 @@ #include <linux/pci.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <linux/mmzone.h>
-#include <asm/uaccess.h>
 
 /* #define VERMILION_DEBUG */
 
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index 64ee78c..02cfc6a 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -21,7 +21,6 @@ #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 
-#include <asm/uaccess.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
