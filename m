From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/7] geodefb:  Add Geode framebuffer driver
Date: Thu, 17 Feb 2005 20:45:32 +0800
Message-ID: <200502172045.32088.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1l59-0000ii-BK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:48:35 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1l57-0008V3-Ng
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:48:35 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B9A04140134C
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 12:48:27 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, David Vrabel <dvrabel@arcom.com>

  Attached is a patch (against 2.6.10) for a framebuffer driver for the
  Geode family of processors.  It does not use AMD's horrible Durango API.
   It is, however, rather feature incomplete at the moment.

          * Only Geode GX1 (with CS5530 companion chip) is supported.
          * Tested resolutions: 640x480 to 1280x1024.
          * Supported bit depths: 8 bit palette, 16 bit RGB 5-6-5.
          * CRT output only.
          * No accelerated features.
          * Compression is not enabled.
          * flat panel support (panel=<x>x<y> option). (Only one 640x480 panel
            has been tested though.)
          * blank function for display blanking/powersaving.
          * crt=<n> option to enable/disable the CRT output.

Signed-off-by: David Vrabel <dvrabel@arcom.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Kconfig              |    2
 Makefile             |    1
 geode/Kconfig        |   29 ++++
 geode/Makefile       |    5
 geode/display_gx1.c  |  213 ++++++++++++++++++++++++++++++
 geode/display_gx1.h  |  154 +++++++++++++++++++++
 geode/geodefb.h      |   39 +++++
 geode/gx1fb_core.c   |  359 +++++++++++++++++++++++++++++++++++++++++++++++++++
 geode/video_cs5530.c |  194 +++++++++++++++++++++++++++
 geode/video_cs5530.h |   75 ++++++++++
 10 files changed, 1071 insertions(+)

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-02-16 08:18:11 +08:00
+++ b/drivers/video/Kconfig	2005-02-15 18:28:19 +08:00
@@ -1179,6 +1179,8 @@
 	bool "Au1100 LCD Driver"
 	depends on FB && EXPERIMENTAL && PCI && MIPS && MIPS_PB1100=y
 
+source "drivers/video/geode/Kconfig"
+
 config FB_SBUS
 	bool "SBUS and UPA framebuffers"
 	depends on FB && (SPARC32 || SPARC64)
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2005-02-15 18:12:59 +08:00
+++ b/drivers/video/Makefile	2005-02-16 08:54:10 +08:00
@@ -36,6 +36,7 @@
 obj-$(CONFIG_FB_SIS)		  += sis/
 obj-$(CONFIG_FB_KYRO)             += kyro/
 obj-$(CONFIG_FB_SAVAGE)		  += savage/
+obj-$(CONFIG_FB_GEODE)		  += geode/
 obj-$(CONFIG_FB_I810)             += vgastate.o
 obj-$(CONFIG_FB_RADEON_OLD)	  += radeonfb.o
 obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o vgastate.o
diff -Nru a/drivers/video/geode/Kconfig b/drivers/video/geode/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/geode/Kconfig	2005-02-15 18:29:38 +08:00
@@ -0,0 +1,29 @@
+#
+# Geode family framebuffer configuration
+#
+config FB_GEODE
+	bool "AMD Geode family framebuffer support (EXPERIMENTAL)"
+	default n
+	depends on FB && EXPERIMENTAL
+	---help---
+	  Say 'Y' here to allow you to select framebuffer drivers for
+	  the AMD Geode family of processors.
+
+config FB_GEODE_GX1
+	tristate "AMD Geode GX1 framebuffer support (EXPERIMENTAL)"
+	default n
+	depends on FB_GEODE && EXPERIMENTAL
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
+	---help---
+	  Framebuffer driver for the display controller integrated into the
+	  AMD Geode GX1 processor.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted and removed from the running kernel whenever you want). The
+	  module will be called gx1fb. If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
diff -Nru a/drivers/video/geode/Makefile b/drivers/video/geode/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/geode/Makefile	2005-02-15 18:28:19 +08:00
@@ -0,0 +1,5 @@
+# Makefile for the Geode family framebuffer drivers
+
+obj-$(CONFIG_FB_GEODE_GX1) += gx1fb.o
+
+gx1fb-objs   		:= gx1fb_core.o display_gx1.o video_cs5530.o
diff -Nru a/drivers/video/geode/display_gx1.c b/drivers/video/geode/display_gx1.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/geode/display_gx1.c	2005-02-15 18:28:19 +08:00
@@ -0,0 +1,213 @@
+/*
+ * drivers/video/geode/display_gx1.c
+ *   -- Geode GX1 display controller
+ *
+ * Copyright (C) 2005 Arcom Control Systems Ltd.
+ *
+ * Based on AMD's original 2.4 driver:
+ *   Copyright (C) 2004 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/spinlock.h>
+#include <linux/fb.h>
+#include <asm/io.h>
+#include <asm/div64.h>
+#include <asm/delay.h>
+
+#include "geodefb.h"
+#include "display_gx1.h"
+
+static spinlock_t gx1_conf_reg_lock = SPIN_LOCK_UNLOCKED;
+
+static u8 gx1_read_conf_reg(u8 reg)
+{
+	u8 val, ccr3;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gx1_conf_reg_lock, flags);
+
+	outb(CONFIG_CCR3, 0x22);
+	ccr3 = inb(0x23);
+	outb(CONFIG_CCR3, 0x22);
+	outb(ccr3 | CONFIG_CCR3_MAPEN, 0x23);
+	outb(reg, 0x22);
+	val = inb(0x23);
+	outb(CONFIG_CCR3, 0x22);
+	outb(ccr3, 0x23);
+
+	spin_unlock_irqrestore(&gx1_conf_reg_lock, flags);
+
+	return val;
+}
+
+unsigned gx1_gx_base(void)
+{
+	return (gx1_read_conf_reg(CONFIG_GCR) & 0x03) << 30;
+}
+
+int gx1_frame_buffer_size(void)
+{
+	void __iomem *mc_regs;
+	u32 bank_cfg;
+	int d;
+	unsigned dram_size = 0, fb_base;
+
+	mc_regs = ioremap(gx1_gx_base() + 0x8400, 0x100);
+	if (!mc_regs)
+		return -ENOMEM;
+
+
+	/* Calculate the total size of both DIMM0 and DIMM1. */
+	bank_cfg = readl(mc_regs + MC_BANK_CFG);
+
+	for (d = 0; d < 2; d++) {
+		if ((bank_cfg & MC_BCFG_DIMM0_PG_SZ_MASK) != MC_BCFG_DIMM0_PG_SZ_NO_DIMM)
+			dram_size += 0x400000 << ((bank_cfg & MC_BCFG_DIMM0_SZ_MASK) >> 8);
+		bank_cfg >>= 16; /* look at DIMM1 next */
+	}
+
+	fb_base = (readl(mc_regs + MC_GBASE_ADD) & MC_GADD_GBADD_MASK) << 19;
+
+	iounmap(mc_regs);
+
+	return dram_size - fb_base;
+}
+
+static void gx1_set_mode(struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+	u32 gcfg, tcfg, ocfg, dclk_div, val;
+	int hactive, hblankstart, hsyncstart, hsyncend, hblankend, htotal;
+	int vactive, vblankstart, vsyncstart, vsyncend, vblankend, vtotal;
+
+	/* Unlock the display controller registers. */
+	readl(par->dc_regs + DC_UNLOCK);
+	writel(DC_UNLOCK_CODE, par->dc_regs + DC_UNLOCK);
+
+	gcfg = readl(par->dc_regs + DC_GENERAL_CFG);
+	tcfg = readl(par->dc_regs + DC_TIMING_CFG);
+
+	/* Blank the display and disable the timing generator. */
+	tcfg &= ~(DC_TCFG_BLKE | DC_TCFG_TGEN);
+	writel(tcfg, par->dc_regs + DC_TIMING_CFG);
+
+	/* Wait for pending memory requests before disabling the FIFO load. */
+	udelay(100);
+
+	/* Disable FIFO load and compression. */
+	gcfg &= ~(DC_GCFG_DFLE | DC_GCFG_CMPE | DC_GCFG_DECE);
+	writel(gcfg, par->dc_regs + DC_GENERAL_CFG);
+
+	/* Setup DCLK and its divisor. */
+	gcfg &= ~DC_GCFG_DCLK_MASK;
+	writel(gcfg, par->dc_regs + DC_GENERAL_CFG);
+
+	par->vid_ops->set_dclk(info);
+
+	dclk_div = DC_GCFG_DCLK_DIV_1; /* FIXME: may need to divide DCLK by 2 sometimes? */
+	gcfg |= dclk_div;
+	writel(gcfg, par->dc_regs + DC_GENERAL_CFG);
+
+	/* Wait for the clock generatation to settle.  This is needed since
+	 * some of the register writes that follow require that clock to be
+	 * present. */
+	udelay(1000); /* FIXME: seems a little long */
+
+	/*
+	 * Setup new mode.
+	 */
+
+	/* Clear all unused feature bits. */
+	gcfg = DC_GCFG_VRDY | dclk_div;
+
+	/* Set FIFO priority (default 6/5) and enable. */
+	/* FIXME: increase fifo priority for 1280x1024 modes? */
+	gcfg |= (6 << DC_GCFG_DFHPEL_POS) | (5 << DC_GCFG_DFHPSL_POS) | DC_GCFG_DFLE;
+
+	/* FIXME: Set pixel and line double bits if necessary. */
+
+	/* Framebuffer start offset. */
+	writel(0, par->dc_regs + DC_FB_ST_OFFSET);
+
+	/* Line delta and line buffer length. */
+	writel(info->fix.line_length >> 2, par->dc_regs + DC_LINE_DELTA);
+	writel(((info->var.xres * info->var.bits_per_pixel/8) >> 3) + 2,
+	       par->dc_regs + DC_BUF_SIZE);
+
+	/* Output configuration. Enable panel data, set pixel format. */
+	ocfg = DC_OCFG_PCKE | DC_OCFG_PDEL | DC_OCFG_PDEH;
+	if (info->var.bits_per_pixel == 8) ocfg |= DC_OCFG_8BPP;
+
+	/* Enable timing generator, sync and FP data. */
+	tcfg = DC_TCFG_FPPE | DC_TCFG_HSYE | DC_TCFG_VSYE | DC_TCFG_BLKE
+		| DC_TCFG_TGEN;
+
+	/* Horizontal and vertical timings. */
+	hactive = info->var.xres;
+	hblankstart = hactive;
+	hsyncstart = hblankstart + info->var.right_margin;
+	hsyncend =  hsyncstart + info->var.hsync_len;
+	hblankend = hsyncend + info->var.left_margin;
+	htotal = hblankend;
+
+	vactive = info->var.yres;
+	vblankstart = vactive;
+	vsyncstart = vblankstart + info->var.lower_margin;
+	vsyncend =  vsyncstart + info->var.vsync_len;
+	vblankend = vsyncend + info->var.upper_margin;
+	vtotal = vblankend;
+
+	val = (hactive - 1) | ((htotal - 1) << 16);
+	writel(val, par->dc_regs + DC_H_TIMING_1);
+	val = (hblankstart - 1) | ((hblankend - 1) << 16);
+	writel(val, par->dc_regs + DC_H_TIMING_2);
+	val = (hsyncstart - 1) | ((hsyncend - 1) << 16);
+	writel(val, par->dc_regs + DC_H_TIMING_3);
+	writel(val, par->dc_regs + DC_FP_H_TIMING);
+	val = (vactive - 1) | ((vtotal - 1) << 16);
+	writel(val, par->dc_regs + DC_V_TIMING_1);
+	val = (vblankstart - 1) | ((vblankend - 1) << 16);
+	writel(val, par->dc_regs + DC_V_TIMING_2);
+	val = (vsyncstart - 1) | ((vsyncend - 1) << 16);
+	writel(val, par->dc_regs + DC_V_TIMING_3);
+	val = (vsyncstart - 2) | ((vsyncend - 2) << 16);
+	writel(val, par->dc_regs + DC_FP_V_TIMING);
+
+	/* Write final register values. */
+	writel(ocfg, par->dc_regs + DC_OUTPUT_CFG);
+	writel(tcfg, par->dc_regs + DC_TIMING_CFG);
+	udelay(1000); /* delay after TIMING_CFG. FIXME: perhaps a little long */
+	writel(gcfg, par->dc_regs + DC_GENERAL_CFG);
+
+	par->vid_ops->configure_display(info);
+
+	/* Relock display controller registers */
+	writel(0, par->dc_regs + DC_UNLOCK);
+
+	/* FIXME: write line_length and bpp to Graphics Pipeline GP_BLT_STATUS
+	 * register. */
+}
+
+static void gx1_set_hw_palette_reg(struct fb_info *info, unsigned regno,
+				   unsigned red, unsigned green, unsigned blue)
+{
+	struct geodefb_par *par = info->par;
+	int val;
+
+	/* Hardware palette is in RGB 6-6-6 format. */
+	val  = (red   <<  2) & 0x3f000;
+	val |= (green >>  4) & 0x00fc0;
+	val |= (blue  >> 10) & 0x0003f;
+
+	writel(regno, par->dc_regs + DC_PAL_ADDRESS);
+	writel(val, par->dc_regs + DC_PAL_DATA);
+}
+
+struct geode_dc_ops gx1_dc_ops = {
+	.set_mode	 = gx1_set_mode,
+	.set_palette_reg = gx1_set_hw_palette_reg,
+};
diff -Nru a/drivers/video/geode/display_gx1.h b/drivers/video/geode/display_gx1.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/geode/display_gx1.h	2005-02-15 18:28:19 +08:00
@@ -0,0 +1,154 @@
+/*
+ * drivers/video/geode/display_gx1.h
+ *   -- Geode GX1 display controller
+ *
+ * Copyright (C) 2005 Arcom Control Systems Ltd.
+ *
+ * Based on AMD's original 2.4 driver:
+ *   Copyright (C) 2004 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __DISPLAY_GX1_H__
+#define __DISPLAY_GX1_H__
+
+unsigned gx1_gx_base(void);
+int gx1_frame_buffer_size(void);
+
+extern struct geode_dc_ops gx1_dc_ops;
+
+/* GX1 configuration I/O registers */
+
+#define CONFIG_CCR3 0xc3
+#  define CONFIG_CCR3_MAPEN 0x10
+#define CONFIG_GCR  0xb8
+
+/* Memory controller registers */
+
+#define MC_BANK_CFG		0x08
+#  define MC_BCFG_DIMM0_SZ_MASK		0x00000700
+#  define MC_BCFG_DIMM0_PG_SZ_MASK	0x00000070
+#  define MC_BCFG_DIMM0_PG_SZ_NO_DIMM	0x00000070
+
+#define MC_GBASE_ADD		0x14
+#  define MC_GADD_GBADD_MASK		0x000003ff
+
+/* Display controller registers */
+
+#define DC_PAL_ADDRESS		0x70
+#define DC_PAL_DATA		0x74
+
+#define DC_UNLOCK		0x00
+#  define DC_UNLOCK_CODE		0x00004758
+
+#define DC_GENERAL_CFG		0x04
+#  define DC_GCFG_DFLE			0x00000001
+#  define DC_GCFG_CURE			0x00000002
+#  define DC_GCFG_VCLK_DIV		0x00000004
+#  define DC_GCFG_PLNO			0x00000004
+#  define DC_GCFG_PPC			0x00000008
+#  define DC_GCFG_CMPE			0x00000010
+#  define DC_GCFG_DECE			0x00000020
+#  define DC_GCFG_DCLK_MASK		0x000000C0
+#  define DC_GCFG_DCLK_DIV_1		0x00000080
+#  define DC_GCFG_DFHPSL_MASK		0x00000F00
+#  define DC_GCFG_DFHPSL_POS			 8
+#  define DC_GCFG_DFHPEL_MASK		0x0000F000
+#  define DC_GCFG_DFHPEL_POS			12
+#  define DC_GCFG_CIM_MASK		0x00030000
+#  define DC_GCFG_CIM_POS			16
+#  define DC_GCFG_FDTY			0x00040000
+#  define DC_GCFG_RTPM			0x00080000
+#  define DC_GCFG_DAC_RS_MASK		0x00700000
+#  define DC_GCFG_DAC_RS_POS			20
+#  define DC_GCFG_CKWR			0x00800000
+#  define DC_GCFG_LDBL			0x01000000
+#  define DC_GCFG_DIAG			0x02000000
+#  define DC_GCFG_CH4S			0x04000000
+#  define DC_GCFG_SSLC			0x08000000
+#  define DC_GCFG_VIDE			0x10000000
+#  define DC_GCFG_VRDY			0x20000000
+#  define DC_GCFG_DPCK			0x40000000
+#  define DC_GCFG_DDCK			0x80000000
+
+#define DC_TIMING_CFG		0x08
+#  define DC_TCFG_FPPE			0x00000001
+#  define DC_TCFG_HSYE			0x00000002
+#  define DC_TCFG_VSYE			0x00000004
+#  define DC_TCFG_BLKE			0x00000008
+#  define DC_TCFG_DDCK			0x00000010
+#  define DC_TCFG_TGEN			0x00000020
+#  define DC_TCFG_VIEN			0x00000040
+#  define DC_TCFG_BLNK			0x00000080
+#  define DC_TCFG_CHSP			0x00000100
+#  define DC_TCFG_CVSP			0x00000200
+#  define DC_TCFG_FHSP			0x00000400
+#  define DC_TCFG_FVSP			0x00000800
+#  define DC_TCFG_FCEN			0x00001000
+#  define DC_TCFG_CDCE			0x00002000
+#  define DC_TCFG_PLNR			0x00002000
+#  define DC_TCFG_INTL			0x00004000
+#  define DC_TCFG_PXDB			0x00008000
+#  define DC_TCFG_BKRT			0x00010000
+#  define DC_TCFG_PSD_MASK		0x000E0000
+#  define DC_TCFG_PSD_POS			17
+#  define DC_TCFG_DDCI			0x08000000
+#  define DC_TCFG_SENS			0x10000000
+#  define DC_TCFG_DNA			0x20000000
+#  define DC_TCFG_VNA			0x40000000
+#  define DC_TCFG_VINT			0x80000000
+
+#define DC_OUTPUT_CFG		0x0C
+#  define DC_OCFG_8BPP			0x00000001
+#  define DC_OCFG_555			0x00000002
+#  define DC_OCFG_PCKE			0x00000004
+#  define DC_OCFG_FRME			0x00000008
+#  define DC_OCFG_DITE			0x00000010
+#  define DC_OCFG_2PXE			0x00000020
+#  define DC_OCFG_2XCK			0x00000040
+#  define DC_OCFG_2IND			0x00000080
+#  define DC_OCFG_34ADD			0x00000100
+#  define DC_OCFG_FRMS			0x00000200
+#  define DC_OCFG_CKSL			0x00000400
+#  define DC_OCFG_PRMP			0x00000800
+#  define DC_OCFG_PDEL			0x00001000
+#  define DC_OCFG_PDEH			0x00002000
+#  define DC_OCFG_CFRW			0x00004000
+#  define DC_OCFG_DIAG			0x00008000
+
+#define DC_FB_ST_OFFSET		0x10
+#define DC_CB_ST_OFFSET		0x14
+#define DC_CURS_ST_OFFSET	0x18
+#define DC_ICON_ST_OFFSET	0x1C
+#define DC_VID_ST_OFFSET	0x20
+#define DC_LINE_DELTA		0x24
+#define DC_BUF_SIZE		0x28
+
+#define DC_H_TIMING_1		0x30
+#define DC_H_TIMING_2		0x34
+#define DC_H_TIMING_3		0x38
+#define DC_FP_H_TIMING		0x3C
+
+#define DC_V_TIMING_1		0x40
+#define DC_V_TIMING_2		0x44
+#define DC_V_TIMING_3		0x48
+#define DC_FP_V_TIMING		0x4C
+
+#define DC_CURSOR_X		0x50
+#define DC_ICON_X		0x54
+#define DC_V_LINE_CNT		0x54
+#define DC_CURSOR_Y		0x58
+#define DC_ICON_Y		0x5C
+#define DC_SS_LINE_CMP		0x5C
+#define DC_CURSOR_COLOR		0x60
+#define DC_ICON_COLOR		0x64
+#define DC_BORDER_COLOR		0x68
+#define DC_PAL_ADDRESS		0x70
+#define DC_PAL_DATA		0x74
+#define DC_DFIFO_DIAG		0x78
+#define DC_CFIFO_DIAG		0x7C
+
+#endif /* !__DISPLAY_GX1_H__ */
diff -Nru a/drivers/video/geode/geodefb.h b/drivers/video/geode/geodefb.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/geode/geodefb.h	2005-02-16 09:10:18 +08:00
@@ -0,0 +1,39 @@
+/*
+ * drivers/video/geode/geodefb.h
+ *   -- Geode framebuffer driver
+ *
+ * Copyright (C) 2005 Arcom Control Systems Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __GEODEFB_H__
+#define __GEODEFB_H__
+
+struct geodefb_info;
+
+struct geode_dc_ops {
+	void (*set_mode)(struct fb_info *);
+	void (*set_palette_reg)(struct fb_info *, unsigned, unsigned, unsigned, unsigned);
+};
+
+struct geode_vid_ops {
+	void (*set_dclk)(struct fb_info *);
+	void (*configure_display)(struct fb_info *);
+	int  (*blank_display)(struct fb_info *, int blank_mode);
+};
+
+struct geodefb_par {
+	int enable_crt;
+	int panel_x; /* dimensions of an attached flat panel, non-zero => enable panel */
+	int panel_y;
+	struct pci_dev *vid_dev;
+	void __iomem *dc_regs;
+	void __iomem *vid_regs;
+	struct geode_dc_ops  *dc_ops;
+	struct geode_vid_ops *vid_ops;
+};
+
+#endif /* !__GEODEFB_H__ */
diff -Nru a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/geode/gx1fb_core.c	2005-02-16 09:10:18 +08:00
@@ -0,0 +1,359 @@
+/*
+ * drivers/video/geode/gx1fb_core.c
+ *   -- Geode GX1 framebuffer driver
+ *
+ * Copyright (C) 2005 Arcom Control Systems Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include "geodefb.h"
+#include "display_gx1.h"
+#include "video_cs5530.h"
+
+static char mode_option[32] = "640x480-16@60";
+static int  crt_option = 1;
+static char panel_option[32] = "";
+
+static int gx1_line_delta(int xres, int bpp)
+{
+	int line_delta = xres * (bpp >> 3);
+
+	if (line_delta > 2048)
+		line_delta = 4096;
+	else if (line_delta > 1024)
+		line_delta = 2048;
+	else
+		line_delta = 1024;
+	return line_delta;
+}
+
+static int gx1fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+
+	printk(KERN_DEBUG "%s()\n", __FUNCTION__);
+
+	/* Maximum resolution is 1280x1024. */
+	if (var->xres > 1280 || var->yres > 1024)
+		return -EINVAL;
+
+	if (par->panel_x && (var->xres > par->panel_x || var->yres > par->panel_y))
+		return -EINVAL;
+
+	/* Only 16 bpp and 8 bpp is supported by the hardware. */
+	if (var->bits_per_pixel == 16) {
+		var->red.offset   = 11; var->red.length   = 5;
+		var->green.offset =  5; var->green.length = 6;
+		var->blue.offset  =  0; var->blue.length  = 5;
+		var->transp.offset = 0; var->transp.length = 0;
+	} else if (var->bits_per_pixel == 8) {
+		var->red.offset   = 0; var->red.length   = 8;
+		var->green.offset = 0; var->green.length = 8;
+		var->blue.offset  = 0; var->blue.length  = 8;
+		var->transp.offset = 0; var->transp.length = 0;
+	} else
+		return -EINVAL;
+
+	/* Enough video memory? */
+	if (gx1_line_delta(var->xres, var->bits_per_pixel) * var->yres > info->fix.smem_len)
+		return -EINVAL;
+
+	/* FIXME: Check timing parameters here? */
+
+	return 0;
+}
+
+static int gx1fb_set_par(struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+
+	if (info->var.bits_per_pixel == 16) {
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+		fb_dealloc_cmap(&info->cmap);
+	} else {
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		fb_alloc_cmap(&info->cmap, 1<<info->var.bits_per_pixel, 0);
+	}
+
+	info->fix.line_length = gx1_line_delta(info->var.xres, info->var.bits_per_pixel);
+
+	par->dc_ops->set_mode(info);
+
+	return 0;
+}
+
+static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
+{
+	chan &= 0xffff;
+	chan >>= 16 - bf->length;
+	return chan << bf->offset;
+}
+
+static int gx1fb_setcolreg(unsigned regno, unsigned red, unsigned green,
+			   unsigned blue, unsigned transp,
+			   struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+
+	if (info->var.grayscale) {
+		/* grayscale = 0.30*R + 0.59*G + 0.11*B */
+		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
+	}
+
+	/* Truecolor has hardware independent palette */
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR) {
+		u32 *pal = info->pseudo_palette;
+		u32 v;
+
+		if (regno >= 16)
+			return -EINVAL;
+
+		v  = chan_to_field(red, &info->var.red);
+		v |= chan_to_field(green, &info->var.green);
+		v |= chan_to_field(blue, &info->var.blue);
+
+		pal[regno] = v;
+	} else {
+		if (regno >= 256)
+			return -EINVAL;
+
+		par->dc_ops->set_palette_reg(info, regno, red, green, blue);
+	}
+
+	return 0;
+}
+
+static int gx1fb_blank(int blank_mode, struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+
+	return par->vid_ops->blank_display(info, blank_mode);
+}
+
+static int __init gx1fb_map_video_memory(struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+	unsigned gx_base;
+	int fb_len;
+
+	gx_base = gx1_gx_base();
+	if (!gx_base)
+		return -ENODEV;
+
+	par->vid_dev = pci_get_device(PCI_VENDOR_ID_CYRIX,
+				      PCI_DEVICE_ID_CYRIX_5530_VIDEO, NULL);
+	if (!par->vid_dev)
+		return -ENODEV;
+
+	par->vid_regs = ioremap(pci_resource_start(par->vid_dev, 1),
+				pci_resource_len(par->vid_dev, 1));
+	if (!par->vid_regs)
+		return -ENOMEM;
+
+	par->dc_regs = ioremap(gx_base + 0x8300, 0x100);
+	if (!par->dc_regs)
+		return -ENOMEM;
+
+	info->fix.smem_start = gx_base + 0x800000;
+	if ((fb_len = gx1_frame_buffer_size()) < 0)
+		return -ENOMEM;
+	info->fix.smem_len = fb_len;
+	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
+	if (!info->screen_base)
+		return -ENOMEM;
+
+	printk(KERN_INFO "%s: %d Kibyte of video memory at 0x%lx\n",
+	       info->fix.id, info->fix.smem_len / 1024, info->fix.smem_start);
+
+	return 0;
+}
+
+static int parse_panel_option(struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+
+	if (strcmp(panel_option, "") != 0) {
+		int x, y;
+		char *s;
+		x = simple_strtol(panel_option, &s, 10);
+		if (!x)
+			return -EINVAL;
+		y = simple_strtol(s + 1, NULL, 10);
+		if (!y)
+			return -EINVAL;
+		par->panel_x = x;
+		par->panel_y = y;
+	}
+	return 0;
+}
+
+static struct fb_ops gx1fb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_check_var	= gx1fb_check_var,
+	.fb_set_par	= gx1fb_set_par,
+	.fb_setcolreg	= gx1fb_setcolreg,
+	.fb_blank       = gx1fb_blank,
+	/* No HW acceleration for now. */
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_cursor	= soft_cursor,
+};
+
+static struct fb_info * __init gx1fb_init_fbinfo(void)
+{
+	struct fb_info *info;
+	struct geodefb_par *par;
+
+	/* Alloc enough space for the pseudo palette. */
+	info = framebuffer_alloc(sizeof(struct geodefb_par) + sizeof(u32) * 16, NULL);
+	if (!info)
+		return NULL;
+
+	par = info->par;
+
+	strcpy(info->fix.id, "GX1");
+
+	info->fix.type		= FB_TYPE_PACKED_PIXELS;
+	info->fix.type_aux	= 0;
+	info->fix.xpanstep	= 0;
+	info->fix.ypanstep	= 0;
+	info->fix.ywrapstep	= 0;
+	info->fix.accel		= FB_ACCEL_NONE;
+
+	info->var.nonstd	= 0;
+	info->var.activate	= FB_ACTIVATE_NOW;
+	info->var.height	= -1;
+	info->var.width	= -1;
+	info->var.accel_flags = 0;
+	info->var.vmode	= FB_VMODE_NONINTERLACED;
+
+	info->fbops		= &gx1fb_ops;
+	info->flags		= FBINFO_DEFAULT;
+	info->node		= -1;
+
+	info->pseudo_palette	= (void *)par + sizeof(struct geodefb_par);
+
+	info->var.grayscale	= 0;
+
+	/* CRT and panel options */
+	par->enable_crt = crt_option;
+	if (parse_panel_option(info) < 0)
+		printk(KERN_WARNING "%s: invalid 'panel' option -- disabling flat panel\n",
+		       info->fix.id);
+	if (!par->panel_x)
+		par->enable_crt = 1; /* fall back to CRT if no panel is specified */
+
+	return info;
+}
+
+
+struct fb_info *gx1fb_info;
+
+int __init gx1fb_init(void)
+{
+	struct fb_info *info;
+        struct geodefb_par *par;
+	int ret;
+
+#ifndef MODULE
+	if (fb_get_options("gx1fb", NULL))
+		return -ENODEV;
+#endif
+
+	info = gx1fb_init_fbinfo();
+	if (!info)
+		return -ENOMEM;
+	gx1fb_info = info;
+
+	par = info->par;
+
+	/* GX1 display controller and CS5530 video device */
+	par->dc_ops  = &gx1_dc_ops;
+	par->vid_ops = &cs5530_vid_ops;
+
+	if ((ret = gx1fb_map_video_memory(info)) < 0) {
+		printk(KERN_ERR "%s: gx1fb_map_video_memory() failed\n", info->fix.id);
+		goto err;
+	}
+
+	ret = fb_find_mode(&info->var, info, mode_option, NULL, 0, NULL, 16);
+	if (ret == 0 || ret == 4) {
+		printk(KERN_ERR "%s: could not find valid video mode\n", info->fix.id);
+		ret = -EINVAL;
+		goto err;
+	}
+
+        /* Clear the frame buffer of garbage. */
+        memset_io(info->screen_base, 0, info->fix.smem_len);
+
+	gx1fb_check_var(&info->var, info);
+	gx1fb_set_par(info);
+
+	if (register_framebuffer(info) < 0) {
+		ret = -EINVAL;
+		goto err;
+	}
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node, info->fix.id);
+	return 0;
+
+  err:
+	if (info->screen_base)
+		iounmap(info->screen_base);
+	if (par->vid_regs)
+		iounmap(par->vid_regs);
+	if (par->dc_regs)
+		iounmap(par->dc_regs);
+	if (par->vid_dev)
+		pci_dev_put(par->vid_dev);
+	if (info)
+		framebuffer_release(info);
+	return ret;
+}
+
+static void __exit gx1fb_cleanup(void)
+{
+	struct fb_info *info = gx1fb_info;
+	struct geodefb_par *par = gx1fb_info->par;
+
+	unregister_framebuffer(info);
+
+	iounmap((void __iomem *)info->screen_base);
+	iounmap(par->vid_regs);
+	iounmap(par->dc_regs);
+
+	pci_dev_put(par->vid_dev);
+
+	framebuffer_release(info);
+}
+
+module_init(gx1fb_init);
+module_exit(gx1fb_cleanup);
+
+module_param_string(mode, mode_option, sizeof(mode_option), 0444);
+MODULE_PARM_DESC(mode, "video mode (<x>x<y>[-<bpp>][@<refr>])");
+
+module_param_named(crt, crt_option, int, 0444);
+MODULE_PARM_DESC(crt, "enable CRT output. 0 = off, 1 = on (default)");
+
+module_param_string(panel, panel_option, sizeof(panel_option), 0444);
+MODULE_PARM_DESC(panel, "size of attached flat panel (<x>x<y>)");
+
+MODULE_DESCRIPTION("framebuffer driver for the AMD Geode GX1");
+MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/geode/video_cs5530.c b/drivers/video/geode/video_cs5530.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/geode/video_cs5530.c	2005-02-16 09:10:18 +08:00
@@ -0,0 +1,194 @@
+/*
+ * drivers/video/geode/video_cs5530.c
+ *   -- CS5530 video device
+ *
+ * Copyright (C) 2005 Arcom Control Systems Ltd.
+ *
+ * Based on AMD's original 2.4 driver:
+ *   Copyright (C) 2004 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/fb.h>
+#include <asm/io.h>
+#include <asm/delay.h>
+
+#include "geodefb.h"
+#include "video_cs5530.h"
+
+/*
+ * CS5530 PLL table. This maps pixclocks to the appropriate PLL register
+ * value.
+ */
+struct cs5530_pll_entry {
+	long pixclock; /* ps */
+	u32 pll_value;
+};
+
+static const struct cs5530_pll_entry cs5530_pll_table[] = {
+	{ 39721, 0x31C45801, }, /*  25.1750 MHz */
+	{ 35308, 0x20E36802, }, /*  28.3220 */
+	{ 31746, 0x33915801, }, /*  31.5000 */
+	{ 27777, 0x31EC4801, }, /*  36.0000 */
+	{ 26666, 0x21E22801, }, /*  37.5000 */
+	{ 25000, 0x33088801, }, /*  40.0000 */
+	{ 22271, 0x33E22801, }, /*  44.9000 */
+	{ 20202, 0x336C4801, }, /*  49.5000 */
+	{ 20000, 0x23088801, }, /*  50.0000 */
+	{ 19860, 0x23088801, }, /*  50.3500 */
+	{ 18518, 0x3708A801, }, /*  54.0000 */
+	{ 17777, 0x23E36802, }, /*  56.2500 */
+	{ 17733, 0x23E36802, }, /*  56.3916 */
+	{ 17653, 0x23E36802, }, /*  56.6444 */
+	{ 16949, 0x37C45801, }, /*  59.0000 */
+	{ 15873, 0x23EC4801, }, /*  63.0000 */
+	{ 15384, 0x37911801, }, /*  65.0000 */
+	{ 14814, 0x37963803, }, /*  67.5000 */
+	{ 14124, 0x37058803, }, /*  70.8000 */
+	{ 13888, 0x3710C805, }, /*  72.0000 */
+	{ 13333, 0x37E22801, }, /*  75.0000 */
+	{ 12698, 0x27915801, }, /*  78.7500 */
+	{ 12500, 0x37D8D802, }, /*  80.0000 */
+	{ 11135, 0x27588802, }, /*  89.8000 */
+	{ 10582, 0x27EC4802, }, /*  94.5000 */
+	{ 10101, 0x27AC6803, }, /*  99.0000 */
+	{ 10000, 0x27088801, }, /* 100.0000 */
+	{  9259, 0x2710C805, }, /* 108.0000 */
+	{  8888, 0x27E36802, }, /* 112.5000 */
+	{  7692, 0x27C58803, }, /* 130.0000 */
+	{  7407, 0x27316803, }, /* 135.0000 */
+	{  6349, 0x2F915801, }, /* 157.5000 */
+	{  6172, 0x2F08A801, }, /* 162.0000 */
+	{  5714, 0x2FB11802, }, /* 175.0000 */
+	{  5291, 0x2FEC4802, }, /* 189.0000 */
+	{  4950, 0x2F963803, }, /* 202.0000 */
+	{  4310, 0x2FB1B802, }, /* 232.0000 */
+};
+
+#define NUM_CS5530_FREQUENCIES sizeof(cs5530_pll_table)/sizeof(struct cs5530_pll_entry)
+
+static void cs5530_set_dclk_frequency(struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+	int i;
+	u32 value;
+	long min, diff;
+
+	/* Search the table for the closest pixclock. */
+	value = cs5530_pll_table[0].pll_value;
+	min = cs5530_pll_table[0].pixclock - info->var.pixclock;
+	if (min < 0) min = -min;
+	for (i = 1; i < NUM_CS5530_FREQUENCIES; i++) {
+		diff = cs5530_pll_table[i].pixclock - info->var.pixclock;
+		if (diff < 0L) diff = -diff;
+		if (diff < min) {
+			min = diff;
+			value = cs5530_pll_table[i].pll_value;
+		}
+	}
+
+	writel(value, par->vid_regs + CS5530_DOT_CLK_CONFIG);
+	writel(value | 0x80000100, par->vid_regs + CS5530_DOT_CLK_CONFIG); /* set reset and bypass */
+	udelay(500); /* wait for PLL to settle */
+	writel(value & 0x7FFFFFFF, par->vid_regs + CS5530_DOT_CLK_CONFIG); /* clear reset */
+	writel(value & 0x7FFFFEFF, par->vid_regs + CS5530_DOT_CLK_CONFIG); /* clear bypass */
+}
+
+static void cs5530_configure_display(struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+	u32 dcfg;
+
+	dcfg = readl(par->vid_regs + CS5530_DISPLAY_CONFIG);
+
+	/* Clear bits from existing mode. */
+	dcfg &= ~(CS5530_DCFG_CRT_SYNC_SKW_MASK | CS5530_DCFG_PWR_SEQ_DLY_MASK
+		  | CS5530_DCFG_CRT_HSYNC_POL   | CS5530_DCFG_CRT_VSYNC_POL
+		  | CS5530_DCFG_FP_PWR_EN       | CS5530_DCFG_FP_DATA_EN
+		  | CS5530_DCFG_DAC_PWR_EN      | CS5530_DCFG_VSYNC_EN
+		  | CS5530_DCFG_HSYNC_EN);
+
+	/* Set default sync skew and power sequence delays.  */
+	dcfg |= (CS5530_DCFG_CRT_SYNC_SKW_INIT | CS5530_DCFG_PWR_SEQ_DLY_INIT
+		 | CS5530_DCFG_GV_PAL_BYP);
+
+	/* Enable DACs, hsync and vsync for CRTs */
+	if (par->enable_crt) {
+		dcfg |= CS5530_DCFG_DAC_PWR_EN;
+		dcfg |= CS5530_DCFG_HSYNC_EN | CS5530_DCFG_VSYNC_EN;
+	}
+	/* Enable panel power and data if using a flat panel. */
+	if (par->panel_x > 0) {
+		dcfg |= CS5530_DCFG_FP_PWR_EN;
+		dcfg |= CS5530_DCFG_FP_DATA_EN;
+	}
+
+	/* Sync polarities. */
+	if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
+		dcfg |= CS5530_DCFG_CRT_HSYNC_POL;
+	if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
+		dcfg |= CS5530_DCFG_CRT_VSYNC_POL;
+
+	writel(dcfg, par->vid_regs + CS5530_DISPLAY_CONFIG);
+}
+
+static int cs5530_blank_display(struct fb_info *info, int blank_mode)
+{
+	struct geodefb_par *par = info->par;
+	u32 dcfg;
+	int blank, hsync, vsync;
+
+	switch (blank_mode) {
+	case FB_BLANK_UNBLANK:
+		blank = 0; hsync = 1; vsync = 1;
+		break;
+	case FB_BLANK_NORMAL:
+		blank = 1; hsync = 1; vsync = 1;
+		break;
+	case FB_BLANK_VSYNC_SUSPEND:
+		blank = 1; hsync = 1; vsync = 0;
+		break;
+	case FB_BLANK_HSYNC_SUSPEND:
+		blank = 1; hsync = 0; vsync = 1;
+		break;
+	case FB_BLANK_POWERDOWN:
+		blank = 1; hsync = 0; vsync = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dcfg = readl(par->vid_regs + CS5530_DISPLAY_CONFIG);
+
+	dcfg &= ~(CS5530_DCFG_DAC_BL_EN | CS5530_DCFG_DAC_PWR_EN
+		  | CS5530_DCFG_HSYNC_EN | CS5530_DCFG_VSYNC_EN
+		  | CS5530_DCFG_FP_DATA_EN | CS5530_DCFG_FP_PWR_EN);
+
+	if (par->enable_crt) {
+		if (!blank)
+			dcfg |= CS5530_DCFG_DAC_BL_EN | CS5530_DCFG_DAC_PWR_EN;
+		if (hsync)
+			dcfg |= CS5530_DCFG_HSYNC_EN;
+		if (vsync)
+			dcfg |= CS5530_DCFG_VSYNC_EN;
+	}
+	if (par->panel_x > 0) {
+		if (!blank)
+			dcfg |= CS5530_DCFG_FP_DATA_EN;
+		if (hsync && vsync)
+			dcfg |= CS5530_DCFG_FP_PWR_EN;
+	}
+
+	writel(dcfg, par->vid_regs + CS5530_DISPLAY_CONFIG);
+
+	return 0;
+}
+
+struct geode_vid_ops cs5530_vid_ops = {
+	.set_dclk          = cs5530_set_dclk_frequency,
+	.configure_display = cs5530_configure_display,
+	.blank_display     = cs5530_blank_display,
+};
diff -Nru a/drivers/video/geode/video_cs5530.h b/drivers/video/geode/video_cs5530.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/geode/video_cs5530.h	2005-02-15 18:28:19 +08:00
@@ -0,0 +1,75 @@
+/*
+ * drivers/video/geode/video_cs5530.h
+ *   -- CS5530 video device
+ *
+ * Copyright (C) 2005 Arcom Control Systems Ltd.
+ *
+ * Based on AMD's original 2.4 driver:
+ *   Copyright (C) 2004 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __VIDEO_CS5530_H__
+#define __VIDEO_CS5530_H__
+
+extern struct geode_vid_ops cs5530_vid_ops;
+
+/* CS5530 Video device registers */
+
+#define CS5530_VIDEO_CONFIG	0x0000
+#  define CS5530_VCFG_VID_EN			0x00000001
+#  define CS5530_VCFG_VID_REG_UPDATE		0x00000002
+#  define CS5530_VCFG_VID_INP_FORMAT		0x0000000C
+#  define CS5530_VCFG_8_BIT_4_2_0		0x00000004
+#  define CS5530_VCFG_16_BIT_4_2_0		0x00000008
+#  define CS5530_VCFG_GV_SEL			0x00000010
+#  define CS5530_VCFG_CSC_BYPASS		0x00000020
+#  define CS5530_VCFG_X_FILTER_EN		0x00000040
+#  define CS5530_VCFG_Y_FILTER_EN		0x00000080
+#  define CS5530_VCFG_LINE_SIZE_LOWER_MASK	0x0000FF00
+#  define CS5530_VCFG_INIT_READ_MASK		0x01FF0000
+#  define CS5530_VCFG_EARLY_VID_RDY		0x02000000
+#  define CS5530_VCFG_LINE_SIZE_UPPER		0x08000000
+#  define CS5530_VCFG_4_2_0_MODE		0x10000000
+#  define CS5530_VCFG_16_BIT_EN			0x20000000
+#  define CS5530_VCFG_HIGH_SPD_INT		0x40000000
+
+#define CS5530_DISPLAY_CONFIG	0x0004
+#  define CS5530_DCFG_DIS_EN			0x00000001
+#  define CS5530_DCFG_HSYNC_EN			0x00000002
+#  define CS5530_DCFG_VSYNC_EN			0x00000004
+#  define CS5530_DCFG_DAC_BL_EN			0x00000008
+#  define CS5530_DCFG_DAC_PWR_EN		0x00000020
+#  define CS5530_DCFG_FP_PWR_EN			0x00000040
+#  define CS5530_DCFG_FP_DATA_EN		0x00000080
+#  define CS5530_DCFG_CRT_HSYNC_POL		0x00000100
+#  define CS5530_DCFG_CRT_VSYNC_POL		0x00000200
+#  define CS5530_DCFG_FP_HSYNC_POL		0x00000400
+#  define CS5530_DCFG_FP_VSYNC_POL		0x00000800
+#  define CS5530_DCFG_XGA_FP			0x00001000
+#  define CS5530_DCFG_FP_DITH_EN		0x00002000
+#  define CS5530_DCFG_CRT_SYNC_SKW_MASK		0x0001C000
+#  define CS5530_DCFG_CRT_SYNC_SKW_INIT		0x00010000
+#  define CS5530_DCFG_PWR_SEQ_DLY_MASK		0x000E0000
+#  define CS5530_DCFG_PWR_SEQ_DLY_INIT		0x00080000
+#  define CS5530_DCFG_VG_CK			0x00100000
+#  define CS5530_DCFG_GV_PAL_BYP		0x00200000
+#  define CS5530_DCFG_DDC_SCL			0x00400000
+#  define CS5530_DCFG_DDC_SDA			0x00800000
+#  define CS5530_DCFG_DDC_OE			0x01000000
+#  define CS5530_DCFG_16_BIT_EN			0x02000000
+
+#define CS5530_VIDEO_X_POS	0x0008
+#define CS5530_VIDEO_Y_POS	0x000C
+#define CS5530_VIDEO_SCALE	0x0010
+#define CS5530_VIDEO_COLOR_KEY	0x0014
+#define CS5530_VIDEO_COLOR_MASK 0x0018
+#define CS5530_PALETTE_ADDRESS	0x001C
+#define CS5530_PALETTE_DATA	0x0020
+#define CS5530_DOT_CLK_CONFIG	0x0024
+#define CS5530_CRCSIG_TFT_TV	0x0028
+
+#endif /* !__VIDEO_CS5530_H__ */




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
