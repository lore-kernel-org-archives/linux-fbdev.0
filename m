From: David Vrabel <dvrabel@arcom.com>
Subject: [patch] Framebuffer driver for Geode GX
Date: Tue, 31 Jan 2006 17:19:05 +0000
Message-ID: <43DF9C09.30806@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060804020404080609000700"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F3z9z-0005QT-2Y
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 Jan 2006 09:19:19 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F3z9w-0004Go-1e
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 Jan 2006 09:19:19 -0800
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
To: linux-fbdev-devel list <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060804020404080609000700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

A framebuffer driver for the display controller in AMD Geode GX
processors (Geode GX533, Geode GX500 etc.).  Tested at 640x480, 800x600,
1024x768 and 1280x1024 at 8, 16, and 24 bpp with both CRT and TFT.  No
accelerated features currently implemented and compression remains disabled.

This driver requires that the BIOS (or the SoftVG/Firmbase code in the
BIOS) has created an appropriate virtual PCI header.

Signed-off-by: David Vrabel <dvrabel@arcom.com>
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------060804020404080609000700
Content-Type: text/plain;
 name="drivers-video-geode-gx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers-video-geode-gx"

Index: linux-2.6-working/drivers/video/geode/Kconfig
===================================================================
--- linux-2.6-working.orig/drivers/video/geode/Kconfig	2006-01-31 16:59:20.000000000 +0000
+++ linux-2.6-working/drivers/video/geode/Kconfig	2006-01-31 16:59:51.000000000 +0000
@@ -8,6 +8,21 @@
 	  Say 'Y' here to allow you to select framebuffer drivers for
 	  the AMD Geode family of processors.
 
+config FB_GEODE_GX
+	tristate "AMD Geode GX framebuffer support (EXPERIMENTAL)"
+	depends on FB_GEODE && EXPERIMENTAL
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	---help---
+	  Framebuffer driver for the display controller integrated into the
+	  AMD Geode GX processors.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called gxfb.
+
+	  If unsure, say N.
+
 config FB_GEODE_GX1
 	tristate "AMD Geode GX1 framebuffer support (EXPERIMENTAL)"
 	depends on FB_GEODE && EXPERIMENTAL
Index: linux-2.6-working/drivers/video/geode/Makefile
===================================================================
--- linux-2.6-working.orig/drivers/video/geode/Makefile	2006-01-31 16:59:20.000000000 +0000
+++ linux-2.6-working/drivers/video/geode/Makefile	2006-01-31 16:59:51.000000000 +0000
@@ -1,5 +1,7 @@
 # Makefile for the Geode family framebuffer drivers
 
 obj-$(CONFIG_FB_GEODE_GX1) += gx1fb.o
+obj-$(CONFIG_FB_GEODE_GX)  += gxfb.o
 
-gx1fb-objs   		:= gx1fb_core.o display_gx1.o video_cs5530.o
+gx1fb-objs := gx1fb_core.o display_gx1.o video_cs5530.o
+gxfb-objs  := gxfb_core.o display_gx.o video_gx.o
Index: linux-2.6-working/drivers/video/geode/display_gx.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/drivers/video/geode/display_gx.c	2006-01-31 16:59:51.000000000 +0000
@@ -0,0 +1,156 @@
+/*
+ * Geode GX display controller.
+ *
+ *   Copyright (C) 2005 Arcom Control Systems Ltd.
+ *
+ *   Portions from AMD's original 2.4 driver:
+ *     Copyright (C) 2004 Advanced Micro Devices, Inc.
+ *
+ *   This program is free software; you can redistribute it and/or modify it
+ *   under the terms of the GNU General Public License as published by * the
+ *   Free Software Foundation; either version 2 of the License, or * (at your
+ *   option) any later version.
+ */
+#include <linux/spinlock.h>
+#include <linux/fb.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <asm/div64.h>
+#include <asm/delay.h>
+
+#include "geodefb.h"
+#include "display_gx.h"
+
+int gx_frame_buffer_size(void)
+{
+	/* Assuming 16 MiB. */
+	return 16*1024*1024;
+}
+
+int gx_line_delta(int xres, int bpp)
+{
+	/* Must be a multiple of 8 bytes. */
+	return (xres * (bpp >> 3) + 7) & ~0x7;
+}
+
+static void gx_set_mode(struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+	u32 gcfg, dcfg;
+	int hactive, hblankstart, hsyncstart, hsyncend, hblankend, htotal;
+	int vactive, vblankstart, vsyncstart, vsyncend, vblankend, vtotal;
+
+	/* Unlock the display controller registers. */
+	readl(par->dc_regs + DC_UNLOCK);
+	writel(DC_UNLOCK_CODE, par->dc_regs + DC_UNLOCK);
+
+	gcfg = readl(par->dc_regs + DC_GENERAL_CFG);
+	dcfg = readl(par->dc_regs + DC_DISPLAY_CFG);
+
+	/* Disable the timing generator. */
+	dcfg &= ~(DC_DCFG_TGEN);
+	writel(dcfg, par->dc_regs + DC_DISPLAY_CFG);
+
+	/* Wait for pending memory requests before disabling the FIFO load. */
+	udelay(100);
+
+	/* Disable FIFO load and compression. */
+	gcfg &= ~(DC_GCFG_DFLE | DC_GCFG_CMPE | DC_GCFG_DECE);
+	writel(gcfg, par->dc_regs + DC_GENERAL_CFG);
+
+	/* Setup DCLK and its divisor. */
+	par->vid_ops->set_dclk(info);
+
+	/*
+	 * Setup new mode.
+	 */
+
+	/* Clear all unused feature bits. */
+	gcfg &= DC_GCFG_YUVM | DC_GCFG_VDSE;
+	dcfg = 0;
+
+	/* Set FIFO priority (default 6/5) and enable. */
+	/* FIXME: increase fifo priority for 1280x1024 and higher modes? */
+	gcfg |= (6 << DC_GCFG_DFHPEL_POS) | (5 << DC_GCFG_DFHPSL_POS) | DC_GCFG_DFLE;
+
+	/* Framebuffer start offset. */
+	writel(0, par->dc_regs + DC_FB_ST_OFFSET);
+
+	/* Line delta and line buffer length. */
+	writel(info->fix.line_length >> 3, par->dc_regs + DC_GFX_PITCH);
+	writel(((info->var.xres * info->var.bits_per_pixel/8) >> 3) + 2,
+	       par->dc_regs + DC_LINE_SIZE);
+
+	/* Enable graphics and video data and unmask address lines. */
+	dcfg |= DC_DCFG_GDEN | DC_DCFG_VDEN | DC_DCFG_A20M | DC_DCFG_A18M;
+
+	/* Set pixel format. */
+	switch (info->var.bits_per_pixel) {
+	case 8:
+		dcfg |= DC_DCFG_DISP_MODE_8BPP;
+		break;
+	case 16:
+		dcfg |= DC_DCFG_DISP_MODE_16BPP;
+		dcfg |= DC_DCFG_16BPP_MODE_565;
+		break;
+	case 32:
+		dcfg |= DC_DCFG_DISP_MODE_24BPP;
+		dcfg |= DC_DCFG_PALB;
+		break;
+	}
+
+	/* Enable timing generator. */
+	dcfg |= DC_DCFG_TGEN;
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
+	writel((hactive - 1)     | ((htotal - 1) << 16),    par->dc_regs + DC_H_ACTIVE_TIMING);
+	writel((hblankstart - 1) | ((hblankend - 1) << 16), par->dc_regs + DC_H_BLANK_TIMING);
+	writel((hsyncstart - 1)  | ((hsyncend - 1) << 16),  par->dc_regs + DC_H_SYNC_TIMING);
+
+	writel((vactive - 1)     | ((vtotal - 1) << 16),    par->dc_regs + DC_V_ACTIVE_TIMING);
+	writel((vblankstart - 1) | ((vblankend - 1) << 16), par->dc_regs + DC_V_BLANK_TIMING);
+	writel((vsyncstart - 1)  | ((vsyncend - 1) << 16),  par->dc_regs + DC_V_SYNC_TIMING);
+
+	/* Write final register values. */
+	writel(dcfg, par->dc_regs + DC_DISPLAY_CFG);
+	writel(gcfg, par->dc_regs + DC_GENERAL_CFG);
+
+	par->vid_ops->configure_display(info);
+
+	/* Relock display controller registers */
+	writel(0, par->dc_regs + DC_UNLOCK);
+}
+
+static void gx_set_hw_palette_reg(struct fb_info *info, unsigned regno,
+				   unsigned red, unsigned green, unsigned blue)
+{
+	struct geodefb_par *par = info->par;
+	int val;
+
+	/* Hardware palette is in RGB 8-8-8 format. */
+	val  = (red   << 8) & 0xff0000;
+	val |= (green)      & 0x00ff00;
+	val |= (blue  >> 8) & 0x0000ff;
+
+	writel(regno, par->dc_regs + DC_PAL_ADDRESS);
+	writel(val, par->dc_regs + DC_PAL_DATA);
+}
+
+struct geode_dc_ops gx_dc_ops = {
+	.set_mode	 = gx_set_mode,
+	.set_palette_reg = gx_set_hw_palette_reg,
+};
Index: linux-2.6-working/drivers/video/geode/display_gx.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/drivers/video/geode/display_gx.h	2006-01-31 16:59:51.000000000 +0000
@@ -0,0 +1,96 @@
+/*
+ * Geode GX display controller
+ *
+ * Copyright (C) 2006 Arcom Control Systems Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __DISPLAY_GX_H__
+#define __DISPLAY_GX_H__
+
+int gx_frame_buffer_size(void);
+int gx_line_delta(int xres, int bpp);
+
+extern struct geode_dc_ops gx_dc_ops;
+
+/* Display controller registers */
+
+#define DC_UNLOCK 0x00
+#  define DC_UNLOCK_CODE 0x00004758
+
+#define DC_GENERAL_CFG 0x04
+#  define DC_GCFG_DFLE	      0x00000001
+#  define DC_GCFG_CURE	      0x00000002
+#  define DC_GCFG_ICNE	      0x00000004
+#  define DC_GCFG_VIDE	      0x00000008
+#  define DC_GCFG_CMPE	      0x00000020
+#  define DC_GCFG_DECE	      0x00000040
+#  define DC_GCFG_VGAE	      0x00000080
+#  define DC_GCFG_DFHPSL_MASK 0x00000F00
+#  define DC_GCFG_DFHPSL_POS	       8
+#  define DC_GCFG_DFHPEL_MASK 0x0000F000
+#  define DC_GCFG_DFHPEL_POS	      12
+#  define DC_GCFG_STFM	      0x00010000
+#  define DC_GCFG_FDTY	      0x00020000
+#  define DC_GCFG_VGAFT	      0x00040000
+#  define DC_GCFG_VDSE	      0x00080000
+#  define DC_GCFG_YUVM	      0x00100000
+#  define DC_GCFG_VFSL	      0x00800000
+#  define DC_GCFG_SIGE	      0x01000000
+#  define DC_GCFG_SGRE	      0x02000000
+#  define DC_GCFG_SGFR	      0x04000000
+#  define DC_GCFG_CRC_MODE    0x08000000
+#  define DC_GCFG_DIAG	      0x10000000
+#  define DC_GCFG_CFRW	      0x20000000
+
+#define DC_DISPLAY_CFG 0x08
+#  define DC_DCFG_TGEN            0x00000001
+#  define DC_DCFG_GDEN            0x00000008
+#  define DC_DCFG_VDEN            0x00000010
+#  define DC_DCFG_TRUP            0x00000040
+#  define DC_DCFG_DISP_MODE_MASK  0x00000300
+#  define DC_DCFG_DISP_MODE_8BPP  0x00000000
+#  define DC_DCFG_DISP_MODE_16BPP 0x00000100
+#  define DC_DCFG_DISP_MODE_24BPP 0x00000200
+#  define DC_DCFG_16BPP_MODE_MASK 0x00000c00
+#  define DC_DCFG_16BPP_MODE_565  0x00000000
+#  define DC_DCFG_16BPP_MODE_555  0x00000100
+#  define DC_DCFG_16BPP_MODE_444  0x00000200
+#  define DC_DCFG_DCEN            0x00080000
+#  define DC_DCFG_PALB            0x02000000
+#  define DC_DCFG_FRLK            0x04000000
+#  define DC_DCFG_VISL            0x08000000
+#  define DC_DCFG_FRSL            0x20000000
+#  define DC_DCFG_A18M            0x40000000
+#  define DC_DCFG_A20M            0x80000000
+
+#define DC_FB_ST_OFFSET 0x10
+
+#define DC_LINE_SIZE 0x30
+#  define DC_LINE_SIZE_FB_LINE_SIZE_MASK  0x000007ff
+#  define DC_LINE_SIZE_FB_LINE_SIZE_POS            0
+#  define DC_LINE_SIZE_CB_LINE_SIZE_MASK  0x007f0000
+#  define DC_LINE_SIZE_CB_LINE_SIZE_POS           16
+#  define DC_LINE_SIZE_VID_LINE_SIZE_MASK 0xff000000
+#  define DC_LINE_SIZE_VID_LINE_SIZE_POS          24
+
+#define DC_GFX_PITCH 0x34
+#  define DC_GFX_PITCH_FB_PITCH_MASK 0x0000ffff
+#  define DC_GFX_PITCH_FB_PITCH_POS           0
+#  define DC_GFX_PITCH_CB_PITCH_MASK 0xffff0000
+#  define DC_GFX_PITCH_CB_PITCH_POS          16
+
+#define DC_H_ACTIVE_TIMING 0x40
+#define DC_H_BLANK_TIMING  0x44
+#define DC_H_SYNC_TIMING   0x48
+#define DC_V_ACTIVE_TIMING 0x50
+#define DC_V_BLANK_TIMING  0x54
+#define DC_V_SYNC_TIMING   0x58
+
+#define DC_PAL_ADDRESS 0x70
+#define DC_PAL_DATA    0x74
+
+#endif /* !__DISPLAY_GX1_H__ */
Index: linux-2.6-working/drivers/video/geode/gxfb_core.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/drivers/video/geode/gxfb_core.c	2006-01-31 17:00:19.000000000 +0000
@@ -0,0 +1,423 @@
+/*
+ * Geode GX framebuffer driver.
+ *
+ *   Copyright (C) 2006 Arcom Control Systems Ltd.
+ *
+ *   This program is free software; you can redistribute it and/or modify it
+ *   under the terms of the GNU General Public License as published by the
+ *   Free Software Foundation; either version 2 of the License, or (at your
+ *   option) any later version.
+ *
+ *
+ * This driver assumes that the BIOS has created a virtual PCI device header
+ * for the video device. The PCI header is assumed to contain the following
+ * BARs:
+ *
+ *    BAR0 - framebuffer memory
+ *    BAR1 - graphics processor registers
+ *    BAR2 - display controller registers
+ *    BAR3 - video processor and flat panel control registers.
+ *
+ * 16 MiB of framebuffer memory is assumed to be available.
+ */
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
+#include "display_gx.h"
+#include "video_gx.h"
+
+static char mode_option[32] = "640x480-16@60";
+
+/* Modes relevant to the GX (taken from modedb.c) */
+static const struct fb_videomode __initdata gx_modedb[] = {
+	/* 640x480-60 VESA */
+	{ NULL, 60, 640, 480, 39682,  48, 16, 33, 10, 96, 2,
+	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 640x480-75 VESA */
+	{ NULL, 75, 640, 480, 31746, 120, 16, 16, 01, 64, 3,
+	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 640x480-85 VESA */
+	{ NULL, 85, 640, 480, 27777, 80, 56, 25, 01, 56, 3,
+	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 800x600-60 VESA */
+	{ NULL, 60, 800, 600, 25000, 88, 40, 23, 01, 128, 4,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 800x600-75 VESA */
+	{ NULL, 75, 800, 600, 20202, 160, 16, 21, 01, 80, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 800x600-85 VESA */
+	{ NULL, 85, 800, 600, 17761, 152, 32, 27, 01, 64, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1024x768-60 VESA */
+	{ NULL, 60, 1024, 768, 15384, 160, 24, 29, 3, 136, 6,
+	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1024x768-75 VESA */
+	{ NULL, 75, 1024, 768, 12690, 176, 16, 28, 1, 96, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1024x768-85 VESA */
+	{ NULL, 85, 1024, 768, 10582, 208, 48, 36, 1, 96, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1280x960-60 VESA */
+	{ NULL, 60, 1280, 960, 9259, 312, 96, 36, 1, 112, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1280x960-85 VESA */
+	{ NULL, 85, 1280, 960, 6734, 224, 64, 47, 1, 160, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1280x1024-60 VESA */
+	{ NULL, 60, 1280, 1024, 9259, 248, 48, 38, 1, 112, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1280x1024-75 VESA */
+	{ NULL, 75, 1280, 1024, 7407, 248, 16, 38, 1, 144, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1280x1024-85 VESA */
+	{ NULL, 85, 1280, 1024, 6349, 224, 64, 44, 1, 160, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1600x1200-60 VESA */
+	{ NULL, 60, 1600, 1200, 6172, 304, 64, 46, 1, 192, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1600x1200-75 VESA */
+	{ NULL, 75, 1600, 1200, 4938, 304, 64, 46, 1, 192, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 1600x1200-85 VESA */
+	{ NULL, 85, 1600, 1200, 4357, 304, 64, 46, 1, 192, 3,
+	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+};
+
+static int gxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	if (var->xres > 1600 || var->yres > 1200)
+		return -EINVAL;
+	if ((var->xres > 1280 || var->yres > 1024) && var->bits_per_pixel > 16)
+		return -EINVAL;
+
+	if (var->bits_per_pixel == 32) {
+		var->red.offset   = 16; var->red.length   = 8;
+		var->green.offset =  8; var->green.length = 8;
+		var->blue.offset  =  0; var->blue.length  = 8;
+	} else if (var->bits_per_pixel == 16) {
+		var->red.offset   = 11; var->red.length   = 5;
+		var->green.offset =  5; var->green.length = 6;
+		var->blue.offset  =  0; var->blue.length  = 5;
+	} else if (var->bits_per_pixel == 8) {
+		var->red.offset   = 0; var->red.length   = 8;
+		var->green.offset = 0; var->green.length = 8;
+		var->blue.offset  = 0; var->blue.length  = 8;
+	} else
+		return -EINVAL;
+	var->transp.offset = 0; var->transp.length = 0;
+
+	/* Enough video memory? */
+	if (gx_line_delta(var->xres, var->bits_per_pixel) * var->yres > info->fix.smem_len)
+		return -EINVAL;
+
+	/* FIXME: Check timing parameters here? */
+
+	return 0;
+}
+
+static int gxfb_set_par(struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+
+	if (info->var.bits_per_pixel > 8) {
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+		fb_dealloc_cmap(&info->cmap);
+	} else {
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		fb_alloc_cmap(&info->cmap, 1<<info->var.bits_per_pixel, 0);
+	}
+
+	info->fix.line_length = gx_line_delta(info->var.xres, info->var.bits_per_pixel);
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
+static int gxfb_setcolreg(unsigned regno, unsigned red, unsigned green,
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
+static int gxfb_blank(int blank_mode, struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+
+	return par->vid_ops->blank_display(info, blank_mode);
+}
+
+static int __init gxfb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
+{
+	struct geodefb_par *par = info->par;
+	int fb_len;
+	int ret;
+
+	ret = pci_enable_device(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = pci_request_region(dev, 3, "gxfb (video processor)");
+	if (ret < 0)
+		return ret;
+	par->vid_regs = ioremap(pci_resource_start(dev, 3),
+				pci_resource_len(dev, 3));
+	if (!par->vid_regs)
+		return -ENOMEM;
+
+	ret = pci_request_region(dev, 2, "gxfb (display controller)");
+	if (ret < 0)
+		return ret;
+	par->dc_regs = ioremap(pci_resource_start(dev, 2), pci_resource_len(dev, 2));
+	if (!par->dc_regs)
+		return -ENOMEM;
+
+	ret = pci_request_region(dev, 0, "gxfb (framebuffer)");
+	if (ret < 0)
+		return ret;
+	if ((fb_len = gx_frame_buffer_size()) < 0)
+		return -ENOMEM;
+	info->fix.smem_start = pci_resource_start(dev, 0);
+	info->fix.smem_len = fb_len;
+	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
+	if (!info->screen_base)
+		return -ENOMEM;
+
+	dev_info(&dev->dev, "%d Kibyte of video memory at 0x%lx\n",
+		 info->fix.smem_len / 1024, info->fix.smem_start);
+
+	return 0;
+}
+
+static struct fb_ops gxfb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_check_var	= gxfb_check_var,
+	.fb_set_par	= gxfb_set_par,
+	.fb_setcolreg	= gxfb_setcolreg,
+	.fb_blank       = gxfb_blank,
+	/* No HW acceleration for now. */
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+};
+
+static struct fb_info * __init gxfb_init_fbinfo(struct device *dev)
+{
+	struct geodefb_par *par;
+	struct fb_info *info;
+
+	/* Alloc enough space for the pseudo palette. */
+	info = framebuffer_alloc(sizeof(struct geodefb_par) + sizeof(u32) * 16, dev);
+	if (!info)
+		return NULL;
+
+	par = info->par;
+
+	strcpy(info->fix.id, "Geode GX");
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
+	info->fbops		= &gxfb_ops;
+	info->flags		= FBINFO_DEFAULT;
+	info->node		= -1;
+
+	info->pseudo_palette	= (void *)par + sizeof(struct geodefb_par);
+
+	info->var.grayscale	= 0;
+
+	return info;
+}
+
+static int __init gxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct geodefb_par *par;
+	struct fb_info *info;
+	int ret;
+
+	info = gxfb_init_fbinfo(&pdev->dev);
+	if (!info)
+		return -ENOMEM;
+	par = info->par;
+
+	/* GX display controller and GX video device. */
+	par->dc_ops  = &gx_dc_ops;
+	par->vid_ops = &gx_vid_ops;
+
+	if ((ret = gxfb_map_video_memory(info, pdev)) < 0) {
+		dev_err(&pdev->dev, "failed to map frame buffer or controller registers\n");
+		goto err;
+	}
+
+	ret = fb_find_mode(&info->var, info, mode_option,
+			   gx_modedb, ARRAY_SIZE(gx_modedb), NULL, 16);
+	if (ret == 0 || ret == 4) {
+		dev_err(&pdev->dev, "could not find valid video mode\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+        /* Clear the frame buffer of garbage. */
+        memset_io(info->screen_base, 0, info->fix.smem_len);
+
+	gxfb_check_var(&info->var, info);
+	gxfb_set_par(info);
+
+	if (register_framebuffer(info) < 0) {
+		ret = -EINVAL;
+		goto err;
+	}
+	pci_set_drvdata(pdev, info);
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node, info->fix.id);
+	return 0;
+
+  err:
+	if (info->screen_base) {
+		iounmap(info->screen_base);
+		pci_release_region(pdev, 0);
+	}
+	if (par->vid_regs) {
+		iounmap(par->vid_regs);
+		pci_release_region(pdev, 3);
+	}
+	if (par->dc_regs) {
+		iounmap(par->dc_regs);
+		pci_release_region(pdev, 2);
+	}
+
+	pci_disable_device(pdev);
+
+	if (info)
+		framebuffer_release(info);
+	return ret;
+}
+
+static void gxfb_remove(struct pci_dev *pdev)
+{
+	struct fb_info *info = pci_get_drvdata(pdev);
+	struct geodefb_par *par = info->par;
+
+	unregister_framebuffer(info);
+
+	iounmap((void __iomem *)info->screen_base);
+	pci_release_region(pdev, 0);
+
+	iounmap(par->vid_regs);
+	pci_release_region(pdev, 3);
+
+	iounmap(par->dc_regs);
+	pci_release_region(pdev, 2);
+
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+
+	framebuffer_release(info);
+}
+
+static struct pci_device_id gxfb_id_table[] = {
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_VIDEO,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
+	  0xff0000, 0 },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, gxfb_id_table);
+
+static struct pci_driver gxfb_driver = {
+	.name		= "gxfb",
+	.id_table	= gxfb_id_table,
+	.probe		= gxfb_probe,
+	.remove		= gxfb_remove,
+};
+
+static int __init gxfb_init(void)
+{
+#ifndef MODULE
+	if (fb_get_options("gxfb", NULL))
+		return -ENODEV;
+#endif
+	return pci_register_driver(&gxfb_driver);
+}
+
+static void __exit gxfb_cleanup(void)
+{
+	pci_unregister_driver(&gxfb_driver);
+}
+
+module_init(gxfb_init);
+module_exit(gxfb_cleanup);
+
+module_param_string(mode, mode_option, sizeof(mode_option), 0444);
+MODULE_PARM_DESC(mode, "video mode (<x>x<y>[-<bpp>][@<refr>])");
+
+MODULE_DESCRIPTION("Framebuffer driver for the AMD Geode GX");
+MODULE_LICENSE("GPL");
Index: linux-2.6-working/drivers/video/geode/video_gx.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/drivers/video/geode/video_gx.c	2006-01-31 17:00:54.000000000 +0000
@@ -0,0 +1,217 @@
+/*
+ * Geode GX video processor device.
+ *
+ *   Copyright (C) 2006 Arcom Control Systems Ltd.
+ *
+ *   Portions from AMD's original 2.4 driver:
+ *     Copyright (C) 2004 Advanced Micro Devices, Inc.
+ *
+ *   This program is free software; you can redistribute it and/or modify it
+ *   under the terms of the GNU General Public License as published by the
+ *   Free Software Foundation; either version 2 of the License, or (at your
+ *   option) any later version.
+ */
+#include <linux/fb.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <asm/delay.h>
+#include <asm/msr.h>
+
+#include "geodefb.h"
+#include "video_gx.h"
+
+
+/*
+ * Tables of register settings for various DOTCLKs.
+ */
+struct gx_pll_entry {
+	long pixclock; /* ps */
+	u32 sys_rstpll_bits;
+	u32 dotpll_value;
+};
+
+#define POSTDIV3 ((u32)MSR_GLCP_SYS_RSTPLL_DOTPOSTDIV3)
+#define PREMULT2 ((u32)MSR_GLCP_SYS_RSTPLL_DOTPREMULT2)
+#define PREDIV2  ((u32)MSR_GLCP_SYS_RSTPLL_DOTPOSTDIV3)
+
+struct gx_pll_entry gx_pll_table_48MHz[] = {
+	{ 40123, POSTDIV3,	    0x00000BF2 },	/*  24.9230 */
+	{ 39721, 0,		    0x00000037 },	/*  25.1750 */
+	{ 35308, POSTDIV3|PREMULT2, 0x00000B1A },	/*  28.3220 */
+	{ 31746, POSTDIV3,	    0x000002D2 },	/*  31.5000 */
+	{ 27777, POSTDIV3|PREMULT2, 0x00000FE2 },	/*  36.0000 */
+	{ 26666, POSTDIV3,	    0x0000057A },	/*  37.5000 */
+	{ 25000, POSTDIV3,	    0x0000030A },	/*  40.0000 */
+	{ 22271, 0,		    0x00000063 },	/*  44.9000 */
+	{ 20202, 0,		    0x0000054B },	/*  49.5000 */
+	{ 20000, 0,		    0x0000026E },	/*  50.0000 */
+	{ 19860, PREMULT2,	    0x00000037 },	/*  50.3500 */
+	{ 18518, POSTDIV3|PREMULT2, 0x00000B0D },	/*  54.0000 */
+	{ 17777, 0,		    0x00000577 },	/*  56.2500 */
+	{ 17733, 0,		    0x000007F7 },	/*  56.3916 */
+	{ 17653, 0,		    0x0000057B },	/*  56.6444 */
+	{ 16949, PREMULT2,	    0x00000707 },	/*  59.0000 */
+	{ 15873, POSTDIV3|PREMULT2, 0x00000B39 },	/*  63.0000 */
+	{ 15384, POSTDIV3|PREMULT2, 0x00000B45 },	/*  65.0000 */
+	{ 14814, POSTDIV3|PREMULT2, 0x00000FC1 },	/*  67.5000 */
+	{ 14124, POSTDIV3,	    0x00000561 },	/*  70.8000 */
+	{ 13888, POSTDIV3,	    0x000007E1 },	/*  72.0000 */
+	{ 13426, PREMULT2,	    0x00000F4A },	/*  74.4810 */
+	{ 13333, 0,		    0x00000052 },	/*  75.0000 */
+	{ 12698, 0,		    0x00000056 },	/*  78.7500 */
+	{ 12500, POSTDIV3|PREMULT2, 0x00000709 },	/*  80.0000 */
+	{ 11135, PREMULT2,	    0x00000262 },	/*  89.8000 */
+	{ 10582, 0,		    0x000002D2 },	/*  94.5000 */
+	{ 10101, PREMULT2,	    0x00000B4A },	/*  99.0000 */
+	{ 10000, PREMULT2,	    0x00000036 },	/* 100.0000 */
+	{  9259, 0,		    0x000007E2 },	/* 108.0000 */
+	{  8888, 0,		    0x000007F6 },	/* 112.5000 */
+	{  7692, POSTDIV3|PREMULT2, 0x00000FB0 },	/* 130.0000 */
+	{  7407, POSTDIV3|PREMULT2, 0x00000B50 },	/* 135.0000 */
+	{  6349, 0,		    0x00000055 },	/* 157.5000 */
+	{  6172, 0,		    0x000009C1 },	/* 162.0000 */
+	{  5787, PREMULT2,	    0x0000002D },	/* 172.798  */
+	{  5698, 0,		    0x000002C1 },	/* 175.5000 */
+	{  5291, 0,		    0x000002D1 },	/* 189.0000 */
+	{  4938, 0,		    0x00000551 },	/* 202.5000 */
+	{  4357, 0,		    0x0000057D },	/* 229.5000 */
+};
+
+static void gx_set_dclk_frequency(struct fb_info *info)
+{
+	struct gx_pll_entry *pll_table;
+	int i, best_i;
+	long min, diff;
+	u64 dotpll, sys_rstpll;
+	int timeout = 1000;
+
+	/* FIXME: Handle rev 1 Geode GXs with a 14 MHz reference clock */
+	pll_table = gx_pll_table_48MHz;
+
+	/* Search the table for the closest pixclock. */
+	best_i = 0;
+	min = pll_table[0].pixclock - info->var.pixclock;
+	if (min < 0) min = -min;
+	for (i = 1; i < ARRAY_SIZE(gx_pll_table_48MHz); i++) {
+		diff = pll_table[i].pixclock - info->var.pixclock;
+		if (diff < 0L) diff = -diff;
+		if (diff < min) {
+			min = diff;
+			best_i = i;
+		}
+	}
+
+	rdmsrl(MSR_GLCP_SYS_RSTPLL, sys_rstpll);
+	rdmsrl(MSR_GLCP_DOTPLL, dotpll);
+
+	/* Program new M, N and P. */
+	dotpll &= 0x00000000ffffffffull;
+	dotpll |= (u64)pll_table[best_i].dotpll_value << 32;
+	dotpll |= MSR_GLCP_DOTPLL_DOTRESET;
+	dotpll &= ~MSR_GLCP_DOTPLL_BYPASS;
+
+	wrmsrl(MSR_GLCP_DOTPLL, dotpll);
+
+	/* Program dividers. */
+	sys_rstpll &= ~( MSR_GLCP_SYS_RSTPLL_DOTPREDIV2
+			 | MSR_GLCP_SYS_RSTPLL_DOTPREMULT2
+			 | MSR_GLCP_SYS_RSTPLL_DOTPOSTDIV3 );
+	sys_rstpll |= pll_table[best_i].sys_rstpll_bits;
+
+	wrmsrl(MSR_GLCP_SYS_RSTPLL, sys_rstpll);
+
+	/* Clear reset bit to start PLL. */
+	dotpll &= ~(MSR_GLCP_DOTPLL_DOTRESET);
+	wrmsrl(MSR_GLCP_DOTPLL, dotpll);
+
+	/* Wait for LOCK bit. */
+	do {
+		rdmsrl(MSR_GLCP_DOTPLL, dotpll);
+	} while (timeout-- && !(dotpll & MSR_GLCP_DOTPLL_LOCK));
+}
+
+static void gx_configure_display(struct fb_info *info)
+{
+	struct geodefb_par *par = info->par;
+	u32 dcfg, fp_pm;
+
+	dcfg = readl(par->vid_regs + GX_DCFG);
+
+	/* Clear bits from existing mode. */
+	dcfg &= ~(GX_DCFG_CRT_SYNC_SKW_MASK
+		  | GX_DCFG_CRT_HSYNC_POL   | GX_DCFG_CRT_VSYNC_POL
+		  | GX_DCFG_VSYNC_EN        | GX_DCFG_HSYNC_EN);
+
+	/* Set default sync skew.  */
+	dcfg |= GX_DCFG_CRT_SYNC_SKW_DFLT;
+
+	/* Enable hsync and vsync. */
+	dcfg |= GX_DCFG_HSYNC_EN | GX_DCFG_VSYNC_EN;
+
+	/* Sync polarities. */
+	if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
+		dcfg |= GX_DCFG_CRT_HSYNC_POL;
+	if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
+		dcfg |= GX_DCFG_CRT_VSYNC_POL;
+
+	writel(dcfg, par->vid_regs + GX_DCFG);
+
+	/* Power on flat panel. */
+	fp_pm = readl(par->vid_regs + GX_FP_PM);
+	fp_pm |= GX_FP_PM_P;
+	writel(fp_pm, par->vid_regs + GX_FP_PM);
+}
+
+static int gx_blank_display(struct fb_info *info, int blank_mode)
+{
+	struct geodefb_par *par = info->par;
+	u32 dcfg, fp_pm;
+	int blank, hsync, vsync;
+
+	/* CRT power saving modes. */
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
+	dcfg = readl(par->vid_regs + GX_DCFG);
+	dcfg &= ~(GX_DCFG_DAC_BL_EN
+		  | GX_DCFG_HSYNC_EN | GX_DCFG_VSYNC_EN);
+	if (!blank)
+		dcfg |= GX_DCFG_DAC_BL_EN;
+	if (hsync)
+		dcfg |= GX_DCFG_HSYNC_EN;
+	if (vsync)
+		dcfg |= GX_DCFG_VSYNC_EN;
+	writel(dcfg, par->vid_regs + GX_DCFG);
+
+	/* Power on/off flat panel. */
+	fp_pm = readl(par->vid_regs + GX_FP_PM);
+	if (blank_mode == FB_BLANK_POWERDOWN)
+		fp_pm &= ~GX_FP_PM_P;
+	else
+		fp_pm |= GX_FP_PM_P;
+	writel(fp_pm, par->vid_regs + GX_FP_PM);
+
+	return 0;
+}
+
+struct geode_vid_ops gx_vid_ops = {
+	.set_dclk	   = gx_set_dclk_frequency,
+	.configure_display = gx_configure_display,
+	.blank_display	   = gx_blank_display,
+};
Index: linux-2.6-working/drivers/video/geode/video_gx.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/drivers/video/geode/video_gx.h	2006-01-31 16:59:51.000000000 +0000
@@ -0,0 +1,47 @@
+/*
+ * Geode GX video device
+ *
+ * Copyright (C) 2006 Arcom Control Systems Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __VIDEO_GX_H__
+#define __VIDEO_GX_H__
+
+extern struct geode_vid_ops gx_vid_ops;
+
+/* Geode GX video processor registers */
+
+#define GX_DCFG		0x0008
+#  define GX_DCFG_CRT_EN		0x00000001
+#  define GX_DCFG_HSYNC_EN		0x00000002
+#  define GX_DCFG_VSYNC_EN		0x00000004
+#  define GX_DCFG_DAC_BL_EN		0x00000008
+#  define GX_DCFG_CRT_HSYNC_POL		0x00000100
+#  define GX_DCFG_CRT_VSYNC_POL		0x00000200
+#  define GX_DCFG_CRT_SYNC_SKW_MASK	0x0001C000
+#  define GX_DCFG_CRT_SYNC_SKW_DFLT	0x00010000
+#  define GX_DCFG_VG_CK			0x00100000
+#  define GX_DCFG_GV_GAM		0x00200000
+#  define GX_DCFG_DAC_VREF		0x04000000
+
+/* Geode GX flat panel display control registers */
+#define GX_FP_PM 0x410
+#  define GX_FP_PM_P 0x01000000
+
+/* Geode GX clock control MSRs */
+
+#define MSR_GLCP_SYS_RSTPLL	0x4c000014
+#  define MSR_GLCP_SYS_RSTPLL_DOTPREDIV2	(0x0000000000000002ull)
+#  define MSR_GLCP_SYS_RSTPLL_DOTPREMULT2	(0x0000000000000004ull)
+#  define MSR_GLCP_SYS_RSTPLL_DOTPOSTDIV3	(0x0000000000000008ull)
+
+#define MSR_GLCP_DOTPLL		0x4c000015
+#  define MSR_GLCP_DOTPLL_DOTRESET		(0x0000000000000001ull)
+#  define MSR_GLCP_DOTPLL_BYPASS		(0x0000000000008000ull)
+#  define MSR_GLCP_DOTPLL_LOCK			(0x0000000002000000ull)
+
+#endif /* !__VIDEO_GX_H__ */

--------------060804020404080609000700--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
