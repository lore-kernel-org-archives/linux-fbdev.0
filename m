From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 28 May 2014 13:16:57 +0000
Subject: [PATCH] video: move Versatile CLCD helpers
Message-Id: <1401283017-15386-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This moves the Versatile-specific helper code and panel database
down into the drivers/video folder next to the CLCD driver
itself, preserving the config symbol but also moving the header
to platform data.

This is necessary to rid the Integrator of this final <plat/*>
inclusion dependency and get us one less user of the
plat-versatile folder.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/include/mach/uncompress.h |  48 ------
 arch/arm/mach-integrator/integrator_cp.c           |   3 +-
 arch/arm/mach-realview/core.c                      |   2 +-
 arch/arm/mach-versatile/core.c                     |   2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   3 +-
 arch/arm/plat-versatile/Kconfig                    |   3 -
 arch/arm/plat-versatile/Makefile                   |   1 -
 arch/arm/plat-versatile/clcd.c                     | 182 ---------------------
 arch/arm/plat-versatile/include/plat/clcd.h        |   9 -
 drivers/video/Kconfig                              |   6 +
 drivers/video/Makefile                             |   1 +
 drivers/video/amba-clcd-versatile.c                | 182 +++++++++++++++++++++
 include/linux/platform_data/video-clcd-versatile.h |   9 +
 13 files changed, 202 insertions(+), 249 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/include/mach/uncompress.h
 delete mode 100644 arch/arm/plat-versatile/clcd.c
 delete mode 100644 arch/arm/plat-versatile/include/plat/clcd.h
 create mode 100644 drivers/video/amba-clcd-versatile.c
 create mode 100644 include/linux/platform_data/video-clcd-versatile.h

diff --git a/arch/arm/mach-integrator/include/mach/uncompress.h b/arch/arm/mach-integrator/include/mach/uncompress.h
deleted file mode 100644
index 8f3cc9954c16..000000000000
--- a/arch/arm/mach-integrator/include/mach/uncompress.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *  arch/arm/mach-integrator/include/mach/uncompress.h
- *
- *  Copyright (C) 1999 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#define AMBA_UART_DR	(*(volatile unsigned char *)0x16000000)
-#define AMBA_UART_LCRH	(*(volatile unsigned char *)0x16000008)
-#define AMBA_UART_LCRM	(*(volatile unsigned char *)0x1600000c)
-#define AMBA_UART_LCRL	(*(volatile unsigned char *)0x16000010)
-#define AMBA_UART_CR	(*(volatile unsigned char *)0x16000014)
-#define AMBA_UART_FR	(*(volatile unsigned char *)0x16000018)
-
-/*
- * This does not append a newline
- */
-static void putc(int c)
-{
-	while (AMBA_UART_FR & (1 << 5))
-		barrier();
-
-	AMBA_UART_DR = c;
-}
-
-static inline void flush(void)
-{
-	while (AMBA_UART_FR & (1 << 3))
-		barrier();
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index a938242b0c95..0228165d2d64 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -18,6 +18,7 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/kmi.h>
 #include <linux/amba/clcd.h>
+#include <linux/platform_data/video-clcd-versatile.h>
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
 #include <linux/irqchip/versatile-fpga.h>
@@ -36,8 +37,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <plat/clcd.h>
-
 #include "hardware.h"
 #include "cm.h"
 #include "common.h"
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 1d5ee5c9a1dc..ac7184c6ea13 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
+#include <linux/platform_data/video-clcd-versatile.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 #include <linux/ata_platform.h>
@@ -47,7 +48,6 @@
 #include <mach/irqs.h>
 #include <asm/hardware/timer-sp.h>
 
-#include <plat/clcd.h>
 #include <plat/sched_clock.h>
 
 #include "core.h"
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index f2c89fb8fca9..5a19d6e3c791 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -28,6 +28,7 @@
 #include <linux/of_platform.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
+#include <linux/platform_data/video-clcd-versatile.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
 #include <linux/amba/pl022.h>
@@ -53,7 +54,6 @@
 #include <mach/platform.h>
 #include <asm/hardware/timer-sp.h>
 
-#include <plat/clcd.h>
 #include <plat/sched_clock.h>
 
 #include "core.h"
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 6f34497a4245..641c940f157e 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
+#include <linux/platform_data/video-clcd-versatile.h>
 #include <linux/clkdev.h>
 #include <linux/vexpress.h>
 #include <linux/irqchip/arm-gic.h>
@@ -29,8 +30,6 @@
 #include <mach/motherboard.h>
 #include <mach/irqs.h>
 
-#include <plat/clcd.h>
-
 static struct map_desc ct_ca9x4_io_desc[] __initdata = {
 	{
 		.virtual        = V2T_PERIPH,
diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
index 2c4332b9f948..06519520db4e 100644
--- a/arch/arm/plat-versatile/Kconfig
+++ b/arch/arm/plat-versatile/Kconfig
@@ -3,9 +3,6 @@ if PLAT_VERSATILE
 config PLAT_VERSATILE_CLOCK
 	bool
 
-config PLAT_VERSATILE_CLCD
-	bool
-
 config PLAT_VERSATILE_LEDS
 	def_bool y if NEW_LEDS
 	depends on ARCH_REALVIEW || ARCH_VERSATILE
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index f88d448b629c..b648242bb335 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,7 +1,6 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
 obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
-obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
 obj-$(CONFIG_PLAT_VERSATILE_SCHED_CLOCK) += sched-clock.o
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
diff --git a/arch/arm/plat-versatile/clcd.c b/arch/arm/plat-versatile/clcd.c
deleted file mode 100644
index 6628cc27efc5..000000000000
--- a/arch/arm/plat-versatile/clcd.c
+++ /dev/null
@@ -1,182 +0,0 @@
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-#include <linux/amba/bus.h>
-#include <linux/amba/clcd.h>
-#include <plat/clcd.h>
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
-	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, framesize,
-						    &dma, GFP_KERNEL);
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
-	return dma_mmap_writecombine(&fb->dev->dev, vma,
-				     fb->fb.screen_base,
-				     fb->fb.fix.smem_start,
-				     fb->fb.fix.smem_len);
-}
-
-void versatile_clcd_remove_dma(struct clcd_fb *fb)
-{
-	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-			      fb->fb.screen_base, fb->fb.fix.smem_start);
-}
diff --git a/arch/arm/plat-versatile/include/plat/clcd.h b/arch/arm/plat-versatile/include/plat/clcd.h
deleted file mode 100644
index 6bb6a1d2019b..000000000000
--- a/arch/arm/plat-versatile/include/plat/clcd.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef PLAT_CLCD_H
-#define PLAT_CLCD_H
-
-struct clcd_panel *versatile_clcd_get_panel(const char *);
-int versatile_clcd_setup_dma(struct clcd_fb *, unsigned long);
-int versatile_clcd_mmap_dma(struct clcd_fb *, struct vm_area_struct *);
-void versatile_clcd_remove_dma(struct clcd_fb *);
-
-#endif
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6c793bc683d9..dfc27de20e03 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -321,6 +321,12 @@ config FB_ARMCLCD
 	  here and read <file:Documentation/kbuild/modules.txt>.  The module
 	  will be called amba-clcd.
 
+# Helper logic selected only by the ARM Versatile platform family.
+config PLAT_VERSATILE_CLCD
+	depends on FB_ARMCLCD
+	depends on PLAT_VERSATILE
+	bool
+
 config FB_ACORN
 	bool "Acorn VIDC support"
 	depends on (FB = y) && ARM && ARCH_ACORN
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 1be26fe10592..cd5baec3ac50 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_FB_ATMEL)		  += atmel_lcdfb.o
 obj-$(CONFIG_FB_PVR2)             += pvr2fb.o
 obj-$(CONFIG_FB_VOODOO1)          += sstfb.o
 obj-$(CONFIG_FB_ARMCLCD)	  += amba-clcd.o
+obj-$(CONFIG_PLAT_VERSATILE_CLCD) += amba-clcd-versatile.o
 obj-$(CONFIG_FB_GOLDFISH)         += goldfishfb.o
 obj-$(CONFIG_FB_68328)            += 68328fb.o
 obj-$(CONFIG_FB_GBE)              += gbefb.o
diff --git a/drivers/video/amba-clcd-versatile.c b/drivers/video/amba-clcd-versatile.c
new file mode 100644
index 000000000000..7a8afcd4573e
--- /dev/null
+++ b/drivers/video/amba-clcd-versatile.c
@@ -0,0 +1,182 @@
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/clcd.h>
+#include <linux/platform_data/video-clcd-versatile.h>
+
+static struct clcd_panel vga = {
+	.mode		= {
+		.name		= "VGA",
+		.refresh	= 60,
+		.xres		= 640,
+		.yres		= 480,
+		.pixclock	= 39721,
+		.left_margin	= 40,
+		.right_margin	= 24,
+		.upper_margin	= 32,
+		.lower_margin	= 11,
+		.hsync_len	= 96,
+		.vsync_len	= 2,
+		.sync		= 0,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_BCD | TIM2_IPC,
+	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551 | CLCD_CAP_565 | CLCD_CAP_888,
+	.bpp		= 16,
+};
+
+static struct clcd_panel xvga = {
+	.mode		= {
+		.name		= "XVGA",
+		.refresh	= 60,
+		.xres		= 1024,
+		.yres		= 768,
+		.pixclock	= 15748,
+		.left_margin	= 152,
+		.right_margin	= 48,
+		.upper_margin	= 23,
+		.lower_margin	= 3,
+		.hsync_len	= 104,
+		.vsync_len	= 4,
+		.sync		= 0,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_BCD | TIM2_IPC,
+	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551 | CLCD_CAP_565 | CLCD_CAP_888,
+	.bpp		= 16,
+};
+
+/* Sanyo TM38QV67A02A - 3.8 inch QVGA (320x240) Color TFT */
+static struct clcd_panel sanyo_tm38qv67a02a = {
+	.mode		= {
+		.name		= "Sanyo TM38QV67A02A",
+		.refresh	= 116,
+		.xres		= 320,
+		.yres		= 240,
+		.pixclock	= 100000,
+		.left_margin	= 6,
+		.right_margin	= 6,
+		.upper_margin	= 5,
+		.lower_margin	= 5,
+		.hsync_len	= 6,
+		.vsync_len	= 6,
+		.sync		= 0,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_BCD,
+	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
+	.bpp		= 16,
+};
+
+static struct clcd_panel sanyo_2_5_in = {
+	.mode		= {
+		.name		= "Sanyo QVGA Portrait",
+		.refresh	= 116,
+		.xres		= 240,
+		.yres		= 320,
+		.pixclock	= 100000,
+		.left_margin	= 20,
+		.right_margin	= 10,
+		.upper_margin	= 2,
+		.lower_margin	= 2,
+		.hsync_len	= 10,
+		.vsync_len	= 2,
+		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_IVS | TIM2_IHS | TIM2_IPC,
+	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
+	.bpp		= 16,
+};
+
+/* Epson L2F50113T00 - 2.2 inch 176x220 Color TFT */
+static struct clcd_panel epson_l2f50113t00 = {
+	.mode		= {
+		.name		= "Epson L2F50113T00",
+		.refresh	= 390,
+		.xres		= 176,
+		.yres		= 220,
+		.pixclock	= 62500,
+		.left_margin	= 3,
+		.right_margin	= 2,
+		.upper_margin	= 1,
+		.lower_margin	= 0,
+		.hsync_len	= 3,
+		.vsync_len	= 2,
+		.sync		= 0,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+	.width		= -1,
+	.height		= -1,
+	.tim2		= TIM2_BCD | TIM2_IPC,
+	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
+	.bpp		= 16,
+};
+
+static struct clcd_panel *panels[] = {
+	&vga,
+	&xvga,
+	&sanyo_tm38qv67a02a,
+	&sanyo_2_5_in,
+	&epson_l2f50113t00,
+};
+
+struct clcd_panel *versatile_clcd_get_panel(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(panels); i++)
+		if (strcmp(panels[i]->mode.name, name) = 0)
+			break;
+
+	if (i < ARRAY_SIZE(panels))
+		return panels[i];
+
+	pr_err("CLCD: couldn't get parameters for panel %s\n", name);
+
+	return NULL;
+}
+
+int versatile_clcd_setup_dma(struct clcd_fb *fb, unsigned long framesize)
+{
+	dma_addr_t dma;
+
+	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, framesize,
+						    &dma, GFP_KERNEL);
+	if (!fb->fb.screen_base) {
+		pr_err("CLCD: unable to map framebuffer\n");
+		return -ENOMEM;
+	}
+
+	fb->fb.fix.smem_start	= dma;
+	fb->fb.fix.smem_len	= framesize;
+
+	return 0;
+}
+
+int versatile_clcd_mmap_dma(struct clcd_fb *fb, struct vm_area_struct *vma)
+{
+	return dma_mmap_writecombine(&fb->dev->dev, vma,
+				     fb->fb.screen_base,
+				     fb->fb.fix.smem_start,
+				     fb->fb.fix.smem_len);
+}
+
+void versatile_clcd_remove_dma(struct clcd_fb *fb)
+{
+	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
+			      fb->fb.screen_base, fb->fb.fix.smem_start);
+}
diff --git a/include/linux/platform_data/video-clcd-versatile.h b/include/linux/platform_data/video-clcd-versatile.h
new file mode 100644
index 000000000000..6bb6a1d2019b
--- /dev/null
+++ b/include/linux/platform_data/video-clcd-versatile.h
@@ -0,0 +1,9 @@
+#ifndef PLAT_CLCD_H
+#define PLAT_CLCD_H
+
+struct clcd_panel *versatile_clcd_get_panel(const char *);
+int versatile_clcd_setup_dma(struct clcd_fb *, unsigned long);
+int versatile_clcd_mmap_dma(struct clcd_fb *, struct vm_area_struct *);
+void versatile_clcd_remove_dma(struct clcd_fb *);
+
+#endif
-- 
1.9.3

