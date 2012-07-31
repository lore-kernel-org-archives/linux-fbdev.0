From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Tue, 31 Jul 2012 12:35:03 +0000
Subject: [PATCH V2 3/5] arm: samsung: Include the modified FIMD header file
Message-Id: <1343737385-23337-4-git-send-email-l.krishna@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, inki.dae@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, jg1.han@samsung.com, m.szyprowski@samsung.com

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
index f98a83a..573a0c4 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -39,7 +39,7 @@
 #include <asm/mach-types.h>
 
 #include <plat/adc.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 #include <plat/regs-serial.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 5a12dc2..c69707e 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -31,7 +31,7 @@
 #include <video/platform_lcd.h>
 
 #include <plat/regs-serial.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index b26beb1..8a8acff 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -35,7 +35,7 @@
 #include <plat/iic.h>
 #include <plat/keypad.h>
 #include <plat/mfc.h>
-#include <plat/regs-fb.h>
+#include <video/samsung_fimd.h>
 #include <plat/regs-serial.h>
 #include <plat/sdhci.h>
 
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index 3cfa688..c2df6e8 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -28,7 +28,7 @@
 #include <video/platform_lcd.h>
 #include <plat/regs-serial.h>
 #include <plat/regs-srom.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/fb.h>
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 4d1f40d..e6fb471 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -39,7 +39,7 @@
 #include <plat/fb.h>
 #include <plat/mfc.h>
 #include <plat/sdhci.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 #include <plat/fimc-core.h>
 #include <plat/s5p-time.h>
 #include <plat/camport.h>
diff --git a/arch/arm/mach-exynos/setup-fimd0.c b/arch/arm/mach-exynos/setup-fimd0.c
index 07a6dbe..53c4c51 100644
--- a/arch/arm/mach-exynos/setup-fimd0.c
+++ b/arch/arm/mach-exynos/setup-fimd0.c
@@ -14,7 +14,7 @@
 #include <linux/gpio.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include <mach/map.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index c3100a0..c8d5f51 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -52,7 +52,7 @@
 #include <plat/udc.h>
 #include <linux/platform_data/s3c-hsudc.h>
 
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 #include <plat/fb.h>
 
 #include <plat/common-smdk.h>
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index ffa29dd..27e3087 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -44,7 +44,7 @@
 #include <plat/regs-serial.h>
 #include <plat/iic.h>
 #include <plat/fb.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include <plat/clock.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 09cd812..66e8c69 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -57,7 +57,7 @@
 #include <mach/regs-gpio-memport.h>
 
 #include <plat/regs-serial.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 #include <plat/fb.h>
 #include <plat/sdhci.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 6890881..ab78c5e 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -41,7 +41,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 5539a25..4b9a9ff 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -41,7 +41,7 @@
 #include <plat/nand.h>
 #include <plat/regs-serial.h>
 #include <plat/ts.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include <video/platform_lcd.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index cad2e05..d4c8af0 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -43,7 +43,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 326b216..05f05d2 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -42,7 +42,7 @@
 #include <plat/nand.h>
 #include <plat/regs-serial.h>
 #include <plat/ts.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include <video/platform_lcd.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index d6266d8..aa225ff 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -28,7 +28,7 @@
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include "common.h"
 #include "mach-smartq.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index 0957d2a..6e9c070 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -28,7 +28,7 @@
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include "common.h"
 #include "mach-smartq.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 0fe4f15..1803192 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -72,7 +72,7 @@
 #include <plat/ts.h>
 #include <plat/keypad.h>
 #include <plat/backlight.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 92fefad..0db0bdd 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -52,7 +52,7 @@
 #include <plat/s5p-time.h>
 #include <plat/backlight.h>
 #include <plat/fb.h>
-#include <plat/regs-fb.h>
+#include <video/smasung_fimd.h>
 #include <plat/sdhci.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index e2335ec..c641d33 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -52,7 +52,7 @@
 #include <plat/s5p-time.h>
 #include <plat/backlight.h>
 #include <plat/fb.h>
-#include <plat/regs-fb.h>
+#include <video/samsung_fimd.h>
 #include <plat/sdhci.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 0c3ae38..e4df3d0 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -51,7 +51,7 @@
 #include <plat/ts.h>
 #include <plat/audio.h>
 #include <plat/backlight.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 78028df..8cbe4ac 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -39,7 +39,7 @@
 #include <plat/fimc-core.h>
 #include <plat/sdhci.h>
 #include <plat/s5p-time.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 822a559..e799a02 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -49,7 +49,7 @@
 #include <plat/clock.h>
 #include <plat/s5p-time.h>
 #include <plat/mfc.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 #include <plat/camport.h>
 
 #include <media/v4l2-mediabus.h>
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 918b23d..3c569e5 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -46,7 +46,7 @@
 #include <plat/fb.h>
 #include <plat/s5p-time.h>
 #include <plat/backlight.h>
-#include <plat/regs-fb-v4.h>
+#include <video/samsung_fimd.h>
 #include <plat/mfc.h>
 #include <plat/clock.h>
 
-- 
1.7.0.4

