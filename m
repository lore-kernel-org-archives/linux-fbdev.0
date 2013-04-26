From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Fri, 26 Apr 2013 20:02:17 +0000
Subject: [PATCH 3/9] ARM: S3C24XX: Remove include/mach/regs-lcd.h header file
Message-Id: <1367006543-5458-4-git-send-email-sylvester.nawrocki@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
In-Reply-To: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Move remaining s3c2410 LCD controller register bit field definitions
to the platform data header. Now the regs-lcd.h header can be removed
and inclusion of the mach specific header dropped from the driver.
Next step could be to redefine platform data structure, so register
specific definitions are private to the driver. Another possibility
is to add DT support, however these platforms will likely use ATAGS
for some time yet.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/mach-s3c24xx/dma-s3c2410.c           |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2412.c           |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2440.c           |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2443.c           |    1 -
 arch/arm/mach-s3c24xx/include/mach/regs-lcd.h |   52 -------------------------
 arch/arm/mach-s3c24xx/mach-anubis.c           |    1 -
 arch/arm/mach-s3c24xx/mach-at2440evb.c        |    1 -
 arch/arm/mach-s3c24xx/mach-bast.c             |    1 -
 arch/arm/mach-s3c24xx/mach-h1940.c            |    1 -
 arch/arm/mach-s3c24xx/mach-jive.c             |    1 -
 arch/arm/mach-s3c24xx/mach-mini2440.c         |    1 -
 arch/arm/mach-s3c24xx/mach-n30.c              |    1 -
 arch/arm/mach-s3c24xx/mach-osiris.c           |    1 -
 arch/arm/mach-s3c24xx/mach-qt2410.c           |    1 -
 arch/arm/mach-s3c24xx/mach-rx1950.c           |    1 -
 arch/arm/mach-s3c24xx/mach-smdk2413.c         |    1 -
 arch/arm/mach-s3c24xx/mach-smdk2416.c         |    1 -
 arch/arm/mach-s3c24xx/mach-smdk2440.c         |    1 -
 arch/arm/mach-s3c24xx/mach-smdk2443.c         |    1 -
 arch/arm/mach-s3c24xx/mach-vstms.c            |    1 -
 drivers/video/s3c2410fb.c                     |    1 -
 include/linux/platform_data/fb-s3c2410.h      |   34 ++++++++++++++++
 22 files changed, 34 insertions(+), 72 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-lcd.h

diff --git a/arch/arm/mach-s3c24xx/dma-s3c2410.c b/arch/arm/mach-s3c24xx/dma-s3c2410.c
index a6c94b8..764556a 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2410.c
@@ -27,7 +27,6 @@
 #include <mach/regs-gpio.h>
 #include <plat/regs-ac97.h>
 #include <plat/regs-dma.h>
-#include <mach/regs-lcd.h>
 #include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
diff --git a/arch/arm/mach-s3c24xx/dma-s3c2412.c b/arch/arm/mach-s3c24xx/dma-s3c2412.c
index c0e8c3f..f02fc3c 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2412.c
@@ -27,7 +27,6 @@
 #include <mach/regs-gpio.h>
 #include <plat/regs-ac97.h>
 #include <plat/regs-dma.h>
-#include <mach/regs-lcd.h>
 #include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
diff --git a/arch/arm/mach-s3c24xx/dma-s3c2440.c b/arch/arm/mach-s3c24xx/dma-s3c2440.c
index 1c08eccd..b621563 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2440.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2440.c
@@ -27,7 +27,6 @@
 #include <mach/regs-gpio.h>
 #include <plat/regs-ac97.h>
 #include <plat/regs-dma.h>
-#include <mach/regs-lcd.h>
 #include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
diff --git a/arch/arm/mach-s3c24xx/dma-s3c2443.c b/arch/arm/mach-s3c24xx/dma-s3c2443.c
index 000e4c6..095e841 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2443.c
@@ -27,7 +27,6 @@
 #include <mach/regs-gpio.h>
 #include <plat/regs-ac97.h>
 #include <plat/regs-dma.h>
-#include <mach/regs-lcd.h>
 #include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-lcd.h b/arch/arm/mach-s3c24xx/include/mach/regs-lcd.h
deleted file mode 100644
index 369511f..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/regs-lcd.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-lcd.h
- *
- * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
- *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-
-#ifndef ___ASM_ARCH_REGS_LCD_H
-#define ___ASM_ARCH_REGS_LCD_H
-
-#define S3C2410_LCDCON1_MMODE	   (1<<7)
-#define S3C2410_LCDCON1_DSCAN4	   (0<<5)
-#define S3C2410_LCDCON1_STN4	   (1<<5)
-#define S3C2410_LCDCON1_STN8	   (2<<5)
-#define S3C2410_LCDCON1_TFT	   (3<<5)
-
-#define S3C2410_LCDCON1_STN1BPP	   (0<<1)
-#define S3C2410_LCDCON1_STN2GREY   (1<<1)
-#define S3C2410_LCDCON1_STN4GREY   (2<<1)
-#define S3C2410_LCDCON1_STN8BPP	   (3<<1)
-#define S3C2410_LCDCON1_STN12BPP   (4<<1)
-
-#define S3C2410_LCDCON1_TFT1BPP	   (8<<1)
-#define S3C2410_LCDCON1_TFT2BPP	   (9<<1)
-#define S3C2410_LCDCON1_TFT4BPP	   (10<<1)
-#define S3C2410_LCDCON1_TFT8BPP	   (11<<1)
-#define S3C2410_LCDCON1_TFT16BPP   (12<<1)
-#define S3C2410_LCDCON1_TFT24BPP   (13<<1)
-
-#define S3C2410_LCDCON1_ENVID	   (1)
-
-#define S3C2410_LCDCON1_MODEMASK    0x1E
-
-#define S3C2410_LCDCON5_BPP24BL	    (1<<12)
-#define S3C2410_LCDCON5_FRM565	    (1<<11)
-#define S3C2410_LCDCON5_INVVCLK	    (1<<10)
-#define S3C2410_LCDCON5_INVVLINE    (1<<9)
-#define S3C2410_LCDCON5_INVVFRAME   (1<<8)
-#define S3C2410_LCDCON5_INVVD	    (1<<7)
-#define S3C2410_LCDCON5_INVVDEN	    (1<<6)
-#define S3C2410_LCDCON5_INVPWREN    (1<<5)
-#define S3C2410_LCDCON5_INVLEND	    (1<<4)
-#define S3C2410_LCDCON5_PWREN	    (1<<3)
-#define S3C2410_LCDCON5_ENLEND	    (1<<2)
-#define S3C2410_LCDCON5_BSWP	    (1<<1)
-#define S3C2410_LCDCON5_HWSWP	    (1<<0)
-
-#endif /* ___ASM_ARCH_REGS_LCD_H */
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index c1fb6c3..d5e8cad 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -34,7 +34,6 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index e4d71d5..f151bf7 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -35,7 +35,6 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 4402741..a500b21 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -47,7 +47,6 @@
 #include <linux/platform_data/fb-s3c2410.h>
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 39ce53a..0236201 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -53,7 +53,6 @@
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 81e8e8c..d1347ec 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -36,7 +36,6 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 #include <linux/platform_data/fb-s3c2410.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index aa59f48..d0f25a4 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -40,7 +40,6 @@
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
 #include <linux/platform_data/leds-s3c24xx.h>
-#include <mach/regs-lcd.h>
 #include <mach/irqs.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 3a32a75..8b956b7 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -35,7 +35,6 @@
 #include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index 58d6fbe..eeca631 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -49,7 +49,6 @@
 
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 
 #include "common.h"
 #include "osiris.h"
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 65be582..7e11373 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -48,7 +48,6 @@
 #include <asm/mach-types.h>
 
 #include <linux/platform_data/leds-s3c24xx.h>
-#include <mach/regs-lcd.h>
 #include <plat/regs-serial.h>
 #include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 17fad4b..1ea1ce8 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -50,7 +50,6 @@
 
 #include <linux/platform_data/fb-s3c2410.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
index d504272..9b473cb 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2413.c
@@ -35,7 +35,6 @@
 //#include <asm/debug-ll.h>
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index cb46847..5630d51 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -36,7 +36,6 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 #include <mach/regs-s3c2443-clock.h>
 
 #include <linux/platform_data/leds-s3c24xx.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
index 8546941..040e39b 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2440.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2440.c
@@ -33,7 +33,6 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 
 #include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
index 5baa2e2..99a5c34 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2443.c
@@ -33,7 +33,6 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 
 #include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
index 86c9199..92cd9ec 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c24xx/mach-vstms.c
@@ -34,7 +34,6 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-lcd.h>
 
 #include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index dc10dbe..12ac94e 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -34,7 +34,6 @@
 
 #include <linux/platform_data/fb-s3c2410.h>
 #include <asm/mach/map.h>
-#include <mach/regs-lcd.h>
 #include <mach/regs-gpio.h>
 
 #ifdef CONFIG_PM
diff --git a/include/linux/platform_data/fb-s3c2410.h b/include/linux/platform_data/fb-s3c2410.h
index dbebc62..8e04d49 100644
--- a/include/linux/platform_data/fb-s3c2410.h
+++ b/include/linux/platform_data/fb-s3c2410.h
@@ -12,6 +12,40 @@
 #ifndef __FB_S3C2410_H
 #define __FB_S3C2410_H __FILE__
 
+#define S3C2410_LCDCON1_DSCAN4		(0 << 5)
+#define S3C2410_LCDCON1_STN4		(1 << 5)
+#define S3C2410_LCDCON1_STN8		(2 << 5)
+#define S3C2410_LCDCON1_TFT		(3 << 5)
+
+#define S3C2410_LCDCON1_STN1BPP		(0 << 1)
+#define S3C2410_LCDCON1_STN2GREY	(1 << 1)
+#define S3C2410_LCDCON1_STN4GREY	(2 << 1)
+#define S3C2410_LCDCON1_STN8BPP		(3 << 1)
+#define S3C2410_LCDCON1_STN12BPP	(4 << 1)
+
+#define S3C2410_LCDCON1_TFT1BPP		(8 << 1)
+#define S3C2410_LCDCON1_TFT2BPP		(9 << 1)
+#define S3C2410_LCDCON1_TFT4BPP		(10 << 1)
+#define S3C2410_LCDCON1_TFT8BPP		(11 << 1)
+#define S3C2410_LCDCON1_TFT16BPP	(12 << 1)
+#define S3C2410_LCDCON1_TFT24BPP	(13 << 1)
+
+
+#define S3C2410_LCDCON5_BPP24BL		(1 << 12)
+#define S3C2410_LCDCON5_FRM565		(1 << 11)
+#define S3C2410_LCDCON5_INVVCLK		(1 << 10)
+#define S3C2410_LCDCON5_INVVLINE	(1 << 9)
+#define S3C2410_LCDCON5_INVVFRAME	(1 << 8)
+#define S3C2410_LCDCON5_INVVD		(1 << 7)
+#define S3C2410_LCDCON5_INVVDEN		(1 << 6)
+#define S3C2410_LCDCON5_INVPWREN	(1 << 5)
+#define S3C2410_LCDCON5_INVLEND		(1 << 4)
+#define S3C2410_LCDCON5_PWREN		(1 << 3)
+#define S3C2410_LCDCON5_ENLEND		(1 << 2)
+#define S3C2410_LCDCON5_BSWP		(1 << 1)
+#define S3C2410_LCDCON5_HWSWP		(1 << 0)
+
+
 struct s3c2410fb_hw {
 	unsigned long	lcdcon1;
 	unsigned long	lcdcon2;
-- 
1.7.4.1

