From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Tue, 3 Jul 2007 22:36:27 +0200
Message-ID: <200707032236.27461.hjk@linutronix.de>
References: <200707031607.08511.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5p6v-0008C9-L5 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 13:36:33 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5p6s-0005gw-S3
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 13:36:33 -0700
In-Reply-To: <200707031607.08511.hjk@linutronix.de>
Content-Disposition: inline
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
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Thomas Gleixner <tglx@linutronix.de>, Clemens Koller <clemens.koller@anagramm.de>, linux-fbdev-devel@lists.sourceforge.net, Paulo Marques <pmarques@grupopie.com>, Lothar Wassmann <LW@karo-electronics.de>

All right, next iteration.

Changes:
If cpuid says it's not a PXA27x, palette format is forced to 0 (which
is the old 16-bit RGB565 format), and the driver will not access LCCR4.

Signed-off-by: Hans J. Koch <hjk@linutronix.de>

Index: linux-2.6.22-rc/include/asm-arm/arch-pxa/pxa-regs.h
===================================================================
--- linux-2.6.22-rc.orig/include/asm-arm/arch-pxa/pxa-regs.h	2007-07-03 22:27:19.000000000 +0200
+++ linux-2.6.22-rc/include/asm-arm/arch-pxa/pxa-regs.h	2007-07-03 22:28:22.000000000 +0200
@@ -1843,6 +1843,7 @@
 #define LCCR1		__REG(0x44000004)  /* LCD Controller Control Register 1 */
 #define LCCR2		__REG(0x44000008)  /* LCD Controller Control Register 2 */
 #define LCCR3		__REG(0x4400000C)  /* LCD Controller Control Register 3 */
+#define LCCR4		__REG(0x44000010)  /* LCD Controller Control Register 4 */
 #define DFBR0		__REG(0x44000020)  /* DMA Channel 0 Frame Branch Register */
 #define DFBR1		__REG(0x44000024)  /* DMA Channel 1 Frame Branch Register */
 #define LCSR		__REG(0x44000038)  /* LCD Controller Status Register */
@@ -1856,6 +1857,16 @@
 #define LCCR3_8BPP (3 << 24)
 #define LCCR3_16BPP (4 << 24)
 
+#define LCCR3_PDFOR_0 (0 << 30)
+#define LCCR3_PDFOR_1 (1 << 30)
+#define LCCR3_PDFOR_2 (2 << 30)
+#define LCCR3_PDFOR_3 (3 << 30)
+
+#define LCCR4_PAL_FOR_0 (0 << 15)
+#define LCCR4_PAL_FOR_1 (1 << 15)
+#define LCCR4_PAL_FOR_2 (2 << 15)
+#define LCCR4_PAL_FOR_MASK (3 << 15)
+
 #define FDADR0		__REG(0x44000200)  /* DMA Channel 0 Frame Descriptor Address Register */
 #define FSADR0		__REG(0x44000204)  /* DMA Channel 0 Frame Source Address Register */
 #define FIDR0		__REG(0x44000208)  /* DMA Channel 0 Frame ID Register */
Index: linux-2.6.22-rc/drivers/video/pxafb.c
===================================================================
--- linux-2.6.22-rc.orig/drivers/video/pxafb.c	2007-07-03 22:27:19.000000000 +0200
+++ linux-2.6.22-rc/drivers/video/pxafb.c	2007-07-03 22:28:22.000000000 +0200
@@ -106,20 +106,38 @@
 		       u_int trans, struct fb_info *info)
 {
 	struct pxafb_info *fbi = (struct pxafb_info *)info;
-	u_int val, ret = 1;
+	u_int val;
 
-	if (regno < fbi->palette_size) {
-		if (fbi->fb.var.grayscale) {
-			val = ((blue >> 8) & 0x00ff);
-		} else {
-			val  = ((red   >>  0) & 0xf800);
-			val |= ((green >>  5) & 0x07e0);
-			val |= ((blue  >> 11) & 0x001f);
-		}
+	if (regno >= fbi->palette_size)
+		return 1;
+
+	if (fbi->fb.var.grayscale) {
+		fbi->palette_cpu[regno] = ((blue >> 8) & 0x00ff);
+		return 0;
+	}
+
+	switch (fbi->lccr4 & LCCR4_PAL_FOR_MASK) {
+	case LCCR4_PAL_FOR_0:
+		val  = ((red   >>  0) & 0xf800);
+		val |= ((green >>  5) & 0x07e0);
+		val |= ((blue  >> 11) & 0x001f);
 		fbi->palette_cpu[regno] = val;
-		ret = 0;
+		break;
+	case LCCR4_PAL_FOR_1:
+		val  = ((red   << 8) & 0x00f80000);
+		val |= ((green >> 0) & 0x0000fc00);
+		val |= ((blue  >> 8) & 0x000000f8);
+		((u32*)(fbi->palette_cpu))[regno] = val;
+		break;
+	case LCCR4_PAL_FOR_2:
+		val  = ((red   << 8) & 0x00fc0000);
+		val |= ((green >> 0) & 0x0000fc00);
+		val |= ((blue  >> 8) & 0x000000fc);
+		((u32*)(fbi->palette_cpu))[regno] = val;
+		break;
 	}
-	return ret;
+
+	return 0;
 }
 
 static int
@@ -361,7 +379,10 @@
 	else
 		fbi->palette_size = var->bits_per_pixel == 1 ? 4 : 1 << var->bits_per_pixel;
 
-	palette_mem_size = fbi->palette_size * sizeof(u16);
+	if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) == LCCR4_PAL_FOR_0)
+		palette_mem_size = fbi->palette_size * sizeof(u16);
+	else
+		palette_mem_size = fbi->palette_size * sizeof(u32);
 
 	pr_debug("pxafb: palette_mem_size = 0x%08lx\n", palette_mem_size);
 
@@ -676,7 +697,13 @@
 
 	fbi->dmadesc_palette_cpu->fsadr = fbi->palette_dma;
 	fbi->dmadesc_palette_cpu->fidr  = 0;
-	fbi->dmadesc_palette_cpu->ldcmd = (fbi->palette_size * 2) | LDCMD_PAL;
+	if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) == LCCR4_PAL_FOR_0)
+		fbi->dmadesc_palette_cpu->ldcmd = fbi->palette_size *
+							sizeof(u16);
+	else
+		fbi->dmadesc_palette_cpu->ldcmd = fbi->palette_size *
+							sizeof(u32);
+	fbi->dmadesc_palette_cpu->ldcmd |= LDCMD_PAL;
 
 	if (var->bits_per_pixel == 16) {
 		/* palette shouldn't be loaded in true-color mode */
@@ -715,6 +742,15 @@
 	fbi->reg_lccr1 = new_regs.lccr1;
 	fbi->reg_lccr2 = new_regs.lccr2;
 	fbi->reg_lccr3 = new_regs.lccr3;
+
+	if (((read_cpuid(CPUID_ID) >> 4) & 0x1f) == 0x11) {
+		/* PXA 27x only */
+		fbi->reg_lccr4 = LCCR4 & (~LCCR4_PAL_FOR_MASK);
+		fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
+	}
+	else {
+		fbi->reg_lccr4 = 0;
+	}
 	set_hsync_time(fbi, pcd);
 	local_irq_restore(flags);
 
@@ -806,6 +842,8 @@
 	pxa_set_cken(CKEN_LCD, 1);
 
 	/* Sequence from 11.7.10 */
+	if (((read_cpuid(CPUID_ID) >> 4) & 0x1f) == 0x11)
+		LCCR4 = fbi->reg_lccr4; /* PXA 27x only */
 	LCCR3 = fbi->reg_lccr3;
 	LCCR2 = fbi->reg_lccr2;
 	LCCR1 = fbi->reg_lccr1;
@@ -1090,10 +1128,13 @@
 		 * dma_writecombine_mmap)
 		 */
 		fbi->fb.fix.smem_start = fbi->screen_dma;
-
 		fbi->palette_size = fbi->fb.var.bits_per_pixel == 8 ? 256 : 16;
 
-		palette_mem_size = fbi->palette_size * sizeof(u16);
+		if ((fbi->lccr4 & LCCR4_PAL_FOR_MASK) == LCCR4_PAL_FOR_0)
+			palette_mem_size = fbi->palette_size * sizeof(u16);
+		else
+			palette_mem_size = fbi->palette_size * sizeof(u32);
+
 		pr_debug("pxafb: palette_mem_size = 0x%08lx\n", palette_mem_size);
 
 		fbi->palette_cpu = (u16 *)(fbi->map_cpu + PAGE_SIZE - palette_mem_size);
@@ -1150,6 +1191,11 @@
 
 	fbi->lccr0			= inf->lccr0;
 	fbi->lccr3			= inf->lccr3;
+	if (((read_cpuid(CPUID_ID) >> 4) & 0x1f) == 0x11)
+		fbi->lccr4 = inf->lccr4; /* PXA27x only */
+	else
+		fbi->lccr4 = 0;
+
 	fbi->state			= C_STARTUP;
 	fbi->task_state			= (u_char)-1;
 
Index: linux-2.6.22-rc/drivers/video/pxafb.h
===================================================================
--- linux-2.6.22-rc.orig/drivers/video/pxafb.h	2007-07-03 22:27:19.000000000 +0200
+++ linux-2.6.22-rc/drivers/video/pxafb.h	2007-07-03 22:28:22.000000000 +0200
@@ -70,6 +70,7 @@
 
 	u_int			lccr0;
 	u_int			lccr3;
+	u_int			lccr4;
 	u_int			cmap_inverse:1,
 				cmap_static:1,
 				unused:30;
@@ -78,6 +79,7 @@
 	u_int			reg_lccr1;
 	u_int			reg_lccr2;
 	u_int			reg_lccr3;
+	u_int			reg_lccr4;
 
 	unsigned long	hsync_time;
 
Index: linux-2.6.22-rc/include/asm-arm/arch-pxa/pxafb.h
===================================================================
--- linux-2.6.22-rc.orig/include/asm-arm/arch-pxa/pxafb.h	2007-07-03 22:27:19.000000000 +0200
+++ linux-2.6.22-rc/include/asm-arm/arch-pxa/pxafb.h	2007-07-03 22:28:22.000000000 +0200
@@ -70,7 +70,12 @@
 	 *      LCCR3_HSP, LCCR3_VSP, LCCR0_Pcd(x), LCCR3_Bpp
 	 */
 	u_int		lccr3;
-
+	/* The following should be defined in LCCR4
+	 *	LCCR4_PAL_FOR_0 or LCCR4_PAL_FOR_1 or LCCR4_PAL_FOR_2
+	 *
+	 * All other bits in LCCR4 should be left alone.
+	 */
+	u_int		lccr4;
 	void (*pxafb_backlight_power)(int);
 	void (*pxafb_lcd_power)(int, struct fb_var_screeninfo *);
 



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
