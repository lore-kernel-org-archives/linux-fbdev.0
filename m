From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [PATCH] Make vesafb usable with Matrox Parhelia & Px50
Date: Mon, 29 Sep 2003 19:19:37 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030929171937.GA4920@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A41jF-0007Qu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 10:22:33 -0700
Received: from [147.32.240.58] (helo=vana.vc.cvut.cz ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1A41jE-0004Jr-EP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Sep 2003 10:22:32 -0700
Received: from vana.vc.cvut.cz (smmsp@localhost [127.0.0.1])
	by vana.vc.cvut.cz (8.12.10/8.12.10/Debian-4) with ESMTP id h8THJcwk005649
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 19:19:38 +0200
Received: (from root@localhost)
	by vana.vc.cvut.cz (8.12.10/8.12.10/Debian-4) id h8THJcqw005646
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Sep 2003 19:19:38 +0200
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,
  in the case that you are unhappy owner of Matrox Parhelia card, patch below
makes vesafb driver in the kernel able to drive card. Problem is that card is
not VGA compatible beast, and so you must use video=vesafb:pmipal. But you cannot
use pmipal because (1) code which checks whether BIOS requires MMIO regions
or not is broken and (2) code does not support MMIO regions.

  Patch below (for 2.6.0-test6) fixes both problems. VESA interface has strange
idea about possible line lengths, but maybe that it is hardware limitation...

vesafb: framebuffer at 0xcc000000, mapped to 0xe080a000, size 16384k
vesafb: mode is 1280x1024x8, linelength=2048, pages=6
vesafb: protected mode interface info at c000:7960
vesafb: pmi: set display start = c00c7ac3, set palette = c00c7bed
vesafb: pmi: ports =
vesafb: MMIO 0xC9800000/8192 mapped at e180b000
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device

Patch is also available at ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/vesafb-parhelia.gz.

						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz

diff -urdN linux/drivers/video/vesafb.c linux/drivers/video/vesafb.c
--- linux/drivers/video/vesafb.c	2003-09-28 20:42:06.000000000 +0200
+++ linux/drivers/video/vesafb.c	2003-09-29 18:53:59.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #ifdef __i386__
 #include <video/edid.h>
+#include <asm/desc.h>
 #endif
 #include <asm/io.h>
 #include <asm/mtrr.h>
@@ -79,13 +80,18 @@
 	offset = (var->yoffset * info->fix.line_length + var->xoffset) / 4;
 
         __asm__ __volatile__(
-                "call *(%%edi)"
+		"pushl %%es\n\t"
+		"pushl %5\n\t"
+		"popl %%es\n\t"
+                "call *%%edi\n\t"
+		"popl %%es\n\t"
                 : /* no return value */
                 : "a" (0x4f07),         /* EAX */
                   "b" (0),              /* EBX */
                   "c" (offset),         /* ECX */
                   "d" (offset >> 16),   /* EDX */
-                  "D" (&pmi_start));    /* EDI */
+                  "D" (pmi_start),      /* EDI */
+		  "i" (GDT_ENTRY_VGABIOS_BASE*8));
 #endif
 	return 0;
 }
@@ -101,14 +107,19 @@
 		entry.blue  = blue  >> 10;
 		entry.pad   = 0;
 	        __asm__ __volatile__(
-                "call *(%%esi)"
+		"pushl %%ds\n\t"
+		"pushl %6\n\t"
+		"popl %%ds\n\t"
+                "call *%%esi\n\t"
+		"popl %%ds\n\t"
                 : /* no return value */
                 : "a" (0x4f09),         /* EAX */
                   "b" (0),              /* EBX */
                   "c" (1),              /* ECX */
                   "d" (regno),          /* EDX */
                   "D" (&entry),         /* EDI */
-                  "S" (&pmi_pal));      /* ESI */
+                  "S" (pmi_pal),        /* ESI */
+		  "i" (GDT_ENTRY_VGABIOS_BASE*8));
 	} else {
 		/* without protected mode interface, try VGA registers... */
 		outb_p(regno,       dac_reg);
@@ -218,6 +229,7 @@
 {
 	int video_cmap_len;
 	int i;
+	int cpunr;
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENXIO;
@@ -273,6 +285,13 @@
 	if (screen_info.vesapm_seg < 0xc000)
 		ypan = pmi_setpal = 0; /* not available or some DOS TSR ... */
 
+	for (cpunr = 0; cpunr < NR_CPUS; cpunr++) {
+		/* 
+		 * Create loadable but inaccessible segment - you can load it into the segment
+		 * register, but you cannot access even single byte through this.
+		 */
+		_set_tssldt_desc(&cpu_gdt_table[cpunr][GDT_ENTRY_VGABIOS_BASE], 0, 0xFFFF, 0x97);
+	}
 	if (ypan || pmi_setpal) {
 		pmi_base  = (unsigned short*)phys_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
 		pmi_start = (void*)((char*)pmi_base + pmi_base[1]);
@@ -280,18 +299,36 @@
 		printk(KERN_INFO "vesafb: pmi: set display start = %p, set palette = %p\n",pmi_start,pmi_pal);
 		if (pmi_base[3]) {
 			printk(KERN_INFO "vesafb: pmi: ports = ");
-				for (i = pmi_base[3]/2; pmi_base[i] != 0xffff; i++)
-					printk("%x ",pmi_base[i]);
+			for (i = pmi_base[3]/2; pmi_base[i] != 0xffff; i++)
+				printk("%x ",pmi_base[i]);
 			printk("\n");
+			i++;
 			if (pmi_base[i] != 0xffff) {
-				/*
-				 * memory areas not supported (yet?)
-				 *
-				 * Rules are: we have to set up a descriptor for the requested
-				 * memory area and pass it in the ES register to the BIOS function.
-				 */
-				printk(KERN_INFO "vesafb: can't handle memory requests, pmi disabled\n");
-				ypan = pmi_setpal = 0;
+				unsigned long base = pmi_base[i] | (pmi_base[i+1] << 16);
+				unsigned int size = pmi_base[i+2];
+				void* mmio;
+
+				i += 3;
+				mmio = ioremap(base, size);
+				if (!mmio) {
+					printk(KERN_INFO "vesafb: can't get access to MMIO at 0x%lX/%u. PMI disabled\n", base, size);
+					ypan = pmi_setpal = 0;
+				} else {
+					printk(KERN_INFO "vesafb: MMIO 0x%lX/%u mapped at %p\n", base, size, mmio);
+					for (cpunr = 0; cpunr < NR_CPUS; cpunr++) {
+						_set_tssldt_desc(&cpu_gdt_table[cpunr][GDT_ENTRY_VGABIOS_BASE], mmio, size-1, 0x93);
+					}
+					if (pmi_base[i] != 0xffff) {
+						/*
+						 * memory areas
+						 *
+						 * Rules are: we have to set up a descriptor for the requested
+						 * memory area and pass it in the ES register to the BIOS function.
+						 */
+						printk(KERN_INFO "vesafb: can't handle memory requests, pmi disabled\n");
+						ypan = pmi_setpal = 0;
+					}
+				}
 			}
 		}
 	}
diff -urdN linux/include/asm-i386/segment.h linux/include/asm-i386/segment.h
--- linux/include/asm-i386/segment.h	2003-09-28 20:43:29.000000000 +0200
+++ linux/include/asm-i386/segment.h	2003-09-29 18:00:48.000000000 +0200
@@ -37,8 +37,8 @@
  *  23 - APM BIOS support
  *  24 - APM BIOS support
  *  25 - APM BIOS support 
+ *  26 - VGA BIOS support (MMIO)
  *
- *  26 - unused
  *  27 - unused
  *  28 - unused
  *  29 - unused
@@ -70,6 +70,7 @@
 
 #define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 6)
 #define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
+#define GDT_ENTRY_VGABIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 14)
 
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
