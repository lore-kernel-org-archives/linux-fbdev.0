From: Sangbeom Kim <sbkim73@samsung.com>
Date: Mon, 18 Oct 2010 12:55:26 +0000
Subject: [PATCH 2/4] ARM: S5PV310: Add platform device and helper functions for FIMD
Message-Id: <1287406528-15324-3-git-send-email-sbkim73@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1287406528-15324-1-git-send-email-sbkim73@samsung.com>
In-Reply-To: <1287406528-15324-1-git-send-email-sbkim73@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Jonghun Han <jonghun.han@samsung.com>

This patch adds platform device s5p_device_fimd0 for S5PV310 FIMD0.
S5PV310 has two FIMDs(FIMD0, FIMD1). FIMD1 will be added later.
Some definitions used to enable S5PV310 FIMD0 are added.

Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5pv310/Kconfig                |    7 +++
 arch/arm/mach-s5pv310/Makefile               |    1 +
 arch/arm/mach-s5pv310/cpu.c                  |    3 +
 arch/arm/mach-s5pv310/include/mach/regs-fb.h |   21 ++++++++
 arch/arm/mach-s5pv310/setup-fimd0-24bpp.c    |   47 ++++++++++++++++++
 arch/arm/plat-s5p/Kconfig                    |    5 ++
 arch/arm/plat-s5p/Makefile                   |    1 +
 arch/arm/plat-s5p/dev-fimd0.c                |   67 ++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h    |    1 +
 arch/arm/plat-samsung/include/plat/fb-core.h |   15 ++++++
 10 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-fb.h
 create mode 100644 arch/arm/mach-s5pv310/setup-fimd0-24bpp.c
 create mode 100644 arch/arm/plat-s5p/dev-fimd0.c

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 1150b36..696f300 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -14,6 +14,11 @@ config CPU_S5PV310
 	help
 	  Enable S5PV310 CPU support
 
+config S5PV310_SETUP_FIMD0_24BPP
+	bool
+	help
+	  Common setup code for FIMD0 with an 24bpp RGB display helper.
+
 config S5PV310_SETUP_I2C1
 	bool
 	help
@@ -95,12 +100,14 @@ menu "S5PV310 Machines"
 config MACH_SMDKV310
 	bool "SMDKV310"
 	select CPU_S5PV310
+	select S5P_DEV_FIMD0
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
+	select S5PV310_SETUP_FIMD0_24BPP
 	select S5PV310_SETUP_SDHCI
 	help
 	  Machine support for Samsung SMDKV310
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index 97aba6d..58bb305 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 
 # device support
 
+obj-$(CONFIG_S5PV310_SETUP_FIMD0_24BPP)	+= setup-fimd0-24bpp.o
 obj-$(CONFIG_S5PV310_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PV310_SETUP_I2C2)	+= setup-i2c2.o
 obj-$(CONFIG_S5PV310_SETUP_I2C3)	+= setup-i2c3.o
diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
index df00df0..f2817cd 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -18,6 +18,8 @@
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
+#include <plat/devs.h>
+#include <plat/fb-core.h>
 #include <plat/s5pv310.h>
 #include <plat/sdhci.h>
 
@@ -105,6 +107,7 @@ void __init s5pv310_map_io(void)
 	s5pv310_default_sdhci1();
 	s5pv310_default_sdhci2();
 	s5pv310_default_sdhci3();
+	s5p_fb_setname(0, "s5pv310-fb");	/* FIMD0 */
 }
 
 void __init s5pv310_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-fb.h b/arch/arm/mach-s5pv310/include/mach/regs-fb.h
new file mode 100644
index 0000000..f320105
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/regs-fb.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
+ *
+ * Dummy framebuffer to allow build for the moment.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_MACH_REGS_FB_H
+#define __ASM_ARCH_MACH_REGS_FB_H __FILE__
+
+#include <plat/regs-fb-v4.h>
+
+static inline unsigned int s3c_fb_pal_reg(unsigned int window, int reg)
+{
+	return 0x2400 + (window * 256 * 4) + reg;
+}
+
+#endif /* __ASM_ARCH_MACH_REGS_FB_H */
diff --git a/arch/arm/mach-s5pv310/setup-fimd0-24bpp.c b/arch/arm/mach-s5pv310/setup-fimd0-24bpp.c
new file mode 100644
index 0000000..7b6b182
--- /dev/null
+++ b/arch/arm/mach-s5pv310/setup-fimd0-24bpp.c
@@ -0,0 +1,47 @@
+/* linux/arch/arm/mach-s5pv310/setup-fimd0-24bpp.c
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Base s5pv210 setup information for 24bpp LCD framebuffer
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/fb.h>
+#include <linux/gpio.h>
+
+#include <plat/fb.h>
+#include <plat/gpio-cfg.h>
+
+#include <mach/regs-clock.h>
+#include <mach/regs-fb.h>
+#include <mach/map.h>
+
+void s5pv310_fimd0_gpio_setup_24bpp(void)
+{
+	unsigned int reg = 0;
+
+	s3c_gpio_cfgrange_nopull(S5PV310_GPF0(0), 8, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgrange_nopull(S5PV310_GPF1(0), 8, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgrange_nopull(S5PV310_GPF2(0), 8, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgrange_nopull(S5PV310_GPF3(0), 4, S3C_GPIO_SFN(2));
+
+	/* 
+	 * Set DISPLAY_CONTROL register for Display path selection.
+	 *
+	 * DISPLAY_CONTROL[1:0]
+	 * ---------------------
+	 *  00 | MIE
+	 *  01 | MDINE
+	 *  10 | FIMD : selected
+	 *  11 | FIMD
+	 */
+	reg = __raw_readl(S3C_VA_SYS + 0x0210);
+	reg |= (1 << 1);
+	__raw_writel(reg, S3C_VA_SYS + 0x0210);
+}
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 65dbfa8..c4e0515 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -52,6 +52,11 @@ config S5P_DEV_FIMC2
 	help
 	  Compile in platform device definitions for FIMC controller 2
 
+config S5P_DEV_FIMD0
+	bool
+	help
+	  Compile in platform device definitions for FIMD controller 0
+
 config S5P_DEV_ONENAND
 	bool
 	help
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index de65238..149e413 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -27,4 +27,5 @@ obj-$(CONFIG_PM)		+= irq-pm.o
 obj-$(CONFIG_S5P_DEV_FIMC0)	+= dev-fimc0.o
 obj-$(CONFIG_S5P_DEV_FIMC1)	+= dev-fimc1.o
 obj-$(CONFIG_S5P_DEV_FIMC2)	+= dev-fimc2.o
+obj-$(CONFIG_S5P_DEV_FIMD0)	+= dev-fimd0.o
 obj-$(CONFIG_S5P_DEV_ONENAND)	+= dev-onenand.o
diff --git a/arch/arm/plat-s5p/dev-fimd0.c b/arch/arm/plat-s5p/dev-fimd0.c
new file mode 100644
index 0000000..81d460a
--- /dev/null
+++ b/arch/arm/plat-s5p/dev-fimd0.c
@@ -0,0 +1,67 @@
+/* linux/arch/arm/plat-s5p/dev-fimd0.c
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Core file for Samsung Display Controller (FIMD) driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/fb.h>
+#include <linux/gfp.h>
+#include <linux/dma-mapping.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/fb.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+
+static struct resource s5p_fimd0_resource[] = {
+	[0] = {
+		.start	= S5P_PA_FIMD0,
+		.end	= S5P_PA_FIMD0 + SZ_32K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_FIMD0_VSYNC,
+		.end	= IRQ_FIMD0_VSYNC,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= IRQ_FIMD0_FIFO,
+		.end	= IRQ_FIMD0_FIFO,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= IRQ_FIMD0_SYSTEM,
+		.end	= IRQ_FIMD0_SYSTEM,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 fimd0_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device s5p_device_fimd0 = {
+	.name		= "s5p-fb",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s5p_fimd0_resource),
+	.resource	= s5p_fimd0_resource,
+	.dev		= {
+		.dma_mask		= &fimd0_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init s5p_fimd0_set_platdata(struct s3c_fb_platdata *pd)
+{
+	s3c_set_platdata(pd, sizeof(struct s3c_fb_platdata),
+			 &s5p_device_fimd0);
+}
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 16521cc..066b7aa 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -40,6 +40,7 @@ extern struct platform_device s3c64xx_device_ac97;
 extern struct platform_device s3c_device_ts;
 
 extern struct platform_device s3c_device_fb;
+extern struct platform_device s5p_device_fimd0;
 extern struct platform_device s3c_device_ohci;
 extern struct platform_device s3c_device_lcd;
 extern struct platform_device s3c_device_wdt;
diff --git a/arch/arm/plat-samsung/include/plat/fb-core.h b/arch/arm/plat-samsung/include/plat/fb-core.h
index bca383e..5be34f8 100644
--- a/arch/arm/plat-samsung/include/plat/fb-core.h
+++ b/arch/arm/plat-samsung/include/plat/fb-core.h
@@ -26,4 +26,19 @@ static inline void s3c_fb_setname(char *name)
 #endif
 }
 
+/* Re-define device name depending on support. */
+static inline void s5p_fb_setname(int id, char *name)
+{
+	switch (id) {
+#ifdef CONFIG_S5P_DEV_FIMD0
+	case 0:
+		s5p_device_fimd0.name = name;
+		break;
+#endif
+	default:
+		printk(KERN_ERR "%s: invalid device id(%d)\n", __func__, id);
+		break;
+	}
+}
+
 #endif /* __ASM_PLAT_FB_CORE_H */
-- 
1.6.2.5

