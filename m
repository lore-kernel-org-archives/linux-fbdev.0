From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Mar 2019 09:33:31 +0000
Subject: [PATCH] video: amba-clcd: Decomission Versatile and Nomadik
Message-Id: <20190320093331.11251-1-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@armlinux.org.uk>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org

These board families are now handled in the DRM subsystem
where we can have reusable panel drivers and some other
stuff. The PL111 there is now the driver used in the
defconfig for Versatile and Nomadik so no need to keep
this code around.

There are a few minor machines in arch/arm/ such as
mach-netx still using the old driver, so we need to keep
the core fbdev driver around for some time.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/video/fbdev/Kconfig               |   8 -
 drivers/video/fbdev/Makefile              |   2 -
 drivers/video/fbdev/amba-clcd-nomadik.c   | 251 ----------
 drivers/video/fbdev/amba-clcd-nomadik.h   |  24 -
 drivers/video/fbdev/amba-clcd-versatile.c | 567 ----------------------
 drivers/video/fbdev/amba-clcd-versatile.h |  17 -
 drivers/video/fbdev/amba-clcd.c           |  98 +---
 include/linux/amba/clcd.h                 |  31 --
 8 files changed, 2 insertions(+), 996 deletions(-)
 delete mode 100644 drivers/video/fbdev/amba-clcd-nomadik.c
 delete mode 100644 drivers/video/fbdev/amba-clcd-nomadik.h
 delete mode 100644 drivers/video/fbdev/amba-clcd-versatile.c
 delete mode 100644 drivers/video/fbdev/amba-clcd-versatile.h

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 58a9590c9db6..bab926ad614b 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -293,14 +293,6 @@ config FB_ARMCLCD
 	  here and read <file:Documentation/kbuild/modules.txt>.  The module
 	  will be called amba-clcd.
 
-# Helper logic selected only by the ARM Versatile platform family.
-config PLAT_VERSATILE_CLCD
-	def_bool ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_INTEGRATOR
-	depends on ARM
-	depends on FB_ARMCLCD && FB=y
-	select REGMAP
-	select MFD_SYSCON
-
 config FB_ACORN
 	bool "Acorn VIDC support"
 	depends on (FB = y) && ARM && ARCH_ACORN
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 846b0c9ea9db..655f2537cac1 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -76,8 +76,6 @@ obj-$(CONFIG_FB_ATMEL)		  += atmel_lcdfb.o
 obj-$(CONFIG_FB_PVR2)             += pvr2fb.o
 obj-$(CONFIG_FB_VOODOO1)          += sstfb.o
 obj-$(CONFIG_FB_ARMCLCD)	  += amba-clcd.o
-obj-$(CONFIG_ARCH_NOMADIK)	  += amba-clcd-nomadik.o
-obj-$(CONFIG_PLAT_VERSATILE_CLCD) += amba-clcd-versatile.o
 obj-$(CONFIG_FB_GOLDFISH)         += goldfishfb.o
 obj-$(CONFIG_FB_68328)            += 68328fb.o
 obj-$(CONFIG_FB_GBE)              += gbefb.o
diff --git a/drivers/video/fbdev/amba-clcd-nomadik.c b/drivers/video/fbdev/amba-clcd-nomadik.c
deleted file mode 100644
index cd2db1113e67..000000000000
--- a/drivers/video/fbdev/amba-clcd-nomadik.c
+++ /dev/null
@@ -1,251 +0,0 @@
-#include <linux/amba/bus.h>
-#include <linux/amba/clcd.h>
-#include <linux/gpio/consumer.h>
-#include <linux/of.h>
-#include <linux/of_graph.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
-
-#include "amba-clcd-nomadik.h"
-
-static struct gpio_desc *grestb;
-static struct gpio_desc *scen;
-static struct gpio_desc *scl;
-static struct gpio_desc *sda;
-
-static u8 tpg110_readwrite_reg(bool write, u8 address, u8 outval)
-{
-	int i;
-	u8 inval = 0;
-
-	/* Assert SCEN */
-	gpiod_set_value_cansleep(scen, 1);
-	ndelay(150);
-	/* Hammer out the address */
-	for (i = 5; i >= 0; i--) {
-		if (address & BIT(i))
-			gpiod_set_value_cansleep(sda, 1);
-		else
-			gpiod_set_value_cansleep(sda, 0);
-		ndelay(150);
-		/* Send an SCL pulse */
-		gpiod_set_value_cansleep(scl, 1);
-		ndelay(160);
-		gpiod_set_value_cansleep(scl, 0);
-		ndelay(160);
-	}
-
-	if (write) {
-		/* WRITE */
-		gpiod_set_value_cansleep(sda, 0);
-	} else {
-		/* READ */
-		gpiod_set_value_cansleep(sda, 1);
-	}
-	ndelay(150);
-	/* Send an SCL pulse */
-	gpiod_set_value_cansleep(scl, 1);
-	ndelay(160);
-	gpiod_set_value_cansleep(scl, 0);
-	ndelay(160);
-
-	if (!write)
-		/* HiZ turn-around cycle */
-		gpiod_direction_input(sda);
-	ndelay(150);
-	/* Send an SCL pulse */
-	gpiod_set_value_cansleep(scl, 1);
-	ndelay(160);
-	gpiod_set_value_cansleep(scl, 0);
-	ndelay(160);
-
-	/* Hammer in/out the data */
-	for (i = 7; i >= 0; i--) {
-		int value;
-
-		if (write) {
-			value = !!(outval & BIT(i));
-			gpiod_set_value_cansleep(sda, value);
-		} else {
-			value = gpiod_get_value(sda);
-			if (value)
-				inval |= BIT(i);
-		}
-		ndelay(150);
-		/* Send an SCL pulse */
-		gpiod_set_value_cansleep(scl, 1);
-		ndelay(160);
-		gpiod_set_value_cansleep(scl, 0);
-		ndelay(160);
-	}
-
-	gpiod_direction_output(sda, 0);
-	/* Deassert SCEN */
-	gpiod_set_value_cansleep(scen, 0);
-	/* Satisfies SCEN pulse width */
-	udelay(1);
-
-	return inval;
-}
-
-static u8 tpg110_read_reg(u8 address)
-{
-	return tpg110_readwrite_reg(false, address, 0);
-}
-
-static void tpg110_write_reg(u8 address, u8 outval)
-{
-	tpg110_readwrite_reg(true, address, outval);
-}
-
-static void tpg110_startup(struct device *dev)
-{
-	u8 val;
-
-	dev_info(dev, "TPG110 display enable\n");
-	/* De-assert the reset signal */
-	gpiod_set_value_cansleep(grestb, 0);
-	mdelay(1);
-	dev_info(dev, "de-asserted GRESTB\n");
-
-	/* Test display communication */
-	tpg110_write_reg(0x00, 0x55);
-	val = tpg110_read_reg(0x00);
-	if (val = 0x55)
-		dev_info(dev, "passed communication test\n");
-	val = tpg110_read_reg(0x01);
-	dev_info(dev, "TPG110 chip ID: %d version: %d\n",
-		val>>4, val&0x0f);
-
-	/* Show display resolution */
-	val = tpg110_read_reg(0x02);
-	val &= 7;
-	switch (val) {
-	case 0x0:
-		dev_info(dev, "IN 400x240 RGB -> OUT 800x480 RGB (dual scan)");
-		break;
-	case 0x1:
-		dev_info(dev, "IN 480x272 RGB -> OUT 800x480 RGB (dual scan)");
-		break;
-	case 0x4:
-		dev_info(dev, "480x640 RGB");
-		break;
-	case 0x5:
-		dev_info(dev, "480x272 RGB");
-		break;
-	case 0x6:
-		dev_info(dev, "640x480 RGB");
-		break;
-	case 0x7:
-		dev_info(dev, "800x480 RGB");
-		break;
-	default:
-		dev_info(dev, "ILLEGAL RESOLUTION");
-		break;
-	}
-
-	val = tpg110_read_reg(0x03);
-	dev_info(dev, "resolution is controlled by %s\n",
-		(val & BIT(7)) ? "software" : "hardware");
-}
-
-static void tpg110_enable(struct clcd_fb *fb)
-{
-	struct device *dev = &fb->dev->dev;
-	static bool startup;
-	u8 val;
-
-	if (!startup) {
-		tpg110_startup(dev);
-		startup = true;
-	}
-
-	/* Take chip out of standby */
-	val = tpg110_read_reg(0x03);
-	val |= BIT(0);
-	tpg110_write_reg(0x03, val);
-}
-
-static void tpg110_disable(struct clcd_fb *fb)
-{
-	u8 val;
-
-	dev_info(&fb->dev->dev, "TPG110 display disable\n");
-	val = tpg110_read_reg(0x03);
-	/* Put into standby */
-	val &= ~BIT(0);
-	tpg110_write_reg(0x03, val);
-}
-
-static void tpg110_init(struct device *dev, struct device_node *np,
-			struct clcd_board *board)
-{
-	dev_info(dev, "TPG110 display init\n");
-
-	/* This asserts the GRESTB signal, putting the display into reset */
-	grestb = devm_fwnode_get_gpiod_from_child(dev, "grestb", &np->fwnode,
-						  GPIOD_OUT_HIGH, "grestb");
-	if (IS_ERR(grestb)) {
-		dev_err(dev, "no GRESTB GPIO\n");
-		return;
-	}
-	scen = devm_fwnode_get_gpiod_from_child(dev, "scen", &np->fwnode,
-						GPIOD_OUT_LOW, "scen");
-	if (IS_ERR(scen)) {
-		dev_err(dev, "no SCEN GPIO\n");
-		return;
-	}
-	scl = devm_fwnode_get_gpiod_from_child(dev, "scl", &np->fwnode,
-					       GPIOD_OUT_LOW, "scl");
-	if (IS_ERR(scl)) {
-		dev_err(dev, "no SCL GPIO\n");
-		return;
-	}
-	sda = devm_fwnode_get_gpiod_from_child(dev, "sda", &np->fwnode,
-					       GPIOD_OUT_LOW, "sda");
-	if (IS_ERR(sda)) {
-		dev_err(dev, "no SDA GPIO\n");
-		return;
-	}
-	board->enable = tpg110_enable;
-	board->disable = tpg110_disable;
-}
-
-int nomadik_clcd_init_panel(struct clcd_fb *fb, struct device_node *panel)
-{
-	if (of_device_is_compatible(panel, "tpo,tpg110"))
-		tpg110_init(&fb->dev->dev, panel, fb->board);
-	else
-		dev_info(&fb->dev->dev, "unknown panel\n");
-
-	/* Unknown panel, fall through */
-	return 0;
-}
-EXPORT_SYMBOL_GPL(nomadik_clcd_init_panel);
-
-#define PMU_CTRL_OFFSET 0x0000
-#define PMU_CTRL_LCDNDIF BIT(26)
-
-int nomadik_clcd_init_board(struct amba_device *adev,
-			    struct clcd_board *board)
-{
-	struct regmap *pmu_regmap;
-
-	dev_info(&adev->dev, "Nomadik CLCD board init\n");
-	pmu_regmap -		syscon_regmap_lookup_by_compatible("stericsson,nomadik-pmu");
-	if (IS_ERR(pmu_regmap)) {
-		dev_err(&adev->dev, "could not find PMU syscon regmap\n");
-		return PTR_ERR(pmu_regmap);
-	}
-	regmap_update_bits(pmu_regmap,
-			   PMU_CTRL_OFFSET,
-			   PMU_CTRL_LCDNDIF,
-			   0);
-	dev_info(&adev->dev, "set PMU mux to CLCD mode\n");
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(nomadik_clcd_init_board);
diff --git a/drivers/video/fbdev/amba-clcd-nomadik.h b/drivers/video/fbdev/amba-clcd-nomadik.h
deleted file mode 100644
index 462c31381fa1..000000000000
--- a/drivers/video/fbdev/amba-clcd-nomadik.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _AMBA_CLCD_NOMADIK_H
-#define _AMBA_CLCD_NOMADIK_H
-
-#include <linux/amba/bus.h>
-
-#ifdef CONFIG_ARCH_NOMADIK
-int nomadik_clcd_init_board(struct amba_device *adev,
-			     struct clcd_board *board);
-int nomadik_clcd_init_panel(struct clcd_fb *fb, struct device_node *panel);
-#else
-static inline int nomadik_clcd_init_board(struct amba_device *adev,
-					  struct clcd_board *board)
-{
-	return 0;
-}
-static inline int nomadik_clcd_init_panel(struct clcd_fb *fb,
-					  struct device_node *panel)
-{
-	return 0;
-}
-#endif
-
-#endif /* inclusion guard */
diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
deleted file mode 100644
index d42047dc4e4e..000000000000
--- a/drivers/video/fbdev/amba-clcd-versatile.c
+++ /dev/null
@@ -1,567 +0,0 @@
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-#include <linux/amba/bus.h>
-#include <linux/amba/clcd.h>
-#include <linux/platform_data/video-clcd-versatile.h>
-#include <linux/of.h>
-#include <linux/of_graph.h>
-#include <linux/regmap.h>
-#include <linux/mfd/syscon.h>
-#include <linux/bitops.h>
-#include "amba-clcd-versatile.h"
-
-static struct clcd_panel vga = {
-	.mode		= {
-		.name		= "VGA",
-		.refresh	= 60,
-		.xres		= 640,
-		.yres		= 480,
-		.pixclock	= 39721,
-		.left_margin	= 40,
-		.right_margin	= 24,
-		.upper_margin	= 32,
-		.lower_margin	= 11,
-		.hsync_len	= 96,
-		.vsync_len	= 2,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD | TIM2_IPC,
-	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
-	.caps		= CLCD_CAP_5551 | CLCD_CAP_565 | CLCD_CAP_888,
-	.bpp		= 16,
-};
-
-static struct clcd_panel xvga = {
-	.mode		= {
-		.name		= "XVGA",
-		.refresh	= 60,
-		.xres		= 1024,
-		.yres		= 768,
-		.pixclock	= 15748,
-		.left_margin	= 152,
-		.right_margin	= 48,
-		.upper_margin	= 23,
-		.lower_margin	= 3,
-		.hsync_len	= 104,
-		.vsync_len	= 4,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD | TIM2_IPC,
-	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
-	.caps		= CLCD_CAP_5551 | CLCD_CAP_565 | CLCD_CAP_888,
-	.bpp		= 16,
-};
-
-/* Sanyo TM38QV67A02A - 3.8 inch QVGA (320x240) Color TFT */
-static struct clcd_panel sanyo_tm38qv67a02a = {
-	.mode		= {
-		.name		= "Sanyo TM38QV67A02A",
-		.refresh	= 116,
-		.xres		= 320,
-		.yres		= 240,
-		.pixclock	= 100000,
-		.left_margin	= 6,
-		.right_margin	= 6,
-		.upper_margin	= 5,
-		.lower_margin	= 5,
-		.hsync_len	= 6,
-		.vsync_len	= 6,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD,
-	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
-	.caps		= CLCD_CAP_5551,
-	.bpp		= 16,
-};
-
-static struct clcd_panel sanyo_2_5_in = {
-	.mode		= {
-		.name		= "Sanyo QVGA Portrait",
-		.refresh	= 116,
-		.xres		= 240,
-		.yres		= 320,
-		.pixclock	= 100000,
-		.left_margin	= 20,
-		.right_margin	= 10,
-		.upper_margin	= 2,
-		.lower_margin	= 2,
-		.hsync_len	= 10,
-		.vsync_len	= 2,
-		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_IVS | TIM2_IHS | TIM2_IPC,
-	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
-	.caps		= CLCD_CAP_5551,
-	.bpp		= 16,
-};
-
-/* Epson L2F50113T00 - 2.2 inch 176x220 Color TFT */
-static struct clcd_panel epson_l2f50113t00 = {
-	.mode		= {
-		.name		= "Epson L2F50113T00",
-		.refresh	= 390,
-		.xres		= 176,
-		.yres		= 220,
-		.pixclock	= 62500,
-		.left_margin	= 3,
-		.right_margin	= 2,
-		.upper_margin	= 1,
-		.lower_margin	= 0,
-		.hsync_len	= 3,
-		.vsync_len	= 2,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD | TIM2_IPC,
-	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
-	.caps		= CLCD_CAP_5551,
-	.bpp		= 16,
-};
-
-static struct clcd_panel *panels[] = {
-	&vga,
-	&xvga,
-	&sanyo_tm38qv67a02a,
-	&sanyo_2_5_in,
-	&epson_l2f50113t00,
-};
-
-struct clcd_panel *versatile_clcd_get_panel(const char *name)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(panels); i++)
-		if (strcmp(panels[i]->mode.name, name) = 0)
-			break;
-
-	if (i < ARRAY_SIZE(panels))
-		return panels[i];
-
-	pr_err("CLCD: couldn't get parameters for panel %s\n", name);
-
-	return NULL;
-}
-
-int versatile_clcd_setup_dma(struct clcd_fb *fb, unsigned long framesize)
-{
-	dma_addr_t dma;
-
-	fb->fb.screen_base = dma_alloc_wc(&fb->dev->dev, framesize, &dma,
-					  GFP_KERNEL);
-	if (!fb->fb.screen_base) {
-		pr_err("CLCD: unable to map framebuffer\n");
-		return -ENOMEM;
-	}
-
-	fb->fb.fix.smem_start	= dma;
-	fb->fb.fix.smem_len	= framesize;
-
-	return 0;
-}
-
-int versatile_clcd_mmap_dma(struct clcd_fb *fb, struct vm_area_struct *vma)
-{
-	return dma_mmap_wc(&fb->dev->dev, vma, fb->fb.screen_base,
-			   fb->fb.fix.smem_start, fb->fb.fix.smem_len);
-}
-
-void versatile_clcd_remove_dma(struct clcd_fb *fb)
-{
-	dma_free_wc(&fb->dev->dev, fb->fb.fix.smem_len, fb->fb.screen_base,
-		    fb->fb.fix.smem_start);
-}
-
-#ifdef CONFIG_OF
-
-static struct regmap *versatile_syscon_map;
-static struct regmap *versatile_ib2_map;
-
-/*
- * We detect the different syscon types from the compatible strings.
- */
-enum versatile_clcd {
-	INTEGRATOR_CLCD_CM,
-	VERSATILE_CLCD,
-	REALVIEW_CLCD_EB,
-	REALVIEW_CLCD_PB1176,
-	REALVIEW_CLCD_PB11MP,
-	REALVIEW_CLCD_PBA8,
-	REALVIEW_CLCD_PBX,
-};
-
-static const struct of_device_id versatile_clcd_of_match[] = {
-	{
-		.compatible = "arm,core-module-integrator",
-		.data = (void *)INTEGRATOR_CLCD_CM,
-	},
-	{
-		.compatible = "arm,versatile-sysreg",
-		.data = (void *)VERSATILE_CLCD,
-	},
-	{
-		.compatible = "arm,realview-eb-syscon",
-		.data = (void *)REALVIEW_CLCD_EB,
-	},
-	{
-		.compatible = "arm,realview-pb1176-syscon",
-		.data = (void *)REALVIEW_CLCD_PB1176,
-	},
-	{
-		.compatible = "arm,realview-pb11mp-syscon",
-		.data = (void *)REALVIEW_CLCD_PB11MP,
-	},
-	{
-		.compatible = "arm,realview-pba8-syscon",
-		.data = (void *)REALVIEW_CLCD_PBA8,
-	},
-	{
-		.compatible = "arm,realview-pbx-syscon",
-		.data = (void *)REALVIEW_CLCD_PBX,
-	},
-	{},
-};
-
-/*
- * Core module CLCD control on the Integrator/CP, bits
- * 8 thru 19 of the CM_CONTROL register controls a bunch
- * of CLCD settings.
- */
-#define INTEGRATOR_HDR_CTRL_OFFSET	0x0C
-#define INTEGRATOR_CLCD_LCDBIASEN	BIT(8)
-#define INTEGRATOR_CLCD_LCDBIASUP	BIT(9)
-#define INTEGRATOR_CLCD_LCDBIASDN	BIT(10)
-/* Bits 11,12,13 controls the LCD type */
-#define INTEGRATOR_CLCD_LCDMUX_MASK	(BIT(11)|BIT(12)|BIT(13))
-#define INTEGRATOR_CLCD_LCDMUX_LCD24	BIT(11)
-#define INTEGRATOR_CLCD_LCDMUX_VGA565	BIT(12)
-#define INTEGRATOR_CLCD_LCDMUX_SHARP	(BIT(11)|BIT(12))
-#define INTEGRATOR_CLCD_LCDMUX_VGA555	BIT(13)
-#define INTEGRATOR_CLCD_LCDMUX_VGA24	(BIT(11)|BIT(12)|BIT(13))
-#define INTEGRATOR_CLCD_LCD0_EN		BIT(14)
-#define INTEGRATOR_CLCD_LCD1_EN		BIT(15)
-/* R/L flip on Sharp */
-#define INTEGRATOR_CLCD_LCD_STATIC1	BIT(16)
-/* U/D flip on Sharp */
-#define INTEGRATOR_CLCD_LCD_STATIC2	BIT(17)
-/* No connection on Sharp */
-#define INTEGRATOR_CLCD_LCD_STATIC	BIT(18)
-/* 0 = 24bit VGA, 1 = 18bit VGA */
-#define INTEGRATOR_CLCD_LCD_N24BITEN	BIT(19)
-
-#define INTEGRATOR_CLCD_MASK		(INTEGRATOR_CLCD_LCDBIASEN | \
-					 INTEGRATOR_CLCD_LCDBIASUP | \
-					 INTEGRATOR_CLCD_LCDBIASDN | \
-					 INTEGRATOR_CLCD_LCDMUX_MASK | \
-					 INTEGRATOR_CLCD_LCD0_EN | \
-					 INTEGRATOR_CLCD_LCD1_EN | \
-					 INTEGRATOR_CLCD_LCD_STATIC1 | \
-					 INTEGRATOR_CLCD_LCD_STATIC2 | \
-					 INTEGRATOR_CLCD_LCD_STATIC | \
-					 INTEGRATOR_CLCD_LCD_N24BITEN)
-
-static void integrator_clcd_enable(struct clcd_fb *fb)
-{
-	struct fb_var_screeninfo *var = &fb->fb.var;
-	u32 val;
-
-	dev_info(&fb->dev->dev, "enable Integrator CLCD connectors\n");
-
-	/* FIXME: really needed? */
-	val = INTEGRATOR_CLCD_LCD_STATIC1 | INTEGRATOR_CLCD_LCD_STATIC2 |
-		INTEGRATOR_CLCD_LCD0_EN | INTEGRATOR_CLCD_LCD1_EN;
-	if (var->bits_per_pixel <= 8 ||
-	    (var->bits_per_pixel = 16 && var->green.length = 5))
-		/* Pseudocolor, RGB555, BGR555 */
-		val |= INTEGRATOR_CLCD_LCDMUX_VGA555;
-	else if (fb->fb.var.bits_per_pixel <= 16)
-		/* truecolor RGB565 */
-		val |= INTEGRATOR_CLCD_LCDMUX_VGA565;
-	else
-		val = 0; /* no idea for this, don't trust the docs */
-
-	regmap_update_bits(versatile_syscon_map,
-			   INTEGRATOR_HDR_CTRL_OFFSET,
-			   INTEGRATOR_CLCD_MASK,
-			   val);
-}
-
-/*
- * This configuration register in the Versatile and RealView
- * family is uniformly present but appears more and more
- * unutilized starting with the RealView series.
- */
-#define SYS_CLCD			0x50
-#define SYS_CLCD_MODE_MASK		(BIT(0)|BIT(1))
-#define SYS_CLCD_MODE_888		0
-#define SYS_CLCD_MODE_5551		BIT(0)
-#define SYS_CLCD_MODE_565_R_LSB		BIT(1)
-#define SYS_CLCD_MODE_565_B_LSB		(BIT(0)|BIT(1))
-#define SYS_CLCD_CONNECTOR_MASK		(BIT(2)|BIT(3)|BIT(4)|BIT(5))
-#define SYS_CLCD_NLCDIOON		BIT(2)
-#define SYS_CLCD_VDDPOSSWITCH		BIT(3)
-#define SYS_CLCD_PWR3V5SWITCH		BIT(4)
-#define SYS_CLCD_VDDNEGSWITCH		BIT(5)
-#define SYS_CLCD_TSNSS			BIT(6) /* touchscreen enable */
-#define SYS_CLCD_SSPEXP			BIT(7) /* SSP expansion enable */
-
-/* The Versatile can detect the connected panel type */
-#define SYS_CLCD_CLCDID_MASK		(BIT(8)|BIT(9)|BIT(10)|BIT(11)|BIT(12))
-#define SYS_CLCD_ID_SANYO_3_8		(0x00 << 8)
-#define SYS_CLCD_ID_SHARP_8_4		(0x01 << 8)
-#define SYS_CLCD_ID_EPSON_2_2		(0x02 << 8)
-#define SYS_CLCD_ID_SANYO_2_5		(0x07 << 8)
-#define SYS_CLCD_ID_VGA			(0x1f << 8)
-
-#define SYS_CLCD_TSNDAV			BIT(13) /* data ready from TS */
-
-/* IB2 control register for the Versatile daughterboard */
-#define IB2_CTRL			0x00
-#define IB2_CTRL_LCD_SD			BIT(1) /* 1 = shut down LCD */
-#define IB2_CTRL_LCD_BL_ON		BIT(0)
-#define IB2_CTRL_LCD_MASK		(BIT(0)|BIT(1))
-
-static void versatile_clcd_disable(struct clcd_fb *fb)
-{
-	dev_info(&fb->dev->dev, "disable Versatile CLCD connectors\n");
-	regmap_update_bits(versatile_syscon_map,
-			   SYS_CLCD,
-			   SYS_CLCD_CONNECTOR_MASK,
-			   0);
-
-	/* If we're on an IB2 daughterboard, turn off display */
-	if (versatile_ib2_map) {
-		dev_info(&fb->dev->dev, "disable IB2 display\n");
-		regmap_update_bits(versatile_ib2_map,
-				   IB2_CTRL,
-				   IB2_CTRL_LCD_MASK,
-				   IB2_CTRL_LCD_SD);
-	}
-}
-
-static void versatile_clcd_enable(struct clcd_fb *fb)
-{
-	struct fb_var_screeninfo *var = &fb->fb.var;
-	u32 val = 0;
-
-	dev_info(&fb->dev->dev, "enable Versatile CLCD connectors\n");
-	switch (var->green.length) {
-	case 5:
-		val |= SYS_CLCD_MODE_5551;
-		break;
-	case 6:
-		if (var->red.offset = 0)
-			val |= SYS_CLCD_MODE_565_R_LSB;
-		else
-			val |= SYS_CLCD_MODE_565_B_LSB;
-		break;
-	case 8:
-		val |= SYS_CLCD_MODE_888;
-		break;
-	}
-
-	/* Set up the MUX */
-	regmap_update_bits(versatile_syscon_map,
-			   SYS_CLCD,
-			   SYS_CLCD_MODE_MASK,
-			   val);
-
-	/* Then enable the display */
-	regmap_update_bits(versatile_syscon_map,
-			   SYS_CLCD,
-			   SYS_CLCD_CONNECTOR_MASK,
-			   SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH);
-
-	/* If we're on an IB2 daughterboard, turn on display */
-	if (versatile_ib2_map) {
-		dev_info(&fb->dev->dev, "enable IB2 display\n");
-		regmap_update_bits(versatile_ib2_map,
-				   IB2_CTRL,
-				   IB2_CTRL_LCD_MASK,
-				   IB2_CTRL_LCD_BL_ON);
-	}
-}
-
-static void versatile_clcd_decode(struct clcd_fb *fb, struct clcd_regs *regs)
-{
-	clcdfb_decode(fb, regs);
-
-	/* Always clear BGR for RGB565: we do the routing externally */
-	if (fb->fb.var.green.length = 6)
-		regs->cntl &= ~CNTL_BGR;
-}
-
-static void realview_clcd_disable(struct clcd_fb *fb)
-{
-	dev_info(&fb->dev->dev, "disable RealView CLCD connectors\n");
-	regmap_update_bits(versatile_syscon_map,
-			   SYS_CLCD,
-			   SYS_CLCD_CONNECTOR_MASK,
-			   0);
-}
-
-static void realview_clcd_enable(struct clcd_fb *fb)
-{
-	dev_info(&fb->dev->dev, "enable RealView CLCD connectors\n");
-	regmap_update_bits(versatile_syscon_map,
-			   SYS_CLCD,
-			   SYS_CLCD_CONNECTOR_MASK,
-			   SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH);
-}
-
-struct versatile_panel {
-	u32 id;
-	char *compatible;
-	bool ib2;
-};
-
-static const struct versatile_panel versatile_panels[] = {
-	{
-		.id = SYS_CLCD_ID_VGA,
-		.compatible = "VGA",
-	},
-	{
-		.id = SYS_CLCD_ID_SANYO_3_8,
-		.compatible = "sanyo,tm38qv67a02a",
-	},
-	{
-		.id = SYS_CLCD_ID_SHARP_8_4,
-		.compatible = "sharp,lq084v1dg21",
-	},
-	{
-		.id = SYS_CLCD_ID_EPSON_2_2,
-		.compatible = "epson,l2f50113t00",
-	},
-	{
-		.id = SYS_CLCD_ID_SANYO_2_5,
-		.compatible = "sanyo,alr252rgt",
-		.ib2 = true,
-	},
-};
-
-static void versatile_panel_probe(struct device *dev, struct device_node *panel)
-{
-	struct versatile_panel const *vpanel = NULL;
-	u32 val;
-	int ret;
-	int i;
-
-	/*
-	 * The Versatile CLCD has a panel auto-detection mechanism.
-	 * We use this and look for the compatible panel in the
-	 * device tree.
-	 */
-	ret = regmap_read(versatile_syscon_map, SYS_CLCD, &val);
-	if (ret) {
-		dev_err(dev, "cannot read CLCD syscon register\n");
-		return;
-	}
-	val &= SYS_CLCD_CLCDID_MASK;
-
-	/* First find corresponding panel information */
-	for (i = 0; i < ARRAY_SIZE(versatile_panels); i++) {
-		vpanel = &versatile_panels[i];
-
-		if (val = vpanel->id) {
-			dev_err(dev, "autodetected panel \"%s\"\n",
-				vpanel->compatible);
-			break;
-		}
-	}
-	if (i = ARRAY_SIZE(versatile_panels)) {
-		dev_err(dev, "could not auto-detect panel\n");
-		return;
-	}
-
-	if (!of_device_is_compatible(panel, vpanel->compatible))
-		dev_err(dev, "panel in DT is not compatible with the "
-			"auto-detected panel, continuing anyway\n");
-
-	/*
-	 * If we have a Sanyo 2.5" port
-	 * that we're running on an IB2 and proceed to look for the
-	 * IB2 syscon regmap.
-	 */
-	if (!vpanel->ib2)
-		return;
-
-	versatile_ib2_map = syscon_regmap_lookup_by_compatible(
-		"arm,versatile-ib2-syscon");
-	if (IS_ERR(versatile_ib2_map)) {
-		dev_err(dev, "could not locate IB2 control register\n");
-		versatile_ib2_map = NULL;
-		return;
-	}
-}
-
-int versatile_clcd_init_panel(struct clcd_fb *fb, struct device_node *panel)
-{
-	const struct of_device_id *clcd_id;
-	enum versatile_clcd versatile_clcd_type;
-	struct device_node *np;
-	struct regmap *map;
-	struct device *dev = &fb->dev->dev;
-
-	np = of_find_matching_node_and_match(NULL, versatile_clcd_of_match,
-					     &clcd_id);
-	if (!np) {
-		/* Vexpress does not have this */
-		return 0;
-	}
-	versatile_clcd_type = (enum versatile_clcd)clcd_id->data;
-
-	map = syscon_node_to_regmap(np);
-	if (IS_ERR(map)) {
-		dev_err(dev, "no Versatile syscon regmap\n");
-		return PTR_ERR(map);
-	}
-
-	switch (versatile_clcd_type) {
-	case INTEGRATOR_CLCD_CM:
-		versatile_syscon_map = map;
-		fb->board->enable = integrator_clcd_enable;
-		/* Override the caps, we have only these */
-		fb->board->caps = CLCD_CAP_5551 | CLCD_CAP_RGB565 |
-			CLCD_CAP_888;
-		dev_info(dev, "set up callbacks for Integrator PL110\n");
-		break;
-	case VERSATILE_CLCD:
-		versatile_syscon_map = map;
-		fb->board->enable = versatile_clcd_enable;
-		fb->board->disable = versatile_clcd_disable;
-		fb->board->decode = versatile_clcd_decode;
-		versatile_panel_probe(dev, panel);
-		dev_info(dev, "set up callbacks for Versatile\n");
-		break;
-	case REALVIEW_CLCD_EB:
-	case REALVIEW_CLCD_PB1176:
-	case REALVIEW_CLCD_PB11MP:
-	case REALVIEW_CLCD_PBA8:
-	case REALVIEW_CLCD_PBX:
-		versatile_syscon_map = map;
-		fb->board->enable = realview_clcd_enable;
-		fb->board->disable = realview_clcd_disable;
-		dev_info(dev, "set up callbacks for RealView PL111\n");
-		break;
-	default:
-		dev_info(dev, "unknown Versatile system controller\n");
-		break;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(versatile_clcd_init_panel);
-#endif
diff --git a/drivers/video/fbdev/amba-clcd-versatile.h b/drivers/video/fbdev/amba-clcd-versatile.h
deleted file mode 100644
index b20baa47e6ad..000000000000
--- a/drivers/video/fbdev/amba-clcd-versatile.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Special local versatile callbacks
- */
-#include <linux/of.h>
-#include <linux/amba/bus.h>
-#include <linux/platform_data/video-clcd-versatile.h>
-
-#if defined(CONFIG_PLAT_VERSATILE_CLCD) && defined(CONFIG_OF)
-int versatile_clcd_init_panel(struct clcd_fb *fb, struct device_node *panel);
-#else
-static inline int versatile_clcd_init_panel(struct clcd_fb *fb,
-					    struct device_node *panel)
-{
-	return 0;
-}
-#endif
diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 38c1f324ce15..89324e42a033 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -30,9 +30,6 @@
 #include <video/of_display_timing.h>
 #include <video/videomode.h>
 
-#include "amba-clcd-nomadik.h"
-#include "amba-clcd-versatile.h"
-
 #define to_clcd(info)	container_of(info, struct clcd_fb, fb)
 
 /* This is limited to 16 characters when displayed by X startup */
@@ -223,15 +220,6 @@ clcdfb_set_bitfields(struct clcd_fb *fb, struct fb_var_screeninfo *var)
 			var->blue.length = 4;
 		}
 		break;
-	case 24:
-		if (fb->vendor->packed_24_bit_pixels) {
-			var->red.length = 8;
-			var->green.length = 8;
-			var->blue.length = 8;
-		} else {
-			ret = -EINVAL;
-		}
-		break;
 	case 32:
 		/* If we can't do 888, reject */
 		caps &= CLCD_CAP_888;
@@ -318,12 +306,6 @@ static int clcdfb_set_par(struct fb_info *info)
 
 	clcdfb_disable(fb);
 
-	/* Some variants must be clocked here */
-	if (fb->vendor->clock_timregs && !fb->clk_enabled) {
-		fb->clk_enabled = true;
-		clk_enable(fb->clk);
-	}
-
 	writel(regs.tim0, fb->regs + CLCD_TIM0);
 	writel(regs.tim1, fb->regs + CLCD_TIM1);
 	writel(regs.tim2, fb->regs + CLCD_TIM2);
@@ -465,14 +447,8 @@ static int clcdfb_register(struct clcd_fb *fb)
 		fb->off_ienb = CLCD_PL111_IENB;
 		fb->off_cntl = CLCD_PL111_CNTL;
 	} else {
-		if (of_machine_is_compatible("arm,versatile-ab") ||
-		    of_machine_is_compatible("arm,versatile-pb")) {
-			fb->off_ienb = CLCD_PL111_IENB;
-			fb->off_cntl = CLCD_PL111_CNTL;
-		} else {
-			fb->off_ienb = CLCD_PL110_IENB;
-			fb->off_cntl = CLCD_PL110_CNTL;
-		}
+		fb->off_ienb = CLCD_PL110_IENB;
+		fb->off_cntl = CLCD_PL110_CNTL;
 	}
 
 	fb->clk = clk_get(&fb->dev->dev, NULL);
@@ -713,42 +689,6 @@ static int clcdfb_of_init_tft_panel(struct clcd_fb *fb, u32 r0, u32 g0, u32 b0)
 	if (r0 != 0 && b0 = 0)
 		fb->panel->bgr_connection = true;
 
-	if (fb->panel->caps && fb->vendor->st_bitmux_control) {
-		/*
-		 * Set up the special bits for the Nomadik control register
-		 * (other platforms tend to do this through an external
-		 * register).
-		 */
-
-		/* Offset of the highest used color */
-		int maxoff = max3(r0, g0, b0);
-		/* Most significant bit out, highest used bit */
-		int msb = 0;
-
-		if (fb->panel->caps & CLCD_CAP_888) {
-			msb = maxoff + 8 - 1;
-		} else if (fb->panel->caps & CLCD_CAP_565) {
-			msb = maxoff + 5 - 1;
-			fb->panel->cntl |= CNTL_ST_1XBPP_565;
-		} else if (fb->panel->caps & CLCD_CAP_5551) {
-			msb = maxoff + 5 - 1;
-			fb->panel->cntl |= CNTL_ST_1XBPP_5551;
-		} else if (fb->panel->caps & CLCD_CAP_444) {
-			msb = maxoff + 4 - 1;
-			fb->panel->cntl |= CNTL_ST_1XBPP_444;
-		}
-
-		/* Send out as many bits as we need */
-		if (msb > 17)
-			fb->panel->cntl |= CNTL_ST_CDWID_24;
-		else if (msb > 15)
-			fb->panel->cntl |= CNTL_ST_CDWID_18;
-		else if (msb > 11)
-			fb->panel->cntl |= CNTL_ST_CDWID_16;
-		else
-			fb->panel->cntl |= CNTL_ST_CDWID_12;
-	}
-
 	return fb->panel->caps ? 0 : -EINVAL;
 }
 
@@ -775,12 +715,6 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 	if (!panel)
 		return -ENODEV;
 
-	if (fb->vendor->init_panel) {
-		err = fb->vendor->init_panel(fb, panel);
-		if (err)
-			return err;
-	}
-
 	err = clcdfb_of_get_backlight(panel, fb->panel);
 	if (err)
 		return err;
@@ -941,7 +875,6 @@ static struct clcd_board *clcdfb_of_get_board(struct amba_device *dev)
 static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct clcd_board *board = dev_get_platdata(&dev->dev);
-	struct clcd_vendor_data *vendor = id->data;
 	struct clcd_fb *fb;
 	int ret;
 
@@ -951,12 +884,6 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 	if (!board)
 		return -EINVAL;
 
-	if (vendor->init_board) {
-		ret = vendor->init_board(dev, board);
-		if (ret)
-			return ret;
-	}
-
 	ret = dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
 	if (ret)
 		goto out;
@@ -974,7 +901,6 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 	}
 
 	fb->dev = dev;
-	fb->vendor = vendor;
 	fb->board = board;
 
 	dev_info(&fb->dev->dev, "PL%03x designer %02x rev%u at 0x%08llx\n",
@@ -1021,30 +947,10 @@ static int clcdfb_remove(struct amba_device *dev)
 	return 0;
 }
 
-static struct clcd_vendor_data vendor_arm = {
-	/* Sets up the versatile board displays */
-	.init_panel = versatile_clcd_init_panel,
-};
-
-static struct clcd_vendor_data vendor_nomadik = {
-	.clock_timregs = true,
-	.packed_24_bit_pixels = true,
-	.st_bitmux_control = true,
-	.init_board = nomadik_clcd_init_board,
-	.init_panel = nomadik_clcd_init_panel,
-};
-
 static const struct amba_id clcdfb_id_table[] = {
 	{
 		.id	= 0x00041110,
 		.mask	= 0x000ffffe,
-		.data	= &vendor_arm,
-	},
-	/* ST Electronics Nomadik variant */
-	{
-		.id	= 0x00180110,
-		.mask	= 0x00fffffe,
-		.data	= &vendor_nomadik,
 	},
 	{ 0, 0 },
 };
diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index d0c3be77c18e..b6e0cbeaf533 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -124,38 +124,11 @@ struct clcd_board {
 struct amba_device;
 struct clk;
 
-/**
- * struct clcd_vendor_data - holds hardware (IP-block) vendor-specific
- * variant information
- *
- * @clock_timregs: the CLCD needs to be clocked when accessing the
- * timer registers, or the hardware will hang.
- * @packed_24_bit_pixels: this variant supports 24bit packed pixel data,
- * so that RGB accesses 3 bytes at a time, not just on even 32bit
- * boundaries, packing the pixel data in memory. ST Microelectronics
- * have this.
- * @st_bitmux_control: ST Microelectronics have implemented output
- * bit line multiplexing into the CLCD control register. This indicates
- * that we need to use this.
- * @init_board: custom board init function for this variant
- * @init_panel: custom panel init function for this variant
- */
-struct clcd_vendor_data {
-	bool	clock_timregs;
-	bool	packed_24_bit_pixels;
-	bool	st_bitmux_control;
-	int	(*init_board)(struct amba_device *adev,
-			      struct clcd_board *board);
-	int	(*init_panel)(struct clcd_fb *fb,
-			      struct device_node *panel);
-};
-
 /* this data structure describes each frame buffer device we find */
 struct clcd_fb {
 	struct fb_info		fb;
 	struct amba_device	*dev;
 	struct clk		*clk;
-	struct clcd_vendor_data	*vendor;
 	struct clcd_panel	*panel;
 	struct clcd_board	*board;
 	void			*board_data;
@@ -257,10 +230,6 @@ static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs *regs)
 		else
 			val |= CNTL_LCDBPP16_444;
 		break;
-	case 24:
-		/* Modified variant supporting 24 bit packed pixels */
-		val |= CNTL_ST_LCDBPP24_PACKED;
-		break;
 	case 32:
 		val |= CNTL_LCDBPP24;
 		break;
-- 
2.20.1
