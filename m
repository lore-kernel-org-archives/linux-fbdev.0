From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 1/7] video: Add support for the Avionic
	Design Xanthos framebuffer.
Date: Fri, 22 May 2009 16:29:30 +0200
Message-ID: <1243002576-14476-2-git-send-email-thierry.reding@avionic-design.de>
References: <1243002576-14476-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <thierry.reding@avionic-design.de>)
	id 1M7Vjr-0002k4-T5 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 May 2009 14:28:47 +0000
Received: from moutng.kundenserver.de ([212.227.126.171])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7Vjp-0007XK-Pb for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 May 2009 14:28:47 +0000
In-Reply-To: <1243002576-14476-1-git-send-email-thierry.reding@avionic-design.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

This patch adds support for the Avionic Design Xanthos framebuffer.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/video/Kconfig         |   12 ++
 drivers/video/Makefile        |    1 +
 drivers/video/adxfb/Makefile  |    1 +
 drivers/video/adxfb/adxfb.h   |  118 ++++++++++++
 drivers/video/adxfb/fb.c      |  411 +++++++++++++++++++++++++++++++++++++++++
 drivers/video/adxfb/overlay.c |  190 +++++++++++++++++++
 drivers/video/adxfb/scaler.c  |  231 +++++++++++++++++++++++
 include/video/Kbuild          |    1 +
 include/video/adxfb.h         |  128 +++++++++++++
 9 files changed, 1093 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/adxfb/Makefile
 create mode 100644 drivers/video/adxfb/adxfb.h
 create mode 100644 drivers/video/adxfb/fb.c
 create mode 100644 drivers/video/adxfb/overlay.c
 create mode 100644 drivers/video/adxfb/scaler.c
 create mode 100644 include/video/adxfb.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0048f11..49e1b69 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1663,6 +1663,18 @@ config CARMINE_DRAM_CUSTOM
 	  Use custom board timings.
 endchoice
 
+config FB_ADX
+	tristate "Avionic Design Xanthos framebuffer support"
+	depends on FB
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  Framebuffer driver for the LCD controller in Avionic Design
+	  Xanthos boards.
+
+	  If in doubt, say N.
+
 config FB_AU1100
 	bool "Au1100 LCD Driver"
 	depends on (FB = y) && MIPS && SOC_AU1100
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index d8d0be5..4de52a5 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -125,6 +125,7 @@ obj-$(CONFIG_FB_OMAP)             += omap/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
 obj-$(CONFIG_FB_CARMINE)          += carminefb.o
 obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
+obj-$(CONFIG_FB_ADX)              += adxfb/
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
diff --git a/drivers/video/adxfb/Makefile b/drivers/video/adxfb/Makefile
new file mode 100644
index 0000000..389d65c
--- /dev/null
+++ b/drivers/video/adxfb/Makefile
@@ -0,0 +1 @@
+obj-y	+= fb.o overlay.o scaler.o
diff --git a/drivers/video/adxfb/adxfb.h b/drivers/video/adxfb/adxfb.h
new file mode 100644
index 0000000..8238bf3
--- /dev/null
+++ b/drivers/video/adxfb/adxfb.h
@@ -0,0 +1,118 @@
+/*
+ * linux/drivers/video/adxfb/adxfb.h
+ *
+ * Copyright (C) 2007-2008 Avionic Design Development GmbH
+ * Copyright (C) 2008-2009 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Written by Thierry Reding <thierry.reding@avionic-design.de>
+ */
+
+#ifndef _DRIVERS_VIDEO_ADXFB_ADXFB_H
+#define _DRIVERS_VIDEO_ADXFB_ADXFB_H 1
+
+#include <linux/spinlock.h>
+#include <video/adxfb.h>
+
+/**
+ * struct adxfb_info - Avionic Design Xanthos framebuffer info structure
+ * @palette:		VGA palette storage
+ * @io_base:		memory-mapped base address for graphics controller
+ * @scaler_base:	memory-mapped base address for scaler
+ * @ioctl:		machine-specific I/O control handler
+ */
+struct adxfb_info {
+	u32 palette[16];
+
+	void __iomem *io_base;
+	void __iomem *scaler_base;
+	spinlock_t lock;
+
+	int (*ioctl)(struct fb_info *info, unsigned int command,
+			unsigned long arg);
+};
+
+/* register definitions */
+#define ADXFB_CONTROL			0x000
+#define ADXFB_CONTROL_ENABLE		(1 <<  0)
+#define ADXFB_CONTROL_SYNC		(1 <<  1)
+#define ADXFB_CONTROL_DOUBLE_Y		(1 <<  2)
+#define ADXFB_CONTROL_HALVE_X		(1 <<  3)
+#define ADXFB_CONTROL_TRIPLE_Y		(1 <<  4)
+#define ADXFB_CONTROL_LOCK		(1 << 31)
+#define ADXFB_OVERLAY_CONTROL		0x008
+#define ADXFB_OVERLAY_CONTROL_OVERLAY	(1 << 0)
+#define ADXFB_OVERLAY_CONTROL_ALPHA	(1 << 1)
+#define ADXFB_OVERLAY_START		0x010
+#define ADXFB_OVERLAY_END		0x018
+#define ADXFB_OVERLAY_PAGE0_START	0x020
+#define ADXFB_OVERLAY_PAGE0_END		0x028
+#define ADXFB_OVERLAY_PAGE0_SIZE	0x030
+#define ADXFB_OVERLAY_PAGE1_START	0x038
+#define ADXFB_OVERLAY_PAGE1_END		0x040
+#define ADXFB_OVERLAY_PAGE1_SIZE	0x048
+#define ADXFB_OVERLAY_LEVEL		0x050
+#define ADXFB_ALPHA_START		0x058
+#define ADXFB_ALPHA_END			0x060
+#define ADXFB_ALPHA_PAGE1_START		0x068
+#define ADXFB_ALPHA_PAGE1_END		0x070
+#define ADXFB_ALPHA_PAGE1_SIZE		0x078
+#define ADXFB_PAGE0_BASE		0x080
+#define ADXFB_PAGE0_FORMAT		0x088
+#define ADXFB_PAGE0_RESOLUTION		0x090
+#define ADXFB_PAGE0_RESOLUTION_BYTE	0x098
+#define ADXFB_PAGE0_SIZE		0x0a0
+#define ADXFB_PAGE1_BASE		0x0b0
+#define ADXFB_PAGE1_FORMAT		0x0b8
+#define ADXFB_PAGE1_RESOLUTION		0x0c0
+#define ADXFB_PAGE1_RESOLUTION_PHYSICAL	0x0c8
+#define ADXFB_PAGE1_RESOLUTION_VIRTUAL	0x0d0
+#define ADXFB_PAGE1_SIZE_PHYSICAL	0x0d8
+#define ADXFB_PAGE1_SIZE_VIRTUAL	0x0e0
+#define ADXFB_PAGE1_OFFSET		0x0e8
+#define ADXFB_PAGE1_SECONDARY_BASE	0x0f0
+#define ADXFB_COLOR_OFFSET		0x100
+#define ADXFB_COLOR_MUL			0x108
+
+/* page format (ADXFB_PAGE0_FORMAT, ADXFB_PAGE1_FORMAT) */
+#define ADXFB_FMT_NONE		0
+#define ADXFB_FMT_GRAYSCALE_8	1
+#define ADXFB_FMT_RGB_565	2
+#define ADXFB_FMT_RGB_888	3
+#define ADXFB_FMT_RGBA_8888	4
+
+/**
+ * adxfb_r32() - read 32-bit register
+ * @fb:		framebuffer context
+ * @offset:	relative register offset
+ */
+static inline u32 adxfb_r32(struct adxfb_info *fb, unsigned long offset)
+{
+	return readl(fb->io_base + offset);
+}
+
+/**
+ * adxfb_w32() - write 32-bit register
+ * @fb:		framebuffer context
+ * @offset:	relative register offset
+ * @value:	value to write to register
+ */
+static inline void adxfb_w32(struct adxfb_info *fb, unsigned long offset,
+		u32 value)
+{
+	writel(value, fb->io_base + offset);
+}
+
+extern int adxfb_scaler_set_mode(struct fb_info *info,
+		struct adxfb_scaler_mode *mode);
+extern int adxfb_scaler_get_mode(struct fb_info *info,
+		struct adxfb_scaler_mode *mode);
+
+extern int adxfb_overlay_enable(struct fb_info *info, unsigned long flags);
+extern int adxfb_overlay_set_viewport(struct fb_info *info,
+		struct adxfb_viewport *viewport);
+
+#endif /* !_DRIVERS_VIDEO_ADXFB_ADXFB_H */
diff --git a/drivers/video/adxfb/fb.c b/drivers/video/adxfb/fb.c
new file mode 100644
index 0000000..7b6f0a5
--- /dev/null
+++ b/drivers/video/adxfb/fb.c
@@ -0,0 +1,411 @@
+/*
+ * linux/drivers/video/adxfb/fb.c
+ *
+ * Copyright (C) 2007-2008 Avionic Design Development GmbH
+ * Copyright (C) 2008-2009 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Written by Thierry Reding <thierry.reding@avionic-design.de>
+ */
+
+#include <linux/fb.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+
+#include "adxfb.h"
+
+/**
+ * adxfb_setcolreg() - set color register
+ * @regno:	register number to set
+ * @red:	red color component
+ * @green:	green color component
+ * @blue:	blue color component
+ * @transp:	transparency component
+ * @info:	framebuffer context
+ */
+static int adxfb_setcolreg(unsigned regno, unsigned red, unsigned green,
+		unsigned blue, unsigned transp, struct fb_info *info)
+{
+	if ((regno >= info->cmap.len) || (regno > 255))
+		return 1;
+
+#define CNVT_TOHW(val, width) ((((val) << (width)) + 0x7FFF - (val)) >> 16)
+	switch (info->fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		if (regno < 16) {
+			((struct adxfb_info *)info->par)->palette[regno] =
+				(CNVT_TOHW(red, info->var.red.length)
+					<< info->var.red.offset) |
+				(CNVT_TOHW(green, info->var.green.length)
+					<< info->var.green.offset) |
+				(CNVT_TOHW(blue, info->var.blue.length)
+					<< info->var.blue.offset) |
+				(CNVT_TOHW(transp, info->var.transp.length)
+					<< info->var.transp.offset);
+		}
+		break;
+
+	default:
+		dev_err(info->dev, "bad depth: %u\n", info->var.bits_per_pixel);
+		break;
+	}
+#undef CNVT_TOHW
+
+	return 0;
+}
+
+/**
+ * adxfb_ioctl() - handle I/O controls
+ * @info:	framebuffer context
+ * @command:	I/O control code
+ * @arg:	I/O control argument
+ */
+static int adxfb_ioctl(struct fb_info *info, unsigned int command,
+		unsigned long arg)
+{
+	struct adxfb_info *fb = info->par;
+	void __user *argp = (void __user *)arg;
+	struct adxfb_scaler_mode mode;
+	struct adxfb_viewport viewport;
+	int err = 0;
+
+	switch (command) {
+	case ADXFB_IOCTL_SCALER_SET_MODE:
+		if (copy_from_user(&mode, argp, sizeof(mode)))
+			return -EFAULT;
+
+		err = adxfb_scaler_set_mode(info, &mode);
+		if (err < 0)
+			return err;
+
+		break;
+
+	case ADXFB_IOCTL_SCALER_GET_MODE:
+		err = adxfb_scaler_get_mode(info, &mode);
+		if (err < 0)
+			return err;
+
+		if (copy_to_user(argp, &mode, sizeof(mode)))
+			return -EFAULT;
+
+		break;
+
+	case ADXFB_IOCTL_OVERLAY_ENABLE:
+		err = adxfb_overlay_enable(info, arg);
+		if (err < 0)
+			return err;
+
+		break;
+
+	case ADXFB_IOCTL_OVERLAY_SET_VIEWPORT:
+		if (copy_from_user(&viewport, argp, sizeof(viewport)))
+			return -EFAULT;
+
+		err = adxfb_overlay_set_viewport(info, &viewport);
+		if (err < 0)
+			return err;
+
+		break;
+
+	default:
+		if (fb && fb->ioctl)
+			return fb->ioctl(info, command, arg);
+
+		break;
+	}
+
+	return 0;
+}
+
+/* framebuffer operations */
+static struct fb_ops adxfb_ops = {
+	.owner = THIS_MODULE,
+	.fb_setcolreg = adxfb_setcolreg,
+	.fb_ioctl = adxfb_ioctl,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+};
+
+/**
+ * adxfb_set_bitfield() - initialize a bitfield structure
+ * @bf:		bitfield structure to fill
+ * @offset:	value for offset field
+ * @length:	value for length field
+ * @msb_right:	value for msb_right field
+ */
+static void adxfb_set_bitfield(struct fb_bitfield *bf, u32 offset, u32 length,
+		u32 msb_right)
+{
+	bf->offset = offset;
+	bf->length = length;
+	bf->msb_right = msb_right;
+}
+
+/**
+ * adxfb_fmt_to_mode() - convert format type to video mode parameters
+ * @fmt:	ADXFB format type
+ * @mode:	video mode
+ */
+static int adxfb_fmt_to_mode(u8 fmt, struct adxfb_mode_info *mode)
+{
+	switch (fmt) {
+	case ADXFB_FMT_GRAYSCALE_8:
+		/* FIXME: use correct values here */
+		adxfb_set_bitfield(&mode->red,   5, 3, 0);
+		adxfb_set_bitfield(&mode->green, 3, 2, 0);
+		adxfb_set_bitfield(&mode->blue,  0, 3, 0);
+		mode->bpp = 8;
+		break;
+
+	case ADXFB_FMT_RGB_565:
+		adxfb_set_bitfield(&mode->red,   11, 5, 0);
+		adxfb_set_bitfield(&mode->green,  5, 6, 0);
+		adxfb_set_bitfield(&mode->blue,   0, 5, 0);
+		mode->bpp = 16;
+		break;
+
+	case ADXFB_FMT_RGB_888:
+		/* FIXME: verify that these are correct values */
+		adxfb_set_bitfield(&mode->red,   16, 8, 0);
+		adxfb_set_bitfield(&mode->green,  8, 8, 0);
+		adxfb_set_bitfield(&mode->blue,   0, 8, 0);
+		mode->bpp = 24;
+		break;
+
+	case ADXFB_FMT_RGBA_8888:
+		/* FIXME: verify that these are correct values */
+		adxfb_set_bitfield(&mode->red,   16, 8, 0);
+		adxfb_set_bitfield(&mode->green,  8, 8, 0);
+		adxfb_set_bitfield(&mode->blue,   0, 8, 0);
+		mode->bpp = 32;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * adxfb_get_mach_mode() - obtain the current video mode
+ * @fb:		framebuffer context
+ * @mode:	structure to return the video mode in
+ */
+static int adxfb_get_mach_mode(struct adxfb_info *fb,
+		struct adxfb_mode_info *mode)
+{
+	u32 size;
+	u16 resx;
+	u16 resy;
+	u8 fmt;
+
+	size = adxfb_r32(fb, ADXFB_PAGE0_RESOLUTION);
+	resx = (size >> 16) & 0x7ff;
+	resy = (size >>  0) & 0x7ff;
+
+	fmt = adxfb_r32(fb, ADXFB_PAGE0_FORMAT) & 0xff;
+
+	mode->xres = resx;
+	mode->yres = resy;
+
+	return adxfb_fmt_to_mode(fmt, mode);
+}
+
+/**
+ * adxfb_probe() - initialize the framebuffer device
+ * @pdev:	platform device
+ */
+static int __init adxfb_probe(struct platform_device *pdev)
+{
+	struct adxfb_mach_info *mach_info = pdev->dev.platform_data;
+	struct adxfb_mode_info mode;
+	struct adxfb_info *fb;
+	struct fb_info *info;
+	struct resource *res;
+	int err = 0;
+
+	info = framebuffer_alloc(sizeof(struct adxfb_info), &pdev->dev);
+	if (!info) {
+		dev_err(&pdev->dev, "failed to allocate framebuffer device\n");
+		return -ENOMEM;
+	}
+
+	fb = info->par;
+	spin_lock_init(&fb->lock);
+
+	if (mach_info)
+		fb->ioctl = mach_info->ioctl;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get graphics controller I/O "
+				"memory resource\n");
+		err = -ENXIO;
+		goto free;
+	}
+
+	res = devm_request_mem_region(&pdev->dev, res->start,
+			res->end - res->start + 1, res->name);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to request graphics controller "
+				"I/O memory region\n");
+		err = -ENXIO;
+		goto free;
+	}
+
+	fb->io_base = devm_ioremap_nocache(&pdev->dev, res->start,
+			res->end - res->start + 1);
+	if (!fb->io_base) {
+		err = -ENXIO;
+		goto free;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get scaler I/O memory "
+				"resource\n");
+		err = -ENXIO;
+		goto free;
+	}
+
+	res = devm_request_mem_region(&pdev->dev, res->start,
+			res->end - res->start + 1, res->name);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to request scaler I/O memory "
+				"region\n");
+		err = -ENXIO;
+		goto free;
+	}
+
+	fb->scaler_base = devm_ioremap_nocache(&pdev->dev, res->start,
+			res->end - res->start + 1);
+	if (!fb->scaler_base) {
+		err = -ENXIO;
+		goto free;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get framebuffer I/O memory "
+				"resource\n");
+		err = -ENXIO;
+		goto free;
+	}
+
+	res = devm_request_mem_region(&pdev->dev, res->start,
+			res->end - res->start + 1, res->name);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to request framebuffer I/O "
+				"memory region\n");
+		err = -ENXIO;
+		goto free;
+	}
+
+	info->screen_base = devm_ioremap_nocache(&pdev->dev, res->start,
+			res->end - res->start + 1);
+	if (!info->screen_base) {
+		err = -ENXIO;
+		goto free;
+	}
+
+	/* TODO: add some checking for these parameters */
+	memset(&mode, 0, sizeof(mode));
+	adxfb_get_mach_mode(fb, &mode);
+
+	snprintf(info->fix.id, sizeof(info->fix.id), "adxfb");
+	info->fix.type = FB_TYPE_PACKED_PIXELS;
+	info->fix.visual = FB_VISUAL_TRUECOLOR;
+	info->fix.accel = FB_ACCEL_NONE;
+	info->fix.line_length = mode.xres * (mode.bpp / 8);
+	info->fix.smem_start = res->start;
+	info->fix.smem_len = res->end - res->start + 1;
+
+	info->var.activate = FB_ACTIVATE_NOW;
+	info->var.vmode = FB_VMODE_NONINTERLACED;
+	info->var.xres = mode.xres;
+	info->var.yres = mode.yres;
+	info->var.xres_virtual = mode.xres;
+	info->var.yres_virtual = mode.yres;
+	info->var.bits_per_pixel = mode.bpp;
+	info->var.red = mode.red;
+	info->var.green = mode.green;
+	info->var.blue = mode.blue;
+	info->var.width = mode.xres;
+	info->var.height = mode.yres;
+
+	info->fbops = &adxfb_ops;
+	info->flags = FBINFO_DEFAULT;
+	info->pseudo_palette = fb->palette;
+
+	err = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (err < 0) {
+		err = -ENOMEM;
+		goto free;
+	}
+
+	err = register_framebuffer(info);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to register framebuffer\n");
+		goto cmap;
+	}
+
+	dev_info(info->dev, "ADX framebuffer initialized\n");
+	platform_set_drvdata(pdev, info);
+	return 0;
+
+cmap:
+	fb_dealloc_cmap(&info->cmap);
+free:
+	framebuffer_release(info);
+	return err;
+}
+
+/**
+ * adxfb_remove() - shutdown the framebuffer device
+ * @pdev:	platform device
+ */
+static int adxfb_remove(struct platform_device *pdev)
+{
+	struct fb_info *info = platform_get_drvdata(pdev);
+	unregister_framebuffer(info);
+	return 0;
+}
+
+/* ADXFB platform driver */
+static struct platform_driver adxfb_driver = {
+	.probe = adxfb_probe,
+	.remove = adxfb_remove,
+	.driver = {
+		.name = "adxfb",
+	},
+};
+
+/**
+ * adxfb_init() - module initialization
+ */
+int __init adxfb_init(void)
+{
+	return platform_driver_register(&adxfb_driver);
+}
+
+/**
+ * adxfb_exit() - module cleanup
+ */
+void __exit adxfb_exit(void)
+{
+	platform_driver_unregister(&adxfb_driver);
+}
+
+module_init(adxfb_init);
+module_exit(adxfb_exit);
+
+MODULE_AUTHOR("Thierry Reding <thierry.reding@avionic-design.de>");
+MODULE_DESCRIPTION("Avionic Design Xanthos framebuffer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/video/adxfb/overlay.c b/drivers/video/adxfb/overlay.c
new file mode 100644
index 0000000..f114a54
--- /dev/null
+++ b/drivers/video/adxfb/overlay.c
@@ -0,0 +1,190 @@
+/*
+ * linux/drivers/video/adxfb/overlay.c
+ *
+ * Copyright (C) 2008 Avionic Design Development GmbH
+ * Copyright (C) 2008 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Written by Thierry Reding <thierry.reding@avionic-design.de>
+ */
+
+#include <linux/fb.h>
+#include "adxfb.h"
+
+/* format to bit-depth table */
+struct fmt_bpp {
+	u8  fmt;
+	int bpp;
+};
+
+static struct fmt_bpp formats[] = {
+	{ ADXFB_FMT_GRAYSCALE_8,  8 },
+	{ ADXFB_FMT_RGB_565,     16 },
+	{ ADXFB_FMT_RGB_888,     24 },
+	{ ADXFB_FMT_RGBA_8888,   32 },
+};
+
+/**
+ * fmt_to_bpp() - obtain the bit-depth for a given page format
+ * @fmt:	format of which to retrieve the bit-depth
+ */
+static int fmt_to_bpp(u8 fmt)
+{
+	int bpp = 0, i;
+
+	for (i = 0; i < ARRAY_SIZE(formats); i++) {
+		if (fmt == formats[i].fmt) {
+			bpp = formats[i].bpp;
+			break;
+		}
+	}
+
+	return bpp;
+}
+
+/**
+ * adxfb_disable() - disable the graphics controller
+ * @fb:		framebuffer context
+ */
+static inline void adxfb_disable(struct adxfb_info *fb)
+{
+	u32 ctrl;
+
+	spin_lock(&fb->lock);
+
+	ctrl = adxfb_r32(fb, ADXFB_CONTROL);
+	ctrl &= ~ADXFB_CONTROL_ENABLE;
+	ctrl |=  ADXFB_CONTROL_LOCK;
+	adxfb_w32(fb, ADXFB_CONTROL, ctrl);
+
+	spin_unlock(&fb->lock);
+}
+
+/**
+ * adxfb_enable() - enable the graphics controller
+ * @fb:		framebuffer context
+ */
+static inline void adxfb_enable(struct adxfb_info *fb)
+{
+	u32 ctrl;
+
+	spin_lock(&fb->lock);
+
+	ctrl = adxfb_r32(fb, ADXFB_CONTROL);
+	ctrl &= ~ADXFB_CONTROL_LOCK;
+	ctrl |=  ADXFB_CONTROL_ENABLE;
+	adxfb_w32(fb, ADXFB_CONTROL, ctrl);
+
+	spin_unlock(&fb->lock);
+}
+
+/**
+ * adxfb_overlay_enable() - enable the overlay window
+ * @info:	framebuffer context
+ * @flags:	flags for enabling/disabling
+ */
+int adxfb_overlay_enable(struct fb_info *info, unsigned long flags)
+{
+	struct adxfb_info *fb = info->par;
+	u32 ctrl;
+
+	if (!info)
+		return -EINVAL;
+
+	spin_lock(&fb->lock);
+
+	ctrl = adxfb_r32(fb, ADXFB_OVERLAY_CONTROL);
+
+	if (flags & ADXFB_OVERLAY_ENABLE)
+		ctrl |=  ADXFB_OVERLAY_CONTROL_OVERLAY;
+	else
+		ctrl &= ~ADXFB_OVERLAY_CONTROL_OVERLAY;
+
+	adxfb_w32(fb, ADXFB_OVERLAY_CONTROL, ctrl);
+
+	spin_unlock(&fb->lock);
+	return 0;
+}
+
+/**
+ * adxfb_overlay_set_viewport() - set the region for the overlay window
+ * @info:	framebuffer context
+ * @viewport:	new screen region for the overlay window
+ */
+int adxfb_overlay_set_viewport(struct fb_info *info,
+		struct adxfb_viewport *viewport)
+{
+	struct adxfb_info *fb = info->par;
+	int sx, sy, dx, dy, ex, ey;
+	int p0dx, p0dy;
+	int p0ps, p1ps;
+	u32 size;
+
+	if (!info || !viewport)
+		return -EINVAL;
+
+	sx = viewport->x & ~0x3;
+	sy = viewport->y & ~0x3;
+	dx = viewport->width & ~0x3;
+	dy = viewport->height & ~0x3;
+	ex = sx + dx - 1;
+	ey = sy + dy - 1;
+
+	size = adxfb_r32(fb, ADXFB_PAGE0_RESOLUTION);
+	p0dx = (size >> 16) & 0x7ff;
+	p0dy = (size >>  0) & 0x7ff;
+
+	size = adxfb_r32(fb, ADXFB_PAGE0_FORMAT) & 0xff;
+	p0ps = fmt_to_bpp(size) / 8;
+
+	size = adxfb_r32(fb, ADXFB_PAGE1_FORMAT) & 0xff;
+	p1ps = fmt_to_bpp(size) / 8;
+
+	adxfb_disable(fb);
+	spin_lock(&fb->lock);
+
+	size = (((dx + 0) & 0x7ff) << 16) | (dy & 0x7ff);
+	adxfb_w32(fb, ADXFB_PAGE1_RESOLUTION, size);
+
+	/* FIXME: (dx + 4) is a hack! */
+	size = ((((dx + 4) * p1ps) & 0x1fff) << 16) | (dy & 0x7ff);
+	adxfb_w32(fb, ADXFB_PAGE1_RESOLUTION_PHYSICAL, size);
+
+	size = ((((p0dx + 0) * p1ps) & 0x1fff) << 16) | (p0dy & 0x7ff);
+	adxfb_w32(fb, ADXFB_PAGE1_RESOLUTION_VIRTUAL, size);
+
+	adxfb_w32(fb, ADXFB_PAGE1_SIZE_PHYSICAL, dx * dy * p1ps);
+	adxfb_w32(fb, ADXFB_PAGE1_SIZE_VIRTUAL, p0dx * p0dy * p1ps);
+
+	size = ((sx & 0x7ff) << 16) | (sy & 0x7ff);
+	adxfb_w32(fb, ADXFB_OVERLAY_START, size);
+
+	size = ((ex & 0x7ff) << 16) | (ey & 0x7ff);
+	adxfb_w32(fb, ADXFB_OVERLAY_END, size);
+
+	size = (((sx * p0ps) & 0x1fff) << 16) | (sy & 0x7ff);
+	adxfb_w32(fb, ADXFB_OVERLAY_PAGE0_START, size);
+	adxfb_w32(fb, ADXFB_PAGE1_OFFSET, size);
+
+	size = (((ex * p0ps) & 0x1fff) << 16) | (ey & 0x7ff);
+	adxfb_w32(fb, ADXFB_OVERLAY_PAGE0_END, size);
+
+	size = (((sx * p1ps) & 0x1fff) << 16) | (sy & 0x7ff);
+	adxfb_w32(fb, ADXFB_OVERLAY_PAGE1_START, size);
+
+	size = (((ex * p1ps) & 0x1fff) << 16) | (ey & 0x7ff);
+	adxfb_w32(fb, ADXFB_OVERLAY_PAGE1_END, size);
+
+	adxfb_w32(fb, ADXFB_OVERLAY_PAGE0_SIZE, dx * dy * p0ps);
+	adxfb_w32(fb, ADXFB_OVERLAY_PAGE1_SIZE, dx * dy * p1ps);
+
+	adxfb_w32(fb, ADXFB_OVERLAY_LEVEL, 0xff);
+
+	spin_unlock(&fb->lock);
+	adxfb_enable(fb);
+
+	return 0;
+}
diff --git a/drivers/video/adxfb/scaler.c b/drivers/video/adxfb/scaler.c
new file mode 100644
index 0000000..96e5796
--- /dev/null
+++ b/drivers/video/adxfb/scaler.c
@@ -0,0 +1,231 @@
+/*
+ * linux/drivers/video/adxfb/fb.c
+ *
+ * Copyright (C) 2007-2008 Avionic Design Development GmbH
+ * Copyright (C) 2008 Avionic Design GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Written by Thierry Reding <thierry.reding@avionic-design.de>
+ */
+
+#include <linux/fb.h>
+#include "adxfb.h"
+
+/**
+ * struct scaler_mode - scaler mode values
+ * @uh:		horizontal up scaling factor
+ * @dh:		horizontal down scaling factor
+ * @uv:		vertical up scaling factor
+ * @dv:		vertical down scaling factor
+ * @ox:		original horizontal resolution
+ * @oy:		original vertical resolution
+ * @tx:		target horizontal resolution
+ * @ty:		target vertical resolution
+ */
+struct scaler_mode {
+	u16 uh, dh;
+	u16 uv, dv;
+	u16 ox, oy;
+	u16 tx, ty;
+};
+
+/* register definitions */
+#define SCALER_MODE				0x000
+#define SCALER_MODE_ENABLE_X	(1 <<  0)
+#define SCALER_MODE_ENABLE_Y	(1 <<  1)
+#define SCALER_MODE_BYPASS_X	(1 <<  2)
+#define SCALER_MODE_BYPASS_Y	(1 <<  3)
+#define SCALER_MODE_RGB_888	(1 <<  4)
+#define SCALER_MODE_LOWPASS	(1 <<  7)
+#define SCALER_MODE_SYNC	(1 <<  8)
+#define SCALER_MODE_RESET	(1 << 15)
+#define SCALER_MODE_LOCK	(1 << 31)
+#define SCALER_UH				0x008
+#define SCALER_DH				0x010
+#define SCALER_UV				0x030
+#define SCALER_DV				0x038
+#define SCALER_ORIGIN_X				0x040
+#define SCALER_ORIGIN_Y				0x048
+#define SCALER_OFFSET_X				0x050
+#define SCALER_OFFSET_Y				0x058
+#define SCALER_TARGET_X				0x060
+#define SCALER_TARGET_Y				0x068
+#define SCALER_ORIGIN_STRIDE			0x070
+#define SCALER_TARGET_STRIDE			0x078
+#define SCALER_ORIGIN_SIZE			0x080
+#define SCALER_TARGET_SIZE			0x088
+#define SCALER_PRIMARY_PRE_TARGET_ADDR		0x090
+#define SCALER_PRIMARY_TARGET_ADDR		0x098
+#define SCALER_SECONDARY_PRE_TARGET_ADDR	0x0a0
+#define SCALER_SECONDARY_TARGET_ADDR		0x0a8
+
+/**
+ * scaler_r32() - read a 32-bit register
+ * @fb:		framebuffer context
+ * @offset:	relative register offset
+ */
+static inline u32 scaler_r32(struct adxfb_info *fb, unsigned long offset)
+{
+	return readl(fb->scaler_base + offset);
+}
+
+/**
+ * scaler_w32() - write a 32-bit register
+ * @fb:		framebuffer context
+ * @offset:	relative register offset
+ * @value:	value to write to the register
+ */
+static inline void scaler_w32(struct adxfb_info *fb, unsigned long offset,
+		u32 value)
+{
+	writel(value, fb->scaler_base + offset);
+}
+
+/**
+ * scaler_enable() - enable the scaling unit
+ * @fb:		framebuffer context
+ */
+static inline void scaler_enable(struct adxfb_info *fb)
+{
+	u32 mode;
+
+	spin_lock(&fb->lock);
+
+	mode = scaler_r32(fb, SCALER_MODE);
+	mode |=  SCALER_MODE_ENABLE_X;
+	mode |=  SCALER_MODE_ENABLE_Y;
+	mode &= ~SCALER_MODE_LOCK;
+	scaler_w32(fb, SCALER_MODE, mode);
+
+	spin_unlock(&fb->lock);
+}
+
+/**
+ * scaler_disable() - disable the scaling unit
+ * @fb:		framebuffer context
+ */
+static inline void scaler_disable(struct adxfb_info *fb)
+{
+	u32 mode;
+
+	spin_lock(&fb->lock);
+
+	mode = scaler_r32(fb, SCALER_MODE);
+	mode |=  SCALER_MODE_LOCK;
+	mode &= ~SCALER_MODE_ENABLE_Y;
+	mode &= ~SCALER_MODE_ENABLE_X;
+	scaler_w32(fb, SCALER_MODE, mode);
+
+	spin_unlock(&fb->lock);
+}
+
+/**
+ * find_mode() - match a request to the best mode that can be achieved
+ * @fb:		framebuffer context
+ * @mode:	requested mode
+ */
+static int find_mode(struct adxfb_info *fb, struct scaler_mode *mode)
+{
+	if (!fb || !mode)
+		return -EINVAL;
+
+	if ((mode->tx == 0) || (mode->ty == 0))
+		return 0;
+
+	mode->uh = scaler_r32(fb, SCALER_UH) & 0x7ff;
+	mode->uh = 128; /* FIXME: don't hardcode */
+	mode->uv = scaler_r32(fb, SCALER_UV) & 0x7ff;
+	mode->uv = 128; /* FIXME: don't hardcode */
+
+	mode->dh = (mode->ox * mode->uh) / mode->tx;
+	mode->dv = (mode->oy * mode->uv) / mode->ty;
+
+	mode->tx = (mode->ox * mode->uh) / mode->dh;
+	mode->ty = (mode->oy * mode->uv) / mode->dv;
+
+	/* TODO: check the parameters */
+
+	return 0;
+}
+
+/**
+ * adxfb_scaler_set_mode() - set a given scaler mode
+ * @info:	framebuffer context
+ * @modep:	scaler mode
+ */
+int adxfb_scaler_set_mode(struct fb_info *info,
+		struct adxfb_scaler_mode *modep)
+{
+	struct adxfb_info *fb = info->par;
+	struct scaler_mode mode;
+	int err, bpp;
+	u32 ctrl;
+
+	memset(&mode, 0, sizeof(mode));
+	mode.ox = modep->origin_x;
+	mode.oy = modep->origin_y;
+	mode.tx = modep->target_x;
+	mode.ty = modep->target_y;
+
+	scaler_disable(fb);
+	spin_lock(&fb->lock);
+
+	err = find_mode(fb, &mode);
+	if (err < 0) {
+		spin_unlock(&fb->lock);
+		scaler_enable(fb);
+		return err;
+	}
+
+	ctrl = scaler_r32(fb, SCALER_MODE);
+	if (ctrl & SCALER_MODE_RGB_888)
+		bpp = 24;
+	else
+		bpp = 16;
+
+	scaler_w32(fb, SCALER_UH, mode.uh);
+	scaler_w32(fb, SCALER_DH, mode.dh);
+	scaler_w32(fb, SCALER_UV, mode.uv);
+	scaler_w32(fb, SCALER_DV, mode.dv);
+
+	scaler_w32(fb, SCALER_OFFSET_X, 0);
+	scaler_w32(fb, SCALER_OFFSET_Y, 0);
+
+	scaler_w32(fb, SCALER_ORIGIN_X, mode.ox);
+	scaler_w32(fb, SCALER_ORIGIN_Y, mode.oy);
+	scaler_w32(fb, SCALER_TARGET_X, mode.tx);
+	scaler_w32(fb, SCALER_TARGET_Y, mode.ty);
+
+	scaler_w32(fb, SCALER_ORIGIN_STRIDE, mode.ox * (bpp / 8));
+	scaler_w32(fb, SCALER_TARGET_STRIDE, mode.tx * (bpp / 8));
+
+	scaler_w32(fb, SCALER_ORIGIN_SIZE, mode.ox * mode.oy * (bpp / 8));
+	scaler_w32(fb, SCALER_TARGET_SIZE, mode.tx * mode.ty * (bpp / 8));
+
+	spin_unlock(&fb->lock);
+	scaler_enable(fb);
+	return 0;
+}
+
+/**
+ * adxfb_scaler_mode() - obtain the current scaler mode
+ * @info:	framebuffer context
+ * @modep:	structure to return the mode in
+ */
+int adxfb_scaler_get_mode(struct fb_info *info, struct adxfb_scaler_mode *modep)
+{
+	struct adxfb_info *fb = info->par;
+
+	spin_lock(&fb->lock);
+
+	modep->origin_x = scaler_r32(fb, SCALER_ORIGIN_X) & 0x7ff;
+	modep->origin_y = scaler_r32(fb, SCALER_ORIGIN_Y) & 0x7ff;
+	modep->target_x = scaler_r32(fb, SCALER_TARGET_X) & 0x7ff;
+	modep->target_y = scaler_r32(fb, SCALER_TARGET_Y) & 0x7ff;
+
+	spin_unlock(&fb->lock);
+	return 0;
+}
diff --git a/include/video/Kbuild b/include/video/Kbuild
index 0e406f7..72fc9b0 100644
--- a/include/video/Kbuild
+++ b/include/video/Kbuild
@@ -1,2 +1,3 @@
 unifdef-y += sisfb.h uvesafb.h
 unifdef-y += edid.h
+unifdef-y += adxfb.h
diff --git a/include/video/adxfb.h b/include/video/adxfb.h
new file mode 100644
index 0000000..e7ef6d0
--- /dev/null
+++ b/include/video/adxfb.h
@@ -0,0 +1,128 @@
+/*
+ * linux/include/video/adxfb.h
+ *
+ * Copyright (C) 2007-2008 Avionic Design Development GmbH
+ * Copyright (C) 2008-2009 Avionic Design GmbH
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ * Written by Thierry Reding <thierry.reding@avionic-design.de>
+ */
+
+#ifndef _VIDEO_ADXFB_H
+#define _VIDEO_ADXFB_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#ifdef __KERNEL__
+/* overlay control register */
+#define ADXFB_OVERLAY_CONTROL			0x008
+#define ADXFB_OVERLAY_CONTROL_OVERLAY_ENABLE	(1 << 0)
+#define ADXFB_OVERLAY_CONTROL_ALPHA_ENABLE	(1 << 1)
+
+#define ADXFB_PAGE0_BASE			0x080
+
+/* color correction (brightness) register */
+#define ADXFB_COLOR_BRIGHTNESS			0x100
+#define ADXFB_COLOR_BRIGHTNESS_MIN		0x00
+#define ADXFB_COLOR_BRIGHTNESS_MAX		0x7f
+
+/* color correction (contrast) register */
+#define ADXFB_COLOR_CONTRAST			0x108
+#define ADXFB_COLOR_CONTRAST_MIN		0x48
+#define ADXFB_COLOR_CONTRAST_MAX		0x7f
+
+/**
+ * struct adxfb_mode_info - video mode information structure
+ * @xres:	horizontal resolution
+ * @yres:	vertical resolution
+ * @bpp:	pixel depth
+ * @red:	packing for red color component
+ * @green:	packing for green color component
+ * @blue:	packing for blue color component
+ */
+struct adxfb_mode_info {
+	/* mode resolution */
+	u_short xres;
+	u_short yres;
+	u_short bpp;
+
+	/* color packing specification */
+	struct fb_bitfield red;
+	struct fb_bitfield green;
+	struct fb_bitfield blue;
+};
+
+/**
+ * struct adxfb_mach_info - machine-specific information structure
+ * @ioctl:	machine-specific I/O control handler
+ */
+struct adxfb_mach_info {
+	int (*ioctl)(struct fb_info *info, unsigned int command,
+			unsigned long arg);
+};
+#endif /* __KERNEL__ */
+
+/**
+ * struct adxfb_scaler_mode - scaler mode definition structure
+ * @origin_x:	original horizontal resolution
+ * @origin_y:	original vertical resolution
+ * @target_x:	targetted horizontal resolution
+ * @target_y:	targetted vertical resolution
+ */
+struct adxfb_scaler_mode {
+	/* original resolution */
+	__u16 origin_x;
+	__u16 origin_y;
+	/* target resolution */
+	__u16 target_x;
+	__u16 target_y;
+};
+
+/**
+ * struct adxfb_viewport - overlay viewport structure
+ * @x:		horizontal start position of the overlay window
+ * @y:		vertical start position of the overlay window
+ * @width:	width of the overlay window
+ * @height:	height of the overlay window
+ */
+struct adxfb_viewport {
+	/* viewport position */
+	__u16 x;
+	__u16 y;
+	/* viewport resolution */
+	__u16 width;
+	__u16 height;
+};
+
+/* I/O control codes */
+#define ADXFB_IOC_MAGIC 'a'
+
+/* set a new scaler mode */
+#define ADXFB_IOCTL_SCALER_SET_MODE \
+			_IOW(ADXFB_IOC_MAGIC, 0, struct adxfb_scaler_mode)
+/* obtain the current scaler mode */
+#define ADXFB_IOCTL_SCALER_GET_MODE \
+			_IOR(ADXFB_IOC_MAGIC, 1, struct adxfb_scaler_mode)
+/* enable/disable the overlay window */
+#define ADXFB_IOCTL_OVERLAY_ENABLE \
+			_IOW(ADXFB_IOC_MAGIC, 2, unsigned long)
+/* set a new region for the overlay window */
+#define ADXFB_IOCTL_OVERLAY_SET_VIEWPORT \
+			_IOW(ADXFB_IOC_MAGIC, 3, struct adxfb_viewport)
+/* set a new input video standard */
+#define ADXFB_IOCTL_SET_INPUT \
+			_IOW(ADXFB_IOC_MAGIC, 4, unsigned long)
+
+/* ADXFB_IOCTL_OVERLAY_ENABLE flags */
+#define ADXFB_OVERLAY_ENABLE	(1 << 0)	/* enable/disable overlay */
+
+/* ADXFB_IOCTL_SET_INPUT parameters */
+#define ADXFB_INPUT_PAL		(0x00)		/* input is PAL standard */
+#define ADXFB_INPUT_NTSC	(0x01)		/* input is NTSC stardard */
+#define ADXFB_INPUT_MASK	(0xff)		/* mask to extract input */
+
+#endif /* !_VIDEO_ADXFB_H */
-- 
1.6.3.1


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
