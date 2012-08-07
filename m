From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Tue, 07 Aug 2012 12:46:31 +0000
Subject: [PATCH V4 1/2] include/video: move fimd register headers from platform to include/video
Message-Id: <1344342872-7904-2-git-send-email-l.krishna@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, kgene.kim@samsung.com, m.szyprowski@samsung.com

This patch moves the contents from regs-fb-v4.h and regs-fb.h to
include/video/samsung_fimd.h. Also updates the header inclusion in
machine files and driver files accordingly.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 arch/arm/mach-exynos/mach-nuri.c                   |    2 +-
 arch/arm/mach-exynos/mach-origen.c                 |    2 +-
 arch/arm/mach-exynos/mach-smdk4x12.c               |    2 +-
 arch/arm/mach-exynos/mach-smdkv310.c               |    2 +-
 arch/arm/mach-exynos/mach-universal_c210.c         |    2 +-
 arch/arm/mach-exynos/setup-fimd0.c                 |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    2 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    2 +-
 arch/arm/mach-s5pv210/mach-aquila.c                |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c                  |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 +-
 arch/arm/plat-samsung/include/plat/regs-fb-v4.h    |  159 --------------------
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |    2 +-
 drivers/video/s3c-fb.c                             |    2 +-
 .../plat/regs-fb.h => include/video/samsung_fimd.h |  145 ++++++++++++++++--
 26 files changed, 158 insertions(+), 194 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
 rename arch/arm/plat-samsung/include/plat/regs-fb.h => include/video/samsung_fimd.h (74%)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index ea785fc..90d8daa 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -29,6 +29,7 @@
 #include <drm/exynos_drm.h>
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 #include <media/m5mols.h>
 #include <media/s5k6aa.h>
 #include <media/s5p_fimc.h>
@@ -39,7 +40,6 @@
 #include <asm/mach-types.h>
 
 #include <plat/adc.h>
-#include <plat/regs-fb-v4.h>
 #include <plat/regs-serial.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 5ca8030..4e245f1 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -29,9 +29,9 @@
 #include <asm/mach-types.h>
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 
 #include <plat/regs-serial.h>
-#include <plat/regs-fb-v4.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index b26beb1..ee069b4 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -26,6 +26,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
+#include <video/samsung_fimd.h>
 #include <plat/backlight.h>
 #include <plat/clock.h>
 #include <plat/cpu.h>
@@ -35,7 +36,6 @@
 #include <plat/iic.h>
 #include <plat/keypad.h>
 #include <plat/mfc.h>
-#include <plat/regs-fb.h>
 #include <plat/regs-serial.h>
 #include <plat/sdhci.h>
 
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index 3cfa688..b1c50da 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -26,9 +26,9 @@
 #include <asm/mach-types.h>
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 #include <plat/regs-serial.h>
 #include <plat/regs-srom.h>
-#include <plat/regs-fb-v4.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/fb.h>
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 4d1f40d..8139cd2 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -30,6 +30,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 
+#include <video/samsung_fimd.h>
 #include <plat/regs-serial.h>
 #include <plat/clock.h>
 #include <plat/cpu.h>
@@ -39,7 +40,6 @@
 #include <plat/fb.h>
 #include <plat/mfc.h>
 #include <plat/sdhci.h>
-#include <plat/regs-fb-v4.h>
 #include <plat/fimc-core.h>
 #include <plat/s5p-time.h>
 #include <plat/camport.h>
diff --git a/arch/arm/mach-exynos/setup-fimd0.c b/arch/arm/mach-exynos/setup-fimd0.c
index 07a6dbe..5665bb4 100644
--- a/arch/arm/mach-exynos/setup-fimd0.c
+++ b/arch/arm/mach-exynos/setup-fimd0.c
@@ -13,8 +13,8 @@
 #include <linux/fb.h>
 #include <linux/gpio.h>
 
+#include <video/samsung_fimd.h>
 #include <plat/gpio-cfg.h>
-#include <plat/regs-fb-v4.h>
 
 #include <mach/map.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index c3100a0..96478f0 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -29,6 +29,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
+#include <video/samsung_fimd.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
@@ -52,7 +53,6 @@
 #include <plat/udc.h>
 #include <linux/platform_data/s3c-hsudc.h>
 
-#include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
 
 #include <plat/common-smdk.h>
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index ffa29dd..f7a108b 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -29,6 +29,7 @@
 #include <linux/dm9000.h>
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
@@ -44,7 +45,6 @@
 #include <plat/regs-serial.h>
 #include <plat/iic.h>
 #include <plat/fb.h>
-#include <plat/regs-fb-v4.h>
 
 #include <plat/clock.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 09cd812..0f882f9 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -46,6 +46,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
+#include <video/samsung_fimd.h>
 #include <mach/hardware.h>
 #include <mach/map.h>
 
@@ -57,7 +58,6 @@
 #include <mach/regs-gpio-memport.h>
 
 #include <plat/regs-serial.h>
-#include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
 #include <plat/sdhci.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 6890881..8ad0bfc 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -26,6 +26,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
+#include <video/samsung_fimd.h>
 #include <mach/hardware.h>
 #include <mach/map.h>
 
@@ -41,7 +42,6 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/regs-fb-v4.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 5539a25..96ebcc5 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -41,9 +41,9 @@
 #include <plat/nand.h>
 #include <plat/regs-serial.h>
 #include <plat/ts.h>
-#include <plat/regs-fb-v4.h>
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index cad2e05..48599bc 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
@@ -43,7 +44,6 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/regs-fb-v4.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 326b216..76d3ffb 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -42,9 +42,9 @@
 #include <plat/nand.h>
 #include <plat/regs-serial.h>
 #include <plat/ts.h>
-#include <plat/regs-fb-v4.h>
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index d6266d8..96d6da2 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -21,6 +21,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <video/samsung_fimd.h>
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
 
@@ -28,7 +29,6 @@
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
-#include <plat/regs-fb-v4.h>
 
 #include "common.h"
 #include "mach-smartq.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index 0957d2a..7d1167b 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -21,6 +21,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <video/samsung_fimd.h>
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
 
@@ -28,7 +29,6 @@
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
-#include <plat/regs-fb-v4.h>
 
 #include "common.h"
 #include "mach-smartq.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 0fe4f15..d1378d7 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -43,6 +43,7 @@
 #endif
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
@@ -72,7 +73,6 @@
 #include <plat/ts.h>
 #include <plat/keypad.h>
 #include <plat/backlight.h>
-#include <plat/regs-fb-v4.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 92fefad..5d0b36e 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -27,6 +27,7 @@
 #include <linux/mmc/host.h>
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
@@ -52,7 +53,6 @@
 #include <plat/s5p-time.h>
 #include <plat/backlight.h>
 #include <plat/fb.h>
-#include <plat/regs-fb.h>
 #include <plat/sdhci.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index e2335ec..7522fb9 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -27,6 +27,7 @@
 #include <linux/mmc/host.h>
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
@@ -52,7 +53,6 @@
 #include <plat/s5p-time.h>
 #include <plat/backlight.h>
 #include <plat/fb.h>
-#include <plat/regs-fb.h>
 #include <plat/sdhci.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 0c3ae38..c3dcafa 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -33,6 +33,7 @@
 #include <mach/regs-gpio.h>
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
@@ -51,7 +52,6 @@
 #include <plat/ts.h>
 #include <plat/audio.h>
 #include <plat/backlight.h>
-#include <plat/regs-fb-v4.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 78028df..ee9fa5c 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 
+#include <video/samsung_fimd.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 
@@ -39,7 +40,6 @@
 #include <plat/fimc-core.h>
 #include <plat/sdhci.h>
 #include <plat/s5p-time.h>
-#include <plat/regs-fb-v4.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 822a559..c552581 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -35,6 +35,7 @@
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 
+#include <video/samsung_fimd.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 
@@ -49,7 +50,6 @@
 #include <plat/clock.h>
 #include <plat/s5p-time.h>
 #include <plat/mfc.h>
-#include <plat/regs-fb-v4.h>
 #include <plat/camport.h>
 
 #include <media/v4l2-mediabus.h>
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 918b23d..9bfbedf 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -28,6 +28,7 @@
 #include <asm/mach-types.h>
 
 #include <video/platform_lcd.h>
+#include <video/samsung_fimd.h>
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
@@ -46,7 +47,6 @@
 #include <plat/fb.h>
 #include <plat/s5p-time.h>
 #include <plat/backlight.h>
-#include <plat/regs-fb-v4.h>
 #include <plat/mfc.h>
 #include <plat/clock.h>
 
diff --git a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
deleted file mode 100644
index 4c3647f..0000000
--- a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
+++ /dev/null
@@ -1,159 +0,0 @@
-/* arch/arm/plat-samsung/include/plat/regs-fb-v4.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      http://armlinux.simtec.co.uk/
- *      Ben Dooks <ben@simtec.co.uk>
- *
- * S3C64XX - new-style framebuffer register definitions
- *
- * This is the register set for the new style framebuffer interface
- * found from the S3C2443 onwards and specifically the S3C64XX series
- * S3C6400 and S3C6410.
- *
- * The file contains the cpu specific items which change between whichever
- * architecture is selected. See <plat/regs-fb.h> for the core definitions
- * that are the same.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* include the core definitions here, in case we really do need to
- * override them at a later date.
-*/
-
-#include <plat/regs-fb.h>
-
-#define S3C_FB_MAX_WIN (5)  /* number of hardware windows available. */
-#define VIDCON1_FSTATUS_EVEN	(1 << 15)
-
-/* Video timing controls */
-#define VIDTCON0				(0x10)
-#define VIDTCON1				(0x14)
-#define VIDTCON2				(0x18)
-
-/* Window position controls */
-
-#define WINCON(_win)				(0x20 + ((_win) * 4))
-
-/* OSD1 and OSD4 do not have register D */
-
-#define VIDOSD_BASE				(0x40)
-
-#define VIDINTCON0				(0x130)
-
-/* WINCONx */
-
-#define WINCONx_CSCWIDTH_MASK			(0x3 << 26)
-#define WINCONx_CSCWIDTH_SHIFT			(26)
-#define WINCONx_CSCWIDTH_WIDE			(0x0 << 26)
-#define WINCONx_CSCWIDTH_NARROW			(0x3 << 26)
-
-#define WINCONx_ENLOCAL				(1 << 22)
-#define WINCONx_BUFSTATUS			(1 << 21)
-#define WINCONx_BUFSEL				(1 << 20)
-#define WINCONx_BUFAUTOEN			(1 << 19)
-#define WINCONx_YCbCr				(1 << 13)
-
-#define WINCON1_LOCALSEL_CAMIF			(1 << 23)
-
-#define WINCON2_LOCALSEL_CAMIF			(1 << 23)
-#define WINCON2_BLD_PIX				(1 << 6)
-
-#define WINCON2_ALPHA_SEL			(1 << 1)
-#define WINCON2_BPPMODE_MASK			(0xf << 2)
-#define WINCON2_BPPMODE_SHIFT			(2)
-#define WINCON2_BPPMODE_1BPP			(0x0 << 2)
-#define WINCON2_BPPMODE_2BPP			(0x1 << 2)
-#define WINCON2_BPPMODE_4BPP			(0x2 << 2)
-#define WINCON2_BPPMODE_8BPP_1232		(0x4 << 2)
-#define WINCON2_BPPMODE_16BPP_565		(0x5 << 2)
-#define WINCON2_BPPMODE_16BPP_A1555		(0x6 << 2)
-#define WINCON2_BPPMODE_16BPP_I1555		(0x7 << 2)
-#define WINCON2_BPPMODE_18BPP_666		(0x8 << 2)
-#define WINCON2_BPPMODE_18BPP_A1665		(0x9 << 2)
-#define WINCON2_BPPMODE_19BPP_A1666		(0xa << 2)
-#define WINCON2_BPPMODE_24BPP_888		(0xb << 2)
-#define WINCON2_BPPMODE_24BPP_A1887		(0xc << 2)
-#define WINCON2_BPPMODE_25BPP_A1888		(0xd << 2)
-#define WINCON2_BPPMODE_28BPP_A4888		(0xd << 2)
-
-#define WINCON3_BLD_PIX				(1 << 6)
-
-#define WINCON3_ALPHA_SEL			(1 << 1)
-#define WINCON3_BPPMODE_MASK			(0xf << 2)
-#define WINCON3_BPPMODE_SHIFT			(2)
-#define WINCON3_BPPMODE_1BPP			(0x0 << 2)
-#define WINCON3_BPPMODE_2BPP			(0x1 << 2)
-#define WINCON3_BPPMODE_4BPP			(0x2 << 2)
-#define WINCON3_BPPMODE_16BPP_565		(0x5 << 2)
-#define WINCON3_BPPMODE_16BPP_A1555		(0x6 << 2)
-#define WINCON3_BPPMODE_16BPP_I1555		(0x7 << 2)
-#define WINCON3_BPPMODE_18BPP_666		(0x8 << 2)
-#define WINCON3_BPPMODE_18BPP_A1665		(0x9 << 2)
-#define WINCON3_BPPMODE_19BPP_A1666		(0xa << 2)
-#define WINCON3_BPPMODE_24BPP_888		(0xb << 2)
-#define WINCON3_BPPMODE_24BPP_A1887		(0xc << 2)
-#define WINCON3_BPPMODE_25BPP_A1888		(0xd << 2)
-#define WINCON3_BPPMODE_28BPP_A4888		(0xd << 2)
-
-#define VIDINTCON0_FIFIOSEL_WINDOW2		(0x10 << 5)
-#define VIDINTCON0_FIFIOSEL_WINDOW3		(0x20 << 5)
-#define VIDINTCON0_FIFIOSEL_WINDOW4		(0x40 << 5)
-
-#define DITHMODE				(0x170)
-#define WINxMAP(_win)				(0x180 + ((_win) * 4))
-
-
-#define DITHMODE_R_POS_MASK			(0x3 << 5)
-#define DITHMODE_R_POS_SHIFT			(5)
-#define DITHMODE_R_POS_8BIT			(0x0 << 5)
-#define DITHMODE_R_POS_6BIT			(0x1 << 5)
-#define DITHMODE_R_POS_5BIT			(0x2 << 5)
-
-#define DITHMODE_G_POS_MASK			(0x3 << 3)
-#define DITHMODE_G_POS_SHIFT			(3)
-#define DITHMODE_G_POS_8BIT			(0x0 << 3)
-#define DITHMODE_G_POS_6BIT			(0x1 << 3)
-#define DITHMODE_G_POS_5BIT			(0x2 << 3)
-
-#define DITHMODE_B_POS_MASK			(0x3 << 1)
-#define DITHMODE_B_POS_SHIFT			(1)
-#define DITHMODE_B_POS_8BIT			(0x0 << 1)
-#define DITHMODE_B_POS_6BIT			(0x1 << 1)
-#define DITHMODE_B_POS_5BIT			(0x2 << 1)
-
-#define DITHMODE_DITH_EN			(1 << 0)
-
-#define WPALCON					(0x1A0)
-
-/* Palette control */
-/* Note for S5PC100: you can still use those macros on WPALCON (aka WPALCON_L),
- * but make sure that WPALCON_H W2PAL-W4PAL entries are zeroed out */
-#define WPALCON_W4PAL_16BPP_A555		(1 << 8)
-#define WPALCON_W3PAL_16BPP_A555		(1 << 7)
-#define WPALCON_W2PAL_16BPP_A555		(1 << 6)
-
-
-/* Notes on per-window bpp settings
- *
- * Value	Win0	 Win1	  Win2	   Win3	    Win 4
- * 0000		1(P)	 1(P)	  1(P)	   1(P)	    1(P)
- * 0001		2(P)	 2(P)     2(P)	   2(P)	    2(P)
- * 0010		4(P)	 4(P)     4(P)	   4(P)     -none-
- * 0011		8(P)	 8(P)     -none-   -none-   -none-
- * 0100		-none-	 8(A232)  8(A232)  -none-   -none-
- * 0101		16(565)	 16(565)  16(565)  16(565)   16(565)
- * 0110		-none-	 16(A555) 16(A555) 16(A555)  16(A555)
- * 0111		16(I555) 16(I565) 16(I555) 16(I555)  16(I555)
- * 1000		18(666)	 18(666)  18(666)  18(666)   18(666)
- * 1001		-none-	 18(A665) 18(A665) 18(A665)  16(A665)
- * 1010		-none-	 19(A666) 19(A666) 19(A666)  19(A666)
- * 1011		24(888)	 24(888)  24(888)  24(888)   24(888)
- * 1100		-none-	 24(A887) 24(A887) 24(A887)  24(A887)
- * 1101		-none-	 25(A888) 25(A888) 25(A888)  25(A888)
- * 1110		-none-	 -none-	  -none-   -none-    -none-
- * 1111		-none-	 -none-   -none-   -none-    -none-
-*/
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index a68d2b3..24c0bd4 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -19,8 +19,8 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 
+#include <video/samsung_fimd.h>
 #include <drm/exynos_drm.h>
-#include <plat/regs-fb-v4.h>
 
 #include "exynos_drm_drv.h"
 #include "exynos_drm_fbdev.h"
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 69bf9d0..901729e 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -25,8 +25,8 @@
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
 
+#include <video/samsung_fimd.h>
 #include <mach/map.h>
-#include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
 
 /* This driver will export a number of framebuffer interfaces depending
diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/include/video/samsung_fimd.h
similarity index 74%
rename from arch/arm/plat-samsung/include/plat/regs-fb.h
rename to include/video/samsung_fimd.h
index 9a78012..e979f42 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb.h
+++ b/include/video/samsung_fimd.h
@@ -1,13 +1,13 @@
-/* arch/arm/plat-samsung/include/plat/regs-fb.h
+/* include/video/samsung_fimd.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *      http://armlinux.simtec.co.uk/
  *      Ben Dooks <ben@simtec.co.uk>
  *
- * S3C Platform - new-style framebuffer register definitions
+ * S3C Platform - new-style fimd and framebuffer register definitions
  *
- * This is the register set for the new style framebuffer interface
+ * This is the register set for the fimd and new style framebuffer interface
  * found from the S3C2443 onwards into the S3C2416, S3C2450 and the
  * S3C64XX series such as the S3C6400 and S3C6410.
  *
@@ -15,19 +15,11 @@
  * whichever architecture is selected, it only contains the core of the
  * register set. See <mach/regs-fb.h> to get the specifics.
  *
- * Note, we changed to using regs-fb.h as it avoids any clashes with
- * the original regs-lcd.h so out of the way of regs-lcd.h as well as
- * indicating the newer block is much more than just an LCD interface.
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
 
-/* Please do not include this file directly, use <mach/regs-fb.h> to
- * ensure all the localised SoC support is included as necessary.
-*/
-
 /* VIDCON0 */
 
 #define VIDCON0					(0x00)
@@ -401,3 +393,134 @@
 #define BLENDCON_NEW_8BIT_ALPHA_VALUE		(1 << 0)
 #define BLENDCON_NEW_4BIT_ALPHA_VALUE		(0 << 0)
 
+#define S3C_FB_MAX_WIN (5)  /* number of hardware windows available. */
+#define VIDCON1_FSTATUS_EVEN	(1 << 15)
+
+/* Video timing controls */
+#define VIDTCON0				(0x10)
+#define VIDTCON1				(0x14)
+#define VIDTCON2				(0x18)
+
+/* Window position controls */
+
+#define WINCON(_win)				(0x20 + ((_win) * 4))
+
+/* OSD1 and OSD4 do not have register D */
+
+#define VIDOSD_BASE				(0x40)
+
+#define VIDINTCON0				(0x130)
+
+/* WINCONx */
+
+#define WINCONx_CSCWIDTH_MASK			(0x3 << 26)
+#define WINCONx_CSCWIDTH_SHIFT			(26)
+#define WINCONx_CSCWIDTH_WIDE			(0x0 << 26)
+#define WINCONx_CSCWIDTH_NARROW			(0x3 << 26)
+
+#define WINCONx_ENLOCAL				(1 << 22)
+#define WINCONx_BUFSTATUS			(1 << 21)
+#define WINCONx_BUFSEL				(1 << 20)
+#define WINCONx_BUFAUTOEN			(1 << 19)
+#define WINCONx_YCbCr				(1 << 13)
+
+#define WINCON1_LOCALSEL_CAMIF			(1 << 23)
+
+#define WINCON2_LOCALSEL_CAMIF			(1 << 23)
+#define WINCON2_BLD_PIX				(1 << 6)
+
+#define WINCON2_ALPHA_SEL			(1 << 1)
+#define WINCON2_BPPMODE_MASK			(0xf << 2)
+#define WINCON2_BPPMODE_SHIFT			(2)
+#define WINCON2_BPPMODE_1BPP			(0x0 << 2)
+#define WINCON2_BPPMODE_2BPP			(0x1 << 2)
+#define WINCON2_BPPMODE_4BPP			(0x2 << 2)
+#define WINCON2_BPPMODE_8BPP_1232		(0x4 << 2)
+#define WINCON2_BPPMODE_16BPP_565		(0x5 << 2)
+#define WINCON2_BPPMODE_16BPP_A1555		(0x6 << 2)
+#define WINCON2_BPPMODE_16BPP_I1555		(0x7 << 2)
+#define WINCON2_BPPMODE_18BPP_666		(0x8 << 2)
+#define WINCON2_BPPMODE_18BPP_A1665		(0x9 << 2)
+#define WINCON2_BPPMODE_19BPP_A1666		(0xa << 2)
+#define WINCON2_BPPMODE_24BPP_888		(0xb << 2)
+#define WINCON2_BPPMODE_24BPP_A1887		(0xc << 2)
+#define WINCON2_BPPMODE_25BPP_A1888		(0xd << 2)
+#define WINCON2_BPPMODE_28BPP_A4888		(0xd << 2)
+
+#define WINCON3_BLD_PIX				(1 << 6)
+
+#define WINCON3_ALPHA_SEL			(1 << 1)
+#define WINCON3_BPPMODE_MASK			(0xf << 2)
+#define WINCON3_BPPMODE_SHIFT			(2)
+#define WINCON3_BPPMODE_1BPP			(0x0 << 2)
+#define WINCON3_BPPMODE_2BPP			(0x1 << 2)
+#define WINCON3_BPPMODE_4BPP			(0x2 << 2)
+#define WINCON3_BPPMODE_16BPP_565		(0x5 << 2)
+#define WINCON3_BPPMODE_16BPP_A1555		(0x6 << 2)
+#define WINCON3_BPPMODE_16BPP_I1555		(0x7 << 2)
+#define WINCON3_BPPMODE_18BPP_666		(0x8 << 2)
+#define WINCON3_BPPMODE_18BPP_A1665		(0x9 << 2)
+#define WINCON3_BPPMODE_19BPP_A1666		(0xa << 2)
+#define WINCON3_BPPMODE_24BPP_888		(0xb << 2)
+#define WINCON3_BPPMODE_24BPP_A1887		(0xc << 2)
+#define WINCON3_BPPMODE_25BPP_A1888		(0xd << 2)
+#define WINCON3_BPPMODE_28BPP_A4888		(0xd << 2)
+
+#define VIDINTCON0_FIFIOSEL_WINDOW2		(0x10 << 5)
+#define VIDINTCON0_FIFIOSEL_WINDOW3		(0x20 << 5)
+#define VIDINTCON0_FIFIOSEL_WINDOW4		(0x40 << 5)
+
+#define DITHMODE				(0x170)
+#define WINxMAP(_win)				(0x180 + ((_win) * 4))
+
+
+#define DITHMODE_R_POS_MASK			(0x3 << 5)
+#define DITHMODE_R_POS_SHIFT			(5)
+#define DITHMODE_R_POS_8BIT			(0x0 << 5)
+#define DITHMODE_R_POS_6BIT			(0x1 << 5)
+#define DITHMODE_R_POS_5BIT			(0x2 << 5)
+
+#define DITHMODE_G_POS_MASK			(0x3 << 3)
+#define DITHMODE_G_POS_SHIFT			(3)
+#define DITHMODE_G_POS_8BIT			(0x0 << 3)
+#define DITHMODE_G_POS_6BIT			(0x1 << 3)
+#define DITHMODE_G_POS_5BIT			(0x2 << 3)
+
+#define DITHMODE_B_POS_MASK			(0x3 << 1)
+#define DITHMODE_B_POS_SHIFT			(1)
+#define DITHMODE_B_POS_8BIT			(0x0 << 1)
+#define DITHMODE_B_POS_6BIT			(0x1 << 1)
+#define DITHMODE_B_POS_5BIT			(0x2 << 1)
+
+#define DITHMODE_DITH_EN			(1 << 0)
+
+#define WPALCON					(0x1A0)
+
+/* Palette control */
+/* Note for S5PC100: you can still use those macros on WPALCON (aka WPALCON_L),
+ * but make sure that WPALCON_H W2PAL-W4PAL entries are zeroed out */
+#define WPALCON_W4PAL_16BPP_A555		(1 << 8)
+#define WPALCON_W3PAL_16BPP_A555		(1 << 7)
+#define WPALCON_W2PAL_16BPP_A555		(1 << 6)
+
+
+/* Notes on per-window bpp settings
+ *
+ * Value	Win0	 Win1	  Win2	   Win3	    Win 4
+ * 0000		1(P)	 1(P)	  1(P)	   1(P)	    1(P)
+ * 0001		2(P)	 2(P)     2(P)	   2(P)	    2(P)
+ * 0010		4(P)	 4(P)     4(P)	   4(P)     -none-
+ * 0011		8(P)	 8(P)     -none-   -none-   -none-
+ * 0100		-none-	 8(A232)  8(A232)  -none-   -none-
+ * 0101		16(565)	 16(565)  16(565)  16(565)   16(565)
+ * 0110		-none-	 16(A555) 16(A555) 16(A555)  16(A555)
+ * 0111		16(I555) 16(I565) 16(I555) 16(I555)  16(I555)
+ * 1000		18(666)	 18(666)  18(666)  18(666)   18(666)
+ * 1001		-none-	 18(A665) 18(A665) 18(A665)  16(A665)
+ * 1010		-none-	 19(A666) 19(A666) 19(A666)  19(A666)
+ * 1011		24(888)	 24(888)  24(888)  24(888)   24(888)
+ * 1100		-none-	 24(A887) 24(A887) 24(A887)  24(A887)
+ * 1101		-none-	 25(A888) 25(A888) 25(A888)  25(A888)
+ * 1110		-none-	 -none-	  -none-   -none-    -none-
+ * 1111		-none-	 -none-   -none-   -none-    -none-
+*/
-- 
1.7.0.4

