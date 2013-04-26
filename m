From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Fri, 26 Apr 2013 20:02:15 +0000
Subject: [PATCH 1/9] s3c2410fb: Move platform data declarations to include/linux/platform_data
Message-Id: <1367006543-5458-2-git-send-email-sylvester.nawrocki@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
In-Reply-To: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Move the platform data structure declarations to include/linux/platform_data
where it's supposed to be placed, rather than in platform specific directories.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/mach-s3c24xx/include/mach/fb.h         |    1 -
 arch/arm/mach-s3c24xx/mach-at2440evb.c          |    2 +-
 arch/arm/mach-s3c24xx/mach-bast.c               |    2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-h1940.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-jive.c               |    2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c           |    2 +-
 arch/arm/mach-s3c24xx/mach-n30.c                |    2 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c             |    2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c             |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c           |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c           |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c           |    2 +-
 arch/arm/mach-s3c24xx/mach-vstms.c              |    3 +-
 arch/arm/plat-samsung/devs.c                    |    2 +-
 arch/arm/plat-samsung/include/plat/fb-s3c2410.h |   72 -----------------------
 drivers/video/s3c2410fb.c                       |    2 +-
 include/linux/platform_data/fb-s3c2410.h        |   72 +++++++++++++++++++++++
 18 files changed, 87 insertions(+), 89 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/fb.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/fb-s3c2410.h
 create mode 100644 include/linux/platform_data/fb-s3c2410.h

diff --git a/arch/arm/mach-s3c24xx/include/mach/fb.h b/arch/arm/mach-s3c24xx/include/mach/fb.h
deleted file mode 100644
index a957bc8e..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/fb.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <plat/fb-s3c2410.h>
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index 6dfeeb7..e4d71d5 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -29,7 +29,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 22d6ae9..4402741 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -44,7 +44,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 13d8d07..cdad542 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -71,7 +71,7 @@
 #include <linux/platform_data/usb-ohci-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-irq.h>
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index af4334d..39ce53a 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -49,7 +49,7 @@
 
 #include <sound/uda1380.h>
 
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index a45fcd8..81e8e8c 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -37,7 +37,7 @@
 
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index a83db46..aa59f48 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -34,7 +34,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/hardware.h>
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 #include <asm/mach-types.h>
 
 #include <plat/regs-serial.h>
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 2cb46c3..3a32a75 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -32,7 +32,7 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index f8feaea..65be582 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -50,7 +50,7 @@
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <mach/regs-lcd.h>
 #include <plat/regs-serial.h>
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index e4d67a3..17fad4b 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -48,7 +48,7 @@
 
 #include <sound/uda1380.h>
 
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
index 8146e92..d504272 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2413.c
@@ -39,7 +39,7 @@
 
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 
 #include <plat/clock.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
index de2e5d3..8546941 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2440.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2440.c
@@ -35,7 +35,7 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
 
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
index 9435c3b..5baa2e2 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2443.c
@@ -35,7 +35,7 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
 
-#include <mach/fb.h>
+#include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
index b665884..86c9199 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c24xx/mach-vstms.c
@@ -36,8 +36,7 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
 
-#include <mach/fb.h>
-
+#include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index e1124d9..33c39bb 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -50,7 +50,7 @@
 #include <linux/platform_data/ata-samsung_cf.h>
 #include <linux/platform_data/usb-ehci-s5p.h>
 #include <plat/fb.h>
-#include <plat/fb-s3c2410.h>
+#include <linux/platform_data/fb-s3c2410.h>
 #include <plat/hdmi.h>
 #include <linux/platform_data/hwmon-s3c.h>
 #include <linux/platform_data/i2c-s3c2410.h>
diff --git a/arch/arm/plat-samsung/include/plat/fb-s3c2410.h b/arch/arm/plat-samsung/include/plat/fb-s3c2410.h
deleted file mode 100644
index 4e5d958..0000000
--- a/arch/arm/plat-samsung/include/plat/fb-s3c2410.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/* arch/arm/plat-samsung/include/plat/fb-s3c2410.h
- *
- * Copyright (c) 2004 Arnaud Patard <arnaud.patard@rtp-net.org>
- *
- * Inspired by pxafb.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_PLAT_FB_S3C2410_H
-#define __ASM_PLAT_FB_S3C2410_H __FILE__
-
-struct s3c2410fb_hw {
-	unsigned long	lcdcon1;
-	unsigned long	lcdcon2;
-	unsigned long	lcdcon3;
-	unsigned long	lcdcon4;
-	unsigned long	lcdcon5;
-};
-
-/* LCD description */
-struct s3c2410fb_display {
-	/* LCD type */
-	unsigned type;
-
-	/* Screen size */
-	unsigned short width;
-	unsigned short height;
-
-	/* Screen info */
-	unsigned short xres;
-	unsigned short yres;
-	unsigned short bpp;
-
-	unsigned pixclock;		/* pixclock in picoseconds */
-	unsigned short left_margin;  /* value in pixels (TFT) or HCLKs (STN) */
-	unsigned short right_margin; /* value in pixels (TFT) or HCLKs (STN) */
-	unsigned short hsync_len;    /* value in pixels (TFT) or HCLKs (STN) */
-	unsigned short upper_margin;	/* value in lines (TFT) or 0 (STN) */
-	unsigned short lower_margin;	/* value in lines (TFT) or 0 (STN) */
-	unsigned short vsync_len;	/* value in lines (TFT) or 0 (STN) */
-
-	/* lcd configuration registers */
-	unsigned long	lcdcon5;
-};
-
-struct s3c2410fb_mach_info {
-
-	struct s3c2410fb_display *displays;	/* attached diplays info */
-	unsigned num_displays;			/* number of defined displays */
-	unsigned default_display;
-
-	/* GPIOs */
-
-	unsigned long	gpcup;
-	unsigned long	gpcup_mask;
-	unsigned long	gpccon;
-	unsigned long	gpccon_mask;
-	unsigned long	gpdup;
-	unsigned long	gpdup_mask;
-	unsigned long	gpdcon;
-	unsigned long	gpdcon_mask;
-
-	/* lpc3600 control register */
-	unsigned long	lpcsel;
-};
-
-extern void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *);
-
-#endif /* __ASM_PLAT_FB_S3C2410_H */
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 76a0e7f..dc10dbe 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -32,10 +32,10 @@
 
 #include <asm/div64.h>
 
+#include <linux/platform_data/fb-s3c2410.h>
 #include <asm/mach/map.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-gpio.h>
-#include <mach/fb.h>
 
 #ifdef CONFIG_PM
 #include <linux/pm.h>
diff --git a/include/linux/platform_data/fb-s3c2410.h b/include/linux/platform_data/fb-s3c2410.h
new file mode 100644
index 0000000..dbebc62
--- /dev/null
+++ b/include/linux/platform_data/fb-s3c2410.h
@@ -0,0 +1,72 @@
+/* arch/arm/plat-samsung/include/plat/fb-s3c2410.h
+ *
+ * Copyright (c) 2004 Arnaud Patard <arnaud.patard@rtp-net.org>
+ *
+ * Inspired by pxafb.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __FB_S3C2410_H
+#define __FB_S3C2410_H __FILE__
+
+struct s3c2410fb_hw {
+	unsigned long	lcdcon1;
+	unsigned long	lcdcon2;
+	unsigned long	lcdcon3;
+	unsigned long	lcdcon4;
+	unsigned long	lcdcon5;
+};
+
+/* LCD description */
+struct s3c2410fb_display {
+	/* LCD type */
+	unsigned type;
+
+	/* Screen size */
+	unsigned short width;
+	unsigned short height;
+
+	/* Screen info */
+	unsigned short xres;
+	unsigned short yres;
+	unsigned short bpp;
+
+	unsigned pixclock;		/* pixclock in picoseconds */
+	unsigned short left_margin;  /* value in pixels (TFT) or HCLKs (STN) */
+	unsigned short right_margin; /* value in pixels (TFT) or HCLKs (STN) */
+	unsigned short hsync_len;    /* value in pixels (TFT) or HCLKs (STN) */
+	unsigned short upper_margin;	/* value in lines (TFT) or 0 (STN) */
+	unsigned short lower_margin;	/* value in lines (TFT) or 0 (STN) */
+	unsigned short vsync_len;	/* value in lines (TFT) or 0 (STN) */
+
+	/* lcd configuration registers */
+	unsigned long	lcdcon5;
+};
+
+struct s3c2410fb_mach_info {
+
+	struct s3c2410fb_display *displays;	/* attached diplays info */
+	unsigned num_displays;			/* number of defined displays */
+	unsigned default_display;
+
+	/* GPIOs */
+
+	unsigned long	gpcup;
+	unsigned long	gpcup_mask;
+	unsigned long	gpccon;
+	unsigned long	gpccon_mask;
+	unsigned long	gpdup;
+	unsigned long	gpdup_mask;
+	unsigned long	gpdcon;
+	unsigned long	gpdcon_mask;
+
+	/* lpc3600 control register */
+	unsigned long	lpcsel;
+};
+
+extern void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *);
+
+#endif /* __FB_S3C2410_H */
-- 
1.7.4.1

