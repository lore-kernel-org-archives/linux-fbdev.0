From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH] fb: add support of LCD display
	controller on pxa168/910 (base layer)
Date: Thu, 21 May 2009 17:03:33 +0800
Message-ID: <f17812d70905210203se23d5e7ya60cbb6eb93815aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1M74Bg-00019a-G4
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 May 2009 09:03:40 +0000
Received: from mail-qy0-f108.google.com ([209.85.221.108])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M74Ba-0005LO-TZ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 May 2009 09:03:40 +0000
Received: by qyk6 with SMTP id 6so1711929qyk.28
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 21 May 2009 02:03:33 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: Green Wan <gwan@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, Jun Nie <njun@marvell.com>, Peter Liao <pliao@marvell.com>, Lennert Buijtenhek <buytenh@marvell.com>, Kevin Liu <kliu5@marvell.com>

This driver is originally written by Lennert, modified by Green to be
feature complete,  and ported by Jun Nie and Kevin Liu for pxa168/910
processors.

The patch adds support for the on-chip LCD display controller, it
currently supports the base (graphics) layer only.

Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
Signed-off-by: Green Wan <gwan@marvell.com>
Cc: Peter Liao <pliao@marvell.com>
Signed-off-by: Jun Nie <njun@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/video/Kconfig    |   10 +
 drivers/video/Makefile   |    1 +
 drivers/video/pxa168fb.c |  821 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/pxa168fb.h |  558 +++++++++++++++++++++++++++++++
 include/video/pxa168fb.h |  138 ++++++++
 5 files changed, 1528 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/pxa168fb.c
 create mode 100644 drivers/video/pxa168fb.h
 create mode 100644 include/video/pxa168fb.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0048f11..0991bf4 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1759,6 +1759,16 @@ config FB_68328
 	  Say Y here if you want to support the built-in frame buffer of
 	  the Motorola 68328 CPU family.

+config FB_PXA168
+	tristate "PXA168 LCD framebuffer support"
+	depends on FB && CPU_PXA168
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	---help---
+	  Frame buffer driver for the built-in LCD controller in the Marvell
+	  MMP processor.
+
 config FB_PXA
 	tristate "PXA LCD framebuffer support"
 	depends on FB && ARCH_PXA
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index d8d0be5..01a819f 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_FB_GBE)              += gbefb.o
 obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o
 obj-$(CONFIG_FB_ASILIANT)	  += asiliantfb.o
 obj-$(CONFIG_FB_PXA)		  += pxafb.o
+obj-$(CONFIG_FB_PXA168)		  += pxa168fb.o
 obj-$(CONFIG_FB_W100)		  += w100fb.o
 obj-$(CONFIG_FB_TMIO)		  += tmiofb.o
 obj-$(CONFIG_FB_AU1100)		  += au1100fb.o
diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
new file mode 100644
index 0000000..47c8b8b
--- /dev/null
+++ b/drivers/video/pxa168fb.c
@@ -0,0 +1,821 @@
+/*
+ * linux/drivers/video/pxa168fb.c -- Marvell PXA168 LCD Controller
+ *
+ *  Copyright (C) 2008 Marvell International Ltd.
+ *  All rights reserved.
+ *
+ *  2009-02-16  adapted from original version for PXA168/910
+ *              Jun Nie <njun@marvell.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/fb.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/uaccess.h>
+#include <video/pxa168fb.h>
+
+#include "pxa168fb.h"
+
+#define DEFAULT_REFRESH		60	/* Hz */
+
+static int determine_best_pix_fmt(struct fb_var_screeninfo *var)
+{
+	/*
+	 * Pseudocolor mode?
+	 */
+	if (var->bits_per_pixel == 8)
+		return PIX_FMT_PSEUDOCOLOR;
+
+	/*
+	 * Check for 565/1555.
+	 */
+	if (var->bits_per_pixel == 16 && var->red.length <= 5 &&
+	    var->green.length <= 6 && var->blue.length <= 5) {
+		if (var->transp.length == 0) {
+			if (var->red.offset >= var->blue.offset)
+				return PIX_FMT_RGB565;
+			else
+				return PIX_FMT_BGR565;
+		}
+
+		if (var->transp.length == 1 && var->green.length <= 5) {
+			if (var->red.offset >= var->blue.offset)
+				return PIX_FMT_RGB1555;
+			else
+				return PIX_FMT_BGR1555;
+		}
+
+		/* fall through */
+	}
+
+	/*
+	 * Check for 888/A888.
+	 */
+	if (var->bits_per_pixel <= 32 && var->red.length <= 8 &&
+	    var->green.length <= 8 && var->blue.length <= 8) {
+		if (var->bits_per_pixel == 24 && var->transp.length == 0) {
+			if (var->red.offset >= var->blue.offset)
+				return PIX_FMT_RGB888PACK;
+			else
+				return PIX_FMT_BGR888PACK;
+		}
+
+		if (var->bits_per_pixel == 32 && var->transp.length == 8) {
+			if (var->red.offset >= var->blue.offset)
+				return PIX_FMT_RGBA888;
+			else
+				return PIX_FMT_BGRA888;
+		} else {
+			if (var->red.offset >= var->blue.offset)
+				return PIX_FMT_RGB888UNPACK;
+			else
+				return PIX_FMT_BGR888UNPACK;
+		}
+
+		/* fall through */
+	}
+
+	return -EINVAL;
+}
+
+static void set_pix_fmt(struct fb_var_screeninfo *var, int pix_fmt)
+{
+	switch (pix_fmt) {
+	case PIX_FMT_RGB565:
+		var->bits_per_pixel = 16;
+		var->red.offset = 11;    var->red.length = 5;
+		var->green.offset = 5;   var->green.length = 6;
+		var->blue.offset = 0;    var->blue.length = 5;
+		var->transp.offset = 0;  var->transp.length = 0;
+		break;
+	case PIX_FMT_BGR565:
+		var->bits_per_pixel = 16;
+		var->red.offset = 0;     var->red.length = 5;
+		var->green.offset = 5;   var->green.length = 6;
+		var->blue.offset = 11;   var->blue.length = 5;
+		var->transp.offset = 0;  var->transp.length = 0;
+		break;
+	case PIX_FMT_RGB1555:
+		var->bits_per_pixel = 16;
+		var->red.offset = 10;    var->red.length = 5;
+		var->green.offset = 5;   var->green.length = 5;
+		var->blue.offset = 0;    var->blue.length = 5;
+		var->transp.offset = 15; var->transp.length = 1;
+		break;
+	case PIX_FMT_BGR1555:
+		var->bits_per_pixel = 16;
+		var->red.offset = 0;     var->red.length = 5;
+		var->green.offset = 5;   var->green.length = 5;
+		var->blue.offset = 10;   var->blue.length = 5;
+		var->transp.offset = 15; var->transp.length = 1;
+		break;
+	case PIX_FMT_RGB888PACK:
+		var->bits_per_pixel = 24;
+		var->red.offset = 16;    var->red.length = 8;
+		var->green.offset = 8;   var->green.length = 8;
+		var->blue.offset = 0;    var->blue.length = 8;
+		var->transp.offset = 0;  var->transp.length = 0;
+		break;
+	case PIX_FMT_BGR888PACK:
+		var->bits_per_pixel = 24;
+		var->red.offset = 0;     var->red.length = 8;
+		var->green.offset = 8;   var->green.length = 8;
+		var->blue.offset = 16;   var->blue.length = 8;
+		var->transp.offset = 0;  var->transp.length = 0;
+		break;
+	case PIX_FMT_RGBA888:
+		var->bits_per_pixel = 32;
+		var->red.offset = 16;    var->red.length = 8;
+		var->green.offset = 8;   var->green.length = 8;
+		var->blue.offset = 0;    var->blue.length = 8;
+		var->transp.offset = 24; var->transp.length = 8;
+		break;
+	case PIX_FMT_BGRA888:
+		var->bits_per_pixel = 32;
+		var->red.offset = 0;     var->red.length = 8;
+		var->green.offset = 8;   var->green.length = 8;
+		var->blue.offset = 16;   var->blue.length = 8;
+		var->transp.offset = 24; var->transp.length = 8;
+		break;
+	case PIX_FMT_PSEUDOCOLOR:
+		var->bits_per_pixel = 8;
+		var->red.offset = 0;     var->red.length = 8;
+		var->green.offset = 0;   var->green.length = 8;
+		var->blue.offset = 0;    var->blue.length = 8;
+		var->transp.offset = 0;  var->transp.length = 0;
+		break;
+	}
+}
+
+static void set_mode(struct pxa168fb_info *fbi, struct fb_var_screeninfo *var,
+		     struct fb_videomode *mode, int pix_fmt, int ystretch)
+{
+	set_pix_fmt(var, pix_fmt);
+
+	var->xres = mode->xres;
+	var->yres = mode->yres;
+	var->xres_virtual = max(var->xres, var->xres_virtual);
+	if (ystretch)
+		var->yres_virtual = fbi->fb_size /
+			(var->xres_virtual * (var->bits_per_pixel >> 3));
+	else
+		var->yres_virtual = max(var->yres, var->yres_virtual);
+	var->grayscale = 0;
+	var->accel_flags = FB_ACCEL_NONE;
+	var->pixclock = mode->pixclock;
+	var->left_margin = mode->left_margin;
+	var->right_margin = mode->right_margin;
+	var->upper_margin = mode->upper_margin;
+	var->lower_margin = mode->lower_margin;
+	var->hsync_len = mode->hsync_len;
+	var->vsync_len = mode->vsync_len;
+	var->sync = mode->sync;
+	var->vmode = FB_VMODE_NONINTERLACED;
+	var->rotate = FB_ROTATE_UR;
+}
+
+static int pxa168fb_check_var(struct fb_var_screeninfo *var,
+			      struct fb_info *info)
+{
+	struct pxa168fb_info *fbi = info->par;
+
+	if (var->bits_per_pixel == 8)
+		return -EINVAL;
+	/*
+	 * Basic geometry sanity checks.
+	 */
+	if (var->xoffset + var->xres > var->xres_virtual)
+		return -EINVAL;
+	if (var->yoffset + var->yres > var->yres_virtual)
+		return -EINVAL;
+	if (var->xres + var->right_margin +
+	    var->hsync_len + var->left_margin > 2048)
+		return -EINVAL;
+	if (var->yres + var->lower_margin +
+	    var->vsync_len + var->upper_margin > 2048)
+		return -EINVAL;
+
+	/*
+	 * Check size of framebuffer.
+	 */
+	if (var->xres_virtual * var->yres_virtual *
+	    (var->bits_per_pixel >> 3) > fbi->fb_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * The hardware clock divider has an integer and a fractional
+ * stage:
+ *
+ *	clk2 = clk_in / integer_divider
+ *	clk_out = clk2 * (1 - (fractional_divider >> 12))
+ *
+ * Calculate integer and fractional divider for given clk_in
+ * and clk_out.
+ */
+static void set_clock_divider(struct pxa168fb_info *fbi,
+			      const struct fb_videomode *m)
+{
+	int divider_int;
+	int needed_pixclk;
+	u64 div_result;
+	u32 x = 0;
+
+	/*
+	 * Notice: The field pixclock is used by linux fb
+	 * is in pixel second. E.g. struct fb_videomode &
+	 * struct fb_var_screeninfo
+	 */
+
+	/*
+	 * Check input values.
+	 */
+	if (!m || !m->pixclock || !m->refresh) {
+		printk(KERN_ERR "Input refresh or pixclock is wrong.\n");
+		return;
+	}
+
+	/*
+	 * Using PLL/AXI clock.
+	 */
+	x = 0x80000000;
+
+	/*
+	 * Calc divider according to refresh rate.
+	 */
+	div_result = 1000000000000ll;
+	do_div(div_result, m->pixclock);
+	needed_pixclk = (u32)div_result;
+
+	divider_int = clk_get_rate(fbi->clk) / needed_pixclk;
+
+	/* check whether divisor is too small. */
+	if (divider_int < 2) {
+		printk(KERN_WARNING "Warning: clock source is too slow."
+				 "Try smaller resolution\n");
+		divider_int = 2;
+	}
+
+	/*
+	 * Set setting to reg.
+	 */
+	x |= divider_int;
+	writel(x, fbi->reg_base + LCD_CFG_SCLK_DIV);
+}
+
+static void set_dma_control0(struct pxa168fb_info *fbi)
+{
+	u32 x;
+
+	/*
+	 * Set bit to enable graphics DMA.
+	 */
+	x = readl(fbi->reg_base + LCD_SPU_DMA_CTRL0);
+	x |= fbi->active ? 0x00000100 : 0;
+	fbi->active = 0;
+
+	/*
+	 * If we are in a pseudo-color mode, we need to enable
+	 * palette lookup.
+	 */
+	if (fbi->pix_fmt == PIX_FMT_PSEUDOCOLOR)
+		x |= 0x10000000;
+
+	/*
+	 * Configure hardware pixel format.
+	 */
+	x &= ~(0xF << 16);
+	x |= (fbi->pix_fmt >> 1) << 16;
+
+	/*
+	 * Check red and blue pixel swap.
+	 * 1. source data swap
+	 * 2. panel output data swap
+	 */
+	x &= ~(1 << 12);
+	x |= ((fbi->pix_fmt & 1) ^ (fbi->panel_rbswap)) << 12;
+
+	writel(x, fbi->reg_base + LCD_SPU_DMA_CTRL0);
+}
+
+static void set_dma_control1(struct pxa168fb_info *fbi, int sync)
+{
+	u32 x;
+
+	/*
+	 * Configure default bits: vsync triggers DMA, gated clock
+	 * enable, power save enable, configure alpha registers to
+	 * display 100% graphics, and set pixel command.
+	 */
+	x = readl(fbi->reg_base + LCD_SPU_DMA_CTRL1);
+	x |= 0x2032ff81;
+
+	/*
+	 * We trigger DMA on the falling edge of vsync if vsync is
+	 * active low, or on the rising edge if vsync is active high.
+	 */
+	if (!(sync & FB_SYNC_VERT_HIGH_ACT))
+		x |= 0x08000000;
+
+
+	writel(x, fbi->reg_base + LCD_SPU_DMA_CTRL1);
+}
+
+static void set_graphics_start(struct fb_info *info, int xoffset, int yoffset)
+{
+	struct pxa168fb_info *fbi = info->par;
+	struct fb_var_screeninfo *var = &info->var;
+	int pixel_offset;
+	unsigned long addr;
+
+	pixel_offset = (yoffset * var->xres_virtual) + xoffset;
+
+	addr = fbi->fb_start_dma + (pixel_offset * (var->bits_per_pixel >> 3));
+	writel(addr, fbi->reg_base + LCD_CFG_GRA_START_ADDR0);
+}
+
+static void set_dumb_panel_control(struct fb_info *info)
+{
+	struct pxa168fb_info *fbi = info->par;
+	struct pxa168fb_mach_info *mi = fbi->dev->platform_data;
+	u32 x;
+
+	/*
+	 * Preserve enable flag.
+	 */
+	x = readl(fbi->reg_base + LCD_SPU_DUMB_CTRL) & 0x00000001;
+
+	x |= (fbi->is_blanked ? 0x7 : mi->dumb_mode) << 28;
+	x |= mi->gpio_output_data << 20;
+	x |= mi->gpio_output_mask << 12;
+	x |= mi->panel_rgb_reverse_lanes ? 0x00000080 : 0;
+	x |= mi->invert_composite_blank ? 0x00000040 : 0;
+	x |= (info->var.sync & FB_SYNC_COMP_HIGH_ACT) ? 0x00000020 : 0;
+	x |= mi->invert_pix_val_ena ? 0x00000010 : 0;
+	x |= (info->var.sync & FB_SYNC_VERT_HIGH_ACT) ? 0 : 0x00000008;
+	x |= (info->var.sync & FB_SYNC_HOR_HIGH_ACT) ? 0 : 0x00000004;
+	x |= mi->invert_pixclock ? 0x00000002 : 0;
+
+	writel(x, fbi->reg_base + LCD_SPU_DUMB_CTRL);
+}
+
+static void set_dumb_screen_dimensions(struct fb_info *info)
+{
+	struct pxa168fb_info *fbi = info->par;
+	struct fb_var_screeninfo *v = &info->var;
+	int x;
+	int y;
+
+	x = v->xres + v->right_margin + v->hsync_len + v->left_margin;
+	y = v->yres + v->lower_margin + v->vsync_len + v->upper_margin;
+
+	writel((y << 16) | x, fbi->reg_base + LCD_SPUT_V_H_TOTAL);
+}
+
+static int pxa168fb_set_par(struct fb_info *info)
+{
+	struct pxa168fb_info *fbi = info->par;
+	struct fb_var_screeninfo *var = &info->var;
+	const struct fb_videomode *m = 0;
+	struct fb_videomode mode;
+	int pix_fmt;
+	u32 x;
+	struct pxa168fb_mach_info *mi;
+
+	mi = fbi->dev->platform_data;
+	/*
+	 * Determine which pixel format we're going to use.
+	 */
+	pix_fmt = determine_best_pix_fmt(&info->var);
+	if (pix_fmt < 0)
+		return pix_fmt;
+	fbi->pix_fmt = pix_fmt;
+
+	/*
+	 * Set additional mode info.
+	 */
+	if (pix_fmt == PIX_FMT_PSEUDOCOLOR)
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+	else
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+	info->fix.line_length = var->xres_virtual * var->bits_per_pixel / 8;
+	info->fix.ypanstep = var->yres;
+
+	/*
+	 * Disable panel output while we setup the display.
+	 */
+	x = readl(fbi->reg_base + LCD_SPU_DUMB_CTRL);
+	writel(x & ~1, fbi->reg_base + LCD_SPU_DUMB_CTRL);
+
+	/*
+	 * Configure global panel parameters.
+	 */
+	writel((var->yres << 16) | var->xres,
+		fbi->reg_base + LCD_SPU_V_H_ACTIVE);
+
+	/*
+	 * convet var to video mode
+	 */
+	fb_var_to_videomode(&mode, &info->var);
+	m = &mode;
+
+	/* Calculate clock divisor. */
+	set_clock_divider(fbi, &mode);
+
+	/* Configure dma ctrl regs. */
+	set_dma_control0(fbi);
+	set_dma_control1(fbi, info->var.sync);
+
+	/*
+	 * Configure graphics DMA parameters.
+	 */
+	set_graphics_start(info, info->var.xoffset, info->var.yoffset);
+	x = readl(fbi->reg_base + LCD_CFG_GRA_PITCH);
+	x = (x & ~0xFFFF) | ((var->xres_virtual * var->bits_per_pixel) >> 3);
+	writel(x, fbi->reg_base + LCD_CFG_GRA_PITCH);
+	writel((var->yres << 16) | var->xres,
+		fbi->reg_base + LCD_SPU_GRA_HPXL_VLN);
+	writel((var->yres << 16) | var->xres,
+		fbi->reg_base + LCD_SPU_GZM_HPXL_VLN);
+
+	/*
+	 * Configure dumb panel ctrl regs & timings.
+	 */
+	set_dumb_panel_control(info);
+	set_dumb_screen_dimensions(info);
+
+	writel((var->left_margin << 16) | var->right_margin,
+			fbi->reg_base + LCD_SPU_H_PORCH);
+	writel((var->upper_margin << 16) | var->lower_margin,
+			fbi->reg_base + LCD_SPU_V_PORCH);
+
+	/*
+	 * Re-enable panel output.
+	 */
+	x = readl(fbi->reg_base + LCD_SPU_DUMB_CTRL);
+	writel(x | 1, fbi->reg_base + LCD_SPU_DUMB_CTRL);
+
+	return 0;
+}
+
+static unsigned int chan_to_field(unsigned int chan, struct fb_bitfield *bf)
+{
+	return ((chan & 0xffff) >> (16 - bf->length)) << bf->offset;
+}
+
+static u32 to_rgb(u16 red, u16 green, u16 blue)
+{
+	red >>= 8;
+	green >>= 8;
+	blue >>= 8;
+
+	return (red << 16) | (green << 8) | blue;
+}
+
+static int
+pxa168fb_setcolreg(unsigned int regno, unsigned int red, unsigned int green,
+		 unsigned int blue, unsigned int trans, struct fb_info *info)
+{
+	struct pxa168fb_info *fbi = info->par;
+	u32 val;
+
+#if 0
+	if (info->var.grayscale)
+		red = green = blue = (19595 * red + 38470 * green +
+					7471 * blue) >> 16;
+#endif
+
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR && regno < 16) {
+		val =  chan_to_field(red,   &info->var.red);
+		val |= chan_to_field(green, &info->var.green);
+		val |= chan_to_field(blue , &info->var.blue);
+		fbi->pseudo_palette[regno] = val;
+	}
+
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR && regno < 256) {
+		val = to_rgb(red, green, blue);
+		writel(val, fbi->reg_base + LCD_SPU_SRAM_WRDAT);
+		writel(0x8300 | regno, fbi->reg_base + LCD_SPU_SRAM_CTRL);
+	}
+
+	return 0;
+}
+
+static int pxa168fb_blank(int blank, struct fb_info *info)
+{
+	struct pxa168fb_info *fbi = info->par;
+
+	fbi->is_blanked = (blank == FB_BLANK_UNBLANK) ? 0 : 1;
+	set_dumb_panel_control(info);
+
+	return 0;
+}
+
+static int pxa168fb_pan_display(struct fb_var_screeninfo *var,
+				struct fb_info *info)
+{
+	set_graphics_start(info, var->xoffset, var->yoffset);
+
+	return 0;
+}
+
+static irqreturn_t pxa168fb_handle_irq(int irq, void *dev_id)
+{
+	struct pxa168fb_info *fbi = (struct pxa168fb_info *)dev_id;
+	u32     isr;
+
+	isr = readl(fbi->reg_base+SPU_IRQ_ISR);
+
+	if ((isr & GRA_FRAME_IRQ0_ENA_MASK)) {
+		/* wake up queue. */
+		atomic_set(&fbi->w_intr, 1);
+		wake_up(&fbi->w_intr_wq);
+
+		writel(isr & (~GRA_FRAME_IRQ0_ENA_MASK),
+			fbi->reg_base+SPU_IRQ_ISR);
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static struct fb_ops pxa168fb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_check_var	= pxa168fb_check_var,
+	.fb_set_par	= pxa168fb_set_par,
+	.fb_setcolreg	= pxa168fb_setcolreg,
+	.fb_blank	= pxa168fb_blank,
+	.fb_pan_display	= pxa168fb_pan_display,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+};
+
+static int pxa168fb_init_mode(struct fb_info *info,
+			      struct pxa168fb_mach_info *mi)
+{
+	struct pxa168fb_info *fbi = info->par;
+	struct fb_var_screeninfo *var = &info->var;
+	int ret = 0;
+	u32 total_w, total_h, refresh;
+	u64 div_result;
+	const struct fb_videomode *m;
+
+	/*
+	 * Set default value
+	 */
+	refresh = DEFAULT_REFRESH;
+
+	/*
+	 * If has bootargs, apply it first.
+	 */
+	if (fbi->dft_vmode.xres && fbi->dft_vmode.yres &&
+	    fbi->dft_vmode.refresh) {
+		/* set data according bootargs */
+		var->xres = fbi->dft_vmode.xres;
+		var->yres = fbi->dft_vmode.yres;
+		refresh = fbi->dft_vmode.refresh;
+	}
+
+	/* try to find best video mode. */
+	m = fb_find_best_mode(&info->var, &info->modelist);
+	if (m)
+		fb_videomode_to_var(&info->var, m);
+
+	/* Init settings. */
+	var->xres_virtual = var->xres;
+	var->yres_virtual = fbi->fb_size /
+		(var->xres_virtual * (var->bits_per_pixel >> 3));
+	printk("pxa168fb: find best mode: res = %dx%d\n", var->xres, var->yres);
+
+	/* correct pixclock. */
+	total_w = var->xres + var->left_margin + var->right_margin +
+		  var->hsync_len;
+	total_h = var->yres + var->upper_margin + var->lower_margin +
+		  var->vsync_len;
+
+	div_result = 1000000000000ll;
+	do_div(div_result, total_w * total_h * refresh);
+	var->pixclock = (u32)div_result;
+
+	return ret;
+}
+
+static int __init pxa168fb_probe(struct platform_device *pdev)
+{
+	struct pxa168fb_mach_info *mi;
+	struct fb_info *info = 0;
+	struct pxa168fb_info *fbi = 0;
+	struct resource *res;
+	struct clk *clk;
+	int irq, ret;
+
+	mi = pdev->dev.platform_data;
+	if (mi == NULL) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	clk = clk_get(&pdev->dev, "LCDCLK");
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "unable to get LCDCLK");
+		return PTR_ERR(clk);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no IO memory defined\n");
+		return -ENOENT;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no IRQ defined\n");
+		return -ENOENT;
+	}
+
+	info = framebuffer_alloc(sizeof(struct pxa168fb_info), &pdev->dev);
+	if (info == NULL)
+		return -ENOMEM;
+
+	/* Initialize private data */
+	fbi = info->par;
+	platform_set_drvdata(pdev, fbi);
+	fbi->clk = clk;
+	fbi->dev = &pdev->dev;
+	fbi->panel_rbswap = mi->panel_rbswap;
+	fbi->is_blanked = 0;
+	fbi->debug = 0;
+	fbi->active = mi->active;
+	init_waitqueue_head(&fbi->w_intr_wq);
+
+	/*
+	 * Initialise static fb parameters.
+	 */
+	info->flags = FBINFO_DEFAULT | FBINFO_PARTIAL_PAN_OK |
+		      FBINFO_HWACCEL_XPAN | FBINFO_HWACCEL_YPAN;
+	info->node = -1;
+	strcpy(info->fix.id, mi->id);
+	info->fix.type = FB_TYPE_PACKED_PIXELS;
+	info->fix.type_aux = 0;
+	info->fix.xpanstep = 0;
+	info->fix.ypanstep = 0;
+	info->fix.ywrapstep = 0;
+	info->fix.mmio_start = res->start;
+	info->fix.mmio_len = res->end - res->start + 1;
+	info->fix.accel = FB_ACCEL_NONE;
+	info->fbops = &pxa168fb_ops;
+	info->pseudo_palette = fbi->pseudo_palette;
+
+	/*
+	 * Map LCD controller registers.
+	 */
+	fbi->reg_base = ioremap_nocache(res->start, res->end - res->start);
+	if (fbi->reg_base == NULL) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	/*
+	 * Allocate framebuffer memory.
+	 */
+	fbi->fb_size = PAGE_ALIGN(DEFAULT_FB_SIZE);
+
+	fbi->fb_start = dma_alloc_writecombine(fbi->dev, fbi->fb_size,
+						&fbi->fb_start_dma,
+						GFP_KERNEL);
+	if (fbi->fb_start == NULL) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	memset(fbi->fb_start, 0, fbi->fb_size);
+	info->fix.smem_start = fbi->fb_start_dma;
+	info->fix.smem_len = fbi->fb_size;
+	info->screen_base = fbi->fb_start;
+	info->screen_size = fbi->fb_size;
+
+	/*
+	 * Set video mode according to platform data.
+	 */
+	set_mode(fbi, &info->var, mi->modes, mi->pix_fmt, 1);
+
+	fb_videomode_to_modelist(mi->modes, mi->num_modes, &info->modelist);
+
+	/*
+	 * init video mode data.
+	 */
+	pxa168fb_init_mode(info, mi);
+
+	/*
+	 * enable controller clock
+	 */
+	clk_enable(fbi->clk);
+
+	/*
+	 * Fill in sane defaults.
+	 */
+	pxa168fb_set_par(info);
+
+	/*
+	 * Configure default register values.
+	 */
+	writel(0x00000000, fbi->reg_base + LCD_SPU_BLANKCOLOR);
+	writel(mi->io_pin_allocation_mode, fbi->reg_base + SPU_IOPAD_CONTROL);
+	writel(0x00000000, fbi->reg_base + LCD_CFG_GRA_START_ADDR1);
+	writel(0x00000000, fbi->reg_base + LCD_SPU_GRA_OVSA_HPXL_VLN);
+	writel(0x0, fbi->reg_base + LCD_SPU_SRAM_PARA0);
+	writel(CFG_CSB_256x32(0x1)|CFG_CSB_256x24(0x1)|CFG_CSB_256x8(0x1),
+		fbi->reg_base + LCD_SPU_SRAM_PARA1);
+
+	/*
+	 * Allocate color map.
+	 */
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		ret = -ENOMEM;
+		goto failed_free_clk;
+	}
+
+	/*
+	 * Register irq handler.
+	 */
+	ret = request_irq(irq, pxa168fb_handle_irq, IRQF_SHARED, mi->id, fbi);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to request IRQ\n");
+		ret = -ENXIO;
+		goto failed_free_cmap;
+	}
+
+	/*
+	 * Enable GFX interrupt
+	 */
+	writel(GRA_FRAME_IRQ0_ENA(0x1), fbi->reg_base+SPU_IRQ_ENA);
+
+	/*
+	 * Register framebuffer.
+	 */
+	ret = register_framebuffer(info);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register pxa168-fb: %d\n", ret);
+		ret = -ENXIO;
+		goto failed_free_irq;
+	}
+
+	return 0;
+
+failed_free_irq:
+	free_irq(irq, fbi);
+failed_free_cmap:
+	fb_dealloc_cmap(&info->cmap);
+failed_free_clk:
+	clk_disable(fbi->clk);
+	clk_put(fbi->clk);
+failed:
+	pr_err("pxa168-fb: frame buffer device init failed\n");
+	platform_set_drvdata(pdev, NULL);
+	fb_dealloc_cmap(&info->cmap);
+
+	if (fbi && fbi->reg_base) {
+		iounmap(fbi->reg_base);
+		kfree(fbi);
+	}
+
+	return ret;
+}
+
+static struct platform_driver pxa168fb_driver = {
+	.driver		= {
+		.name	= "pxa168-fb",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= pxa168fb_probe,
+};
+
+static int __devinit pxa168fb_init(void)
+{
+	return platform_driver_register(&pxa168fb_driver);
+}
+module_init(pxa168fb_init);
+
+MODULE_AUTHOR("Lennert Buytenhek <buytenh@marvell.com> "
+	      "Green Wan <gwan@marvell.com>");
+MODULE_DESCRIPTION("Framebuffer driver for PXA168/910");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/pxa168fb.h b/drivers/video/pxa168fb.h
new file mode 100644
index 0000000..a43a10b
--- /dev/null
+++ b/drivers/video/pxa168fb.h
@@ -0,0 +1,558 @@
+#ifndef __PXA168FB_H__
+#define __PXA168FB_H__
+
+/* ------------< LCD register >------------ */
+/* Video Frame 0&1 start address registers */
+#define	LCD_SPU_DMA_START_ADDR_Y0	0x00C0
+#define	LCD_SPU_DMA_START_ADDR_U0	0x00C4
+#define	LCD_SPU_DMA_START_ADDR_V0	0x00C8
+#define LCD_CFG_DMA_START_ADDR_0	0x00CC /* Cmd address */
+#define	LCD_SPU_DMA_START_ADDR_Y1	0x00D0
+#define	LCD_SPU_DMA_START_ADDR_U1	0x00D4
+#define	LCD_SPU_DMA_START_ADDR_V1	0x00D8
+#define LCD_CFG_DMA_START_ADDR_1	0x00DC /* Cmd address */
+
+/* YC & UV Pitch */
+#define LCD_SPU_DMA_PITCH_YC		0x00E0
+#define     SPU_DMA_PITCH_C(c)		(c<<16)
+#define     SPU_DMA_PITCH_Y(y)		(y)
+#define LCD_SPU_DMA_PITCH_UV		0x00E4
+#define     SPU_DMA_PITCH_V(v)		(v<<16)
+#define     SPU_DMA_PITCH_U(u)		(u)
+
+/* Video Starting Point on Screen Register */
+#define LCD_SPUT_DMA_OVSA_HPXL_VLN		0x00E8
+#define     CFG_DMA_OVSA_VLN(y)			(y<<16) /* 0~0xfff */
+#define     CFG_DMA_OVSA_HPXL(x)		(x)     /* 0~0xfff */
+
+/* Video Size Register */
+#define LCD_SPU_DMA_HPXL_VLN			0x00EC
+#define     CFG_DMA_VLN(y)			(y<<16)
+#define     CFG_DMA_HPXL(x)			(x)
+
+/* Video Size After zooming Register */
+#define LCD_SPU_DZM_HPXL_VLN			0x00F0
+#define     CFG_DZM_VLN(y)			(y<<16)
+#define     CFG_DZM_HPXL(x)			(x)
+
+/* Graphic Frame 0&1 Starting Address Register */
+#define LCD_CFG_GRA_START_ADDR0			0x00F4
+#define LCD_CFG_GRA_START_ADDR1			0x00F8
+
+/* Graphic Frame Pitch */
+#define LCD_CFG_GRA_PITCH			0x00FC
+
+/* Graphic Starting Point on Screen Register */
+#define LCD_SPU_GRA_OVSA_HPXL_VLN		0x0100
+#define     CFG_GRA_OVSA_VLN(y)			(y<<16)
+#define     CFG_GRA_OVSA_HPXL(x)		(x)
+
+/* Graphic Size Register */
+#define LCD_SPU_GRA_HPXL_VLN			0x0104
+#define     CFG_GRA_VLN(y)			(y<<16)
+#define     CFG_GRA_HPXL(x)			(x)
+
+/* Graphic Size after Zooming Register */
+#define LCD_SPU_GZM_HPXL_VLN			0x0108
+#define     CFG_GZM_VLN(y)			(y<<16)
+#define     CFG_GZM_HPXL(x)			(x)
+
+/* HW Cursor Starting Point on Screen Register */
+#define LCD_SPU_HWC_OVSA_HPXL_VLN		0x010C
+#define     CFG_HWC_OVSA_VLN(y)			(y<<16)
+#define     CFG_HWC_OVSA_HPXL(x)		(x)
+
+/* HW Cursor Size */
+#define LCD_SPU_HWC_HPXL_VLN			0x0110
+#define     CFG_HWC_VLN(y)			(y<<16)
+#define     CFG_HWC_HPXL(x)			(x)
+
+/* Total Screen Size Register */
+#define LCD_SPUT_V_H_TOTAL			0x0114
+#define     CFG_V_TOTAL(y)			((y)<<16)
+#define     CFG_H_TOTAL(x)			(x)
+
+/* Total Screen Active Size Register */
+#define LCD_SPU_V_H_ACTIVE			0x0118
+#define     CFG_V_ACTIVE(y)			((y)<<16)
+#define     CFG_H_ACTIVE(x)			(x)
+
+/* Screen H&V Porch Register */
+#define LCD_SPU_H_PORCH				0x011C
+#define     CFG_H_BACK_PORCH(b)			(b<<16)
+#define     CFG_H_FRONT_PORCH(f)		(f)
+#define LCD_SPU_V_PORCH				0x0120
+#define     CFG_V_BACK_PORCH(b)			(b<<16)
+#define     CFG_V_FRONT_PORCH(f)		(f)
+
+/* Screen Blank Color Register */
+#define LCD_SPU_BLANKCOLOR			0x0124
+#define     CFG_BLANKCOLOR_MASK			0x00FFFFFF
+#define     CFG_BLANKCOLOR_R_MASK		0x000000FF
+#define     CFG_BLANKCOLOR_G_MASK		0x0000FF00
+#define     CFG_BLANKCOLOR_B_MASK		0x00FF0000
+
+/* HW Cursor Color 1&2 Register */
+#define LCD_SPU_ALPHA_COLOR1			0x0128
+#define     CFG_HWC_COLOR1			0x00FFFFFF
+#define     CFG_HWC_COLOR1_R(red)		(red<<16)
+#define     CFG_HWC_COLOR1_G(green)		(green<<8)
+#define     CFG_HWC_COLOR1_B(blue)		(blue)
+#define     CFG_HWC_COLOR1_R_MASK		0x000000FF
+#define     CFG_HWC_COLOR1_G_MASK		0x0000FF00
+#define     CFG_HWC_COLOR1_B_MASK		0x00FF0000
+#define LCD_SPU_ALPHA_COLOR2			0x012C
+#define     CFG_HWC_COLOR2			0x00FFFFFF
+#define     CFG_HWC_COLOR2_R_MASK		0x000000FF
+#define     CFG_HWC_COLOR2_G_MASK		0x0000FF00
+#define     CFG_HWC_COLOR2_B_MASK		0x00FF0000
+
+/* Video YUV Color Key Control */
+#define LCD_SPU_COLORKEY_Y			0x0130
+#define     CFG_CKEY_Y2(y2)			((y2)<<24)
+#define     CFG_CKEY_Y2_MASK			0xFF000000
+#define     CFG_CKEY_Y1(y1)			((y1)<<16)
+#define     CFG_CKEY_Y1_MASK			0x00FF0000
+#define     CFG_CKEY_Y(y)			((y)<<8)
+#define     CFG_CKEY_Y_MASK			0x0000FF00
+#define     CFG_ALPHA_Y(y)			(y)
+#define     CFG_ALPHA_Y_MASK			0x000000FF
+#define LCD_SPU_COLORKEY_U			0x0134
+#define     CFG_CKEY_U2(u2)			((u2)<<24)
+#define     CFG_CKEY_U2_MASK			0xFF000000
+#define     CFG_CKEY_U1(u1)			((u1)<<16)
+#define     CFG_CKEY_U1_MASK			0x00FF0000
+#define     CFG_CKEY_U(u)			((u)<<8)
+#define     CFG_CKEY_U_MASK			0x0000FF00
+#define     CFG_ALPHA_U(u)			(u)
+#define     CFG_ALPHA_U_MASK			0x000000FF
+#define LCD_SPU_COLORKEY_V			0x0138
+#define     CFG_CKEY_V2(v2)			((v2)<<24)
+#define     CFG_CKEY_V2_MASK			0xFF000000
+#define     CFG_CKEY_V1(v1)			((v1)<<16)
+#define     CFG_CKEY_V1_MASK			0x00FF0000
+#define     CFG_CKEY_V(v)			((v)<<8)
+#define     CFG_CKEY_V_MASK			0x0000FF00
+#define     CFG_ALPHA_V(v)			(v)
+#define     CFG_ALPHA_V_MASK			0x000000FF
+
+/* SPI Read Data Register */
+#define LCD_SPU_SPI_RXDATA			0x0140
+
+/* Smart Panel Read Data Register */
+#define LCD_SPU_ISA_RSDATA			0x0144
+#define     ISA_RXDATA_16BIT_1_DATA_MASK	0x000000FF
+#define     ISA_RXDATA_16BIT_2_DATA_MASK	0x0000FF00
+#define     ISA_RXDATA_16BIT_3_DATA_MASK	0x00FF0000
+#define     ISA_RXDATA_16BIT_4_DATA_MASK	0xFF000000
+#define     ISA_RXDATA_32BIT_1_DATA_MASK	0x00FFFFFF
+
+/* HWC SRAM Read Data Register */
+#define LCD_SPU_HWC_RDDAT			0x0158
+
+/* Gamma Table SRAM Read Data Register */
+#define LCD_SPU_GAMMA_RDDAT			0x015c
+#define     CFG_GAMMA_RDDAT_MASK		0x000000FF
+
+/* Palette Table SRAM Read Data Register */
+#define LCD_SPU_PALETTE_RDDAT			0x0160
+#define     CFG_PALETTE_RDDAT_MASK		0x00FFFFFF
+
+/* I/O Pads Input Read Only Register */
+#define LCD_SPU_IOPAD_IN			0x0178
+#define     CFG_IOPAD_IN_MASK			0x0FFFFFFF
+
+/* Reserved Read Only Registers */
+#define LCD_CFG_RDREG5F				0x017C
+#define     IRE_FRAME_CNT_MASK			0x000000C0
+#define     IPE_FRAME_CNT_MASK			0x00000030
+#define     GRA_FRAME_CNT_MASK			0x0000000C  /* Graphic */
+#define     DMA_FRAME_CNT_MASK			0x00000003  /* Video */
+
+/* SPI Control Register. */
+#define LCD_SPU_SPI_CTRL			0x0180
+#define     CFG_SCLKCNT(div)			(div<<24)  /* 0xFF~0x2 */
+#define     CFG_SCLKCNT_MASK			0xFF000000
+#define     CFG_RXBITS(rx)			(rx<<16)   /* 0x1F~0x1 */
+#define     CFG_RXBITS_MASK			0x00FF0000
+#define     CFG_TXBITS(tx)			(tx<<8)    /* 0x1F~0x1 */
+#define     CFG_TXBITS_MASK			0x0000FF00
+#define     CFG_CLKINV(clk)			(clk<<7)
+#define     CFG_CLKINV_MASK			0x00000080
+#define     CFG_KEEPXFER(transfer)		(transfer<<6)
+#define     CFG_KEEPXFER_MASK			0x00000040
+#define     CFG_RXBITSTO0(rx)			(rx<<5)
+#define     CFG_RXBITSTO0_MASK			0x00000020
+#define     CFG_TXBITSTO0(tx)			(tx<<4)
+#define     CFG_TXBITSTO0_MASK			0x00000010
+#define     CFG_SPI_ENA(spi)			(spi<<3)
+#define     CFG_SPI_ENA_MASK			0x00000008
+#define     CFG_SPI_SEL(spi)			(spi<<2)
+#define     CFG_SPI_SEL_MASK			0x00000004
+#define     CFG_SPI_3W4WB(wire)			(wire<<1)
+#define     CFG_SPI_3W4WB_MASK			0x00000002
+#define     CFG_SPI_START(start)		(start)
+#define     CFG_SPI_START_MASK			0x00000001
+
+/* SPI Tx Data Register */
+#define LCD_SPU_SPI_TXDATA			0x0184
+
+/*
+   1. Smart Pannel 8-bit Bus Control Register.
+   2. AHB Slave Path Data Port Register
+*/
+#define LCD_SPU_SMPN_CTRL			0x0188
+
+/* DMA Control 0 Register */
+#define LCD_SPU_DMA_CTRL0			0x0190
+#define     CFG_NOBLENDING(nb)			(nb<<31)
+#define     CFG_NOBLENDING_MASK			0x80000000
+#define     CFG_GAMMA_ENA(gn)			(gn<<30)
+#define     CFG_GAMMA_ENA_MASK			0x40000000
+#define     CFG_CBSH_ENA(cn)			(cn<<29)
+#define     CFG_CBSH_ENA_MASK			0x20000000
+#define     CFG_PALETTE_ENA(pn)			(pn<<28)
+#define     CFG_PALETTE_ENA_MASK		0x10000000
+#define     CFG_ARBFAST_ENA(an)			(an<<27)
+#define     CFG_ARBFAST_ENA_MASK		0x08000000
+#define     CFG_HWC_1BITMOD(mode)		(mode<<26)
+#define     CFG_HWC_1BITMOD_MASK		0x04000000
+#define     CFG_HWC_1BITENA(mn)			(mn<<25)
+#define     CFG_HWC_1BITENA_MASK		0x02000000
+#define     CFG_HWC_ENA(cn)		        (cn<<24)
+#define     CFG_HWC_ENA_MASK			0x01000000
+#define     CFG_DMAFORMAT(dmaformat)		(dmaformat<<20)
+#define     CFG_DMAFORMAT_MASK			0x00F00000
+#define     CFG_GRAFORMAT(graformat)		(graformat<<16)
+#define     CFG_GRAFORMAT_MASK			0x000F0000
+/* for graphic part */
+#define     CFG_GRA_FTOGGLE(toggle)		(toggle<<15)
+#define     CFG_GRA_FTOGGLE_MASK		0x00008000
+#define     CFG_GRA_HSMOOTH(smooth)		(smooth<<14)
+#define     CFG_GRA_HSMOOTH_MASK		0x00004000
+#define     CFG_GRA_TSTMODE(test)		(test<<13)
+#define     CFG_GRA_TSTMODE_MASK		0x00002000
+#define     CFG_GRA_SWAPRB(swap)		(swap<<12)
+#define     CFG_GRA_SWAPRB_MASK			0x00001000
+#define     CFG_GRA_SWAPUV(swap)		(swap<<11)
+#define     CFG_GRA_SWAPUV_MASK			0x00000800
+#define     CFG_GRA_SWAPYU(swap)		(swap<<10)
+#define     CFG_GRA_SWAPYU_MASK			0x00000400
+#define     CFG_YUV2RGB_GRA(cvrt)		(cvrt<<9)
+#define     CFG_YUV2RGB_GRA_MASK		0x00000200
+#define     CFG_GRA_ENA(gra)			(gra<<8)
+#define     CFG_GRA_ENA_MASK			0x00000100
+/* for video part */
+#define     CFG_DMA_FTOGGLE(toggle)		(toggle<<7)
+#define     CFG_DMA_FTOGGLE_MASK		0x00000080
+#define     CFG_DMA_HSMOOTH(smooth)		(smooth<<6)
+#define     CFG_DMA_HSMOOTH_MASK		0x00000040
+#define     CFG_DMA_TSTMODE(test)		(test<<5)
+#define     CFG_DMA_TSTMODE_MASK		0x00000020
+#define     CFG_DMA_SWAPRB(swap)		(swap<<4)
+#define     CFG_DMA_SWAPRB_MASK			0x00000010
+#define     CFG_DMA_SWAPUV(swap)		(swap<<3)
+#define     CFG_DMA_SWAPUV_MASK			0x00000008
+#define     CFG_DMA_SWAPYU(swap)		(swap<<2)
+#define     CFG_DMA_SWAPYU_MASK			0x00000004
+#define     CFG_DMA_SWAP_MASK			0x0000001C
+#define     CFG_YUV2RGB_DMA(cvrt)		(cvrt<<1)
+#define     CFG_YUV2RGB_DMA_MASK		0x00000002
+#define     CFG_DMA_ENA(video)			(video)
+#define     CFG_DMA_ENA_MASK			0x00000001
+
+/* DMA Control 1 Register */
+#define LCD_SPU_DMA_CTRL1			0x0194
+#define     CFG_FRAME_TRIG(trig)		(trig<<31)
+#define     CFG_FRAME_TRIG_MASK			0x80000000
+#define     CFG_VSYNC_TRIG(trig)		(trig<<28)
+#define     CFG_VSYNC_TRIG_MASK			0x70000000
+#define     CFG_VSYNC_INV(inv)			(inv<<27)
+#define     CFG_VSYNC_INV_MASK			0x08000000
+#define     CFG_COLOR_KEY_MODE(cmode)		(cmode<<24)
+#define     CFG_COLOR_KEY_MASK			0x07000000
+#define     CFG_CARRY(carry)			(carry<<23)
+#define     CFG_CARRY_MASK			0x00800000
+#define     CFG_LNBUF_ENA(lnbuf)		(lnbuf<<22)
+#define     CFG_LNBUF_ENA_MASK			0x00400000
+#define     CFG_GATED_ENA(gated)		(gated<<21)
+#define     CFG_GATED_ENA_MASK			0x00200000
+#define     CFG_PWRDN_ENA(power)		(power<<20)
+#define     CFG_PWRDN_ENA_MASK			0x00100000
+#define     CFG_DSCALE(dscale)			(dscale<<18)
+#define     CFG_DSCALE_MASK			0x000C0000
+#define     CFG_ALPHA_MODE(amode)		(amode<<16)
+#define     CFG_ALPHA_MODE_MASK			0x00030000
+#define     CFG_ALPHA(alpha)			(alpha<<8)
+#define     CFG_ALPHA_MASK			0x0000FF00
+#define     CFG_PXLCMD(pxlcmd)			(pxlcmd)
+#define     CFG_PXLCMD_MASK			0x000000FF
+
+/* SRAM Control Register */
+#define LCD_SPU_SRAM_CTRL			0x0198
+#define     CFG_SRAM_INIT_WR_RD(mode)		(mode<<14)
+#define     CFG_SRAM_INIT_WR_RD_MASK		0x0000C000
+#define     CFG_SRAM_ADDR_LCDID(id)		(id<<8)
+#define     CFG_SRAM_ADDR_LCDID_MASK		0x00000F00
+#define     CFG_SRAM_ADDR(addr)			(addr)
+#define     CFG_SRAM_ADDR_MASK			0x000000FF
+
+/* SRAM Write Data Register */
+#define LCD_SPU_SRAM_WRDAT			0x019C
+
+/* SRAM RTC/WTC Control Register */
+#define LCD_SPU_SRAM_PARA0			0x01A0
+
+/* SRAM Power Down Control Register */
+#define LCD_SPU_SRAM_PARA1			0x01A4
+#define     CFG_CSB_256x32(hwc)			(hwc<<15)	/* HWC */
+#define     CFG_CSB_256x32_MASK			0x00008000
+#define     CFG_CSB_256x24(palette)		(palette<<14)	/* Palette */
+#define     CFG_CSB_256x24_MASK			0x00004000
+#define     CFG_CSB_256x8(gamma)		(gamma<<13)	/* Gamma */
+#define     CFG_CSB_256x8_MASK			0x00002000
+#define     CFG_PDWN256x32(pdwn)		(pdwn<<7)	/* HWC */
+#define     CFG_PDWN256x32_MASK			0x00000080
+#define     CFG_PDWN256x24(pdwn)		(pdwn<<6)	/* Palette */
+#define     CFG_PDWN256x24_MASK			0x00000040
+#define     CFG_PDWN256x8(pdwn)			(pdwn<<5)	/* Gamma */
+#define     CFG_PDWN256x8_MASK			0x00000020
+#define     CFG_PDWN32x32(pdwn)			(pdwn<<3)
+#define     CFG_PDWN32x32_MASK			0x00000008
+#define     CFG_PDWN16x66(pdwn)			(pdwn<<2)
+#define     CFG_PDWN16x66_MASK			0x00000004
+#define     CFG_PDWN32x66(pdwn)			(pdwn<<1)
+#define     CFG_PDWN32x66_MASK			0x00000002
+#define     CFG_PDWN64x66(pdwn)			(pdwn)
+#define     CFG_PDWN64x66_MASK			0x00000001
+
+/* Smart or Dumb Panel Clock Divider */
+#define LCD_CFG_SCLK_DIV			0x01A8
+#define     SCLK_SOURCE_SELECT(src)		(src<<31)
+#define     SCLK_SOURCE_SELECT_MASK		0x80000000
+#define     CLK_FRACDIV(frac)			(frac<<16)
+#define     CLK_FRACDIV_MASK			0x0FFF0000
+#define     CLK_INT_DIV(div)			(div)
+#define     CLK_INT_DIV_MASK			0x0000FFFF
+
+/* Video Contrast Register */
+#define LCD_SPU_CONTRAST			0x01AC
+#define     CFG_BRIGHTNESS(bright)		(bright<<16)
+#define     CFG_BRIGHTNESS_MASK			0xFFFF0000
+#define     CFG_CONTRAST(contrast)		(contrast)
+#define     CFG_CONTRAST_MASK			0x0000FFFF
+
+/* Video Saturation Register */
+#define LCD_SPU_SATURATION			0x01B0
+#define     CFG_C_MULTS(mult)			(mult<<16)
+#define     CFG_C_MULTS_MASK			0xFFFF0000
+#define     CFG_SATURATION(sat)			(sat)
+#define     CFG_SATURATION_MASK			0x0000FFFF
+
+/* Video Hue Adjust Register */
+#define LCD_SPU_CBSH_HUE			0x01B4
+#define     CFG_SIN0(sin0)			(sin0<<16)
+#define     CFG_SIN0_MASK			0xFFFF0000
+#define     CFG_COS0(con0)			(con0)
+#define     CFG_COS0_MASK			0x0000FFFF
+
+/* Dump LCD Panel Control Register */
+#define LCD_SPU_DUMB_CTRL			0x01B8
+#define     CFG_DUMBMODE(mode)			(mode<<28)
+#define     CFG_DUMBMODE_MASK			0xF0000000
+#define     CFG_LCDGPIO_O(data)			(data<<20)
+#define     CFG_LCDGPIO_O_MASK			0x0FF00000
+#define     CFG_LCDGPIO_ENA(gpio)		(gpio<<12)
+#define     CFG_LCDGPIO_ENA_MASK		0x000FF000
+#define     CFG_BIAS_OUT(bias)			(bias<<8)
+#define     CFG_BIAS_OUT_MASK			0x00000100
+#define     CFG_REVERSE_RGB(rRGB)		(rRGB<<7)
+#define     CFG_REVERSE_RGB_MASK		0x00000080
+#define     CFG_INV_COMPBLANK(blank)		(blank<<6)
+#define     CFG_INV_COMPBLANK_MASK		0x00000040
+#define     CFG_INV_COMPSYNC(sync)		(sync<<5)
+#define     CFG_INV_COMPSYNC_MASK		0x00000020
+#define     CFG_INV_HENA(hena)			(hena<<4)
+#define     CFG_INV_HENA_MASK			0x00000010
+#define     CFG_INV_VSYNC(vsync)		(vsync<<3)
+#define     CFG_INV_VSYNC_MASK			0x00000008
+#define     CFG_INV_HSYNC(hsync)		(hsync<<2)
+#define     CFG_INV_HSYNC_MASK			0x00000004
+#define     CFG_INV_PCLK(pclk)			(pclk<<1)
+#define     CFG_INV_PCLK_MASK			0x00000002
+#define     CFG_DUMB_ENA(dumb)			(dumb)
+#define     CFG_DUMB_ENA_MASK			0x00000001
+
+/* LCD I/O Pads Control Register */
+#define SPU_IOPAD_CONTROL			0x01BC
+#define     CFG_GRA_VM_ENA(vm)			(vm<<15)        /* gfx */
+#define     CFG_GRA_VM_ENA_MASK			0x00008000
+#define     CFG_DMA_VM_ENA(vm)			(vm<<13)	/* video */
+#define     CFG_DMA_VM_ENA_MASK			0x00002000
+#define     CFG_CMD_VM_ENA(vm)			(vm<<13)
+#define     CFG_CMD_VM_ENA_MASK			0x00000800
+#define     CFG_CSC(csc)			(csc<<8)	/* csc */
+#define     CFG_CSC_MASK			0x00000300
+#define     CFG_AXICTRL(axi)			(axi<<4)
+#define     CFG_AXICTRL_MASK			0x000000F0
+#define     CFG_IOPADMODE(iopad)		(iopad)
+#define     CFG_IOPADMODE_MASK			0x0000000F
+
+/* LCD Interrupt Control Register */
+#define SPU_IRQ_ENA				0x01C0
+#define     DMA_FRAME_IRQ0_ENA(irq)		(irq<<31)
+#define     DMA_FRAME_IRQ0_ENA_MASK		0x80000000
+#define     DMA_FRAME_IRQ1_ENA(irq)		(irq<<30)
+#define     DMA_FRAME_IRQ1_ENA_MASK		0x40000000
+#define     DMA_FF_UNDERFLOW_ENA(ff)		(ff<<29)
+#define     DMA_FF_UNDERFLOW_ENA_MASK		0x20000000
+#define     GRA_FRAME_IRQ0_ENA(irq)		(irq<<27)
+#define     GRA_FRAME_IRQ0_ENA_MASK		0x08000000
+#define     GRA_FRAME_IRQ1_ENA(irq)		(irq<<26)
+#define     GRA_FRAME_IRQ1_ENA_MASK		0x04000000
+#define     GRA_FF_UNDERFLOW_ENA(ff)		(ff<<25)
+#define     GRA_FF_UNDERFLOW_ENA_MASK		0x02000000
+#define     VSYNC_IRQ_ENA(vsync_irq)		(vsync_irq<<23)
+#define     VSYNC_IRQ_ENA_MASK			0x00800000
+#define     DUMB_FRAMEDONE_ENA(fdone)		(fdone<<22)
+#define     DUMB_FRAMEDONE_ENA_MASK		0x00400000
+#define     TWC_FRAMEDONE_ENA(fdone)		(fdone<<21)
+#define     TWC_FRAMEDONE_ENA_MASK		0x00200000
+#define     HWC_FRAMEDONE_ENA(fdone)		(fdone<<20)
+#define     HWC_FRAMEDONE_ENA_MASK		0x00100000
+#define     SLV_IRQ_ENA(irq)			(irq<<19)
+#define     SLV_IRQ_ENA_MASK			0x00080000
+#define     SPI_IRQ_ENA(irq)			(irq<<18)
+#define     SPI_IRQ_ENA_MASK			0x00040000
+#define     PWRDN_IRQ_ENA(irq)			(irq<<17)
+#define     PWRDN_IRQ_ENA_MASK			0x00020000
+#define     ERR_IRQ_ENA(irq)			(irq<<16)
+#define     ERR_IRQ_ENA_MASK			0x00010000
+#define     CLEAN_SPU_IRQ_ISR(irq)		(irq)
+#define     CLEAN_SPU_IRQ_ISR_MASK		0x0000FFFF
+
+/* LCD Interrupt Status Register */
+#define SPU_IRQ_ISR				0x01C4
+#define     DMA_FRAME_IRQ0(irq)			(irq<<31)
+#define     DMA_FRAME_IRQ0_MASK			0x80000000
+#define     DMA_FRAME_IRQ1(irq)			(irq<<30)
+#define     DMA_FRAME_IRQ1_MASK			0x40000000
+#define     DMA_FF_UNDERFLOW(ff)		(ff<<29)
+#define     DMA_FF_UNDERFLOW_MASK		0x20000000
+#define     GRA_FRAME_IRQ0(irq)			(irq<<27)
+#define     GRA_FRAME_IRQ0_MASK			0x08000000
+#define     GRA_FRAME_IRQ1(irq)			(irq<<26)
+#define     GRA_FRAME_IRQ1_MASK			0x04000000
+#define     GRA_FF_UNDERFLOW(ff)		(ff<<25)
+#define     GRA_FF_UNDERFLOW_MASK		0x02000000
+#define     VSYNC_IRQ(vsync_irq)		(vsync_irq<<23)
+#define     VSYNC_IRQ_MASK			0x00800000
+#define     DUMB_FRAMEDONE(fdone)		(fdone<<22)
+#define     DUMB_FRAMEDONE_MASK			0x00400000
+#define     TWC_FRAMEDONE(fdone)		(fdone<<21)
+#define     TWC_FRAMEDONE_MASK			0x00200000
+#define     HWC_FRAMEDONE(fdone)		(fdone<<20)
+#define     HWC_FRAMEDONE_MASK			0x00100000
+#define     SLV_IRQ(irq)			(irq<<19)
+#define     SLV_IRQ_MASK			0x00080000
+#define     SPI_IRQ(irq)			(irq<<18)
+#define     SPI_IRQ_MASK			0x00040000
+#define     PWRDN_IRQ(irq)			(irq<<17)
+#define     PWRDN_IRQ_MASK			0x00020000
+#define     ERR_IRQ(irq)			(irq<<16)
+#define     ERR_IRQ_MASK			0x00010000
+/* read-only */
+#define     DMA_FRAME_IRQ0_LEVEL_MASK		0x00008000
+#define     DMA_FRAME_IRQ1_LEVEL_MASK		0x00004000
+#define     DMA_FRAME_CNT_ISR_MASK		0x00003000
+#define     GRA_FRAME_IRQ0_LEVEL_MASK		0x00000800
+#define     GRA_FRAME_IRQ1_LEVEL_MASK		0x00000400
+#define     GRA_FRAME_CNT_ISR_MASK		0x00000300
+#define     VSYNC_IRQ_LEVEL_MASK		0x00000080
+#define     DUMB_FRAMEDONE_LEVEL_MASK		0x00000040
+#define     TWC_FRAMEDONE_LEVEL_MASK		0x00000020
+#define     HWC_FRAMEDONE_LEVEL_MASK		0x00000010
+#define     SLV_FF_EMPTY_MASK			0x00000008
+#define     DMA_FF_ALLEMPTY_MASK		0x00000004
+#define     GRA_FF_ALLEMPTY_MASK		0x00000002
+#define     PWRDN_IRQ_LEVEL_MASK		0x00000001
+
+
+/*
+ * defined Video Memory Color format for DMA control 0 register
+ * DMA0 bit[23:20]
+ */
+#define VMODE_RGB565		0x0
+#define VMODE_RGB1555		0x1
+#define VMODE_RGB888PACKED	0x2
+#define VMODE_RGB888UNPACKED	0x3
+#define VMODE_RGBA888		0x4
+#define VMODE_YUV422PACKED	0x5
+#define VMODE_YUV422PLANAR	0x6
+#define VMODE_YUV420PLANAR	0x7
+#define VMODE_SMPNCMD		0x8
+#define VMODE_PALETTE4BIT	0x9
+#define VMODE_PALETTE8BIT	0xa
+#define VMODE_RESERVED		0xb
+
+/*
+ * defined Graphic Memory Color format for DMA control 0 register
+ * DMA0 bit[19:16]
+ */
+#define GMODE_RGB565		0x0
+#define GMODE_RGB1555		0x1
+#define GMODE_RGB888PACKED	0x2
+#define GMODE_RGB888UNPACKED	0x3
+#define GMODE_RGBA888		0x4
+#define GMODE_YUV422PACKED	0x5
+#define GMODE_YUV422PLANAR	0x6
+#define GMODE_YUV420PLANAR	0x7
+#define GMODE_SMPNCMD		0x8
+#define GMODE_PALETTE4BIT	0x9
+#define GMODE_PALETTE8BIT	0xa
+#define GMODE_RESERVED		0xb
+
+/*
+ * define for DMA control 1 register
+ */
+#define DMA1_FRAME_TRIG		31 /* bit location */
+#define DMA1_VSYNC_MODE		28
+#define DMA1_VSYNC_INV		27
+#define DMA1_CKEY		24
+#define DMA1_CARRY		23
+#define DMA1_LNBUF_ENA		22
+#define DMA1_GATED_ENA		21
+#define DMA1_PWRDN_ENA		20
+#define DMA1_DSCALE		18
+#define DMA1_ALPHA_MODE		16
+#define DMA1_ALPHA		08
+#define DMA1_PXLCMD		00
+
+/*
+ * defined for Configure Dumb Mode
+ * DUMB LCD Panel bit[31:28]
+ */
+#define DUMB16_RGB565_0		0x0
+#define DUMB16_RGB565_1		0x1
+#define DUMB18_RGB666_0		0x2
+#define DUMB18_RGB666_1		0x3
+#define DUMB12_RGB444_0		0x4
+#define DUMB12_RGB444_1		0x5
+#define DUMB24_RGB888_0		0x6
+#define DUMB_BLANK		0x7
+
+/*
+ * defined for Configure I/O Pin Allocation Mode
+ * LCD LCD I/O Pads control register bit[3:0]
+ */
+#define IOPAD_DUMB24		0x0
+#define IOPAD_DUMB18SPI		0x1
+#define IOPAD_DUMB18GPIO	0x2
+#define IOPAD_DUMB16SPI		0x3
+#define IOPAD_DUMB16GPIO	0x4
+#define IOPAD_DUMB12		0x5
+#define IOPAD_SMART18SPI	0x6
+#define IOPAD_SMART16SPI	0x7
+#define IOPAD_SMART8BOTH	0x8
+
+#endif /* __PXA168FB_H__ */
diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
new file mode 100644
index 0000000..59c4a1b
--- /dev/null
+++ b/include/video/pxa168fb.h
@@ -0,0 +1,138 @@
+/*
+ * linux/arch/arm/mach-mmp/include/mach/pxa168fb.h
+ *
+ *  Copyright (C) 2009 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_PXA168FB_H
+#define __ASM_MACH_PXA168FB_H
+
+#include <linux/fb.h>
+#include <linux/interrupt.h>
+
+/* Dumb interface */
+#define PIN_MODE_DUMB_24		0
+#define PIN_MODE_DUMB_18_SPI		1
+#define PIN_MODE_DUMB_18_GPIO		2
+#define PIN_MODE_DUMB_16_SPI		3
+#define PIN_MODE_DUMB_16_GPIO		4
+#define PIN_MODE_DUMB_12_SPI_GPIO	5
+#define PIN_MODE_SMART_18_SPI		6
+#define PIN_MODE_SMART_16_SPI		7
+#define PIN_MODE_SMART_8_SPI_GPIO	8
+
+/* Dumb interface pin allocation */
+#define DUMB_MODE_RGB565		0
+#define DUMB_MODE_RGB565_UPPER		1
+#define DUMB_MODE_RGB666		2
+#define DUMB_MODE_RGB666_UPPER		3
+#define DUMB_MODE_RGB444		4
+#define DUMB_MODE_RGB444_UPPER		5
+#define DUMB_MODE_RGB888		6
+
+/* default fb buffer size WVGA-32bits */
+#define DEFAULT_FB_SIZE	(800 * 480 * 4)
+
+/*
+ * Buffer pixel format
+ * bit0 is for rb swap.
+ * bit12 is for Y UorV swap
+ */
+#define PIX_FMT_RGB565		0
+#define PIX_FMT_BGR565		1
+#define PIX_FMT_RGB1555		2
+#define PIX_FMT_BGR1555		3
+#define PIX_FMT_RGB888PACK	4
+#define PIX_FMT_BGR888PACK	5
+#define PIX_FMT_RGB888UNPACK	6
+#define PIX_FMT_BGR888UNPACK	7
+#define PIX_FMT_RGBA888		8
+#define PIX_FMT_BGRA888		9
+#define PIX_FMT_YUV422PACK	10
+#define PIX_FMT_YVU422PACK	11
+#define PIX_FMT_YUV422PLANAR	12
+#define PIX_FMT_YVU422PLANAR	13
+#define PIX_FMT_YUV420PLANAR	14
+#define PIX_FMT_YVU420PLANAR	15
+#define PIX_FMT_PSEUDOCOLOR	20
+#define PIX_FMT_UYVY422PACK	(0x1000|PIX_FMT_YUV422PACK)
+
+/*
+ * PXA LCD controller private state.
+ */
+struct pxa168fb_info {
+	struct device		*dev;
+	struct clk		*clk;
+
+	void			*reg_base;
+	unsigned long		new_addr;
+	dma_addr_t		fb_start_dma;
+	void			*fb_start;
+	int			fb_size;
+	atomic_t		w_intr;
+	wait_queue_head_t	w_intr_wq;
+	struct mutex		access_ok;
+	struct fb_videomode	dft_vmode;
+	unsigned char		*hwc_buf;
+	unsigned int		pseudo_palette[16];
+	struct tasklet_struct	tasklet;
+	char *mode_option;
+
+	int			pix_fmt;
+	unsigned		is_blanked:1;
+	unsigned		panel_rbswap:1;
+	unsigned		debug:1;
+	unsigned		active:1;
+};
+
+/*
+ * PXA fb machine information
+ */
+struct pxa168fb_mach_info {
+	char	id[16];
+	unsigned int	sclk_clock;
+
+	int		num_modes;
+	struct fb_videomode *modes;
+
+	/*
+	 * Pix_fmt
+	 */
+	unsigned	pix_fmt;
+
+	/*
+	 * I/O pin allocation.
+	 */
+	unsigned	io_pin_allocation_mode:4;
+
+	/*
+	 * Dumb panel -- assignment of R/G/B component info to the 24
+	 * available external data lanes.
+	 */
+	unsigned	dumb_mode:4;
+	unsigned	panel_rgb_reverse_lanes:1;
+
+	/*
+	 * Dumb panel -- GPIO output data.
+	 */
+	unsigned	gpio_output_mask:8;
+	unsigned	gpio_output_data:8;
+
+	/*
+	 * Dumb panel -- configurable output signal polarity.
+	 */
+	unsigned	invert_composite_blank:1;
+	unsigned	invert_pix_val_ena:1;
+	unsigned	invert_pixclock:1;
+	unsigned	invert_vsync:1;
+	unsigned	invert_hsync:1;
+	unsigned	panel_rbswap:1;
+	unsigned	active:1;
+	unsigned	enable_lcd:1;
+};
+
+#endif /* __ASM_MACH_PXA168FB_H */
-- 
1.6.0.4


-- 
Cheers
- eric

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
