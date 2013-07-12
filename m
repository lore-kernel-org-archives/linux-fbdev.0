From: Alison Wang <b18965@freescale.com>
Date: Fri, 12 Jul 2013 06:07:55 +0000
Subject: [PATCH 4/5] fb: Add DCU framebuffer driver for Vybrid VF610 platform
Message-Id: <1373609276-14566-5-git-send-email-b18965@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373609276-14566-1-git-send-email-b18965@freescale.com>
In-Reply-To: <1373609276-14566-1-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The Display Controller Unit (DCU) module is a system master that
fetches graphics stored in internal or external memory and displays
them on a TFT LCD panel. A wide range of panel sizes is supported
and the timing of the interface signals is highly configurable.
Graphics are read directly from memory and then blended in real-time,
which allows for dynamic content creation with minimal CPU intervention.

The features:

(1) Full RGB888 output to TFT LCD panel.
(2) For the current LCD panel, WQVGA "480x272" is tested.
(3) Blending of each pixel using up to 4 source layers dependent on size of panel.
(4) Each graphic layer can be placed with one pixel resolution in either axis.
(5) Each graphic layer support RGB565 and RGB888 direct colors without alpha channel
and BGRA8888 direct colors with an alpha channel.
(6) Each graphic layer support alpha blending with 8-bit resolution.

This driver has been tested on Vybrid VF610 TOWER board.

Signed-off-by: Alison Wang <b18965@freescale.com>
---
Changes in v2: None

 drivers/video/Kconfig      |    9 +
 drivers/video/Makefile     |    1 +
 drivers/video/fsl-dcu-fb.c | 1091 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1101 insertions(+)
 create mode 100644 drivers/video/fsl-dcu-fb.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 46544d0..32dc1f8 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1978,6 +1978,15 @@ config FB_FSL_DIU
 	---help---
 	  Framebuffer driver for the Freescale SoC DIU
 
+config FB_FSL_DCU
+	tristate "Freescale DCU framebuffer support"
+	depends on FB
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	---help---
+	  Framebuffer driver for the Freescale SoC DCU
+
 config FB_W100
 	tristate "W100 frame buffer support"
 	depends on FB && ARCH_PXA
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index e8bae8d..3707a7d 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -129,6 +129,7 @@ obj-$(CONFIG_FB_IMX)              += imxfb.o
 obj-$(CONFIG_FB_S3C)		  += s3c-fb.o
 obj-$(CONFIG_FB_S3C2410)	  += s3c2410fb.o
 obj-$(CONFIG_FB_FSL_DIU)	  += fsl-diu-fb.o
+obj-$(CONFIG_FB_FSL_DCU)	  += fsl-dcu-fb.o
 obj-$(CONFIG_FB_COBALT)           += cobalt_lcdfb.o
 obj-$(CONFIG_FB_IBM_GXT4500)	  += gxt4500.o
 obj-$(CONFIG_FB_PS3)		  += ps3fb.o
diff --git a/drivers/video/fsl-dcu-fb.c b/drivers/video/fsl-dcu-fb.c
new file mode 100644
index 0000000..5571dde
--- /dev/null
+++ b/drivers/video/fsl-dcu-fb.c
@@ -0,0 +1,1091 @@
+/*
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *
+ * Freescale DCU Frame Buffer device driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/fb.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/uaccess.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+
+#define DRIVER_NAME			"fsl-dcu-fb"
+
+#define DCU_DCU_MODE			0x0010
+#define DCU_MODE_BLEND_ITER(x)		(x << 20)
+#define DCU_MODE_RASTER_EN		(1 << 14)
+#define DCU_MODE_DCU_MODE(x)		(x)
+#define DCU_MODE_DCU_MODE_MASK		0x03
+#define DCU_MODE_OFF			0
+#define DCU_MODE_NORMAL			1
+#define DCU_MODE_TEST			2
+#define DCU_MODE_COLORBAR		3
+
+#define DCU_BGND			0x0014
+#define DCU_BGND_R(x)			(x << 16)
+#define DCU_BGND_G(x)			(x << 8)
+#define DCU_BGND_B(x)			(x)
+
+#define DCU_DISP_SIZE			0x0018
+#define DCU_DISP_SIZE_DELTA_Y(x)	(x << 16)
+#define DCU_DISP_SIZE_DELTA_X(x)	(x)
+
+#define DCU_HSYN_PARA			0x001c
+#define DCU_HSYN_PARA_BP(x)		(x << 22)
+#define DCU_HSYN_PARA_PW(x)		(x << 11)
+#define DCU_HSYN_PARA_FP(x)		(x)
+
+#define DCU_VSYN_PARA			0x0020
+#define DCU_VSYN_PARA_BP(x)		(x << 22)
+#define DCU_VSYN_PARA_PW(x)		(x << 11)
+#define DCU_VSYN_PARA_FP(x)		(x)
+
+#define DCU_SYN_POL			0x0024
+#define DCU_SYN_POL_INV_PXCK_FALL	(0 << 6)
+#define DCU_SYN_POL_NEG_REMAIN		(0 << 5)
+#define DCU_SYN_POL_INV_VS_LOW		(1 << 1)
+#define DCU_SYN_POL_INV_HS_LOW		(1)
+
+#define DCU_THRESHOLD			0x0028
+#define DCU_THRESHOLD_LS_BF_VS(x)	(x << 16)
+#define DCU_THRESHOLD_OUT_BUF_HIGH(x)	(x << 8)
+#define DCU_THRESHOLD_OUT_BUF_LOW(x)	(x)
+
+#define DCU_INT_STATUS			0x002C
+#define DCU_INT_STATUS_UNDRUN		(1 << 1)
+
+#define DCU_INT_MASK			0x0030
+#define DCU_INT_MASK_UNDRUN		(1 << 1)
+
+#define DCU_DIV_RATIO			0x0054
+
+#define DCU_UPDATE_MODE			0x00cc
+#define DCU_UPDATE_MODE_MODE		(1 << 31)
+#define DCU_UPDATE_MODE_READREG		(1 << 30)
+
+#define DCU_CTRLDESCLN_1(x)		(0x200 + (x) * 0x40)
+#define DCU_CTRLDESCLN_1_HEIGHT(x)	(x << 16)
+#define DCU_CTRLDESCLN_1_WIDTH(x)	(x)
+
+#define DCU_CTRLDESCLN_2(x)		(0x204 + (x) * 0x40)
+#define DCU_CTRLDESCLN_2_POSY(x)	(x << 16)
+#define DCU_CTRLDESCLN_2_POSX(x)	(x)
+
+#define DCU_CTRLDESCLN_3(x)		(0x208 + (x) * 0x40)
+
+#define DCU_CTRLDESCLN_4(x)		(0x20c + (x) * 0x40)
+#define DCU_CTRLDESCLN_4_EN		(1 << 31)
+#define DCU_CTRLDESCLN_4_TILE_EN	(1 << 30)
+#define DCU_CTRLDESCLN_4_DATA_SEL_CLUT	(1 << 29)
+#define DCU_CTRLDESCLN_4_SAFETY_EN	(1 << 28)
+#define DCU_CTRLDESCLN_4_TRANS(x)	(x << 20)
+#define DCU_CTRLDESCLN_4_BPP(x)		(x << 16)
+#define DCU_CTRLDESCLN_4_RLE_EN		(1 << 15)
+#define DCU_CTRLDESCLN_4_LUOFFS(x)	(x << 4)
+#define DCU_CTRLDESCLN_4_BB_ON		(1 << 2)
+#define DCU_CTRLDESCLN_4_AB(x)		(x)
+
+#define DCU_CTRLDESCLN_5(x)		(0x210 + (x) * 0x40)
+#define DCU_CTRLDESCLN_5_CKMAX_R(x)	(x << 16)
+#define DCU_CTRLDESCLN_5_CKMAX_G(x)	(x << 8)
+#define DCU_CTRLDESCLN_5_CKMAX_B(x)	(x)
+
+#define DCU_CTRLDESCLN_6(x)		(0x214 + (x) * 0x40)
+#define DCU_CTRLDESCLN_6_CKMIN_R(x)	(x << 16)
+#define DCU_CTRLDESCLN_6_CKMIN_G(x)	(x << 8)
+#define DCU_CTRLDESCLN_6_CKMIN_B(x)	(x)
+
+#define DCU_CTRLDESCLN_7(x)		(0x218 + (x) * 0x40)
+#define DCU_CTRLDESCLN_7_TILE_VER(x)	(x << 16)
+#define DCU_CTRLDESCLN_7_TILE_HOR(x)	(x)
+
+#define DCU_CTRLDESCLN_8(x)		(0x21c + (x) * 0x40)
+#define DCU_CTRLDESCLN_8_FG_FCOLOR(x)	(x)
+
+#define DCU_CTRLDESCLN_9(x)		(0x220 + (x) * 0x40)
+#define DCU_CTRLDESCLN_9_BG_BCOLOR(x)	(x)
+
+#define DCU_TOTAL_LAYER_NUM		64
+#define DCU_LAYER_NUM_MAX		6
+#define DCU_LAYER_NUM			4
+
+#define BPP_16_RGB565			4
+#define BPP_24_RGB888			5
+#define BPP_32_ARGB8888			6
+
+#define TCON_CTRL1			0x0000
+#define TCON_BYPASS_ENABLE		(1 << 29)
+
+#define MFB_SET_ALPHA		_IOW('M', 0, __u8)
+#define MFB_GET_ALPHA		_IOR('M', 0, __u8)
+#define MFB_SET_LAYER		_IOW('M', 4, struct layer_display_offset)
+#define MFB_GET_LAYER		_IOR('M', 4, struct layer_display_offset)
+
+static char *fb_mode;
+static unsigned int default_bpp = 24;
+
+static struct fb_videomode dcu_mode_db[] = {
+	{
+		.name		= "480x272",
+		.refresh	= 75,
+		.xres		= 480,
+		.yres		= 272,
+		.pixclock	= 91996,
+		.left_margin	= 2,
+		.right_margin	= 2,
+		.upper_margin	= 1,
+		.lower_margin	= 1,
+		.hsync_len	= 41,
+		.vsync_len	= 2,
+		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+};
+
+/* DCU framebuffer data structure */
+struct dcu_fb_data {
+	struct fb_info *fsl_dcu_info[DCU_LAYER_NUM];
+	void __iomem *reg_base;
+	unsigned int irq;
+	struct clk *clk;
+};
+
+struct layer_display_offset {
+	int x_layer_d;
+	int y_layer_d;
+};
+
+struct mfb_info {
+	int index;
+	char *id;
+	unsigned long pseudo_palette[16];
+	unsigned char alpha;
+	unsigned char blend;
+	unsigned int count;
+	int x_layer_d;	/* layer display x offset to physical screen */
+	int y_layer_d;	/* layer display y offset to physical screen */
+	struct dcu_fb_data *parent;
+};
+
+enum mfb_index {
+	LAYER0 = 0,
+	LAYER1,
+	LAYER2,
+	LAYER3,
+};
+
+static struct mfb_info mfb_template[] = {
+	{
+	.index = LAYER0,
+	.id = "Layer0",
+	.alpha = 0xff,
+	.blend = 0,
+	.count = 0,
+	.x_layer_d = 0,
+	.y_layer_d = 0,
+	},
+	{
+	.index = LAYER1,
+	.id = "Layer1",
+	.alpha = 0xff,
+	.blend = 0,
+	.count = 0,
+	.x_layer_d = 50,
+	.y_layer_d = 50,
+	},
+	{
+	.index = LAYER2,
+	.id = "Layer2",
+	.alpha = 0xff,
+	.blend = 0,
+	.count = 0,
+	.x_layer_d = 100,
+	.y_layer_d = 100,
+	},
+	{
+	.index = LAYER3,
+	.id = "Layer3",
+	.alpha = 0xff,
+	.blend = 0,
+	.count = 0,
+	.x_layer_d = 150,
+	.y_layer_d = 150,
+	},
+};
+
+static int enable_panel(struct fb_info *info)
+{
+	struct fb_var_screeninfo *var = &info->var;
+	struct mfb_info *mfbi = info->par;
+	struct dcu_fb_data *dcufb = mfbi->parent;
+	unsigned int bpp;
+
+	writel(DCU_CTRLDESCLN_1_HEIGHT(var->yres) |
+		DCU_CTRLDESCLN_1_WIDTH(var->xres),
+		dcufb->reg_base + DCU_CTRLDESCLN_1(mfbi->index));
+	writel(DCU_CTRLDESCLN_2_POSY(mfbi->y_layer_d) |
+		DCU_CTRLDESCLN_2_POSX(mfbi->x_layer_d),
+		dcufb->reg_base + DCU_CTRLDESCLN_2(mfbi->index));
+
+	writel(info->fix.smem_start,
+		dcufb->reg_base + DCU_CTRLDESCLN_3(mfbi->index));
+
+	switch (var->bits_per_pixel) {
+	case 16:
+		bpp = BPP_16_RGB565;
+		break;
+	case 24:
+		bpp = BPP_24_RGB888;
+		break;
+	case 32:
+		bpp = BPP_32_ARGB8888;
+		break;
+	default:
+		printk(KERN_ERR "unsupported color depth: %u\n",
+			var->bits_per_pixel);
+		return -EINVAL;
+	}
+
+	writel(DCU_CTRLDESCLN_4_EN |
+		DCU_CTRLDESCLN_4_TRANS(mfbi->alpha) |
+		DCU_CTRLDESCLN_4_BPP(bpp) |
+		DCU_CTRLDESCLN_4_AB(mfbi->blend),
+		dcufb->reg_base + DCU_CTRLDESCLN_4(mfbi->index));
+
+	writel(DCU_CTRLDESCLN_5_CKMAX_R(0xff) |
+		DCU_CTRLDESCLN_5_CKMAX_G(0xff) |
+		DCU_CTRLDESCLN_5_CKMAX_B(0xff),
+		dcufb->reg_base + DCU_CTRLDESCLN_5(mfbi->index));
+	writel(DCU_CTRLDESCLN_6_CKMIN_R(0) |
+		DCU_CTRLDESCLN_6_CKMIN_G(0) |
+		DCU_CTRLDESCLN_6_CKMIN_B(0),
+		dcufb->reg_base + DCU_CTRLDESCLN_6(mfbi->index));
+
+	writel(DCU_CTRLDESCLN_7_TILE_VER(0) | DCU_CTRLDESCLN_7_TILE_HOR(0),
+		dcufb->reg_base + DCU_CTRLDESCLN_7(mfbi->index));
+
+	writel(DCU_CTRLDESCLN_8_FG_FCOLOR(0),
+		dcufb->reg_base + DCU_CTRLDESCLN_8(mfbi->index));
+	writel(DCU_CTRLDESCLN_9_BG_BCOLOR(0),
+		dcufb->reg_base + DCU_CTRLDESCLN_9(mfbi->index));
+
+	writel(DCU_UPDATE_MODE_READREG, dcufb->reg_base + DCU_UPDATE_MODE);
+	return 0;
+}
+
+static int disable_panel(struct fb_info *info)
+{
+	struct mfb_info *mfbi = info->par;
+	struct dcu_fb_data *dcufb = mfbi->parent;
+
+	writel(DCU_CTRLDESCLN_1_HEIGHT(0) |
+		DCU_CTRLDESCLN_1_WIDTH(0),
+		dcufb->reg_base + DCU_CTRLDESCLN_1(mfbi->index));
+	writel(DCU_CTRLDESCLN_2_POSY(0) | DCU_CTRLDESCLN_2_POSX(0),
+		dcufb->reg_base + DCU_CTRLDESCLN_2(mfbi->index));
+
+	writel(0, dcufb->reg_base + DCU_CTRLDESCLN_3(mfbi->index));
+	writel(0, dcufb->reg_base + DCU_CTRLDESCLN_4(mfbi->index));
+
+	writel(DCU_CTRLDESCLN_5_CKMAX_R(0) |
+		DCU_CTRLDESCLN_5_CKMAX_G(0) |
+		DCU_CTRLDESCLN_5_CKMAX_B(0),
+		dcufb->reg_base + DCU_CTRLDESCLN_5(mfbi->index));
+	writel(DCU_CTRLDESCLN_6_CKMIN_R(0) |
+		DCU_CTRLDESCLN_6_CKMIN_G(0) |
+		DCU_CTRLDESCLN_6_CKMIN_B(0),
+		dcufb->reg_base + DCU_CTRLDESCLN_6(mfbi->index));
+
+	writel(DCU_CTRLDESCLN_7_TILE_VER(0) | DCU_CTRLDESCLN_7_TILE_HOR(0),
+		dcufb->reg_base + DCU_CTRLDESCLN_7(mfbi->index));
+
+	writel(DCU_CTRLDESCLN_8_FG_FCOLOR(0),
+		dcufb->reg_base + DCU_CTRLDESCLN_8(mfbi->index));
+	writel(DCU_CTRLDESCLN_9_BG_BCOLOR(0),
+		dcufb->reg_base + DCU_CTRLDESCLN_9(mfbi->index));
+
+	writel(DCU_UPDATE_MODE_READREG, dcufb->reg_base + DCU_UPDATE_MODE);
+	return 0;
+}
+
+static void enable_controller(struct fb_info *info)
+{
+	struct mfb_info *mfbi = info->par;
+	struct dcu_fb_data *dcufb = mfbi->parent;
+	unsigned int dcu_mode;
+
+	dcu_mode = readl(dcufb->reg_base + DCU_DCU_MODE);
+	writel(dcu_mode | DCU_MODE_DCU_MODE(DCU_MODE_NORMAL),
+		dcufb->reg_base + DCU_DCU_MODE);
+}
+
+static void disable_controller(struct fb_info *info)
+{
+	struct mfb_info *mfbi = info->par;
+	struct dcu_fb_data *dcufb = mfbi->parent;
+
+	writel(DCU_MODE_DCU_MODE(DCU_MODE_OFF),
+		dcufb->reg_base + DCU_DCU_MODE);
+}
+
+static int fsl_dcu_check_var(struct fb_var_screeninfo *var,
+		struct fb_info *info)
+{
+	if (var->xres_virtual < var->xres)
+		var->xres_virtual = var->xres;
+	if (var->yres_virtual < var->yres)
+		var->yres_virtual = var->yres;
+
+	if (var->xoffset < 0)
+		var->xoffset = 0;
+
+	if (var->yoffset < 0)
+		var->yoffset = 0;
+
+	if (var->xoffset + info->var.xres > info->var.xres_virtual)
+		var->xoffset = info->var.xres_virtual - info->var.xres;
+
+	if (var->yoffset + info->var.yres > info->var.yres_virtual)
+		var->yoffset = info->var.yres_virtual - info->var.yres;
+
+	if ((var->bits_per_pixel != 32) && (var->bits_per_pixel != 24) &&
+	    (var->bits_per_pixel != 16))
+		var->bits_per_pixel = default_bpp;
+
+	switch (var->bits_per_pixel) {
+	case 16:
+		var->red.length = 5;
+		var->red.offset = 11;
+		var->red.msb_right = 0;
+
+		var->green.length = 6;
+		var->green.offset = 5;
+		var->green.msb_right = 0;
+
+		var->blue.length = 5;
+		var->blue.offset = 0;
+		var->blue.msb_right = 0;
+
+		var->transp.length = 0;
+		var->transp.offset = 0;
+		var->transp.msb_right = 0;
+		break;
+	case 24:
+		var->red.length = 8;
+		var->red.offset = 16;
+		var->red.msb_right = 0;
+
+		var->green.length = 8;
+		var->green.offset = 8;
+		var->green.msb_right = 0;
+
+		var->blue.length = 8;
+		var->blue.offset = 0;
+		var->blue.msb_right = 0;
+
+		var->transp.length = 0;
+		var->transp.offset = 0;
+		var->transp.msb_right = 0;
+		break;
+	case 32:
+		var->red.length = 8;
+		var->red.offset = 16;
+		var->red.msb_right = 0;
+
+		var->green.length = 8;
+		var->green.offset = 8;
+		var->green.msb_right = 0;
+
+		var->blue.length = 8;
+		var->blue.offset = 0;
+		var->blue.msb_right = 0;
+
+		var->transp.length = 8;
+		var->transp.offset = 24;
+		var->transp.msb_right = 0;
+		break;
+	default:
+		printk(KERN_ERR "unsupported color depth: %u\n",
+			var->bits_per_pixel);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int calc_div_ratio(struct fb_info *info)
+{
+	struct mfb_info *mfbi = info->par;
+	struct dcu_fb_data *dcufb = mfbi->parent;
+	unsigned long dcu_clk;
+	unsigned long long tmp;
+
+	dcu_clk = clk_get_rate(dcufb->clk);
+	tmp = info->var.pixclock * (unsigned long long)dcu_clk;
+
+	do_div(tmp, 1000000);
+
+	if (do_div(tmp, 1000000) > 500000)
+		tmp++;
+
+	tmp = tmp - 1;
+	return tmp;
+}
+
+static void update_controller(struct fb_info *info)
+{
+	struct fb_var_screeninfo *var = &info->var;
+	struct mfb_info *mfbi = info->par;
+	struct dcu_fb_data *dcufb = mfbi->parent;
+	unsigned int ratio;
+
+	ratio = calc_div_ratio(info);
+	writel(ratio, dcufb->reg_base + DCU_DIV_RATIO);
+
+	writel(DCU_DISP_SIZE_DELTA_Y(var->yres) |
+		DCU_DISP_SIZE_DELTA_X(var->xres / 16),
+		dcufb->reg_base + DCU_DISP_SIZE);
+
+	/* Horizontal and vertical sync parameter */
+	writel(DCU_HSYN_PARA_BP(var->left_margin) |
+		DCU_HSYN_PARA_PW(var->hsync_len) |
+		DCU_HSYN_PARA_FP(var->right_margin),
+		dcufb->reg_base + DCU_HSYN_PARA);
+
+	writel(DCU_VSYN_PARA_BP(var->upper_margin) |
+		DCU_VSYN_PARA_PW(var->vsync_len) |
+		DCU_VSYN_PARA_FP(var->lower_margin),
+		dcufb->reg_base + DCU_VSYN_PARA);
+
+	writel(DCU_SYN_POL_INV_PXCK_FALL | DCU_SYN_POL_NEG_REMAIN |
+		DCU_SYN_POL_INV_VS_LOW | DCU_SYN_POL_INV_HS_LOW,
+		dcufb->reg_base + DCU_SYN_POL);
+
+	writel(DCU_BGND_R(0) | DCU_BGND_G(0) | DCU_BGND_B(0),
+		dcufb->reg_base + DCU_BGND);
+
+	writel(DCU_MODE_BLEND_ITER(DCU_LAYER_NUM_MAX) | DCU_MODE_RASTER_EN,
+			dcufb->reg_base + DCU_DCU_MODE);
+
+	writel(DCU_THRESHOLD_LS_BF_VS(0x3) | DCU_THRESHOLD_OUT_BUF_HIGH(0x78) |
+		DCU_THRESHOLD_OUT_BUF_LOW(0), dcufb->reg_base + DCU_THRESHOLD);
+
+	enable_controller(info);
+}
+
+static int map_video_memory(struct fb_info *info)
+{
+	u32 smem_len = info->fix.line_length * info->var.yres_virtual;
+
+	info->fix.smem_len = smem_len;
+
+	info->screen_base = dma_alloc_coherent(info->device, info->fix.smem_len,
+		(dma_addr_t *)&info->fix.smem_start, GFP_KERNEL);
+	if (!info->screen_base) {
+		printk(KERN_ERR "unable to allocate fb memory\n");
+		return -ENOMEM;
+	}
+
+	memset(info->screen_base, 0, info->fix.smem_len);
+
+	return 0;
+}
+
+static void unmap_video_memory(struct fb_info *info)
+{
+	if (!info->screen_base)
+		return;
+
+	dma_free_coherent(info->device, info->fix.smem_len,
+		info->screen_base, info->fix.smem_start);
+
+	info->screen_base = NULL;
+	info->fix.smem_start = 0;
+	info->fix.smem_len = 0;
+}
+
+static int fsl_dcu_set_layer(struct fb_info *info)
+{
+	struct mfb_info *mfbi = info->par;
+	struct fb_var_screeninfo *var = &info->var;
+	struct dcu_fb_data *dcufb = mfbi->parent;
+	int pixel_offset;
+	unsigned long addr;
+
+	pixel_offset = (var->yoffset * var->xres_virtual) + var->xoffset;
+	addr = info->fix.smem_start +
+		(pixel_offset * (var->bits_per_pixel >> 3));
+
+	writel(addr, dcufb->reg_base + DCU_CTRLDESCLN_3(mfbi->index));
+	writel(DCU_UPDATE_MODE_READREG, dcufb->reg_base + DCU_UPDATE_MODE);
+
+	return 0;
+}
+
+static int fsl_dcu_set_par(struct fb_info *info)
+{
+	unsigned long len;
+	struct fb_var_screeninfo *var = &info->var;
+	struct fb_fix_screeninfo *fix = &info->fix;
+	struct mfb_info *mfbi = info->par;
+
+	fix->line_length = var->xres_virtual * var->bits_per_pixel / 8;
+	fix->type = FB_TYPE_PACKED_PIXELS;
+	fix->accel = FB_ACCEL_NONE;
+	fix->visual = FB_VISUAL_TRUECOLOR;
+	fix->xpanstep = 1;
+	fix->ypanstep = 1;
+
+	len = info->var.yres_virtual * info->fix.line_length;
+	if (len != info->fix.smem_len) {
+		if (info->fix.smem_start)
+			unmap_video_memory(info);
+
+		if (map_video_memory(info)) {
+			printk(KERN_ERR "unable to allocate fb memory\n");
+			return -ENOMEM;
+		}
+	}
+
+	/* Only layer 0 could update LCD controller */
+	if (mfbi->index = LAYER0)
+		update_controller(info);
+
+	enable_panel(info);
+	return 0;
+}
+
+static inline __u32 CNVT_TOHW(__u32 val, __u32 width)
+{
+	return ((val<<width) + 0x7FFF - val) >> 16;
+}
+
+static int fsl_dcu_setcolreg(unsigned regno, unsigned red, unsigned green,
+			   unsigned blue, unsigned transp, struct fb_info *info)
+{
+	unsigned int val;
+	int ret = -EINVAL;
+
+	/*
+	 * If greyscale is true, then we convert the RGB value
+	 * to greyscale no matter what visual we are using.
+	 */
+	if (info->var.grayscale)
+		red = green = blue = (19595 * red + 38470 * green +
+				      7471 * blue) >> 16;
+	switch (info->fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		/*
+		 * 16-bit True Colour.  We encode the RGB value
+		 * according to the RGB bitfield information.
+		 */
+		if (regno < 16) {
+			u32 *pal = info->pseudo_palette;
+
+			red = CNVT_TOHW(red, info->var.red.length);
+			green = CNVT_TOHW(green, info->var.green.length);
+			blue = CNVT_TOHW(blue, info->var.blue.length);
+			transp = CNVT_TOHW(transp, info->var.transp.length);
+
+			val = (red << info->var.red.offset) |
+			    (green << info->var.green.offset) |
+			    (blue << info->var.blue.offset) |
+			    (transp << info->var.transp.offset);
+
+			pal[regno] = val;
+			ret = 0;
+		}
+		break;
+	case FB_VISUAL_STATIC_PSEUDOCOLOR:
+	case FB_VISUAL_PSEUDOCOLOR:
+		break;
+	}
+
+	return ret;
+}
+
+static int fsl_dcu_pan_display(struct fb_var_screeninfo *var,
+			     struct fb_info *info)
+{
+	if ((info->var.xoffset = var->xoffset) &&
+	    (info->var.yoffset = var->yoffset))
+		return 0;
+
+	if (var->xoffset < 0 || var->yoffset < 0
+	    || var->xoffset + info->var.xres > info->var.xres_virtual
+	    || var->yoffset + info->var.yres > info->var.yres_virtual)
+		return -EINVAL;
+
+	info->var.xoffset = var->xoffset;
+	info->var.yoffset = var->yoffset;
+
+	if (var->vmode & FB_VMODE_YWRAP)
+		info->var.vmode |= FB_VMODE_YWRAP;
+	else
+		info->var.vmode &= ~FB_VMODE_YWRAP;
+
+	fsl_dcu_set_layer(info);
+
+	return 0;
+}
+
+static int fsl_dcu_blank(int blank_mode, struct fb_info *info)
+{
+	switch (blank_mode) {
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_NORMAL:
+		disable_panel(info);
+		break;
+	case FB_BLANK_POWERDOWN:
+		disable_controller(info);
+		break;
+	case FB_BLANK_UNBLANK:
+		enable_panel(info);
+		break;
+	}
+
+	return 0;
+}
+
+static int fsl_dcu_ioctl(struct fb_info *info, unsigned int cmd,
+		unsigned long arg)
+{
+	struct mfb_info *mfbi = info->par;
+	struct layer_display_offset layer_d;
+	void __user *buf = (void __user *)arg;
+	unsigned char alpha;
+
+	switch (cmd) {
+	case MFB_SET_LAYER:
+		if (copy_from_user(&layer_d, buf, sizeof(layer_d)))
+			return -EFAULT;
+		mfbi->x_layer_d = layer_d.x_layer_d;
+		mfbi->y_layer_d = layer_d.y_layer_d;
+		fsl_dcu_set_par(info);
+		break;
+	case MFB_GET_LAYER:
+		layer_d.x_layer_d = mfbi->x_layer_d;
+		layer_d.y_layer_d = mfbi->y_layer_d;
+		if (copy_to_user(buf, &layer_d, sizeof(layer_d)))
+			return -EFAULT;
+		break;
+	case MFB_GET_ALPHA:
+		alpha = mfbi->alpha;
+		if (copy_to_user(buf, &alpha, sizeof(alpha)))
+			return -EFAULT;
+		break;
+	case MFB_SET_ALPHA:
+		if (copy_from_user(&alpha, buf, sizeof(alpha)))
+			return -EFAULT;
+		mfbi->blend = 1;
+		mfbi->alpha = alpha;
+		fsl_dcu_set_par(info);
+		break;
+	default:
+		printk(KERN_ERR "unknown ioctl command (0x%08X)\n", cmd);
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
+static void enable_interrupts(struct dcu_fb_data *dcufb)
+{
+	u32 int_mask = readl(dcufb->reg_base + DCU_INT_MASK);
+
+	writel(int_mask & ~DCU_INT_MASK_UNDRUN, dcufb->reg_base + DCU_INT_MASK);
+}
+
+static void reset_layers(struct dcu_fb_data *dcufb)
+{
+	int i;
+
+	for (i = 1; i < DCU_TOTAL_LAYER_NUM; i++) {
+		writel(0, dcufb->reg_base + DCU_CTRLDESCLN_1(i));
+		writel(0, dcufb->reg_base + DCU_CTRLDESCLN_2(i));
+		writel(0, dcufb->reg_base + DCU_CTRLDESCLN_3(i));
+		writel(0, dcufb->reg_base + DCU_CTRLDESCLN_4(i));
+		writel(0, dcufb->reg_base + DCU_CTRLDESCLN_5(i));
+		writel(0, dcufb->reg_base + DCU_CTRLDESCLN_6(i));
+		writel(0, dcufb->reg_base + DCU_CTRLDESCLN_7(i));
+		writel(0, dcufb->reg_base + DCU_CTRLDESCLN_8(i));
+		writel(0, dcufb->reg_base + DCU_CTRLDESCLN_9(i));
+	}
+	writel(DCU_UPDATE_MODE_READREG, dcufb->reg_base + DCU_UPDATE_MODE);
+}
+
+static int fsl_dcu_open(struct fb_info *info, int user)
+{
+	struct mfb_info *mfbi = info->par;
+	int ret = 0;
+
+	mfbi->index = info->node;
+
+	mfbi->count++;
+	if (mfbi->count = 1) {
+		fsl_dcu_check_var(&info->var, info);
+		ret = fsl_dcu_set_par(info);
+		if (ret < 0)
+			mfbi->count--;
+		else
+			enable_interrupts(mfbi->parent);
+	}
+
+	return ret;
+}
+
+static int fsl_dcu_release(struct fb_info *info, int user)
+{
+	struct mfb_info *mfbi = info->par;
+	int ret = 0;
+
+	mfbi->count--;
+	if (mfbi->count = 0) {
+		ret = disable_panel(info);
+		if (ret < 0)
+			mfbi->count++;
+	}
+
+	return ret;
+}
+
+static struct fb_ops fsl_dcu_ops = {
+	.owner = THIS_MODULE,
+	.fb_check_var = fsl_dcu_check_var,
+	.fb_set_par = fsl_dcu_set_par,
+	.fb_setcolreg = fsl_dcu_setcolreg,
+	.fb_blank = fsl_dcu_blank,
+	.fb_pan_display = fsl_dcu_pan_display,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+	.fb_ioctl = fsl_dcu_ioctl,
+	.fb_open = fsl_dcu_open,
+	.fb_release = fsl_dcu_release,
+};
+
+static int install_framebuffer(struct fb_info *info)
+{
+	struct mfb_info *mfbi = info->par;
+	struct fb_videomode *db = dcu_mode_db;
+	unsigned int dbsize = ARRAY_SIZE(dcu_mode_db);
+	int ret;
+
+	info->var.activate = FB_ACTIVATE_NOW;
+	info->fbops = &fsl_dcu_ops;
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->pseudo_palette = &mfbi->pseudo_palette;
+
+	fb_alloc_cmap(&info->cmap, 16, 0);
+
+	ret = fb_find_mode(&info->var, info, fb_mode, db, dbsize,
+			NULL, default_bpp);
+
+	if (fsl_dcu_check_var(&info->var, info)) {
+		ret = -EINVAL;
+		goto failed_checkvar;
+	}
+
+	if (register_framebuffer(info) < 0) {
+		ret = -EINVAL;
+		goto failed_register_framebuffer;
+	}
+
+	printk(KERN_INFO "fb%d: %s fb device registered successfully.\n",
+		info->node, info->fix.id);
+	return 0;
+
+failed_checkvar:
+	fb_dealloc_cmap(&info->cmap);
+failed_register_framebuffer:
+	unmap_video_memory(info);
+	fb_dealloc_cmap(&info->cmap);
+	return ret;
+}
+
+static void uninstall_framebuffer(struct fb_info *info)
+{
+	unregister_framebuffer(info);
+	unmap_video_memory(info);
+
+	if (&info->cmap)
+		fb_dealloc_cmap(&info->cmap);
+}
+
+static irqreturn_t fsl_dcu_irq(int irq, void *dev_id)
+{
+	struct dcu_fb_data *dcufb = dev_id;
+	unsigned int status = readl(dcufb->reg_base + DCU_INT_STATUS);
+	u32 dcu_mode;
+
+	if (status) {
+		if (status & DCU_INT_STATUS_UNDRUN) {
+			dcu_mode = readl(dcufb->reg_base + DCU_DCU_MODE);
+			dcu_mode &= ~DCU_MODE_DCU_MODE_MASK;
+			writel(dcu_mode | DCU_MODE_DCU_MODE(DCU_MODE_OFF),
+				dcufb->reg_base + DCU_DCU_MODE);
+			udelay(1);
+			writel(dcu_mode | DCU_MODE_DCU_MODE(DCU_MODE_NORMAL),
+				dcufb->reg_base + DCU_DCU_MODE);
+		}
+		writel(status, dcufb->reg_base + DCU_INT_STATUS);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
+#ifdef CONFIG_PM
+static int fsl_dcu_suspend(struct platform_device *pdev,
+		pm_message_t state)
+{
+	struct dcu_fb_data *dcufb = dev_get_drvdata(&pdev->dev);
+
+	clk_disable_unprepare(dcufb->clk);
+	return 0;
+}
+
+static int fsl_dcu_resume(struct platform_device *pdev)
+{
+	struct dcu_fb_data *dcufb = dev_get_drvdata(&pdev->dev);
+
+	clk_prepare_enable(dcufb->clk);
+	return 0;
+}
+#else
+#define fsl_dcu_suspend	NULL
+#define fsl_dcu_resume	NULL
+#endif
+
+static int bypass_tcon(struct device_node *np)
+{
+	struct device_node *tcon_np;
+	struct platform_device *tcon_pdev;
+	struct clk *tcon_clk;
+	void __iomem *tcon_reg;
+	int ret = 0;
+
+	tcon_np = of_parse_phandle(np, "tcon-controller", 0);
+	if (!tcon_np)
+		return -EINVAL;
+
+	tcon_pdev = of_find_device_by_node(tcon_np);
+	if (!tcon_pdev)
+		return -EINVAL;
+
+	tcon_clk = devm_clk_get(&tcon_pdev->dev, "tcon");
+	if (IS_ERR(tcon_clk)) {
+		ret = PTR_ERR(tcon_clk);
+		goto failed_getclock;
+	}
+	clk_prepare_enable(tcon_clk);
+
+	tcon_reg = of_iomap(tcon_np, 0);
+	if (!tcon_reg) {
+		ret = -ENOMEM;
+		goto failed_ioremap;
+	}
+	writel(TCON_BYPASS_ENABLE, tcon_reg + TCON_CTRL1);
+
+	return 0;
+
+failed_ioremap:
+	clk_disable_unprepare(tcon_clk);
+failed_getclock:
+	of_node_put(tcon_np);
+	return ret;
+}
+
+static int fsl_dcu_probe(struct platform_device *pdev)
+{
+	struct dcu_fb_data *dcufb;
+	struct mfb_info *mfbi;
+	struct resource *res;
+	int ret = 0;
+	int i;
+
+	dcufb = devm_kzalloc(&pdev->dev,
+		sizeof(struct dcu_fb_data), GFP_KERNEL);
+	if (!dcufb)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "could not get memory IO resource\n");
+		return -ENODEV;
+	}
+
+	dcufb->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dcufb->reg_base)) {
+		ret = PTR_ERR(dcufb->reg_base);
+		goto failed_ioremap;
+	}
+
+	dcufb->irq = platform_get_irq(pdev, 0);
+	if (!dcufb->irq) {
+		ret = -EINVAL;
+		goto failed_getirq;
+	}
+
+	ret = request_irq(dcufb->irq, fsl_dcu_irq, 0, DRIVER_NAME, dcufb);
+	if (ret) {
+		dev_err(&pdev->dev, "could not request irq\n");
+		goto failed_requestirq;
+	}
+
+	/* Put TCON in bypass mode, so the input signals from DCU are passed
+	 * through TCON unchanged */
+	ret = bypass_tcon(pdev->dev.of_node);
+	if (ret) {
+		dev_err(&pdev->dev, "could not bypass TCON\n");
+		goto failed_bypasstcon;
+	}
+
+	dcufb->clk = devm_clk_get(&pdev->dev, "dcu");
+	if (IS_ERR(dcufb->clk)) {
+		dev_err(&pdev->dev, "could not get clock\n");
+		goto failed_getclock;
+	}
+	clk_prepare_enable(dcufb->clk);
+
+	for (i = 0; i < ARRAY_SIZE(dcufb->fsl_dcu_info); i++) {
+		dcufb->fsl_dcu_info[i] +			framebuffer_alloc(sizeof(struct mfb_info), &pdev->dev);
+		if (!dcufb->fsl_dcu_info[i]) {
+			ret = ENOMEM;
+			goto failed_alloc_framebuffer;
+		}
+
+		dcufb->fsl_dcu_info[i]->fix.smem_start = 0;
+
+		mfbi = dcufb->fsl_dcu_info[i]->par;
+		memcpy(mfbi, &mfb_template[i], sizeof(struct mfb_info));
+		mfbi->parent = dcufb;
+
+		ret = install_framebuffer(dcufb->fsl_dcu_info[i]);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"could not register framebuffer %d\n", i);
+			goto failed_register_framebuffer;
+		}
+	}
+
+	reset_layers(mfbi->parent);
+
+	dev_set_drvdata(&pdev->dev, dcufb);
+	return 0;
+
+failed_register_framebuffer:
+	for (i = 0; i < ARRAY_SIZE(dcufb->fsl_dcu_info); i++) {
+		if (dcufb->fsl_dcu_info[i])
+			framebuffer_release(dcufb->fsl_dcu_info[i]);
+	}
+failed_alloc_framebuffer:
+failed_getclock:
+failed_bypasstcon:
+	free_irq(dcufb->irq, dcufb);
+failed_requestirq:
+failed_getirq:
+	iounmap(dcufb->reg_base);
+failed_ioremap:
+	kfree(dcufb);
+	return ret;
+}
+
+static int fsl_dcu_remove(struct platform_device *pdev)
+{
+	struct dcu_fb_data *dcufb = dev_get_drvdata(&pdev->dev);
+	int i;
+
+	disable_controller(dcufb->fsl_dcu_info[0]);
+
+	clk_disable_unprepare(dcufb->clk);
+	free_irq(dcufb->irq, dcufb);
+
+	for (i = 0; i < ARRAY_SIZE(dcufb->fsl_dcu_info); i++) {
+		uninstall_framebuffer(dcufb->fsl_dcu_info[i]);
+		framebuffer_release(dcufb->fsl_dcu_info[i]);
+	}
+
+	return 0;
+}
+
+static int fsl_dcu_setup(void)
+{
+#ifndef MODULE
+	char *opt, *options = NULL;
+	unsigned long val;
+
+	if (fb_get_options("fslfb", &options))
+		return -ENODEV;
+
+	if (!options || !*options)
+		return 0;
+
+	while ((opt = strsep(&options, ",")) != NULL) {
+		if (!*opt)
+			continue;
+		if (!strncmp(opt, "bpp=", 4)) {
+			if (!strict_strtoul(opt + 4, 10, &val))
+				default_bpp = val;
+		} else {
+			fb_mode = opt;
+		}
+	}
+#endif
+	return 0;
+}
+
+static struct of_device_id fsl_dcu_dt_ids[] = {
+	{
+		.compatible = "fsl,vf610-dcu",
+	},
+	{}
+};
+
+static struct platform_driver fsl_dcu_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = fsl_dcu_dt_ids,
+	},
+	.probe = fsl_dcu_probe,
+	.remove = fsl_dcu_remove,
+	.suspend = fsl_dcu_suspend,
+	.resume = fsl_dcu_resume,
+};
+
+static int __init fsl_dcu_init(void)
+{
+	int ret = fsl_dcu_setup();
+
+	if (ret < 0)
+		return ret;
+
+	return platform_driver_register(&fsl_dcu_driver);
+}
+
+static void __exit fsl_dcu_exit(void)
+{
+	platform_driver_unregister(&fsl_dcu_driver);
+}
+
+module_init(fsl_dcu_init);
+module_exit(fsl_dcu_exit);
+
+MODULE_AUTHOR("Alison Wang");
+MODULE_DESCRIPTION("Freescale DCU framebuffer driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.0


