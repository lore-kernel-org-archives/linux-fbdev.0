From: Jurriaan <thunder7@xs4all.nl>
Subject: Re: vm86 patch updated to 2.5.67 / oops in blank_screen()?
Date: Mon, 14 Apr 2003 19:41:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030414174135.GA2611@middle.of.nowhere>
References: <200304130814.h3D8E8H00330@web3.po.com>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtpzilla5.xs4all.nl ([194.109.127.141])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1957y6-0005xf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Apr 2003 10:42:10 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtpzilla5.xs4all.nl (8.12.9/8.12.9) with ESMTP id h3EHg1FQ028440
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Apr 2003 19:42:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200304130814.h3D8E8H00330@web3.po.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Antonino Daplas <adaplas@pol.net>
Date: Sun, Apr 13, 2003 at 04:14:08AM -0400
> I believe I've seen that "oops" tracing before.  It is due to console 
> blanking routines calling a lot of functions (fb_blank, fb_setcolreg, 
> etc), all of which are done when "sleeping" is not allowed.  
> However, /dev/vm86 will always sleep, and this causes the oops.
> 
> Calling fb_blank via an ioctl is pretty safe though (ie, when xfree86 
> uses fb_blank ioctls for XFree86 DPMS).
> 
> I worked around this by doing deferred execution of fb_blank (also 
> using a workqueue), and differentiating if fb_blank() was called from 
> fbcon_blank() or from fb_ioctl().  I think I've also included these 
> fixes in vm86d-0.1.tar.gz (md5sum 10fa0ad4647ea6a8a002998196ce6cd9)

I don't think it's in that patch.

> 
> Anyway, as a quick workaround, you can make vbe_blank() in vbe.c 
> return 0 always.  This will not blank the screen, but it will at 
> least prevent the oops.
> 
Anyway, here is your patch, split in a vm86-patch and an edid-patch, and
all other changes removed. In this form, there patches apply against
2.5.67, against 2.5.67-ac1 and against 2.5.67-bk5.

They also work (tested with 2.5.67).

Kind regards,
Jurriaan

-- 
However, the things that surprise Emacs users are very different from
the things that surprise users of lesser operating systems.
	Per Abrahamsen in news.software.readers
Debian (Unstable) GNU/Linux 2.5.67 3940 bogomips 5 users load av: 0.15 0.14 0.07

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="edid.diff"

diff -urN -X dontdiff linux-2.5.67/drivers/video/Makefile linux-2.5.67-vm86/drivers/video/Makefile
--- linux-2.5.67/drivers/video/Makefile	2003-04-08 07:18:20.000000000 +0200
+++ linux-2.5.67-vm86/drivers/video/Makefile	2003-04-12 08:27:28.000000000 +0200
@@ -7,7 +7,7 @@
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
 
-obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o modedb.o softcursor.o
+obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o modedb.o vbe.o softcursor.o
 # Only include macmodes.o if we have FB support and are PPC
 ifeq ($(CONFIG_FB),y)
 obj-$(CONFIG_PPC)                 += macmodes.o
diff -urN -X dontdiff linux-2.5.67/drivers/video/edid.h linux-2.5.67-vm86/drivers/video/edid.h
--- linux-2.5.67/drivers/video/edid.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-vm86/drivers/video/edid.h	2003-04-12 08:27:28.000000000 +0200
@@ -0,0 +1,138 @@
+/* 
+ * drivers/video/edid.h - EDID/DDC Header
+ *
+ * Based on:
+ *   1. XFree86 4.3.0, edid.h
+ *      Copyright 1998 by Egbert Eich <Egbert.Eich@Physik.TU-Darmstadt.DE>
+ * 
+ *   2. John Fremlin <vii@users.sourceforge.net> and 
+ *      Ani Joshi <ajoshi@unixbox.com>
+ *
+ * DDC is a Trademark of VESA (Video Electronics Standard Association).
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+*/
+
+#ifndef __EDID_H__
+#define __EDID_H__
+
+#define EDID_LENGTH				0x80
+#define EDID_HEADER				0x00
+#define EDID_HEADER_END				0x07
+
+#define ID_MANUFACTURER_NAME			0x08
+#define ID_MANUFACTURER_NAME_END		0x09
+#define ID_MODEL				0x0a
+
+#define ID_SERIAL_NUMBER			0x0c
+
+#define MANUFACTURE_WEEK			0x10
+#define MANUFACTURE_YEAR			0x11
+
+#define EDID_STRUCT_VERSION			0x12
+#define EDID_STRUCT_REVISION			0x13
+
+#define EDID_STRUCT_DISPLAY                     0x14
+
+#define DPMS_FLAGS				0x18
+#define ESTABLISHED_TIMING_1			0x23
+#define ESTABLISHED_TIMING_2			0x24
+#define MANUFACTURERS_TIMINGS			0x25
+
+/* standard timings supported */
+#define STD_TIMING                              8
+#define STD_TIMING_DESCRIPTION_SIZE             2
+#define STD_TIMING_DESCRIPTIONS_START           0x26
+
+#define DETAILED_TIMING_DESCRIPTIONS_START	0x36
+#define DETAILED_TIMING_DESCRIPTION_SIZE	18
+#define NO_DETAILED_TIMING_DESCRIPTIONS		4
+
+#define DETAILED_TIMING_DESCRIPTION_1		0x36
+#define DETAILED_TIMING_DESCRIPTION_2		0x48
+#define DETAILED_TIMING_DESCRIPTION_3		0x5a
+#define DETAILED_TIMING_DESCRIPTION_4		0x6c
+
+#define DESCRIPTOR_DATA				5
+
+#define UPPER_NIBBLE( x ) \
+        (((128|64|32|16) & (x)) >> 4)
+
+#define LOWER_NIBBLE( x ) \
+        ((1|2|4|8) & (x))
+
+#define COMBINE_HI_8LO( hi, lo ) \
+        ( (((unsigned)hi) << 8) | (unsigned)lo )
+
+#define COMBINE_HI_4LO( hi, lo ) \
+        ( (((unsigned)hi) << 4) | (unsigned)lo )
+
+#define PIXEL_CLOCK_LO     (unsigned)block[ 0 ]
+#define PIXEL_CLOCK_HI     (unsigned)block[ 1 ]
+#define PIXEL_CLOCK	   (COMBINE_HI_8LO( PIXEL_CLOCK_HI,PIXEL_CLOCK_LO )*10000)
+#define H_ACTIVE_LO        (unsigned)block[ 2 ]
+#define H_BLANKING_LO      (unsigned)block[ 3 ]
+#define H_ACTIVE_HI        UPPER_NIBBLE( (unsigned)block[ 4 ] )
+#define H_ACTIVE           COMBINE_HI_8LO( H_ACTIVE_HI, H_ACTIVE_LO )
+#define H_BLANKING_HI      LOWER_NIBBLE( (unsigned)block[ 4 ] )
+#define H_BLANKING         COMBINE_HI_8LO( H_BLANKING_HI, H_BLANKING_LO )
+
+#define V_ACTIVE_LO        (unsigned)block[ 5 ]
+#define V_BLANKING_LO      (unsigned)block[ 6 ]
+#define V_ACTIVE_HI        UPPER_NIBBLE( (unsigned)block[ 7 ] )
+#define V_ACTIVE           COMBINE_HI_8LO( V_ACTIVE_HI, V_ACTIVE_LO )
+#define V_BLANKING_HI      LOWER_NIBBLE( (unsigned)block[ 7 ] )
+#define V_BLANKING         COMBINE_HI_8LO( V_BLANKING_HI, V_BLANKING_LO )
+
+#define H_SYNC_OFFSET_LO   (unsigned)block[ 8 ]
+#define H_SYNC_WIDTH_LO    (unsigned)block[ 9 ]
+
+#define V_SYNC_OFFSET_LO   UPPER_NIBBLE( (unsigned)block[ 10 ] )
+#define V_SYNC_WIDTH_LO    LOWER_NIBBLE( (unsigned)block[ 10 ] )
+
+#define V_SYNC_WIDTH_HI    ((unsigned)block[ 11 ] & (1|2))
+#define V_SYNC_OFFSET_HI   (((unsigned)block[ 11 ] & (4|8)) >> 2)
+
+#define H_SYNC_WIDTH_HI    (((unsigned)block[ 11 ] & (16|32)) >> 4)
+#define H_SYNC_OFFSET_HI   (((unsigned)block[ 11 ] & (64|128)) >> 6)
+
+#define V_SYNC_WIDTH       COMBINE_HI_4LO( V_SYNC_WIDTH_HI, V_SYNC_WIDTH_LO )
+#define V_SYNC_OFFSET      COMBINE_HI_4LO( V_SYNC_OFFSET_HI, V_SYNC_OFFSET_LO )
+
+#define H_SYNC_WIDTH       COMBINE_HI_4LO( H_SYNC_WIDTH_HI, H_SYNC_WIDTH_LO )
+#define H_SYNC_OFFSET      COMBINE_HI_4LO( H_SYNC_OFFSET_HI, H_SYNC_OFFSET_LO )
+
+#define H_SIZE_LO          (unsigned)block[ 12 ]
+#define V_SIZE_LO          (unsigned)block[ 13 ]
+
+#define H_SIZE_HI          UPPER_NIBBLE( (unsigned)block[ 14 ] )
+#define V_SIZE_HI          LOWER_NIBBLE( (unsigned)block[ 14 ] )
+
+#define H_SIZE             COMBINE_HI_8LO( H_SIZE_HI, H_SIZE_LO )
+#define V_SIZE             COMBINE_HI_8LO( V_SIZE_HI, V_SIZE_LO )
+
+#define H_BORDER           (unsigned)block[ 15 ]
+#define V_BORDER           (unsigned)block[ 16 ]
+
+#define FLAGS              (unsigned)block[ 17 ]
+
+#define INTERLACED         (FLAGS&128)
+#define SYNC_TYPE          (FLAGS&3<<3)	/* bits 4,3 */
+#define SYNC_SEPARATE      (3<<3)
+#define HSYNC_POSITIVE     (FLAGS & 4)
+#define VSYNC_POSITIVE     (FLAGS & 2)
+
+#define V_MIN_RATE              block[ 5 ]
+#define V_MAX_RATE              block[ 6 ]
+#define H_MIN_RATE              block[ 7 ]
+#define H_MAX_RATE              block[ 8 ]
+#define MAX_PIXEL_CLOCK         (((int)block[ 9 ]) * 10)
+#define GTF_SUPPORT		block[10]
+
+#define DPMS_ACTIVE_OFF		(1 << 5)
+#define DPMS_SUSPEND		(1 << 6)
+#define DPMS_STANDBY		(1 << 7)
+
+#endif /* __EDID_H__ */
diff -urN -X dontdiff linux-2.5.67/drivers/video/fbmon.c linux-2.5.67-vm86/drivers/video/fbmon.c
--- linux-2.5.67/drivers/video/fbmon.c	2003-04-07 19:55:38.000000000 +0200
+++ linux-2.5.67-vm86/drivers/video/fbmon.c	2003-04-13 11:09:39.000000000 +0200
@@ -1,7 +1,25 @@
 /*
- *   linux/drivers/video/fbmon.c
+ * linux/drivers/video/fbmon.c
  *
- *  Copyright (C) 2002 James Simmons <jsimmons@users.sf.net>
+ * Copyright (C) 2002 James Simmons <jsimmons@users.sf.net>
+ *
+ * Credits:
+ * 
+ * The EDID Parser is a conglomeration from the following sources:
+ *
+ *   1. SciTech SNAP Graphics Architecture
+ *      Copyright (C) 1991-2002 SciTech Software, Inc. All rights reserved.
+ *
+ *   2. XFree86 4.3.0, interpret_edid.c
+ *      Copyright 1998 by Egbert Eich <Egbert.Eich@Physik.TU-Darmstadt.DE>
+ * 
+ *   3. John Fremlin <vii@users.sourceforge.net> and 
+ *      Ani Joshi <ajoshi@unixbox.com>
+ *  
+ * Generalized Timing Formula is derived from:
+ *
+ *      GTF Spreadsheet by Andy Morrish (1/5/97) 
+ *      available at http://www.vesa.org
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file COPYING in the main directory of this archive
@@ -11,124 +29,33 @@
 #include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/module.h>
-#ifdef CONFIG_PCI
-#include <linux/pci.h>
-#endif
 #ifdef CONFIG_ALL_PPC
 #include <asm/prom.h>
 #endif
+#include "edid.h"
+
+static int vbe_debug = 0;
+#define dprintk(x...) do { if (vbe_debug) printk(x); } while(0)
 
 /* 
  * EDID parser
- *
- * portions of this file were based on the EDID parser by
- * John Fremlin <vii@users.sourceforge.net> and Ani Joshi <ajoshi@unixbox.com>
  */
 
-#define EDID_LENGTH				0x80
-#define EDID_HEADER				0x00
-#define EDID_HEADER_END				0x07
-
-#define ID_MANUFACTURER_NAME			0x08
-#define ID_MANUFACTURER_NAME_END		0x09
-#define ID_MODEL				0x0a
-
-#define ID_SERIAL_NUMBER			0x0c
-
-#define MANUFACTURE_WEEK			0x10
-#define MANUFACTURE_YEAR			0x11
-
-#define EDID_STRUCT_VERSION			0x12
-#define EDID_STRUCT_REVISION			0x13
-
-#define DPMS_FLAGS				0x18
-#define ESTABLISHED_TIMING_1			0x23
-#define ESTABLISHED_TIMING_2			0x24
-#define MANUFACTURERS_TIMINGS			0x25
-
-#define DETAILED_TIMING_DESCRIPTIONS_START	0x36
-#define DETAILED_TIMING_DESCRIPTION_SIZE	18
-#define NO_DETAILED_TIMING_DESCRIPTIONS		4
-
-#define DETAILED_TIMING_DESCRIPTION_1		0x36
-#define DETAILED_TIMING_DESCRIPTION_2		0x48
-#define DETAILED_TIMING_DESCRIPTION_3		0x5a
-#define DETAILED_TIMING_DESCRIPTION_4		0x6c
-
-#define DESCRIPTOR_DATA				5
-
-#define UPPER_NIBBLE( x ) \
-        (((128|64|32|16) & (x)) >> 4)
-
-#define LOWER_NIBBLE( x ) \
-        ((1|2|4|8) & (x))
-
-#define COMBINE_HI_8LO( hi, lo ) \
-        ( (((unsigned)hi) << 8) | (unsigned)lo )
-
-#define COMBINE_HI_4LO( hi, lo ) \
-        ( (((unsigned)hi) << 4) | (unsigned)lo )
-
-#define PIXEL_CLOCK_LO     (unsigned)block[ 0 ]
-#define PIXEL_CLOCK_HI     (unsigned)block[ 1 ]
-#define PIXEL_CLOCK	   (COMBINE_HI_8LO( PIXEL_CLOCK_HI,PIXEL_CLOCK_LO )*1000)
-#define H_ACTIVE_LO        (unsigned)block[ 2 ]
-#define H_BLANKING_LO      (unsigned)block[ 3 ]
-#define H_ACTIVE_HI        UPPER_NIBBLE( (unsigned)block[ 4 ] )
-#define H_ACTIVE           COMBINE_HI_8LO( H_ACTIVE_HI, H_ACTIVE_LO )
-#define H_BLANKING_HI      LOWER_NIBBLE( (unsigned)block[ 4 ] )
-#define H_BLANKING         COMBINE_HI_8LO( H_BLANKING_HI, H_BLANKING_LO )
-
-#define V_ACTIVE_LO        (unsigned)block[ 5 ]
-#define V_BLANKING_LO      (unsigned)block[ 6 ]
-#define V_ACTIVE_HI        UPPER_NIBBLE( (unsigned)block[ 7 ] )
-#define V_ACTIVE           COMBINE_HI_8LO( V_ACTIVE_HI, V_ACTIVE_LO )
-#define V_BLANKING_HI      LOWER_NIBBLE( (unsigned)block[ 7 ] )
-#define V_BLANKING         COMBINE_HI_8LO( V_BLANKING_HI, V_BLANKING_LO )
-
-#define H_SYNC_OFFSET_LO   (unsigned)block[ 8 ]
-#define H_SYNC_WIDTH_LO    (unsigned)block[ 9 ]
-
-#define V_SYNC_OFFSET_LO   UPPER_NIBBLE( (unsigned)block[ 10 ] )
-#define V_SYNC_WIDTH_LO    LOWER_NIBBLE( (unsigned)block[ 10 ] )
-
-#define V_SYNC_WIDTH_HI    ((unsigned)block[ 11 ] & (1|2))
-#define V_SYNC_OFFSET_HI   (((unsigned)block[ 11 ] & (4|8)) >> 2)
-
-#define H_SYNC_WIDTH_HI    (((unsigned)block[ 11 ] & (16|32)) >> 4)
-#define H_SYNC_OFFSET_HI   (((unsigned)block[ 11 ] & (64|128)) >> 6)
-
-#define V_SYNC_WIDTH       COMBINE_HI_4LO( V_SYNC_WIDTH_HI, V_SYNC_WIDTH_LO )
-#define V_SYNC_OFFSET      COMBINE_HI_4LO( V_SYNC_OFFSET_HI, V_SYNC_OFFSET_LO )
-
-#define H_SYNC_WIDTH       COMBINE_HI_4LO( H_SYNC_WIDTH_HI, H_SYNC_WIDTH_LO )
-#define H_SYNC_OFFSET      COMBINE_HI_4LO( H_SYNC_OFFSET_HI, H_SYNC_OFFSET_LO )
-
-#define H_SIZE_LO          (unsigned)block[ 12 ]
-#define V_SIZE_LO          (unsigned)block[ 13 ]
-
-#define H_SIZE_HI          UPPER_NIBBLE( (unsigned)block[ 14 ] )
-#define V_SIZE_HI          LOWER_NIBBLE( (unsigned)block[ 14 ] )
-
-#define H_SIZE             COMBINE_HI_8LO( H_SIZE_HI, H_SIZE_LO )
-#define V_SIZE             COMBINE_HI_8LO( V_SIZE_HI, V_SIZE_LO )
-
-#define H_BORDER           (unsigned)block[ 15 ]
-#define V_BORDER           (unsigned)block[ 16 ]
-
-#define FLAGS              (unsigned)block[ 17 ]
-
-#define INTERLACED         (FLAGS&128)
-#define SYNC_TYPE          (FLAGS&3<<3)	/* bits 4,3 */
-#define SYNC_SEPARATE      (3<<3)
-#define HSYNC_POSITIVE     (FLAGS & 4)
-#define VSYNC_POSITIVE     (FLAGS & 2)
-
 const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
 	0xff, 0xff, 0xff, 0x00
 };
 const unsigned char edid_v1_descriptor_flag[] = { 0x00, 0x00 };
 
+static void copy_string(unsigned char *c, unsigned char *s)
+{
+  int i;
+  c = c + 5;
+  for (i = 0; (i < 13 && *c != 0x0A); i++)
+    *(s++) = *(c++);
+  *s = 0;
+  while (i-- && (*--s == 0x20)) *s = 0;
+}
+
 static int edid_checksum(unsigned char *edid)
 {
 	unsigned char i, csum = 0;
@@ -157,122 +84,765 @@
 	return 1;
 }
 
-
-static char *edid_get_vendor(unsigned char *block)
+static void parse_vendor_block(unsigned char *block)
 {
-	static char sign[4];
-	unsigned short h;
+	unsigned char c[4];
+
+	c[0] = ((block[0] & 0x7c) >> 2) + '@';
+	c[1] = ((block[0] & 0x03) << 3) + ((block[1] & 0xe0) >> 5) + '@';
+	c[2] = (block[1] & 0x1f) + '@';
+	c[3] = 0;
+	printk("   Manufacturer: %s ", c);
+	printk("Model: %x ", block[2] + (block[3] << 8));
+	printk("Serial#: %u\n", block[4] + (block[5] << 8) + 
+	       (block[6] << 16) + (block[7] << 24));
+	printk("   Year: %u Week %u\n", block[9] + 1990, block[8]);
+}
 
-	h = COMBINE_HI_8LO(block[0], block[1]);
-	sign[0] = ((h >> 10) & 0x1f) + 'A' - 1;
-	sign[1] = ((h >> 5) & 0x1f) + 'A' - 1;
-	sign[2] = (h & 0x1f) + 'A' - 1;
-	sign[3] = 0;
+static void parse_dpms_capabilities(unsigned char flags)
+{
+	printk("      DPMS: Active %s, Suspend %s, Standby %s\n",
+	       (flags & DPMS_ACTIVE_OFF) ? "yes" : "no",
+	       (flags & DPMS_SUSPEND)    ? "yes" : "no",
+	       (flags & DPMS_STANDBY)    ? "yes" : "no");
+}
+	
+static void print_chroma(unsigned char *block)
+{
+	int tmp;
 
-	return sign;
+	/* Chromaticity data */
+	printk("      Chromaticity: ");
+	tmp = ((block[5] & (3 << 6)) >> 6) | (block[0x7] << 2);
+	tmp *= 1000;
+	tmp += 512;
+	printk("RedX:   0.%03d ", tmp/1024);
+
+	tmp = ((block[5] & (3 << 4)) >> 4) | (block[0x8] << 2);
+	tmp *= 1000;
+	tmp += 512;
+	printk("RedY:   0.%03d\n", tmp/1024);
+
+	tmp = ((block[5] & (3 << 2)) >> 2) | (block[0x9] << 2);
+	tmp *= 1000;
+	tmp += 512;
+	printk("                    GreenX: 0.%03d ", tmp/1024);
+
+	tmp = (block[5] & 3) | (block[0xa] << 2);
+	tmp *= 1000;
+	tmp += 512;
+	printk("GreenY: 0.%03d\n", tmp/1024);
+
+	tmp = ((block[6] & (3 << 6)) >> 6) | (block[0xb] << 2);
+	tmp *= 1000;
+	tmp += 512;
+	printk("                    BlueX:  0.%03d ", tmp/1024);
+
+	tmp = ((block[6] & (3 << 4)) >> 4) | (block[0xc] << 2);
+	tmp *= 1000;
+	tmp += 512;
+	printk("BlueY:  0.%03d\n", tmp/1024);
+	
+	tmp = ((block[6] & (3 << 2)) >> 2) | (block[0xd] << 2);
+	tmp *= 1000;
+	tmp += 512;
+	printk("                    WhiteX: 0.%03d ", tmp/1024);
+
+	tmp = (block[6] & 3) | (block[0xe] << 2);
+	tmp *= 1000;
+	tmp += 512;
+	printk("WhiteY: 0.%03d\n", tmp/1024);
 }
 
-static char *edid_get_monitor(unsigned char *block)
+static void parse_display_block(unsigned char *block)
 {
-	static char name[13];
-	unsigned i;
-	const unsigned char *ptr = block + DESCRIPTOR_DATA;
+	unsigned char c;
 
-	for (i = 0; i < 13; i++, ptr++) {
-		if (*ptr == 0xa) {
-			name[i] = 0x00;
-			return name;
+	c = (block[0] & 0x80) >> 7;
+	if (c) 
+		printk("      Digital Display Input");
+	else {
+		printk("      Analog Display Input: Input Voltage - ");
+		switch ((block[0] & 0x60) >> 5) {
+		case 0:
+			printk("0.700V/0.300V");
+			break;
+		case 1:
+			printk("0.714V/0.286V");
+			break;
+		case 2:
+			printk("1.000V/0.400V");
+			break;
+		case 3:
+			printk("0.700V/0.000V");
+			break;
+		default:
+			printk("unknown");
 		}
-		name[i] = *ptr;
+		printk("\n");
 	}
-	return name;
+	c = (block[0] & 0x10) >> 4;
+	if (c)
+		printk("      Configurable signal level\n");
+	printk("      Sync: ");
+	c = block[0] & 0x0f;
+	if (c & 0x10)
+		printk("Blank to Blank ");
+	if (c & 0x08)
+		printk("Separate ");
+	if (c & 0x04)
+		printk("Composite ");
+	if (c & 0x02)
+		printk("Sync on Green ");
+	if (c & 0x01)
+		printk("Serration on ");
+	printk("\n");
+
+	printk("      Max H-size in cm: ");
+	c = block[1];
+	if (c) 
+		printk("%d\n", c);
+	else
+		printk("variable\n");
+	
+	printk("      Max V-size in cm: ");
+	c = block[2];
+	if (c)
+		printk("%d\n", c);
+	else
+		printk("variable\n");
+
+	c = block[3];
+	printk("      Gamma: ");
+	printk("%d.%d\n", (c + 100)/100, (c+100) % 100);
+
+	parse_dpms_capabilities(block[4]);
+
+	switch ((block[4] & 0x18) >> 3) {
+	case 0:
+		printk("      Monochrome/Grayscale\n");
+		break;
+	case 1:
+		printk("      RGB Color Display\n");
+		break;
+	case 2:
+		printk("      Non-RGB Multicolor Display\n");
+		break;
+	default:
+		printk("      Unknown\n");
+		break;
+	}
+
+	print_chroma(block);
+	
+	c = block[4] & 0x7;
+	if (c & 0x04)
+		printk("      Default color format is primary\n");
+	if (c & 0x02)
+		printk("      First DETAILED Timing is preferred\n");
+	if (c & 0x01)
+		printk("      Display is GTF capable\n");
 }
 
+static void parse_std_md_block(unsigned char *block)
+{
+	unsigned char c;
+
+	c = block[0];
+	if (c&0x80) printk("      720x400@70Hz\n");
+	if (c&0x40) printk("      720x400@88Hz\n");
+	if (c&0x20) printk("      640x480@60Hz\n");
+	if (c&0x10) printk("      640x480@67Hz\n");
+	if (c&0x08) printk("      640x480@72Hz\n");
+	if (c&0x04) printk("      640x480@75Hz\n");
+	if (c&0x02) printk("      800x600@56Hz\n");
+	if (c&0x01) printk("      800x600@60Hz\n");
+
+	c = block[1];
+	if (c&0x80) printk("      800x600@72Hz\n");
+	if (c&0x40) printk("      800x600@75Hz\n");
+	if (c&0x20) printk("      832x624@75Hz\n");
+	if (c&0x10) printk("      1024x768@87Hz (interlaced)\n");
+	if (c&0x08) printk("      1024x768@60Hz\n");
+	if (c&0x04) printk("      1024x768@70Hz\n");
+	if (c&0x02) printk("      1024x768@75Hz\n");
+	if (c&0x01) printk("      1280x1024@75Hz\n");
+
+	c = block[2];
+	if (c&0x80) printk("      1152x870@75Hz\n");
+	printk("      Manufacturer's mask: %x\n",c&0x7F);
+}
+		
+		
 static int edid_is_timing_block(unsigned char *block)
 {
-	if ((block[0] == 0x00) && (block[1] == 0x00))
+	if ((block[0] != 0x00) || (block[1] != 0x00) || 
+	    (block[2] != 0x00) || (block[4] != 0x00)) 
+		return 1;
+	else
 		return 0;
+}
+
+static int edid_is_serial_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) && 
+	    (block[2] == 0x00) && (block[3] == 0xff) &&
+	    (block[4] == 0x00))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_ascii_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) && 
+	    (block[2] == 0x00) && (block[3] == 0xfe) &&
+	    (block[4] == 0x00))
+		return 1;
 	else
+		return 0;
+}
+
+static int edid_is_limits_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) && 
+	    (block[2] == 0x00) && (block[3] == 0xfd) &&
+	    (block[4] == 0x00))
 		return 1;
+	else
+		return 0;
 }
 
 static int edid_is_monitor_block(unsigned char *block)
 {
-	if ((block[0] == 0x00) && (block[1] == 0x00) && (block[3] == 0xfc))
+	if ((block[0] == 0x00) && (block[1] == 0x00) && 
+	    (block[2] == 0x00) && (block[3] == 0xfc) &&
+	    (block[4] == 0x00))
 		return 1;
 	else
 		return 0;
 }
 
-static void parse_timing_block(unsigned char *block,
-			       struct fb_var_screeninfo *var)
+static int edid_is_color_block(unsigned char *block)
 {
-	var->xres = var->xres_virtual = H_ACTIVE;
-	var->yres = var->yres_virtual = V_ACTIVE;
-	var->height = var->width = -1;
-	var->right_margin = H_SYNC_OFFSET;
-	var->left_margin = (H_ACTIVE + H_BLANKING) -
-	    (H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
-	var->upper_margin = V_BLANKING - V_SYNC_OFFSET - V_SYNC_WIDTH;
-	var->lower_margin = V_SYNC_OFFSET;
-	var->hsync_len = H_SYNC_WIDTH;
-	var->vsync_len = V_SYNC_WIDTH;
-	var->pixclock = PIXEL_CLOCK;
-	var->pixclock /= 1000;
-	var->pixclock = KHZ2PICOS(var->pixclock);
+	if ((block[0] == 0x00) && (block[1] == 0x00) && 
+	    (block[2] == 0x00) && (block[3] == 0xfb) &&
+	    (block[4] == 0x00))
+		return 1;
+	else
+		return 0;
+}
 
-	if (HSYNC_POSITIVE)
-		var->sync |= FB_SYNC_HOR_HIGH_ACT;
-	if (VSYNC_POSITIVE)
-		var->sync |= FB_SYNC_VERT_HIGH_ACT;
+static int edid_is_std_timings_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) && 
+	    (block[2] == 0x00) && (block[3] == 0xfa) &&
+	    (block[4] == 0x00))
+		return 1;
+	else
+		return 0;
+}
+
+static void parse_serial_block(unsigned char *block)
+{
+	unsigned char c[13];
+	
+	copy_string(block, c);
+	printk("      Serial No     : %s\n", c);
+}
+
+static void parse_ascii_block(unsigned char *block)
+{
+	unsigned char c[13];
+	
+	copy_string(block, c);
+	printk("      %s\n", c);
+}
+
+static void parse_limits_block(unsigned char *block)
+{
+	printk("      HorizSync     : %d-%d KHz\n", H_MIN_RATE, H_MAX_RATE);
+	printk("      VertRefresh   : %d-%d Hz\n", V_MIN_RATE, V_MAX_RATE);
+	if (MAX_PIXEL_CLOCK != 10*0xff)
+		printk("      Max Pixelclock: %d MHz\n", (int) MAX_PIXEL_CLOCK);
+}
+
+static void parse_monitor_block(unsigned char *block)
+{
+	unsigned char c[13];
+	
+	copy_string(block, c);
+	printk("      Monitor Name  : %s\n", c);
+}
+
+static void parse_color_block(unsigned char *block)
+{
+	printk("      Color Point    : unimplemented\n");
+}
+
+static void parse_std_timing_block(unsigned char *block)
+{
+	int xres, yres = 0, refresh, ratio, err = 1;
+	
+	xres = (block[0] + 31) * 8;
+	if (xres <= 256)
+		return;
+
+	ratio = (block[1] & 0xc0) >> 6;
+	switch (ratio) {
+	case 0:
+		yres = xres;
+		break;
+	case 1:
+		yres = (xres * 3)/4;
+		break;
+	case 2:
+		yres = (xres * 4)/5;
+		break;
+	case 3:
+		yres = (xres * 9)/16;
+		break;
+	}
+	refresh = (block[1] & 0x3f) + 60;
+	printk("      %dx%d@%dHz\n", xres, yres, refresh);
+	err = 0;
+}
+
+static void parse_dst_timing_block(unsigned char *block)
+{
+	int i;
+
+	block += 5;
+	for (i = 0; i < 5; i++, block += STD_TIMING_DESCRIPTION_SIZE)
+		parse_std_timing_block(block);
+}
+
+static void parse_detailed_timing_block(unsigned char *block)
+{
+	printk("      %d MHz ",  PIXEL_CLOCK/1000000);
+	printk("%d %d %d %d ", H_ACTIVE, H_ACTIVE + H_SYNC_OFFSET, 
+	       H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH, H_ACTIVE + H_BLANKING);
+	printk("%d %d %d %d ", V_ACTIVE, V_ACTIVE + V_SYNC_OFFSET, 
+	       V_ACTIVE + V_SYNC_OFFSET + V_SYNC_WIDTH, V_ACTIVE + V_BLANKING);
+	printk("%sHSync %sVSync\n\n", (HSYNC_POSITIVE) ? "+" : "-", 
+	       (VSYNC_POSITIVE) ? "+" : "-");
 }
 
 int parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 {
-	unsigned char *block, *vendor, *monitor = NULL;
 	int i;
+	unsigned char *block;
+
+	if (edid == NULL || var == NULL)
+		return 1;
 
 	if (!(edid_checksum(edid)))
-		return 0;
+		return 1;
 
 	if (!(edid_check_header(edid)))
+		return 1;
+
+	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+
+	for (i = 0; i < 4; i++, block += DETAILED_TIMING_DESCRIPTION_SIZE) {
+		if (edid_is_timing_block(block)) {
+			var->xres = var->xres_virtual = H_ACTIVE;
+			var->yres = var->yres_virtual = V_ACTIVE;
+			var->height = var->width = -1;
+			var->right_margin = H_SYNC_OFFSET;
+			var->left_margin = (H_ACTIVE + H_BLANKING) -
+				(H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
+			var->upper_margin = V_BLANKING - V_SYNC_OFFSET - 
+				V_SYNC_WIDTH;
+			var->lower_margin = V_SYNC_OFFSET;
+			var->hsync_len = H_SYNC_WIDTH;
+			var->vsync_len = V_SYNC_WIDTH;
+			var->pixclock = PIXEL_CLOCK;
+			var->pixclock /= 1000;
+			var->pixclock = KHZ2PICOS(var->pixclock);
+
+			dprintk("fbmon.c: parse_edid: %ux%u pixclock %lu\n", var->xres, var->yres, var->pixclock);
+			if (HSYNC_POSITIVE)
+				var->sync |= FB_SYNC_HOR_HIGH_ACT;
+			if (VSYNC_POSITIVE)
+				var->sync |= FB_SYNC_VERT_HIGH_ACT;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static void calc_mode_timings(int xres, int yres, int refresh, struct fb_videomode *mode)
+{
+	struct fb_var_screeninfo var;
+	struct fb_info info;
+	
+	var.xres = xres;
+	var.yres = yres;
+	fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON, 
+		    refresh, &var, &info);
+	mode->xres = xres;
+	mode->yres = yres;
+	mode->pixclock = var.pixclock;
+	mode->refresh = refresh;
+	mode->left_margin = var.left_margin;
+	mode->right_margin = var.right_margin;
+	mode->upper_margin = var.upper_margin;
+	mode->lower_margin = var.lower_margin;
+	mode->hsync_len = var.hsync_len;
+	mode->vsync_len = var.vsync_len;
+	mode->vmode = 0;
+	mode->sync = 0;
+}
+
+static int get_est_timing(unsigned char *block, struct fb_videomode *mode)
+{
+	int num = 0;
+	unsigned char c;
+
+	c = block[0];
+	if (c&0x80) 
+		calc_mode_timings(720, 400, 70, &mode[num++]);
+	if (c&0x40) 
+		calc_mode_timings(720, 400, 88, &mode[num++]);
+	if (c&0x20)
+		mode[num++] = vesa_modes[3];
+	if (c&0x10)
+		calc_mode_timings(640, 480, 67, &mode[num++]);
+	if (c&0x08)
+		mode[num++] = vesa_modes[4];
+	if (c&0x04)
+		mode[num++] = vesa_modes[5];
+	if (c&0x02)
+		mode[num++] = vesa_modes[7];
+	if (c&0x01)
+		mode[num++] = vesa_modes[8];
+
+	c = block[1];
+	if (c&0x80)
+ 		mode[num++] = vesa_modes[9];
+	if (c&0x40)
+ 		mode[num++] = vesa_modes[10];
+	if (c&0x20)
+		calc_mode_timings(832, 624, 75, &mode[num++]);
+	if (c&0x10)
+		mode[num++] = vesa_modes[12];
+	if (c&0x08)
+		mode[num++] = vesa_modes[13];
+	if (c&0x04)
+		mode[num++] = vesa_modes[14];
+	if (c&0x02)
+		mode[num++] = vesa_modes[15];
+	if (c&0x01)
+		mode[num++] = vesa_modes[21];
+
+	c = block[2];
+	if (c&0x80)
+		mode[num++] = vesa_modes[17];
+
+	return num;
+}
+
+static int get_std_timing(unsigned char *block, struct fb_videomode *mode)
+{
+	int xres, yres = 0, refresh, ratio, i;
+	
+	xres = (block[0] + 31) * 8;
+	if (xres <= 256)
 		return 0;
 
-	printk("EDID ver %d rev %d\n", (int) edid[EDID_STRUCT_VERSION],
-	       (int) edid[EDID_STRUCT_REVISION]);
+	ratio = (block[1] & 0xc0) >> 6;
+	switch (ratio) {
+	case 0:
+		yres = xres;
+		break;
+	case 1:
+		yres = (xres * 3)/4;
+		break;
+	case 2:
+		yres = (xres * 4)/5;
+		break;
+	case 3:
+		yres = (xres * 9)/16;
+		break;
+	}
+	refresh = (block[1] & 0x3f) + 60;
+
+	for (i = 0; i < VESA_MODEDB_SIZE; i++) {
+		if (vesa_modes[i].xres == xres && 
+		    vesa_modes[i].yres == yres &&
+		    vesa_modes[i].refresh == refresh) {
+			*mode = vesa_modes[i];
+			break;
+		} else {
+			calc_mode_timings(xres, yres, refresh, mode);
+			break;
+		}
+	}
+	return 1;
+}
 
-	vendor = edid_get_vendor(edid + ID_MANUFACTURER_NAME);
+static int get_dst_timing(unsigned char *block,
+			  struct fb_videomode *mode)
+{
+	int j, num = 0;
+
+	for (j = 0; j < 6; j++, block+= STD_TIMING_DESCRIPTION_SIZE) 
+		num += get_std_timing(block, &mode[num]);
+
+	return num;
+}
 
+static void get_detailed_timing(unsigned char *block, 
+				struct fb_videomode *mode)
+{
+	mode->xres = H_ACTIVE;
+	mode->yres = V_ACTIVE;
+	mode->pixclock = PIXEL_CLOCK;
+	mode->pixclock /= 1000;
+	mode->pixclock = KHZ2PICOS(mode->pixclock);
+	mode->right_margin = H_SYNC_OFFSET;
+	mode->left_margin = (H_ACTIVE + H_BLANKING) -
+		(H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
+	mode->upper_margin = V_BLANKING - V_SYNC_OFFSET - 
+		V_SYNC_WIDTH;
+	mode->lower_margin = V_SYNC_OFFSET;
+	mode->hsync_len = H_SYNC_WIDTH;
+	mode->vsync_len = V_SYNC_WIDTH;
+	if (HSYNC_POSITIVE)
+		mode->sync |= FB_SYNC_HOR_HIGH_ACT;
+	if (VSYNC_POSITIVE)
+		mode->sync |= FB_SYNC_VERT_HIGH_ACT;
+	mode->refresh = PIXEL_CLOCK/((H_ACTIVE + H_BLANKING) *
+				     (V_ACTIVE + V_BLANKING));
+	mode->vmode = 0;
+	dprintk("fbmon.c: get_detailed_timing: %ux%u pixclock %lu refresh %lu\n", mode->xres, mode->yres, mode->pixclock, mode->refresh);
+}
+
+/**
+ * fb_create_modedb - create video mode database
+ * @edid: EDID data
+ * @dbsize: database size
+ *
+ * RETURNS: struct fb_videomode, @dbsize contains length of database
+ *
+ * DESCRIPTION:
+ * This function builds a mode database using the contents of the EDID
+ * data
+ */
+struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
+{
+	struct fb_videomode *mode, *m;
+	unsigned char *block;
+	int num = 0, i;
+
+	mode = kmalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
+	if (mode == NULL)
+		return NULL;
+	memset(mode, 0, 50 * sizeof(struct fb_videomode));
+
+	if (edid == NULL || !edid_checksum(edid) || 
+	    !edid_check_header(edid)) {
+		kfree(mode);
+		return NULL;
+	}
+
+	*dbsize = 0;
+
+	block = edid + ESTABLISHED_TIMING_1;
+	num += get_est_timing(block, &mode[num]);
+
+	block = edid + STD_TIMING_DESCRIPTIONS_START;
+	for (i = 0; i < STD_TIMING; i++, block += STD_TIMING_DESCRIPTION_SIZE) 
+		num += get_std_timing(block, &mode[num]);
+
+	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+	for (i = 0; i < 4; i++, block+= DETAILED_TIMING_DESCRIPTION_SIZE) {
+		if (block[0] == 0x00 && block[1] == 0x00) {
+			if (block[3] == 0xfa) {
+				num += get_dst_timing(block + 5, &mode[num]);
+			}
+		} else  {
+			get_detailed_timing(block, &mode[num]);
+			num++;
+		}
+	}
+	
+	/* Yikes, EDID data is totally useless */
+	if (!num) {
+		kfree(mode);
+		return NULL;
+	}
+
+	*dbsize = num;
+	m = kmalloc(num * sizeof(struct fb_videomode), GFP_KERNEL);
+	if (!m)
+		return mode;
+	memmove(m, mode, num * sizeof(struct fb_videomode));
+	kfree(mode);
+	return m;
+}
+
+/**
+ * fb_destroy_modedb - destroys mode database
+ * @modedb: mode database to destroy
+ *
+ * DESCRIPTION:
+ * Destroy mode database created by fb_create_modedb
+ */
+void fb_destroy_modedb(struct fb_videomode *modedb)
+{
+	if (modedb)
+		kfree(modedb);
+}
+
+/**
+ * fb_get_monitor_limits - get monitor operating limits
+ * @edid: EDID data
+ * @specs: fb_monspecs structure pointer
+ *
+ * DESCRIPTION:
+ * Gets monitor operating limits from EDID data and places them in 
+ * @specs
+ */
+int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
+{
+	int i, retval = 1;
+	unsigned char *block;
+
+	if (edid == NULL || specs == NULL)
+		return 1;
+
+	if (!(edid_checksum(edid)))
+		return 1;
+
+	if (!(edid_check_header(edid)))
+		return 1;
+
+	memset(specs, 0, sizeof(struct fb_monspecs));
 	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
 
+	printk("Monitor Operating Limits: ");
 	for (i = 0; i < 4; i++, block += DETAILED_TIMING_DESCRIPTION_SIZE) {
-		if (edid_is_monitor_block(block)) {
-			monitor = edid_get_monitor(block);
+		if (edid_is_limits_block(block)) {
+			specs->hfmin = H_MIN_RATE * 1000;
+			specs->hfmax = H_MAX_RATE * 1000;
+			specs->vfmin = V_MIN_RATE;
+			specs->vfmax = V_MAX_RATE;
+			specs->dclkmax = (MAX_PIXEL_CLOCK != 10*0xff) ?
+				MAX_PIXEL_CLOCK * 1000000 : 0;
+			specs->gtf = (GTF_SUPPORT) ? 1 : 0;
+			specs->dpms = edid[DPMS_FLAGS];
+			retval = 0;
+			printk("From EDID\n");
+			break;
 		}
 	}
+	
+	/* estimate monitor limits based on modes supported */
+	if (retval) {
+		struct fb_videomode *modes;
+		int num_modes, i, hz, hscan, pixclock;
+
+		modes = fb_create_modedb(edid, &num_modes);
+		if (!modes) {
+			printk("None Available\n");
+			return 1;
+		}
 
-	printk("EDID: detected %s %s\n", vendor, monitor);
+		retval = 0;
+		for (i = 0; i < num_modes; i++) {
+			hz = modes[i].refresh;
+			pixclock = PICOS2KHZ(modes[i].pixclock) * 1000;
+			hscan = (modes[i].yres * 105 * hz + 5000)/100;
+			
+			if (specs->dclkmax == 0 || specs->dclkmax < pixclock)
+				specs->dclkmax = pixclock;
+			if (specs->dclkmin == 0 || specs->dclkmin > pixclock)
+				specs->dclkmin = pixclock;
+			if (specs->hfmax == 0 || specs->hfmax < hscan)
+				specs->hfmax = hscan;
+			if (specs->hfmin == 0 || specs->hfmin > hscan)
+				specs->hfmin = hscan;
+			if (specs->vfmax == 0 || specs->vfmax < hz)
+				specs->vfmax = hz;
+			if (specs->vfmin == 0 || specs->vfmin > hz)
+				specs->vfmin = hz;
+		}
+		printk("Extrapolated\n");
+		fb_destroy_modedb(modes);
+	}
+	printk("     H: %d-%dKHz V: %d-%dHz DCLK: %dMHz\n", specs->hfmin/1000, specs->hfmax/1000, 
+	       specs->vfmin, specs->vfmax, specs->dclkmax/1000000);
+	return retval;
+}
 
-	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+void show_edid(unsigned char *edid)
+{
+	unsigned char *block;
+	int i;
+
+	if (edid == NULL)
+		return;
+
+	if (!(edid_checksum(edid)))
+		return;
 
+	if (!(edid_check_header(edid)))
+		return;
+	printk("========================================\n");
+	printk("Display Information (EDID)\n");
+	printk("========================================\n");
+	printk("   EDID Version %d.%d\n", (int) edid[EDID_STRUCT_VERSION],
+	       (int) edid[EDID_STRUCT_REVISION]);
+
+	parse_vendor_block(edid + ID_MANUFACTURER_NAME);
+
+	printk("   Display Characteristics:\n");
+	parse_display_block(edid + EDID_STRUCT_DISPLAY);
+
+	printk("   Standard Timings\n");
+	block = edid + STD_TIMING_DESCRIPTIONS_START;
+	for (i = 0; i < STD_TIMING; i++, block += STD_TIMING_DESCRIPTION_SIZE) 
+		parse_std_timing_block(block);
+
+	printk("   Supported VESA Modes\n");
+	parse_std_md_block(edid + ESTABLISHED_TIMING_1);
+
+	printk("   Detailed Monitor Information\n");
+	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
 	for (i = 0; i < 4; i++, block += DETAILED_TIMING_DESCRIPTION_SIZE) {
-		if (edid_is_timing_block(block)) {
-			parse_timing_block(block, var);
+		if (edid_is_serial_block(block)) {
+			parse_serial_block(block);
+		} else if (edid_is_ascii_block(block)) {
+			parse_ascii_block(block);
+		} else if (edid_is_limits_block(block)) {
+			parse_limits_block(block);
+		} else if (edid_is_monitor_block(block)) {
+			parse_monitor_block(block);
+		} else if (edid_is_color_block(block)) {
+			parse_color_block(block);
+		} else if (edid_is_std_timings_block(block)) {
+			parse_dst_timing_block(block);
+		} else if (edid_is_timing_block(block)) {
+			parse_detailed_timing_block(block);
 		}
 	}
-	return 1;
+	printk("========================================\n");
 }
 
 #ifdef CONFIG_PCI
 char *get_EDID(struct pci_dev *pdev)
 {
+	unsigned char *pedid = NULL;
 #ifdef CONFIG_ALL_PPC
 	static char *propnames[] =
 	    { "DFP,EDID", "LCD,EDID", "EDID", "EDID1", NULL };
-	unsigned char *pedid = NULL;
 	struct device_node *dp;
 	int i;
 
+	if (pdev == NULL)
+		return NULL;
 	dp = pci_device_to_OF_node(pdev);
 	while (dp != NULL) {
 		for (i = 0; propnames[i] != NULL; ++i) {
@@ -285,10 +855,8 @@
 		}
 		dp = dp->child;
 	}
-	return pedid;
-#else
-	return NULL;
 #endif
+	return pedid;
 }
 #endif
 
@@ -672,6 +1240,9 @@
 	hfreq = pixclock/htotal;
 	vfreq = hfreq/vtotal;
 
+	dprintk("fbmon.c: fb_validate_mode: vfmin<vfreq<vfmax %u<%u<%u hfmin<hfreq<hvmax %u<%u<%u dclkmin<pixclock<dclkmax %lu<%lu<%lu\n",
+		vfmin, vfreq, vfmax, hfmin, hfreq, hfmax, dclkmin, pixclock, dclkmax);
+
 	return (vfreq < vfmin || vfreq > vfmax || 
 		hfreq < hfmin || hfreq > hfmax ||
 		pixclock < dclkmin || pixclock > dclkmax) ?
@@ -679,8 +1250,12 @@
 }
 
 EXPORT_SYMBOL(parse_edid);
+EXPORT_SYMBOL(show_edid);
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(get_EDID);
 #endif
+EXPORT_SYMBOL(fb_get_monitor_limits);
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
+EXPORT_SYMBOL(fb_create_modedb);
+EXPORT_SYMBOL(fb_destroy_modedb);
diff -urN -X dontdiff linux-2.5.67/drivers/video/modedb.c linux-2.5.67-vm86/drivers/video/modedb.c
--- linux-2.5.67/drivers/video/modedb.c	2003-04-07 19:55:38.000000000 +0200
+++ linux-2.5.67-vm86/drivers/video/modedb.c	2003-04-12 08:27:28.000000000 +0200
@@ -251,6 +251,110 @@
     },
 };
 
+const struct fb_videomode vesa_modes[] = {
+	/* 0 640x350-85 VESA */
+	{ NULL, 85, 640, 350, 31746,  96, 32, 60, 32, 64, 3,
+	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 1 640x400-85 VESA */
+	{ NULL, 85, 640, 400, 31746,  96, 32, 41, 01, 64, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 2 720x400-85 VESA */
+	{ NULL, 85, 721, 400, 28169, 108, 36, 42, 01, 72, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 3 640x480-60 VESA */
+	{ NULL, 60, 640, 480, 39682,  48, 16, 33, 10, 96, 2, 
+	  0, FB_VMODE_NONINTERLACED },
+	/* 4 640x480-72 VESA */
+	{ NULL, 72, 640, 480, 31746, 128, 24, 29, 9, 40, 2, 
+	  0, FB_VMODE_NONINTERLACED },
+	/* 5 640x480-75 VESA */
+	{ NULL, 75, 640, 480, 31746, 120, 16, 16, 01, 64, 3,
+	  0, FB_VMODE_NONINTERLACED },
+	/* 6 640x480-85 VESA */
+	{ NULL, 85, 640, 480, 27777, 80, 56, 25, 01, 56, 3,
+	  0, FB_VMODE_NONINTERLACED },
+	/* 7 800x600-56 VESA */
+	{ NULL, 56, 800, 600, 27777, 128, 24, 22, 01, 72, 2,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 8 800x600-60 VESA */
+	{ NULL, 60, 800, 600, 25000, 88, 40, 23, 01, 128, 4,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 9 800x600-72 VESA */
+	{ NULL, 72, 800, 600, 20000, 64, 56, 23, 37, 120, 6,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 10 800x600-75 VESA */
+	{ NULL, 75, 800, 600, 20202, 160, 16, 21, 01, 80, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 11 800x600-85 VESA */
+	{ NULL, 85, 800, 600, 17761, 152, 32, 27, 01, 64, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+        /* 12 1024x768i-43 VESA */
+	{ NULL, 53, 1024, 768, 22271, 56, 8, 41, 0, 176, 8,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_INTERLACED },
+	/* 13 1024x768-60 VESA */
+	{ NULL, 60, 1024, 768, 15384, 160, 24, 29, 3, 136, 6,
+	  0, FB_VMODE_NONINTERLACED },
+	/* 14 1024x768-70 VESA */
+	{ NULL, 70, 1024, 768, 13333, 144, 24, 29, 3, 136, 6,
+	  0, FB_VMODE_NONINTERLACED },
+	/* 15 1024x768-75 VESA */
+	{ NULL, 75, 1024, 768, 12690, 176, 16, 28, 1, 96, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 16 1024x768-85 VESA */
+	{ NULL, 85, 1024, 768, 10582, 208, 48, 36, 1, 96, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 17 1152x864-75 VESA */
+	{ NULL, 75, 1153, 864, 9259, 256, 64, 32, 1, 128, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 18 1280x960-60 VESA */
+	{ NULL, 60, 1280, 960, 9259, 312, 96, 36, 1, 112, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 19 1280x960-85 VESA */
+	{ NULL, 85, 1280, 960, 6734, 224, 64, 47, 1, 160, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 20 1280x1024-60 VESA */
+	{ NULL, 60, 1280, 1024, 9259, 248, 48, 38, 1, 112, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 21 1280x1024-75 VESA */
+	{ NULL, 75, 1280, 1024, 7407, 248, 16, 38, 1, 144, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 22 1280x1024-85 VESA */
+	{ NULL, 85, 1280, 1024, 6349, 224, 64, 44, 1, 160, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 23 1600x1200-60 VESA */
+	{ NULL, 60, 1600, 1200, 6172, 304, 64, 46, 1, 192, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 24 1600x1200-65 VESA */
+	{ NULL, 65, 1600, 1200, 5698, 304,  64, 46, 1, 192, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 25 1600x1200-70 VESA */
+	{ NULL, 70, 1600, 1200, 5291, 304, 64, 46, 1, 192, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 26 1600x1200-75 VESA */
+	{ NULL, 75, 1600, 1200, 4938, 304, 64, 46, 1, 192, 3, 
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 27 1600x1200-85 VESA */
+	{ NULL, 85, 1600, 1200, 4357, 304, 64, 46, 1, 192, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 28 1792x1344-60 VESA */
+	{ NULL, 60, 1792, 1344, 4882, 328, 128, 46, 1, 200, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 29 1792x1344-75 VESA */
+	{ NULL, 75, 1792, 1344, 3831, 352, 96, 69, 1, 216, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 30 1856x1392-60 VESA */
+	{ NULL, 60, 1856, 1392, 4580, 352, 96, 43, 1, 224, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 31 1856x1392-75 VESA */
+	{ NULL, 75, 1856, 1392, 3472, 352, 128, 104, 1, 224, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 32 1920x1440-60 VESA */
+	{ NULL, 60, 1920, 1440, 4273, 344, 128, 56, 1, 200, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+	/* 33 1920x1440-75 VESA */
+	{ NULL, 60, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED },
+};
 
 static int __init my_atoi(const char *name)
 {
@@ -432,3 +536,4 @@
 }
 
 EXPORT_SYMBOL(__fb_try_mode);
+EXPORT_SYMBOL(vesa_modes);
diff -urN -X dontdiff linux-2.5.67/drivers/video/vbe.c linux-2.5.67-vm86/drivers/video/vbe.c
--- linux-2.5.67/drivers/video/vbe.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-vm86/drivers/video/vbe.c	2003-04-13 11:06:04.000000000 +0200
@@ -0,0 +1,685 @@
+ /*-*- linux-c -*-
+ *  linux/drivers/video/vbe.c -- VBE Generic Functions via VM86
+ *
+ *      Copyright (C) 2003 Antonino Daplas<adaplas@pol.net>
+ *      All Rights Reserved      
+ *
+ *  NOTES: practically all functions here needs the scheduler
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+#include <linux/tty.h>
+#include <linux/fb.h>
+#include <linux/module.h>
+#include <linux/vm86.h>
+#include "edid.h"
+#include "vbe.h"
+
+static int vbe_debug = 0;
+#define dprintk(x...) do { if (vbe_debug) printk(x); } while(0)
+
+static u8 edid_block[128];
+
+static int vbe_setcolreg(unsigned regno, unsigned red, unsigned green,
+			 unsigned blue, unsigned transp,
+			 struct fb_info *info);
+static int vbe_set_par(struct fb_info *info);
+static int vbe_check_var(struct fb_var_screeninfo *var, struct fb_info *info);
+static int vbe_pan_display(struct fb_var_screeninfo *var,
+			   struct fb_info *info);
+static int vbe_blank(int blank, struct fb_info *info);
+static struct fb_ops vbe_ops;
+
+char *vbe_get_edid(void)
+{
+	struct vm86_request request;
+	u8 *buffer;
+
+	buffer = kmalloc(1024, GFP_KERNEL);
+	if (buffer == NULL)
+		return NULL;
+	memset(&request, 0, sizeof(struct vm86_request));
+	request.regs.eax = 0x4f15;
+	request.regs.ebx = 0;
+	request.regs.ecx = 0;
+	request.interrupt = 0x10;
+	request.buf_len = 0;
+	if (vm86_exec(&request, buffer) || 
+	    request.flags == VM86_FAILED) {
+		kfree(buffer);
+		return NULL;
+	}
+	if (request.regs.ebx & 1 ||
+	    request.regs.ebx & 2) {
+		memset(&request, 0, sizeof(struct vm86_request));
+		request.regs.eax = 0x4f15;
+		request.regs.ebx = 1;
+		request.regs.ecx = 0;
+		request.regs.edx = 1;
+		request.interrupt = 0x10;
+		request.buf_len = 0;
+		if (vm86_exec(&request, buffer) ||
+		    request.flags == VM86_FAILED) {
+			kfree(buffer);
+			return NULL;
+		}
+		memcpy(edid_block, buffer, 128);
+		show_edid(edid_block);
+	}
+	kfree(buffer);
+	return edid_block;
+}
+
+static int vbe_filter_mode(short vbeidx, struct vbemode *mode,
+			   struct vbe_modeinfo *modeinfo, struct fb_info *info)
+{
+	struct vbe_par *par = (struct vbe_par *) info->vbe_par;
+	int retval = 0, i;
+
+	if (info->monspecs.gtf) {
+		struct fb_var_screeninfo var;
+		
+		memset(&var, 0, sizeof(struct fb_var_screeninfo));
+		var.xres = mode->xres;
+		var.yres = mode->yres;
+		retval = (fb_get_mode(FB_MAXTIMINGS, 0, &var, info)) ? 0 : 1;
+	} else {
+		for (i = 0; i < par->num_modes; i++) {
+			if (par->modes[i].xres == mode->xres &&
+			    par->modes[i].yres == mode->yres) {
+				retval = 1;
+				break;
+			}
+		}
+	}
+	if (retval) {
+		modeinfo->vbemode = vbeidx;
+		modeinfo->xres = mode->xres;
+		modeinfo->yres = mode->yres;
+		modeinfo->bpp = mode->bpp;
+		modeinfo->pitch = mode->pitch;
+		modeinfo->visual = mode->mem_model;
+		modeinfo->red.offset = mode->redoffset;
+		modeinfo->red.length = mode->redlen;
+		modeinfo->green.offset = mode->greenoffset;
+		modeinfo->green.length = mode->greenlen;
+		modeinfo->blue.offset = mode->blueoffset;
+		modeinfo->blue.length = mode->bluelen;
+		modeinfo->transp.offset = mode->reserved_offset;
+		modeinfo->transp.length = mode->reserved_len;
+		printk("   %dx%d-%dbpp RGB%d%d%d \n", mode->xres, mode->yres,
+		       mode->bpp, mode->redmask, mode->greenmask, mode->bluemask);
+	}
+	return retval;
+}
+			
+static int vbe_check_modes(struct fb_info *info, short *modelist)
+{
+	struct vm86_request request;
+	struct vbe_par *par = (struct vbe_par *) info->vbe_par;
+	struct vbemode *mode;
+	struct vbe_modeinfo *modeinfo;
+	int num_modes = 0;
+
+	mode = kmalloc(1024, GFP_KERNEL);
+	if (mode == NULL)
+		return 1;
+
+	modeinfo = kmalloc(256 * sizeof(struct vbe_modeinfo), GFP_KERNEL);
+	if (modeinfo == NULL) {
+		kfree(mode);
+		return 1;
+	}
+	printk("Filtered Video Modes\n");
+	for (; *modelist != -1; modelist++) {
+		memset(&request, 0, sizeof(struct vm86_request));
+		request.regs.eax = 0x4f01;
+		request.regs.ecx = *modelist;
+		request.interrupt = 0x10;
+		request.buf_len = sizeof(struct vbemode);
+		if (vm86_exec(&request, mode) ||
+		    request.flags == VM86_FAILED ||
+		    (request.regs.eax & 0xff) != 0x4f) {
+			kfree(mode);
+			kfree(modeinfo);
+			return 1;
+		}
+		if ((request.regs.eax & 0xff00) == 0x0000 &&
+		    (mode->attr & 1) && (mode->attr & (1<<4)) && 
+		    (mode->attr & (1 << 7))) {
+			num_modes += vbe_filter_mode(*modelist, mode, 
+						    &modeinfo[num_modes], info);
+		}
+	}
+	par->num_vbemodes = num_modes;
+	if (num_modes) {
+		par->modeinfo = kmalloc(sizeof(struct vbe_modeinfo) * num_modes,
+					GFP_KERNEL);
+		if (par->modeinfo) {
+			memcpy(par->modeinfo, modeinfo, 
+			       sizeof(struct vbe_modeinfo) * num_modes);
+			kfree(modeinfo);
+		} else 
+			par->modeinfo = modeinfo;
+	} else
+		kfree(modeinfo);
+	kfree(mode);
+	return 0;
+}
+			
+static int vbe_modelist(struct fb_info *info)
+{
+	struct vbe_par *par = (struct vbe_par *) info->vbe_par;
+	struct vm86_request request;
+	struct vbeinfo *vbe;
+	short *modelist;
+
+	vbe = kmalloc(1024, GFP_KERNEL);
+	if (vbe == NULL)
+		return 1;
+	modelist = (short *) vbe;
+	memset(&request, 0, sizeof(struct vm86_request));
+	request.interrupt = 0x10;
+	request.regs.eax = 0x4f00;
+	request.buf_len = sizeof(struct vbeinfo);
+	memmove(vbe->sig, "VBE2", 4);
+	
+	if (vm86_exec(&request, vbe) ||
+	    request.flags == VM86_FAILED) {
+		kfree(vbe);
+		return 1;
+	}
+	if ((request.regs.eax & 0xffff) != 0x4f || 
+	    strncmp(vbe->sig, "VESA", 4)) {
+		kfree(vbe);
+		return 1;
+	}
+	par->caps = vbe->caps;
+	(unsigned long) modelist += vbe->modelist;
+	vbe_check_modes(info, modelist);
+	kfree(vbe);
+	return 0;
+}
+	
+static int vbe_init_modes(struct fb_info *info)
+{
+	struct vbe_par *par = (struct vbe_par *) info->vbe_par;
+	int retval = 0;
+	u8 *edid;
+
+	edid = vbe_get_edid();
+	if (edid == NULL) 
+		return -EINVAL;
+	memcpy(par->edid, edid, 128);
+	fb_get_monitor_limits(par->edid, &info->monspecs);
+	par->modes = fb_create_modedb(par->edid, &par->num_modes);
+	retval = vbe_modelist(info);
+	if (!retval) 
+		par->flags |= VBE_FLAGS_INIT;
+	return retval;
+}
+
+static int vbe_get_gtfmode(struct fb_var_screeninfo *var, struct fb_info *info,
+			   struct vbe_modeinfo *modeinfo)
+{
+	struct vm86_request request;
+	void *buffer;
+	u32 pixclock;
+	int retval;
+	
+	buffer = kmalloc(1024, GFP_KERNEL);
+	if (buffer == NULL)
+		return -ENOMEM;
+	
+	retval = fb_get_mode(FB_MAXTIMINGS, 0, var, info);
+	if (retval)
+		return retval;
+
+	pixclock = var->pixclock;
+	for (;;) {
+		pixclock = PICOS2KHZ(pixclock);
+		pixclock *= 1000;
+		if (pixclock < info->monspecs.dclkmin ||
+		    pixclock > info->monspecs.dclkmax) {
+			kfree(buffer);
+			return -EINVAL;
+		}
+		memset(&request, 0, sizeof(struct vm86_request));
+		request.regs.eax = 0x4f0b;
+		request.regs.ebx = 0;
+		request.regs.ecx = pixclock;
+		request.regs.edx = modeinfo->vbemode;
+		request.interrupt = 0x10;
+		retval =  (vm86_exec(&request, buffer) ||
+			   request.flags == VM86_FAILED ||
+			   (request.regs.eax & 0xffff) != 0x4f) ?
+			-EINVAL : 0;
+		
+		if (retval) {
+			kfree(buffer);
+			return retval;
+		}
+		pixclock = request.regs.ecx;
+		pixclock /= 1000;
+		pixclock = KHZ2PICOS(pixclock);
+		retval = fb_get_mode(FB_DCLKTIMINGS, pixclock, var, info);
+		if (!retval)
+			break;
+		/* lower pixclock by .25 MHz */
+		pixclock = KHZ2PICOS(PICOS2KHZ(pixclock) - 250);
+	} 
+	kfree(buffer);
+	return retval;
+}
+	
+static int vbe_get_dmtmode(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct vbe_par *par = (struct vbe_par *)info->vbe_par;
+	u32 best_refresh = 0, best_mode = -1, i;
+
+	for (i = 0; i < par->num_modes; i++) {
+		dprintk("vbe.c: vbe_get_dmtmode: best %dx%d @ %d, found %dx%d @ %d\n",
+				var->xres, var->yres, best_refresh, par->modes[i].xres, par->modes[i].yres, par->modes[i].refresh);
+		if (par->modes[i].xres == var->xres &&
+		    par->modes[i].yres == var->yres &&
+		    par->modes[i].refresh > best_refresh &&
+		    par->modes[i].vmode == FB_VMODE_NONINTERLACED) {
+			best_refresh = par->modes[i].refresh;
+			best_mode = i;
+		}
+	}
+	if (!best_refresh)
+		return -EINVAL;
+	var->pixclock = par->modes[best_mode].pixclock;
+	var->left_margin = par->modes[best_mode].left_margin;
+	var->right_margin = par->modes[best_mode].right_margin;
+	var->upper_margin = par->modes[best_mode].upper_margin;
+	var->lower_margin = par->modes[best_mode].lower_margin;
+	var->vsync_len = par->modes[best_mode].vsync_len;
+	var->hsync_len = par->modes[best_mode].hsync_len;
+	var->sync = par->modes[best_mode].sync;
+	return 0;
+}
+
+static int vbe_writedac(u8 regno, u8 red, u8 green, u8 blue,
+			struct vbepaletteentry *entry, int vblank) 
+{
+	struct vm86_request request;
+
+	entry->red = red;
+	entry->green = green;
+	entry->blue = blue;
+
+	memset(&request, 0, sizeof(struct vm86_request));
+	request.regs.eax = 0x4f09;
+	request.regs.ebx = (vblank) ? 0x80 : 0;
+	request.regs.ecx = 1;
+	request.regs.edx = regno;
+	request.interrupt = 0x10;
+	request.buf_len = sizeof(struct vm86_request);
+	return (vm86_exec(&request, entry) ||
+		request.flags == VM86_FAILED) ?
+		-EINVAL : 0;
+}
+
+/*
+ * FIXME: console blanking functions also calls several
+ *        fb-related functions.  Since console blanking
+ *        cannot be scheduled, we need to differentiate if
+ *        blanking came from kernel space or not.
+ */
+static int vbe_blank(int blank, struct fb_info *info)
+{
+	struct vbe_par *par = (struct vbe_par *) info->vbe_par;
+#if CONFIG_VM86
+	/* don't blank; blanking is done from interrupt context and
+	 * vm86_exec() calls yield() which causes an oops.
+	 */
+	dprintk("Console (un)blanking not supported when CONFIG_VM86 is configured into the kernel.\n");
+	return 0;
+#endif
+	par->blank = blank;
+	par->blank_kspc = info->blank_kspc;
+
+	return -EINVAL;
+}
+
+static int vbe_pan_display(struct fb_var_screeninfo *var,
+			   struct fb_info *info)
+{
+	struct vm86_request request;
+	struct vbe_par *par = (struct vbe_par *) info->vbe_par;
+	void *buffer;
+	int err;
+
+	if (!(par->flags & VBE_FLAGS_INIT) || 
+	    (par->blank_kspc && par->blank))
+		return par->fbops->fb_pan_display(var, info);
+
+	if (!(buffer = kmalloc(1024, GFP_KERNEL)))
+		return -EINVAL;
+
+	memset(&request, 0, sizeof(struct vm86_request));
+	request.regs.eax = 0x4f07;
+	request.regs.ebx = 0x80;
+	request.regs.ecx = var->xoffset;
+	request.regs.edx = var->yoffset;
+	request.interrupt = 0x10;
+	request.buf_len = 0;
+	err = (vm86_exec(&request, buffer) ||
+	       request.flags == VM86_FAILED) ? -EINVAL : 0;
+	kfree(buffer);
+
+	return err;
+}
+
+static int vbe_setcolreg(unsigned regno, unsigned red, unsigned green,
+			 unsigned blue, unsigned transp,
+			 struct fb_info *info)
+{
+	struct vbepaletteentry *entry;
+	struct vbe_par *par = (struct vbe_par *) info->vbe_par;
+	int vblank;
+
+	if (!(par->flags & VBE_FLAGS_INIT) || 
+	    (par->blank_kspc && par->blank)) 
+		return par->fbops->fb_setcolreg(regno, red, green, 
+						blue, transp, info);
+
+	if (regno > 255)
+		return 1;
+		    
+	entry = kmalloc(1024, GFP_KERNEL);
+	if (entry == NULL)
+		return -EINVAL;
+
+	vblank = par->caps & (1 << 3);
+
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
+		vbe_writedac((u8) regno, (u8) (red >> 10), 
+			     (u8) (green >> 10), (u8) (blue >> 10),
+			     entry, vblank);
+	}
+
+	if (regno < 16) {
+		if (info->fix.visual == FB_VISUAL_TRUECOLOR) {
+			int mask, offset, val;
+			
+			mask = (0xff << (8 - info->var.red.length)) & 0xff; 
+			offset = info->var.red.offset - (8 - info->var.red.length);
+			val  =	(offset >= 0) ? (red & mask) << offset :
+				(red & mask) >> -(offset);
+
+			mask = (0xff << (8 - info->var.green.length)) & 0xff; 
+			offset = info->var.green.offset - (8 - info->var.green.length);
+			val  |=	(offset >= 0) ? (green & mask) << offset :
+				(green & mask) >> -(offset);
+
+			mask = (0xff << (8 - info->var.blue.length)) & 0xff; 
+			offset = info->var.blue.offset - (8 - info->var.blue.length);
+			val  |=	(offset >= 0) ? (blue & mask) << offset :
+				(blue & mask) >> -(offset);
+
+			((u32 *)info->pseudo_palette)[regno] = val;
+		}
+	}
+
+	kfree(entry);
+	return 0;
+}
+		
+static int vbe_set_par(struct fb_info *info)
+{
+	struct vm86_request request;
+	struct vbe_par *par = (struct vbe_par *) info->vbe_par;
+	struct vbecrtcinfo *crtc;
+	struct vbe_modeinfo modeinfo;
+	struct fb_var_screeninfo *var = &info->var;
+	u32 i;
+	short vbemode = 0;
+
+	if (!(par->flags & VBE_FLAGS_INIT) ||
+	    !par->num_vbemodes || (par->blank_kspc && par->blank))
+		return 0;
+	
+	crtc = kmalloc(1024, GFP_KERNEL);
+	if (crtc == NULL)
+		return -ENOMEM;
+	for (i = 0; i < par->num_vbemodes; i++) {
+		if (par->modeinfo[i].xres == info->var.xres &&
+		    par->modeinfo[i].yres == info->var.yres &&
+		    par->modeinfo[i].bpp == info->var.bits_per_pixel &&
+		    par->modeinfo[i].red.offset == info->var.red.offset &&
+		    par->modeinfo[i].green.offset == info->var.green.offset &&
+		    par->modeinfo[i].blue.offset == info->var.blue.offset) {
+			vbemode = par->modeinfo[i].vbemode;
+			modeinfo = par->modeinfo[i];
+			break;
+		}
+	}
+	
+	if (!vbemode)
+		return -EINVAL;
+
+	crtc->hsync0 = var->xres + var->right_margin;
+	crtc->hsync1 = crtc->hsync0 + var->hsync_len;
+	crtc->htotal = crtc->hsync1 + var->left_margin;
+		    
+	crtc->vsync0 = var->yres + var->lower_margin;
+	crtc->vsync1 = crtc->vsync0 + var->vsync_len;
+	crtc->vtotal = crtc->vsync1 + var->upper_margin;
+	crtc->flags = (var->sync & FB_SYNC_HOR_HIGH_ACT) ? (1 << 2) : 0;
+	crtc->flags |= (var->sync & FB_SYNC_VERT_HIGH_ACT) ? (1 << 3) : 0;
+	crtc->pixclock = PICOS2KHZ(var->pixclock);
+	crtc->pixclock *= 1000;
+	crtc->refresh = crtc->pixclock/(crtc->htotal * crtc->vtotal);
+	crtc->refresh *= 100;
+
+	dprintk("vbe.c: set_par vbemode %d (%dx%d-%d@%d.\n", vbemode, 
+		var->xres, var->yres, var->bits_per_pixel, crtc->refresh/100);
+	memset(&request, 0, sizeof(struct vm86_request));
+	request.regs.eax = 0x4f02;
+	request.regs.ebx = vbemode | (1 << 11) | (1 << 14) | (1 << 15);
+	request.interrupt = 0x10;
+	request.buf_len = sizeof(struct vbecrtcinfo);
+	if (vm86_exec(&request, crtc) ||
+	    request.flags == VM86_FAILED) {
+		kfree(crtc);
+		return -EINVAL;
+	}
+
+	if (modeinfo.visual == 4) {
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+	} else if (modeinfo.visual == 6)
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+
+	memset(&request, 0, sizeof(struct vm86_request));
+	request.regs.eax = 0x4f06;
+	request.regs.ebx = 0;
+	request.regs.ecx = info->var.xres_virtual;
+	request.interrupt = 0x10;
+	request.buf_len = 0;
+	if (vm86_exec(&request, crtc) ||
+	    request.flags == VM86_FAILED) {
+		kfree(crtc);
+		return -EINVAL;
+	}
+	
+	info->fix.line_length = request.regs.ebx;
+	info->fix.ypanstep = 1;
+	info->fix.xpanstep = 1;
+
+	kfree(crtc);
+	return 0;
+}
+		
+static int vbe_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct vm86_request request;
+	struct vbe_par *par = (struct vbe_par *) info->vbe_par;
+	u32 i, best_xres = 0, best_bpp = 0, best_yres = 0;
+	u32 diff_xres = 0xffff, diff_yres = 0xffff, diff_bpp = 0xffff;
+	u32 pitch;
+	int err = 1;
+	unsigned short best_mode = 0xffff;
+
+	if (par->blank_kspc && par->blank)
+		return -EINVAL;
+
+	if (!(par->flags & VBE_FLAGS_INIT))
+		vbe_init_modes(info);
+
+	request.flags = VM86_TEST;
+	if (!(par->flags & VBE_FLAGS_INIT) || !par->num_vbemodes ||
+	    vm86_exec(&request, NULL)) {
+		*var = info->var;
+		return 0;
+	}
+
+	for (i = 0; i < par->num_vbemodes; i++) {
+		if (par->modeinfo[i].bpp >= var->bits_per_pixel &&
+		    par->modeinfo[i].bpp - var->bits_per_pixel < diff_bpp) {
+			best_bpp = par->modeinfo[i].bpp;
+			diff_bpp = best_bpp - var->bits_per_pixel;
+		}
+	}
+	if (best_bpp == 0) {
+		return -EINVAL;
+	}
+
+	for (i = 0; i < par->num_vbemodes; i++) {
+		if (par->modeinfo[i].bpp  == best_bpp &&
+		    par->modeinfo[i].xres >= var->xres &&
+		    par->modeinfo[i].xres - var->xres < diff_xres) {
+			best_xres = par->modeinfo[i].xres;
+			diff_xres = best_xres - var->xres;
+		}
+	}
+	if (best_xres == 0) {
+		return -EINVAL;
+	}
+
+	for (i = 0; i < par->num_vbemodes; i++) {
+		if (par->modeinfo[i].xres == best_xres &&
+		    par->modeinfo[i].bpp  == best_bpp &&
+		    par->modeinfo[i].yres >= var->yres &&
+		    par->modeinfo[i].yres - var->yres < diff_yres) {
+			best_yres = par->modeinfo[i].yres;
+			diff_yres = best_yres - var->yres;
+			best_mode = i;
+		}
+	}
+	if (best_yres == 0) {
+		return -EINVAL;
+	}
+
+	var->xres = best_xres;
+	var->yres = best_yres;
+	var->bits_per_pixel = best_bpp;
+	
+	if (var->xres_virtual < var->xres)
+		var->xres_virtual = var->xres;
+	if (var->yres_virtual < var->yres)
+		var->yres_virtual = var->yres;
+	
+	pitch = var->xres_virtual * var->bits_per_pixel + 31;
+	pitch &= -32;
+	pitch /= 8;
+
+	if (pitch * var->yres_virtual > info->fix.smem_len) {
+		var->yres_virtual = info->fix.smem_len/pitch;
+		if (var->yres_virtual < var->yres) {
+			var->yres_virtual = var->yres;
+			var->xres_virtual = info->fix.smem_len/var->yres_virtual;
+			var->xres_virtual /= 8;
+			if (var->xres_virtual < var->xres)
+				return -EINVAL;
+		}
+	}
+
+	var->vmode = FB_VMODE_NONINTERLACED;
+
+	if (info->monspecs.hfmax && info->monspecs.vfmax &&
+	    info->monspecs.dclkmax && 
+	    info->monspecs.hfmin <= info->monspecs.hfmax &&
+	    info->monspecs.vfmin <= info->monspecs.vfmax &&
+	    info->monspecs.dclkmin <= info->monspecs.dclkmax) {
+		err = fb_validate_mode(var, info);
+	}
+	if (err) { 
+		if (info->monspecs.gtf) 
+			err = vbe_get_gtfmode(var, info, &par->modeinfo[best_mode]); 
+		if (err) 
+			err = vbe_get_dmtmode(var, info);
+	}
+	if (err)
+		return -EINVAL;
+
+	var->red = par->modeinfo[best_mode].red;
+	var->green = par->modeinfo[best_mode].green;
+	var->blue = par->modeinfo[best_mode].blue;
+	var->transp = par->modeinfo[best_mode].transp;
+	if (var->red.length == 0 && var->green.length == 0 &&
+	    var->blue.length == 0) {
+		var->red.length = var->green.length = var->blue.length = 6;
+		var->transp.length = 0;
+		var->transp.offset = 0;
+	}
+	return 0;
+}
+	
+int vbe_init(struct fb_info *info)
+{
+	struct vbe_par *par;
+
+	par = kmalloc(sizeof(struct vbe_par), GFP_KERNEL);
+	if (par == NULL) 
+		return -ENOMEM;
+	memset(par, 0, sizeof(struct vbe_par));
+	par->modes = kmalloc(4096, GFP_KERNEL);
+	if (par->modes == NULL) {
+		kfree(par);
+		return -ENOMEM;
+	}
+	info->vbe_par = par;
+
+	if (!vbe_init_modes(info)) {
+		struct fb_videomode *v;
+
+		v = kmalloc(sizeof(struct fb_videomode) * par->num_modes,
+			    GFP_KERNEL);
+		if (v) {
+			memcpy(v, par->modes, sizeof(struct fb_videomode) * 
+			       par->num_modes);
+			kfree(par->modes);
+			par->modes = v;
+		}
+	}
+
+	par->fbops = info->fbops;
+	vbe_ops = *info->fbops;
+	vbe_ops.fb_check_var =   vbe_check_var;
+	vbe_ops.fb_set_par =     vbe_set_par;
+	vbe_ops.fb_setcolreg =   vbe_setcolreg;
+	vbe_ops.fb_pan_display = vbe_pan_display;
+	vbe_ops.fb_blank =       vbe_blank;
+	info->fbops = &vbe_ops;
+
+	return 0;
+}
+
+void vbe_exit(struct fb_info *info)
+{
+	struct vbe_par *par = (struct vbe_par *) info->vbe_par;
+
+	info->fbops = par->fbops;
+	if (par->modeinfo)
+		kfree(par->modeinfo);
+	fb_destroy_modedb(par->modes);
+	kfree(info->vbe_par);
+}
+
+EXPORT_SYMBOL(vbe_init);
+EXPORT_SYMBOL(vbe_exit);
diff -urN -X dontdiff linux-2.5.67/drivers/video/vbe.h linux-2.5.67-vm86/drivers/video/vbe.h
--- linux-2.5.67/drivers/video/vbe.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-vm86/drivers/video/vbe.h	2003-04-12 08:27:29.000000000 +0200
@@ -0,0 +1,126 @@
+ /*-*- linux-c -*-
+ *  linux/drivers/video/vbe.h -- VBE Generic Functions via VM86
+ *
+ *      Copyright (C) 2003 Antonino Daplas<adaplas@pol.net>
+ *      All Rights Reserved      
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#ifndef __VBE_H__
+#define __VBE_H__
+
+#define VBE_FLAGS_INIT           1
+
+struct vbe_modeinfo {
+	short    vbemode;
+	short    xres;
+	short    yres;
+	char     bpp;
+	short    pitch;
+	char     visual;
+	struct fb_bitfield red;
+	struct fb_bitfield green;
+	struct fb_bitfield blue;
+	struct fb_bitfield transp;
+};
+
+struct vbe_par {
+	char edid[128];
+	struct fb_ops       *fbops;
+	struct fb_videomode *modes;
+	struct vbe_modeinfo *modeinfo;
+	int flags;
+	int num_modes;
+	int num_vbemodes;
+	int caps;
+	int blank;
+	int blank_kspc;
+};
+
+struct vbeinfo {
+	char         sig[4];
+	short        version;
+	unsigned int oemstr;
+	unsigned int caps;
+	unsigned int modelist;
+	short        mem;
+	short        softref;
+	unsigned int vendor;
+	unsigned int product;
+	unsigned int prodrev;
+	char         reserved[222];
+	char         oemdata[256];
+}__attribute__((packed));
+
+struct vbecrtcinfo {
+	short        htotal;
+	short        hsync0;
+	short        hsync1;
+	short        vtotal;
+	short        vsync0;
+	short        vsync1;
+	char         flags;
+	unsigned int pixclock;
+	short        refresh;
+	char         reserved[40];
+}__attribute__((packed));
+
+struct vbepaletteentry {
+	char         blue;
+	char         green;
+	char         red;
+	char         align;
+}__attribute__((packed));
+
+struct vbemode {
+	short        attr;
+	char         wina_attr;
+	char         winb_attr;
+	short        win_gran;
+	short        win_size;
+	short        wina_segment;
+	short        wingb_segment;
+	int          winfx_ptr;
+	short        bytes_per_scanline;
+	short        xres;
+	short        yres;
+	char         charwidth;
+	char         charheight;
+	char         plane_nr;
+	char         bpp;
+	char         bank_nr;
+	char         mem_model;
+	char         bank_size;
+	char         imagepg_nr;
+	char         reserved;
+	char         redmask;
+	char         redfield;
+	char         greenmask;
+	char         greenfield;
+	char         bluemask;
+	char         bluefield;
+	char         reserved_mask;
+	char         reserved_field;
+	char         dc_modeinfo;
+	int          smem_start;
+	int          reserved1;
+	short        reserved2;
+	short        pitch;
+	char         imagebank_nr;
+	char         imagelinear_nr;
+	char         redlen;
+	char         redoffset;
+	char         greenlen;
+	char         greenoffset;
+	char         bluelen;
+	char         blueoffset;
+	char         reserved_len;
+	char         reserved_offset;
+	int          maxpixclock;
+	char         reserved3[189];
+}__attribute__((packed));
+
+#endif /* __VBE_H__ */
diff -urN -X dontdiff linux-2.5.67/drivers/video/vesafb.c linux-2.5.67-vm86/drivers/video/vesafb.c
--- linux-2.5.67/drivers/video/vesafb.c	2003-03-14 10:31:14.000000000 +0100
+++ linux-2.5.67-vm86/drivers/video/vesafb.c	2003-04-12 08:27:29.000000000 +0200
@@ -356,6 +356,7 @@
 	fb_info.flags = FBINFO_FLAG_DEFAULT;
 
 	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
+	vbe_init(&fb_info);
 
 	if (register_framebuffer(&fb_info)<0)
 		return -EINVAL;
diff -urN -X dontdiff linux-2.5.67/include/linux/fb.h linux-2.5.67-vm86/include/linux/fb.h
--- linux-2.5.67/include/linux/fb.h	2003-04-07 19:55:38.000000000 +0200
+++ linux-2.5.67-vm86/include/linux/fb.h	2003-04-12 08:27:29.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/tty.h>
 #include <asm/types.h>
 #include <asm/io.h>
+#include <linux/workqueue.h>
 
 /* Definitions of frame buffers						*/
 
@@ -309,8 +310,9 @@
 #define FB_CUR_SETHOT   0x04
 #define FB_CUR_SETCMAP  0x08
 #define FB_CUR_SETSHAPE 0x10
-#define FB_CUR_SETSIZE	0x20
-#define FB_CUR_SETDEST	0x40
+#define FB_CUR_SETDEST	0x20
+#define FB_CUR_SETSIZE	0x40
+#define FB_CUR_SETFLASH 0x80
 #define FB_CUR_SETALL   0xFF
 
 struct fbcurpos {
@@ -318,7 +320,7 @@
 };
 
 struct fb_cursor {
-	__u16 set;		/* what to set */
+	__u32 set;		/* what to set */
 	__u16 enable;		/* cursor on/off */
 	__u16 rop;		/* bitop operation */
 	char *mask;		/* cursor mask bits */
@@ -327,24 +329,25 @@
 	struct fb_image	image;	/* Cursor image */
 };
 
-#define FB_PIXMAP_DEFAULT 1     /* used internally by fbcon */
-#define FB_PIXMAP_SYSTEM  2     /* memory is in system RAM  */
-#define FB_PIXMAP_IO      4     /* memory is iomapped       */
-#define FB_PIXMAP_SYNC    256   /* set if GPU can DMA       */
+#define FB_PIXMAP_DEFAULT 1
+#define FB_PIXMAP_SYSTEM  2
+#define FB_PIXMAP_IO      3
+#define FB_PIXMAP_SYNC    (1 << 16)
 
 struct fb_pixmap {
-        __u8  *addr;                      /* pointer to memory             */  
-	__u32 size;                       /* size of buffer in bytes       */
-	__u32 offset;                     /* current offset to buffer      */
-	__u32 buf_align;                  /* byte alignment of each bitmap */
-	__u32 scan_align;                 /* alignment per scanline        */
-	__u32 flags;                      /* see FB_PIXMAP_*               */
-	void (*outbuf)(u8 dst, u8 *addr); /* access methods                */
-	u8   (*inbuf) (u8 *addr);
+	__u8  *addr;
+	__u32 size;
+	__u32 offset;
+	__u32 scan_align;
+	__u32 buf_align;
+	__u32 flags;
+	void (*outbuf)(u8 val, u8 *dst);
+	__u8 (*inbuf) (u8 *dst);
 	unsigned long lock_flags;         /* flags for locking             */
-	spinlock_t lock;                  /* spinlock                      */
-	atomic_t count;
+	spinlock_t    lock;
+	atomic_t      count;
 };
+
 #ifdef __KERNEL__
 
 #include <linux/fs.h>
@@ -407,12 +410,18 @@
    struct fb_monspecs monspecs;         /* Current Monitor specs */
    struct fb_cursor cursor;		/* Current cursor */	
    struct fb_cmap cmap;                 /* Current cmap */
-   struct fb_pixmap pixmap;	        /* Current pixmap */
+   struct fb_pixmap pixmap;
+   struct work_struct queue;             
+   struct work_struct blank_queue;
    struct fb_ops *fbops;
    char *screen_base;                   /* Virtual address */
    struct vc_data *display_fg;		/* Console visible on this display */
    int currcon;				/* Current VC. */	
+   int blank;                           /* current fb_blank flag */
+   int blank_kspc;                      /* is fb_blank command from kernel space */
    void *pseudo_palette;                /* Fake palette of 16 colors */ 
+   void *fbcon_priv;                    /* console related private data */
+   void *vbe_par;                       /* VBE related private_data */
    /* From here on everything is device dependent */
    void *par;	
 };
@@ -491,7 +500,15 @@
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 
+/* drivers/video/modedb.c */
+#define VESA_MODEDB_SIZE 34
+extern const struct fb_videomode vesa_modes[];
+
 /* drivers/video/fbmon.c */
+#ifdef CONFIG_PCI
+#include <linux/pci.h>
+#endif
+
 #define FB_MAXTIMINGS       0
 #define FB_VSYNCTIMINGS     1
 #define FB_HSYNCTIMINGS     2
@@ -505,6 +522,17 @@
 		       struct fb_info *info);
 extern int fb_validate_mode(struct fb_var_screeninfo *var,
 			    struct fb_info *info);
+extern int parse_edid(unsigned char *edid, struct fb_var_screeninfo *var);
+extern char *get_EDID(struct pci_dev *pdev);
+extern void show_edid(unsigned char *edid);
+extern int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs);
+extern struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize);
+extern void fb_destroy_modedb(struct fb_videomode *modedb);
+
+
+/* drivers/video/vbe.c */
+extern int  vbe_init(struct fb_info *info);
+extern void vbe_exit(struct fb_info *info);
 
 /* drivers/video/fbcmap.c */
 extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vm86.diff"

diff -urN -X dontdiff linux-2.5.67/drivers/char/Kconfig linux-2.5.67-vm86/drivers/char/Kconfig
--- linux-2.5.67/drivers/char/Kconfig	2003-03-21 18:23:31.000000000 +0100
+++ linux-2.5.67-vm86/drivers/char/Kconfig	2003-04-14 19:25:52.000000000 +0200
+config VM86
+	bool "VM86 Interface"
+	depends on X86
+	help
+	  The VM86 interface is an interface between the kernel and
+	  a user-mode daemon (vm86d) that provides 16-bit BIOS services.
+	  At the moment, this is only used for the VESA framebuffer
+	  driver as a way to change refresh-rates and get information
+	  from the monitor and the card. You also need the user-mode
+	  daemon at http://i810fb.sourceforge.net,
+
 endmenu
 
diff -urN -X dontdiff linux-2.5.67/drivers/char/Makefile linux-2.5.67-vm86/drivers/char/Makefile
--- linux-2.5.67/drivers/char/Makefile	2003-04-07 19:55:37.000000000 +0200
+++ linux-2.5.67-vm86/drivers/char/Makefile	2003-04-12 08:27:33.000000000 +0200
@@ -78,6 +78,7 @@
 obj-$(CONFIG_IPMI_HANDLER) += ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
+obj-$(CONFIG_VM86) += vm86.o
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
diff -urN -X dontdiff linux-2.5.67/drivers/char/vm86.c linux-2.5.67-vm86/drivers/char/vm86.c
--- linux-2.5.67/drivers/char/vm86.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-vm86/drivers/char/vm86.c	2003-04-12 17:28:52.000000000 +0200
@@ -0,0 +1,271 @@
+/*
+ *     VM86 Kernel-User interface
+ *
+ *     Copyright (C) 2003 Antonino Daplas
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/vm86.h>
+#include <asm/semaphore.h>
+
+static struct vm86_info {
+	struct vm86_request request;
+	struct fasync_struct *async_queue;
+	int event;
+	int enabled;
+	int count;
+	int error;
+	int poll_mask;
+	void *buffer;
+} *info = NULL;
+
+static DECLARE_WAIT_QUEUE_HEAD(vm86_wait);
+static DECLARE_WAIT_QUEUE_HEAD(vm86_exec_wait);
+static DECLARE_MUTEX(vm86_sem);
+
+/* File operations */
+static int vm86_fasync(int fd, struct file *file, int on)
+{
+	return fasync_helper(fd, file, on, &info->async_queue);
+}
+
+static int vm86_open(struct inode *inode, struct file *file)
+{
+	if (info->count)
+		return -EINVAL;
+	info->count++;
+	info->enabled = 1;
+	return 0;
+}
+
+static int vm86_release(struct inode *inode, struct file *file)
+{
+	if (!info->count)
+		return -EINVAL;
+	info->count--;
+	if (file->f_flags & FASYNC) 
+		vm86_fasync(-1, file, 0); 
+	memset(info, 0, sizeof(struct vm86_info));
+	return 0;
+}
+
+static ssize_t vm86_read(struct file *file, char *buf, size_t count, 
+			 loff_t *ppos)
+{
+	int retval = 0, c = sizeof(struct vm86_request);
+	DECLARE_WAITQUEUE(wait, current);
+
+	if (!info->enabled)
+		return 0;
+	
+	add_wait_queue(&vm86_wait, &wait);
+	while (info->poll_mask != (POLLIN | POLLRDNORM)) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		retval = -EWOULDBLOCK;
+		if (file->f_flags & O_NDELAY) {
+			break;
+		}
+		retval = -ERESTARTSYS;
+		if (signal_pending(current)) {
+			break;
+		}
+		schedule();
+		retval = 0;
+	}
+	info->poll_mask = 0;
+	remove_wait_queue(&vm86_wait, &wait);
+	current->state = TASK_RUNNING;
+	if (retval) {
+		info->event = 0;
+		info->error = 1;
+		return 0;
+	}
+	if (count) {
+		int i;
+
+		if (copy_to_user(buf, &info->request, 
+				 sizeof(struct vm86_request))) {
+			info->event = 0;
+			info->error = 1;
+			return 0;
+		}
+		if (info->request.buf_len) {
+			i = copy_to_user(buf + sizeof(struct vm86_request), 
+					 info->buffer,
+					 info->request.buf_len);
+			if (i) {
+				info->event = 0;
+				info->error = 1;
+				return 0;
+			}
+			c += info->request.buf_len;
+		}
+	}
+	info->poll_mask = POLLOUT | POLLRDNORM;
+	return c;
+}
+
+static ssize_t vm86_write(struct file *file, const char *buf, 
+			  size_t count, loff_t *ppos)
+{
+	int retval, c = 0;
+	DECLARE_WAITQUEUE(wait, current);
+
+	if (info->poll_mask != (POLLOUT | POLLRDNORM) ||
+	    !info->enabled) {
+		info->event = 0;
+		info->error = 1;
+		return 0;
+	}
+
+	if (!info->enabled)
+		return 0;
+	
+	add_wait_queue(&vm86_wait, &wait);
+	while (info->poll_mask != (POLLOUT | POLLRDNORM)) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		retval = -EWOULDBLOCK;
+		if (file->f_flags & O_NDELAY) {
+			break;
+		}
+		retval = -ERESTARTSYS;
+		if (signal_pending(current)) {
+			break;
+		}
+		schedule();
+		retval = 0;
+	}
+	info->poll_mask = 0;
+	remove_wait_queue(&vm86_wait, &wait);
+	current->state = TASK_RUNNING;
+
+	if (count) {
+		info->error = copy_from_user(&info->request, buf, 
+					     sizeof(struct vm86_request));
+		if (!info->error) {
+			c = sizeof(struct vm86_request);
+			if (info->request.buf_len) {
+				info->error = 
+				  copy_from_user(info->buffer, buf + c, 
+						 info->request.buf_len);
+				if (!info->error)
+					c += info->request.buf_len; 
+			}
+		}
+	}
+	info->event = 0;
+	return c;
+}
+
+
+static unsigned int vm86_poll(struct file *file, poll_table *wait)
+{
+	poll_wait(file, &vm86_wait, wait);
+
+	return info->poll_mask;
+}
+
+static struct file_operations vm86_ops = {
+	.owner =    THIS_MODULE,
+	.read =     vm86_read,
+	.write =    vm86_write,
+	.open =     vm86_open,
+	.release =  vm86_release,
+	.fasync =   vm86_fasync,
+	.poll =     vm86_poll,
+};
+
+static struct miscdevice vm86_dev = {
+	VM86_MINOR,
+	"vm86",
+	&vm86_ops
+};
+
+/**
+ * vm86_exec - execute instructions
+ * @request: pointer to instruction request data
+ * @buffer: 1024-byte min sized buffer for extra data
+ *
+ * ON ENTRY: @buffer must point to a valid buffer (1024 bytes).
+ * ON EXIT: @request contains results of x86 instructions.  @request->buffer
+ *          may contain additional data, depending on the code.  Check 
+ *          @request->buf_len. 
+ * WARNING:
+ * Will sleep
+ */
+int vm86_exec(struct vm86_request *request, void *buffer)
+{
+	int len;
+	unsigned long timeout;
+	static int next_tick = 3 * HZ;
+
+	if (!info || !info->enabled)
+		return -ENODEV;
+
+	if (request->flags & VM86_TEST)
+		return 0;
+
+	len = sizeof(struct vm86_request) + request->buf_len;
+	if (len > 1024)
+		return -EINVAL;
+
+	down(&vm86_sem);
+
+	info->request = *request;
+	info->buffer = buffer;
+	info->error = 0;
+	info->event = 1;
+	info->poll_mask = POLLIN | POLLRDNORM;
+	kill_fasync(&info->async_queue, SIGIO, POLL_IN);  /* send signal */
+
+	wake_up(&vm86_wait);               
+
+	while (info->event)
+		yield();
+
+	info->request.flags = (info->error) ? 
+		VM86_FAILED : VM86_SUCCESS;
+	*request = info->request;
+
+	up(&vm86_sem);
+
+	return 0;
+}
+
+static int __init vm86_init(void)
+{
+	
+	info = kmalloc(sizeof(struct vm86_info), GFP_KERNEL);
+	if (info == NULL)
+		return -ENOMEM;
+	memset(info, 0, sizeof(struct vm86_info));
+	  
+	if (misc_register(&vm86_dev)) {
+		kfree(info);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static void __exit vm86_exit(void)
+{
+	misc_deregister(&vm86_dev);
+	kfree(info);
+}
+
+module_init(vm86_init);
+module_exit(vm86_exit);
+
+EXPORT_SYMBOL(vm86_exec);
diff -urN -X dontdiff linux-2.5.67/include/linux/miscdevice.h linux-2.5.67-vm86/include/linux/miscdevice.h
--- linux-2.5.67/include/linux/miscdevice.h	2003-01-18 06:35:12.000000000 +0100
+++ linux-2.5.67-vm86/include/linux/miscdevice.h	2003-04-12 08:27:33.000000000 +0200
@@ -35,6 +35,7 @@
 #define SGI_USEMACLONE	     151
 
 #define TUN_MINOR	     200
+#define VM86_MINOR           201
 
 extern int misc_init(void);
 
diff -urN -X dontdiff linux-2.5.67/include/linux/vm86.h linux-2.5.67-vm86/include/linux/vm86.h
--- linux-2.5.67/include/linux/vm86.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.67-vm86/include/linux/vm86.h	2003-04-12 08:27:33.000000000 +0200
@@ -0,0 +1,47 @@
+#ifndef __VM86_H__
+#define __VM86_H__
+
+/* Based on LRMI */
+struct user_vm86_regs {
+	unsigned int edi;
+	unsigned int esi;
+	unsigned int ebp;
+	unsigned int reserved;
+	unsigned int ebx;
+	unsigned int edx;
+	unsigned int ecx;
+	unsigned int eax;
+	unsigned short int flags;
+	unsigned short int es;
+	unsigned short int ds;
+	unsigned short int fs;
+	unsigned short int gs;
+	unsigned short int ip;
+	unsigned short int cs;
+	unsigned short int sp;
+	unsigned short int ss;
+};
+
+/* flags after vm86_exec() */
+#define VM86_SUCCESS          0
+#define VM86_UNDEFINED        1
+#define VM86_FAILED           2
+#define VM86_TEST             4
+
+struct vm86_request {
+	struct user_vm86_regs regs;
+	unsigned int flags;                 /* flags                       */
+	unsigned int type;                  /* code type                   */
+	unsigned int interrupt;             /* interrupt service           */
+	unsigned int buf_len;               /* extra buffers, if any       */
+	unsigned short bus;                 /* bus, device, function no.   */
+};
+
+#ifdef __KERNEL__
+#if defined(CONFIG_VM86) 
+extern int vm86_exec(struct vm86_request *request, void *buffer);
+#else
+#define vm86_exec(x, y) ( -EINVAL ) 
+#endif
+#endif /* __KERNEL__ */
+#endif /* __VM86_H_ */

--/04w6evG8XlLl3ft--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
