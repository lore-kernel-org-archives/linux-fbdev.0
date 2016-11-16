From: "Ong, Hean Loong" <hean.loong.ong@intel.com>
Date: Wed, 16 Nov 2016 09:07:58 +0000
Subject: [PATCHv0 1/1] fbdev: add Intel FPGA FRAME BUFFER driver
Message-Id: <1479287278-5192-1-git-send-email-hean.loong.ong@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Ong Hean Loong <hean.loong.ong@intel.com>

From: Ong Hean Loong <hean.loong.ong@intel.com>

	This patch enables the display port IP driver for
	Intel Arria 10 SOCFPGA Golden Hardware
	Reference Design (GHRD).

	The driver requires enabling the options such as
	Coheherent Memory Allocation,
	Intel FPGA Frame Buffer, Frame Buffer Conasole

Signed-off-by: Ong Hean Loong <hean.loong.ong@intel.com>
---
 .../devicetree/bindings/video/intelfpgavipfb.txt   |   22 ++
 MAINTAINERS                                        |    6 +
 drivers/video/fbdev/Kconfig                        |   15 +
 drivers/video/fbdev/Makefile                       |    1 +
 drivers/video/fbdev/intelfpgavipfb.c               |  302 ++++++++++++++++++++
 5 files changed, 346 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/intelfpgavipfb.txt
 create mode 100644 drivers/video/fbdev/intelfpgavipfb.c

diff --git a/Documentation/devicetree/bindings/video/intelfpgavipfb.txt b/Documentation/devicetree/bindings/video/intelfpgavipfb.txt
new file mode 100644
index 0000000..8928c99
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/intelfpgavipfb.txt
@@ -0,0 +1,22 @@
+Intel FPGA Video and Image Processing(VIP) Frame Buffer bindings
+
+Required properties:
+- compatible: "intel,vip-frame-buffer2"
+- reg: Physical base address and length of the framebuffer controller's
+  registers.
+- max-width: The width of the framebuffer in pixels.
+- max-height: The height of the framebuffer in pixels.
+- bits-per-color: only "8" is currently supported
+- mem-word-width = the bus width of the avalon master port on the frame reader
+
+Example:
+
+alt_vip_vfr_0: vip@0xff260000 {
+	compatible = "intel,vip-frame-buffer2";
+	reg = <0xff260000 0x00000080>;
+	max-width = <1024>;
+	max-height = <768>;
+	bits-per-color = <8>;
+	mem-word-width = <128>;
+};
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 4012c2f..bfc2687 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6314,6 +6314,12 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/i810/
 
+INTEL FPGA FRAMEBUFFER DRIVER
+M:	Ong, Hean Loong <hean.loong.ong@intel.com>
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+F:	drivers/video/fbdev/intvipfb.c
+
 INTEL MENLOW THERMAL DRIVER
 M:	Sujith Thomas <sujith.thomas@intel.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 5d3b0db..5c9d674 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -228,6 +228,21 @@ config FB_TILEBLITTING
 comment "Frame buffer hardware drivers"
 	depends on FB
 
+config FB_INTEL_FPGA_VIP
+       	tristate "Intel FPGA VIP framebuffer support"
+	depends on FB
+       	select CMA
+       	select FB_CFB_FILLRECT
+       	select FB_CFB_COPYAREA
+       	select FB_CFB_IMAGEBLIT
+       	select FRAMEBUFFER_CONSOLE
+	select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if  FRAMEBUFFER_CONSOLE
+	---help---
+	The FB_INTEL_FPGA_VIP driver supports the formerly Altera Video and Image Processing(VIP)
+	Frame Buffer II. Requires CONFIG_CMA and Frame Buffer Console to
+	be enabled as well. The driver currently only supports ARRIA 10 board from the Intel
+	FPGA Reference Design board family.
+
 config FB_GRVGA
 	tristate "Aeroflex Gaisler framebuffer support"
 	depends on FB && SPARC
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index ee8c814..6c30549 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_FB_MACMODES)      += macmodes.o
 obj-$(CONFIG_FB_WMT_GE_ROPS)   += wmt_ge_rops.o
 
 # Hardware specific drivers go first
+obj-$(CONFIG_FB_INTEL_FPGA_VIP)   += intelfpgavipfb.o
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p_planar.o
 obj-$(CONFIG_FB_ARC)              += arcfb.o
 obj-$(CONFIG_FB_CLPS711X)	  += clps711x-fb.o
diff --git a/drivers/video/fbdev/intelfpgavipfb.c b/drivers/video/fbdev/intelfpgavipfb.c
new file mode 100644
index 0000000..9f5ca26
--- /dev/null
+++ b/drivers/video/fbdev/intelfpgavipfb.c
@@ -0,0 +1,302 @@
+/*
+ * Copyright (C) 2016 Intel Corporation. All rights reserved
+ *
+ * intelfpgavipfb.c -- Intel Video and Image Processing(VIP)
+ * Frame Buffer II driver
+ *
+ * This is based on a driver made by Thomas Chou <thomas@wytron.com.tw> and
+ * Winteler Goossens <wintelergoossens@home.nl> This driver supports the
+ * Intel VIP Frame Buffer II component.  More info on the hardware can be
+ * found in the Intel Video and Image Processing Suite User Guide at
+ * http://www.intelera.com/literature/ug/ug_vip.pdf.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define PALETTE_SIZE	256
+#define DRIVER_NAME	"intelvipfb"
+
+/* control registers */
+#define INTVIPFB2_CONTROL			0
+#define INTVIPFB2_STATUS			0x4
+#define INTVIPFB2_INTERRUPT			0x8
+#define INTVIPFB2_FRAME_COUNTER		0xC
+#define INTVIPFB2_FRAME_DROP		0x10
+#define INTVIPFB2_FRAME_INFO		0x14
+#define INTVIPFB2_FRAME_START		0x18
+#define INTVIPFB2_FRAME_READER		0x1C
+
+#define BITS_PER_PIXEL		32
+
+struct intelvipfb_dev {
+	struct platform_device *pdev;
+	struct fb_info info;
+	struct resource *reg_res;
+	void __iomem *base;
+	int mem_word_width;
+	u32 pseudo_palette[PALETTE_SIZE];
+};
+
+static int intelvipfb_setcolreg(unsigned int regno, unsigned int red,
+				unsigned int green, unsigned int blue,
+				unsigned int transp, struct fb_info *info)
+{
+	/*
+	 *  Set a single color register. The values supplied have a 32 bit
+	 *  magnitude.
+	 *  Return != 0 for invalid regno.
+	 */
+
+	if (regno > 255)
+		return 1;
+
+	red >>= 8;
+	green >>= 8;
+	blue >>= 8;
+	if (regno < 255) {
+		((u32 *)info->pseudo_palette)[regno] +		((red & 255) << 16) | ((green & 255) << 8) | (blue & 255);
+	}
+
+	return 0;
+}
+
+static struct fb_ops intelvipfb_ops = {
+	.owner = THIS_MODULE,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+	.fb_setcolreg = intelvipfb_setcolreg,
+};
+
+static int intelvipfb_of_setup(struct intelvipfb_dev *fbdev)
+{
+	struct device_node *np = fbdev->pdev->dev.of_node;
+	int ret;
+	u32 bits_per_color;
+
+	ret = of_property_read_u32(np, "max-width", &fbdev->info.var.xres);
+	if (ret) {
+		dev_err(&fbdev->pdev->dev,
+			"Missing required parameter 'max-width'");
+		return ret;
+	}
+	fbdev->info.var.xres_virtual = fbdev->info.var.xres,
+
+	ret = of_property_read_u32(np, "max-height", &fbdev->info.var.yres);
+	if (ret) {
+		dev_err(&fbdev->pdev->dev,
+			"Missing required parameter 'max-height'");
+		return ret;
+	}
+	fbdev->info.var.yres_virtual = fbdev->info.var.yres;
+
+	ret = of_property_read_u32(np, "bits-per-color", &bits_per_color);
+	if (ret) {
+		dev_err(&fbdev->pdev->dev,
+			"Missing required parameter 'bits-per-color'");
+		return ret;
+	}
+	if (bits_per_color != 8) {
+		dev_err(&fbdev->pdev->dev,
+			"bits-per-color is set to %i.  Currently only 8 is supported.",
+			bits_per_color);
+		return -ENODEV;
+	}
+	fbdev->info.var.bits_per_pixel = BITS_PER_PIXEL;
+
+	ret = of_property_read_u32(np, "mem-word-width",
+				   &fbdev->mem_word_width);
+	if (ret) {
+		dev_err(&fbdev->pdev->dev,
+			"Missing required parameter 'mem-word-width'");
+		return ret;
+	}
+	if (!(fbdev->mem_word_width >= BITS_PER_PIXEL &&
+	      fbdev->mem_word_width % BITS_PER_PIXEL = 0)) {
+		dev_err(&fbdev->pdev->dev,
+			"mem-word-width is set to %i.  must be >= 32 and multiple of 32.",
+			fbdev->mem_word_width);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void intelvipfb_start_hw(struct intelvipfb_dev *fbdev)
+{
+	/*
+	 * The frameinfo variable has to correspond to the size of the VIP Suite
+	 * Frame Reader register 7 which will determine the maximum size used
+	 * in this frameinfo
+	 */
+	u32 frameinfo = readl(fbdev->base +
+				INTVIPFB2_FRAME_READER) & 0x00ffffff;
+
+	writel(frameinfo, fbdev->base + INTVIPFB2_FRAME_INFO);
+	writel(fbdev->info.fix.smem_start, fbdev->base + INTVIPFB2_FRAME_START);
+	/* Finally set the control register to 1 to start streaming */
+	writel(1, fbdev->base + INTVIPFB2_CONTROL);
+}
+
+static void intelvipfb_disable_hw(struct intelvipfb_dev *fbdev)
+{
+	/* set the control register to 0 to stop streaming */
+	writel(0, fbdev->base + INTVIPFB2_CONTROL);
+}
+
+static int intelvipfb_setup_fb_info(struct intelvipfb_dev *fbdev)
+{
+	struct fb_info *info = &fbdev->info;
+	int ret;
+
+	strcpy(info->fix.id, DRIVER_NAME);
+	info->fix.type = FB_TYPE_PACKED_PIXELS;
+	info->fix.visual = FB_VISUAL_TRUECOLOR;
+	info->fix.accel = FB_ACCEL_NONE;
+
+	info->fbops = &intelvipfb_ops;
+	info->var.activate = FB_ACTIVATE_NOW;
+	info->var.height = -1;
+	info->var.width = -1;
+	info->var.vmode = FB_VMODE_NONINTERLACED;
+
+	ret = intelvipfb_of_setup(fbdev);
+	if (ret)
+		return ret;
+
+	/* settings for 32bit pixels */
+	info->var.red.offset = 16;
+	info->var.red.length = 8;
+	info->var.red.msb_right = 0;
+	info->var.green.offset = 8;
+	info->var.green.length = 8;
+	info->var.green.msb_right = 0;
+	info->var.blue.offset = 0;
+	info->var.blue.length = 8;
+	info->var.blue.msb_right = 0;
+
+	info->fix.line_length = (info->var.xres *
+		(info->var.bits_per_pixel >> 3));
+	info->fix.smem_len = info->fix.line_length * info->var.yres;
+
+	info->pseudo_palette = fbdev->pseudo_palette;
+	info->flags = FBINFO_FLAG_DEFAULT;
+
+	return 0;
+}
+
+static int intelvipfb_probe(struct platform_device *pdev)
+{
+	int retval;
+	void *fbmem_virt;
+	struct intelvipfb_dev *fbdev;
+
+	fbdev = devm_kzalloc(&pdev->dev, sizeof(*fbdev), GFP_KERNEL);
+	if (!fbdev)
+		return -ENOMEM;
+
+	fbdev->pdev = pdev;
+	fbdev->reg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!fbdev->reg_res)
+		return -ENODEV;
+
+	fbdev->base = devm_ioremap_resource(&pdev->dev, fbdev->reg_res);
+	if (IS_ERR(fbdev->base)) {
+		dev_err(&pdev->dev, "devm_ioremap_resource failed\n");
+		retval = PTR_ERR(fbdev->base);
+		return -ENODEV;
+	}
+
+	retval = intelvipfb_setup_fb_info(fbdev);
+
+	fbmem_virt = dma_alloc_coherent(NULL,
+					fbdev->info.fix.smem_len,
+					(void *)&fbdev->info.fix.smem_start,
+					GFP_KERNEL);
+	if (!fbmem_virt) {
+		dev_err(&pdev->dev,
+			"intelvipfb: unable to allocate %d Bytes fb memory\n",
+			fbdev->info.fix.smem_len);
+		return retval;
+	}
+
+	fbdev->info.screen_base = fbmem_virt;
+
+	retval = fb_alloc_cmap(&fbdev->info.cmap, PALETTE_SIZE, 0);
+	if (retval < 0)
+		goto err_dma_free;
+
+	platform_set_drvdata(pdev, fbdev);
+
+	intelvipfb_start_hw(fbdev);
+
+	retval = register_framebuffer(&fbdev->info);
+	if (retval < 0)
+		goto err_dealloc_cmap;
+
+	dev_info(&pdev->dev, "fb%d: %s frame buffer device at 0x%x+0x%x\n",
+		 fbdev->info.node, fbdev->info.fix.id,
+		 (unsigned int)fbdev->info.fix.smem_start,
+		 fbdev->info.fix.smem_len);
+
+	return 0;
+
+err_dealloc_cmap:
+	fb_dealloc_cmap(&fbdev->info.cmap);
+err_dma_free:
+	dma_free_coherent(NULL, fbdev->info.fix.smem_len, fbmem_virt,
+			  fbdev->info.fix.smem_start);
+	return retval;
+}
+
+static int intelvipfb_remove(struct platform_device *dev)
+{
+	struct intelvipfb_dev *fbdev = platform_get_drvdata(dev);
+
+	if (fbdev) {
+		unregister_framebuffer(&fbdev->info);
+		fb_dealloc_cmap(&fbdev->info.cmap);
+		dma_free_coherent(NULL, fbdev->info.fix.smem_len,
+				  fbdev->info.screen_base,
+				  fbdev->info.fix.smem_start);
+		intelvipfb_disable_hw(fbdev);
+	}
+	return 0;
+}
+
+static const struct of_device_id intelvipfb_match[] = {
+	{ .compatible = "intel,vip-frame-buffer2" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, intelvipfb_match);
+
+static struct platform_driver intelvipfb_driver = {
+	.probe = intelvipfb_probe,
+	.remove = intelvipfb_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = intelvipfb_match,
+	},
+};
+module_platform_driver(intelvipfb_driver);
+
+MODULE_DESCRIPTION("Intel VIP Frame Buffer II driver");
+MODULE_AUTHOR("Chris Rauer <christopher.rauer@intel.com>");
+MODULE_LICENSE("GPL v2");
+
-- 
1.7.1


