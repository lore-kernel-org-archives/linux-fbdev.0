From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Tue, 07 Aug 2012 09:49:57 +0000
Subject: [PATCH V3 3/5] arm: samsung: Include the modified FIMD header file
Message-Id: <1344332279-16736-4-git-send-email-l.krishna@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344332279-16736-1-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1344332279-16736-1-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, kgene.kim@samsung.com, m.szyprowski@samsung.com

The fimd register headers have been moved to include/video/
hence, modifying the machine files accordingly.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 arch/arm/mach-exynos/mach-nuri.c           |    2 +-
 arch/arm/mach-exynos/mach-origen.c         |    2 +-
 arch/arm/mach-exynos/mach-smdk4x12.c       |    2 +-
 arch/arm/mach-exynos/mach-smdkv310.c       |    2 +-
 arch/arm/mach-exynos/mach-universal_c210.c |    2 +-
 arch/arm/mach-exynos/setup-fimd0.c         |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c      |    2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c       |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c      |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c      |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c      |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c       |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c       |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c      |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c      |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c      |    2 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c      |    2 +-
 arch/arm/mach-s5pv210/mach-aquila.c        |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c          |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c      |    2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)

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
 
-- 
1.7.0.4

