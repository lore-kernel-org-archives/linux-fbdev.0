From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/2] fbdev: Intel 830M/845G/852GM/855GM/865G framebuffer driver port
Date: Sat, 23 Oct 2004 04:36:16 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410230436.16781.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL62s-0003AF-WD
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 13:29:54 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CL62r-00083H-Ts
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 13:29:54 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 860981159780
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Oct 2004 20:29:37 +0000 (UTC)
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
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Sylvain Meyer <sylvain.meyer@ifrance.com>

  Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G integrat=
ed
  graphics chips.
  Port from kernel 2.4 + some modifications and cleanup :
       - Fix HW accel on 845G
       - Use of agpgart for fb memory reservation
       - Add mtrr support

Signed-off-by: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
=2D--
 drivers/Makefile                     |    3
 drivers/video/Kconfig                |   21
 drivers/video/Makefile               |    3
 drivers/video/intelfb/Makefile       |    8
 drivers/video/intelfb/builtinmodes.c |  222 ++++
 drivers/video/intelfb/intelfb.h      |  294 +++++
 drivers/video/intelfb/intelfbdrv.c   | 1625 ++++++++++++++++++++++++++++++=
++
 drivers/video/intelfb/intelfbdrv.h   |   77 +
 drivers/video/intelfb/intelfbhw.c    | 1749 ++++++++++++++++++++++++++++++=
+++++
 drivers/video/intelfb/intelfbhw.h    |  565 +++++++++++
 include/linux/fb.h                   |    1
 11 files changed, 4567 insertions(+), 1 deletion(-)

diff -Nru a/drivers/Makefile b/drivers/Makefile
=2D-- a/drivers/Makefile	2004-10-19 19:22:10 +08:00
+++ b/drivers/Makefile	2004-10-21 05:06:30 +08:00
@@ -17,8 +17,9 @@
 # default.
 obj-y				+=3D char/
=20
=2D# i810fb depends on char/agp/
+# i810fb and intelfb depend on char/agp/
 obj-$(CONFIG_FB_I810)           +=3D video/i810/
+obj-$(CONFIG_FB_INTEL)          +=3D video/intelfb/
=20
 # we also need input/serio early so serio bus is initialized by the time
 # serial drivers start registering their serio ports
diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
=2D-- a/drivers/video/Kconfig	2004-10-07 06:18:18 +08:00
+++ b/drivers/video/Kconfig	2004-10-21 05:06:31 +08:00
@@ -517,6 +517,27 @@
  =20
           If unsure, say N.
=20
+config FB_INTEL
+	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
+	depends on FB && EXPERIMENTAL && PCI
+	select AGP
+	select AGP_INTEL
+	help
+	  This driver supports the on-board graphics built in to the Intel
+          830M/845G/852GM/855GM/865G chipsets.
+          Say Y if you have and plan to use such a board.
+
+          To compile this driver as a module, choose M here: the
+	  module will be called intelfb.
+
+config FB_INTEL_DEBUG
+        bool "Intel driver Debug Messages"
+	depends on FB_INTEL
+	---help---
+	  Say Y here if you want the Intel driver to output all sorts
+	  of debugging informations to provide to the maintainer when
+	  something goes wrong.
+
 config FB_MATROX
 	tristate "Matrox acceleration"
 	depends on FB && PCI
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
=2D-- a/drivers/video/Makefile	2004-10-19 20:21:09 +08:00
+++ b/drivers/video/Makefile	2004-10-21 05:06:32 +08:00
@@ -32,6 +32,9 @@
=20
 obj-$(CONFIG_FB_I810)             +=3D cfbcopyarea.o cfbfillrect.o cfbimgb=
lt.o \
 				     vgastate.o
+obj-$(CONFIG_FB_INTEL)            +=3D cfbfillrect.o cfbcopyarea.o \
+	                             cfbimgblt.o
+
 obj-$(CONFIG_FB_RADEON_OLD)	  +=3D radeonfb.o cfbfillrect.o cfbcopyarea.o =
cfbimgblt.o
 obj-$(CONFIG_FB_NEOMAGIC)         +=3D neofb.o cfbfillrect.o cfbcopyarea.o=
 cfbimgblt.o vgastate.o
 obj-$(CONFIG_FB_VIRGE)            +=3D virgefb.o
diff -Nru a/drivers/video/intelfb/Makefile b/drivers/video/intelfb/Makefile
=2D-- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/intelfb/Makefile	2004-10-21 05:06:34 +08:00
@@ -0,0 +1,8 @@
+obj-$(CONFIG_FB_INTEL) +=3D intelfb.o
+
+intelfb-objs :=3D intelfbdrv.o intelfbhw.o
+
+ifdef CONFIG_FB_INTEL_DEBUG
+#EXTRA_CFLAGS +=3D -DDEBUG -DVERBOSE -DREGDUMP
+EXTRA_CFLAGS +=3D -DDEBUG -DREGDUMP
+endif
diff -Nru a/drivers/video/intelfb/builtinmodes.c b/drivers/video/intelfb/bu=
iltinmodes.c
=2D-- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/intelfb/builtinmodes.c	2004-10-21 05:06:36 +08:00
@@ -0,0 +1,222 @@
+
+/*
+ * THIS FILE IS AUTOMATICALLY GENERATED BY fbmode.pl -- DO NOT EDIT
+ */
+
+static struct fb_videomode modedb[] =3D {
+    {
+	/* 640x350 @ 85 Hz, 37.9 kHz hsync */
+	"640x350@85", 85, 640, 350, 31746, 96, 32, 60, 32, 64, 3,
+	FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 640x400 @ 85 Hz, 37.9 kHz hsync */
+	"640x400@85", 85, 640, 400, 31746, 96, 32, 41, 1, 64, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 720x400 @ 85 Hz, 37.9 kHz hsync */
+	"720x400@85", 85, 720, 400, 28169, 108, 36, 42, 1, 72, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 640x480 @ 60 Hz, 31.5 kHz hsync */
+	"640x480@60", 60, 640, 480, 39683, 48, 16, 33, 10, 96, 2,
+	0, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 640x480 @ 73 Hz, 37.9 kHz hsync */
+	"640x480@73", 73, 640, 480, 31746, 128, 24, 29, 9, 40, 2,
+	0, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 640x480 @ 75 Hz, 37.5 kHz hsync */
+	"640x480@75", 75, 640, 480, 31746, 120, 16, 16, 1, 64, 3,
+	0, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 640x480 @ 85 Hz, 43.3 kHz hsync */
+	"640x480@85", 85, 640, 480, 27778, 80, 56, 25, 1, 56, 3,
+	0, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 800x600 @ 56 Hz, 35.2 kHz hsync */
+	"800x600@56", 56, 800, 600, 27778, 128, 24, 22, 1, 72, 2,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 800x600 @ 60 Hz, 37.9 kHz hsync */
+	"800x600@60", 60, 800, 600, 25000, 88, 40, 23, 1, 128, 4,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 800x600 @ 72 Hz, 48.1 kHz hsync */
+	"800x600@72", 72, 800, 600, 20000, 64, 56, 23, 37, 120, 6,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 800x600 @ 75 Hz, 46.9 kHz hsync */
+	"800x600@75", 75, 800, 600, 20202, 160, 16, 21, 1, 80, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 800x600 @ 85 Hz, 53.7 kHz hsync */
+	"800x600@85", 85, 800, 600, 17762, 152, 32, 27, 1, 64, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1024x768 @ 60 Hz, 48.4 kHz hsync */
+	"1024x768@60", 60, 1024, 768, 15385, 160, 24, 29, 3, 136, 6,
+	0, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1024x768 @ 70 Hz, 56.5 kHz hsync */
+	"1024x768@70", 70, 1024, 768, 13333, 144, 24, 29, 3, 136, 6,
+	0, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1024x768 @ 75 Hz, 60.1 kHz hsync */
+	"1024x768@75", 75, 1024, 768, 12690, 176, 16, 28, 1, 96, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1024x768 @ 85 Hz, 68.7 kHz hsync */
+	"1024x768@85", 85, 1024, 768, 10582, 208, 48, 36, 1, 96, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1152x864 @ 75 Hz, 67.5 kHz hsync */
+	"1152x864@75", 75, 1152, 864, 9259, 256, 64, 32, 1, 128, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1280x960 @ 60 Hz, 60.0 kHz hsync */
+	"1280x960@60", 60, 1280, 960, 9259, 312, 96, 36, 1, 112, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1280x960 @ 85 Hz, 85.9 kHz hsync */
+	"1280x960@85", 85, 1280, 960, 6734, 224, 64, 47, 1, 160, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1280x1024 @ 60 Hz, 64.0 kHz hsync */
+	"1280x1024@60", 60, 1280, 1024, 9259, 248, 48, 38, 1, 112, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1280x1024 @ 75 Hz, 80.0 kHz hsync */
+	"1280x1024@75", 75, 1280, 1024, 7407, 248, 16, 38, 1, 144, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1280x1024 @ 85 Hz, 91.1 kHz hsync */
+	"1280x1024@85", 85, 1280, 1024, 6349, 224, 64, 44, 1, 160, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1600x1200 @ 60 Hz, 75.0 kHz hsync */
+	"1600x1200@60", 60, 1600, 1200, 6173, 304, 64, 46, 1, 192, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1600x1200 @ 65 Hz, 81.2 kHz hsync */
+	"1600x1200@65", 65, 1600, 1200, 5698, 304, 64, 46, 1, 192, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1600x1200 @ 70 Hz, 87.5 kHz hsync */
+	"1600x1200@70", 70, 1600, 1200, 5291, 304, 64, 46, 1, 192, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1600x1200 @ 75 Hz, 93.8 kHz hsync */
+	"1600x1200@75", 75, 1600, 1200, 4938, 304, 64, 46, 1, 192, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1600x1200 @ 85 Hz, 106.2 kHz hsync */
+	"1600x1200@85", 85, 1600, 1200, 4357, 304, 64, 46, 1, 192, 3,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1792x1344 @ 60 Hz, 83.7 kHz hsync */
+	"1792x1344@60", 60, 1792, 1344, 4883, 328, 128, 46, 1, 200, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1792x1344 @ 75 Hz, 106.3 kHz hsync */
+	"1792x1344@75", 75, 1792, 1344, 3831, 352, 96, 69, 1, 216, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1856x1392 @ 60 Hz, 86.4 kHz hsync */
+	"1856x1392@60", 60, 1856, 1392, 4581, 352, 96, 43, 1, 224, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1856x1392 @ 75 Hz, 112.5 kHz hsync */
+	"1856x1392@75", 75, 1856, 1392, 3472, 352, 128, 104, 1, 224, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1920x1440 @ 60 Hz, 90.0 kHz hsync */
+	"1920x1440@60", 60, 1920, 1440, 4274, 344, 128, 56, 1, 208, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1920x1440 @ 75 Hz, 112.5 kHz hsync */
+	"1920x1440@75", 75, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 832x624 @ 75 Hz, 49.7 kHz hsync */
+	"832x624@75", 75, 832, 624, 17457, 224, 32, 39, 1, 64, 3,
+	0, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1152x768 @ 55 Hz, 44.2 kHz hsync */
+	"1152x768@55", 55, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1400x1050 @ 60 Hz, 64.9 kHz hsync */
+	"1400x1050@60", 60, 1400, 1050, 8197, 240, 88, 18, 2, 152, 12,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1400x1050 @ 75 Hz, 81.5 kHz hsync */
+	"1400x1050@75", 75, 1400, 1050, 6418, 128, 64, 26, 2, 320, 12,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1600x1024 @ 60 Hz, 64.0 kHz hsync */
+	"1600x1024@60", 60, 1600, 1024, 9354, 30, 20, 37, 3, 20, 3,
+	0, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 1920x1440 @ 85 Hz, 128.5 kHz hsync */
+	"1920x1440@85", 85, 1920, 1440, 2930, 368, 152, 68, 1, 216, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 2048x1536 @ 60 Hz, 95.3 kHz hsync */
+	"2048x1536@60", 60, 2048, 1536, 3746, 376, 152, 49, 1, 224, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 2048x1536 @ 75 Hz, 120.2 kHz hsync */
+	"2048x1536@75", 75, 2048, 1536, 2937, 392, 168, 63, 1, 224, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    },
+    {
+	/* 2048x1536 @ 85 Hz, 137.0 kHz hsync */
+	"2048x1536@85", 85, 2048, 1536, 2577, 392, 168, 72, 1, 224, 3,
+	FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    }
+};
+
+static int num_modes =3D sizeof(modedb) / sizeof(modedb[0]);
+
+#define DFLT_MODE 3
+
diff -Nru a/drivers/video/intelfb/intelfb.h b/drivers/video/intelfb/intelfb=
=2Eh
=2D-- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/intelfb/intelfb.h	2004-10-21 05:06:38 +08:00
@@ -0,0 +1,294 @@
+#ifndef _INTELFB_H
+#define _INTELFB_H
+
+/* $DHD: intelfb/intelfb.h,v 1.40 2003/06/27 15:06:25 dawes Exp $ */
+
+#include <linux/agp_backend.h>
+#include <linux/fb.h>
+
+
+/*** Version/name ***/
+#define INTELFB_VERSION			"0.9.0"
+#define INTELFB_MODULE_NAME		"intelfb"
+#define SUPPORTED_CHIPSETS		"830M/845G/852GM/855GM/865G"
+
+
+/*** Debug/feature defines ***/
+
+#ifndef DEBUG
+#define DEBUG				0
+#endif
+
+#ifndef VERBOSE
+#define VERBOSE				0
+#endif
+
+#ifndef REGDUMP
+#define REGDUMP				0
+#endif
+
+#ifndef DETECT_VGA_CLASS_ONLY
+#define DETECT_VGA_CLASS_ONLY		1
+#endif
+
+#ifndef ALLOCATE_FOR_PANNING
+#define ALLOCATE_FOR_PANNING		1
+#endif
+
+#ifndef BAILOUT_EARLY
+#define BAILOUT_EARLY			0
+#endif
+
+#ifndef TEST_MODE_TO_HW
+#define TEST_MODE_TO_HW			0
+#endif
+
+#ifndef PREFERRED_MODE
+#define PREFERRED_MODE			"1024x768-16@60"
+#endif
+
+/*** hw-related values ***/
+
+/* PCI ids for supported devices */
+#define PCI_DEVICE_ID_INTEL_830M	0x3577
+#define PCI_DEVICE_ID_INTEL_845G	0x2562
+#define PCI_DEVICE_ID_INTEL_85XGM	0x3582
+#define PCI_DEVICE_ID_INTEL_865G	0x2572
+
+/* Size of MMIO region */
+#define INTEL_REG_SIZE			0x80000
+
+#define STRIDE_ALIGNMENT		16
+
+#define PALETTE_8_ENTRIES		256
+
+
+/*** Macros ***/
+
+/* basic arithmetic */
+#define KB(x)			((x) * 1024)
+#define MB(x)			((x) * 1024 * 1024)
+#define BtoKB(x)		((x) / 1024)
+#define BtoMB(x)		((x) / 1024 / 1024)
+
+#define GTT_PAGE_SIZE           KB(4)
+
+#define ROUND_UP_TO(x, y)	(((x) + (y) - 1) / (y) * (y))
+#define ROUND_DOWN_TO(x, y)	((x) / (y) * (y))
+#define ROUND_UP_TO_PAGE(x)	ROUND_UP_TO((x), GTT_PAGE_SIZE)
+#define ROUND_DOWN_TO_PAGE(x)	ROUND_DOWN_TO((x), GTT_PAGE_SIZE)
+
+/* messages */
+#define PFX			INTELFB_MODULE_NAME ": "
+
+#define ERR_MSG(fmt, args...)	printk(KERN_ERR PFX fmt, ## args)
+#define WRN_MSG(fmt, args...)	printk(KERN_WARNING PFX fmt, ## args)
+#define NOT_MSG(fmt, args...)	printk(KERN_NOTICE PFX fmt, ## args)
+#define INF_MSG(fmt, args...)	printk(KERN_INFO PFX fmt, ## args)
+#if DEBUG
+#define DBG_MSG(fmt, args...)	printk(KERN_DEBUG PFX fmt, ## args)
+#else
+#define DBG_MSG(fmt, args...)	while (0) printk(fmt, ## args)
+#endif
+
+/* get commonly used pointers */
+#define GET_DINFO(info)		(info)->par
+
+/* module parameters */
+#define INTELFB_INT_PARAM(name, default, desc)				\
+	static int name =3D default;					\
+	MODULE_PARM(name, "i");					        \
+	MODULE_PARM_DESC(name, desc);
+
+#define INTELFB_STR_PARAM(name, default, desc)				\
+	static const char *name =3D default;				\
+	MODULE_PARM(name, "s");				                \
+	MODULE_PARM_DESC(name, desc);
+
+/* misc macros */
+#define TEXT_ACCEL(d, v)						\
+	((d)->accel && (d)->ring_active &&				\
+	 ((v)->accel_flags & FB_ACCELF_TEXT))
+
+/*#define NOACCEL_CHIPSET(d)						\
+	((d)->chipset !=3D INTEL_865G)*/
+#define NOACCEL_CHIPSET(d)						\
+	(0)
+
+#define FIXED_MODE(d) ((d)->fixed_mode)
+
+/*** Driver paramters ***/
+
+#define RINGBUFFER_SIZE		KB(64)
+#define HW_CURSOR_SIZE		KB(4)
+
+/* Intel agpgart driver */
+#define AGP_PHYSICAL_MEMORY     2
+
+/*** Data Types ***/
+
+/* supported chipsets */
+enum intel_chips {
+	INTEL_830M,
+	INTEL_845G,
+	INTEL_85XGM,
+	INTEL_852GM,
+	INTEL_852GME,
+	INTEL_855GM,
+	INTEL_855GME,
+	INTEL_865G
+};
+
+struct intelfb_hwstate {
+	u32 vga0_divisor;
+	u32 vga1_divisor;
+	u32 vga_pd;
+	u32 dpll_a;
+	u32 dpll_b;
+	u32 fpa0;
+	u32 fpa1;
+	u32 fpb0;
+	u32 fpb1;
+	u32 palette_a[PALETTE_8_ENTRIES];
+	u32 palette_b[PALETTE_8_ENTRIES];
+	u32 htotal_a;
+	u32 hblank_a;
+	u32 hsync_a;
+	u32 vtotal_a;
+	u32 vblank_a;
+	u32 vsync_a;
+	u32 src_size_a;
+	u32 bclrpat_a;
+	u32 htotal_b;
+	u32 hblank_b;
+	u32 hsync_b;
+	u32 vtotal_b;
+	u32 vblank_b;
+	u32 vsync_b;
+	u32 src_size_b;
+	u32 bclrpat_b;
+	u32 adpa;
+	u32 dvoa;
+	u32 dvob;
+	u32 dvoc;
+	u32 dvoa_srcdim;
+	u32 dvob_srcdim;
+	u32 dvoc_srcdim;
+	u32 lvds;
+	u32 pipe_a_conf;
+	u32 pipe_b_conf;
+	u32 disp_arb;
+	u32 cursor_a_control;
+	u32 cursor_b_control;
+	u32 cursor_a_base;
+	u32 cursor_b_base;
+	u32 cursor_size;
+	u32 disp_a_ctrl;
+	u32 disp_b_ctrl;
+	u32 disp_a_base;
+	u32 disp_b_base;
+	u32 cursor_a_palette[4];
+	u32 cursor_b_palette[4];
+	u32 disp_a_stride;
+	u32 disp_b_stride;
+	u32 vgacntrl;
+	u32 add_id;
+	u32 swf0x[7];
+	u32 swf1x[7];
+	u32 swf3x[3];
+	u32 fence[8];
+	u32 instpm;
+	u32 mem_mode;
+	u32 fw_blc_0;
+	u32 fw_blc_1;
+};
+
+struct intelfb_heap_data {
+	u32 physical;
+	u32 virtual;
+	u32 offset;  // in GATT pages
+	u32 size;    // in bytes
+};
+
+struct intelfb_info {
+	struct fb_info *info;
+	struct fb_ops  *fbops;
+	struct pci_dev *pdev;
+
+	struct intelfb_hwstate save_state;
+
+	/* agpgart structs */
+	struct agp_memory *gtt_fb_mem;     // use all stolen memory
+	struct agp_memory *gtt_ring_mem;   // ring buffer
+	struct agp_memory *gtt_cursor_mem; // hw cursor
+
+	/* mtrr support */
+	u32 mtrr_reg;
+	u32 has_mtrr;
+
+	/* heap data */
+	struct intelfb_heap_data aperture;
+	struct intelfb_heap_data fb;
+	struct intelfb_heap_data ring;
+	struct intelfb_heap_data cursor;
+
+	/* mmio regs */
+	u32 mmio_base_phys;
+	u32 mmio_base;
+
+	/* fb start offset (in bytes) */
+	u32 fb_start;
+
+	/* ring buffer */
+	u32 ring_head;
+	u32 ring_tail;
+	u32 ring_tail_mask;
+	u32 ring_space;
+	u32 ring_lockup;
+
+	/* palette */
+	u32 pseudo_palette[17];
+	struct { u8 red, green, blue, pad; } palette[256];
+
+	/* chip info */
+	int pci_chipset;
+	int chipset;
+	const char *name;
+	int mobile;
+
+	/* current mode */
+	int bpp, depth;
+	u32 visual;
+	int xres, yres, pitch;
+	int pixclock;
+
+	/* current pipe */
+	int pipe;
+
+	/* some flags */
+	int accel;
+	int hwcursor;
+	int fixed_mode;
+	int ring_active;
+
+	/* hw cursor */
+	int cursor_on;
+	int cursor_blanked;
+	u8  cursor_src[64];
+
+	/* initial parameters */
+	int initial_vga;
+	struct fb_var_screeninfo initial_var;
+	u32 initial_fb_base;
+	u32 initial_video_ram;
+	u32 initial_pitch;
+
+	/* driver registered */
+	int registered;
+};
+
+/*** function prototypes ***/
+
+extern int intelfb_var_to_depth(const struct fb_var_screeninfo *var);
+
+#endif /* _INTELFB_H */
diff -Nru a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/inte=
lfbdrv.c
=2D-- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/intelfb/intelfbdrv.c	2004-10-21 05:06:40 +08:00
@@ -0,0 +1,1625 @@
+/*
+ * intelfb
+ *
+ * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G
+ * integrated graphics chips.
+ *
+ * Copyright =A9 2002, 2003 David Dawes <dawes@xfree86.org>
+ *                   2004 Sylvain Meyer
+ *
+ * This driver consists of two parts.  The first part (intelfbdrv.c) provi=
des
+ * the basic fbdev interfaces, is derived in part from the radeonfb and
+ * vesafb drivers, and is covered by the GPL.  The second part (intelfbhw.=
c)
+ * provides the code to program the hardware.  Most of it is derived from
+ * the i810/i830 XFree86 driver.  The HW-specific code is covered here
+ * under a dual license (GPL and MIT/XFree86 license).
+ *
+ * Author: David Dawes
+ *
+ */
+
+/* $DHD: intelfb/intelfbdrv.c,v 1.20 2003/06/27 15:17:40 dawes Exp $ */
+
+/*
+ * Changes:
+ *    01/2003 - Initial driver (0.1.0), no mode switching, no acceleration.
+ *		This initial version is a basic core that works a lot like
+ *		the vesafb driver.  It must be built-in to the kernel,
+ *		and the initial video mode must be set with vga=3DXXX at
+ *		boot time.  (David Dawes)
+ *
+ *    01/2003 - Version 0.2.0: Mode switching added, colormap support
+ *		implemented, Y panning, and soft screen blanking implemented.
+ *		No acceleration yet.  (David Dawes)
+ *
+ *    01/2003 - Version 0.3.0: fbcon acceleration support added.  Module
+ *		option handling added.  (David Dawes)
+ *
+ *    01/2003 - Version 0.4.0: fbcon HW cursor support added.  (David Dawe=
s)
+ *
+ *    01/2003 - Version 0.4.1: Add auto-generation of built-in modes.
+ *		(David Dawes)
+ *
+ *    02/2003 - Version 0.4.2: Add check for active non-CRT devices, and
+ *		mode validation checks.  (David Dawes)
+ *
+ *    02/2003 - Version 0.4.3: Check when the VC is in graphics mode so th=
at
+ *		acceleration is disabled while an XFree86 server is running.
+ *		(David Dawes)
+ *
+ *    02/2003 - Version 0.4.4: Monitor DPMS support.  (David Dawes)
+ *
+ *    02/2003 - Version 0.4.5: Basic XFree86 + fbdev working.  (David Dawe=
s)
+ *
+ *    02/2003 - Version 0.5.0: Modify to work with the 2.5.32 kernel as we=
ll
+ *		as 2.4.x kernels.  (David Dawes)
+ *
+ *    02/2003 - Version 0.6.0: Split out HW-specifics into a separate file.
+ *		(David Dawes)
+ *
+ *    02/2003 - Version 0.7.0: Test on 852GM/855GM.  Acceleration and HW
+ *		cursor are disabled on this platform.  (David Dawes)
+ *
+ *    02/2003 - Version 0.7.1: Test on 845G.  Acceleration is disabled
+ *		on this platform.  (David Dawes)
+ *
+ *    02/2003 - Version 0.7.2: Test on 830M.  Acceleration and HW
+ *		cursor are disabled on this platform.  (David Dawes)
+ *
+ *    02/2003 - Version 0.7.3: Fix 8-bit modes for mobile platforms
+ *		(David Dawes)
+ *
+ *    02/2003 - Version 0.7.4: Add checks for FB and FBCON_HAS_CFB* config=
ured
+ *		in the kernel, and add mode bpp verification and default
+ *		bpp selection based on which FBCON_HAS_CFB* are configured.
+ *		(David Dawes)
+ *
+ *    02/2003 - Version 0.7.5: Add basic package/install scripts based on =
the
+ *		DRI packaging scripts.  (David Dawes)
+ *
+ *    04/2003 - Version 0.7.6: Fix typo that affects builds with SMP-enabl=
ed
+ *		kernels.  (David Dawes, reported by Anupam).
+ *
+ *    06/2003 - Version 0.7.7:
+ *              Fix Makefile.kernel build problem (Tsutomu Yasuda).
+ *		Fix mis-placed #endif (2.4.21 kernel).
+ *
+ *    09/2004 - Version 0.9.0 - by Sylvain Meyer
+ *              Port to linux 2.6 kernel fbdev
+ *              Fix HW accel and HW cursor on i845G
+ *              Add TV-Out functionality (tested with a ch7011 tv encoder)
+ *              Use of agpgart for fb memory reservation
+ *              Add mtrr support
+ *
+ * TODO:
+ *
+ *
+ * Wish List:
+ *
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/console.h>
+#include <linux/selection.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+#include <linux/kd.h>
+#include <linux/vt_kern.h>
+#include <linux/pagemap.h>
+#include <linux/version.h>
+
+#include <asm/io.h>
+
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
+
+#include "intelfb.h"
+#include "intelfbdrv.h"
+#include "intelfbhw.h"
+
+#include "builtinmodes.c"
+
+#define FB_ACCEL_I830 42
+
+/*
+ * Limiting the class to PCI_CLASS_DISPLAY_VGA prevents function 1 of the
+ * mobile chipsets from being registered.
+ */
+#if DETECT_VGA_CLASS_ONLY
+#define INTELFB_CLASS_MASK ~0 << 8
+#else
+#define INTELFB_CLASS_MASK 0
+#endif
+
+static struct pci_device_id intelfb_pci_table[] __devinitdata =3D {
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_830M, PCI_ANY_ID, PCI_ANY_ID, =
PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_830M },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_845G, PCI_ANY_ID, PCI_ANY_ID, =
PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_845G },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_85XGM, PCI_ANY_ID, PCI_ANY_ID,=
 PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_85XGM },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_865G, PCI_ANY_ID, PCI_ANY_ID, =
PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_865G },
+	{ 0, }
+};
+
+/* Global data */
+static int num_registered =3D 0;
+
+/* fb ops */
+static struct fb_ops intel_fb_ops =3D {
+	.owner =3D		THIS_MODULE,
+	.fb_check_var =3D         intelfb_check_var,
+	.fb_set_par =3D           intelfb_set_par,
+	.fb_setcolreg =3D		intelfb_setcolreg,
+	.fb_blank =3D		intelfb_blank,
+	.fb_pan_display =3D       intelfb_pan_display,
+	.fb_fillrect  =3D         intelfb_fillrect,
+	.fb_copyarea  =3D         intelfb_copyarea,
+	.fb_imageblit =3D         intelfb_imageblit,
+	.fb_cursor =3D            intelfb_cursor,
+	.fb_sync =3D              intelfb_sync,
+	.fb_ioctl =3D		intelfb_ioctl
+};
+
+/* PCI driver module table */
+static struct pci_driver intelfb_driver =3D {
+	.name =3D		"Intel(R) " SUPPORTED_CHIPSETS " Framebuffer Driver",
+	.id_table =3D	intelfb_pci_table,
+	.probe =3D	intelfb_pci_register,
+	.remove =3D	__devexit_p(intelfb_pci_unregister)
+};
+
+/* Module description/parameters */
+MODULE_AUTHOR("David Dawes <dawes@tungstengraphics.com>, "
+	      "Sylvain Meyer <sylvain.meyer@worldonline.fr>");
+MODULE_DESCRIPTION(
+	"Framebuffer driver for Intel(R) " SUPPORTED_CHIPSETS " chipsets");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DEVICE_TABLE(pci, intelfb_pci_table);
+
+INTELFB_INT_PARAM(accel, 1, "Enable console acceleration");
+INTELFB_INT_PARAM(hwcursor, 1, "Enable HW cursor");
+INTELFB_INT_PARAM(mtrr, 1, "Enable MTRR support");
+INTELFB_INT_PARAM(fixed, 0, "Disable mode switching");
+INTELFB_INT_PARAM(noinit, 0, "Don't initialise graphics mode when loading"=
);
+INTELFB_INT_PARAM(noregister, 0, "Don't register, just probe and exit (deb=
ug)");
+INTELFB_INT_PARAM(probeonly, 0, "Do a minimal probe (debug)");
+INTELFB_INT_PARAM(idonly, 0,
+		  "Just identify without doing anything else (debug)");
+INTELFB_INT_PARAM(bailearly, 0, "Bail out early, depending on value (debug=
)");
+INTELFB_STR_PARAM(mode, NULL,
+		  "Initial video mode \"<xres>x<yres>[-<depth>][@<refresh>]\"");
+/***************************************************************
+ *                     modules entry points                    *
+ ***************************************************************/
+
+/* module load/unload entry points */
+int __init
+intelfb_init(void)
+{
+#ifndef MODULE
+	char *option =3D NULL;
+#endif
+
+	DBG_MSG("intelfb_init\n");
+
+	INF_MSG("Framebuffer driver for "
+		"Intel(R) " SUPPORTED_CHIPSETS " chipsets\n");
+	INF_MSG("Version " INTELFB_VERSION "\n");
+
+	if (idonly)
+		return -ENODEV;
+
+#ifndef MODULE
+	if (fb_get_options("intelfb", &option))
+		return -ENODEV;
+	intelfb_setup(option);
+
+#endif
+
+	return pci_module_init(&intelfb_driver);
+}
+
+static void __exit
+intelfb_exit(void)
+{
+	DBG_MSG("intelfb_exit\n");
+	pci_unregister_driver(&intelfb_driver);
+}
+
+#ifndef MODULE
+#define OPT_EQUAL(opt, name) (!strncmp(opt, name, strlen(name)))
+#define OPT_INTVAL(opt, name) simple_strtoul(opt + strlen(name), NULL, 0)
+#define OPT_STRVAL(opt, name) (opt + strlen(name))
+
+static __inline__ char *
+get_opt_string(const char *this_opt, const char *name)
+{
+	const char *p;
+	int i;
+	char *ret;
+
+	p =3D OPT_STRVAL(this_opt, name);
+	i =3D 0;
+	while (p[i] && p[i] !=3D ' ' && p[i] !=3D ',')
+		i++;
+	ret =3D kmalloc(i + 1, GFP_KERNEL);
+	if (ret) {
+		strncpy(ret, p, i);
+		ret[i] =3D '\0';
+	}
+	return ret;
+}
+
+static __inline__ int
+get_opt_bool(const char *this_opt, const char *name, int *ret)
+{
+	if (!ret)
+		return 0;
+
+	if (OPT_EQUAL(this_opt, name)) {
+		if (this_opt[strlen(name)] =3D=3D '=3D')
+			*ret =3D simple_strtoul(this_opt + strlen(name) + 1,
+					      NULL, 0);
+		else
+			*ret =3D 1;
+	} else {
+		if (OPT_EQUAL(this_opt, "no") && OPT_EQUAL(this_opt + 2, name))
+			*ret =3D 0;
+		else
+			return 0;
+	}
+	return 1;
+}
+
+static __inline__ int
+get_opt_int(const char *this_opt, const char *name, int *ret)
+{
+	if (!ret)
+		return 0;
+
+	if (!OPT_EQUAL(this_opt, name))
+		return 0;
+
+	*ret =3D OPT_INTVAL(this_opt, name);
+	return 1;
+}
+
+int __init
+intelfb_setup(char *options)
+{
+	char *this_opt;
+
+	DBG_MSG("intelfb_setup\n");
+
+	if (!options || !*options) {
+		DBG_MSG("no options\n");
+		return 0;
+	} else
+		DBG_MSG("options: %s\n", options);
+
+	/*
+	 * These are the built-in options analogous to the module parameters
+	 * defined above.
+	 *
+	 * The syntax is:
+	 *
+	 *    video=3Dintelfb:[mode][,<param>=3D<val>] ...
+	 *
+	 * e.g.,
+	 *
+	 *    video=3Dintelfb:1024x768-16@75,accel=3D0
+	 */
+
+	while ((this_opt =3D strsep(&options, ","))) {
+		if (!*this_opt)
+			continue;
+		if (get_opt_bool(this_opt, "accel", &accel))
+			;
+		else if (get_opt_bool(this_opt, "hwcursor", &hwcursor))
+			;
+		else if (get_opt_bool(this_opt, "mtrr", &mtrr))
+			;
+		else if (get_opt_bool(this_opt, "fixed", &fixed))
+			;
+		else if (get_opt_bool(this_opt, "init", &noinit))
+			noinit =3D !noinit;
+		else if (OPT_EQUAL(this_opt, "mode=3D"))
+			mode =3D get_opt_string(this_opt, "mode=3D");
+		else
+			mode =3D this_opt;
+	}
+
+	return 0;
+}
+
+#endif
+
+module_init(intelfb_init);
+
+#ifdef MODULE
+module_exit(intelfb_exit);
+#endif
+
+/***************************************************************
+ *                     mtrr support functions                  *
+ ***************************************************************/
+
+#ifdef CONFIG_MTRR
+static inline void __devinit set_mtrr(struct intelfb_info *dinfo)
+{
+	dinfo->mtrr_reg =3D mtrr_add(dinfo->aperture.physical,
+				   dinfo->aperture.size, MTRR_TYPE_WRCOMB, 1);
+	if (dinfo->mtrr_reg < 0) {
+		ERR_MSG("unable to set MTRR\n");
+		return;
+	}
+	dinfo->has_mtrr =3D 1;
+}
+static inline void unset_mtrr(struct intelfb_info *dinfo)
+{
+  	if (dinfo->has_mtrr)
+  		mtrr_del(dinfo->mtrr_reg, dinfo->aperture.physical,
+			 dinfo->aperture.size);
+}
+#else
+#define set_mtrr(x) WRN_MSG("MTRR is disabled in the kernel\n")
+
+#define unset_mtrr(x) do { } while (0)
+#endif /* CONFIG_MTRR */
+
+/***************************************************************
+ *                        driver init / cleanup                *
+ ***************************************************************/
+
+static void
+cleanup(struct intelfb_info *dinfo)
+{
+	DBG_MSG("cleanup\n");
+
+	if (!dinfo)
+		return;
+
+	fb_dealloc_cmap(&dinfo->info->cmap);
+	kfree(dinfo->info->pixmap.addr);
+
+	if (dinfo->registered)
+		unregister_framebuffer(dinfo->info);
+
+	unset_mtrr(dinfo);
+
+	if (dinfo->gtt_fb_mem)
+		agp_unbind_memory(dinfo->gtt_fb_mem);
+	if (dinfo->gtt_cursor_mem) {
+		agp_unbind_memory(dinfo->gtt_cursor_mem);
+		agp_free_memory(dinfo->gtt_cursor_mem);
+	}
+	if (dinfo->gtt_ring_mem) {
+		agp_unbind_memory(dinfo->gtt_ring_mem);
+		agp_free_memory(dinfo->gtt_ring_mem);
+	}
+
+	if (dinfo->mmio_base)
+		iounmap((void *)dinfo->mmio_base);
+	if (dinfo->aperture.virtual)
+		iounmap((void *)dinfo->aperture.virtual);
+
+	if (dinfo->mmio_base_phys)
+		release_mem_region(dinfo->mmio_base_phys, INTEL_REG_SIZE);
+	if (dinfo->aperture.physical)
+		release_mem_region(dinfo->aperture.physical,
+				   dinfo->aperture.size);
+	framebuffer_release(dinfo->info);
+}
+
+#define bailout(dinfo) do {						\
+	DBG_MSG("bailout\n");						\
+	cleanup(dinfo);							\
+	INF_MSG("Not going to register framebuffer, exiting...\n");	\
+	return -ENODEV;							\
+} while (0)
+
+
+static int __devinit
+intelfb_pci_register(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct fb_info *info;
+	struct intelfb_info *dinfo;
+	int i, j, err, dvo;
+	int aperture_size, stolen_size;
+	struct agp_kern_info gtt_info;
+	int agp_memtype;
+	const char *s;
+
+	DBG_MSG("intelfb_pci_register\n");
+
+	num_registered++;
+	if (num_registered !=3D 1) {
+		ERR_MSG("Attempted to register %d devices "
+			"(should be only 1).\n", num_registered);
+		return -ENODEV;
+	}
+
+	info =3D framebuffer_alloc(sizeof(struct intelfb_info), &pdev->dev);
+	if (!info) {
+		ERR_MSG("Could not allocate memory for intelfb_info.\n");
+		return -ENODEV;
+	}
+	if (fb_alloc_cmap(&info->cmap, 256, 1) < 0) {
+		ERR_MSG("Could not allocate cmap for intelfb_info.\n");
+		goto err_out_cmap;
+		return -ENODEV;
+	}
+
+	dinfo =3D info->par;
+	dinfo->info  =3D info;
+	dinfo->fbops =3D &intel_fb_ops;
+	dinfo->pdev  =3D pdev;
+
+	/* Reserve pixmap space. */
+	info->pixmap.addr =3D kmalloc(64 * 1024, GFP_KERNEL);
+	if (info->pixmap.addr =3D=3D NULL) {
+		ERR_MSG("Cannot reserve pixmap memory.\n");
+		goto err_out_pixmap;
+	}
+	memset(info->pixmap.addr, 0, 64 * 1024);
+
+	/* set early this option because it could be changed by tv encoder
+	   driver */
+	dinfo->fixed_mode =3D fixed;
+
+	/* Enable device. */
+	if ((err =3D pci_enable_device(pdev))) {
+		ERR_MSG("Cannot enable device.\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	/* Set base addresses. */
+	dinfo->aperture.physical =3D pci_resource_start(pdev, 0);
+	dinfo->aperture.size     =3D pci_resource_len(pdev, 0);
+	dinfo->mmio_base_phys    =3D pci_resource_start(pdev, 1);
+
+	DBG_MSG("fb aperture: 0x%lx/0x%lx, MMIO region: 0x%lx/0x%lx\n",
+		pci_resource_start(pdev, 0), pci_resource_len(pdev, 0),
+		pci_resource_start(pdev, 1), pci_resource_len(pdev, 1));
+
+	/* Reserve the fb and MMIO regions */
+	if (!request_mem_region(dinfo->aperture.physical, dinfo->aperture.size,
+				INTELFB_MODULE_NAME)) {
+		ERR_MSG("Cannot reserve FB region.\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+	if (!request_mem_region(dinfo->mmio_base_phys,
+				INTEL_REG_SIZE,
+				INTELFB_MODULE_NAME)) {
+		ERR_MSG("Cannot reserve MMIO region.\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	/* Map the fb and MMIO regions */
+	dinfo->aperture.virtual =3D (u32)ioremap_nocache
+		(dinfo->aperture.physical, dinfo->aperture.size);
+	if (!dinfo->aperture.virtual) {
+		ERR_MSG("Cannot remap FB region.\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+	dinfo->mmio_base =3D (u32)ioremap_nocache(dinfo->mmio_base_phys,
+						INTEL_REG_SIZE);
+	if (!dinfo->mmio_base) {
+		ERR_MSG("Cannot remap MMIO region.\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	/* Get the chipset info. */
+	dinfo->pci_chipset =3D pdev->device;
+
+	if (intelfbhw_get_chipset(pdev, &dinfo->name, &dinfo->chipset,
+				  &dinfo->mobile)) {
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	if (intelfbhw_get_memory(pdev, &aperture_size,&stolen_size)) {
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	INF_MSG("%02x:%02x.%d: %s, aperture size %dMB, "
+		"stolen memory %dkB\n",
+		pdev->bus->number, PCI_SLOT(pdev->devfn),
+		PCI_FUNC(pdev->devfn), dinfo->name,
+		BtoMB(aperture_size), BtoKB(stolen_size));
+
+	/* Set these from the options. */
+	dinfo->accel    =3D accel;
+	dinfo->hwcursor =3D hwcursor;
+
+	if (NOACCEL_CHIPSET(dinfo) && dinfo->accel =3D=3D 1) {
+		INF_MSG("Acceleration is not supported for the %s chipset.\n",
+			dinfo->name);
+		dinfo->accel =3D 0;
+	}
+
+	/* Framebuffer parameters - Use all the stolen memory */
+	dinfo->fb.size =3D ROUND_UP_TO_PAGE(stolen_size);
+	dinfo->fb.offset =3D 0;   // starts at offset 0
+	dinfo->fb.physical =3D dinfo->aperture.physical
+		+ (dinfo->fb.offset << 12);
+	dinfo->fb.virtual =3D dinfo->aperture.virtual + (dinfo->fb.offset << 12);
+	dinfo->fb_start =3D dinfo->fb.offset << 12;
+
+	/* Allocate space for the ring buffer and HW cursor if enabled. */
+	if (dinfo->accel) {
+		dinfo->ring.size =3D RINGBUFFER_SIZE;
+		dinfo->ring_tail_mask =3D dinfo->ring.size - 1;
+	}
+	if (dinfo->hwcursor) {
+		dinfo->cursor.size =3D HW_CURSOR_SIZE;
+	}
+
+	/* Use agpgart to manage the GATT */
+	if (agp_backend_acquire()) {
+		ERR_MSG("cannot acquire agp\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	/* get the current gatt info */
+	if (agp_copy_info(&gtt_info)) {
+		ERR_MSG("cannot get agp info\n");
+		agp_backend_release();
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	/* set the mem offsets - set them after the already used pages */
+	if (dinfo->accel) {
+		dinfo->ring.offset =3D (stolen_size >> 12)
+			+ gtt_info.current_memory;
+	}
+	if (dinfo->hwcursor) {
+		dinfo->cursor.offset =3D (stolen_size >> 12) +
+			+ gtt_info.current_memory + (dinfo->ring.size >> 12);
+	}
+
+	/* Allocate memories (which aren't stolen) */
+	if (dinfo->accel) {
+		if (!(dinfo->gtt_ring_mem =3D
+		      agp_allocate_memory(dinfo->ring.size >> 12,
+					  AGP_NORMAL_MEMORY))) {
+			ERR_MSG("cannot allocate ring buffer memory\n");
+			agp_backend_release();
+			cleanup(dinfo);
+			return -ENOMEM;
+		}
+		if (agp_bind_memory(dinfo->gtt_ring_mem,
+				    dinfo->ring.offset)) {
+			ERR_MSG("cannot bind ring buffer memory\n");
+			agp_backend_release();
+			cleanup(dinfo);
+			return -EBUSY;
+		}
+		dinfo->ring.physical =3D dinfo->aperture.physical
+			+ (dinfo->ring.offset << 12);
+		dinfo->ring.virtual  =3D dinfo->aperture.virtual
+			+ (dinfo->ring.offset << 12);
+		dinfo->ring_head =3D dinfo->ring.virtual;
+	}
+	if (dinfo->hwcursor) {
+		agp_memtype =3D dinfo->mobile ? AGP_PHYSICAL_MEMORY
+			: AGP_NORMAL_MEMORY;
+		if (!(dinfo->gtt_cursor_mem =3D
+		      agp_allocate_memory(dinfo->cursor.size >> 12,
+					  agp_memtype))) {
+			ERR_MSG("cannot allocate cursor memory\n");
+			agp_backend_release();
+			cleanup(dinfo);
+			return -ENOMEM;
+		}
+		if (agp_bind_memory(dinfo->gtt_cursor_mem,
+				    dinfo->cursor.offset)) {
+			ERR_MSG("cannot bind cursor memory\n");
+			agp_backend_release();
+			cleanup(dinfo);
+			return -EBUSY;
+		}
+		if (dinfo->mobile)
+			dinfo->cursor.physical
+				=3D dinfo->gtt_cursor_mem->physical;
+		else
+			dinfo->cursor.physical =3D dinfo->aperture.physical
+				+ (dinfo->cursor.offset << 12);
+		dinfo->cursor.virtual =3D dinfo->aperture.virtual
+			+ (dinfo->cursor.offset << 12);
+	}
+
+	/* release agpgart */
+	agp_backend_release();
+
+	if (mtrr)
+		set_mtrr(dinfo);
+
+	DBG_MSG("fb: 0x%x(+ 0x%x)/0x%x (0x%x)\n",
+		dinfo->fb.physical, dinfo->fb.offset, dinfo->fb.size,
+		dinfo->fb.virtual);
+	DBG_MSG("MMIO: 0x%x/0x%x (0x%x)\n",
+		dinfo->mmio_base_phys, INTEL_REG_SIZE, dinfo->mmio_base);
+	DBG_MSG("ring buffer: 0x%x/0x%x (0x%x)\n",
+		dinfo->ring.physical, dinfo->ring.size, dinfo->ring.virtual);
+	DBG_MSG("HW cursor: 0x%x/0x%x (0x%x) (offset 0x%x) (phys 0x%x)\n",
+		dinfo->cursor.physical, dinfo->cursor.size,
+		dinfo->cursor.virtual, dinfo->cursor.offset,
+		dinfo->cursor.physical);
+
+	DBG_MSG("options: accel =3D %d, hwcursor =3D %d, fixed =3D %d, "
+		"noinit =3D %d\n", accel, hwcursor, fixed, noinit);
+	DBG_MSG("options: mode =3D \"%s\"\n", mode ? mode : "");
+
+	if (probeonly)
+		bailout(dinfo);
+
+	/*
+	 * Check if the LVDS port or any DVO ports are enabled.  If so,
+	 * don't allow mode switching
+	 */
+	dvo =3D intelfbhw_check_non_crt(dinfo);
+	if (dvo) {
+		dinfo->fixed_mode =3D 1;
+		WRN_MSG("Non-CRT device is enabled ( ");
+		i =3D 0;
+		while (dvo) {
+			if (dvo & 1) {
+				s =3D intelfbhw_dvo_to_string(1 << i);
+				if (s)
+					printk("%s ", s);
+			}
+			dvo >>=3D 1;
+			++i;
+		}
+		printk(").  Disabling mode switching.\n");
+	}
+
+	if (bailearly =3D=3D 1)
+		bailout(dinfo);
+
+	if (FIXED_MODE(dinfo) && ORIG_VIDEO_ISVGA !=3D VIDEO_TYPE_VLFB) {
+		ERR_MSG("Video mode must be programmed at boot time.\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	if (bailearly =3D=3D 2)
+		bailout(dinfo);
+
+	/* Initialise dinfo and related data. */
+	/* If an initial mode was programmed at boot time, get its details. */
+	if (ORIG_VIDEO_ISVGA =3D=3D VIDEO_TYPE_VLFB)
+		get_initial_mode(dinfo);
+
+	if (bailearly =3D=3D 3)
+		bailout(dinfo);
+
+	if (FIXED_MODE(dinfo)) {
+		/* remap fb address */
+		update_dinfo(dinfo, &dinfo->initial_var);
+	}
+
+	if (bailearly =3D=3D 4)
+		bailout(dinfo);
+
+
+	if (intelfb_set_fbinfo(dinfo)) {
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	if (bailearly =3D=3D 5)
+		bailout(dinfo);
+
+	for (i =3D 0; i < 16; i++) {
+		j =3D color_table[i];
+		dinfo->palette[i].red =3D default_red[j];
+		dinfo->palette[i].green =3D default_grn[j];
+		dinfo->palette[i].blue =3D default_blu[j];
+	}
+
+	if (bailearly =3D=3D 6)
+		bailout(dinfo);
+
+	pci_set_drvdata(pdev, dinfo);
+
+	/* Save the initial register state. */
+	i =3D intelfbhw_read_hw_state(dinfo, &dinfo->save_state,
+				    bailearly > 6 ? bailearly - 6 : 0);
+	if (i !=3D 0) {
+		DBG_MSG("intelfbhw_read_hw_state returned %d\n", i);
+		bailout(dinfo);
+	}
+
+	intelfbhw_print_hw_state(dinfo, &dinfo->save_state);
+
+	if (bailearly =3D=3D 18)
+		bailout(dinfo);
+
+#if TEST_MODE_TO_HW
+	{
+		struct intelfb_hwstate hw;
+		struct fb_var_screeninfo var;
+		int i;
+
+		for (i =3D 0; i < num_modes; i++) {
+			mode_to_var(&modedb[i], &var, 8);
+			intelfbhw_read_hw_state(dinfo, &hw, 0);
+			if (intelfbhw_mode_to_hw(dinfo, &hw, &var)) {
+				DBG_MSG("Failed to set hw for mode %dx%d\n",
+					var.xres, var.yres);
+			} else {
+				DBG_MSG("HW state for mode %dx%d\n",
+					var.xres, var.yres);
+				intelfbhw_print_hw_state(dinfo, &hw);
+			}
+		}
+	}
+#endif
+
+	/* Cursor initialisation */
+	if (dinfo->hwcursor) {
+		intelfbhw_cursor_init(dinfo);
+		intelfbhw_cursor_reset(dinfo);
+	}
+
+	if (bailearly =3D=3D 19)
+		bailout(dinfo);
+
+	/* 2d acceleration init */
+	if (dinfo->accel)
+		intelfbhw_2d_start(dinfo);
+
+	if (bailearly =3D=3D 20)
+		bailout(dinfo);
+
+	if (noregister)
+		bailout(dinfo);
+
+	if (register_framebuffer(dinfo->info) < 0) {
+		ERR_MSG("Cannot register framebuffer.\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	dinfo->registered =3D 1;
+
+	return 0;
+
+err_out_pixmap:
+	fb_dealloc_cmap(&info->cmap);
+err_out_cmap:
+	framebuffer_release(info);
+	return -ENODEV;
+}
+
+static void __devexit
+intelfb_pci_unregister(struct pci_dev *pdev)
+{
+	struct intelfb_info *dinfo =3D pci_get_drvdata(pdev);
+
+	DBG_MSG("intelfb_pci_unregister\n");
+
+	if (!dinfo)
+		return;
+
+	cleanup(dinfo);
+
+	pci_set_drvdata(pdev, NULL);
+}
+
+/***************************************************************
+ *                       helper functions                      *
+ ***************************************************************/
+
+/*
+ * A simplified version of fb_find_mode.  The latter doesn't seem to work
+ * too well -- haven't figured out why yet.
+ */
+static int
+intelfb_find_mode(struct fb_var_screeninfo *var,
+		  struct fb_info *info, const char *mode_option,
+		  const struct fb_videomode *db, unsigned int dbsize,
+		  const struct fb_videomode *default_mode,
+		  unsigned int default_bpp)
+{
+	int i;
+	char mname[20] =3D "", tmp[20] =3D "", *p, *q;
+	unsigned int bpp =3D 0;
+
+	DBG_MSG("intelfb_find_mode\n");
+
+	/* Set up defaults */
+	if (!db) {
+		db =3D modedb;
+		dbsize =3D sizeof(modedb) / sizeof(*modedb);
+	}
+
+	if (!default_bpp)
+		default_bpp =3D 16;
+
+	var->activate =3D FB_ACTIVATE_TEST;
+	if (mode_option && *mode_option) {
+		if (strlen(mode_option) < sizeof(tmp) - 1) {
+			strcat(tmp, mode_option);
+			q =3D tmp;
+			p =3D strsep(&q, "-");
+			strcat(mname, p);
+			if (q) {
+				p =3D strsep(&q, "@");
+				bpp =3D simple_strtoul(p, NULL, 10);
+				if (q) {
+					strcat(mname, "@");
+					strcat(mname, q);
+				}
+			}
+		}
+		if (!bpp)
+			bpp =3D default_bpp;
+		DBG_MSG("Mode is %s, bpp %d\n", mname, bpp);
+	}
+	if (*mname) {
+		for (i =3D 0; i < dbsize; i++) {
+			if (!strncmp(db[i].name, mname, strlen(mname))) {
+				mode_to_var(&db[i], var, bpp);
+				if (!intelfb_check_var(var, info))
+					return 1;
+			}
+		}
+	}
+
+	if (!default_mode)
+		return 0;
+
+	mode_to_var(default_mode, var, default_bpp);
+	if (!intelfb_check_var(var, info))
+		return 3;
+
+	for (i =3D 0; i < dbsize; i++) {
+		mode_to_var(&db[i], var, default_bpp);
+		if (!intelfb_check_var(var, info))
+			return 4;
+	}
+
+	return 0;
+}
+
+int
+intelfb_var_to_depth(const struct fb_var_screeninfo *var)
+{
+	DBG_MSG("intelfb_var_to_depth: bpp: %d, green.length is %d\n",
+		var->bits_per_pixel, var->green.length);
+
+	switch (var->bits_per_pixel) {
+	case 16:
+		return (var->green.length =3D=3D 6) ? 16 : 15;
+	case 32:
+		return 24;
+	default:
+		return var->bits_per_pixel;
+	}
+}
+
+static void
+get_initial_mode(struct intelfb_info *dinfo)
+{
+	struct fb_var_screeninfo *var;
+	int xtot, ytot;
+
+	DBG_MSG("get_initial_mode\n");
+
+	dinfo->initial_vga =3D 1;
+	dinfo->initial_fb_base =3D screen_info.lfb_base;
+	dinfo->initial_video_ram =3D screen_info.lfb_size * KB(64);
+	dinfo->initial_pitch =3D screen_info.lfb_linelength;
+
+	var =3D &dinfo->initial_var;
+	memset(var, 0, sizeof(*var));
+	var->xres =3D screen_info.lfb_width;
+	var->yres =3D screen_info.lfb_height;
+	var->xres_virtual =3D var->xres;
+#if ALLOCATE_FOR_PANNING
+	/* Allow use of half of the video ram for panning */
+	var->yres_virtual =3D
+		dinfo->initial_video_ram / 2 / dinfo->initial_pitch;
+	if (var->yres_virtual < var->yres)
+		var->yres_virtual =3D var->yres;
+#else
+	var->yres_virtual =3D var->yres;
+#endif
+	var->bits_per_pixel =3D screen_info.lfb_depth;
+	switch (screen_info.lfb_depth) {
+	case 15:
+		var->bits_per_pixel =3D 16;
+		break;
+	case 24:
+		var->bits_per_pixel =3D 32;
+		break;
+	}
+
+	DBG_MSG("Initial info: FB is 0x%x/0x%x (%d kByte)\n",
+		dinfo->initial_fb_base, dinfo->initial_video_ram,
+		BtoKB(dinfo->initial_video_ram));
+
+	DBG_MSG("Initial info: mode is %dx%d-%d (%d)\n",
+		var->xres, var->yres, var->bits_per_pixel,
+		dinfo->initial_pitch);
+
+	/* Dummy timing values (assume 60Hz) */
+	var->left_margin =3D (var->xres / 8) & 0xf8;
+	var->right_margin =3D 32;
+	var->upper_margin =3D 16;
+	var->lower_margin =3D 4;
+	var->hsync_len =3D (var->xres / 8) & 0xf8;
+	var->vsync_len =3D 4;
+
+	xtot =3D var->xres + var->left_margin +
+		var->right_margin + var->hsync_len;
+	ytot =3D var->yres + var->upper_margin +
+		var->lower_margin + var->vsync_len;
+	var->pixclock =3D 10000000 / xtot * 1000 / ytot * 100 / 60;
+
+	var->height =3D -1;
+	var->width =3D -1;
+
+	if (var->bits_per_pixel > 8) {
+		var->red.offset =3D screen_info.red_pos;
+		var->red.length =3D screen_info.red_size;
+		var->green.offset =3D screen_info.green_pos;
+		var->green.length =3D screen_info.green_size;
+		var->blue.offset =3D screen_info.blue_pos;
+		var->blue.length =3D screen_info.blue_size;
+		var->transp.offset =3D screen_info.rsvd_pos;
+		var->transp.length =3D screen_info.rsvd_size;
+	} else {
+		var->red.length =3D 8;
+		var->green.length =3D 8;
+		var->blue.length =3D 8;
+	}
+}
+
+/* Convert a mode to a var, also making the bpp a supported value. */
+static void
+mode_to_var(const struct fb_videomode *mode, struct fb_var_screeninfo *var,
+	    u32 bpp)
+{
+	if (!mode || !var)
+		return;
+
+	var->xres =3D mode->xres;
+	var->yres =3D mode->yres;
+	var->xres_virtual =3D mode->xres;
+	var->yres_virtual =3D mode->yres;
+	var->xoffset =3D 0;
+	var->yoffset =3D 0;
+	if (bpp <=3D 8)
+		var->bits_per_pixel =3D 8;
+	else if (bpp <=3D 16) {
+		if (bpp =3D=3D 16)
+			var->green.length =3D 6;
+		var->bits_per_pixel =3D 16;
+	} else if (bpp <=3D 32)
+		var->bits_per_pixel =3D 32;
+	else {
+		WRN_MSG("var_to_mode: bad bpp: %d\n", bpp);
+		var->bits_per_pixel =3D bpp;
+	}
+	var->pixclock =3D mode->pixclock;
+	var->left_margin =3D mode->left_margin;
+	var->right_margin =3D mode->right_margin;
+	var->upper_margin =3D mode->upper_margin;
+	var->lower_margin =3D mode->lower_margin;
+	var->hsync_len =3D mode->hsync_len;
+	var->vsync_len =3D mode->vsync_len;
+	var->sync =3D mode->sync;
+	var->vmode =3D mode->vmode;
+	var->width =3D -1;
+	var->height =3D -1;
+}
+
+static __inline__ int
+var_to_refresh(const struct fb_var_screeninfo *var)
+{
+	int xtot =3D var->xres + var->left_margin + var->right_margin +
+		   var->hsync_len;
+	int ytot =3D var->yres + var->upper_margin + var->lower_margin +
+		   var->vsync_len;
+
+	return (1000000000 / var->pixclock * 1000 + 500) / xtot / ytot;
+}
+
+/***************************************************************
+ *                Various intialisation functions              *
+ ***************************************************************/
+
+static int __devinit
+intelfb_init_var(struct intelfb_info *dinfo)
+{
+	int msrc =3D 0;
+
+	DBG_MSG("intelfb_init_disp_var\n");
+
+	if (dinfo->fixed_mode) {
+	        memcpy(&dinfo->info->var, &dinfo->initial_var,
+		       sizeof(struct fb_var_screeninfo));
+		msrc =3D 5;
+	} else {
+		if (mode) {
+			msrc =3D intelfb_find_mode(&dinfo->info->var,
+						 dinfo->info, mode,
+						 modedb, num_modes, NULL, 0);
+			if (msrc)
+				msrc |=3D 8;
+		}
+		if (!msrc) {
+			msrc =3D intelfb_find_mode(&dinfo->info->var,
+						 dinfo->info, PREFERRED_MODE,
+						 modedb, num_modes,
+						 &modedb[DFLT_MODE], 0);
+		}
+	}
+
+	if (!msrc) {
+		ERR_MSG("Cannot find a suitable video mode.\n");
+		return 1;
+	}
+
+	INF_MSG("Initial video mode is %dx%d-%d@%d.\n", dinfo->info->var.xres,
+		dinfo->info->var.yres, intelfb_var_to_depth(&dinfo->info->var),
+		var_to_refresh(&dinfo->info->var));
+
+	DBG_MSG("Initial video mode is from %d.\n", msrc);
+
+	if (dinfo->accel)
+		dinfo->info->var.accel_flags |=3D FB_ACCELF_TEXT;
+	else
+		dinfo->info->var.accel_flags &=3D ~FB_ACCELF_TEXT;
+
+	return 0;
+}
+
+static int __devinit
+intelfb_set_fbinfo(struct intelfb_info *dinfo)
+{
+	struct fb_info *info =3D dinfo->info;
+
+	DBG_MSG("intelfb_set_fbinfo\n");
+
+	//info->currcon =3D -1;
+	info->flags =3D FBINFO_FLAG_DEFAULT;
+	info->fbops =3D &intel_fb_ops;
+	info->pseudo_palette =3D dinfo->pseudo_palette;
+
+	info->pixmap.size =3D 64*1024;
+	info->pixmap.buf_align =3D 8;
+	info->pixmap.flags =3D FB_PIXMAP_SYSTEM;
+
+	if (intelfb_init_var(dinfo))
+		return 1;
+
+	info->pixmap.scan_align =3D 1;
+
+	update_dinfo(dinfo, &info->var);
+
+	return 0;
+}
+
+/* Update dinfo to match the active video mode. */
+static void
+update_dinfo(struct intelfb_info *dinfo, struct fb_var_screeninfo *var)
+{
+	DBG_MSG("update_dinfo\n");
+
+	dinfo->bpp =3D var->bits_per_pixel;
+	dinfo->depth =3D intelfb_var_to_depth(var);
+	dinfo->xres =3D var->xres;
+	dinfo->yres =3D var->xres;
+	dinfo->pixclock =3D var->pixclock;
+
+	intelfb_get_fix(&dinfo->info->fix, dinfo->info);
+
+	switch (dinfo->bpp) {
+	case 8:
+		dinfo->visual =3D FB_VISUAL_PSEUDOCOLOR;
+		dinfo->pitch =3D var->xres_virtual;
+		break;
+	case 16:
+		dinfo->visual =3D FB_VISUAL_TRUECOLOR;
+		dinfo->pitch =3D var->xres_virtual * 2;
+		break;
+	case 32:
+		dinfo->visual =3D FB_VISUAL_TRUECOLOR;
+		dinfo->pitch =3D var->xres_virtual * 4;
+		break;
+	}
+
+	/* Make sure the line length is a aligned correctly. */
+	dinfo->pitch =3D ROUND_UP_TO(dinfo->pitch, STRIDE_ALIGNMENT);
+
+	if (FIXED_MODE(dinfo))
+		dinfo->pitch =3D dinfo->initial_pitch;
+
+	dinfo->info->screen_base =3D (char *)dinfo->fb.virtual;
+	dinfo->info->fix.line_length =3D dinfo->pitch;
+	dinfo->info->fix.visual =3D dinfo->visual;
+}
+
+/* fbops functions */
+
+static int
+intelfb_get_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
+{
+	struct intelfb_info *dinfo =3D GET_DINFO(info);
+
+	DBG_MSG("intelfb_get_fix\n");
+
+	memset(fix, 0, sizeof(*fix));
+	strcpy(fix->id, dinfo->name);
+	fix->smem_start =3D dinfo->fb.physical;
+	fix->smem_len =3D dinfo->fb.size;
+	fix->type =3D FB_TYPE_PACKED_PIXELS;
+	fix->type_aux =3D 0;
+	fix->visual =3D dinfo->visual;
+	fix->xpanstep =3D 8;
+	fix->ypanstep =3D 1;
+	fix->ywrapstep =3D 0;
+	fix->line_length =3D dinfo->pitch;
+	fix->mmio_start =3D dinfo->mmio_base_phys;
+	fix->mmio_len =3D INTEL_REG_SIZE;
+	fix->accel =3D FB_ACCEL_I830;
+	return 0;
+}
+
+/***************************************************************
+ *                       fbdev interface                       *
+ ***************************************************************/
+
+static int
+intelfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	int change_var =3D 0;
+	struct fb_var_screeninfo v;
+	struct intelfb_info *dinfo;
+	static int first =3D 1;
+
+	DBG_MSG("intelfb_check_var: accel_flags is %d\n", var->accel_flags);
+
+	dinfo =3D GET_DINFO(info);
+
+	if (intelfbhw_validate_mode(dinfo, var) !=3D 0)
+		return -EINVAL;
+
+	memcpy(&v, var, sizeof(v));
+
+	/* Check for a supported bpp. */
+	if (v.bits_per_pixel <=3D 8) {
+		v.bits_per_pixel =3D 8;
+	} else if (v.bits_per_pixel <=3D 16) {
+		if (v.bits_per_pixel =3D=3D 16)
+			v.green.length =3D 6;
+		v.bits_per_pixel =3D 16;
+	} else if (v.bits_per_pixel <=3D 32) {
+		v.bits_per_pixel =3D 32;
+	} else
+		return -EINVAL;
+
+	change_var =3D ((info->var.xres !=3D var->xres) ||
+		      (info->var.yres !=3D var->yres) ||
+		      (info->var.xres_virtual !=3D var->xres_virtual) ||
+		      (info->var.yres_virtual !=3D var->yres_virtual) ||
+		      (info->var.bits_per_pixel !=3D var->bits_per_pixel) ||
+		      memcmp(&info->var.red, &var->red, sizeof(var->red)) ||
+		      memcmp(&info->var.green, &var->green,
+			     sizeof(var->green)) ||
+		      memcmp(&info->var.blue, &var->blue, sizeof(var->blue)));
+
+	if (FIXED_MODE(dinfo) &&
+	    (change_var ||
+	     var->yres_virtual > dinfo->initial_var.yres_virtual ||
+	     var->yres_virtual < dinfo->initial_var.yres ||
+	     var->xoffset || var->nonstd)) {
+		if (first) {
+			ERR_MSG("Changing the video mode is not supported.\n");
+			first =3D 0;
+		}
+		return -EINVAL;
+	}
+
+	switch (intelfb_var_to_depth(&v)) {
+	case 8:
+		v.red.offset =3D v.green.offset =3D v.blue.offset =3D 0;
+		v.red.length =3D v.green.length =3D v.blue.length =3D 8;
+		v.transp.offset =3D v.transp.length =3D 0;
+		break;
+	case 15:
+		v.red.offset =3D 10;
+		v.green.offset =3D 5;
+		v.blue.offset =3D 0;
+		v.red.length =3D v.green.length =3D v.blue.length =3D 5;
+		v.transp.offset =3D v.transp.length =3D 0;
+		break;
+	case 16:
+		v.red.offset =3D 11;
+		v.green.offset =3D 5;
+		v.blue.offset =3D 0;
+		v.red.length =3D 5;
+		v.green.length =3D 6;
+		v.blue.length =3D 5;
+		v.transp.offset =3D v.transp.length =3D 0;
+		break;
+	case 24:
+		v.red.offset =3D 16;
+		v.green.offset =3D 8;
+		v.blue.offset =3D 0;
+		v.red.length =3D v.green.length =3D v.blue.length =3D 8;
+		v.transp.offset =3D v.transp.length =3D 0;
+		break;
+	case 32:
+		v.red.offset =3D 16;
+		v.green.offset =3D 8;
+		v.blue.offset =3D 0;
+		v.red.length =3D v.green.length =3D v.blue.length =3D 8;
+		v.transp.offset =3D 24;
+		v.transp.length =3D 8;
+		break;
+	}
+
+	if (v.xoffset < 0)
+		v.xoffset =3D 0;
+	if (v.yoffset < 0)
+		v.yoffset =3D 0;
+
+	if (v.xoffset > v.xres_virtual - v.xres)
+		v.xoffset =3D v.xres_virtual - v.xres;
+	if (v.yoffset > v.yres_virtual - v.yres)
+		v.yoffset =3D v.yres_virtual - v.yres;
+
+	v.red.msb_right =3D v.green.msb_right =3D v.blue.msb_right =3D
+			  v.transp.msb_right =3D 0;
+
+        memcpy(var, &v, sizeof(v));
+
+	return 0;
+}
+
+static int
+intelfb_set_par(struct fb_info *info)
+{
+	struct intelfb_hwstate hw;
+
+        struct intelfb_info *dinfo =3D GET_DINFO(info);
+
+	if (FIXED_MODE(dinfo)) {
+		ERR_MSG("Changing the video mode is not supported.\n");
+		return -EINVAL;
+	}
+
+	DBG_MSG("intelfb_set_par (%dx%d-%d)\n", info->var.xres,
+		info->var.yres, intelfb_var_to_depth(&info->var));
+
+	intelfb_blank(1, info);
+
+	if (dinfo->accel)
+		intelfbhw_2d_stop(dinfo);
+
+	mdelay(100);
+
+	memcpy(&hw, &dinfo->save_state, sizeof(hw));
+	if (intelfbhw_mode_to_hw(dinfo, &hw, &info->var))
+		return -EINVAL;
+	if (intelfbhw_program_mode(dinfo, &hw, 0))
+		return -EINVAL;
+
+#if REGDUMP > 0
+	intelfbhw_read_hw_state(dinfo, &hw, 0);
+	intelfbhw_print_hw_state(dinfo, &hw);
+#endif
+
+	update_dinfo(dinfo, &info->var);
+
+	mdelay(100);
+
+	if (dinfo->accel)
+		intelfbhw_2d_start(dinfo);
+
+	intelfbhw_pan_display(&info->var, info);
+
+	intelfb_blank(0, info);
+
+	return 0;
+}
+
+static int
+intelfb_setcolreg(unsigned regno, unsigned red, unsigned green,
+		  unsigned blue, unsigned transp, struct fb_info *info)
+{
+	struct intelfb_info *dinfo =3D GET_DINFO(info);
+
+#if VERBOSE > 0
+	DBG_MSG("intelfb_setcolreg: regno %d, depth %d\n", regno, dinfo->depth);
+#endif
+
+	if (regno > 255)
+		return 1;
+
+	switch (dinfo->depth) {
+	case 8:
+		{
+			red >>=3D 8;
+			green >>=3D 8;
+			blue >>=3D 8;
+
+			dinfo->palette[regno].red =3D red;
+			dinfo->palette[regno].green =3D green;
+			dinfo->palette[regno].blue =3D blue;
+
+			intelfbhw_setcolreg(dinfo, regno, red, green, blue,
+					    transp);
+		}
+		break;
+	case 15:
+		dinfo->pseudo_palette[regno] =3D ((red & 0xf800) >>  1) |
+					       ((green & 0xf800) >>  6) |
+					       ((blue & 0xf800) >> 11);
+		break;
+	case 16:
+		dinfo->pseudo_palette[regno] =3D (red & 0xf800) |
+					       ((green & 0xfc00) >>  5) |
+					       ((blue  & 0xf800) >> 11);
+		break;
+	case 24:
+		dinfo->pseudo_palette[regno] =3D ((red & 0xff00) << 8) |
+					       (green & 0xff00) |
+					       ((blue  & 0xff00) >> 8);
+		break;
+	}
+	return 0;
+}
+
+static int
+intelfb_blank(int blank, struct fb_info *info)
+{
+	intelfbhw_do_blank(blank, info);
+	return 0;
+}
+
+static int
+intelfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	intelfbhw_pan_display(var, info);
+	return 0;
+}
+
+/* When/if we have our own ioctls. */
+static int
+intelfb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	      unsigned long arg, struct fb_info *info)
+{
+	int retval =3D 0;
+
+	return retval;
+}
+
+static void
+intelfb_fillrect (struct fb_info *info, const struct fb_fillrect *rect)
+{
+        struct intelfb_info *dinfo =3D GET_DINFO(info);
+	u32 rop, color;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfb_fillrect\n");
+#endif
+
+	if (!dinfo->accel || dinfo->ring_lockup || dinfo->depth =3D=3D 4)
+		return cfb_fillrect(info, rect);
+
+	if (rect->rop =3D=3D ROP_COPY)
+		rop =3D PAT_ROP_GXCOPY;
+	else // ROP_XOR
+		rop =3D PAT_ROP_GXXOR;
+
+	if (dinfo->depth !=3D 8)
+		color =3D dinfo->pseudo_palette[rect->color];
+	else
+		color =3D rect->color;
+
+	intelfbhw_do_fillrect(dinfo, rect->dx, rect->dy,
+			      rect->width, rect->height, color,
+			      dinfo->pitch, info->var.bits_per_pixel,
+			      rop);
+}
+
+static void
+intelfb_copyarea(struct fb_info *info, const struct fb_copyarea *region)
+{
+        struct intelfb_info *dinfo =3D GET_DINFO(info);
+
+#if VERBOSE > 0
+	DBG_MSG("intelfb_copyarea\n");
+#endif
+
+	if (!dinfo->accel || dinfo->ring_lockup || dinfo->depth =3D=3D 4)
+		return cfb_copyarea(info, region);
+
+	intelfbhw_do_bitblt(dinfo, region->sx, region->sy, region->dx,
+			    region->dy, region->width, region->height,
+			    dinfo->pitch, info->var.bits_per_pixel);
+}
+
+static void
+intelfb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+        struct intelfb_info *dinfo =3D GET_DINFO(info);
+	u32 fgcolor, bgcolor;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfb_imageblit\n");
+#endif
+
+	if (!dinfo->accel || dinfo->ring_lockup || dinfo->depth =3D=3D 4
+	    || image->depth !=3D 1)
+		return cfb_imageblit(info, image);
+
+	if (dinfo->depth !=3D 8) {
+		fgcolor =3D dinfo->pseudo_palette[image->fg_color];
+		bgcolor =3D dinfo->pseudo_palette[image->bg_color];
+	} else {
+		fgcolor =3D image->fg_color;
+		bgcolor =3D image->bg_color;
+	}
+
+	if (!intelfbhw_do_drawglyph(dinfo, fgcolor, bgcolor, image->width,
+				    image->height, image->data,
+				    image->dx, image->dy,
+				    dinfo->pitch, info->var.bits_per_pixel))
+		return cfb_imageblit(info, image);
+}
+
+static int
+intelfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+        struct intelfb_info *dinfo =3D GET_DINFO(info);
+
+#if VERBOSE > 0
+	DBG_MSG("intelfb_cursor\n");
+#endif
+
+	if (!dinfo->hwcursor)
+		return soft_cursor(info, cursor);
+
+	intelfbhw_cursor_hide(dinfo);
+
+	/* If XFree killed the cursor - restore it */
+	if (INREG(CURSOR_A_BASEADDR) !=3D dinfo->cursor.physical) {
+		u32 fg, bg;
+
+		DBG_MSG("the cursor was killed - restore it !!\n");
+		DBG_MSG("size %d, %d   pos %d, %d\n",
+			cursor->image.width, cursor->image.height,
+			cursor->image.dx, cursor->image.dy);
+
+		intelfbhw_cursor_init(dinfo);
+		intelfbhw_cursor_reset(dinfo);
+		intelfbhw_cursor_setpos(dinfo, cursor->image.dx,
+					cursor->image.dy);
+
+		if (dinfo->depth !=3D 8) {
+			fg =3Ddinfo->pseudo_palette[cursor->image.fg_color];
+			bg =3Ddinfo->pseudo_palette[cursor->image.bg_color];
+		} else {
+			fg =3D cursor->image.fg_color;
+			bg =3D cursor->image.bg_color;
+		}
+		intelfbhw_cursor_setcolor(dinfo, bg, fg);
+		intelfbhw_cursor_load(dinfo, cursor->image.width,
+				      cursor->image.height,
+				      dinfo->cursor_src);
+
+		if (cursor->enable)
+			intelfbhw_cursor_show(dinfo);
+		return 0;
+	}
+
+	if (cursor->set & FB_CUR_SETPOS) {
+		u32 dx, dy;
+
+		dx =3D cursor->image.dx - info->var.xoffset;
+		dy =3D cursor->image.dy - info->var.yoffset;
+
+		intelfbhw_cursor_setpos(dinfo, dx, dy);
+	}
+
+	if (cursor->set & FB_CUR_SETSIZE) {
+		if (cursor->image.width > 64 || cursor->image.height > 64)
+			return -ENXIO;
+
+		intelfbhw_cursor_reset(dinfo);
+	}
+
+	if (cursor->set & FB_CUR_SETCMAP) {
+		u32 fg, bg;
+
+		if (dinfo->depth !=3D 8) {
+			fg =3D dinfo->pseudo_palette[cursor->image.fg_color];
+			bg =3D dinfo->pseudo_palette[cursor->image.bg_color];
+		} else {
+			fg =3D cursor->image.fg_color;
+			bg =3D cursor->image.bg_color;
+		}
+
+		intelfbhw_cursor_setcolor(dinfo, bg, fg);
+	}
+
+	if (cursor->set & FB_CUR_SETSHAPE) {
+		u32 s_pitch =3D (ROUND_UP_TO(cursor->image.width, 8) / 8);
+		u32 size =3D s_pitch * cursor->image.height;
+		u8 *dat =3D (u8 *) cursor->image.data;
+		u8 *msk =3D (u8 *) cursor->mask;
+		u8 src[64];
+		u32 i;
+
+		if (cursor->image.depth !=3D 1)
+			return -ENXIO;
+
+		switch (cursor->rop) {
+		case ROP_XOR:
+			for (i =3D 0; i < size; i++)
+				src[i] =3D dat[i] ^ msk[i];
+			break;
+		case ROP_COPY:
+		default:
+			for (i =3D 0; i < size; i++)
+				src[i] =3D dat[i] & msk[i];
+			break;
+		}
+
+		/* save the bitmap to restore it when XFree will
+		   make the cursor dirty */
+		memcpy(dinfo->cursor_src, src, size);
+
+		intelfbhw_cursor_load(dinfo, cursor->image.width,
+				      cursor->image.height, src);
+	}
+
+	if (cursor->enable)
+		intelfbhw_cursor_show(dinfo);
+
+	return 0;
+}
+
+static int
+intelfb_sync(struct fb_info *info)
+{
+        struct intelfb_info *dinfo =3D GET_DINFO(info);
+
+#if VERBOSE > 0
+	DBG_MSG("intelfb_sync\n");
+#endif
+
+	if (dinfo->ring_lockup)
+		return 0;
+
+	intelfbhw_do_sync(dinfo);
+	return 0;
+}
+
diff -Nru a/drivers/video/intelfb/intelfbdrv.h b/drivers/video/intelfb/inte=
lfbdrv.h
=2D-- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/intelfb/intelfbdrv.h	2004-10-21 05:06:42 +08:00
@@ -0,0 +1,77 @@
+#ifndef _INTELFBDRV_H
+#define _INTELFBDRV_H
+
+/*
+ *************************************************************************=
*****
+ * intelfb
+ *
+ * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G
+ * integrated graphics chips.
+ *
+ * Copyright =A9 2004 Sylvain Meyer
+ *
+ * Author: Sylvain Meyer
+ *
+ *************************************************************************=
*****
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+int __init intelfb_setup(char *options);
+static void get_initial_mode(struct intelfb_info *dinfo);
+static void update_dinfo(struct intelfb_info *dinfo,
+			 struct fb_var_screeninfo *var);
+static int intelfb_get_fix(struct fb_fix_screeninfo *fix,
+			   struct fb_info *info);
+static void mode_to_var(const struct fb_videomode *mode,
+			struct fb_var_screeninfo *var, u32 bpp);
+static int
+intelfb_find_mode(struct fb_var_screeninfo *var,
+		  struct fb_info *info, const char *mode_option,
+		  const struct fb_videomode *db, unsigned int dbsize,
+		  const struct fb_videomode *default_mode,
+		  unsigned int default_bpp);
+
+static int intelfb_check_var(struct fb_var_screeninfo *var,
+			     struct fb_info *info);
+static int intelfb_set_par(struct fb_info *info);
+static int intelfb_setcolreg(unsigned regno, unsigned red, unsigned green,
+			     unsigned blue, unsigned transp,
+			     struct fb_info *info);
+
+static int intelfb_blank(int blank, struct fb_info *info);
+static int intelfb_pan_display(struct fb_var_screeninfo *var,
+			       struct fb_info *info);
+
+static void intelfb_fillrect(struct fb_info *info,
+			     const struct fb_fillrect *rect);
+static void intelfb_copyarea(struct fb_info *info,
+			     const struct fb_copyarea *region);
+static void intelfb_imageblit(struct fb_info *info,
+			      const struct fb_image *image);
+static int intelfb_cursor(struct fb_info *info,
+			   struct fb_cursor *cursor);
+
+static int intelfb_sync(struct fb_info *info);
+
+static int intelfb_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg,
+			 struct fb_info *info);
+
+static int intelfb_pci_register(struct pci_dev *pdev,
+				const struct pci_device_id *ent);
+static void __devexit intelfb_pci_unregister(struct pci_dev *pdev);
+static int __devinit intelfb_set_fbinfo(struct intelfb_info *dinfo);
+
+#endif
diff -Nru a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/intel=
fbhw.c
=2D-- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/intelfb/intelfbhw.c	2004-10-21 05:06:43 +08:00
@@ -0,0 +1,1749 @@
+/*
+ * intelfb
+ *
+ * Linux framebuffer driver for Intel(R) 865G integrated graphics chips.
+ *
+ * Copyright =A9 2002, 2003 David Dawes <dawes@xfree86.org>
+ *                   2004 Sylvain Meyer
+ *
+ * This driver consists of two parts.  The first part (intelfbdrv.c) provi=
des
+ * the basic fbdev interfaces, is derived in part from the radeonfb and
+ * vesafb drivers, and is covered by the GPL.  The second part (intelfbhw.=
c)
+ * provides the code to program the hardware.  Most of it is derived from
+ * the i810/i830 XFree86 driver.  The HW-specific code is covered here
+ * under a dual license (GPL and MIT/XFree86 license).
+ *
+ * Author: David Dawes
+ *
+ */
+
+/* $DHD: intelfb/intelfbhw.c,v 1.9 2003/06/27 15:06:25 dawes Exp $ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/console.h>
+#include <linux/selection.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+#include <linux/kd.h>
+#include <linux/vt_kern.h>
+#include <linux/pagemap.h>
+#include <linux/version.h>
+
+#include <asm/io.h>
+
+#include "intelfb.h"
+#include "intelfbhw.h"
+
+int
+intelfbhw_get_chipset(struct pci_dev *pdev, const char **name, int *chipse=
t,
+		      int *mobile)
+{
+	u32 tmp;
+
+	if (!pdev || !name || !chipset || !mobile)
+		return 1;
+
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_INTEL_830M:
+		*name =3D "Intel(R) 830M";
+		*chipset =3D INTEL_830M;
+		*mobile =3D 1;
+		return 0;
+	case PCI_DEVICE_ID_INTEL_845G:
+		*name =3D "Intel(R) 845G";
+		*chipset =3D INTEL_845G;
+		*mobile =3D 0;
+		return 0;
+	case PCI_DEVICE_ID_INTEL_85XGM:
+		tmp =3D 0;
+		*mobile =3D 1;
+		pci_read_config_dword(pdev, INTEL_85X_CAPID, &tmp);
+		switch ((tmp >> INTEL_85X_VARIANT_SHIFT) &
+			INTEL_85X_VARIANT_MASK) {
+		case INTEL_VAR_855GME:
+			*name =3D "Intel(R) 855GME";
+			*chipset =3D INTEL_855GME;
+			return 0;
+		case INTEL_VAR_855GM:
+			*name =3D "Intel(R) 855GM";
+			*chipset =3D INTEL_855GM;
+			return 0;
+		case INTEL_VAR_852GME:
+			*name =3D "Intel(R) 852GME";
+			*chipset =3D INTEL_852GME;
+			return 0;
+		case INTEL_VAR_852GM:
+			*name =3D "Intel(R) 852GM";
+			*chipset =3D INTEL_852GM;
+			return 0;
+		default:
+			*name =3D "Intel(R) 852GM/855GM";
+			*chipset =3D INTEL_85XGM;
+			return 0;
+		}
+		break;
+	case PCI_DEVICE_ID_INTEL_865G:
+		*name =3D "Intel(R) 865G";
+		*chipset =3D INTEL_865G;
+		*mobile =3D 0;
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+int
+intelfbhw_get_memory(struct pci_dev *pdev, int *aperture_size,
+		     int *stolen_size)
+{
+	struct pci_dev *bridge_dev;
+	u16 tmp;
+
+	if (!pdev || !aperture_size || !stolen_size)
+		return 1;
+
+	/* Find the bridge device.  It is always 0:0.0 */
+	if (!(bridge_dev =3D pci_find_slot(0, PCI_DEVFN(0, 0)))) {
+		ERR_MSG("cannot find bridge device\n");
+		return 1;
+	}
+
+	/* Get the fb aperture size and "stolen" memory amount. */
+	tmp =3D 0;
+	pci_read_config_word(bridge_dev, INTEL_GMCH_CTRL, &tmp);
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_INTEL_830M:
+	case PCI_DEVICE_ID_INTEL_845G:
+		if ((tmp & INTEL_GMCH_MEM_MASK) =3D=3D INTEL_GMCH_MEM_64M)
+			*aperture_size =3D MB(64);
+		else
+			*aperture_size =3D MB(128);
+		switch (tmp & INTEL_830_GMCH_GMS_MASK) {
+		case INTEL_830_GMCH_GMS_STOLEN_512:
+			*stolen_size =3D KB(512) - KB(132);
+			return 0;
+		case INTEL_830_GMCH_GMS_STOLEN_1024:
+			*stolen_size =3D MB(1) - KB(132);
+			return 0;
+		case INTEL_830_GMCH_GMS_STOLEN_8192:
+			*stolen_size =3D MB(8) - KB(132);
+			return 0;
+		case INTEL_830_GMCH_GMS_LOCAL:
+			ERR_MSG("only local memory found\n");
+			return 1;
+		case INTEL_830_GMCH_GMS_DISABLED:
+			ERR_MSG("video memory is disabled\n");
+			return 1;
+		default:
+			ERR_MSG("unexpected GMCH_GMS value: 0x%02x\n",
+				tmp & INTEL_830_GMCH_GMS_MASK);
+			return 1;
+		}
+		break;
+	default:
+		*aperture_size =3D MB(128);
+		switch (tmp & INTEL_855_GMCH_GMS_MASK) {
+		case INTEL_855_GMCH_GMS_STOLEN_1M:
+			*stolen_size =3D MB(1) - KB(132);
+			return 0;
+		case INTEL_855_GMCH_GMS_STOLEN_4M:
+			*stolen_size =3D MB(4) - KB(132);
+			return 0;
+		case INTEL_855_GMCH_GMS_STOLEN_8M:
+			*stolen_size =3D MB(8) - KB(132);
+			return 0;
+		case INTEL_855_GMCH_GMS_STOLEN_16M:
+			*stolen_size =3D MB(16) - KB(132);
+			return 0;
+		case INTEL_855_GMCH_GMS_STOLEN_32M:
+			*stolen_size =3D MB(32) - KB(132);
+			return 0;
+		case INTEL_855_GMCH_GMS_DISABLED:
+			ERR_MSG("video memory is disabled\n");
+			return 0;
+		default:
+			ERR_MSG("unexpected GMCH_GMS value: 0x%02x\n",
+				tmp & INTEL_855_GMCH_GMS_MASK);
+			return 1;
+		}
+	}
+}
+
+int
+intelfbhw_check_non_crt(struct intelfb_info *dinfo)
+{
+	int dvo =3D 0;
+
+	if (INREG(LVDS) & PORT_ENABLE)
+		dvo |=3D LVDS_PORT;
+	if (INREG(DVOA) & PORT_ENABLE)
+		dvo |=3D DVOA_PORT;
+	if (INREG(DVOB) & PORT_ENABLE)
+		dvo |=3D DVOB_PORT;
+	if (INREG(DVOC) & PORT_ENABLE)
+		dvo |=3D DVOC_PORT;
+
+	return dvo;
+}
+
+const char *
+intelfbhw_dvo_to_string(int dvo)
+{
+	if (dvo & DVOA_PORT)
+		return "DVO port A";
+	else if (dvo & DVOB_PORT)
+		return "DVO port B";
+	else if (dvo & DVOC_PORT)
+		return "DVO port C";
+	else if (dvo & LVDS_PORT)
+		return "LVDS port";
+	else
+		return NULL;
+}
+
+
+int
+intelfbhw_validate_mode(struct intelfb_info *dinfo,
+			struct fb_var_screeninfo *var)
+{
+	int bytes_per_pixel;
+	int tmp;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_validate_mode\n");
+#endif
+
+	bytes_per_pixel =3D var->bits_per_pixel / 8;
+	if (bytes_per_pixel =3D=3D 3)
+		bytes_per_pixel =3D 4;
+
+	/* Check if enough video memory. */
+	tmp =3D var->yres_virtual * var->xres_virtual * bytes_per_pixel;
+	if (tmp > dinfo->fb.size) {
+		WRN_MSG("Not enough video ram for mode "
+			"(%d KByte vs %d KByte).\n",
+			BtoKB(tmp), BtoKB(dinfo->fb.size));
+		return 1;
+	}
+
+	/* Check if x/y limits are OK. */
+	if (var->xres - 1 > HACTIVE_MASK) {
+		WRN_MSG("X resolution too large (%d vs %d).\n",
+			var->xres, HACTIVE_MASK + 1);
+		return 1;
+	}
+	if (var->yres - 1 > VACTIVE_MASK) {
+		WRN_MSG("Y resolution too large (%d vs %d).\n",
+			var->yres, VACTIVE_MASK + 1);
+		return 1;
+	}
+
+	/* Check for interlaced/doublescan modes. */
+	if (var->vmode & FB_VMODE_INTERLACED) {
+		WRN_MSG("Mode is interlaced.\n");
+		return 1;
+	}
+	if (var->vmode & FB_VMODE_DOUBLE) {
+		WRN_MSG("Mode is double-scan.\n");
+		return 1;
+	}
+
+	/* Check if clock is OK. */
+	tmp =3D 1000000000 / var->pixclock;
+	if (tmp < MIN_CLOCK) {
+		WRN_MSG("Pixel clock is too low (%d MHz vs %d MHz).\n",
+			(tmp + 500) / 1000, MIN_CLOCK / 1000);
+		return 1;
+	}
+	if (tmp > MAX_CLOCK) {
+		WRN_MSG("Pixel clock is too high (%d MHz vs %d MHz).\n",
+			(tmp + 500) / 1000, MAX_CLOCK / 1000);
+		return 1;
+	}
+
+	return 0;
+}
+
+int
+intelfbhw_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct intelfb_info *dinfo =3D GET_DINFO(info);
+	u32 offset, xoffset, yoffset;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_pan_display\n");
+#endif
+
+	xoffset =3D ROUND_DOWN_TO(var->xoffset, 8);
+	yoffset =3D var->yoffset;
+
+	if ((xoffset + var->xres > var->xres_virtual) ||
+	    (yoffset + var->yres > var->yres_virtual))
+		return EINVAL;
+
+	offset =3D (yoffset * dinfo->pitch) +
+		 (xoffset * var->bits_per_pixel) / 8;
+
+	offset +=3D dinfo->fb.offset >> 12;
+
+	OUTREG(DSPABASE, offset);
+
+	return 0;
+}
+
+/* Blank the screen. */
+void
+intelfbhw_do_blank(int blank, struct fb_info *info)
+{
+	struct intelfb_info *dinfo =3D GET_DINFO(info);
+	u32 tmp;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_do_blank: blank is %d\n", blank);
+#endif
+
+	/* Turn plane A on or off */
+	tmp =3D INREG(DSPACNTR);
+	if (blank)
+		tmp &=3D ~DISPPLANE_PLANE_ENABLE;
+	else
+		tmp |=3D DISPPLANE_PLANE_ENABLE;
+	OUTREG(DSPACNTR, tmp);
+	/* Flush */
+	tmp =3D INREG(DSPABASE);
+	OUTREG(DSPABASE, tmp);
+
+	/* Turn off/on the HW cursor */
+#if VERBOSE > 0
+	DBG_MSG("cursor_on is %d\n", dinfo->cursor_on);
+#endif
+	if (dinfo->cursor_on) {
+		if (blank) {
+			intelfbhw_cursor_hide(dinfo);
+		} else {
+			intelfbhw_cursor_show(dinfo);
+		}
+		dinfo->cursor_on =3D 1;
+	}
+	dinfo->cursor_blanked =3D blank;
+
+	/* Set DPMS level */
+	tmp =3D INREG(ADPA) & ~ADPA_DPMS_CONTROL_MASK;
+	switch (blank) {
+	case 0:
+	case 1:
+		tmp |=3D ADPA_DPMS_D0;
+		break;
+	case 2:
+		tmp |=3D ADPA_DPMS_D1;
+		break;
+	case 3:
+		tmp |=3D ADPA_DPMS_D2;
+		break;
+	case 4:
+		tmp |=3D ADPA_DPMS_D3;
+		break;
+	}
+	OUTREG(ADPA, tmp);
+
+	return;
+}
+
+
+void
+intelfbhw_setcolreg(struct intelfb_info *dinfo, unsigned regno,
+		    unsigned red, unsigned green, unsigned blue,
+		    unsigned transp)
+{
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_setcolreg: %d: (%d, %d, %d)\n",
+		regno, red, green, blue);
+#endif
+
+	u32 palette_reg =3D (dinfo->pipe =3D=3D PIPE_A) ?
+			  PALETTE_A : PALETTE_B;
+
+	OUTREG(palette_reg + (regno << 2),
+	       (red << PALETTE_8_RED_SHIFT) |
+	       (green << PALETTE_8_GREEN_SHIFT) |
+	       (blue << PALETTE_8_BLUE_SHIFT));
+}
+
+
+int
+intelfbhw_read_hw_state(struct intelfb_info *dinfo, struct intelfb_hwstate=
 *hw,
+			int flag)
+{
+	int i;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_read_hw_state\n");
+#endif
+
+	if (!hw || !dinfo)
+		return -1;
+
+	/* Read in as much of the HW state as possible. */
+	hw->vga0_divisor =3D INREG(VGA0_DIVISOR);
+	hw->vga1_divisor =3D INREG(VGA1_DIVISOR);
+	hw->vga_pd =3D INREG(VGAPD);
+	hw->dpll_a =3D INREG(DPLL_A);
+	hw->dpll_b =3D INREG(DPLL_B);
+	hw->fpa0 =3D INREG(FPA0);
+	hw->fpa1 =3D INREG(FPA1);
+	hw->fpb0 =3D INREG(FPB0);
+	hw->fpb1 =3D INREG(FPB1);
+
+	if (flag =3D=3D 1)
+		return flag;
+
+#if 0
+	/* This seems to be a problem with the 852GM/855GM */
+	for (i =3D 0; i < PALETTE_8_ENTRIES; i++) {
+		hw->palette_a[i] =3D INREG(PALETTE_A + (i << 2));
+		hw->palette_b[i] =3D INREG(PALETTE_B + (i << 2));
+	}
+#endif
+
+	if (flag =3D=3D 2)
+		return flag;
+
+	hw->htotal_a =3D INREG(HTOTAL_A);
+	hw->hblank_a =3D INREG(HBLANK_A);
+	hw->hsync_a =3D INREG(HSYNC_A);
+	hw->vtotal_a =3D INREG(VTOTAL_A);
+	hw->vblank_a =3D INREG(VBLANK_A);
+	hw->vsync_a =3D INREG(VSYNC_A);
+	hw->src_size_a =3D INREG(SRC_SIZE_A);
+	hw->bclrpat_a =3D INREG(BCLRPAT_A);
+	hw->htotal_b =3D INREG(HTOTAL_B);
+	hw->hblank_b =3D INREG(HBLANK_B);
+	hw->hsync_b =3D INREG(HSYNC_B);
+	hw->vtotal_b =3D INREG(VTOTAL_B);
+	hw->vblank_b =3D INREG(VBLANK_B);
+	hw->vsync_b =3D INREG(VSYNC_B);
+	hw->src_size_b =3D INREG(SRC_SIZE_B);
+	hw->bclrpat_b =3D INREG(BCLRPAT_B);
+
+	if (flag =3D=3D 3)
+		return flag;
+
+	hw->adpa =3D INREG(ADPA);
+	hw->dvoa =3D INREG(DVOA);
+	hw->dvob =3D INREG(DVOB);
+	hw->dvoc =3D INREG(DVOC);
+	hw->dvoa_srcdim =3D INREG(DVOA_SRCDIM);
+	hw->dvob_srcdim =3D INREG(DVOB_SRCDIM);
+	hw->dvoc_srcdim =3D INREG(DVOC_SRCDIM);
+	hw->lvds =3D INREG(LVDS);
+
+	if (flag =3D=3D 4)
+		return flag;
+
+	hw->pipe_a_conf =3D INREG(PIPEACONF);
+	hw->pipe_b_conf =3D INREG(PIPEBCONF);
+	hw->disp_arb =3D INREG(DISPARB);
+
+	if (flag =3D=3D 5)
+		return flag;
+
+	hw->cursor_a_control =3D INREG(CURSOR_A_CONTROL);
+	hw->cursor_b_control =3D INREG(CURSOR_B_CONTROL);
+	hw->cursor_a_base =3D INREG(CURSOR_A_BASEADDR);
+	hw->cursor_b_base =3D INREG(CURSOR_B_BASEADDR);
+
+	if (flag =3D=3D 6)
+		return flag;
+
+	for (i =3D 0; i < 4; i++) {
+		hw->cursor_a_palette[i] =3D INREG(CURSOR_A_PALETTE0 + (i << 2));
+		hw->cursor_b_palette[i] =3D INREG(CURSOR_B_PALETTE0 + (i << 2));
+	}
+
+	if (flag =3D=3D 7)
+		return flag;
+
+	hw->cursor_size =3D INREG(CURSOR_SIZE);
+
+	if (flag =3D=3D 8)
+		return flag;
+
+	hw->disp_a_ctrl =3D INREG(DSPACNTR);
+	hw->disp_b_ctrl =3D INREG(DSPBCNTR);
+	hw->disp_a_base =3D INREG(DSPABASE);
+	hw->disp_b_base =3D INREG(DSPBBASE);
+	hw->disp_a_stride =3D INREG(DSPASTRIDE);
+	hw->disp_b_stride =3D INREG(DSPBSTRIDE);
+
+	if (flag =3D=3D 9)
+		return flag;
+
+	hw->vgacntrl =3D INREG(VGACNTRL);
+
+	if (flag =3D=3D 10)
+		return flag;
+
+	hw->add_id =3D INREG(ADD_ID);
+
+	if (flag =3D=3D 11)
+		return flag;
+
+	for (i =3D 0; i < 7; i++) {
+		hw->swf0x[i] =3D INREG(SWF00 + (i << 2));
+		hw->swf1x[i] =3D INREG(SWF10 + (i << 2));
+		if (i < 3)
+			hw->swf3x[i] =3D INREG(SWF30 + (i << 2));
+	}
+
+	for (i =3D 0; i < 8; i++)
+		hw->fence[i] =3D INREG(FENCE + (i << 2));
+
+	hw->instpm =3D INREG(INSTPM);
+	hw->mem_mode =3D INREG(MEM_MODE);
+	hw->fw_blc_0 =3D INREG(FW_BLC_0);
+	hw->fw_blc_1 =3D INREG(FW_BLC_1);
+
+	return 0;
+}
+
+
+void
+intelfbhw_print_hw_state(struct intelfb_info *dinfo, struct intelfb_hwstat=
e *hw)
+{
+#if REGDUMP
+	int i, m1, m2, n, p1, p2;
+
+	DBG_MSG("intelfbhw_print_hw_state\n");
+
+	if (!hw || !dinfo)
+		return;
+	/* Read in as much of the HW state as possible. */
+	printk("hw state dump start\n");
+	printk("	VGA0_DIVISOR:		0x%08x\n", hw->vga0_divisor);
+	printk("	VGA1_DIVISOR:		0x%08x\n", hw->vga1_divisor);
+	printk("	VGAPD: 			0x%08x\n", hw->vga_pd);
+	n =3D (hw->vga0_divisor >> FP_N_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	m1 =3D (hw->vga0_divisor >> FP_M1_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	m2 =3D (hw->vga0_divisor >> FP_M2_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	if (hw->vga_pd & VGAPD_0_P1_FORCE_DIV2)
+		p1 =3D 0;
+	else
+		p1 =3D (hw->vga_pd >> VGAPD_0_P1_SHIFT) & DPLL_P1_MASK;
+	p2 =3D (hw->vga_pd >> VGAPD_0_P2_SHIFT) & DPLL_P2_MASK;
+	printk("	VGA0: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
+		m1, m2, n, p1, p2);
+	printk("	VGA0: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
+
+	n =3D (hw->vga1_divisor >> FP_N_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	m1 =3D (hw->vga1_divisor >> FP_M1_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	m2 =3D (hw->vga1_divisor >> FP_M2_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	if (hw->vga_pd & VGAPD_1_P1_FORCE_DIV2)
+		p1 =3D 0;
+	else
+		p1 =3D (hw->vga_pd >> VGAPD_1_P1_SHIFT) & DPLL_P1_MASK;
+	p2 =3D (hw->vga_pd >> VGAPD_1_P2_SHIFT) & DPLL_P2_MASK;
+	printk("	VGA1: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
+		m1, m2, n, p1, p2);
+	printk("	VGA1: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
+
+	printk("	DPLL_A:			0x%08x\n", hw->dpll_a);
+	printk("	DPLL_B:			0x%08x\n", hw->dpll_b);
+	printk("	FPA0:			0x%08x\n", hw->fpa0);
+	printk("	FPA1:			0x%08x\n", hw->fpa1);
+	printk("	FPB0:			0x%08x\n", hw->fpb0);
+	printk("	FPB1:			0x%08x\n", hw->fpb1);
+
+	n =3D (hw->fpa0 >> FP_N_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	m1 =3D (hw->fpa0 >> FP_M1_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	m2 =3D (hw->fpa0 >> FP_M2_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	if (hw->dpll_a & DPLL_P1_FORCE_DIV2)
+		p1 =3D 0;
+	else
+		p1 =3D (hw->dpll_a >> DPLL_P1_SHIFT) & DPLL_P1_MASK;
+	p2 =3D (hw->dpll_a >> DPLL_P2_SHIFT) & DPLL_P2_MASK;
+	printk("	PLLA0: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
+		m1, m2, n, p1, p2);
+	printk("	PLLA0: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
+
+	n =3D (hw->fpa1 >> FP_N_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	m1 =3D (hw->fpa1 >> FP_M1_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	m2 =3D (hw->fpa1 >> FP_M2_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
+	if (hw->dpll_a & DPLL_P1_FORCE_DIV2)
+		p1 =3D 0;
+	else
+		p1 =3D (hw->dpll_a >> DPLL_P1_SHIFT) & DPLL_P1_MASK;
+	p2 =3D (hw->dpll_a >> DPLL_P2_SHIFT) & DPLL_P2_MASK;
+	printk("	PLLA1: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
+		m1, m2, n, p1, p2);
+	printk("	PLLA1: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
+
+#if 0
+	printk("	PALETTE_A:\n");
+	for (i =3D 0; i < PALETTE_8_ENTRIES)
+		printk("	%3d:	0x%08x\n", i, hw->palette_a[i];
+	printk("	PALETTE_B:\n");
+	for (i =3D 0; i < PALETTE_8_ENTRIES)
+		printk("	%3d:	0x%08x\n", i, hw->palette_b[i];
+#endif
+
+	printk("	HTOTAL_A:		0x%08x\n", hw->htotal_a);
+	printk("	HBLANK_A:		0x%08x\n", hw->hblank_a);
+	printk("	HSYNC_A:		0x%08x\n", hw->hsync_a);
+	printk("	VTOTAL_A:		0x%08x\n", hw->vtotal_a);
+	printk("	VBLANK_A:		0x%08x\n", hw->vblank_a);
+	printk("	VSYNC_A:		0x%08x\n", hw->vsync_a);
+	printk("	SRC_SIZE_A:		0x%08x\n", hw->src_size_a);
+	printk("	BCLRPAT_A:		0x%08x\n", hw->bclrpat_a);
+	printk("	HTOTAL_B:		0x%08x\n", hw->htotal_b);
+	printk("	HBLANK_B:		0x%08x\n", hw->hblank_b);
+	printk("	HSYNC_B:		0x%08x\n", hw->hsync_b);
+	printk("	VTOTAL_B:		0x%08x\n", hw->vtotal_b);
+	printk("	VBLANK_B:		0x%08x\n", hw->vblank_b);
+	printk("	VSYNC_B:		0x%08x\n", hw->vsync_b);
+	printk("	SRC_SIZE_B:		0x%08x\n", hw->src_size_b);
+	printk("	BCLRPAT_B:		0x%08x\n", hw->bclrpat_b);
+
+	printk("	ADPA:			0x%08x\n", hw->adpa);
+	printk("	DVOA:			0x%08x\n", hw->dvoa);
+	printk("	DVOB:			0x%08x\n", hw->dvob);
+	printk("	DVOC:			0x%08x\n", hw->dvoc);
+	printk("	DVOA_SRCDIM:		0x%08x\n", hw->dvoa_srcdim);
+	printk("	DVOB_SRCDIM:		0x%08x\n", hw->dvob_srcdim);
+	printk("	DVOC_SRCDIM:		0x%08x\n", hw->dvoc_srcdim);
+	printk("	LVDS:			0x%08x\n", hw->lvds);
+
+	printk("	PIPEACONF:		0x%08x\n", hw->pipe_a_conf);
+	printk("	PIPEBCONF:		0x%08x\n", hw->pipe_b_conf);
+	printk("	DISPARB:		0x%08x\n", hw->disp_arb);
+
+	printk("	CURSOR_A_CONTROL:	0x%08x\n", hw->cursor_a_control);
+	printk("	CURSOR_B_CONTROL:	0x%08x\n", hw->cursor_b_control);
+	printk("	CURSOR_A_BASEADDR:	0x%08x\n", hw->cursor_a_base);
+	printk("	CURSOR_B_BASEADDR:	0x%08x\n", hw->cursor_b_base);
+
+	printk("	CURSOR_A_PALETTE:	");
+	for (i =3D 0; i < 4; i++) {
+		printk("0x%08x", hw->cursor_a_palette[i]);
+		if (i < 3)
+			printk(", ");
+	}
+	printk("\n");
+	printk("	CURSOR_B_PALETTE:	");
+	for (i =3D 0; i < 4; i++) {
+		printk("0x%08x", hw->cursor_b_palette[i]);
+		if (i < 3)
+			printk(", ");
+	}
+	printk("\n");
+
+	printk("	CURSOR_SIZE:		0x%08x\n", hw->cursor_size);
+
+	printk("	DSPACNTR:		0x%08x\n", hw->disp_a_ctrl);
+	printk("	DSPBCNTR:		0x%08x\n", hw->disp_b_ctrl);
+	printk("	DSPABASE:		0x%08x\n", hw->disp_a_base);
+	printk("	DSPBBASE:		0x%08x\n", hw->disp_b_base);
+	printk("	DSPASTRIDE:		0x%08x\n", hw->disp_a_stride);
+	printk("	DSPBSTRIDE:		0x%08x\n", hw->disp_b_stride);
+
+	printk("	VGACNTRL:		0x%08x\n", hw->vgacntrl);
+	printk("	ADD_ID:			0x%08x\n", hw->add_id);
+
+	for (i =3D 0; i < 7; i++) {
+		printk("	SWF0%d			0x%08x\n", i,
+			hw->swf0x[i]);
+	}
+	for (i =3D 0; i < 7; i++) {
+		printk("	SWF1%d			0x%08x\n", i,
+			hw->swf1x[i]);
+	}
+	for (i =3D 0; i < 3; i++) {
+		printk("	SWF3%d			0x%08x\n", i,
+			hw->swf3x[i]);
+	}
+	for (i =3D 0; i < 8; i++)
+		printk("	FENCE%d			0x%08x\n", i,
+			hw->fence[i]);
+
+	printk("	INSTPM			0x%08x\n", hw->instpm);
+	printk("	MEM_MODE		0x%08x\n", hw->mem_mode);
+	printk("	FW_BLC_0		0x%08x\n", hw->fw_blc_0);
+	printk("	FW_BLC_1		0x%08x\n", hw->fw_blc_1);
+
+	printk("hw state dump end\n");
+#endif
+}
+
+/* Split the M parameter into M1 and M2. */
+static int
+splitm(unsigned int m, unsigned int *retm1, unsigned int *retm2)
+{
+	int m1, m2;
+
+	m1 =3D (m - 2 - (MIN_M2 + MAX_M2) / 2) / 5 - 2;
+	if (m1 < MIN_M1)
+		m1 =3D MIN_M1;
+	if (m1 > MAX_M1)
+		m1 =3D MAX_M1;
+	m2 =3D m - 5 * (m1 + 2) - 2;
+	if (m2 < MIN_M2 || m2 > MAX_M2 || m2 >=3D m1) {
+		return 1;
+	} else {
+		*retm1 =3D (unsigned int)m1;
+		*retm2 =3D (unsigned int)m2;
+		return 0;
+	}
+}
+
+/* Split the P parameter into P1 and P2. */
+static int
+splitp(unsigned int p, unsigned int *retp1, unsigned int *retp2)
+{
+	int p1, p2;
+
+	if (p % 4 =3D=3D 0)
+		p2 =3D 1;
+	else
+		p2 =3D 0;
+	p1 =3D (p / (1 << (p2 + 1))) - 2;
+	if (p % 4 =3D=3D 0 && p1 < MIN_P1) {
+		p2 =3D 0;
+		p1 =3D (p / (1 << (p2 + 1))) - 2;
+	}
+	if (p1  < MIN_P1 || p1 > MAX_P1 || (p1 + 2) * (1 << (p2 + 1)) !=3D p) {
+		return 1;
+	} else {
+		*retp1 =3D (unsigned int)p1;
+		*retp2 =3D (unsigned int)p2;
+		return 0;
+	}
+}
+
+static int
+calc_pll_params(int clock, u32 *retm1, u32 *retm2, u32 *retn, u32 *retp1,
+		u32 *retp2, u32 *retclock)
+{
+	u32 m1, m2, n, p1, p2, n1;
+	u32 f_vco, p, p_best =3D 0, m, f_out;
+	u32 err_max, err_target, err_best =3D 10000000;
+	u32 n_best =3D 0, m_best =3D 0, f_best, f_err;
+	u32 p_min, p_max, p_inc, div_min, div_max;
+
+	/* Accept 0.5% difference, but aim for 0.1% */
+	err_max =3D 5 * clock / 1000;
+	err_target =3D clock / 1000;
+
+	DBG_MSG("Clock is %d\n", clock);
+
+	div_max =3D MAX_VCO_FREQ / clock;
+	div_min =3D ROUND_UP_TO(MIN_VCO_FREQ, clock) / clock;
+
+	if (clock <=3D P_TRANSITION_CLOCK)
+		p_inc =3D 4;
+	else
+		p_inc =3D 2;
+	p_min =3D ROUND_UP_TO(div_min, p_inc);
+	p_max =3D ROUND_DOWN_TO(div_max, p_inc);
+	if (p_min < MIN_P)
+		p_min =3D 4;
+	if (p_max > MAX_P)
+		p_max =3D 128;
+
+	DBG_MSG("p range is %d-%d (%d)\n", p_min, p_max, p_inc);
+
+	p =3D p_min;
+	do {
+		if (splitp(p, &p1, &p2)) {
+			WRN_MSG("cannot split p =3D %d\n", p);
+			p +=3D p_inc;
+			continue;
+		}
+		n =3D MIN_N;
+		f_vco =3D clock * p;
+
+		do {
+			m =3D ROUND_UP_TO(f_vco * n, PLL_REFCLK) / PLL_REFCLK;
+			if (m < MIN_M)
+				m =3D MIN_M;
+			if (m > MAX_M)
+				m =3D MAX_M;
+			f_out =3D CALC_VCLOCK3(m, n, p);
+			if (splitm(m, &m1, &m2)) {
+				WRN_MSG("cannot split m =3D %d\n", m);
+				n++;
+				continue;
+			}
+			if (clock > f_out)
+				f_err =3D clock - f_out;
+			else
+				f_err =3D f_out - clock;
+
+			if (f_err < err_best) {
+				m_best =3D m;
+				n_best =3D n;
+				p_best =3D p;
+				f_best =3D f_out;
+				err_best =3D f_err;
+			}
+			n++;
+		} while ((n <=3D MAX_N) && (f_out >=3D clock));
+		p +=3D p_inc;
+	} while ((p <=3D p_max));
+
+	if (!m_best) {
+		WRN_MSG("cannot find parameters for clock %d\n", clock);
+		return 1;
+	}
+	m =3D m_best;
+	n =3D n_best;
+	p =3D p_best;
+	splitm(m, &m1, &m2);
+	splitp(p, &p1, &p2);
+	n1 =3D n - 2;
+
+	DBG_MSG("m, n, p: %d (%d,%d), %d (%d), %d (%d,%d), "
+		"f: %d (%d), VCO: %d\n",
+		m, m1, m2, n, n1, p, p1, p2,
+		CALC_VCLOCK3(m, n, p), CALC_VCLOCK(m1, m2, n1, p1, p2),
+		CALC_VCLOCK3(m, n, p) * p);
+	*retm1 =3D m1;
+	*retm2 =3D m2;
+	*retn =3D n1;
+	*retp1 =3D p1;
+	*retp2 =3D p2;
+	*retclock =3D CALC_VCLOCK(m1, m2, n1, p1, p2);
+
+	return 0;
+}
+
+static __inline__ int
+check_overflow(u32 value, u32 limit, const char *description)
+{
+	if (value > limit) {
+		WRN_MSG("%s value %d exceeds limit %d\n",
+			description, value, limit);
+		return 1;
+	}
+	return 0;
+}
+
+/* It is assumed that hw is filled in with the initial state information. =
*/
+int
+intelfbhw_mode_to_hw(struct intelfb_info *dinfo, struct intelfb_hwstate *h=
w,
+		     struct fb_var_screeninfo *var)
+{
+	int pipe =3D PIPE_A;
+	u32 *dpll, *fp0, *fp1;
+	u32 m1, m2, n, p1, p2, clock_target, clock;
+	u32 hsync_start, hsync_end, hblank_start, hblank_end, htotal, hactive;
+	u32 vsync_start, vsync_end, vblank_start, vblank_end, vtotal, vactive;
+	u32 vsync_pol, hsync_pol;
+	u32 *vs, *vb, *vt, *hs, *hb, *ht, *ss, *pipe_conf;
+
+	DBG_MSG("intelfbhw_mode_to_hw\n");
+
+	/* Disable VGA */
+	hw->vgacntrl |=3D VGA_DISABLE;
+
+	/* Check whether pipe A or pipe B is enabled. */
+	if (hw->pipe_a_conf & PIPECONF_ENABLE)
+		pipe =3D PIPE_A;
+	else if (hw->pipe_b_conf & PIPECONF_ENABLE)
+		pipe =3D PIPE_B;
+
+	/* Set which pipe's registers will be set. */
+	if (pipe =3D=3D PIPE_B) {
+		dpll =3D &hw->dpll_b;
+		fp0 =3D &hw->fpb0;
+		fp1 =3D &hw->fpb1;
+		hs =3D &hw->hsync_b;
+		hb =3D &hw->hblank_b;
+		ht =3D &hw->htotal_b;
+		vs =3D &hw->vsync_b;
+		vb =3D &hw->vblank_b;
+		vt =3D &hw->vtotal_b;
+		ss =3D &hw->src_size_b;
+		pipe_conf =3D &hw->pipe_b_conf;
+	} else {
+		dpll =3D &hw->dpll_a;
+		fp0 =3D &hw->fpa0;
+		fp1 =3D &hw->fpa1;
+		hs =3D &hw->hsync_a;
+		hb =3D &hw->hblank_a;
+		ht =3D &hw->htotal_a;
+		vs =3D &hw->vsync_a;
+		vb =3D &hw->vblank_a;
+		vt =3D &hw->vtotal_a;
+		ss =3D &hw->src_size_a;
+		pipe_conf =3D &hw->pipe_a_conf;
+	}
+
+	/* Use ADPA register for sync control. */
+	hw->adpa &=3D ~ADPA_USE_VGA_HVPOLARITY;
+
+	/* sync polarity */
+	hsync_pol =3D (var->sync & FB_SYNC_HOR_HIGH_ACT) ?
+			ADPA_SYNC_ACTIVE_HIGH : ADPA_SYNC_ACTIVE_LOW;
+	vsync_pol =3D (var->sync & FB_SYNC_VERT_HIGH_ACT) ?
+			ADPA_SYNC_ACTIVE_HIGH : ADPA_SYNC_ACTIVE_LOW;
+	hw->adpa &=3D ~((ADPA_SYNC_ACTIVE_MASK << ADPA_VSYNC_ACTIVE_SHIFT) |
+		      (ADPA_SYNC_ACTIVE_MASK << ADPA_HSYNC_ACTIVE_SHIFT));
+	hw->adpa |=3D (hsync_pol << ADPA_HSYNC_ACTIVE_SHIFT) |
+		    (vsync_pol << ADPA_VSYNC_ACTIVE_SHIFT);
+
+	/* Connect correct pipe to the analog port DAC */
+	hw->adpa &=3D ~(PIPE_MASK << ADPA_PIPE_SELECT_SHIFT);
+	hw->adpa |=3D (pipe << ADPA_PIPE_SELECT_SHIFT);
+
+	/* Set DPMS state to D0 (on) */
+	hw->adpa &=3D ~ADPA_DPMS_CONTROL_MASK;
+	hw->adpa |=3D ADPA_DPMS_D0;
+
+	hw->adpa |=3D ADPA_DAC_ENABLE;
+
+	*dpll |=3D (DPLL_VCO_ENABLE | DPLL_VGA_MODE_DISABLE);
+	*dpll &=3D ~(DPLL_RATE_SELECT_MASK | DPLL_REFERENCE_SELECT_MASK);
+	*dpll |=3D (DPLL_REFERENCE_DEFAULT | DPLL_RATE_SELECT_FP0);
+
+	/* Desired clock in kHz */
+	clock_target =3D 1000000000 / var->pixclock;
+
+	if (calc_pll_params(clock_target, &m1, &m2, &n, &p1, &p2, &clock)) {
+		WRN_MSG("calc_pll_params failed\n");
+		return 1;
+	}
+
+	/* Check for overflow. */
+	if (check_overflow(p1, DPLL_P1_MASK, "PLL P1 parameter"))
+		return 1;
+	if (check_overflow(p2, DPLL_P2_MASK, "PLL P2 parameter"))
+		return 1;
+	if (check_overflow(m1, FP_DIVISOR_MASK, "PLL M1 parameter"))
+		return 1;
+	if (check_overflow(m2, FP_DIVISOR_MASK, "PLL M2 parameter"))
+		return 1;
+	if (check_overflow(n, FP_DIVISOR_MASK, "PLL N parameter"))
+		return 1;
+
+	*dpll &=3D ~DPLL_P1_FORCE_DIV2;
+	*dpll &=3D ~((DPLL_P2_MASK << DPLL_P2_SHIFT) |
+		   (DPLL_P1_MASK << DPLL_P1_SHIFT));
+	*dpll |=3D (p2 << DPLL_P2_SHIFT) | (p1 << DPLL_P1_SHIFT);
+	*fp0 =3D (n << FP_N_DIVISOR_SHIFT) |
+	       (m1 << FP_M1_DIVISOR_SHIFT) |
+	       (m2 << FP_M2_DIVISOR_SHIFT);
+	*fp1 =3D *fp0;
+
+	hw->dvob &=3D ~PORT_ENABLE;
+	hw->dvoc &=3D ~PORT_ENABLE;
+
+	/* Use display plane A. */
+	hw->disp_a_ctrl |=3D DISPPLANE_PLANE_ENABLE;
+	hw->disp_a_ctrl &=3D ~DISPPLANE_GAMMA_ENABLE;
+	hw->disp_a_ctrl &=3D ~DISPPLANE_PIXFORMAT_MASK;
+	switch (intelfb_var_to_depth(var)) {
+	case 8:
+		hw->disp_a_ctrl |=3D DISPPLANE_8BPP | DISPPLANE_GAMMA_ENABLE;
+		break;
+	case 15:
+		hw->disp_a_ctrl |=3D DISPPLANE_15_16BPP;
+		break;
+	case 16:
+		hw->disp_a_ctrl |=3D DISPPLANE_16BPP;
+		break;
+	case 24:
+		hw->disp_a_ctrl |=3D DISPPLANE_32BPP_NO_ALPHA;
+		break;
+	}
+	hw->disp_a_ctrl &=3D ~(PIPE_MASK << DISPPLANE_SEL_PIPE_SHIFT);
+	hw->disp_a_ctrl |=3D (pipe << DISPPLANE_SEL_PIPE_SHIFT);
+
+	/* Set CRTC registers. */
+	hactive =3D var->xres;
+	hsync_start =3D hactive + var->right_margin;
+	hsync_end =3D hsync_start + var->hsync_len;
+	htotal =3D hsync_end + var->left_margin;
+	hblank_start =3D hactive;
+	hblank_end =3D htotal;
+
+	DBG_MSG("H: act %d, ss %d, se %d, tot %d bs %d, be %d\n",
+		hactive, hsync_start, hsync_end, htotal, hblank_start,
+		hblank_end);
+
+	vactive =3D var->yres;
+	vsync_start =3D vactive + var->lower_margin;
+	vsync_end =3D vsync_start + var->vsync_len;
+	vtotal =3D vsync_end + var->upper_margin;
+	vblank_start =3D vactive;
+	vblank_end =3D vtotal;
+	vblank_end =3D vsync_end + 1;
+
+	DBG_MSG("V: act %d, ss %d, se %d, tot %d bs %d, be %d\n",
+		vactive, vsync_start, vsync_end, vtotal, vblank_start,
+		vblank_end);
+
+	/* Adjust for register values, and check for overflow. */
+	hactive--;
+	if (check_overflow(hactive, HACTIVE_MASK, "CRTC hactive"))
+		return 1;
+	hsync_start--;
+	if (check_overflow(hsync_start, HSYNCSTART_MASK, "CRTC hsync_start"))
+		return 1;
+	hsync_end--;
+	if (check_overflow(hsync_end, HSYNCEND_MASK, "CRTC hsync_end"))
+		return 1;
+	htotal--;
+	if (check_overflow(htotal, HTOTAL_MASK, "CRTC htotal"))
+		return 1;
+	hblank_start--;
+	if (check_overflow(hblank_start, HBLANKSTART_MASK, "CRTC hblank_start"))
+		return 1;
+	hblank_end--;
+	if (check_overflow(hblank_end, HBLANKEND_MASK, "CRTC hblank_end"))
+		return 1;
+
+	vactive--;
+	if (check_overflow(vactive, VACTIVE_MASK, "CRTC vactive"))
+		return 1;
+	vsync_start--;
+	if (check_overflow(vsync_start, VSYNCSTART_MASK, "CRTC vsync_start"))
+		return 1;
+	vsync_end--;
+	if (check_overflow(vsync_end, VSYNCEND_MASK, "CRTC vsync_end"))
+		return 1;
+	vtotal--;
+	if (check_overflow(vtotal, VTOTAL_MASK, "CRTC vtotal"))
+		return 1;
+	vblank_start--;
+	if (check_overflow(vblank_start, VBLANKSTART_MASK, "CRTC vblank_start"))
+		return 1;
+	vblank_end--;
+	if (check_overflow(vblank_end, VBLANKEND_MASK, "CRTC vblank_end"))
+		return 1;
+
+	*ht =3D (htotal << HTOTAL_SHIFT) | (hactive << HACTIVE_SHIFT);
+	*hb =3D (hblank_start << HBLANKSTART_SHIFT) |
+	      (hblank_end << HSYNCEND_SHIFT);
+	*hs =3D (hsync_start << HSYNCSTART_SHIFT) | (hsync_end << HSYNCEND_SHIFT);
+
+	*vt =3D (vtotal << VTOTAL_SHIFT) | (vactive << VACTIVE_SHIFT);
+	*vb =3D (vblank_start << VBLANKSTART_SHIFT) |
+	      (vblank_end << VSYNCEND_SHIFT);
+	*vs =3D (vsync_start << VSYNCSTART_SHIFT) | (vsync_end << VSYNCEND_SHIFT);
+	*ss =3D (hactive << SRC_SIZE_HORIZ_SHIFT) |
+	      (vactive << SRC_SIZE_VERT_SHIFT);
+
+	hw->disp_a_stride =3D var->xres_virtual * var->bits_per_pixel / 8;
+	DBG_MSG("pitch is %d\n", hw->disp_a_stride);
+
+	hw->disp_a_base =3D hw->disp_a_stride * var->yoffset +
+			  var->xoffset * var->bits_per_pixel / 8;
+
+	hw->disp_a_base +=3D dinfo->fb.offset << 12;
+
+	/* Check stride alignment. */
+	if (hw->disp_a_stride % STRIDE_ALIGNMENT !=3D 0) {
+		WRN_MSG("display stride %d has bad alignment %d\n",
+			hw->disp_a_stride, STRIDE_ALIGNMENT);
+		return 1;
+	}
+
+	/* Set the palette to 8-bit mode. */
+	*pipe_conf &=3D ~PIPECONF_GAMMA;
+	return 0;
+}
+
+/* Program a (non-VGA) video mode. */
+int
+intelfbhw_program_mode(struct intelfb_info *dinfo,
+		     const struct intelfb_hwstate *hw, int blank)
+{
+	int pipe =3D PIPE_A;
+	u32 tmp;
+	const u32 *dpll, *fp0, *fp1, *pipe_conf;
+	const u32 *hs, *ht, *hb, *vs, *vt, *vb, *ss;
+	u32 dpll_reg, fp0_reg, fp1_reg, pipe_conf_reg;
+	u32 hsync_reg, htotal_reg, hblank_reg;
+	u32 vsync_reg, vtotal_reg, vblank_reg;
+	u32 src_size_reg;
+
+	/* Assume single pipe, display plane A, analog CRT. */
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_program_mode\n");
+#endif
+
+	/* Disable VGA */
+	tmp =3D INREG(VGACNTRL);
+	tmp |=3D VGA_DISABLE;
+	OUTREG(VGACNTRL, tmp);
+
+	/* Check whether pipe A or pipe B is enabled. */
+	if (hw->pipe_a_conf & PIPECONF_ENABLE)
+		pipe =3D PIPE_A;
+	else if (hw->pipe_b_conf & PIPECONF_ENABLE)
+		pipe =3D PIPE_B;
+
+	dinfo->pipe =3D pipe;
+
+	if (pipe =3D=3D PIPE_B) {
+		dpll =3D &hw->dpll_b;
+		fp0 =3D &hw->fpb0;
+		fp1 =3D &hw->fpb1;
+		pipe_conf =3D &hw->pipe_b_conf;
+		hs =3D &hw->hsync_b;
+		hb =3D &hw->hblank_b;
+		ht =3D &hw->htotal_b;
+		vs =3D &hw->vsync_b;
+		vb =3D &hw->vblank_b;
+		vt =3D &hw->vtotal_b;
+		ss =3D &hw->src_size_b;
+		dpll_reg =3D DPLL_B;
+		fp0_reg =3D FPB0;
+		fp1_reg =3D FPB1;
+		pipe_conf_reg =3D PIPEBCONF;
+		hsync_reg =3D HSYNC_B;
+		htotal_reg =3D HTOTAL_B;
+		hblank_reg =3D HBLANK_B;
+		vsync_reg =3D VSYNC_B;
+		vtotal_reg =3D VTOTAL_B;
+		vblank_reg =3D VBLANK_B;
+		src_size_reg =3D SRC_SIZE_B;
+	} else {
+		dpll =3D &hw->dpll_a;
+		fp0 =3D &hw->fpa0;
+		fp1 =3D &hw->fpa1;
+		pipe_conf =3D &hw->pipe_a_conf;
+		hs =3D &hw->hsync_a;
+		hb =3D &hw->hblank_a;
+		ht =3D &hw->htotal_a;
+		vs =3D &hw->vsync_a;
+		vb =3D &hw->vblank_a;
+		vt =3D &hw->vtotal_a;
+		ss =3D &hw->src_size_a;
+		dpll_reg =3D DPLL_A;
+		fp0_reg =3D FPA0;
+		fp1_reg =3D FPA1;
+		pipe_conf_reg =3D PIPEACONF;
+		hsync_reg =3D HSYNC_A;
+		htotal_reg =3D HTOTAL_A;
+		hblank_reg =3D HBLANK_A;
+		vsync_reg =3D VSYNC_A;
+		vtotal_reg =3D VTOTAL_A;
+		vblank_reg =3D VBLANK_A;
+		src_size_reg =3D SRC_SIZE_A;
+	}
+
+	/* Disable planes A and B. */
+	tmp =3D INREG(DSPACNTR);
+	tmp &=3D ~DISPPLANE_PLANE_ENABLE;
+	OUTREG(DSPACNTR, tmp);
+	tmp =3D INREG(DSPBCNTR);
+	tmp &=3D ~DISPPLANE_PLANE_ENABLE;
+	OUTREG(DSPBCNTR, tmp);
+
+	/* Wait for vblank.  For now, just wait for a 50Hz cycle (20ms)) */
+	mdelay(20);
+
+	/* Disable Sync */
+	tmp =3D INREG(ADPA);
+	tmp &=3D ~ADPA_DPMS_CONTROL_MASK;
+	tmp |=3D ADPA_DPMS_D3;
+	OUTREG(ADPA, tmp);
+
+	/* turn off pipe */
+	tmp =3D INREG(pipe_conf_reg);
+	tmp &=3D ~PIPECONF_ENABLE;
+	OUTREG(pipe_conf_reg, tmp);
+
+	/* turn off PLL */
+	tmp =3D INREG(dpll_reg);
+	dpll_reg &=3D ~DPLL_VCO_ENABLE;
+	OUTREG(dpll_reg, tmp);
+
+	/* Set PLL parameters */
+	OUTREG(dpll_reg, *dpll & ~DPLL_VCO_ENABLE);
+	OUTREG(fp0_reg, *fp0);
+	OUTREG(fp1_reg, *fp1);
+
+	/* Set pipe parameters */
+	OUTREG(hsync_reg, *hs);
+	OUTREG(hblank_reg, *hb);
+	OUTREG(htotal_reg, *ht);
+	OUTREG(vsync_reg, *vs);
+	OUTREG(vblank_reg, *vb);
+	OUTREG(vtotal_reg, *vt);
+	OUTREG(src_size_reg, *ss);
+
+	/* Set DVOs B/C */
+	OUTREG(DVOB, hw->dvob);
+	OUTREG(DVOC, hw->dvoc);
+
+	/* Set ADPA */
+	OUTREG(ADPA, (hw->adpa & ~(ADPA_DPMS_CONTROL_MASK)) | ADPA_DPMS_D3);
+
+	/* Enable PLL */
+	tmp =3D INREG(dpll_reg);
+	tmp |=3D DPLL_VCO_ENABLE;
+	OUTREG(dpll_reg, tmp);
+
+	/* Enable pipe */
+	OUTREG(pipe_conf_reg, *pipe_conf | PIPECONF_ENABLE);
+
+	/* Enable sync */
+	tmp =3D INREG(ADPA);
+	tmp &=3D ~ADPA_DPMS_CONTROL_MASK;
+	tmp |=3D ADPA_DPMS_D0;
+	OUTREG(ADPA, tmp);
+
+	/* setup display plane */
+	OUTREG(DSPACNTR, hw->disp_a_ctrl & ~DISPPLANE_PLANE_ENABLE);
+	OUTREG(DSPASTRIDE, hw->disp_a_stride);
+	OUTREG(DSPABASE, hw->disp_a_base);
+
+	/* Enable plane */
+	if (!blank) {
+		tmp =3D INREG(DSPACNTR);
+		tmp |=3D DISPPLANE_PLANE_ENABLE;
+		OUTREG(DSPACNTR, tmp);
+		OUTREG(DSPABASE, hw->disp_a_base);
+	}
+
+	return 0;
+}
+
+/* forward declarations */
+static void refresh_ring(struct intelfb_info *dinfo);
+static void reset_state(struct intelfb_info *dinfo);
+static void do_flush(struct intelfb_info *dinfo);
+
+static int
+wait_ring(struct intelfb_info *dinfo, int n)
+{
+	int i =3D 0;
+	unsigned long end;
+	u32 last_head =3D INREG(PRI_RING_HEAD) & RING_HEAD_MASK;
+
+#if VERBOSE > 0
+	DBG_MSG("wait_ring: %d\n", n);
+#endif
+
+	end =3D jiffies + (HZ * 3);
+	while (dinfo->ring_space < n) {
+		dinfo->ring_head =3D INREG(PRI_RING_HEAD) & RING_HEAD_MASK;
+		if (dinfo->ring_tail + RING_MIN_FREE < dinfo->ring_head)
+			dinfo->ring_space =3D dinfo->ring_head
+				- (dinfo->ring_tail + RING_MIN_FREE);
+		else
+			dinfo->ring_space =3D (dinfo->ring.size +
+					     dinfo->ring_head)
+				- (dinfo->ring_tail + RING_MIN_FREE);
+		if (dinfo->ring_head !=3D last_head) {
+			end =3D jiffies + (HZ * 3);
+			last_head =3D dinfo->ring_head;
+		}
+		i++;
+		if (time_before(end, jiffies)) {
+			if (!i) {
+				/* Try again */
+				reset_state(dinfo);
+				refresh_ring(dinfo);
+				do_flush(dinfo);
+				end =3D jiffies + (HZ * 3);
+				i =3D 1;
+			} else {
+				WRN_MSG("ring buffer : space: %d wanted %d\n",
+					dinfo->ring_space, n);
+				WRN_MSG("lockup - turning off hardware "
+					"acceleration\n");
+				dinfo->ring_lockup =3D 1;
+				break;
+			}
+		}
+		udelay(1);
+	}
+	return i;
+}
+
+static void
+do_flush(struct intelfb_info *dinfo) {
+	START_RING(2);
+	OUT_RING(MI_FLUSH | MI_WRITE_DIRTY_STATE | MI_INVALIDATE_MAP_CACHE);
+	OUT_RING(MI_NOOP);
+	ADVANCE_RING();
+}
+
+void
+intelfbhw_do_sync(struct intelfb_info *dinfo)
+{
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_do_sync\n");
+#endif
+
+	if (!dinfo->accel)
+		return;
+
+	/*
+	 * Send a flush, then wait until the ring is empty.  This is what
+	 * the XFree86 driver does, and actually it doesn't seem a lot worse
+	 * than the recommended method (both have problems).
+	 */
+	do_flush(dinfo);
+	wait_ring(dinfo, dinfo->ring.size - RING_MIN_FREE);
+	dinfo->ring_space =3D dinfo->ring.size - RING_MIN_FREE;
+}
+
+static void
+refresh_ring(struct intelfb_info *dinfo)
+{
+#if VERBOSE > 0
+	DBG_MSG("refresh_ring\n");
+#endif
+
+	dinfo->ring_head =3D INREG(PRI_RING_HEAD) & RING_HEAD_MASK;
+	dinfo->ring_tail =3D INREG(PRI_RING_TAIL) & RING_TAIL_MASK;
+	if (dinfo->ring_tail + RING_MIN_FREE < dinfo->ring_head)
+		dinfo->ring_space =3D dinfo->ring_head
+			- (dinfo->ring_tail + RING_MIN_FREE);
+	else
+		dinfo->ring_space =3D (dinfo->ring.size + dinfo->ring_head)
+			- (dinfo->ring_tail + RING_MIN_FREE);
+}
+
+static void
+reset_state(struct intelfb_info *dinfo)
+{
+	int i;
+	u32 tmp;
+
+#if VERBOSE > 0
+	DBG_MSG("reset_state\n");
+#endif
+
+	for (i =3D 0; i < FENCE_NUM; i++)
+		OUTREG(FENCE + (i << 2), 0);
+
+	/* Flush the ring buffer if it's enabled. */
+	tmp =3D INREG(PRI_RING_LENGTH);
+	if (tmp & RING_ENABLE) {
+#if VERBOSE > 0
+		DBG_MSG("reset_state: ring was enabled\n");
+#endif
+		refresh_ring(dinfo);
+		intelfbhw_do_sync(dinfo);
+		DO_RING_IDLE();
+	}
+
+	OUTREG(PRI_RING_LENGTH, 0);
+	OUTREG(PRI_RING_HEAD, 0);
+	OUTREG(PRI_RING_TAIL, 0);
+	OUTREG(PRI_RING_START, 0);
+}
+
+/* Stop the 2D engine, and turn off the ring buffer. */
+void
+intelfbhw_2d_stop(struct intelfb_info *dinfo)
+{
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_2d_stop: accel: %d, ring_active: %d\n", dinfo->accel,
+		dinfo->ring_active);
+#endif
+
+	if (!dinfo->accel)
+		return;
+
+	dinfo->ring_active =3D 0;
+	reset_state(dinfo);
+}
+
+/*
+ * Enable the ring buffer, and initialise the 2D engine.
+ * It is assumed that the graphics engine has been stopped by previously
+ * calling intelfb_2d_stop().
+ */
+void
+intelfbhw_2d_start(struct intelfb_info *dinfo)
+{
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_2d_start: accel: %d, ring_active: %d\n",
+		dinfo->accel, dinfo->ring_active);
+#endif
+
+	if (!dinfo->accel)
+		return;
+
+	/* Initialise the primary ring buffer. */
+	OUTREG(PRI_RING_LENGTH, 0);
+	OUTREG(PRI_RING_TAIL, 0);
+	OUTREG(PRI_RING_HEAD, 0);
+
+	OUTREG(PRI_RING_START, dinfo->ring.physical & RING_START_MASK);
+	OUTREG(PRI_RING_LENGTH,
+		((dinfo->ring.size - GTT_PAGE_SIZE) & RING_LENGTH_MASK) |
+		RING_NO_REPORT | RING_ENABLE);
+	refresh_ring(dinfo);
+	dinfo->ring_active =3D 1;
+}
+
+/* 2D fillrect (solid fill or invert) */
+void
+intelfbhw_do_fillrect(struct intelfb_info *dinfo, u32 x, u32 y, u32 w, u32=
 h,
+		      u32 color, u32 pitch, u32 bpp, u32 rop)
+{
+	u32 br00, br09, br13, br14, br16;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_do_fillrect: (%d,%d) %dx%d, c 0x%06x, p %d bpp %d, "
+		"rop 0x%02x\n", x, y, w, h, color, pitch, bpp, rop);
+#endif
+
+	br00 =3D COLOR_BLT_CMD;
+	br09 =3D dinfo->fb_start + (y * pitch + x * (bpp / 8));
+	br13 =3D (rop << ROP_SHIFT) | pitch;
+	br14 =3D (h << HEIGHT_SHIFT) | ((w * (bpp / 8)) << WIDTH_SHIFT);
+	br16 =3D color;
+
+	switch (bpp) {
+	case 8:
+		br13 |=3D COLOR_DEPTH_8;
+		break;
+	case 16:
+		br13 |=3D COLOR_DEPTH_16;
+		break;
+	case 32:
+		br13 |=3D COLOR_DEPTH_32;
+		br00 |=3D WRITE_ALPHA | WRITE_RGB;
+		break;
+	}
+
+	START_RING(6);
+	OUT_RING(br00);
+	OUT_RING(br13);
+	OUT_RING(br14);
+	OUT_RING(br09);
+	OUT_RING(br16);
+	OUT_RING(MI_NOOP);
+	ADVANCE_RING();
+
+#if VERBOSE > 0
+	DBG_MSG("ring =3D 0x%08x, 0x%08x (%d)\n", dinfo->ring_head,
+		dinfo->ring_tail, dinfo->ring_space);
+#endif
+}
+
+void
+intelfbhw_do_bitblt(struct intelfb_info *dinfo, u32 curx, u32 cury,
+		    u32 dstx, u32 dsty, u32 w, u32 h, u32 pitch, u32 bpp)
+{
+	u32 br00, br09, br11, br12, br13, br22, br23, br26;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_do_bitblt: (%d,%d)->(%d,%d) %dx%d, p %d bpp %d\n",
+		curx, cury, dstx, dsty, w, h, pitch, bpp);
+#endif
+
+	br00 =3D XY_SRC_COPY_BLT_CMD;
+	br09 =3D dinfo->fb_start;
+	br11 =3D (pitch << PITCH_SHIFT);
+	br12 =3D dinfo->fb_start;
+	br13 =3D (SRC_ROP_GXCOPY << ROP_SHIFT) | (pitch << PITCH_SHIFT);
+	br22 =3D (dstx << WIDTH_SHIFT) | (dsty << HEIGHT_SHIFT);
+	br23 =3D ((dstx + w) << WIDTH_SHIFT) |
+	       ((dsty + h) << HEIGHT_SHIFT);
+	br26 =3D (curx << WIDTH_SHIFT) | (cury << HEIGHT_SHIFT);
+
+	switch (bpp) {
+	case 8:
+		br13 |=3D COLOR_DEPTH_8;
+		break;
+	case 16:
+		br13 |=3D COLOR_DEPTH_16;
+		break;
+	case 32:
+		br13 |=3D COLOR_DEPTH_32;
+		br00 |=3D WRITE_ALPHA | WRITE_RGB;
+		break;
+	}
+
+	START_RING(8);
+	OUT_RING(br00);
+	OUT_RING(br13);
+	OUT_RING(br22);
+	OUT_RING(br23);
+	OUT_RING(br09);
+	OUT_RING(br26);
+	OUT_RING(br11);
+	OUT_RING(br12);
+	ADVANCE_RING();
+}
+
+int
+intelfbhw_do_drawglyph(struct intelfb_info *dinfo, u32 fg, u32 bg, u32 w,
+		       u32 h, const u8* cdat, u32 x, u32 y, u32 pitch, u32 bpp)
+{
+	int nbytes, ndwords, pad, tmp;
+	u32 br00, br09, br13, br18, br19, br22, br23;
+	int dat, ix, iy, iw;
+	int i, j;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_do_drawglyph: (%d,%d) %dx%d\n", x, y, w, h);
+#endif
+
+	/* size in bytes of a padded scanline */
+	nbytes =3D ROUND_UP_TO(w, 16) / 8;
+
+	/* Total bytes of padded scanline data to write out. */
+	nbytes =3D nbytes * h;
+
+	/*
+	 * Check if the glyph data exceeds the immediate mode limit.
+	 * It would take a large font (1K pixels) to hit this limit.
+	 */
+	if (nbytes > MAX_MONO_IMM_SIZE)
+		return 0;
+
+	/* Src data is packaged a dword (32-bit) at a time. */
+	ndwords =3D ROUND_UP_TO(nbytes, 4) / 4;
+
+	/*
+	 * Ring has to be padded to a quad word. But because the command starts
+	   with 7 bytes, pad only if there is an even number of ndwords
+	 */
+	pad =3D !(ndwords % 2);
+
+	tmp =3D (XY_MONO_SRC_IMM_BLT_CMD & DW_LENGTH_MASK) + ndwords;
+	br00 =3D (XY_MONO_SRC_IMM_BLT_CMD & ~DW_LENGTH_MASK) | tmp;
+	br09 =3D dinfo->fb_start;
+	br13 =3D (SRC_ROP_GXCOPY << ROP_SHIFT) | (pitch << PITCH_SHIFT);
+	br18 =3D bg;
+	br19 =3D fg;
+	br22 =3D (x << WIDTH_SHIFT) | (y << HEIGHT_SHIFT);
+	br23 =3D ((x + w) << WIDTH_SHIFT) | ((y + h) << HEIGHT_SHIFT);
+
+	switch (bpp) {
+	case 8:
+		br13 |=3D COLOR_DEPTH_8;
+		break;
+	case 16:
+		br13 |=3D COLOR_DEPTH_16;
+		break;
+	case 32:
+		br13 |=3D COLOR_DEPTH_32;
+		br00 |=3D WRITE_ALPHA | WRITE_RGB;
+		break;
+	}
+
+	START_RING(8 + ndwords);
+	OUT_RING(br00);
+	OUT_RING(br13);
+	OUT_RING(br22);
+	OUT_RING(br23);
+	OUT_RING(br09);
+	OUT_RING(br18);
+	OUT_RING(br19);
+	ix =3D iy =3D 0;
+	iw =3D ROUND_UP_TO(w, 8) / 8;
+	while (ndwords--) {
+		dat =3D 0;
+		for (j =3D 0; j < 2; ++j) {
+			for (i =3D 0; i < 2; ++i) {
+				if (ix !=3D iw || i =3D=3D 0)
+					dat |=3D cdat[iy*iw + ix++] << (i+j*2)*8;
+			}
+			if (ix =3D=3D iw && iy !=3D (h-1)) {
+				ix =3D 0;
+				++iy;
+			}
+		}
+		OUT_RING(dat);
+	}
+	if (pad)
+		OUT_RING(MI_NOOP);
+	ADVANCE_RING();
+
+	return 1;
+}
+
+/* HW cursor functions. */
+void
+intelfbhw_cursor_init(struct intelfb_info *dinfo)
+{
+	u32 tmp;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_cursor_init\n");
+#endif
+
+	if (dinfo->mobile) {
+		if (!dinfo->cursor.physical)
+			return;
+		tmp =3D INREG(CURSOR_A_CONTROL);
+		tmp &=3D ~(CURSOR_MODE_MASK | CURSOR_MOBILE_GAMMA_ENABLE |
+			 CURSOR_MEM_TYPE_LOCAL |
+			 (1 << CURSOR_PIPE_SELECT_SHIFT));
+		tmp |=3D CURSOR_MODE_DISABLE;
+		OUTREG(CURSOR_A_CONTROL, tmp);
+		OUTREG(CURSOR_A_BASEADDR, dinfo->cursor.physical);
+	} else {
+		tmp =3D INREG(CURSOR_CONTROL);
+		tmp &=3D ~(CURSOR_FORMAT_MASK | CURSOR_GAMMA_ENABLE |
+			 CURSOR_ENABLE | CURSOR_STRIDE_MASK);
+		tmp =3D CURSOR_FORMAT_3C;
+		OUTREG(CURSOR_CONTROL, tmp);
+		OUTREG(CURSOR_A_BASEADDR, dinfo->cursor.physical);
+		tmp =3D (64 << CURSOR_SIZE_H_SHIFT) |
+		      (64 << CURSOR_SIZE_V_SHIFT);
+		OUTREG(CURSOR_SIZE, tmp);
+	}
+}
+
+void
+intelfbhw_cursor_hide(struct intelfb_info *dinfo)
+{
+	u32 tmp;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_cursor_hide\n");
+#endif
+
+	dinfo->cursor_on =3D 0;
+	if (dinfo->mobile) {
+		if (!dinfo->cursor.physical)
+			return;
+		tmp =3D INREG(CURSOR_A_CONTROL);
+		tmp &=3D ~CURSOR_MODE_MASK;
+		tmp |=3D CURSOR_MODE_DISABLE;
+		OUTREG(CURSOR_A_CONTROL, tmp);
+		/* Flush changes */
+		OUTREG(CURSOR_A_BASEADDR, dinfo->cursor.physical);
+	} else {
+		tmp =3D INREG(CURSOR_CONTROL);
+		tmp &=3D ~CURSOR_ENABLE;
+		OUTREG(CURSOR_CONTROL, tmp);
+	}
+}
+
+void
+intelfbhw_cursor_show(struct intelfb_info *dinfo)
+{
+	u32 tmp;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_cursor_show\n");
+#endif
+
+	dinfo->cursor_on =3D 1;
+
+	if (dinfo->cursor_blanked)
+		return;
+
+	if (dinfo->mobile) {
+		if (!dinfo->cursor.physical)
+			return;
+		tmp =3D INREG(CURSOR_A_CONTROL);
+		tmp &=3D ~CURSOR_MODE_MASK;
+		tmp |=3D CURSOR_MODE_64_4C_AX;
+		OUTREG(CURSOR_A_CONTROL, tmp);
+		/* Flush changes */
+		OUTREG(CURSOR_A_BASEADDR, dinfo->cursor.physical);
+	} else {
+		tmp =3D INREG(CURSOR_CONTROL);
+		tmp |=3D CURSOR_ENABLE;
+		OUTREG(CURSOR_CONTROL, tmp);
+	}
+}
+
+void
+intelfbhw_cursor_setpos(struct intelfb_info *dinfo, int x, int y)
+{
+	u32 tmp;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_cursor_setpos: (%d, %d)\n", x, y);
+#endif
+
+	/*
+	 * Sets the position.  The coordinates are assumed to already
+	 * have any offset adjusted.  Assume that the cursor is never
+	 * completely off-screen, and that x, y are always >=3D 0.
+	 */
+
+	tmp =3D ((x & CURSOR_POS_MASK) << CURSOR_X_SHIFT) |
+	      ((y & CURSOR_POS_MASK) << CURSOR_Y_SHIFT);
+	OUTREG(CURSOR_A_POSITION, tmp);
+}
+
+void
+intelfbhw_cursor_setcolor(struct intelfb_info *dinfo, u32 bg, u32 fg)
+{
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_cursor_setcolor\n");
+#endif
+
+	OUTREG(CURSOR_A_PALETTE0, bg & CURSOR_PALETTE_MASK);
+	OUTREG(CURSOR_A_PALETTE1, fg & CURSOR_PALETTE_MASK);
+	OUTREG(CURSOR_A_PALETTE2, fg & CURSOR_PALETTE_MASK);
+	OUTREG(CURSOR_A_PALETTE3, bg & CURSOR_PALETTE_MASK);
+}
+
+void
+intelfbhw_cursor_load(struct intelfb_info *dinfo, int width, int height,
+		      u8 *data)
+{
+	u8 *addr =3D (u8 *)dinfo->cursor.virtual;
+	int i, j, w =3D width / 8;
+	int mod =3D width % 8, t_mask, d_mask;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_cursor_load\n");
+#endif
+
+	if (!dinfo->cursor.virtual)
+		return;
+
+	t_mask =3D 0xff >> mod;
+	d_mask =3D ~(0xff >> mod);
+	for (i =3D height; i--; ) {
+		for (j =3D 0; j < w; j++) {
+			writeb(0x00, addr + j);
+			writeb(*(data++), addr + j+8);
+		}
+		if (mod) {
+			writeb(t_mask, addr + j);
+			writeb(*(data++) & d_mask, addr + j+8);
+		}
+		addr +=3D 16;
+	}
+}
+
+void
+intelfbhw_cursor_reset(struct intelfb_info *dinfo) {
+	u8 *addr =3D (u8 *)dinfo->cursor.virtual;
+	int i, j;
+
+#if VERBOSE > 0
+	DBG_MSG("intelfbhw_cursor_reset\n");
+#endif
+
+	if (!dinfo->cursor.virtual)
+		return;
+
+	for (i =3D 64; i--; ) {
+		for (j =3D 0; j < 8; j++) {
+			writeb(0xff, addr + j+0);
+			writeb(0x00, addr + j+8);
+		}
+		addr +=3D 16;
+	}
+}
diff -Nru a/drivers/video/intelfb/intelfbhw.h b/drivers/video/intelfb/intel=
fbhw.h
=2D-- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/intelfb/intelfbhw.h	2004-10-21 05:06:45 +08:00
@@ -0,0 +1,565 @@
+#ifndef _INTELFBHW_H
+#define _INTELFBHW_H
+
+/* $DHD: intelfb/intelfbhw.h,v 1.5 2003/06/27 15:06:25 dawes Exp $ */
+
+
+/*** HW-specific data ***/
+
+/* Information about the 852GM/855GM variants */
+#define INTEL_85X_CAPID		0x44
+#define INTEL_85X_VARIANT_MASK		0x7
+#define INTEL_85X_VARIANT_SHIFT		5
+#define INTEL_VAR_855GME		0x0
+#define INTEL_VAR_855GM			0x4
+#define INTEL_VAR_852GME		0x2
+#define INTEL_VAR_852GM			0x5
+
+/* Information about DVO/LVDS Ports */
+#define DVOA_PORT  0x1
+#define DVOB_PORT  0x2
+#define DVOC_PORT  0x4
+#define LVDS_PORT  0x8
+
+/*
+ * The Bridge device's PCI config space has information about the
+ * fb aperture size and the amount of pre-reserved memory.
+ */
+#define INTEL_GMCH_CTRL		0x52
+#define INTEL_GMCH_ENABLED		0x4
+#define INTEL_GMCH_MEM_MASK		0x1
+#define INTEL_GMCH_MEM_64M		0x1
+#define INTEL_GMCH_MEM_128M		0
+
+#define INTEL_830_GMCH_GMS_MASK		(0x7 << 4)
+#define INTEL_830_GMCH_GMS_DISABLED	(0x0 << 4)
+#define INTEL_830_GMCH_GMS_LOCAL	(0x1 << 4)
+#define INTEL_830_GMCH_GMS_STOLEN_512	(0x2 << 4)
+#define INTEL_830_GMCH_GMS_STOLEN_1024	(0x3 << 4)
+#define INTEL_830_GMCH_GMS_STOLEN_8192	(0x4 << 4)
+
+#define INTEL_855_GMCH_GMS_MASK		(0x7 << 4)
+#define INTEL_855_GMCH_GMS_DISABLED	(0x0 << 4)
+#define INTEL_855_GMCH_GMS_STOLEN_1M	(0x1 << 4)
+#define INTEL_855_GMCH_GMS_STOLEN_4M	(0x2 << 4)
+#define INTEL_855_GMCH_GMS_STOLEN_8M	(0x3 << 4)
+#define INTEL_855_GMCH_GMS_STOLEN_16M	(0x4 << 4)
+#define INTEL_855_GMCH_GMS_STOLEN_32M	(0x5 << 4)
+
+/* HW registers */
+
+/* Fence registers */
+#define FENCE			0x2000
+#define FENCE_NUM			8
+
+/* Primary ring buffer */
+#define PRI_RING_TAIL		0x2030
+#define RING_TAIL_MASK			0x001ffff8
+#define RING_INUSE			0x1
+
+#define PRI_RING_HEAD		0x2034
+#define RING_HEAD_WRAP_MASK		0x7ff
+#define RING_HEAD_WRAP_SHIFT		21
+#define RING_HEAD_MASK			0x001ffffc
+
+#define PRI_RING_START		0x2038
+#define RING_START_MASK			0xfffff000
+
+#define PRI_RING_LENGTH		0x203c
+#define RING_LENGTH_MASK		0x001ff000
+#define RING_REPORT_MASK		(0x3 << 1)
+#define RING_NO_REPORT			(0x0 << 1)
+#define RING_REPORT_64K			(0x1 << 1)
+#define RING_REPORT_4K			(0x2 << 1)
+#define RING_REPORT_128K		(0x3 << 1)
+#define RING_ENABLE			0x1
+
+/*
+ * Tail can't wrap to any closer than RING_MIN_FREE bytes of the head,
+ * and the last RING_MIN_FREE bytes need to be padded with MI_NOOP
+ */
+#define RING_MIN_FREE			64
+
+#define IPEHR     		0x2088
+
+#define INSTDONE		0x2090
+#define PRI_RING_EMPTY			1
+
+#define INSTPM			0x20c0
+#define SYNC_FLUSH_ENABLE		(1 << 5)
+
+#define INSTPS			0x20c4
+
+#define MEM_MODE		0x20cc
+
+#define MASK_SHIFT			16
+
+#define FW_BLC_0		0x20d8
+#define FW_DISPA_WM_SHIFT		0
+#define FW_DISPA_WM_MASK		0x3f
+#define FW_DISPA_BL_SHIFT		8
+#define FW_DISPA_BL_MASK		0xf
+#define FW_DISPB_WM_SHIFT		16
+#define FW_DISPB_WM_MASK		0x1f
+#define FW_DISPB_BL_SHIFT		24
+#define FW_DISPB_BL_MASK		0x7
+
+#define FW_BLC_1		0x20dc
+#define FW_DISPC_WM_SHIFT		0
+#define FW_DISPC_WM_MASK		0x1f
+#define FW_DISPC_BL_SHIFT		8
+#define FW_DISPC_BL_MASK		0x7
+
+
+/* PLL registers */
+#define VGA0_DIVISOR		0x06000
+#define VGA1_DIVISOR		0x06004
+#define VGAPD			0x06010
+#define VGAPD_0_P1_SHIFT		0
+#define VGAPD_0_P1_FORCE_DIV2		(1 << 5)
+#define VGAPD_0_P2_SHIFT		7
+#define VGAPD_1_P1_SHIFT		8
+#define VGAPD_1_P1_FORCE_DIV2		(1 << 13)
+#define VGAPD_1_P2_SHIFT		15
+
+#define DPLL_A			0x06014
+#define DPLL_B			0x06018
+#define DPLL_VCO_ENABLE			(1 << 31)
+#define DPLL_2X_CLOCK_ENABLE		(1 << 30)
+#define DPLL_SYNCLOCK_ENABLE		(1 << 29)
+#define DPLL_VGA_MODE_DISABLE		(1 << 28)
+#define DPLL_P2_MASK			1
+#define DPLL_P2_SHIFT			23
+#define DPLL_P1_FORCE_DIV2		(1 << 21)
+#define DPLL_P1_MASK			0x1f
+#define DPLL_P1_SHIFT			16
+#define DPLL_REFERENCE_SELECT_MASK	(0x3 << 13)
+#define DPLL_REFERENCE_DEFAULT		(0x0 << 13)
+#define DPLL_REFERENCE_TVCLK		(0x2 << 13)
+#define DPLL_RATE_SELECT_MASK		(1 << 8)
+#define DPLL_RATE_SELECT_FP0		(0 << 8)
+#define DPLL_RATE_SELECT_FP1		(1 << 8)
+
+#define FPA0			0x06040
+#define FPA1			0x06044
+#define FPB0			0x06048
+#define FPB1			0x0604c
+#define FP_DIVISOR_MASK			0x3f
+#define FP_N_DIVISOR_SHIFT		16
+#define FP_M1_DIVISOR_SHIFT		8
+#define FP_M2_DIVISOR_SHIFT		0
+
+/* PLL parameters (these are for 852GM/855GM/865G, check earlier chips). */
+/* Clock values are in units of kHz */
+#define PLL_REFCLK		48000
+#define MIN_VCO_FREQ		930000
+#define MAX_VCO_FREQ		1400000
+#define MIN_CLOCK		25000
+#define MAX_CLOCK		350000
+#define P_TRANSITION_CLOCK	165000
+#define MIN_M			108
+#define MAX_M			140
+#define MIN_M1			18
+#define MAX_M1			26
+#define MIN_M2			6
+#define MAX_M2			16
+#define MIN_P			4
+#define MAX_P			128
+#define MIN_P1			0
+#define MAX_P1			31
+#define MIN_N			3
+#define MAX_N			16
+
+#define CALC_VCLOCK(m1, m2, n, p1, p2) \
+        ((PLL_REFCLK * (5 * ((m1) + 2) + ((m2) + 2)) / ((n) + 2)) / \
+        (((p1) + 2) * (1 << (p2 + 1))))
+
+#define CALC_VCLOCK3(m, n, p)	((PLL_REFCLK * (m) / (n)) / (p))
+
+/* Two pipes */
+#define PIPE_A			0
+#define PIPE_B			1
+#define PIPE_MASK		1
+
+/* palette registers */
+#define PALETTE_A		0x0a000
+#define PALETTE_B		0x0a800
+#ifndef PALETTE_8_ENTRIES
+#define PALETTE_8_ENTRIES		256
+#endif
+#define PALETTE_8_SIZE			(PALETTE_8_ENTRIES * 4)
+#define PALETTE_10_ENTRIES		128
+#define PALETTE_10_SIZE			(PALETTE_10_ENTRIES * 8)
+#define PALETTE_8_MASK			0xff
+#define PALETTE_8_RED_SHIFT		16
+#define PALETTE_8_GREEN_SHIFT		8
+#define PALETTE_8_BLUE_SHIFT		0
+
+/* CRTC registers */
+#define HTOTAL_A		0x60000
+#define HBLANK_A		0x60004
+#define HSYNC_A			0x60008
+#define VTOTAL_A		0x6000c
+#define VBLANK_A		0x60010
+#define VSYNC_A			0x60014
+#define SRC_SIZE_A		0x6001c
+#define BCLRPAT_A		0x60020
+
+#define HTOTAL_B		0x61000
+#define HBLANK_B		0x61004
+#define HSYNC_B			0x61008
+#define VTOTAL_B		0x6100c
+#define VBLANK_B		0x61010
+#define VSYNC_B			0x61014
+#define SRC_SIZE_B		0x6101c
+#define BCLRPAT_B		0x61020
+
+#define HTOTAL_MASK			0xfff
+#define HTOTAL_SHIFT			16
+#define HACTIVE_MASK			0x7ff
+#define HACTIVE_SHIFT			0
+#define HBLANKEND_MASK			0xfff
+#define HBLANKEND_SHIFT			16
+#define HBLANKSTART_MASK		0xfff
+#define HBLANKSTART_SHIFT		0
+#define HSYNCEND_MASK			0xfff
+#define HSYNCEND_SHIFT			16
+#define HSYNCSTART_MASK			0xfff
+#define HSYNCSTART_SHIFT		0
+#define VTOTAL_MASK			0xfff
+#define VTOTAL_SHIFT			16
+#define VACTIVE_MASK			0x7ff
+#define VACTIVE_SHIFT			0
+#define VBLANKEND_MASK			0xfff
+#define VBLANKEND_SHIFT			16
+#define VBLANKSTART_MASK		0xfff
+#define VBLANKSTART_SHIFT		0
+#define VSYNCEND_MASK			0xfff
+#define VSYNCEND_SHIFT			16
+#define VSYNCSTART_MASK			0xfff
+#define VSYNCSTART_SHIFT		0
+#define SRC_SIZE_HORIZ_MASK		0x7ff
+#define SRC_SIZE_HORIZ_SHIFT		16
+#define SRC_SIZE_VERT_MASK		0x7ff
+#define SRC_SIZE_VERT_SHIFT		0
+
+#define ADPA			0x61100
+#define ADPA_DAC_ENABLE			(1 << 31)
+#define ADPA_DAC_DISABLE		0
+#define ADPA_PIPE_SELECT_SHIFT		30
+#define ADPA_USE_VGA_HVPOLARITY		(1 << 15)
+#define ADPA_SETS_HVPOLARITY		0
+#define ADPA_DPMS_CONTROL_MASK		(0x3 << 10)
+#define ADPA_DPMS_D0			(0x0 << 10)
+#define ADPA_DPMS_D2			(0x1 << 10)
+#define ADPA_DPMS_D1			(0x2 << 10)
+#define ADPA_DPMS_D3			(0x3 << 10)
+#define ADPA_VSYNC_ACTIVE_SHIFT		4
+#define ADPA_HSYNC_ACTIVE_SHIFT		3
+#define ADPA_SYNC_ACTIVE_MASK		1
+#define ADPA_SYNC_ACTIVE_HIGH		1
+#define ADPA_SYNC_ACTIVE_LOW		0
+
+#define DVOA			0x61120
+#define DVOB			0x61140
+#define DVOC			0x61160
+#define LVDS			0x61180
+#define PORT_ENABLE		        (1 << 31)
+#define PORT_PIPE_SELECT_SHIFT	        30
+#define PORT_TV_FLAGS_MASK              0xFF
+#define PORT_TV_FLAGS                   0xC4  // ripped from my BIOS
+                                              // to understand and correct
+
+#define DVOA_SRCDIM		0x61124
+#define DVOB_SRCDIM		0x61144
+#define DVOC_SRCDIM		0x61164
+
+#define PIPEACONF		0x70008
+#define PIPEBCONF		0x71008
+#define PIPECONF_ENABLE			(1 << 31)
+#define PIPECONF_DISABLE		0
+#define PIPECONF_DOUBLE_WIDE		(1 << 30)
+#define PIPECONF_SINGLE_WIDE		0
+#define PIPECONF_LOCKED			(1 << 25)
+#define PIPECONF_UNLOCKED		0
+#define PIPECONF_GAMMA			(1 << 24)
+#define PIPECONF_PALETTE		0
+
+#define DISPARB			0x70030
+#define DISPARB_AEND_MASK		0x1ff
+#define DISPARB_AEND_SHIFT		0
+#define DISPARB_BEND_MASK		0x3ff
+#define DISPARB_BEND_SHIFT		9
+
+/* Desktop HW cursor */
+#define CURSOR_CONTROL		0x70080
+#define CURSOR_ENABLE			(1 << 31)
+#define CURSOR_GAMMA_ENABLE		(1 << 30)
+#define CURSOR_STRIDE_MASK		(0x3 << 28)
+#define CURSOR_STRIDE_256		(0x0 << 28)
+#define CURSOR_STRIDE_512		(0x1 << 28)
+#define CURSOR_STRIDE_1K		(0x2 << 28)
+#define CURSOR_STRIDE_2K		(0x3 << 28)
+#define CURSOR_FORMAT_MASK		(0x7 << 24)
+#define CURSOR_FORMAT_2C		(0x0 << 24)
+#define CURSOR_FORMAT_3C		(0x1 << 24)
+#define CURSOR_FORMAT_4C		(0x2 << 24)
+#define CURSOR_FORMAT_ARGB		(0x4 << 24)
+#define CURSOR_FORMAT_XRGB		(0x5 << 24)
+
+/* Mobile HW cursor (and i810) */
+#define CURSOR_A_CONTROL	CURSOR_CONTROL
+#define CURSOR_B_CONTROL	0x700c0
+#define CURSOR_MODE_MASK		0x27
+#define CURSOR_MODE_DISABLE		0
+#define CURSOR_MODE_64_3C		0x04
+#define CURSOR_MODE_64_4C_AX		0x05
+#define CURSOR_MODE_64_4C		0x06
+#define CURSOR_MODE_64_32B_AX		0x07
+#define CURSOR_MODE_64_ARGB_AX		0x27
+#define CURSOR_PIPE_SELECT_SHIFT	28
+#define CURSOR_MOBILE_GAMMA_ENABLE	(1 << 26)
+#define CURSOR_MEM_TYPE_LOCAL		(1 << 25)
+
+/* All platforms (desktop has no pipe B) */
+#define CURSOR_A_BASEADDR	0x70084
+#define CURSOR_B_BASEADDR	0x700c4
+#define CURSOR_BASE_MASK		0xffffff00
+
+#define CURSOR_A_POSITION	0x70088
+#define CURSOR_B_POSITION	0x700c8
+#define CURSOR_POS_SIGN			(1 << 15)
+#define CURSOR_POS_MASK			0x7ff
+#define CURSOR_X_SHIFT			0
+#define CURSOR_Y_SHIFT			16
+
+#define CURSOR_A_PALETTE0	0x70090
+#define CURSOR_A_PALETTE1	0x70094
+#define CURSOR_A_PALETTE2	0x70098
+#define CURSOR_A_PALETTE3	0x7009c
+#define CURSOR_B_PALETTE0	0x700d0
+#define CURSOR_B_PALETTE1	0x700d4
+#define CURSOR_B_PALETTE2	0x700d8
+#define CURSOR_B_PALETTE3	0x700dc
+#define CURSOR_COLOR_MASK			0xff
+#define CURSOR_RED_SHIFT			16
+#define CURSOR_GREEN_SHIFT			8
+#define CURSOR_BLUE_SHIFT			0
+#define CURSOR_PALETTE_MASK			0xffffff
+
+/* Desktop only */
+#define CURSOR_SIZE		0x700a0
+#define CURSOR_SIZE_MASK		0x3ff
+#define CURSOR_SIZE_H_SHIFT		0
+#define CURSOR_SIZE_V_SHIFT		12
+
+#define DSPACNTR		0x70180
+#define DSPBCNTR		0x71180
+#define DISPPLANE_PLANE_ENABLE		(1 << 31)
+#define DISPPLANE_PLANE_DISABLE		0
+#define DISPPLANE_GAMMA_ENABLE		(1<<30)
+#define DISPPLANE_GAMMA_DISABLE		0
+#define DISPPLANE_PIXFORMAT_MASK	(0xf<<26)
+#define DISPPLANE_8BPP			(0x2<<26)
+#define DISPPLANE_15_16BPP		(0x4<<26)
+#define DISPPLANE_16BPP			(0x5<<26)
+#define DISPPLANE_32BPP_NO_ALPHA 	(0x6<<26)
+#define DISPPLANE_32BPP			(0x7<<26)
+#define DISPPLANE_STEREO_ENABLE		(1<<25)
+#define DISPPLANE_STEREO_DISABLE	0
+#define DISPPLANE_SEL_PIPE_SHIFT	24
+#define DISPPLANE_SRC_KEY_ENABLE	(1<<22)
+#define DISPPLANE_SRC_KEY_DISABLE	0
+#define DISPPLANE_LINE_DOUBLE		(1<<20)
+#define DISPPLANE_NO_LINE_DOUBLE	0
+#define DISPPLANE_STEREO_POLARITY_FIRST	0
+#define DISPPLANE_STEREO_POLARITY_SECOND (1<<18)
+/* plane B only */
+#define DISPPLANE_ALPHA_TRANS_ENABLE	(1<<15)
+#define DISPPLANE_ALPHA_TRANS_DISABLE	0
+#define DISPPLANE_SPRITE_ABOVE_DISPLAYA	0
+#define DISPPLANE_SPRITE_ABOVE_OVERLAY	1
+
+#define DSPABASE		0x70184
+#define DSPASTRIDE		0x70188
+
+#define DSPBBASE		0x71184
+#define DSPBSTRIDE		0x71188
+
+#define VGACNTRL		0x71400
+#define VGA_DISABLE			(1 << 31)
+#define VGA_ENABLE			0
+#define VGA_PIPE_SELECT_SHIFT		29
+#define VGA_PALETTE_READ_SELECT		23
+#define VGA_PALETTE_A_WRITE_DISABLE	(1 << 22)
+#define VGA_PALETTE_B_WRITE_DISABLE	(1 << 21)
+#define VGA_LEGACY_PALETTE		(1 << 20)
+#define VGA_6BIT_DAC			0
+#define VGA_8BIT_DAC			(1 << 20)
+
+#define ADD_ID			0x71408
+#define ADD_ID_MASK			0xff
+
+/* BIOS scratch area registers (830M and 845G). */
+#define SWF0			0x71410
+#define SWF1			0x71414
+#define SWF2			0x71418
+#define SWF3			0x7141c
+#define SWF4			0x71420
+#define SWF5			0x71424
+#define SWF6			0x71428
+
+/* BIOS scratch area registers (852GM, 855GM, 865G). */
+#define SWF00			0x70410
+#define SWF01			0x70414
+#define SWF02			0x70418
+#define SWF03			0x7041c
+#define SWF04			0x70420
+#define SWF05			0x70424
+#define SWF06			0x70428
+
+#define SWF10			SWF0
+#define SWF11			SWF1
+#define SWF12			SWF2
+#define SWF13			SWF3
+#define SWF14			SWF4
+#define SWF15			SWF5
+#define SWF16			SWF6
+
+#define SWF30			0x72414
+#define SWF31			0x72418
+#define SWF32			0x7241c
+
+/* Memory Commands */
+#define MI_NOOP			(0x00 << 23)
+#define MI_NOOP_WRITE_ID		(1 << 22)
+#define MI_NOOP_ID_MASK			((1 << 22) - 1)
+
+#define MI_FLUSH		(0x04 << 23)
+#define MI_WRITE_DIRTY_STATE		(1 << 4)
+#define MI_END_SCENE			(1 << 3)
+#define MI_INHIBIT_RENDER_CACHE_FLUSH	(1 << 2)
+#define MI_INVALIDATE_MAP_CACHE		(1 << 0)
+
+#define MI_STORE_DWORD_IMM	((0x20 << 23) | 1)
+
+/* 2D Commands */
+#define COLOR_BLT_CMD		((2 << 29) | (0x40 << 22) | 3)
+#define XY_COLOR_BLT_CMD	((2 << 29) | (0x50 << 22) | 4)
+#define XY_SETUP_CLIP_BLT_CMD	((2 << 29) | (0x03 << 22) | 1)
+#define XY_SRC_COPY_BLT_CMD	((2 << 29) | (0x53 << 22) | 6)
+#define SRC_COPY_BLT_CMD	((2 << 29) | (0x43 << 22) | 4)
+#define XY_MONO_PAT_BLT_CMD	((2 << 29) | (0x52 << 22) | 7)
+#define XY_MONO_SRC_BLT_CMD	((2 << 29) | (0x54 << 22) | 6)
+#define XY_MONO_SRC_IMM_BLT_CMD	((2 << 29) | (0x71 << 22) | 5)
+#define TXT_IMM_BLT_CMD	        ((2 << 29) | (0x30 << 22) | 2)
+#define SETUP_BLT_CMD	        ((2 << 29) | (0x00 << 22) | 6)
+
+#define DW_LENGTH_MASK			0xff
+
+#define WRITE_ALPHA			(1 << 21)
+#define WRITE_RGB			(1 << 20)
+#define VERT_SEED			(3 << 8)
+#define HORIZ_SEED			(3 << 12)
+
+#define COLOR_DEPTH_8			(0 << 24)
+#define COLOR_DEPTH_16			(1 << 24)
+#define COLOR_DEPTH_32			(3 << 24)
+
+#define SRC_ROP_GXCOPY			0xcc
+#define SRC_ROP_GXXOR			0x66
+
+#define PAT_ROP_GXCOPY                  0xf0
+#define PAT_ROP_GXXOR                   0x5a
+
+#define PITCH_SHIFT			0
+#define ROP_SHIFT			16
+#define WIDTH_SHIFT			0
+#define HEIGHT_SHIFT			16
+
+/* in bytes */
+#define MAX_MONO_IMM_SIZE		128
+
+
+/*** Macros ***/
+
+/* I/O macros */
+#define INREG8(addr)	      readb((u8 *)(dinfo->mmio_base + (addr)))
+#define INREG(addr)	      readl((u32 *)(dinfo->mmio_base + (addr)))
+#define OUTREG8(addr, val)    writeb((val), (u8 *)(dinfo->mmio_base + (add=
r)))
+#define OUTREG(addr, val)     writel((val), (u32 *)(dinfo->mmio_base + (ad=
dr)))
+
+/* Ring buffer macros */
+#define OUT_RING(n)	do {						\
+	writel((n), (u32 *)(dinfo->ring.virtual + dinfo->ring_tail));	\
+	dinfo->ring_tail +=3D 4;						\
+	dinfo->ring_tail &=3D dinfo->ring_tail_mask;			\
+} while (0)
+
+#define START_RING(n)	do {						\
+	if (dinfo->ring_space < (n) * 4)				\
+		wait_ring(dinfo,(n) * 4);				\
+	dinfo->ring_space -=3D (n) * 4;					\
+} while (0)
+
+#define ADVANCE_RING()	do {						\
+	OUTREG(PRI_RING_TAIL, dinfo->ring_tail);                        \
+} while (0)
+
+#define DO_RING_IDLE()	do {						\
+	u32 head, tail;							\
+	do {								\
+		head =3D INREG(PRI_RING_HEAD) & RING_HEAD_MASK;		\
+		tail =3D INREG(PRI_RING_TAIL) & RING_TAIL_MASK;		\
+		udelay(10);						\
+	} while (head !=3D tail);						\
+} while (0)
+
+
+/* function protoypes */
+extern int intelfbhw_get_chipset(struct pci_dev *pdev, const char **name,
+				 int *chipset, int *mobile);
+extern int intelfbhw_get_memory(struct pci_dev *pdev, int *aperture_size,
+				int *stolen_size);
+extern int intelfbhw_check_non_crt(struct intelfb_info *dinfo);
+extern const char *intelfbhw_dvo_to_string(int dvo);
+extern int intelfbhw_validate_mode(struct intelfb_info *dinfo,
+				   struct fb_var_screeninfo *var);
+extern int intelfbhw_pan_display(struct fb_var_screeninfo *var,
+				 struct fb_info *info);
+extern void intelfbhw_do_blank(int blank, struct fb_info *info);
+extern void intelfbhw_setcolreg(struct intelfb_info *dinfo, unsigned regno,
+				unsigned red, unsigned green, unsigned blue,
+				unsigned transp);
+extern int intelfbhw_read_hw_state(struct intelfb_info *dinfo,
+				   struct intelfb_hwstate *hw, int flag);
+extern void intelfbhw_print_hw_state(struct intelfb_info *dinfo,
+				     struct intelfb_hwstate *hw);
+extern int intelfbhw_mode_to_hw(struct intelfb_info *dinfo,
+				struct intelfb_hwstate *hw,
+				struct fb_var_screeninfo *var);
+extern int intelfbhw_program_mode(struct intelfb_info *dinfo,
+				  const struct intelfb_hwstate *hw, int blank);
+extern void intelfbhw_do_sync(struct intelfb_info *dinfo);
+extern void intelfbhw_2d_stop(struct intelfb_info *dinfo);
+extern void intelfbhw_2d_start(struct intelfb_info *dinfo);
+extern void intelfbhw_do_fillrect(struct intelfb_info *dinfo, u32 x, u32 y,
+				  u32 w, u32 h, u32 color, u32 pitch, u32 bpp,
+				  u32 rop);
+extern void intelfbhw_do_bitblt(struct intelfb_info *dinfo, u32 curx, u32 =
cury,
+				u32 dstx, u32 dsty, u32 w, u32 h, u32 pitch,
+				u32 bpp);
+extern int intelfbhw_do_drawglyph(struct intelfb_info *dinfo, u32 fg, u32 =
bg,
+				  u32 w, u32 h, const u8* cdat, u32 x, u32 y,
+				  u32 pitch, u32 bpp);
+extern void intelfbhw_cursor_init(struct intelfb_info *dinfo);
+extern void intelfbhw_cursor_hide(struct intelfb_info *dinfo);
+extern void intelfbhw_cursor_show(struct intelfb_info *dinfo);
+extern void intelfbhw_cursor_setpos(struct intelfb_info *dinfo, int x, int=
 y);
+extern void intelfbhw_cursor_setcolor(struct intelfb_info *dinfo, u32 bg,
+				      u32 fg);
+extern void intelfbhw_cursor_load(struct intelfb_info *dinfo, int width,
+				  int height, u8 *data);
+extern void intelfbhw_cursor_reset(struct intelfb_info *dinfo);
+
+#endif /* _INTELFBHW_H */
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
=2D-- a/include/linux/fb.h	2004-10-17 15:03:25 +08:00
+++ b/include/linux/fb.h	2004-10-21 05:06:32 +08:00
@@ -102,6 +102,7 @@
 #define FB_ACCEL_I810           39      /* Intel 810/815                */
 #define FB_ACCEL_SIS_GLAMOUR_2  40	/* SiS 315, 650, 740		*/
 #define FB_ACCEL_SIS_XABRE      41	/* SiS 330 ("Xabre")		*/
+#define FB_ACCEL_I830           42      /* Intel 830M/845G/85x/865G     */
=20
 #define FB_ACCEL_NEOMAGIC_NM2070 90	/* NeoMagic NM2070              */
 #define FB_ACCEL_NEOMAGIC_NM2090 91	/* NeoMagic NM2090              */




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
