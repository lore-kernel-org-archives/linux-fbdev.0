From: Pawel Osciak <p.osciak@samsung.com>
Date: Mon, 28 Jun 2010 08:08:50 +0000
Subject: [PATCH v3 04/12] s3c-fb: Add device name initialization
Message-Id: <1277712538-23188-5-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add framebuffer device name initialization calls for S3C2443, S3C64xx
and S5P machines.

Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s3c2416/s3c2416.c              |    3 +-
 arch/arm/mach-s3c2443/s3c2443.c              |    2 +
 arch/arm/mach-s5pc100/cpu.c                  |    3 ++
 arch/arm/mach-s5pv210/cpu.c                  |    7 ++---
 arch/arm/plat-samsung/include/plat/fb-core.h |   29 ++++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/fb-core.h

diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index 35dabcc..bc30245 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -55,6 +55,7 @@
 #include <plat/cpu.h>
 
 #include <plat/iic-core.h>
+#include <plat/fb-core.h>
 
 static struct map_desc s3c2416_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
@@ -90,7 +91,7 @@ int __init s3c2416_init(void)
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
 
-	s3c_device_fb.name = "s3c2443-fb";
+	s3c_fb_setname("s3c2443-fb");
 
 	return sysdev_register(&s3c2416_sysdev);
 }
diff --git a/arch/arm/mach-s3c2443/s3c2443.c b/arch/arm/mach-s3c2443/s3c2443.c
index ce2ec32..839b6b2 100644
--- a/arch/arm/mach-s3c2443/s3c2443.c
+++ b/arch/arm/mach-s3c2443/s3c2443.c
@@ -35,6 +35,7 @@
 #include <plat/s3c2443.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/fb-core.h>
 
 static struct map_desc s3c2443_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
@@ -62,6 +63,7 @@ int __init s3c2443_init(void)
 	s3c24xx_reset_hook = s3c2443_hard_reset;
 
 	s3c_device_nand.name = "s3c2412-nand";
+	s3c_fb_setname("s3c2443-fb");
 
 	/* change WDT IRQ number */
 	s3c_device_wdt.resource[1].start = IRQ_S3C2443_WDT;
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index 7b5bdbc..d10276a 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -41,6 +41,7 @@
 #include <plat/iic-core.h>
 #include <plat/sdhci.h>
 #include <plat/onenand-core.h>
+#include <plat/fb-core.h>
 
 #include <plat/s5pc100.h>
 
@@ -92,6 +93,8 @@ void __init s5pc100_map_io(void)
 	s3c_i2c1_setname("s3c2440-i2c");
 
 	s3c_onenand_setname("s5pc100-onenand");
+
+	s3c_fb_setname("s5pc100-fb");
 }
 
 void __init s5pc100_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index f42c507..4d3580a 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -34,6 +34,7 @@
 #include <plat/s5pv210.h>
 #include <plat/iic-core.h>
 #include <plat/sdhci.h>
+#include <plat/fb-core.h>
 
 /* Initial IO mappings */
 
@@ -80,10 +81,6 @@ void __init s5pv210_map_io(void)
 	s3c_device_adc.name	= "s3c64xx-adc";
 #endif
 
-#ifdef CONFIG_S3C_DEV_FB
-	s3c_device_fb.name	= "s5p-fb";
-#endif
-
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
 
 	/* initialise device information early */
@@ -95,6 +92,8 @@ void __init s5pv210_map_io(void)
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
 	s3c_i2c2_setname("s3c2440-i2c");
+
+	s3c_fb_setname("s5pv210-fb");
 }
 
 void __init s5pv210_init_clocks(int xtal)
diff --git a/arch/arm/plat-samsung/include/plat/fb-core.h b/arch/arm/plat-samsung/include/plat/fb-core.h
new file mode 100644
index 0000000..bca383e
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/fb-core.h
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/plat-samsung/include/plat/fb-core.h
+ *
+ * Copyright 2010 Samsung Electronics Co., Ltd.
+ *	Pawel Osciak <p.osciak@samsung.com>
+ *
+ * Samsung framebuffer driver core functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_PLAT_FB_CORE_H
+#define __ASM_PLAT_FB_CORE_H __FILE__
+
+/*
+ * These functions are only for use with the core support code, such as
+ * the CPU-specific initialization code.
+ */
+
+/* Re-define device name depending on support. */
+static inline void s3c_fb_setname(char *name)
+{
+#ifdef CONFIG_S3C_DEV_FB
+	s3c_device_fb.name = name;
+#endif
+}
+
+#endif /* __ASM_PLAT_FB_CORE_H */
-- 
1.7.1.569.g6f426

