From: Christopher Hoover <ch@murgatroid.com>
Subject: Re: [PATCH 2.5.68] Epson 1355 Rewrite for 2.5
Date: Tue, 13 May 2003 18:31:39 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030513183135.A31196@heavens.murgatroid.com>
References: <Pine.GSO.4.21.0305080731520.12135-100000@vervain.sonytel.be> <Pine.LNX.4.44.0305132326190.12672-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139] helo=heavens.murgatroid.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Fl7S-0004au-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 May 2003 18:31:46 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305132326190.12672-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Tue, May 13, 2003 at 11:32:39PM +0100
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, May 13, 2003 at 11:32:39PM +0100, James Simmons wrote:
> Chris coudl you send me what you have tho. Just merge in your version of 
> the cfb* functions into your driver for now. 
>   Currently I'm trying to push a bunch to Linus. So I like to push your 
> driver.

Sure.  Here it is.  Diff'ed off of 2.5.68-rmk1 but I checked that it
applies cleanly to 2.5.68.

-ch
mailto:ch(at)murgatroid.com
mailto:ch(at)hpl.hp.com

--- linux-2.5.68-rmk1/MAINTAINERS	2003-04-19 19:50:01.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/MAINTAINERS	2003-05-13 18:07:06.000000000 -0700
@@ -644,6 +644,11 @@ L:	emu10k1-devel@lists.sourceforge.net
 W:	http://sourceforge.net/projects/emu10k1/
 S:	Maintained
 
+EPSON 1355 FRAMEBUFFER DRIVER
+P:	Christopher Hoover
+M:	ch@murgatroid.com, ch@hpl.hp.com
+S:	Maintained
+
 ETHEREXPRESS-16 NETWORK DRIVER
 P:	Philip Blundell
 M:	Philip.Blundell@pobox.com
diff -X dontdiff.txt -Naurp linux-2.5.68-rmk1/include/video/epson1355.h linux-2.5.68-rmk1-ceiva1/include/video/epson1355.h
--- linux-2.5.68-rmk1/include/video/epson1355.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.5.68-rmk1-ceiva1/include/video/epson1355.h	2003-05-13 18:19:14.000000000 -0700
@@ -0,0 +1,72 @@
+/*
+ * include/video/epson1355.h
+ *
+ * Epson Research S1D13505 Embedded RAMDAC LCD/CRT Controller
+ *   (previously known as SED1355)
+ *
+ * Cf. http://www.erd.epson.com/vdc/html/S1D13505.html
+ *
+ * Copyright (C) Hewlett-Packard Company.  All rights reserved.
+ *
+ * Written by Christopher Hoover <ch@hpl.hp.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ */
+
+#ifndef _EPSON1355_H_
+#define _EPSON1355_H_
+
+#define REG_REVISION_CODE              0x00
+#define REG_MEMORY_CONFIG              0x01
+#define REG_PANEL_TYPE                 0x02
+#define REG_MOD_RATE                   0x03
+#define REG_HORZ_DISP_WIDTH            0x04
+#define REG_HORZ_NONDISP_PERIOD        0x05
+#define REG_HRTC_START_POSITION        0x06
+#define REG_HRTC_PULSE_WIDTH           0x07
+#define REG_VERT_DISP_HEIGHT0          0x08
+#define REG_VERT_DISP_HEIGHT1          0x09
+#define REG_VERT_NONDISP_PERIOD        0x0A
+#define REG_VRTC_START_POSITION        0x0B
+#define REG_VRTC_PULSE_WIDTH           0x0C
+#define REG_DISPLAY_MODE               0x0D
+#define REG_SCRN1_LINE_COMPARE0        0x0E
+#define REG_SCRN1_LINE_COMPARE1        0x0F
+#define REG_SCRN1_DISP_START_ADDR0     0x10
+#define REG_SCRN1_DISP_START_ADDR1     0x11
+#define REG_SCRN1_DISP_START_ADDR2     0x12
+#define REG_SCRN2_DISP_START_ADDR0     0x13
+#define REG_SCRN2_DISP_START_ADDR1     0x14
+#define REG_SCRN2_DISP_START_ADDR2     0x15
+#define REG_MEM_ADDR_OFFSET0           0x16
+#define REG_MEM_ADDR_OFFSET1           0x17
+#define REG_PIXEL_PANNING              0x18
+#define REG_CLOCK_CONFIG               0x19
+#define REG_POWER_SAVE_CONFIG          0x1A
+#define REG_MISC                       0x1B
+#define REG_MD_CONFIG_READBACK0        0x1C
+#define REG_MD_CONFIG_READBACK1        0x1D
+#define REG_GPIO_CONFIG0               0x1E
+#define REG_GPIO_CONFIG1               0x1F
+#define REG_GPIO_CONTROL0              0x20
+#define REG_GPIO_CONTROL1              0x21
+#define REG_PERF_ENHANCEMENT0          0x22
+#define REG_PERF_ENHANCEMENT1          0x23
+#define REG_LUT_ADDR                   0x24
+#define REG_RESERVED_1                 0x25
+#define REG_LUT_DATA                   0x26
+#define REG_INK_CURSOR_CONTROL         0x27
+#define REG_CURSOR_X_POSITION0         0x28
+#define REG_CURSOR_X_POSITION1         0x29
+#define REG_CURSOR_Y_POSITION0         0x2A
+#define REG_CURSOR_Y_POSITION1         0x2B
+#define REG_INK_CURSOR_COLOR0_0        0x2C
+#define REG_INK_CURSOR_COLOR0_1        0x2D
+#define REG_INK_CURSOR_COLOR1_0        0x2E
+#define REG_INK_CURSOR_COLOR1_1        0x2F
+#define REG_INK_CURSOR_START_ADDR      0x30
+#define REG_ALTERNATE_FRM              0x31
+
+#endif
diff -X dontdiff.txt -Naurp linux-2.5.68-rmk1/drivers/video/Kconfig linux-2.5.68-rmk1-ceiva1/drivers/video/Kconfig
--- linux-2.5.68-rmk1/drivers/video/Kconfig	2003-04-19 19:48:49.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/drivers/video/Kconfig	2003-05-13 18:15:28.000000000 -0700
@@ -423,34 +423,14 @@ config FB_PVR2_DEBUG
 	  messages. Most people will want to say N here. If unsure, you will
 	  also want to say N.
 
-config FB_E1355
+config FB_EPSON1355
 	bool "Epson 1355 framebuffer support"
-	depends on FB && SUPERH
+	depends on FB
 	help
-	  Build in support for the SED1355 Epson Research Embedded RAMDAC
-	  LCD/CRT Controller (since redesignated as the S1D13505) as a
-	  framebuffer.  Product specs at
-	  <http://www.erd.epson.com/vdc/html/products.htm>.
-
-config E1355_REG_BASE
-	hex "Register Base Address"
-	depends on FB_E1355
-	default "a8000000"
-	help
-	  Epson SED1355/S1D13505 LCD/CRT controller register base address.
-	  See the manuals at
-	  <http://www.erd.epson.com/vdc/html/contents/S1D13505.htm> for
-	  discussion.
-
-config E1355_FB_BASE
-	hex "Framebuffer Base Address"
-	depends on FB_E1355
-	default "a8200000"
-	help
-	  Epson SED1355/S1D13505 LCD/CRT controller memory base address.  See
-	  the manuals at
-	  <http://www.erd.epson.com/vdc/html/contents/S1D13505.htm> for
-	  discussion.
+	  This drivers supports the Epson Research S1D13505 Embedded RAMDAC
+	  LCD/CRT Controller (previously known as SED1355).  Say Y if
+	  you have such a chip.
+
 
 config FB_RIVA
 	tristate "nVidia Riva support"
diff -X dontdiff.txt -Naurp linux-2.5.68-rmk1/drivers/video/Makefile linux-2.5.68-rmk1-ceiva1/drivers/video/Makefile
--- linux-2.5.68-rmk1/drivers/video/Makefile	2003-04-19 19:48:51.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/drivers/video/Makefile	2003-04-30 16:34:55.000000000 -0700
@@ -68,7 +68,7 @@ obj-$(CONFIG_FB_HGA)              += hga
 obj-$(CONFIG_FB_SA1100)           += sa1100fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_VIRTUAL)          += vfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HIT)              += hitfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_E1355)            += epson1355fb.o
+obj-$(CONFIG_FB_EPSON1355)        += epson1355fb.o
 obj-$(CONFIG_FB_PVR2)             += pvr2fb.o
 obj-$(CONFIG_FB_VOODOO1)          += sstfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 
diff -X dontdiff.txt -Naurp linux-2.5.68-rmk1/drivers/video/cfbcopyarea.c linux-2.5.68-rmk1-ceiva1/drivers/video/cfbcopyarea.c
--- linux-2.5.68-rmk1/drivers/video/cfbcopyarea.c	2003-04-19 19:50:46.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/drivers/video/cfbcopyarea.c	2003-05-13 18:04:44.000000000 -0700
@@ -29,16 +29,30 @@
 #include <asm/types.h>
 #include <asm/io.h>
 
+/* this file may be included in your source file, with your own
+ * fb_{read,write}{l,q} routines, if you define CFB_SOURCE_INCLUDE,
+ * CFB_COPYAREA_FN, and _FB_{READ|WRITE}{Q|L} */
+#ifndef CFB_SOURCE_INCLUDE
+#  define CFB_COPYAREA_FN cfb_copyarea
+#  define CFB_COPYAREA_DECL
+#  define _FB_WRITEL fb_writel
+#  define _FB_READL fb_readl
+#  define _FB_WRITEQ fb_writeq
+#  define _FB_READQ fb_readq
+#else
+#  define CFB_COPYAREA_DECL static
+#endif
+
 #define LONG_MASK  (BITS_PER_LONG - 1)
 
 #if BITS_PER_LONG == 32
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
+#define FB_WRITEL _FB_WRITEL
+#define FB_READL  _FB_READL
 #define SHIFT_PER_LONG 5
 #define BYTES_PER_LONG 4
 #else
-#define FB_WRITEL fb_writeq
-#define FB_READL  fb_readq
+#define FB_WRITEL _FB_WRITEQ
+#define FB_READL  _FB_READQ
 #define SHIFT_PER_LONG 6
 #define BYTES_PER_LONG 8
 #endif
@@ -337,7 +351,8 @@ static void bitcpy_rev(unsigned long *ds
 	}
 }
 
-void cfb_copyarea(struct fb_info *p, const struct fb_copyarea *area)
+CFB_COPYAREA_DECL
+void CFB_COPYAREA_FN(struct fb_info *p, const struct fb_copyarea *area)
 {
 	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
 	u32 height = area->height, width = area->width;
@@ -424,9 +439,10 @@ void cfb_copyarea(struct fb_info *p, con
 	}
 }
 
+#ifndef CFB_SOURCE_INCLUDE
 EXPORT_SYMBOL(cfb_copyarea);
 
 MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
 MODULE_DESCRIPTION("Generic software accelerated copyarea");
 MODULE_LICENSE("GPL");
-
+#endif
diff -X dontdiff.txt -Naurp linux-2.5.68-rmk1/drivers/video/cfbfillrect.c linux-2.5.68-rmk1-ceiva1/drivers/video/cfbfillrect.c
--- linux-2.5.68-rmk1/drivers/video/cfbfillrect.c	2003-04-19 19:49:54.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/drivers/video/cfbfillrect.c	2003-05-13 18:04:02.000000000 -0700
@@ -23,14 +23,28 @@
 #include <linux/fb.h>
 #include <asm/types.h>
 
+/* this file may be included in your source file, with your own
+ * fb_{read,write}{l,q} routines, if you define CFB_SOURCE_INCLUDE,
+ * CFB_FILLRECT_FN, and _FB_{READ|WRITE}{Q|L} */
+#ifndef CFB_SOURCE_INCLUDE
+#  define CFB_FILLRECT_FN cfb_fillrect
+#  define CFB_FILLRECT_DECL
+#  define _FB_WRITEL fb_writel
+#  define _FB_READL fb_readl
+#  define _FB_WRITEQ fb_writeq
+#  define _FB_READQ fb_readq
+#else
+#  define CFB_FILLRECT_DECL static
+#endif
+
 #if BITS_PER_LONG == 32
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
+#define FB_WRITEL _FB_WRITEL
+#define FB_READL  _FB_READL
 #define BYTES_PER_LONG 4
 #define SHIFT_PER_LONG 5
 #else
-#define FB_WRITEL fb_writeq
-#define FB_READL  fb_readq
+#define FB_WRITEL _FB_WRITEQ
+#define FB_READL  _FB_READQ
 #define BYTES_PER_LONG 8
 #define SHIFT_PER_LONG 6
 #endif
@@ -119,7 +133,7 @@ static inline unsigned long pixel_to_pat
      *  Unaligned 32-bit pattern fill using 32/64-bit memory accesses
      */
 
-void bitfill32(unsigned long *dst, int dst_idx, u32 pat, u32 n)
+static void bitfill32(unsigned long *dst, int dst_idx, u32 pat, u32 n)
 {
 	unsigned long val = pat;
 	unsigned long first, last;
@@ -178,7 +192,7 @@ void bitfill32(unsigned long *dst, int d
      *  used for the next 32/64-bit word
      */
 
-void bitfill(unsigned long *dst, int dst_idx, unsigned long pat, int left,
+static void bitfill(unsigned long *dst, int dst_idx, unsigned long pat, int left,
 	     int right, u32 n)
 {
 	unsigned long first, last;
@@ -228,7 +242,7 @@ void bitfill(unsigned long *dst, int dst
 	}
 }
 
-void bitfill32_rev(unsigned long *dst, int dst_idx, u32 pat, u32 n)
+static void bitfill32_rev(unsigned long *dst, int dst_idx, u32 pat, u32 n)
 {
 	unsigned long val = pat, dat;
 	unsigned long first, last;
@@ -300,7 +314,7 @@ void bitfill32_rev(unsigned long *dst, i
      *  used for the next 32/64-bit word
      */
 
-void bitfill_rev(unsigned long *dst, int dst_idx, unsigned long pat, int left,
+static void bitfill_rev(unsigned long *dst, int dst_idx, unsigned long pat, int left,
 	     int right, u32 n)
 {
 	unsigned long first, last, dat;
@@ -359,7 +373,8 @@ void bitfill_rev(unsigned long *dst, int
 	}
 }
 
-void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
+CFB_FILLRECT_DECL
+void CFB_FILLRECT_FN(struct fb_info *p, const struct fb_fillrect *rect)
 {
 	u32 bpp = p->var.bits_per_pixel;
 	unsigned long x2, y2, vxres, vyres;
@@ -451,8 +466,10 @@ void cfb_fillrect(struct fb_info *p, con
 	}
 }
 
+#ifndef CFB_SOURCE_INCLUDE
 EXPORT_SYMBOL(cfb_fillrect);
 
 MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
 MODULE_DESCRIPTION("Generic software accelerated fill rectangle");
 MODULE_LICENSE("GPL");
+#endif
diff -X dontdiff.txt -Naurp linux-2.5.68-rmk1/drivers/video/cfbimgblt.c linux-2.5.68-rmk1-ceiva1/drivers/video/cfbimgblt.c
--- linux-2.5.68-rmk1/drivers/video/cfbimgblt.c	2003-04-19 19:49:54.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/drivers/video/cfbimgblt.c	2003-05-13 18:04:10.000000000 -0700
@@ -35,6 +35,20 @@
 #include <linux/fb.h>
 #include <asm/types.h>
 
+/* this file may be included in your source file, with your own
+ * fb_{read,write}{l,q} routines, if you define CFB_SOURCE_INCLUDE,
+ * CFB_IMAGEBLIT_FN, and _FB_{READ|WRITE}{Q|L} */
+#ifndef CFB_SOURCE_INCLUDE
+#  define CFB_IMAGEBLIT_FN cfb_imageblit
+#  define CFB_IMAGEBLIT_DECL
+#  define _FB_WRITEL fb_writel
+#  define _FB_READL fb_readl
+#  define _FB_WRITEQ fb_writeq
+#  define _FB_READQ fb_readq
+#else
+#  define CFB_IMAGEBLIT_DECL static
+#endif
+
 #define DEBUG
 
 #ifdef DEBUG
@@ -84,13 +98,13 @@ static u32 cfb_tab32[] = {
 #endif
 
 #if BITS_PER_LONG == 32
-#define FB_WRITEL	fb_writel
-#define FB_READL	fb_readl
+#define FB_WRITEL	_FB_WRITEL
+#define FB_READL	_FB_READL
 #define INIT_FASTPATH	{}
-#define FASTPATH	fb_writel((end_mask & eorx)^bgx, dst++)
+#define FASTPATH	_FB_WRITEL((end_mask & eorx)^bgx, dst++)
 #else
-#define FB_WRITEL	fb_writeq
-#define FB_READL	fb_readq
+#define FB_WRITEL	_FB_WRITEQ
+#define FB_READL	_FB_READQ
 #define INIT_FASTPATH	unsigned long val = 0, bpl = 0
 #define FASTPATH {					\
 	val |= SHIFT_HIGH((end_mask & eorx)^bgx, bpl);	\
@@ -290,7 +304,9 @@ static inline void fast_imageblit(const 
 	}
 }	
 	
-void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
+
+CFB_IMAGEBLIT_DECL
+void CFB_IMAGEBLIT_FN(struct fb_info *p, const struct fb_image *image)
 {
 	unsigned long fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
 	unsigned long bpl = sizeof(unsigned long), bpp = p->var.bits_per_pixel;
@@ -350,9 +366,10 @@ void cfb_imageblit(struct fb_info *p, co
 		color_imageblit(image, p, dst1, start_index, pitch_index);
 }
 
+#ifndef CFB_SOURCE_INCLUDE
 EXPORT_SYMBOL(cfb_imageblit);
 
 MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
 MODULE_DESCRIPTION("Generic software accelerated imaging drawing");
 MODULE_LICENSE("GPL");
-
+#endif
diff -X dontdiff.txt -Naurp linux-2.5.68-rmk1/drivers/video/epson1355fb.c linux-2.5.68-rmk1-ceiva1/drivers/video/epson1355fb.c
--- linux-2.5.68-rmk1/drivers/video/epson1355fb.c	2003-04-19 19:48:50.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/drivers/video/epson1355fb.c	2003-05-13 18:19:24.000000000 -0700
@@ -1,542 +1,726 @@
 /*
- * linux/drivers/video/epson1355fb.c
- *	-- Support for the Epson SED1355 LCD/CRT controller
+ * linux/drivers/video/epson1355fb.c -- Epson S1D13505 frame buffer for 2.5.
  *
- * Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>
+ * Epson Research S1D13505 Embedded RAMDAC LCD/CRT Controller
+ *   (previously known as SED1355)
  *
- * based on linux/drivers/video/skeletonfb.c, which was
+ * Cf. http://www.erd.epson.com/vdc/html/S1D13505.html
+ *
+ *
+ * Copyright (C) Hewlett-Packard Company.  All rights reserved.
+ *
+ * Written by Christopher Hoover <ch@hpl.hp.com>
+ *
+ * Adapted from:
+ *
+ *  linux/drivers/video/skeletonfb.c
+ *  Modified to new api Jan 2001 by James Simmons (jsimmons@transvirtual.com)
  *  Created 28 Dec 1997 by Geert Uytterhoeven
  *
+ *  linux/drivers/video/epson1355fb.c (2.4 driver)
+ *  Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>
+ *
  * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
- */
-/* TODO (roughly in order of priority):
- * 16 bpp support
- * crt support
- * hw cursor support
- * SwivelView
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ *
+ * Noteworthy Issues
+ * -----------------
+ *
+ * This driver is complicated by the fact that this is a 16-bit chip
+ * and, on at least one platform (ceiva), we can only do 16-bit reads
+ * and writes to the framebuffer.  We hide this from user space
+ * except in the case of mmap().
+ *
+ *
+ * To Do
+ * -----
+ *
+ * - Test 8-bit pseudocolor mode
+ * - Allow setting bpp, virtual resolution 
+ * - Implement horizontal panning
+ * - (maybe) Implement hardware cursor
  */
 
-#include <asm/io.h>
-#include <linux/config.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/fb.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/mm.h>
 #include <linux/tty.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-mfb.h>
-#include <video/fbcon.h>
-
-/* Register defines.  The docs don't seem to provide nice mnemonic names
- * so I made them up myself ... */
-
-#define E1355_PANEL	0x02
-#define E1355_DISPLAY	0x0D
-#define E1355_MISC	0x1B
-#define E1355_GPIO	0x20
-#define E1355_LUT_INDEX 0x24
-#define E1355_LUT_DATA	0x26
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <asm/types.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#include <video/epson1355.h>
+
+static struct fb_info info;
+
+static struct epson1355fb_par { 
+	unsigned long reg_addr;
+} par;
+
+static u32 pseudo_palette[16];
+
+/* ------------------------------------------------------------------------- */
 
 #ifdef CONFIG_SUPERH
-#define E1355_REG_BASE	CONFIG_E1355_REG_BASE
-#define E1355_FB_BASE	CONFIG_E1355_FB_BASE
 
-static inline u8 e1355_read_reg(int index)
+static inline u8 epson1355_read_reg(int index)
 {
-	return ctrl_inb(E1355_REG_BASE + index);
+	return ctrl_inb(par.reg_addr + index);
 }
 
-static inline void e1355_write_reg(u8 data, int index)
+static inline void epson1355_write_reg(u8 data, int index)
 {
-	ctrl_outb(data, E1355_REG_BASE + index);
+	ctrl_outb(data, par.reg_addr + index);
 }
 
-static inline u16 e1355_read_reg16(int index)
+#elif defined(CONFIG_ARM)
+
+# ifdef CONFIG_ARCH_CEIVA
+#  include <asm/arch/hardware.h>
+#  define EPSON1355FB_BASE_PHYS	(CEIVA_PHYS_SED1355)
+# endif
+
+static inline u8 epson1355_read_reg(int index)
 {
-	return e1355_read_reg(index) + (e1355_read_reg(index+1) << 8);
+        return __raw_readb(par.reg_addr + index);
 }
 
-static inline void e1355_write_reg16(u16 data, int index)
+static inline void epson1355_write_reg(u8 data, int index)
 {
-	e1355_write_reg((data&0xff), index);
-	e1355_write_reg(((data>>8)&0xff), index + 1);
+        __raw_writeb(data, par.reg_addr + index);
 }
+
 #else
-#error unknown architecture
+# error "no architecture-specific epson1355_{read,write}_reg"
 #endif
 
-struct e1355fb_info {
-	struct fb_info_gen gen;
-};
 
-static int current_par_valid = 0;
-static struct display disp;
+#ifndef EPSON1355FB_BASE_PHYS
+# error  "EPSON1355FB_BASE_PHYS is not defined"
+#endif
 
-static struct fb_var_screeninfo default_var;
+#define EPSON1355FB_REGS_OFS	(0)
+#define EPSON1355FB_REGS_PHYS	(EPSON1355FB_BASE_PHYS + EPSON1355FB_REGS_OFS)
+#define EPSON1355FB_REGS_LEN	(64)
 
-int e1355fb_init(void);
-int e1355fb_setup(char*);
-static int e1355_encode_var(struct fb_var_screeninfo *var, const void *par,
-			    struct fb_info_gen *info);
-/* ------------------- chipset specific functions -------------------------- */
+#define EPSON1355FB_FB_OFS	(0x00200000)
+#define EPSON1355FB_FB_PHYS	(EPSON1355FB_BASE_PHYS + EPSON1355FB_FB_OFS)
+#define EPSON1355FB_FB_LEN	(2 * 1024 * 1024)
 
+/* ------------------------------------------------------------------------- */
 
-static void disable_hw_cursor(void)
+static inline u16 epson1355_read_reg16(int index)
 {
-	u8 curs;
+	u8 lo = epson1355_read_reg(index);
+	u8 hi = epson1355_read_reg(index + 1);
 
-	curs = e1355_read_reg(0x27);
-	curs &= ~0xc0;
-	e1355_write_reg(curs, 0x27);
+	return  (hi << 8) | lo;
 }
 
-static void e1355_detect(void)
+static inline void epson1355_write_reg16(u16 data, int index)
 {
-	u8 rev;
-
-	e1355_write_reg(0x00, E1355_MISC);
+	u8 lo = data & 0xff;
+	u8 hi = (data >> 8) & 0xff;
 
-	rev = e1355_read_reg(0x00);
-
-	if ((rev & 0xfc) != 0x0c) {
-		printk(KERN_WARNING "Epson 1355 not detected\n");
-	}
+	epson1355_write_reg(lo, index);
+	epson1355_write_reg(hi, index + 1);
+}
 
-	/* XXX */
-	disable_hw_cursor();
+static inline u32 epson1355_read_reg20(int index)
+{
+	u8 b0 = epson1355_read_reg(index);
+	u8 b1 = epson1355_read_reg(index + 1);
+	u8 b2 = epson1355_read_reg(index + 2);
 
-	e1355_encode_var(&default_var, NULL, NULL);
+	return  (b2 & 0x0f) << 16 | (b1 << 8) | b0;
 }
 
-struct e1355_par {
-	u32 xres;
-	u32 yres;
+static inline void epson1355_write_reg20(u32 data, int index)
+{
+	u8 b0 = data & 0xff;
+	u8 b1 = (data >> 8) & 0xff;
+	u8 b2 = (data >> 16) & 0x0f;
 
-	int bpp;
-	int mem_bpp;
+	epson1355_write_reg(b0, index);
+	epson1355_write_reg(b1, index + 1);
+	epson1355_write_reg(b2, index + 2);
+}
 
-	u32 panel_xres;
-	u32 panel_yres;
-	
-	int panel_width;
-	int panel_ymul;
-};
+/* ------------------------------------------------------------------------- */
 
-static int e1355_encode_fix(struct fb_fix_screeninfo *fix,
-			    const void *raw_par,
-			    struct fb_info_gen *info)
+static void set_lut(u8 index, u8 r, u8 g, u8 b)
 {
-	const struct e1355_par *par = raw_par;
-	
-	memset(fix, 0, sizeof *fix);
-	
-	fix->type= FB_TYPE_PACKED_PIXELS;
+	epson1355_write_reg(index, REG_LUT_ADDR);
+	epson1355_write_reg(r, REG_LUT_DATA);
+	epson1355_write_reg(g, REG_LUT_DATA);
+	epson1355_write_reg(b, REG_LUT_DATA);
+}
 
-	if (!par)
-		BUG();
 
-	if (par->bpp == 1) {
-		fix->visual = FB_VISUAL_MONO10;
-	} else if (par->bpp <= 8) {
-		fix->visual = FB_VISUAL_PSEUDOCOLOR;
-	} else {
-		fix->visual = FB_VISUAL_TRUECOLOR;
-	}
+/**
+ *  	epson1355fb_setcolreg - sets a color register.
+ *      @regno: Which register in the CLUT we are programming 
+ *      @red: The red value which can be up to 16 bits wide 
+ *	@green: The green value which can be up to 16 bits wide 
+ *	@blue:  The blue value which can be up to 16 bits wide.
+ *	@transp: If supported the alpha value which can be up to 16 bits wide.
+ *      @info: frame buffer info structure
+ * 
+ *	Returns negative errno on error, or zero on success.
+ */
+static int epson1355fb_setcolreg(unsigned regno, unsigned r, unsigned g,
+				 unsigned b, unsigned transp,
+				 struct fb_info *info)
+{
+	if (info->var.grayscale)
+		r = g = b = (19595 * r + 38470 * g + 7471 * b) >> 16;
+
+	switch (info->fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		if (regno >= 16)
+			return -EINVAL;
+
+		((u32 *) info->pseudo_palette)[regno] = 
+			(r & 0xf800) | 
+			(g & 0xfc00) >> 5 | 
+			(b & 0xf800) >> 11;
 
-	return 0;
-}
+		break;
+	case FB_VISUAL_PSEUDOCOLOR:
+		if (regno >= 256)
+			return -EINVAL;
 
-static int e1355_set_bpp(struct e1355_par *par, int bpp)
-{
-	int code;
-	u8 disp;
-	u16 bytes_per_line;
-
-	switch(bpp) {
-	case 1:
-		code = 0; break;
-	case 2:
-		code = 1; break;
-	case 4:
-		code = 2; break;
-	case 8:
-		code = 3; break;
-	case 16:
-		code = 5; break;
+		set_lut(regno, r>>8, g>>8, b>>8);
+
+		break;
 	default:
-		return -EINVAL; break;
+		return -ENOSYS;
 	}
 
-	disp = e1355_read_reg(E1355_DISPLAY);
-	disp &= ~0x1c;
-	disp |= code << 2;
-	e1355_write_reg(disp, E1355_DISPLAY);
-	
-	bytes_per_line = (par->xres * bpp) >> 3;
-	
-	e1355_write_reg16(bytes_per_line, 0x16);
-
-	par->bpp = bpp;
-
 	return 0;
 }
-		
-static int e1355_decode_var(const struct fb_var_screeninfo *var,
-			    void *raw_par,
-			    struct fb_info_gen *info)
+
+/* ------------------------------------------------------------------------- */
+
+/**
+ *      epson1355fb_pan_display - Pans the display.
+ *      @var: frame buffer variable screen structure
+ *      @info: frame buffer structure that represents a single frame buffer
+ *
+ *	Pan (or wrap, depending on the `vmode' field) the display using the
+ *  	`xoffset' and `yoffset' fields of the `var' structure.
+ *  	If the values don't fit, return -EINVAL.
+ *
+ *      Returns negative errno on error, or zero on success.
+ */
+static int epson1355fb_pan_display(struct fb_var_screeninfo *var,
+				   struct fb_info *info)
 {
-	struct e1355_par *par = raw_par;
-	int ret;
+	u32 start;
 
-	if (!par)
-		BUG();
+	if (var->xoffset != 0)	/* not yet ... */
+		return -EINVAL;
 
-	/*
-	 * Don't allow setting any of these yet: xres and yres don't
-	 * make sense for LCD panels; xres_virtual and yres_virtual
-	 * should be supported fine by our hardware though.
-	 */
-	if (var->xres != par->xres ||
-	    var->yres != par->yres ||
-	    var->xres != var->xres_virtual ||
-	    var->yres != var->yres_virtual ||
-	    var->xoffset != 0 ||
-	    var->yoffset != 0)
+	if (var->yoffset + info->var.yres > info->var.yres_virtual)
 		return -EINVAL;
 
-	if(var->bits_per_pixel != par->bpp) {
-		ret = e1355_set_bpp(par, var->bits_per_pixel);
+	start = (info->fix.line_length >> 1) * var->yoffset;
 
-		if (ret)
-			goto out_err;
-	}
-		
-	return 0;
+	epson1355_write_reg20(start, REG_SCRN1_DISP_START_ADDR0);
 
- out_err:
-	return ret;
+	return 0;
 }
 
-static void dump_panel_data(void)
+/* ------------------------------------------------------------------------- */
+
+static void lcd_enable(int enable)
 {
-	u8 panel = e1355_read_reg(E1355_PANEL);
-	int width[2][4] = { { 4, 8, 16, -1 }, { 9, 12, 16, -1 } };
+	u8 mode = epson1355_read_reg(REG_DISPLAY_MODE);
 
-	printk("%s %s %s panel, width %d bits\n",
-	       panel & 2 ? "dual" : "single",
-	       panel & 4 ? "color" : "mono",
-	       panel & 1 ? "TFT" : "passive",
-	       width[panel&1][(panel>>4)&3]);
+	if (enable)
+		mode |= 1;
+	else
+		mode &= ~1;
 
-	printk("resolution %d x %d\n",
-	       (e1355_read_reg(0x04) + 1) * 8,
-	       ((e1355_read_reg16(0x08) + 1) * (1 + ((panel & 3) == 2))));
+	epson1355_write_reg(mode, REG_DISPLAY_MODE);
 }
 
-static int e1355_bpp_to_var(int bpp, struct fb_var_screeninfo *var)
+#if defined(CONFIG_ARCH_CEIVA)
+static void backlight_enable(int enable)
 {
-	switch(bpp) {
-	case 1:
-	case 2:
-	case 4:
-	case 8:
-		var->bits_per_pixel = bpp;
-		var->red.offset = var->green.offset = var->blue.offset = 0;
-		var->red.length = var->green.length = var->blue.length = bpp;
+	/* ### this should be protected by a spinlock ... */
+	u8 pddr = clps_readb(PDDR);
+	if (enable)
+		pddr |= (1<<5);
+	else
+		pddr &= ~(1<<5);
+	clps_writeb(pddr, PDDR);
+}
+#else
+static void backlight_enable(int enable) { }
+#endif
+
+
+/**
+ *      epson1355fb_blank - blanks the display.
+ *      @blank_mode: the blank mode we want. 
+ *      @info: frame buffer structure that represents a single frame buffer
+ *
+ *      Blank the screen if blank_mode != 0, else unblank. Return 0 if
+ *      blanking succeeded, != 0 if un-/blanking failed due to e.g. a 
+ *      video mode which doesn't support it. Implements VESA suspend
+ *      and powerdown modes on hardware that supports disabling hsync/vsync:
+ *      blank_mode == 2: suspend vsync
+ *      blank_mode == 3: suspend hsync
+ *      blank_mode == 4: powerdown
+ *
+ *      Returns negative errno on error, or zero on success.
+ *
+ */
+static int epson1355fb_blank(int blank_mode, struct fb_info *info)
+{
+	switch (blank_mode) {
+	case VESA_NO_BLANKING:
+		lcd_enable(1);
+		backlight_enable(1);
 		break;
-	case 16:
-		var->bits_per_pixel = 16;
-		var->red.offset = 11;
-		var->red.length = 5;
-		var->green.offset = 5;
-		var->green.length = 6;
-		var->blue.offset = 0;
-		var->blue.length = 5;
+	case VESA_VSYNC_SUSPEND:
+	case VESA_HSYNC_SUSPEND:
+		backlight_enable(0);
+		break;
+	case VESA_POWERDOWN:
+		backlight_enable(0);
+		lcd_enable(0);
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int e1355_encode_var(struct fb_var_screeninfo *var, const void *raw_par,
-			    struct fb_info_gen *info)
+/* ------------------------------------------------------------------------- */
+
+/*
+ * We can't use the cfb generic routines, as we have to limit
+ * ourselves to 16-bit or 8-bit loads and stores to this 16-bit
+ * chip.
+ */
+
+static inline void epson1355fb_fb_writel(unsigned long v, unsigned long *a)
 {
-	u8 panel, display;
-	u32 xres, xres_virtual, yres;
-	static int width[2][4] = { { 4, 8, 16, -1 }, { 9, 12, 16, -1 } };
-	static int bpp_tab[8] = { 1, 2, 4, 8, 15, 16 };
-	int bpp, hw_bpp;
-	int is_color, is_dual, is_tft;
-	int lcd_enabled, crt_enabled;
+	u16 *p = (u16 *) a;
+	u16 l = v & 0xffff;
+	u16 h = v >> 16;
+	
+	fb_writew(l, p);
+	fb_writew(h, p + 1);
+}
 
-	panel = e1355_read_reg(E1355_PANEL);
-	display = e1355_read_reg(E1355_DISPLAY);
+static inline unsigned long epson1355fb_fb_readl(const unsigned long *a)
+{
+	const u16 *p = (u16 *) a;
+	u16 l = fb_readw(p);
+	u16 h = fb_readw(p + 1);
 
-	is_color = (panel & 0x04) != 0;
-	is_dual  = (panel & 0x02) != 0;
-	is_tft   = (panel & 0x01) != 0;
+	return (h<<16) | l;
+}
 
-	bpp = bpp_tab[(display>>2)&7]; 
-	e1355_bpp_to_var(bpp, var);
+/* use the generic routines, but with our special definitions of
+   FB_{READ|WRITE}L */
 
-	crt_enabled = (display & 0x02) != 0;
-	lcd_enabled = (display & 0x02) != 0;
+#define CFB_SOURCE_INCLUDE
+#define _FB_READL epson1355fb_fb_readl
+#define _FB_WRITEL epson1355fb_fb_writel
+#define CFB_FILLRECT_FN epson1355fb_fillrect
+#define CFB_IMAGEBLIT_FN epson1355fb_imageblit
+#define CFB_COPYAREA_FN epson1355fb_copyarea
 
-	hw_bpp = width[is_tft][(panel>>4)&3];
+#include "cfbfillrect.c"
+#include "cfbimgblt.c"
+#include "cfbcopyarea.c"
 
-	xres = e1355_read_reg(0x04) + 1;
-	yres = e1355_read_reg16(0x08) + 1;
+/* ------------------------------------------------------------------------- */
+
+static inline unsigned long copy_from_user16(void *to, const void *from, 
+					     unsigned long n)
+{
+	u16 *dst = (u16 *) to;
+	u16 *src = (u16 *) from;
+
+	if (!access_ok(VERIFY_READ, from, n))
+		return n;
 	
-	xres *= 8;
-	/* talk about weird hardware .. */
-	yres *= (is_dual && !crt_enabled) ? 2 : 1;
-
-	xres_virtual = e1355_read_reg16(0x16);
-	/* it's in 2-byte words initially */
-	xres_virtual *= 16;
-	xres_virtual /= var->bits_per_pixel;
+	while (n > 1) {
+		u16 v;
+		if (__get_user(v, src))
+			return n;
 
-	var->xres = xres;
-	var->yres = yres;
-	var->xres_virtual = xres_virtual;
-	var->yres_virtual = yres;
+		fb_writew(v, dst);
 
-	var->xoffset = var->yoffset = 0;
+		src++, dst++;
+		n -= 2;
+	}
+
+	if (n) {
+		u8 v;
+		
+		if (__get_user(v, ((u8 *) src)))
+			return n;
+
+		fb_writeb(v, dst);
+	}
 
-	var->grayscale = !is_color;
-	
 	return 0;
 }
 
-#define is_dual(panel) (((panel)&3)==2)
-
-static void get_panel_data(struct e1355_par *par)
+static inline unsigned long copy_to_user16(void *to, const void *from, 
+					   unsigned long n)
 {
-	u8 panel;
-	int width[2][4] = { { 4, 8, 16, -1 }, { 9, 12, 16, -1 } };
+	u16 *dst = (u16 *) to;
+	u16 *src = (u16 *) from;
 
-	panel = e1355_read_reg(E1355_PANEL);
+	if (!access_ok(VERIFY_WRITE, to, n))
+		return n;
+	
+	while (n > 1) {
+		u16 v = fb_readw(src);
 
-	par->panel_width = width[panel&1][(panel>>4)&3];
-	par->panel_xres = (e1355_read_reg(0x04) + 1) * 8;
-	par->panel_ymul = is_dual(panel) ? 2 : 1;
-	par->panel_yres = ((e1355_read_reg16(0x08) + 1)
-			   * par->panel_ymul);
-}
+		if (__put_user(v, dst))
+			return n;
 
-static void e1355_get_par(void *raw_par, struct fb_info_gen *info)
-{
-	struct e1355_par *par = raw_par;
+		src++, dst++;
+		n -= 2;
+	}
 
-	get_panel_data(par);
-}
+	if (n) {
+		u8 v = fb_readb(src);
+		
+		if (__put_user(v, ((u8 *) dst)))
+			return n;
+	}
 
-static void e1355_set_par(const void *par, struct fb_info_gen *info)
-{
+	return 0;
 }
 
-static int e1355_getcolreg(unsigned regno, unsigned *red, unsigned *green,
-			   unsigned *blue, unsigned *transp,
-			   struct fb_info *info)
+
+static ssize_t
+epson1355fb_read(struct file *file, char *buf, size_t count, loff_t *ppos)
 {
-	u8 r, g, b;
+	unsigned long p = *ppos;
 
-	e1355_write_reg(regno, E1355_LUT_INDEX);
-	r = e1355_read_reg(E1355_LUT_DATA);
-	g = e1355_read_reg(E1355_LUT_DATA);
-	b = e1355_read_reg(E1355_LUT_DATA);
+	/* from fbmem.c except for our own copy_*_user */
+	if (p >= info.fix.smem_len)
+	    return 0;
+	if (count >= info.fix.smem_len)
+	    count = info.fix.smem_len;
+	if (count + p > info.fix.smem_len)
+		count = info.fix.smem_len - p;
+
+	if (count) {
+	    char *base_addr;
+
+	    base_addr = info.screen_base;
+	    count -= copy_to_user16(buf, base_addr+p, count);
+	    if (!count)
+		return -EFAULT;
+	    *ppos += count;
+	}
+	return count;
+}
 
-	*red = r << 8;
-	*green = g << 8;
-	*blue = b << 8;
+static ssize_t
+epson1355fb_write(struct file *file, const char *buf, 
+		  size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	int err;
+
+	/* from fbmem.c except for our own copy_*_user */
+	if (p > info.fix.smem_len)
+	    return -ENOSPC;
+	if (count >= info.fix.smem_len)
+	    count = info.fix.smem_len;
+	err = 0;
+	if (count + p > info.fix.smem_len) {
+	    count = info.fix.smem_len - p;
+	    err = -ENOSPC;
+	}
 
-	return 0;
-}
+	if (count) {
+	    char *base_addr;
 
-static int e1355fb_setcolreg(unsigned regno, unsigned red, unsigned green,
-			     unsigned blue, unsigned transp,
-			     struct fb_info *info)
-{
-	u8 r = (red >> 8) & 0xf0;
-	u8 g = (green>>8) & 0xf0;
-	u8 b = (blue>> 8) & 0xf0;
-
-	e1355_write_reg(regno, E1355_LUT_INDEX);
-	e1355_write_reg(r, E1355_LUT_DATA);
-	e1355_write_reg(g, E1355_LUT_DATA);
-	e1355_write_reg(b, E1355_LUT_DATA);
-	
-	return 0;
-}
+	    base_addr = info.screen_base;
+	    count -= copy_from_user16(base_addr+p, buf, count);
+	    *ppos += count;
+	    err = -EFAULT;
+	}
+	if (count)
+		return count;
+	return err;
+}
+
+/* ------------------------------------------------------------------------- */
+
+static struct fb_ops epson1355fb_fbops = {
+	.owner		= THIS_MODULE,
+	.fb_setcolreg	= epson1355fb_setcolreg,
+	.fb_pan_display	= epson1355fb_pan_display,
+	.fb_blank	= epson1355fb_blank,
+	.fb_fillrect	= epson1355fb_fillrect,
+	.fb_copyarea	= epson1355fb_copyarea,
+	.fb_imageblit	= epson1355fb_imageblit,
+	.fb_read	= epson1355fb_read,
+	.fb_write	= epson1355fb_write,
+	.fb_cursor	= soft_cursor,
+};
+
+/* ------------------------------------------------------------------------- */
 
-static int e1355_pan_display(const struct fb_var_screeninfo *var,
-			     struct fb_info_gen *info)
+static  __init unsigned int get_fb_size(struct fb_info *info)
 {
-	BUG();
+	unsigned int size = 2 * 1024 * 1024;
+	char *p = info->screen_base;
+
+	/* the 512k framebuffer is aliased at start + 0x80000 * n */
+	fb_writeb(1, p);
+	fb_writeb(0, p + 0x80000);
+	if (!fb_readb(p))
+		size = 512 * 1024;
 	
-	return -EINVAL;
+	fb_writeb(0, p);
+
+	return size;
 }
 
-/*
- * The AERO_HACKS parts disable/enable the backlight on the Compaq Aero 8000.
- * I'm not sure they aren't dangerous to the hardware, so be warned.
- */
-#undef AERO_HACKS
+static int epson1355_width_tab[2][4] __initdata = 
+  { { 4, 8, 16, -1 }, { 9, 12, 16, -1 } };
+static int epson1355_bpp_tab[8] __initdata = 
+  { 1, 2, 4, 8, 15, 16 };
 
-static int e1355_blank(int blank_mode, struct fb_info_gen *info)
+static void __init fetch_hw_state(struct fb_info *info)
 {
-	u8 disp;
+	struct fb_var_screeninfo *var = &info->var;
+	struct fb_fix_screeninfo *fix = &info->fix;
+	u8 panel, display;
+	u16 offset;
+	u32 xres, yres;
+	u32 xres_virtual, yres_virtual;
+	int bpp, lcd_bpp;
+	int is_color, is_dual, is_tft;
+	int lcd_enabled, crt_enabled;
 
-	switch (blank_mode) {
-	case VESA_NO_BLANKING:
-		disp = e1355_read_reg(E1355_DISPLAY);
-		disp |= 1;
-		e1355_write_reg(disp, E1355_DISPLAY);
- 		
-#ifdef AERO_HACKS
-		e1355_write_reg(0x6, 0x20);
-#endif
-		break;
+	fix->type = FB_TYPE_PACKED_PIXELS;
 
-	case VESA_VSYNC_SUSPEND:
-	case VESA_HSYNC_SUSPEND:
-	case VESA_POWERDOWN:
-		disp = e1355_read_reg(E1355_DISPLAY);
-		disp &= ~1;
-		e1355_write_reg(disp, E1355_DISPLAY);
+	display = epson1355_read_reg(REG_DISPLAY_MODE);
+	bpp = epson1355_bpp_tab[(display>>2)&7]; 
 
-#ifdef AERO_HACKS
-		e1355_write_reg(0x0, 0x20);
-#endif
+	switch (bpp) {
+	case 8:
+		fix->visual = FB_VISUAL_PSEUDOCOLOR;
+		var->bits_per_pixel = 8;
+		var->red.offset = var->green.offset = var->blue.offset = 0;
+		var->red.length = var->green.length = var->blue.length = 8;
+		break;
+	case 16:
+		/* 5-6-5 RGB */
+		fix->visual = FB_VISUAL_TRUECOLOR;
+		var->bits_per_pixel = 16;
+		var->red.offset = 11;
+		var->red.length = 5;
+		var->green.offset = 5;
+		var->green.length = 6;
+		var->blue.offset = 0;
+		var->blue.length = 5;
 		break;
-
 	default:
-		return -EINVAL;
+		BUG();
 	}
 
-	return 0;
-}
+	if (fix->visual == FB_VISUAL_TRUECOLOR) {
+		info->pseudo_palette = &pseudo_palette;
+		fb_alloc_cmap(&(info->cmap), 16, 0);
+	} else
+		fb_alloc_cmap(&(info->cmap), 1<<bpp, 0);
 
-static struct display_switch e1355_dispsw;
+	panel = epson1355_read_reg(REG_PANEL_TYPE);
+	is_color = (panel & 0x04) != 0;
+	is_dual  = (panel & 0x02) != 0;
+	is_tft   = (panel & 0x01) != 0;
+	crt_enabled = (display & 0x02) != 0;
+	lcd_enabled = (display & 0x01) != 0;
+	lcd_bpp = epson1355_width_tab[is_tft][(panel>>4)&3];
 
-static void e1355_set_disp(const void *unused, struct display *disp,
-			   struct fb_info_gen *info)
-{
-	struct display_switch *d;
+	xres = (epson1355_read_reg(REG_HORZ_DISP_WIDTH) + 1) * 8;
+	yres = (epson1355_read_reg16(REG_VERT_DISP_HEIGHT0) + 1) *
+		((is_dual && !crt_enabled) ? 2 : 1);
+	offset = epson1355_read_reg16(REG_MEM_ADDR_OFFSET0) & 0x7ff;
+	xres_virtual = offset * 16 / bpp;
+	yres_virtual = fix->smem_len / (offset * 2);
+
+	var->xres = xres;
+	var->yres = yres;
+	var->xres_virtual = xres_virtual;
+	var->yres_virtual = yres_virtual;
+	var->xoffset = var->yoffset = 0;
 
-	disp->dispsw = &e1355_dispsw;
+	fix->line_length = offset * 2;
+
+	fix->xpanstep = 0;	/* no pan yet */
+	fix->ypanstep = 1;
+	fix->ywrapstep = 0;
+	fix->accel = FB_ACCEL_NONE;
+
+	var->grayscale = !is_color;
 	
-	switch(disp->var.bits_per_pixel) {
-#ifdef FBCON_HAS_MFB
-	case 1:
-		d = &fbcon_mfb; break;
-#endif	       
-#ifdef FBCON_HAS_CFB8
-	case 8:
-		d = &fbcon_cfb8; break;
+#ifdef DEBUG
+	printk(KERN_INFO
+	       "epson1355fb: xres=%d, yres=%d, "
+	       "is_color=%d, is_dual=%d, is_tft=%d\n",
+	       xres, yres, is_color, is_dual, is_tft);
+	printk(KERN_INFO
+	       "epson1355fb: bpp=%d, lcd_bpp=%d, "
+	       "crt_enabled=%d, lcd_enabled=%d\n",
+	       bpp, lcd_bpp, crt_enabled, lcd_enabled);
 #endif
-	default:
-		BUG(); break;
-	}
+}
 
-	memcpy(&e1355_dispsw, d, sizeof *d);
 
-	/* reading is terribly slow for us */
-#if 0 /* XXX: need to work out why this doesn't work */
-	e1355_dispsw.bmove = fbcon_redraw_bmove;
-#endif
+static void clearfb16(struct fb_info *info)
+{
+	u16 *dst = (u16 *) info->screen_base;
+	unsigned long n = info->fix.smem_len;
+
+	while (n > 1) {
+		fb_writew(0, dst);
+		dst++, n -= 2;
+	}
+
+	if (n)
+		fb_writeb(0, dst);
 }
 
-/* ------------ Interfaces to hardware functions ------------ */
+static void epson1355fb_deinit(void);
 
+int __init epson1355fb_init(void)
+{
+	u8 revision;
+	int rc = 0;
 
-struct fbgen_hwswitch e1355_switch = {
-	.detect =	e1355_detect,
-	.encode_fix =	e1355_encode_fix,
-	.decode_var =	e1355_decode_var,
-	.encode_var =	e1355_encode_var,
-	.get_par =	e1355_get_par,
-	.set_par =	e1355_set_par,
-	.getcolreg =	e1355_getcolreg,
-	.pan_display =	e1355_pan_display,
-	.blank =	e1355_blank,
-	.set_disp =	e1355_set_disp,
-};
+	if (!request_mem_region(EPSON1355FB_REGS_PHYS, EPSON1355FB_REGS_LEN,
+				"S1D13505 registers")) {
+		printk(KERN_ERR "epson1355fb: unable to reserve "
+		       "registers at 0x%0x\n", EPSON1355FB_REGS_PHYS);
+		rc = -EBUSY;
+		goto bail;
+	}
 
+	if (!request_mem_region(EPSON1355FB_FB_PHYS, EPSON1355FB_FB_LEN,
+				"S1D13505 framebuffer")) {
+		printk(KERN_ERR "epson1355fb: unable to reserve "
+		       "framebuffer at 0x%0x\n", EPSON1355FB_FB_PHYS);
+		rc = -EBUSY;
+		goto bail;
+	}
 
-/* ------------ Hardware Independent Functions ------------ */
+	par.reg_addr = (unsigned long) 
+		ioremap(EPSON1355FB_REGS_PHYS, EPSON1355FB_REGS_LEN);
+	if (!par.reg_addr) {
+		printk(KERN_ERR "epson1355fb: unable to map registers\n");
+		rc = -ENOMEM;
+		goto bail;
+	}
 
+	info.screen_base = ioremap(EPSON1355FB_FB_PHYS, EPSON1355FB_FB_LEN);
+	if (!info.screen_base) {
+		printk(KERN_ERR "epson1355fb: unable to map framebuffer\n");
+		rc = -ENOMEM;
+		goto bail;
+	}
 
-static struct fb_ops e1355fb_ops = {
-	.owner =	THIS_MODULE,
-	.fb_get_fix =	fbgen_get_fix,
-	.fb_get_var =	fbgen_get_var,
-	.fb_set_var =	fbgen_set_var,
-	.fb_get_cmap =	fbgen_get_cmap,
-	.fb_set_cmap =	gen_set_cmap,
-	.fb_setcolreg =	e1355fb_setcolreg,
-	.fb_pan_display =fbgen_pan_display,
-	.fb_blank =	fbgen_blank,
-};
+	revision = epson1355_read_reg(REG_REVISION_CODE);
+	if ((revision>>2) != 3) {
+		printk(KERN_INFO "epson1355fb: epson1355 not found\n");
+		rc = -ENODEV; 
+		goto bail; 
+	}
 
-static struct e1355fb_info fb_info;
+	info.fix.mmio_start = EPSON1355FB_REGS_PHYS;
+	info.fix.mmio_len = EPSON1355FB_REGS_LEN;
+	info.fix.smem_start = EPSON1355FB_FB_PHYS;
+	info.fix.smem_len = get_fb_size(&info);
+
+	printk(KERN_INFO 
+	       "epson1355fb: regs mapped at 0x%lx, fb %d KiB mapped at 0x%p\n",
+	       par.reg_addr, info.fix.smem_len / 1024, info.screen_base);
+
+	strcpy(info.fix.id, "S1D13505");
+	info.par = &par;
+	info.node = NODEV;
+	info.fbops = &epson1355fb_fbops;
+	info.flags = FBINFO_FLAG_DEFAULT;
+
+	/* we expect the boot loader to have initialized the chip
+	   with appropriate parameters from which we can determinte
+	   the flavor of lcd panel attached */
+	fetch_hw_state(&info);
+
+	/* turn this puppy on ... */
+	clearfb16(&info);
+	backlight_enable(1);
+	lcd_enable(1);
+
+	if (register_framebuffer(&info) < 0) {
+		rc = -EINVAL; 
+		goto bail; 
+	}
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", 
+	       minor(info.node), info.fix.id);
 
-int __init e1355fb_setup(char *str)
-{
 	return 0;
+
+ bail:
+	epson1355fb_deinit();
+	return rc;
 }
 
-int __init e1355fb_init(void)
+static void epson1355fb_deinit(void)
 {
-	fb_info.gen.fbhw = &e1355_switch;
-	fb_info.gen.fbhw->detect();
-	strcpy(fb_info.gen.info.modename, "SED1355");
-	fb_info.gen.info.changevar = NULL;
-	fb_info.gen.info.node = NODEV;
-	fb_info.gen.info.fbops = &e1355fb_ops;
-	fb_info.gen.info.screen_base = (void *)E1355_FB_BASE;
-	fb_info.gen.currcon = -1;
-	fb_info.gen.info.disp = &disp;
-	fb_info.gen.parsize = sizeof(struct e1355_par);
-	fb_info.gen.info.switch_con = &fbgen_switch;
-	fb_info.gen.info.updatevar = &fbgen_update_var;
-	fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
-	/* This should give a reasonable default video mode */
-	fbgen_get_var(&disp.var, -1, &fb_info.gen.info);
-	fbgen_do_set_var(&disp.var, 1, &fb_info.gen);
-	fbgen_set_disp(-1, &fb_info.gen);
-	if (disp.var.bits_per_pixel > 1) 
-		do_install_cmap(0, &fb_info.gen);
-	if (register_framebuffer(&fb_info.gen.info) < 0)
-		return -EINVAL;
-	printk(KERN_INFO "fb%d: %s frame buffer device\n", minor(fb_info.gen.info.node),
-	       fb_info.gen.info.modename);
+	fb_dealloc_cmap(&info.cmap);
 
-	return 0;
+	if (info.screen_base) iounmap(info.screen_base);
+	if (par.reg_addr) iounmap((void *) par.reg_addr);
+
+	release_mem_region(EPSON1355FB_FB_PHYS, EPSON1355FB_FB_LEN);
+	release_mem_region(EPSON1355FB_REGS_PHYS, EPSON1355FB_REGS_LEN);
 }
 
+static void __exit epson1355fb_cleanup(void)
+{
+	backlight_enable(0);
+	lcd_enable(0);
 
-    /*
-     *  Cleanup
-     */
-
-void e1355fb_cleanup(struct fb_info *info)
-{
-	/*
-	 *  If your driver supports multiple boards, you should unregister and
-	 *  clean up all instances.
-	 */
-	
-	unregister_framebuffer(info);
-	/* ... */
+	unregister_framebuffer(&info);
+	epson1355fb_deinit();
 }
 
+/* ------------------------------------------------------------------------- */
+
+#ifdef MODULE
+module_init(epson1355fb_init);
+#endif
+module_exit(epson1355fb_cleanup);
+
+MODULE_AUTHOR("Christopher Hoover <ch@hpl.hp.com>");
+MODULE_DESCRIPTION("Framebuffer driver for Epson S1D13505");
 MODULE_LICENSE("GPL");
diff -X dontdiff.txt -Naurp linux-2.5.68-rmk1/drivers/video/fbmem.c linux-2.5.68-rmk1-ceiva1/drivers/video/fbmem.c
--- linux-2.5.68-rmk1/drivers/video/fbmem.c	2003-05-06 11:53:47.000000000 -0700
+++ linux-2.5.68-rmk1-ceiva1/drivers/video/fbmem.c	2003-05-13 18:12:12.000000000 -0700
@@ -134,8 +134,7 @@ extern int tx3912fb_init(void);
 extern int tx3912fb_setup(char*);
 extern int radeonfb_init(void);
 extern int radeonfb_setup(char*);
-extern int e1355fb_init(void);
-extern int e1355fb_setup(char*);
+extern int epson1355fb_init(void);
 extern int pvr2fb_init(void);
 extern int pvr2fb_setup(char*);
 extern int sstfb_init(void);
@@ -341,8 +340,8 @@ static struct {
 #ifdef CONFIG_FB_TX3912
 	{ "tx3912fb", tx3912fb_init, tx3912fb_setup },
 #endif
-#ifdef CONFIG_FB_E1355
-	{ "e1355fb", e1355fb_init, e1355fb_setup },
+#ifdef CONFIG_FB_EPSON1355
+	{ "S1D13505", epson1355fb_init, NULL },
 #endif
 #ifdef CONFIG_FB_PVR2
 	{ "pvr2fb", pvr2fb_init, pvr2fb_setup },





-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
