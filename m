From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] changes asm/uaccess.h to linux/uaccess.h
Date: Thu, 16 Aug 2007 19:53:21 +0200
Message-ID: <46c48f110e496@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46c48f1110baa"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILjXB-0006P8-Pn for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 10:53:26 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILjXA-0001Rk-F2
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 10:53:25 -0700
Received: from poczta-8.free.wp-sa.pl (HELO localhost) ([10.1.1.19])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	16 Aug 2007 19:53:21 +0200
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
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--part46c48f1110baa
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch replaces <asm/uaccess.h> with <linux/uaccess.h>
after the checkpatch.pl hint.
The include of <asm/uaccess.h> is removed if the driver
does not use it.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

I haven't removed this include from drivers I couldn't
compile (non-pc and arm).

diff -urp linux-2.6.23.old/drivers/video/amifb.c linux-2.6.
23/drivers/video/amifb.c
--- linux-2.6.23.old/drivers/video/amifb.c	2007-07-09 01:32:
16.000000000 +0200
+++ linux-2.6.23/drivers/video/amifb.c	2007-08-16 09:14:22.
000000000 +0200
@@ -52,7 +52,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
=20
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/amigahw.h>
diff -urp linux-2.6.23.old/drivers/video/arcfb.c linux-2.6.
23/drivers/video/arcfb.c
--- linux-2.6.23.old/drivers/video/arcfb.c	2007-07-09 01:32:
16.000000000 +0200
+++ linux-2.6.23/drivers/video/arcfb.c	2007-08-16 09:13:49.
000000000 +0200
@@ -48,7 +48,7 @@
 #include <linux/arcfb.h>
 #include <linux/platform_device.h>
=20
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
=20
 #define floor8(a) (a&(~0x07))
 #define floorXres(a,xres) (a&(~(xres - 1)))
diff -urp linux-2.6.23.old/drivers/video/atafb.c linux-2.6.
23/drivers/video/atafb.c
--- linux-2.6.23.old/drivers/video/atafb.c	2007-07-09 01:32:
16.000000000 +0200
+++ linux-2.6.23/drivers/video/atafb.c	2007-08-16 09:14:57.
000000000 +0200
@@ -58,7 +58,7 @@
 #include <linux/interrupt.h>
=20
 #include <asm/setup.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/irq.h>
 #include <asm/io.h>
diff -urp linux-2.6.23.old/drivers/video/aty/aty128fb.c linux-2.
6.23/drivers/video/aty/aty128fb.c
--- linux-2.6.23.old/drivers/video/aty/aty128fb.c	2007-08-15=20
21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/aty/aty128fb.c	2007-08-16 09:
15:46.000000000 +0200
@@ -56,7 +56,7 @@
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
diff -urp linux-2.6.23.old/drivers/video/aty/atyfb_base.c=20
linux-2.6.23/drivers/video/aty/atyfb_base.c
--- linux-2.6.23.old/drivers/video/aty/atyfb_base.
c	2007-08-15 21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/aty/atyfb_base.c	2007-08-16=20
09:17:30.000000000 +0200
@@ -68,7 +68,7 @@
 #include <linux/backlight.h>
=20
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
=20
 #include <video/mach64.h>
 #include "atyfb.h"
diff -urp linux-2.6.23.old/drivers/video/aty/mach64_cursor.c=20
linux-2.6.23/drivers/video/aty/mach64_cursor.c
--- linux-2.6.23.old/drivers/video/aty/mach64_cursor.
c	2007-07-09 01:32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/aty/mach64_cursor.c	2007-08-16=20
09:16:48.000000000 +0200
@@ -8,7 +8,6 @@
 #include <linux/string.h>
=20
 #include <asm/io.h>
-#include <asm/uaccess.h>
=20
 #ifdef __sparc__
 #include <asm/fbio.h>
diff -urp linux-2.6.23.old/drivers/video/aty/radeon_base.c=20
linux-2.6.23/drivers/video/aty/radeon_base.c
--- linux-2.6.23.old/drivers/video/aty/radeon_base.
c	2007-08-15 21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/aty/radeon_base.c	2007-08-16=20
09:16:17.000000000 +0200
@@ -69,7 +69,7 @@
 #include <linux/device.h>
=20
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
=20
 #ifdef CONFIG_PPC_OF
=20
diff -urp linux-2.6.23.old/drivers/video/backlight/cr_bllcd.c=20
linux-2.6.23/drivers/video/backlight/cr_bllcd.c
--- linux-2.6.23.old/drivers/video/backlight/cr_bllcd.
c	2007-08-15 21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/backlight/cr_bllcd.
c	2007-08-16 09:17:53.000000000 +0200
@@ -36,7 +36,6 @@
 #include <linux/backlight.h>
 #include <linux/lcd.h>
 #include <linux/pci.h>
-#include <asm/uaccess.h>
=20
 /* The LVDS- and panel power controls sits on the
  * GPIO port of the ISA bridge.
diff -urp linux-2.6.23.old/drivers/video/backlight/progear_bl.c=20
linux-2.6.23/drivers/video/backlight/progear_bl.c
--- linux-2.6.23.old/drivers/video/backlight/progear_bl.
c	2007-07-09 01:32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/backlight/progear_bl.
c	2007-08-16 09:23:13.000000000 +0200
@@ -23,7 +23,6 @@
 #include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/pci.h>
-#include <asm/uaccess.h>
=20
 #define PMU_LPCR               0xB0
 #define SB_MPS1                0x61
diff -urp linux-2.6.23.old/drivers/video/clps711xfb.c linux-2.6.
23/drivers/video/clps711xfb.c
--- linux-2.6.23.old/drivers/video/clps711xfb.c	2007-08-15=20
21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/clps711xfb.c	2007-08-16 09:23:
38.000000000 +0200
@@ -29,7 +29,7 @@
=20
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
=20
 #include <asm/hardware/clps7111.h>
 #include <asm/arch/syspld.h>
diff -urp linux-2.6.23.old/drivers/video/console/fbcon.c linux-2.
6.23/drivers/video/console/fbcon.c
--- linux-2.6.23.old/drivers/video/console/fbcon.c	2007-08-15=20
21:45:30.000000000 +0200
+++ linux-2.6.23/drivers/video/console/fbcon.c	2007-08-16 09:
27:34.000000000 +0200
@@ -78,7 +78,6 @@
 #include <asm/fb.h>
 #include <asm/irq.h>
 #include <asm/system.h>
-#include <asm/uaccess.h>
 #ifdef CONFIG_ATARI
 #include <asm/atariints.h>
 #endif
diff -urp linux-2.6.23.old/drivers/video/console/softcursor.c=20
linux-2.6.23/drivers/video/console/softcursor.c
--- linux-2.6.23.old/drivers/video/console/softcursor.
c	2007-07-09 01:32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/console/softcursor.
c	2007-08-16 09:30:13.000000000 +0200
@@ -15,7 +15,6 @@
 #include <linux/fb.h>
 #include <linux/slab.h>
=20
-#include <asm/uaccess.h>
 #include <asm/io.h>
=20
 #include "fbcon.h"
diff -urp linux-2.6.23.old/drivers/video/cyber2000fb.c linux-2.6.
23/drivers/video/cyber2000fb.c
--- linux-2.6.23.old/drivers/video/cyber2000fb.c	2007-08-15=20
21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/cyber2000fb.c	2007-08-16 09:
25:19.000000000 +0200
@@ -50,7 +50,6 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
-#include <asm/uaccess.h>
=20
 #ifdef __arm__
 #include <asm/mach-types.h>
diff -urp linux-2.6.23.old/drivers/video/epson1355fb.c linux-2.6.
23/drivers/video/epson1355fb.c
--- linux-2.6.23.old/drivers/video/epson1355fb.c	2007-08-15=20
21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/epson1355fb.c	2007-08-16 10:
48:31.000000000 +0200
@@ -57,7 +57,7 @@
=20
 #include <asm/types.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
=20
 #include <video/epson1355.h>
=20
diff -urp linux-2.6.23.old/drivers/video/fb_defio.c linux-2.6.
23/drivers/video/fb_defio.c
--- linux-2.6.23.old/drivers/video/fb_defio.c	2007-07-09 01:
32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/fb_defio.c	2007-08-16 09:25:
46.000000000 +0200
@@ -19,7 +19,6 @@
 #include <linux/interrupt.h>
 #include <linux/fb.h>
 #include <linux/list.h>
-#include <asm/uaccess.h>
=20
 /* to support deferred IO */
 #include <linux/rmap.h>
diff -urp linux-2.6.23.old/drivers/video/fb_sys_fops.c linux-2.6.
23/drivers/video/fb_sys_fops.c
--- linux-2.6.23.old/drivers/video/fb_sys_fops.c	2007-07-09=20
01:32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/fb_sys_fops.c	2007-08-16 09:
26:23.000000000 +0200
@@ -11,7 +11,7 @@
  */
 #include <linux/fb.h>
 #include <linux/module.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
=20
 ssize_t fb_sys_read(struct fb_info *info, char __user *buf,=20
size_t count,
 		    loff_t *ppos)
diff -urp linux-2.6.23.old/drivers/video/fbcmap.c linux-2.6.
23/drivers/video/fbcmap.c
--- linux-2.6.23.old/drivers/video/fbcmap.c	2007-07-09 01:32:
16.000000000 +0200
+++ linux-2.6.23/drivers/video/fbcmap.c	2007-08-16 09:29:02.
000000000 +0200
@@ -15,8 +15,7 @@
 #include <linux/module.h>
 #include <linux/fb.h>
 #include <linux/slab.h>
-
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
=20
 static u16 red2[] __read_mostly =3D {
     0x0000, 0xaaaa
diff -urp linux-2.6.23.old/drivers/video/hecubafb.c linux-2.6.
23/drivers/video/hecubafb.c
--- linux-2.6.23.old/drivers/video/hecubafb.c	2007-07-09 01:
32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/hecubafb.c	2007-08-16 09:25:
05.000000000 +0200
@@ -45,7 +45,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/list.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
=20
 /* Apollo controller specific defines */
 #define APOLLO_START_NEW_IMG	0xA0
diff -urp linux-2.6.23.old/drivers/video/imsttfb.c linux-2.6.
23/drivers/video/imsttfb.c
--- linux-2.6.23.old/drivers/video/imsttfb.c	2007-07-09 01:
32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/imsttfb.c	2007-08-16 09:27:02.
000000000 +0200
@@ -29,7 +29,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
=20
 #if defined(CONFIG_PPC)
 #include <linux/nvram.h>
diff -urp linux-2.6.23.old/drivers/video/imxfb.c linux-2.6.
23/drivers/video/imxfb.c
--- linux-2.6.23.old/drivers/video/imxfb.c	2007-07-09 01:32:
16.000000000 +0200
+++ linux-2.6.23/drivers/video/imxfb.c	2007-08-16 10:51:00.
000000000 +0200
@@ -34,7 +34,6 @@
=20
 #include <asm/hardware.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
 #include <asm/arch/imxfb.h>
=20
 /*
diff -urp linux-2.6.23.old/drivers/video/kyro/fbdev.c linux-2.6.
23/drivers/video/kyro/fbdev.c
--- linux-2.6.23.old/drivers/video/kyro/fbdev.c	2007-07-09=20
01:32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/kyro/fbdev.c	2007-08-16 09:12:
40.000000000 +0200
@@ -21,7 +21,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
 #endif
diff -urp linux-2.6.23.old/drivers/video/matrox/matroxfb_base.c=20
linux-2.6.23/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.23.old/drivers/video/matrox/matroxfb_base.
c	2007-08-15 21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/matrox/matroxfb_base.
c	2007-08-16 09:09:15.000000000 +0200
@@ -113,7 +113,7 @@
 #include "matroxfb_g450.h"
 #include <linux/matroxfb.h>
 #include <linux/interrupt.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
=20
 #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
diff -urp linux-2.6.23.old/drivers/video/matrox/matroxfb_crtc2.c=20
linux-2.6.23/drivers/video/matrox/matroxfb_crtc2.c
--- linux-2.6.23.old/drivers/video/matrox/matroxfb_crtc2.
c	2007-08-15 21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/matrox/matroxfb_crtc2.
c	2007-08-16 09:11:03.000000000 +0200
@@ -15,7 +15,7 @@
 #include "matroxfb_misc.h"
 #include "matroxfb_DAC1064.h"
 #include <linux/matroxfb.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
=20
 /* **************************************************** */
=20
diff -urp linux-2.6.23.old/drivers/video/matrox/matroxfb_g450.c=20
linux-2.6.23/drivers/video/matrox/matroxfb_g450.c
--- linux-2.6.23.old/drivers/video/matrox/matroxfb_g450.
c	2007-07-09 01:32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/matrox/matroxfb_g450.
c	2007-08-16 09:08:46.000000000 +0200
@@ -17,7 +17,6 @@
 #include "matroxfb_DAC1064.h"
 #include "g450_pll.h"
 #include <linux/matroxfb.h>
-#include <asm/uaccess.h>
 #include <asm/div64.h>
=20
 #include "matroxfb_g450.h"
diff -urp linux-2.6.23.old/drivers/video/matrox/matroxfb_maven.c=20
linux-2.6.23/drivers/video/matrox/matroxfb_maven.c
--- linux-2.6.23.old/drivers/video/matrox/matroxfb_maven.
c	2007-08-15 21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/matrox/matroxfb_maven.
c	2007-08-16 09:08:27.000000000 +0200
@@ -18,7 +18,6 @@
 #include <linux/i2c.h>
 #include <linux/matroxfb.h>
 #include <asm/div64.h>
-#include <asm/uaccess.h>
=20
 #define MAVEN_I2CID	(0x1B)
=20
diff -urp linux-2.6.23.old/drivers/video/neofb.c linux-2.6.
23/drivers/video/neofb.c
--- linux-2.6.23.old/drivers/video/neofb.c	2007-07-09 01:32:
16.000000000 +0200
+++ linux-2.6.23/drivers/video/neofb.c	2007-08-16 09:04:00.
000000000 +0200
@@ -72,7 +72,6 @@
 #include <asm/irq.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
-#include <asm/uaccess.h>
=20
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
diff -urp linux-2.6.23.old/drivers/video/pnx4008/pnxrgbfb.c=20
linux-2.6.23/drivers/video/pnx4008/pnxrgbfb.c
--- linux-2.6.23.old/drivers/video/pnx4008/pnxrgbfb.
c	2007-07-09 01:32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/pnx4008/pnxrgbfb.c	2007-08-16=20
11:39:56.000000000 +0200
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
=20
-#include <asm/uaccess.h>
 #include "sdum.h"
 #include "fbcommon.h"
=20
diff -urp linux-2.6.23.old/drivers/video/ps3fb.c linux-2.6.
23/drivers/video/ps3fb.c
--- linux-2.6.23.old/drivers/video/ps3fb.c	2007-08-15 21:44:
50.000000000 +0200
+++ linux-2.6.23/drivers/video/ps3fb.c	2007-08-16 09:03:28.
000000000 +0200
@@ -34,7 +34,7 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
=20
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <asm/time.h>
diff -urp linux-2.6.23.old/drivers/video/pvr2fb.c linux-2.6.
23/drivers/video/pvr2fb.c
--- linux-2.6.23.old/drivers/video/pvr2fb.c	2007-08-15 21:45:
30.000000000 +0200
+++ linux-2.6.23/drivers/video/pvr2fb.c	2007-08-16 09:02:51.
000000000 +0200
@@ -72,7 +72,7 @@
 #endif
=20
 #ifdef CONFIG_SH_STORE_QUEUES
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/cpu/sq.h>
 #endif
=20
diff -urp linux-2.6.23.old/drivers/video/pxafb.c linux-2.6.
23/drivers/video/pxafb.c
--- linux-2.6.23.old/drivers/video/pxafb.c	2007-07-09 01:32:
16.000000000 +0200
+++ linux-2.6.23/drivers/video/pxafb.c	2007-08-16 10:50:39.
000000000 +0200
@@ -41,7 +41,6 @@
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <asm/arch/pxa-regs.h>
 #include <asm/arch/bitfield.h>
diff -urp linux-2.6.23.old/drivers/video/sa1100fb.c linux-2.6.
23/drivers/video/sa1100fb.c
--- linux-2.6.23.old/drivers/video/sa1100fb.c	2007-07-09 01:
32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/sa1100fb.c	2007-08-16 10:48:
04.000000000 +0200
@@ -178,7 +178,6 @@
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
-#include <asm/uaccess.h>
 #include <asm/arch/assabet.h>
 #include <asm/arch/shannon.h>
=20
diff -urp linux-2.6.23.old/drivers/video/savage/savagefb_driver.c=20
linux-2.6.23/drivers/video/savage/savagefb_driver.c
--- linux-2.6.23.old/drivers/video/savage/savagefb_driver.
c	2007-08-15 21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/savage/savagefb_driver.
c	2007-08-16 09:01:03.000000000 +0200
@@ -57,7 +57,6 @@
 #include <asm/irq.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
-#include <asm/uaccess.h>
=20
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
diff -urp linux-2.6.23.old/drivers/video/sis/sis_main.c linux-2.
6.23/drivers/video/sis/sis_main.c
--- linux-2.6.23.old/drivers/video/sis/sis_main.c	2007-08-15=20
21:44:50.000000000 +0200
+++ linux-2.6.23/drivers/video/sis/sis_main.c	2007-08-16 09:
00:29.000000000 +0200
@@ -58,7 +58,7 @@
 #include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/types.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/io.h>
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
diff -urp linux-2.6.23.old/drivers/video/sstfb.c linux-2.6.
23/drivers/video/sstfb.c
--- linux-2.6.23.old/drivers/video/sstfb.c	2007-08-15 21:44:
50.000000000 +0200
+++ linux-2.6.23/drivers/video/sstfb.c	2007-08-16 08:53:48.
000000000 +0200
@@ -88,7 +88,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <video/sstfb.h>
=20
=20
diff -urp linux-2.6.23.old/drivers/video/vermilion/vermilion.c=20
linux-2.6.23/drivers/video/vermilion/vermilion.c
--- linux-2.6.23.old/drivers/video/vermilion/vermilion.
c	2007-07-09 01:32:16.000000000 +0200
+++ linux-2.6.23/drivers/video/vermilion/vermilion.
c	2007-08-16 08:55:34.000000000 +0200
@@ -39,7 +39,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <linux/mmzone.h>
-#include <asm/uaccess.h>
=20
 /* #define VERMILION_DEBUG */
=20
diff -urp linux-2.6.23.old/drivers/video/vfb.c linux-2.6.
23/drivers/video/vfb.c
--- linux-2.6.23.old/drivers/video/vfb.c	2007-07-09 01:32:16.
000000000 +0200
+++ linux-2.6.23/drivers/video/vfb.c	2007-08-16 08:44:08.
000000000 +0200
@@ -21,7 +21,6 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
=20
-#include <asm/uaccess.h>
 #include <linux/fb.h>
 #include <linux/init.h>
=20


----------------------------------------------------
Czy na wakacje warto zabra=E6 laptopa?
Zobacz gdzie dzia=B3aj=B1 strefy darmowego, bezprzewodowego Internetu!
Kliknij: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd=
128.html&sid=3D1259

--part46c48f1110baa
Content-Type: application/octet-stream; name="fb-uaccess.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fb-uaccess.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggcmVw
bGFjZXMgPGFzbS91YWNjZXNzLmg+IHdpdGggPGxpbnV4L3VhY2Nlc3MuaD4KYWZ0ZXIgdGhlIGNo
ZWNrcGF0Y2gucGwgaGludC4KVGhlIGluY2x1ZGUgb2YgPGFzbS91YWNjZXNzLmg+IGlzIHJlbW92
ZWQgaWYgdGhlIGRyaXZlcgpkb2VzIG5vdCB1c2UgaXQuCgpTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0
b2YgSGVsdCA8a3J6eXN6dG9mLmgxQHdwLnBsPgoKLS0tCgpJIGhhdmVuJ3QgcmVtb3ZlZCB0aGlz
IGluY2x1ZGUgZnJvbSBkcml2ZXJzIEkgY291bGRuJ3QKY29tcGlsZSAoc3BhcmMsIHBwYywgaHBw
YSwgb3RoZXJzKS4KCmRpZmYgLXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vYW1p
ZmIuYyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9hbWlmYi5jCi0tLSBsaW51eC0yLjYuMjMu
b2xkL2RyaXZlcnMvdmlkZW8vYW1pZmIuYwkyMDA3LTA3LTA5IDAxOjMyOjE2LjAwMDAwMDAwMCAr
MDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vYW1pZmIuYwkyMDA3LTA4LTE2IDA5
OjE0OjIyLjAwMDAwMDAwMCArMDIwMApAQCAtNTIsNyArNTIsNyBAQAogI2luY2x1ZGUgPGxpbnV4
L2luaXQuaD4KICNpbmNsdWRlIDxsaW51eC9pb3BvcnQuaD4KIAotI2luY2x1ZGUgPGFzbS91YWNj
ZXNzLmg+CisjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgogI2luY2x1ZGUgPGFzbS9zeXN0ZW0u
aD4KICNpbmNsdWRlIDxhc20vaXJxLmg+CiAjaW5jbHVkZSA8YXNtL2FtaWdhaHcuaD4KZGlmZiAt
dXJwIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9hcmNmYi5jIGxpbnV4LTIuNi4yMy9k
cml2ZXJzL3ZpZGVvL2FyY2ZiLmMKLS0tIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9h
cmNmYi5jCTIwMDctMDctMDkgMDE6MzI6MTYuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYu
MjMvZHJpdmVycy92aWRlby9hcmNmYi5jCTIwMDctMDgtMTYgMDk6MTM6NDkuMDAwMDAwMDAwICsw
MjAwCkBAIC00OCw3ICs0OCw3IEBACiAjaW5jbHVkZSA8bGludXgvYXJjZmIuaD4KICNpbmNsdWRl
IDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KIAotI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+Cisj
aW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgogCiAjZGVmaW5lIGZsb29yOChhKSAoYSYofjB4MDcp
KQogI2RlZmluZSBmbG9vclhyZXMoYSx4cmVzKSAoYSYofih4cmVzIC0gMSkpKQpkaWZmIC11cnAg
bGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2F0YWZiLmMgbGludXgtMi42LjIzL2RyaXZl
cnMvdmlkZW8vYXRhZmIuYwotLS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2F0YWZi
LmMJMjAwNy0wNy0wOSAwMTozMjoxNi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9k
cml2ZXJzL3ZpZGVvL2F0YWZiLmMJMjAwNy0wOC0xNiAwOToxNDo1Ny4wMDAwMDAwMDAgKzAyMDAK
QEAgLTU4LDcgKzU4LDcgQEAKICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KIAogI2luY2x1
ZGUgPGFzbS9zZXR1cC5oPgotI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CisjaW5jbHVkZSA8bGlu
dXgvdWFjY2Vzcy5oPgogI2luY2x1ZGUgPGFzbS9wZ3RhYmxlLmg+CiAjaW5jbHVkZSA8YXNtL2ly
cS5oPgogI2luY2x1ZGUgPGFzbS9pby5oPgpkaWZmIC11cnAgbGludXgtMi42LjIzLm9sZC9kcml2
ZXJzL3ZpZGVvL2F0eS9hdHkxMjhmYi5jIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL2F0eS9h
dHkxMjhmYi5jCi0tLSBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vYXR5L2F0eTEyOGZi
LmMJMjAwNy0wOC0xNSAyMTo0NDo1MC4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9k
cml2ZXJzL3ZpZGVvL2F0eS9hdHkxMjhmYi5jCTIwMDctMDgtMTYgMDk6MTU6NDYuMDAwMDAwMDAw
ICswMjAwCkBAIC01Niw3ICs1Niw3IEBACiAjaW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPgogI2lu
Y2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CiAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+Ci0jaW5j
bHVkZSA8YXNtL3VhY2Nlc3MuaD4KKyNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+CiAjaW5jbHVk
ZSA8bGludXgvZmIuaD4KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgv
cGNpLmg+CmRpZmYgLXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vYXR5L2F0eWZi
X2Jhc2UuYyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9hdHkvYXR5ZmJfYmFzZS5jCi0tLSBs
aW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vYXR5L2F0eWZiX2Jhc2UuYwkyMDA3LTA4LTE1
IDIxOjQ0OjUwLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8v
YXR5L2F0eWZiX2Jhc2UuYwkyMDA3LTA4LTE2IDA5OjE3OjMwLjAwMDAwMDAwMCArMDIwMApAQCAt
NjgsNyArNjgsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2JhY2tsaWdodC5oPgogCiAjaW5jbHVkZSA8
YXNtL2lvLmg+Ci0jaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KKyNpbmNsdWRlIDxsaW51eC91YWNj
ZXNzLmg+CiAKICNpbmNsdWRlIDx2aWRlby9tYWNoNjQuaD4KICNpbmNsdWRlICJhdHlmYi5oIgpk
aWZmIC11cnAgbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2F0eS9tYWNoNjRfY3Vyc29y
LmMgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vYXR5L21hY2g2NF9jdXJzb3IuYwotLS0gbGlu
dXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2F0eS9tYWNoNjRfY3Vyc29yLmMJMjAwNy0wNy0w
OSAwMTozMjoxNi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVv
L2F0eS9tYWNoNjRfY3Vyc29yLmMJMjAwNy0wOC0xNiAwOToxNjo0OC4wMDAwMDAwMDAgKzAyMDAK
QEAgLTgsNyArOCw2IEBACiAjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+CiAKICNpbmNsdWRlIDxh
c20vaW8uaD4KLSNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPgogCiAjaWZkZWYgX19zcGFyY19fCiAj
aW5jbHVkZSA8YXNtL2ZiaW8uaD4KZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92
aWRlby9hdHkvcmFkZW9uX2Jhc2UuYyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9hdHkvcmFk
ZW9uX2Jhc2UuYwotLS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2F0eS9yYWRlb25f
YmFzZS5jCTIwMDctMDgtMTUgMjE6NDQ6NTAuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYu
MjMvZHJpdmVycy92aWRlby9hdHkvcmFkZW9uX2Jhc2UuYwkyMDA3LTA4LTE2IDA5OjE2OjE3LjAw
MDAwMDAwMCArMDIwMApAQCAtNjksNyArNjksNyBAQAogI2luY2x1ZGUgPGxpbnV4L2RldmljZS5o
PgogCiAjaW5jbHVkZSA8YXNtL2lvLmg+Ci0jaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KKyNpbmNs
dWRlIDxsaW51eC91YWNjZXNzLmg+CiAKICNpZmRlZiBDT05GSUdfUFBDX09GCiAKZGlmZiAtdXJw
IGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvY3JfYmxsY2QuYyBsaW51
eC0yLjYuMjMvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvY3JfYmxsY2QuYwotLS0gbGludXgtMi42
LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9jcl9ibGxjZC5jCTIwMDctMDgtMTUgMjE6
NDQ6NTAuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9iYWNr
bGlnaHQvY3JfYmxsY2QuYwkyMDA3LTA4LTE2IDA5OjE3OjUzLjAwMDAwMDAwMCArMDIwMApAQCAt
MzYsNyArMzYsNiBAQAogI2luY2x1ZGUgPGxpbnV4L2JhY2tsaWdodC5oPgogI2luY2x1ZGUgPGxp
bnV4L2xjZC5oPgogI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgotI2luY2x1ZGUgPGFzbS91YWNjZXNz
Lmg+CiAKIC8qIFRoZSBMVkRTLSBhbmQgcGFuZWwgcG93ZXIgY29udHJvbHMgc2l0cyBvbiB0aGUK
ICAqIEdQSU8gcG9ydCBvZiB0aGUgSVNBIGJyaWRnZS4KZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5v
bGQvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHJvZ2Vhcl9ibC5jIGxpbnV4LTIuNi4yMy9kcml2
ZXJzL3ZpZGVvL2JhY2tsaWdodC9wcm9nZWFyX2JsLmMKLS0tIGxpbnV4LTIuNi4yMy5vbGQvZHJp
dmVycy92aWRlby9iYWNrbGlnaHQvcHJvZ2Vhcl9ibC5jCTIwMDctMDctMDkgMDE6MzI6MTYuMDAw
MDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHJv
Z2Vhcl9ibC5jCTIwMDctMDgtMTYgMDk6MjM6MTMuMDAwMDAwMDAwICswMjAwCkBAIC0yMyw3ICsy
Myw2IEBACiAjaW5jbHVkZSA8bGludXgvZmIuaD4KICNpbmNsdWRlIDxsaW51eC9iYWNrbGlnaHQu
aD4KICNpbmNsdWRlIDxsaW51eC9wY2kuaD4KLSNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPgogCiAj
ZGVmaW5lIFBNVV9MUENSICAgICAgICAgICAgICAgMHhCMAogI2RlZmluZSBTQl9NUFMxICAgICAg
ICAgICAgICAgIDB4NjEKZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9j
bHBzNzExeGZiLmMgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vY2xwczcxMXhmYi5jCi0tLSBs
aW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vY2xwczcxMXhmYi5jCTIwMDctMDgtMTUgMjE6
NDQ6NTAuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9jbHBz
NzExeGZiLmMJMjAwNy0wOC0xNiAwOToyMzozOC4wMDAwMDAwMDAgKzAyMDAKQEAgLTI5LDcgKzI5
LDcgQEAKIAogI2luY2x1ZGUgPGFzbS9oYXJkd2FyZS5oPgogI2luY2x1ZGUgPGFzbS9tYWNoLXR5
cGVzLmg+Ci0jaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KKyNpbmNsdWRlIDxsaW51eC91YWNjZXNz
Lmg+CiAKICNpbmNsdWRlIDxhc20vaGFyZHdhcmUvY2xwczcxMTEuaD4KICNpbmNsdWRlIDxhc20v
YXJjaC9zeXNwbGQuaD4KZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9j
b25zb2xlL2ZiY29uLmMgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vY29uc29sZS9mYmNvbi5j
Ci0tLSBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vY29uc29sZS9mYmNvbi5jCTIwMDct
MDgtMTUgMjE6NDU6MzAuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92
aWRlby9jb25zb2xlL2ZiY29uLmMJMjAwNy0wOC0xNiAwOToyNzozNC4wMDAwMDAwMDAgKzAyMDAK
QEAgLTc4LDcgKzc4LDYgQEAKICNpbmNsdWRlIDxhc20vZmIuaD4KICNpbmNsdWRlIDxhc20vaXJx
Lmg+CiAjaW5jbHVkZSA8YXNtL3N5c3RlbS5oPgotI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CiAj
aWZkZWYgQ09ORklHX0FUQVJJCiAjaW5jbHVkZSA8YXNtL2F0YXJpaW50cy5oPgogI2VuZGlmCmRp
ZmYgLXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vY29uc29sZS9zb2Z0Y3Vyc29y
LmMgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vY29uc29sZS9zb2Z0Y3Vyc29yLmMKLS0tIGxp
bnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9jb25zb2xlL3NvZnRjdXJzb3IuYwkyMDA3LTA3
LTA5IDAxOjMyOjE2LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlk
ZW8vY29uc29sZS9zb2Z0Y3Vyc29yLmMJMjAwNy0wOC0xNiAwOTozMDoxMy4wMDAwMDAwMDAgKzAy
MDAKQEAgLTE1LDcgKzE1LDYgQEAKICNpbmNsdWRlIDxsaW51eC9mYi5oPgogI2luY2x1ZGUgPGxp
bnV4L3NsYWIuaD4KIAotI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CiAjaW5jbHVkZSA8YXNtL2lv
Lmg+CiAKICNpbmNsdWRlICJmYmNvbi5oIgpkaWZmIC11cnAgbGludXgtMi42LjIzLm9sZC9kcml2
ZXJzL3ZpZGVvL2N5YmVyMjAwMGZiLmMgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vY3liZXIy
MDAwZmIuYwotLS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2N5YmVyMjAwMGZiLmMJ
MjAwNy0wOC0xNSAyMTo0NDo1MC4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9kcml2
ZXJzL3ZpZGVvL2N5YmVyMjAwMGZiLmMJMjAwNy0wOC0xNiAwOToyNToxOS4wMDAwMDAwMDAgKzAy
MDAKQEAgLTUwLDcgKzUwLDYgQEAKICNpbmNsdWRlIDxhc20vaW8uaD4KICNpbmNsdWRlIDxhc20v
cGd0YWJsZS5oPgogI2luY2x1ZGUgPGFzbS9zeXN0ZW0uaD4KLSNpbmNsdWRlIDxhc20vdWFjY2Vz
cy5oPgogCiAjaWZkZWYgX19hcm1fXwogI2luY2x1ZGUgPGFzbS9tYWNoLXR5cGVzLmg+CmRpZmYg
LXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vZXBzb24xMzU1ZmIuYyBsaW51eC0y
LjYuMjMvZHJpdmVycy92aWRlby9lcHNvbjEzNTVmYi5jCi0tLSBsaW51eC0yLjYuMjMub2xkL2Ry
aXZlcnMvdmlkZW8vZXBzb24xMzU1ZmIuYwkyMDA3LTA4LTE1IDIxOjQ0OjUwLjAwMDAwMDAwMCAr
MDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vZXBzb24xMzU1ZmIuYwkyMDA3LTA4
LTE2IDEwOjQ4OjMxLjAwMDAwMDAwMCArMDIwMApAQCAtNTcsNyArNTcsNyBAQAogCiAjaW5jbHVk
ZSA8YXNtL3R5cGVzLmg+CiAjaW5jbHVkZSA8YXNtL2lvLmg+Ci0jaW5jbHVkZSA8YXNtL3VhY2Nl
c3MuaD4KKyNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+CiAKICNpbmNsdWRlIDx2aWRlby9lcHNv
bjEzNTUuaD4KIApkaWZmIC11cnAgbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2ZiX2Rl
ZmlvLmMgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vZmJfZGVmaW8uYwotLS0gbGludXgtMi42
LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2ZiX2RlZmlvLmMJMjAwNy0wNy0wOSAwMTozMjoxNi4wMDAw
MDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL2ZiX2RlZmlvLmMJMjAw
Ny0wOC0xNiAwOToyNTo0Ni4wMDAwMDAwMDAgKzAyMDAKQEAgLTE5LDcgKzE5LDYgQEAKICNpbmNs
dWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KICNpbmNsdWRlIDxsaW51eC9mYi5oPgogI2luY2x1ZGUg
PGxpbnV4L2xpc3QuaD4KLSNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPgogCiAvKiB0byBzdXBwb3J0
IGRlZmVycmVkIElPICovCiAjaW5jbHVkZSA8bGludXgvcm1hcC5oPgpkaWZmIC11cnAgbGludXgt
Mi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2ZiX3N5c19mb3BzLmMgbGludXgtMi42LjIzL2RyaXZl
cnMvdmlkZW8vZmJfc3lzX2ZvcHMuYwotLS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVv
L2ZiX3N5c19mb3BzLmMJMjAwNy0wNy0wOSAwMTozMjoxNi4wMDAwMDAwMDAgKzAyMDAKKysrIGxp
bnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL2ZiX3N5c19mb3BzLmMJMjAwNy0wOC0xNiAwOToyNjoy
My4wMDAwMDAwMDAgKzAyMDAKQEAgLTExLDcgKzExLDcgQEAKICAqLwogI2luY2x1ZGUgPGxpbnV4
L2ZiLmg+CiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Ci0jaW5jbHVkZSA8YXNtL3VhY2Nlc3Mu
aD4KKyNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+CiAKIHNzaXplX3QgZmJfc3lzX3JlYWQoc3Ry
dWN0IGZiX2luZm8gKmluZm8sIGNoYXIgX191c2VyICpidWYsIHNpemVfdCBjb3VudCwKIAkJICAg
IGxvZmZfdCAqcHBvcykKZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9m
YmNtYXAuYyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9mYmNtYXAuYwotLS0gbGludXgtMi42
LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2ZiY21hcC5jCTIwMDctMDctMDkgMDE6MzI6MTYuMDAwMDAw
MDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9mYmNtYXAuYwkyMDA3LTA4
LTE2IDA5OjI5OjAyLjAwMDAwMDAwMCArMDIwMApAQCAtMTUsOCArMTUsNyBAQAogI2luY2x1ZGUg
PGxpbnV4L21vZHVsZS5oPgogI2luY2x1ZGUgPGxpbnV4L2ZiLmg+CiAjaW5jbHVkZSA8bGludXgv
c2xhYi5oPgotCi0jaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KKyNpbmNsdWRlIDxsaW51eC91YWNj
ZXNzLmg+CiAKIHN0YXRpYyB1MTYgcmVkMltdIF9fcmVhZF9tb3N0bHkgPSB7CiAgICAgMHgwMDAw
LCAweGFhYWEKZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9oZWN1YmFm
Yi5jIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL2hlY3ViYWZiLmMKLS0tIGxpbnV4LTIuNi4y
My5vbGQvZHJpdmVycy92aWRlby9oZWN1YmFmYi5jCTIwMDctMDctMDkgMDE6MzI6MTYuMDAwMDAw
MDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9oZWN1YmFmYi5jCTIwMDct
MDgtMTYgMDk6MjU6MDUuMDAwMDAwMDAwICswMjAwCkBAIC00NSw3ICs0NSw3IEBACiAjaW5jbHVk
ZSA8bGludXgvaW5pdC5oPgogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgogI2lu
Y2x1ZGUgPGxpbnV4L2xpc3QuaD4KLSNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPgorI2luY2x1ZGUg
PGxpbnV4L3VhY2Nlc3MuaD4KIAogLyogQXBvbGxvIGNvbnRyb2xsZXIgc3BlY2lmaWMgZGVmaW5l
cyAqLwogI2RlZmluZSBBUE9MTE9fU1RBUlRfTkVXX0lNRwkweEEwCmRpZmYgLXVycCBsaW51eC0y
LjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vaW1zdHRmYi5jIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3Zp
ZGVvL2ltc3R0ZmIuYwotLS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2ltc3R0ZmIu
YwkyMDA3LTA3LTA5IDAxOjMyOjE2LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2Ry
aXZlcnMvdmlkZW8vaW1zdHRmYi5jCTIwMDctMDgtMTYgMDk6Mjc6MDIuMDAwMDAwMDAwICswMjAw
CkBAIC0yOSw3ICsyOSw3IEBACiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPgogI2luY2x1ZGUgPGxp
bnV4L3BjaS5oPgogI2luY2x1ZGUgPGFzbS9pby5oPgotI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+
CisjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgogCiAjaWYgZGVmaW5lZChDT05GSUdfUFBDKQog
I2luY2x1ZGUgPGxpbnV4L252cmFtLmg+CmRpZmYgLXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZl
cnMvdmlkZW8vaW14ZmIuYyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9pbXhmYi5jCi0tLSBs
aW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vaW14ZmIuYwkyMDA3LTA3LTA5IDAxOjMyOjE2
LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vaW14ZmIuYwky
MDA3LTA4LTE2IDEwOjUxOjAwLjAwMDAwMDAwMCArMDIwMApAQCAtMzQsNyArMzQsNiBAQAogCiAj
aW5jbHVkZSA8YXNtL2hhcmR3YXJlLmg+CiAjaW5jbHVkZSA8YXNtL2lvLmg+Ci0jaW5jbHVkZSA8
YXNtL3VhY2Nlc3MuaD4KICNpbmNsdWRlIDxhc20vYXJjaC9pbXhmYi5oPgogCiAvKgpkaWZmIC11
cnAgbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL2t5cm8vZmJkZXYuYyBsaW51eC0yLjYu
MjMvZHJpdmVycy92aWRlby9reXJvL2ZiZGV2LmMKLS0tIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVy
cy92aWRlby9reXJvL2ZiZGV2LmMJMjAwNy0wNy0wOSAwMTozMjoxNi4wMDAwMDAwMDAgKzAyMDAK
KysrIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL2t5cm8vZmJkZXYuYwkyMDA3LTA4LTE2IDA5
OjEyOjQwLjAwMDAwMDAwMCArMDIwMApAQCAtMjEsNyArMjEsNyBAQAogI2luY2x1ZGUgPGxpbnV4
L2luaXQuaD4KICNpbmNsdWRlIDxsaW51eC9wY2kuaD4KICNpbmNsdWRlIDxhc20vaW8uaD4KLSNp
bmNsdWRlIDxhc20vdWFjY2Vzcy5oPgorI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4KICNpZmRl
ZiBDT05GSUdfTVRSUgogI2luY2x1ZGUgPGFzbS9tdHJyLmg+CiAjZW5kaWYKZGlmZiAtdXJwIGxp
bnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9tYXRyb3gvbWF0cm94ZmJfYmFzZS5jIGxpbnV4
LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL21hdHJveC9tYXRyb3hmYl9iYXNlLmMKLS0tIGxpbnV4LTIu
Ni4yMy5vbGQvZHJpdmVycy92aWRlby9tYXRyb3gvbWF0cm94ZmJfYmFzZS5jCTIwMDctMDgtMTUg
MjE6NDQ6NTAuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9t
YXRyb3gvbWF0cm94ZmJfYmFzZS5jCTIwMDctMDgtMTYgMDk6MDk6MTUuMDAwMDAwMDAwICswMjAw
CkBAIC0xMTMsNyArMTEzLDcgQEAKICNpbmNsdWRlICJtYXRyb3hmYl9nNDUwLmgiCiAjaW5jbHVk
ZSA8bGludXgvbWF0cm94ZmIuaD4KICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KLSNpbmNs
dWRlIDxhc20vdWFjY2Vzcy5oPgorI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4KIAogI2lmZGVm
IENPTkZJR19QUENfUE1BQwogI2luY2x1ZGUgPGFzbS9tYWNoZGVwLmg+CmRpZmYgLXVycCBsaW51
eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vbWF0cm94L21hdHJveGZiX2NydGMyLmMgbGludXgt
Mi42LjIzL2RyaXZlcnMvdmlkZW8vbWF0cm94L21hdHJveGZiX2NydGMyLmMKLS0tIGxpbnV4LTIu
Ni4yMy5vbGQvZHJpdmVycy92aWRlby9tYXRyb3gvbWF0cm94ZmJfY3J0YzIuYwkyMDA3LTA4LTE1
IDIxOjQ0OjUwLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8v
bWF0cm94L21hdHJveGZiX2NydGMyLmMJMjAwNy0wOC0xNiAwOToxMTowMy4wMDAwMDAwMDAgKzAy
MDAKQEAgLTE1LDcgKzE1LDcgQEAKICNpbmNsdWRlICJtYXRyb3hmYl9taXNjLmgiCiAjaW5jbHVk
ZSAibWF0cm94ZmJfREFDMTA2NC5oIgogI2luY2x1ZGUgPGxpbnV4L21hdHJveGZiLmg+Ci0jaW5j
bHVkZSA8YXNtL3VhY2Nlc3MuaD4KKyNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+CiAKIC8qICoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiogKi8KIApk
aWZmIC11cnAgbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL21hdHJveC9tYXRyb3hmYl9n
NDUwLmMgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vbWF0cm94L21hdHJveGZiX2c0NTAuYwot
LS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL21hdHJveC9tYXRyb3hmYl9nNDUwLmMJ
MjAwNy0wNy0wOSAwMTozMjoxNi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9kcml2
ZXJzL3ZpZGVvL21hdHJveC9tYXRyb3hmYl9nNDUwLmMJMjAwNy0wOC0xNiAwOTowODo0Ni4wMDAw
MDAwMDAgKzAyMDAKQEAgLTE3LDcgKzE3LDYgQEAKICNpbmNsdWRlICJtYXRyb3hmYl9EQUMxMDY0
LmgiCiAjaW5jbHVkZSAiZzQ1MF9wbGwuaCIKICNpbmNsdWRlIDxsaW51eC9tYXRyb3hmYi5oPgot
I2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CiAjaW5jbHVkZSA8YXNtL2RpdjY0Lmg+CiAKICNpbmNs
dWRlICJtYXRyb3hmYl9nNDUwLmgiCmRpZmYgLXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMv
dmlkZW8vbWF0cm94L21hdHJveGZiX21hdmVuLmMgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8v
bWF0cm94L21hdHJveGZiX21hdmVuLmMKLS0tIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRl
by9tYXRyb3gvbWF0cm94ZmJfbWF2ZW4uYwkyMDA3LTA4LTE1IDIxOjQ0OjUwLjAwMDAwMDAwMCAr
MDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vbWF0cm94L21hdHJveGZiX21hdmVu
LmMJMjAwNy0wOC0xNiAwOTowODoyNy4wMDAwMDAwMDAgKzAyMDAKQEAgLTE4LDcgKzE4LDYgQEAK
ICNpbmNsdWRlIDxsaW51eC9pMmMuaD4KICNpbmNsdWRlIDxsaW51eC9tYXRyb3hmYi5oPgogI2lu
Y2x1ZGUgPGFzbS9kaXY2NC5oPgotI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CiAKICNkZWZpbmUg
TUFWRU5fSTJDSUQJKDB4MUIpCiAKZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92
aWRlby9uZW9mYi5jIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL25lb2ZiLmMKLS0tIGxpbnV4
LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9uZW9mYi5jCTIwMDctMDctMDkgMDE6MzI6MTYuMDAw
MDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9uZW9mYi5jCTIwMDct
MDgtMTYgMDk6MDQ6MDAuMDAwMDAwMDAwICswMjAwCkBAIC03Miw3ICs3Miw2IEBACiAjaW5jbHVk
ZSA8YXNtL2lycS5oPgogI2luY2x1ZGUgPGFzbS9wZ3RhYmxlLmg+CiAjaW5jbHVkZSA8YXNtL3N5
c3RlbS5oPgotI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CiAKICNpZmRlZiBDT05GSUdfTVRSUgog
I2luY2x1ZGUgPGFzbS9tdHJyLmg+CmRpZmYgLXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMv
dmlkZW8vcG54NDAwOC9wbnhyZ2JmYi5jIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL3BueDQw
MDgvcG54cmdiZmIuYwotLS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL3BueDQwMDgv
cG54cmdiZmIuYwkyMDA3LTA3LTA5IDAxOjMyOjE2LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgt
Mi42LjIzL2RyaXZlcnMvdmlkZW8vcG54NDAwOC9wbnhyZ2JmYi5jCTIwMDctMDgtMTYgMTE6Mzk6
NTYuMDAwMDAwMDAwICswMjAwCkBAIC0yNiw3ICsyNiw2IEBACiAjaW5jbHVkZSA8bGludXgvaW5p
dC5oPgogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgogCi0jaW5jbHVkZSA8YXNt
L3VhY2Nlc3MuaD4KICNpbmNsdWRlICJzZHVtLmgiCiAjaW5jbHVkZSAiZmJjb21tb24uaCIKIApk
aWZmIC11cnAgbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL3BzM2ZiLmMgbGludXgtMi42
LjIzL2RyaXZlcnMvdmlkZW8vcHMzZmIuYwotLS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3Zp
ZGVvL3BzM2ZiLmMJMjAwNy0wOC0xNSAyMTo0NDo1MC4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4
LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL3BzM2ZiLmMJMjAwNy0wOC0xNiAwOTowMzoyOC4wMDAwMDAw
MDAgKzAyMDAKQEAgLTM0LDcgKzM0LDcgQEAKICNpbmNsdWRlIDxsaW51eC9rdGhyZWFkLmg+CiAj
aW5jbHVkZSA8bGludXgvZnJlZXplci5oPgogCi0jaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KKyNp
bmNsdWRlIDxsaW51eC91YWNjZXNzLmg+CiAjaW5jbHVkZSA8bGludXgvZmIuaD4KICNpbmNsdWRl
IDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8YXNtL3RpbWUuaD4KZGlmZiAtdXJwIGxpbnV4LTIu
Ni4yMy5vbGQvZHJpdmVycy92aWRlby9wdnIyZmIuYyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRl
by9wdnIyZmIuYwotLS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL3B2cjJmYi5jCTIw
MDctMDgtMTUgMjE6NDU6MzAuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVy
cy92aWRlby9wdnIyZmIuYwkyMDA3LTA4LTE2IDA5OjAyOjUxLjAwMDAwMDAwMCArMDIwMApAQCAt
NzIsNyArNzIsNyBAQAogI2VuZGlmCiAKICNpZmRlZiBDT05GSUdfU0hfU1RPUkVfUVVFVUVTCi0j
aW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KKyNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+CiAjaW5j
bHVkZSA8YXNtL2NwdS9zcS5oPgogI2VuZGlmCiAKZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5vbGQv
ZHJpdmVycy92aWRlby9weGFmYi5jIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL3B4YWZiLmMK
LS0tIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9weGFmYi5jCTIwMDctMDctMDkgMDE6
MzI6MTYuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9weGFm
Yi5jCTIwMDctMDgtMTYgMTA6NTA6MzkuMDAwMDAwMDAwICswMjAwCkBAIC00MSw3ICs0MSw2IEBA
CiAjaW5jbHVkZSA8YXNtL2hhcmR3YXJlLmg+CiAjaW5jbHVkZSA8YXNtL2lvLmg+CiAjaW5jbHVk
ZSA8YXNtL2lycS5oPgotI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CiAjaW5jbHVkZSA8YXNtL2Rp
djY0Lmg+CiAjaW5jbHVkZSA8YXNtL2FyY2gvcHhhLXJlZ3MuaD4KICNpbmNsdWRlIDxhc20vYXJj
aC9iaXRmaWVsZC5oPgpkaWZmIC11cnAgbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL3Nh
MTEwMGZiLmMgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vc2ExMTAwZmIuYwotLS0gbGludXgt
Mi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL3NhMTEwMGZiLmMJMjAwNy0wNy0wOSAwMTozMjoxNi4w
MDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL3NhMTEwMGZiLmMJ
MjAwNy0wOC0xNiAxMDo0ODowNC4wMDAwMDAwMDAgKzAyMDAKQEAgLTE3OCw3ICsxNzgsNiBAQAog
I2luY2x1ZGUgPGFzbS9oYXJkd2FyZS5oPgogI2luY2x1ZGUgPGFzbS9pby5oPgogI2luY2x1ZGUg
PGFzbS9tYWNoLXR5cGVzLmg+Ci0jaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KICNpbmNsdWRlIDxh
c20vYXJjaC9hc3NhYmV0Lmg+CiAjaW5jbHVkZSA8YXNtL2FyY2gvc2hhbm5vbi5oPgogCmRpZmYg
LXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vc2F2YWdlL3NhdmFnZWZiX2RyaXZl
ci5jIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL3NhdmFnZS9zYXZhZ2VmYl9kcml2ZXIuYwot
LS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL3NhdmFnZS9zYXZhZ2VmYl9kcml2ZXIu
YwkyMDA3LTA4LTE1IDIxOjQ0OjUwLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2Ry
aXZlcnMvdmlkZW8vc2F2YWdlL3NhdmFnZWZiX2RyaXZlci5jCTIwMDctMDgtMTYgMDk6MDE6MDMu
MDAwMDAwMDAwICswMjAwCkBAIC01Nyw3ICs1Nyw2IEBACiAjaW5jbHVkZSA8YXNtL2lycS5oPgog
I2luY2x1ZGUgPGFzbS9wZ3RhYmxlLmg+CiAjaW5jbHVkZSA8YXNtL3N5c3RlbS5oPgotI2luY2x1
ZGUgPGFzbS91YWNjZXNzLmg+CiAKICNpZmRlZiBDT05GSUdfTVRSUgogI2luY2x1ZGUgPGFzbS9t
dHJyLmg+CmRpZmYgLXVycCBsaW51eC0yLjYuMjMub2xkL2RyaXZlcnMvdmlkZW8vc2lzL3Npc19t
YWluLmMgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vc2lzL3Npc19tYWluLmMKLS0tIGxpbnV4
LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9zaXMvc2lzX21haW4uYwkyMDA3LTA4LTE1IDIxOjQ0
OjUwLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL2RyaXZlcnMvdmlkZW8vc2lzL3Np
c19tYWluLmMJMjAwNy0wOC0xNiAwOTowMDoyOS4wMDAwMDAwMDAgKzAyMDAKQEAgLTU4LDcgKzU4
LDcgQEAKICNpbmNsdWRlIDxsaW51eC9jYXBhYmlsaXR5Lmg+CiAjaW5jbHVkZSA8bGludXgvZnMu
aD4KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgotI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+Cisj
aW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgogI2luY2x1ZGUgPGFzbS9pby5oPgogI2lmZGVmIENP
TkZJR19NVFJSCiAjaW5jbHVkZSA8YXNtL210cnIuaD4KZGlmZiAtdXJwIGxpbnV4LTIuNi4yMy5v
bGQvZHJpdmVycy92aWRlby9zc3RmYi5jIGxpbnV4LTIuNi4yMy9kcml2ZXJzL3ZpZGVvL3NzdGZi
LmMKLS0tIGxpbnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby9zc3RmYi5jCTIwMDctMDgtMTUg
MjE6NDQ6NTAuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby9z
c3RmYi5jCTIwMDctMDgtMTYgMDg6NTM6NDguMDAwMDAwMDAwICswMjAwCkBAIC04OCw3ICs4OCw3
IEBACiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPgogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KICNp
bmNsdWRlIDxhc20vaW8uaD4KLSNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPgorI2luY2x1ZGUgPGxp
bnV4L3VhY2Nlc3MuaD4KICNpbmNsdWRlIDx2aWRlby9zc3RmYi5oPgogCiAKZGlmZiAtdXJwIGxp
bnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby92ZXJtaWxpb24vdmVybWlsaW9uLmMgbGludXgt
Mi42LjIzL2RyaXZlcnMvdmlkZW8vdmVybWlsaW9uL3Zlcm1pbGlvbi5jCi0tLSBsaW51eC0yLjYu
MjMub2xkL2RyaXZlcnMvdmlkZW8vdmVybWlsaW9uL3Zlcm1pbGlvbi5jCTIwMDctMDctMDkgMDE6
MzI6MTYuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92aWRlby92ZXJt
aWxpb24vdmVybWlsaW9uLmMJMjAwNy0wOC0xNiAwODo1NTozNC4wMDAwMDAwMDAgKzAyMDAKQEAg
LTM5LDcgKzM5LDYgQEAKICNpbmNsdWRlIDxhc20vY2FjaGVmbHVzaC5oPgogI2luY2x1ZGUgPGFz
bS90bGJmbHVzaC5oPgogI2luY2x1ZGUgPGxpbnV4L21tem9uZS5oPgotI2luY2x1ZGUgPGFzbS91
YWNjZXNzLmg+CiAKIC8qICNkZWZpbmUgVkVSTUlMSU9OX0RFQlVHICovCiAKZGlmZiAtdXJwIGxp
bnV4LTIuNi4yMy5vbGQvZHJpdmVycy92aWRlby92ZmIuYyBsaW51eC0yLjYuMjMvZHJpdmVycy92
aWRlby92ZmIuYwotLS0gbGludXgtMi42LjIzLm9sZC9kcml2ZXJzL3ZpZGVvL3ZmYi5jCTIwMDct
MDctMDkgMDE6MzI6MTYuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMjMvZHJpdmVycy92
aWRlby92ZmIuYwkyMDA3LTA4LTE2IDA4OjQ0OjA4LjAwMDAwMDAwMCArMDIwMApAQCAtMjEsNyAr
MjEsNiBAQAogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgogI2luY2x1ZGUgPGxpbnV4L3Bs
YXRmb3JtX2RldmljZS5oPgogCi0jaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KICNpbmNsdWRlIDxs
aW51eC9mYi5oPgogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KIAo=

--part46c48f1110baa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--part46c48f1110baa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--part46c48f1110baa--
