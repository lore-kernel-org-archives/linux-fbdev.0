From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC PATCH 2/2] ep93xx framebuffer driver
Date: Mon, 25 May 2009 17:33:43 +1200
Message-ID: <4A1A2DB7.1050500@bluewatersys.com>
References: <4A1A2ABD.8000104@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <4A1A2ABD.8000104@bluewatersys.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>, hartleys <hartleys@visionengravers.com>, linux-fbdev-devel@lists.sourceforge.net

This patch adds support for the ep93xx framebuffer. Patch is against arm
ep93xx branch.

Can anybody with ep93xx hardware please test, specifically with regard
to the physical address bit 27 bug. My hardware has the bug, but I'm not
sure about other ep93xx chips.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index c535e88..885786c 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -53,6 +53,7 @@
 
 #include <asm/hardware/vic.h>
 
+#include <mach/fb.h>
 
 /*************************************************************************
  * Static I/O mappings that are needed for all EP93xx platforms
@@ -546,6 +547,34 @@ void __init ep93xx_register_i2c(struct i2c_board_info *devices, int num)
 	platform_device_register(&ep93xx_i2c_device);
 }
 
+/*************************************************************************
+ * EP93xx video peripheral handling
+ *************************************************************************/
+static struct ep93xxfb_mach_info ep93xxfb_data;
+
+static struct resource ep93xx_fb_resource[] = {
+	{
+		.start		= EP93XX_RASTER_PHYS_BASE,
+		.end		= EP93XX_RASTER_PHYS_BASE + 0x800 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device ep93xx_fb_device = {
+	.name			= "ep93xxfb",
+	.id			= 0,
+	.dev.platform_data	= &ep93xxfb_data,
+	.dev.coherent_dma_mask	= 0xf7ffffff,
+	.num_resources		= ARRAY_SIZE(ep93xx_fb_resource),
+	.resource		= ep93xx_fb_resource,
+};
+
+void __init ep93xx_register_fb(struct ep93xxfb_mach_info *data)
+{
+	ep93xxfb_data = *data;
+	platform_device_register(&ep93xx_fb_device);
+}
+
 extern void ep93xx_gpio_init(void);
 
 void __init ep93xx_init_devices(void)
diff --git a/arch/arm/mach-ep93xx/include/mach/fb.h b/arch/arm/mach-ep93xx/include/mach/fb.h
new file mode 100644
index 0000000..3bb9f04
--- /dev/null
+++ b/arch/arm/mach-ep93xx/include/mach/fb.h
@@ -0,0 +1,56 @@
+/*
+ * arch/arm/mach-ep93xx/include/mach/fb.h
+ */
+
+#ifndef __ASM_ARCH_EP93XXFB_H
+#define __ASM_ARCH_EP93XXFB_H
+
+struct fb_videomode;
+struct fb_info;
+
+#define EP93XXFB_USE_MODEDB		0
+
+/* VideoAttributes flags */
+#define EP93XXFB_STATE_MACHINE_ENABLE	(1 << 0)
+#define EP93XXFB_PIXEL_CLOCK_ENABLE	(1 << 1)
+#define EP93XXFB_VSYNC_ENABLE		(1 << 2)
+#define EP93XXFB_PIXEL_DATA_ENABLE	(1 << 3)
+#define EP93XXFB_COMPOSITE_SYNC		(1 << 4)
+#define EP93XXFB_SYNC_VERT_HIGH		(1 << 5)
+#define EP93XXFB_SYNC_HORIZ_HIGH	(1 << 6)
+#define EP93XXFB_SYNC_BLANK_HIGH	(1 << 7)
+#define EP93XXFB_PCLK_FALLING		(1 << 8)
+#define EP93XXFB_ENABLE_AC		(1 << 9)
+#define EP93XXFB_ENABLE_LCD		(1 << 10)
+#define EP93XXFB_ENABLE_CCIR		(1 << 12)
+#define EP93XXFB_USE_PARALLEL_INTERFACE	(1 << 13)
+#define EP93XXFB_ENABLE_INTERRUPT	(1 << 14)
+#define EP93XXFB_USB_INTERLACE		(1 << 16)
+#define EP93XXFB_USE_EQUALIZATION	(1 << 17)
+#define EP93XXFB_USE_DOUBLE_HORZ	(1 << 18)
+#define EP93XXFB_USE_DOUBLE_VERT	(1 << 19)
+#define EP93XXFB_USE_BLANK_PIXEL	(1 << 20)
+#define EP93XXFB_USE_SDCSN0		(0 << 21)
+#define EP93XXFB_USE_SDCSN1		(1 << 21)
+#define EP93XXFB_USE_SDCSN2		(2 << 21)
+#define EP93XXFB_USE_SDCSN3		(3 << 21)
+
+#define EP93XXFB_ENABLE			(EP93XXFB_STATE_MACHINE_ENABLE	| \
+					 EP93XXFB_PIXEL_CLOCK_ENABLE	| \
+					 EP93XXFB_VSYNC_ENABLE		| \
+					 EP93XXFB_PIXEL_DATA_ENABLE)
+
+struct ep93xxfb_mach_info {
+	unsigned int			num_modes;
+	const struct fb_videomode	*modes;
+	const struct fb_videomode	*default_mode;
+	int				bpp;
+	unsigned int			flags;
+
+	int				(*setup)(struct fb_info *info);
+	void				(*teardown)(struct fb_info *info);
+	void				(*blank)(int blank_mode, 
+						 struct fb_info *info);
+};
+
+#endif /* __ASM_ARCH_EP93XXFB_H */
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 05f0f4f..99fcef2 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -5,6 +5,7 @@
 #ifndef __ASSEMBLY__
 
 struct i2c_board_info;
+struct ep93xxfb_mach_info;
 
 struct ep93xx_eth_data
 {
@@ -17,6 +18,7 @@ void ep93xx_init_irq(void);
 void ep93xx_init_time(unsigned long);
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
 void ep93xx_register_i2c(struct i2c_board_info *devices, int num);
+void ep93xx_register_fb(struct ep93xxfb_mach_info *data);
 void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer;
 
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7826bdc..1e54bf3 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2114,6 +2114,17 @@ config FB_MB862XX_LIME
 	---help---
 	  Framebuffer support for Fujitsu Lime GDC on host CPU bus.
 
+config FB_EP93XX
+	tristate "EP93XX frame buffer support"
+	depends on FB && ARCH_EP93XX
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	---help---
+	  Framebuffer driver for the Cirrus Logic EP93XX series of processors.
+	  This driver is also available as a module. The module will be called
+	  ep93xxfb.
+
 config FB_PRE_INIT_FB
 	bool "Don't reinitialize, use bootloader's GDC/Display configuration"
 	depends on FB_MB862XX_LIME
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 0dbd6c6..f8c1bd4 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_FB_OMAP)             += omap/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
 obj-$(CONFIG_FB_CARMINE)          += carminefb.o
 obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
+obj-$(CONFIG_FB_EP93XX)		  += ep93xxfb.o
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
diff --git a/drivers/video/ep93xxfb.c b/drivers/video/ep93xxfb.c
new file mode 100644
index 0000000..6c02520
--- /dev/null
+++ b/drivers/video/ep93xxfb.c
@@ -0,0 +1,658 @@
+/*
+ * linux/drivers/video/ep93xxfb.c
+ *
+ * Framebuffer support for the EP93xx series.
+ *
+ * Copyright (C) 2007 Bluewater Systems
+ * Author: Ryan Mallon <ryan@bluewatersys.com>
+ *
+ * Copyright (c) 2009 H Hartley Sweeten <hsweeten@visionengravers.com>
+ *
+ * Based on the Cirrus Logic ep93xxfb driver, and various other ep93xxfb
+ * drivers.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/clk.h>
+#include <linux/fb.h>
+
+#include <mach/fb.h>
+
+/* Vertical Frame Timing Registers */
+#define EP93XXFB_VLINES_TOTAL			0x0000	/* SW locked */
+#define EP93XXFB_VSYNC				0x0004	/* SW locked */
+#define EP93XXFB_VACTIVE			0x0008	/* SW locked */
+#define EP93XXFB_VBLANK				0x0228	/* SW locked */
+#define EP93XXFB_VCLK				0x000c	/* SW locked */
+
+/* Horizontal Frame Timing Registers */
+#define EP93XXFB_HCLKS_TOTAL			0x0010	/* SW locked */
+#define EP93XXFB_HSYNC				0x0014	/* SW locked */
+#define EP93XXFB_HACTIVE			0x0018	/* SW locked */
+#define EP93XXFB_HBLANK				0x022c	/* SW locked */
+#define EP93XXFB_HCLK				0x001c	/* SW locked */
+
+/* Frame Buffer Memory Configuration Registers */
+#define EP93XXFB_SCREEN_PAGE			0x0028
+#define EP93XXFB_SCREEN_HPAGE			0x002c
+#define EP93XXFB_SCREEN_LINES			0x0030
+#define EP93XXFB_LINE_LENGTH			0x0034
+#define EP93XXFB_VLINE_STEP			0x0038
+#define EP93XXFB_LINE_CARRY			0x003c	/* SW locked */
+#define EP93XXFB_EOL_OFFSET			0x0230
+
+/* Other Video Registers */
+#define EP93XXFB_BRIGHTNESS			0x0020
+#define EP93XXFB_ATTRIBS			0x0024	/* SW locked */
+#define EP93XXFB_SWLOCK				0x007c	/* SW locked */
+#define EP93XXFB_AC_RATE			0x0214
+#define EP93XXFB_FIFO_LEVEL			0x0234
+#define EP93XXFB_PIXELMODE			0x0054
+#define EP93XXFB_PARL_IF_OUT			0x0058
+#define EP93XXFB_PARL_IF_IN			0x005c
+
+/* Blink Control Registers */
+#define EP93XXFB_BLINK_RATE			0x0040
+#define EP93XXFB_BLINK_MASK			0x0044
+#define EP93XXFB_BLINK_PATTRN			0x0048
+#define EP93XXFB_PATTRN_MASK			0x004c
+#define EP93XXFB_BKGRND_OFFSET			0x0050
+
+/* Hardware Cursor Registers */
+#define EP93XXFB_CURSOR_ADR_START		0x0060
+#define EP93XXFB_CURSOR_ADR_RESET		0x0064
+#define EP93XXFB_CURSOR_SIZE			0x0068
+#define EP93XXFB_CURSOR_COLOR1			0x006c
+#define EP93XXFB_CURSOR_COLOR2			0x0070
+#define EP93XXFB_CURSOR_BLINK_COLOR1		0x021c
+#define EP93XXFB_CURSOR_BLINK_COLOR2		0x0220
+#define EP93XXFB_CURSOR_XY_LOC			0x0074
+#define EP93XXFB_CURSOR_DSCAN_HY_LOC		0x0078
+#define EP93XXFB_CURSOR_BLINK_RATE_CTRL		0x0224
+
+/* LUT Registers */
+#define EP93XXFB_GRY_SCL_LUTR			0x0080
+#define EP93XXFB_GRY_SCL_LUTG			0x0280
+#define EP93XXFB_GRY_SCL_LUTB			0x0300
+#define EP93XXFB_LUT_SW_CONTROL			0x0218
+#define EP93XXFB_COLOR_LUT			0x0400
+
+/* Video Signature Registers */
+#define EP93XXFB_VID_SIG_RSLT_VAL		0x0200
+#define EP93XXFB_VID_SIG_CTRL			0x0204
+#define EP93XXFB_VSIG				0x0208
+#define EP93XXFB_HSIG				0x020c
+#define EP93XXFB_SIG_CLR_STR			0x0210
+
+/* Minimum / Maximum resolutions supported */
+#define EP93XXFB_MIN_XRES			64
+#define EP93XXFB_MIN_YRES			64
+#define EP93XXFB_MAX_XRES			1024
+#define EP93XXFB_MAX_YRES			768
+
+struct ep93xx_fbi {
+	struct ep93xxfb_mach_info	*mach_info;
+	struct clk			*clk;
+	struct resource			*res;
+	void __iomem			*mmio_base;
+	unsigned int			pseudo_palette[256];
+};
+
+static int check_screenpage_bug = 1;
+module_param(check_screenpage_bug, int, 0644);
+MODULE_PARM_DESC(check_screenpage_bug,
+		"Check for bit 27 screen page bug. Default = 1");
+
+static inline unsigned int ep93xxfb_readl(struct ep93xx_fbi *fbi,
+					  unsigned int off)
+{
+	return __raw_readl(fbi->mmio_base + off);
+}
+
+static inline void ep93xxfb_writel(struct ep93xx_fbi *fbi, unsigned int val, 
+				   unsigned int off)
+{
+	__raw_writel(val, fbi->mmio_base + off);
+}
+
+/*
+ * Write to one of the locked raster registers.
+ */
+static inline void ep93xxfb_out_locked(struct ep93xx_fbi *fbi,
+				       unsigned int val, unsigned int reg)
+{
+	/*
+	 * We don't need a lock or delay here since the raster register
+	 * block will remain unlocked until the next access.
+	 */
+	ep93xxfb_writel(fbi, 0xaa, EP93XXFB_SWLOCK);
+	ep93xxfb_writel(fbi, val, reg);
+}
+
+static void ep93xxfb_set_video_attribs(struct fb_info *info)
+{
+	struct ep93xx_fbi *fbi = info->par;
+	unsigned int attribs;
+
+	attribs = EP93XXFB_ENABLE;
+	attribs |= fbi->mach_info->flags;
+	ep93xxfb_out_locked(fbi, attribs, EP93XXFB_ATTRIBS);
+}
+
+static int ep93xxfb_set_pixelmode(struct fb_info *info)
+{
+	struct ep93xx_fbi *fbi = info->par;
+	unsigned int val;
+
+	info->var.transp.offset = 0;
+	info->var.transp.length = 0;
+
+	switch (info->var.bits_per_pixel) {
+	case 8:
+		/*
+		 * TRBSW = 0	Normal Red/Green/Blue
+		 * DSCAN = 0	Single Scan
+		 * C     = 0	Use LUT Data
+		 * M     = 0	Blink Mode Disabled
+		 * S     = 1	1 pixel mapped to 18-bits per clock
+		 * P     = 2	8-bits/pixel
+		 */
+		val = (0<<15) | (0<<14) | (0<<10) | (0<<6) | (1<<3) | (2<<0);
+
+		info->var.red.offset	= 0;
+		info->var.red.length	= 8;
+		info->var.green.offset	= 0;
+		info->var.green.length	= 8;
+		info->var.blue.offset	= 0;
+		info->var.blue.length	= 8;
+		info->fix.visual 	= FB_VISUAL_PSEUDOCOLOR;
+		break;
+
+	case 16:
+		/*
+		 * TRBSW = 0	Normal Red/Green/Blue
+		 * DSCAN = 0	Single Scan
+		 * C     = 5	16-bit 555 color mode
+		 * M     = 0	Blink Mode Disabled
+		 * S     = 1	1 pixel mapped to 18-bits per clock
+		 * P     = 4	16-bits/pixel
+		 */
+		val = (0<<15) | (0<<14) | (5<<10) | (0<<6) | (1<<3) | (4<<0);
+
+		info->var.red.offset	= 11;
+		info->var.red.length	= 5;
+		info->var.green.offset	= 5;
+		info->var.green.length	= 6;
+		info->var.blue.offset	= 0;
+		info->var.blue.length	= 5;
+		info->fix.visual 	= FB_VISUAL_TRUECOLOR;
+		break;
+
+	case 24:
+		/*
+		 * TRBSW = 0	Normal Red/Green/Blue
+		 * DSCAN = 0	Single Scan
+		 * C     = 4	Triple 8-bits per channel
+		 * M     = 0	Blink Mode Disabled
+		 * S     = 0	1 pixel per clock (up to 24-bits)
+		 * P     = 6	24-bits/pixel packed
+		 */
+		val = (0<<15) | (0<<14) | (4<<10) | (0<<6) | (0<<3) | (6<<0);
+
+		info->var.red.offset	= 16;
+		info->var.red.length	= 8;
+		info->var.green.offset	= 8;
+		info->var.green.length	= 8;
+		info->var.blue.offset	= 0;
+		info->var.blue.length	= 8;
+		info->fix.visual 	= FB_VISUAL_TRUECOLOR;
+		break;
+
+	case 32:
+		/*
+		 * TRBSW = 0	Normal Red/Green/Blue
+		 * DSCAN = 0	Single Scan
+		 * C     = 4	Triple 8-bits per channel
+		 * M     = 0	Blink Mode Disabled
+		 * S     = 0	1 pixel per clock (up to 24-bits)
+		 * P     = 7	32-bits per pixel (24-bits/pixel unpacked)
+		 */
+		val = (0<<15) | (0<<14) | (4<<10) | (0<<6) | (0<<3) | (7<<0);
+
+		info->var.red.offset	= 16;
+		info->var.red.length	= 8;
+		info->var.green.offset	= 8;
+		info->var.green.length	= 8;
+		info->var.blue.offset	= 0;
+		info->var.blue.length	= 8;
+		info->fix.visual 	= FB_VISUAL_TRUECOLOR;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	ep93xxfb_writel(fbi, val, EP93XXFB_PIXELMODE);
+	return 0;
+}
+
+static void ep93xxfb_set_timing(struct fb_info *info)
+{
+	struct ep93xx_fbi *fbi = info->par;
+	unsigned int vlines_total, hclks_total, start, stop;
+
+	vlines_total = info->var.yres + info->var.upper_margin +
+		info->var.lower_margin + info->var.vsync_len - 1;
+	
+	hclks_total = info->var.xres + info->var.left_margin +
+		info->var.right_margin + info->var.hsync_len - 1;
+	
+	ep93xxfb_out_locked(fbi, vlines_total, EP93XXFB_VLINES_TOTAL);
+	ep93xxfb_out_locked(fbi, hclks_total, EP93XXFB_HCLKS_TOTAL);
+	
+	start = vlines_total;
+	stop = vlines_total - info->var.vsync_len;
+	ep93xxfb_out_locked(fbi, start | (stop << 16), EP93XXFB_VSYNC);
+	
+	start = vlines_total - info->var.vsync_len - info->var.upper_margin;
+	stop = info->var.lower_margin - 1;
+	ep93xxfb_out_locked(fbi, start | (stop << 16), EP93XXFB_VBLANK);
+	ep93xxfb_out_locked(fbi, start | (stop << 16), EP93XXFB_VACTIVE);
+
+	start = vlines_total;
+	stop = vlines_total + 1;
+	ep93xxfb_out_locked(fbi, start | (stop << 16), EP93XXFB_VCLK);
+
+	start = hclks_total;
+	stop = hclks_total - info->var.hsync_len;
+	ep93xxfb_out_locked(fbi, start | (stop << 16), EP93XXFB_HSYNC);
+
+	start = hclks_total - info->var.hsync_len - info->var.left_margin;
+	stop = info->var.right_margin - 1;
+	ep93xxfb_out_locked(fbi, start | (stop << 16), EP93XXFB_HBLANK);
+	ep93xxfb_out_locked(fbi, start | (stop << 16), EP93XXFB_HACTIVE);
+
+	start = hclks_total;
+	stop = hclks_total;
+	ep93xxfb_out_locked(fbi, start | (stop << 16), EP93XXFB_HCLK);
+
+	ep93xxfb_out_locked(fbi, 0x0, EP93XXFB_LINE_CARRY);
+}
+
+static int ep93xxfb_set_par(struct fb_info *info)
+{
+	struct ep93xx_fbi *fbi = info->par;
+
+	clk_set_rate(fbi->clk, 1000 * PICOS2KHZ(info->var.pixclock));
+
+	ep93xxfb_set_timing(info);
+
+	info->fix.line_length = info->var.xres_virtual *
+		info->var.bits_per_pixel / 8;
+
+	ep93xxfb_writel(fbi, info->fix.smem_start, EP93XXFB_SCREEN_PAGE);
+	ep93xxfb_writel(fbi, info->var.yres - 1, EP93XXFB_SCREEN_LINES);
+	ep93xxfb_writel(fbi, ((info->var.xres * info->var.bits_per_pixel) 
+			      / 32) - 1, EP93XXFB_LINE_LENGTH);
+	ep93xxfb_writel(fbi, info->fix.line_length / 4, EP93XXFB_VLINE_STEP);
+	ep93xxfb_set_video_attribs(info);
+	return 0;
+}
+
+static int ep93xxfb_check_var(struct fb_var_screeninfo *var,
+			      struct fb_info *info)
+{
+	int err;
+	
+	err = ep93xxfb_set_pixelmode(info);
+	if (err)
+		return err;
+
+	var->xres = max(var->xres, (unsigned int)EP93XXFB_MIN_XRES);
+	var->xres = min(var->xres, (unsigned int)EP93XXFB_MAX_XRES);
+	var->xres_virtual = max(var->xres_virtual, var->xres);
+
+	var->yres = max(var->yres, (unsigned int)EP93XXFB_MIN_YRES);
+	var->yres = min(var->yres, (unsigned int)EP93XXFB_MAX_YRES);
+	var->yres_virtual = max(var->yres_virtual, var->yres);
+
+	return 0;
+}
+
+static int ep93xxfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
+{
+	unsigned int offset = vma->vm_pgoff << PAGE_SHIFT;
+	
+	if (offset < info->fix.smem_len) {
+		return dma_mmap_writecombine(info->dev, vma, info->screen_base,
+					     info->fix.smem_start,
+					     info->fix.smem_len);
+	}
+
+	return -EINVAL;
+}
+
+static int ep93xxfb_blank(int blank_mode, struct fb_info *info)
+{
+	struct ep93xx_fbi *fbi = info->par;
+	unsigned int attribs = ep93xxfb_readl(fbi, EP93XXFB_ATTRIBS);
+	
+	if (blank_mode) {
+		if (fbi->mach_info->blank)
+			fbi->mach_info->blank(blank_mode, info);
+		ep93xxfb_out_locked(fbi, attribs & ~EP93XXFB_ENABLE,
+				    EP93XXFB_ATTRIBS);
+		clk_disable(fbi->clk);
+	} else {
+		clk_enable(fbi->clk);
+		ep93xxfb_out_locked(fbi, attribs | EP93XXFB_ENABLE,
+				    EP93XXFB_ATTRIBS);
+		if (fbi->mach_info->blank)
+			fbi->mach_info->blank(blank_mode, info);
+	}
+	
+	return 0;
+}
+
+static inline int ep93xxfb_convert_color(int val, int width)
+{
+	return ((val << width) + 0x7fff - val) >> 16;
+}
+
+static int ep93xxfb_setcolreg(unsigned int regno, unsigned int red,
+			unsigned int green, unsigned int blue,
+			unsigned int transp, struct fb_info *info)
+{
+	struct ep93xx_fbi *fbi = info->par;
+	unsigned int *pal = info->pseudo_palette;
+	unsigned int ctrl, i, rgb;
+	
+	switch (info->fix.visual) {
+	case FB_VISUAL_PSEUDOCOLOR:
+		rgb = ((red & 0xff00) << 8) | (green & 0xff00) |
+			((blue & 0xff00) >> 8);
+		
+		pal[regno] = rgb;
+		ep93xxfb_writel(fbi, rgb, (EP93XXFB_COLOR_LUT + (regno << 2)));
+		ctrl = ep93xxfb_readl(fbi, EP93XXFB_LUT_SW_CONTROL);
+
+		if (!!(ctrl & (1 << 1)) == !!(ctrl & (1 << 0))) {
+			for (i = 0; i < 256; i++) {
+				ep93xxfb_writel(fbi, pal[i],
+					EP93XXFB_COLOR_LUT + (i << 2));
+			}
+
+			ep93xxfb_writel(fbi, ctrl ^ (1<<0),
+				EP93XXFB_LUT_SW_CONTROL);
+		}
+		break;
+
+	case FB_VISUAL_TRUECOLOR:
+		if (regno > 16)
+			return 1;
+
+		red = ep93xxfb_convert_color(red, info->var.red.length);
+		green = ep93xxfb_convert_color(green, info->var.green.length);
+		blue = ep93xxfb_convert_color(blue, info->var.blue.length);
+		transp = ep93xxfb_convert_color(transp,
+						info->var.transp.length);
+
+		pal[regno] = (red << info->var.red.offset) |
+			(green << info->var.green.offset) |
+			(blue << info->var.blue.offset) |
+			(transp << info->var.transp.offset);
+		break;
+
+	default:
+		return 1;
+	}
+
+	return 0;
+}
+
+static struct fb_ops ep93xxfb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_check_var	= ep93xxfb_check_var,
+	.fb_set_par	= ep93xxfb_set_par,
+	.fb_blank	= ep93xxfb_blank,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_setcolreg	= ep93xxfb_setcolreg,
+	.fb_mmap	= ep93xxfb_mmap,
+};
+
+static int __init ep93xxfb_calc_fbsize(struct ep93xxfb_mach_info *mach_info)
+{
+	int i, fb_size = 0;
+
+	if (mach_info->num_modes == EP93XXFB_USE_MODEDB) {
+		fb_size = EP93XXFB_MAX_XRES * EP93XXFB_MAX_YRES *
+			mach_info->bpp / 8;
+	} else {
+		for (i = 0; i < mach_info->num_modes; i++) {
+			const struct fb_videomode *mode;
+			int size;
+			
+			mode = &mach_info->modes[i];
+			size = mode->xres * mode->yres * mach_info->bpp / 8;
+			if (size > fb_size)
+				fb_size = size;
+		}
+	}
+	
+	return fb_size;
+}
+
+static int __init ep93xxfb_alloc_videomem(struct fb_info *info)
+{
+	struct ep93xx_fbi *fbi = info->par;
+	char __iomem *virt_addr;
+	dma_addr_t phys_addr;
+	unsigned int fb_size;
+
+	fb_size = ep93xxfb_calc_fbsize(fbi->mach_info);
+	virt_addr = dma_alloc_writecombine(info->dev, fb_size,
+					   &phys_addr, GFP_KERNEL);
+	if (!virt_addr)
+		return -ENOMEM;
+	
+	/*
+	 * There is a bug in the ep93xx framebuffer which causes problems
+	 * if bit 27 of the physical address is set.
+	 * See: http://marc.info/?l=linux-arm-kernel&m=110061245502000&w=2
+	 * There does not seem to be any offical errata for this, but I
+	 * have confirmed the problem exists on my hardware (ep9315) at
+	 * least.
+	 */
+	if (check_screenpage_bug && phys_addr & (1 << 27)) {
+		dev_err(info->dev, "ep93xx framebuffer bug. phys addr (0x%x) "
+			"has bit 27 set: cannot init framebuffer\n", 
+			phys_addr);
+		
+		dma_free_coherent(info->dev, fb_size, virt_addr, phys_addr);
+		return -ENOMEM;
+	}
+
+	info->fix.smem_start = phys_addr;
+	info->fix.smem_len = fb_size;
+	info->screen_base = virt_addr;
+
+	return 0;
+}
+
+static void ep93xxfb_dealloc_videomem(struct fb_info *info)
+{
+	if (info->screen_base)
+		dma_free_coherent(info->dev, info->fix.smem_len,
+				  info->screen_base, info->fix.smem_start);
+}
+
+static int __init ep93xxfb_probe(struct platform_device *pdev)
+{
+	struct ep93xxfb_mach_info *mach_info = pdev->dev.platform_data;
+	struct fb_info *info;
+	struct ep93xx_fbi *fbi;
+	struct resource *res;
+	char *video_mode;
+	int err;
+	
+	if (!mach_info)
+		return -EINVAL;
+	
+	info = framebuffer_alloc(sizeof(struct ep93xx_fbi), &pdev->dev);
+	if (!info)
+		return -ENOMEM;
+	
+	info->dev = &pdev->dev;
+	platform_set_drvdata(pdev, info);
+	fbi = info->par;
+	fbi->mach_info = mach_info;
+	
+	err = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (err)
+		goto failed;
+
+	err = ep93xxfb_alloc_videomem(info);
+	if (err)
+		goto failed;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		err = -ENXIO;
+		goto failed;
+	}
+	res = request_mem_region(res->start, resource_size(res), pdev->name);
+	if (res == NULL) {
+		err = -EBUSY;
+		goto failed;
+	}
+	fbi->res = res;
+	fbi->mmio_base = ioremap(res->start, resource_size(res));
+	if (fbi->mmio_base == NULL) {
+		err = -ENXIO;
+		goto failed;
+	}
+	
+	strcpy(info->fix.id, pdev->name);
+	info->fbops		= &ep93xxfb_ops;
+	info->fix.type		= FB_TYPE_PACKED_PIXELS;
+	info->fix.accel		= FB_ACCEL_NONE;
+	info->var.activate	= FB_ACTIVATE_NOW;
+	info->var.vmode		= FB_VMODE_NONINTERLACED;
+	info->flags		= FBINFO_DEFAULT;
+	info->node		= -1;
+	info->state		= FBINFO_STATE_RUNNING;
+	info->pseudo_palette	= &fbi->pseudo_palette;
+	
+	fb_get_options("ep93xxfb", &video_mode);
+	err = fb_find_mode(&info->var, info, video_mode,
+			   fbi->mach_info->modes, fbi->mach_info->num_modes,
+			   fbi->mach_info->default_mode, fbi->mach_info->bpp);
+	if (err == 0) {
+		dev_err(info->dev, "No suitable video mode found\n");
+		err = -EINVAL;
+		goto failed;
+	}
+
+	if (mach_info->setup) {
+		err = mach_info->setup(info);
+		if (err)
+			return err;
+	}
+
+	err = ep93xxfb_check_var(&info->var, info);
+	if (err)
+		goto failed;
+
+	fbi->clk = clk_get(info->dev, NULL);
+	if (IS_ERR(fbi->clk)) {
+		err = PTR_ERR(fbi->clk);
+		fbi->clk = NULL;
+		goto failed;
+	}
+	
+	ep93xxfb_set_par(info);
+	clk_enable(fbi->clk);
+	
+	err = register_framebuffer(info);
+	if (err)
+		goto failed;
+	
+	dev_info(info->dev, "registered. Mode = %dx%d-%d\n",
+		 info->var.xres, info->var.yres, info->var.bits_per_pixel);
+	return 0;
+	
+failed:
+	if (fbi->clk)
+		clk_put(fbi->clk);
+	if (fbi->mmio_base)
+		iounmap(fbi->mmio_base);
+	if (fbi->res)
+		release_mem_region(fbi->res->start, resource_size(fbi->res));
+	ep93xxfb_dealloc_videomem(info);
+	if (&info->cmap)
+		fb_dealloc_cmap(&info->cmap);
+	if (fbi->mach_info->teardown)
+		fbi->mach_info->teardown(info);
+	kfree(info);
+	platform_set_drvdata(pdev, NULL);
+	
+	return err;
+}
+
+static int ep93xxfb_remove(struct platform_device *pdev)
+{
+	struct fb_info *info = platform_get_drvdata(pdev);
+	struct ep93xx_fbi *fbi = info->par;
+	
+	unregister_framebuffer(info);
+	clk_disable(fbi->clk);
+	clk_put(fbi->clk);
+	iounmap(fbi->mmio_base);
+	release_mem_region(fbi->res->start, resource_size(fbi->res));
+	ep93xxfb_dealloc_videomem(info);
+	fb_dealloc_cmap(&info->cmap);
+	
+	if (fbi->mach_info->teardown)
+		fbi->mach_info->teardown(info);
+	
+	kfree(info);
+	platform_set_drvdata(pdev, NULL);
+	
+	return 0;
+}
+
+static struct platform_driver ep93xxfb_driver = {
+	.probe		= ep93xxfb_probe,
+	.remove		= ep93xxfb_remove,
+	.driver = {
+		.name	= "ep93xxfb",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __devinit ep93xxfb_init(void)
+{
+	return platform_driver_register(&ep93xxfb_driver);
+}
+
+static void __exit ep93xxfb_exit(void)
+{
+	platform_driver_unregister(&ep93xxfb_driver);
+}
+
+module_init(ep93xxfb_init);
+module_exit(ep93xxfb_exit);
+
+MODULE_DESCRIPTION("EP93XX Framebuffer Driver");
+MODULE_ALIAS("platform:ep93xxfb");
+MODULE_AUTHOR("Ryan Mallon <ryan&bluewatersys.com>, "
+	      "H Hartley Sweeten <hsweeten@visionengravers.com");
+MODULE_LICENSE("GPL");


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
