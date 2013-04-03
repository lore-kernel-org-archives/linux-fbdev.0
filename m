From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 03 Apr 2013 06:17:10 +0000
Subject: [PATCH] video: implement a dumb framebuffer driver
Message-Id: <1364969830-6481-1-git-send-email-swarren@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

A dumb frame-buffer describes a raw memory region that may be rendered
to, with the assumption that the display hardware has already been set
up to scan out from that buffer.

This is useful in cases where a bootloader exists and has set up the
display hardware, but a Linux driver doesn't yet exist for the display
hardware.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
Should this be merged through akpm's tree (I think many fb drivers are
these days), or if not, I could take it through the bcm2835 tree.

I ended up going with a separate FB driver:
* DRM/KMS look much more complex, and don't provide any benefit that I can
  tell for this simple driver.
* Creating a separate driver rather than adjusting offb.c to work allows a
  new clean binding to be defined, and doesn't require removing or ifdefing
  PPC-isms in offb.c.

 .../devicetree/bindings/video/dumb-framebuffer.txt |   25 +++
 drivers/video/Kconfig                              |   17 ++
 drivers/video/Makefile                             |    1 +
 drivers/video/dumbfb.c                             |  234 ++++++++++++++++++++
 4 files changed, 277 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/dumb-framebuffer.txt
 create mode 100644 drivers/video/dumbfb.c

diff --git a/Documentation/devicetree/bindings/video/dumb-framebuffer.txt b/Documentation/devicetree/bindings/video/dumb-framebuffer.txt
new file mode 100644
index 0000000..ba6676b
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/dumb-framebuffer.txt
@@ -0,0 +1,25 @@
+Dumb Framebuffer
+
+A dumb frame-buffer describes a raw memory region that may be rendered to,
+with the assumption that the display hardware has already been set up to scan
+out from that buffer.
+
+Required properties:
+- compatible: "dumb-framebuffer"
+- reg: Should contain the location and size of the framebuffer memory.
+- width: The width of the framebuffer in pixels.
+- height: The height of the framebuffer in pixels.
+- stride: The number of bytes in each line of the framebuffer.
+- format: The format of the framebuffer surface. Valid values are:
+  r5g6b5: A 16bpp format.
+
+Example:
+
+	framebuffer {
+		compatible = "dumb-framebuffer";
+		reg = <0x1d385000 (1600 * 1200 * 2)>;
+		width = <1600>;
+		height = <1200>;
+		stride = <(1600 * 2)>;
+		format = "r5g6b5";
+	};
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4c1546f..0ebc143 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2451,6 +2451,23 @@ config FB_PUV3_UNIGFX
 	  Choose this option if you want to use the Unigfx device as a
 	  framebuffer device. Without the support of PCI & AGP.
 
+config FB_DUMB
+	bool "Dumb framebuffer support"
+	depends on (FB = y) && OF
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  Say Y if you want support for a dumb frame-buffer.
+
+	  This driver assumes that the display hardware has been initialized
+	  before the kernel boots, and the kernel will simply render to the
+	  pre-allocated frame buffer surface.
+
+	  Configuration re: surface address, size, and format must be provided
+	  through device tree, or potentially plain old platform data in the
+	  future.
+
 source "drivers/video/omap/Kconfig"
 source "drivers/video/omap2/Kconfig"
 source "drivers/video/exynos/Kconfig"
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9df3873..c8facd4 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -165,6 +165,7 @@ obj-$(CONFIG_FB_MX3)		  += mx3fb.o
 obj-$(CONFIG_FB_DA8XX)		  += da8xx-fb.o
 obj-$(CONFIG_FB_MXS)		  += mxsfb.o
 obj-$(CONFIG_FB_SSD1307)	  += ssd1307fb.o
+obj-$(CONFIG_FB_DUMB)             += dumbfb.o
 
 # the test framebuffer is last
 obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
diff --git a/drivers/video/dumbfb.c b/drivers/video/dumbfb.c
new file mode 100644
index 0000000..96afffb
--- /dev/null
+++ b/drivers/video/dumbfb.c
@@ -0,0 +1,234 @@
+/*
+ * Simplest possible dumb frame-buffer driver, as a platform device
+ *
+ * Copyright (c) 2013, Stephen Warren
+ *
+ * Based on q40fb.c, which was:
+ * Copyright (C) 2001 Richard Zidlicky <rz@linux-m68k.org>
+ *
+ * Also based on offb.c, which was:
+ * Copyright (C) 1997 Geert Uytterhoeven
+ * Copyright (C) 1996 Paul Mackerras
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+static struct fb_fix_screeninfo dumbfb_fix = {
+	.id		= "dumb",
+	.type		= FB_TYPE_PACKED_PIXELS,
+	.visual		= FB_VISUAL_TRUECOLOR,
+	.accel		= FB_ACCEL_NONE,
+};
+
+static struct fb_var_screeninfo dumbfb_var = {
+	.height		= -1,
+	.width		= -1,
+	.activate	= FB_ACTIVATE_NOW,
+	.vmode		= FB_VMODE_NONINTERLACED,
+};
+
+static int dumbfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+			    u_int transp, struct fb_info *info)
+{
+	u32 *pal = info->pseudo_palette;
+	u32 cr = red >> (16 - info->var.red.length);
+	u32 cg = green >> (16 - info->var.green.length);
+	u32 cb = blue >> (16 - info->var.blue.length);
+	u32 value;
+
+	if (regno >= 16)
+		return -EINVAL;
+
+	value = (cr << info->var.red.offset) |
+		(cg << info->var.green.offset) |
+		(cb << info->var.blue.offset);
+	if (info->var.transp.length > 0) {
+		u32 mask = (1 << info->var.transp.length) - 1;
+		mask <<= info->var.transp.offset;
+		value |= mask;
+	}
+	pal[regno] = value;
+
+	return 0;
+}
+
+static struct fb_ops dumbfb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_setcolreg	= dumbfb_setcolreg,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+};
+
+struct dumbfb_format {
+	const char *name;
+	u32 bits_per_pixel;
+	struct fb_bitfield red;
+	struct fb_bitfield green;
+	struct fb_bitfield blue;
+	struct fb_bitfield transp;
+};
+
+struct dumbfb_format dumbfb_formats[] = {
+	{ "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0} },
+};
+
+struct dumbfb_params {
+	u32 width;
+	u32 height;
+	u32 stride;
+	struct dumbfb_format *format;
+};
+
+static int dumbfb_parse_dt(struct platform_device *pdev,
+			   struct dumbfb_params *params)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+	const char *format;
+	int i;
+
+	ret = of_property_read_u32(np, "width", &params->width);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't parse width property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "height", &params->height);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't parse height property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "stride", &params->stride);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't parse stride property\n");
+		return ret;
+	}
+
+	ret = of_property_read_string(np, "format", &format);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't parse format property\n");
+		return ret;
+	}
+	params->format = NULL;
+	for (i = 0; i < ARRAY_SIZE(dumbfb_formats); i++) {
+		if (strcmp(format, dumbfb_formats[i].name))
+			continue;
+		params->format = &dumbfb_formats[i];
+		break;
+	}
+	if (!params->format) {
+		dev_err(&pdev->dev, "Invalid format value\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dumbfb_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct dumbfb_params params;
+	struct fb_info *info;
+	struct resource *mem;
+
+	if (fb_get_options("dumbfb", NULL))
+		return -ENODEV;
+
+	ret = dumbfb_parse_dt(pdev, &params);
+	if (ret)
+		return ret;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "No memory resource\n");
+		return -EINVAL;
+	}
+
+	info = framebuffer_alloc(sizeof(u32) * 16, &pdev->dev);
+	if (!info)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, info);
+
+	info->fix = dumbfb_fix;
+	info->fix.smem_start = mem->start;
+	info->fix.smem_len = resource_size(mem);
+	info->fix.line_length = params.stride;
+
+	info->var = dumbfb_var;
+	info->var.xres = params.width;
+	info->var.yres = params.height;
+	info->var.xres_virtual = params.width;
+	info->var.yres_virtual = params.height;
+	info->var.bits_per_pixel = params.format->bits_per_pixel;
+	info->var.red = params.format->red;
+	info->var.green = params.format->green;
+	info->var.blue = params.format->blue;
+	info->var.transp = params.format->transp;
+
+	info->fbops = &dumbfb_ops;
+	info->flags = FBINFO_DEFAULT;
+	info->screen_base = devm_ioremap(&pdev->dev, info->fix.smem_start,
+					 info->fix.smem_len);
+	if (!info->screen_base) {
+		framebuffer_release(info);
+		return -ENODEV;
+	}
+	info->pseudo_palette = (void *)(info + 1);
+
+	ret = register_framebuffer(info);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to register dumbfb: %d\n", ret);
+		framebuffer_release(info);
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "fb%d: dumbfb registered!\n", info->node);
+
+	return 0;
+}
+
+static int dumbfb_remove(struct platform_device *pdev)
+{
+	struct fb_info *info = platform_get_drvdata(pdev);
+
+	unregister_framebuffer(info);
+	framebuffer_release(info);
+
+	return 0;
+}
+
+static const struct of_device_id dumbfb_of_match[] = {
+	{ .compatible = "dumb-framebuffer", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, dumbfb_of_match);
+
+static struct platform_driver dumbfb_driver = {
+	.driver = {
+		.name = "dumb-framebuffer",
+		.owner = THIS_MODULE,
+		.of_match_table = dumbfb_of_match,
+	},
+	.probe = dumbfb_probe,
+	.remove = dumbfb_remove,
+};
+module_platform_driver(dumbfb_driver);
+
+MODULE_AUTHOR("Stephen Warren <swarren@wwwdotorg.org>");
+MODULE_DESCRIPTION("Dumb framebuffer driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.10.4

