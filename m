From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jul 2014 08:39:57 +0000
Subject: PATCH] video: fix up versatile CLCD helper move
Message-Id: <9561883.zqovrcBa4A@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

commit 11c32d7b6274cb0f ("video: move Versatile CLCD helpers")
moved files out of the plat-versatile directory but in the process
got a few of the dependencies wrong:

- If CONFIG_FB is not set, the file no longer gets built, resulting
  in a link error
- If CONFIG_FB or CONFIG_FB_ARMCLCD are disabled, we also get a
  Kconfig warning for incorrect dependencies due to the symbol
  being 'select'ed from the platform Kconfig.
- When the file is not built, we also get a link error for missing
  symbols.

This patch should fix all three, by removing the 'select' statements,
changing the Kconfig description of the symbol to be enabled in
exactly the right configurations, and adding inline stub functions
for the case when the framebuffer driver is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fceb014c54a1..76e0d6752bd8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -336,7 +336,6 @@ config ARCH_VERSATILE
 	select HAVE_MACH_CLKDEV
 	select ICST
 	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLCD
 	select PLAT_VERSATILE_CLOCK
 	select VERSATILE_FPGA_IRQ
 	help
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 3b02ba4e7094..4b7649d59bf6 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -9,7 +9,6 @@ config ARCH_REALVIEW
 	select GPIO_PL061 if GPIOLIB
 	select ICST
 	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLCD
 	help
 	  This enables support for ARM Ltd RealView boards.
 
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index d8b9330f896a..e9166dfc4756 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -13,7 +13,6 @@ menuconfig ARCH_VEXPRESS
 	select ICST
 	select NO_IOPORT_MAP
 	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLCD
 	select POWER_RESET
 	select POWER_RESET_VEXPRESS
 	select POWER_SUPPLY
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e2dd9b493580..a16efe729988 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -292,10 +292,8 @@ config FB_ARMCLCD
 
 # Helper logic selected only by the ARM Versatile platform family.
 config PLAT_VERSATILE_CLCD
-	depends on FB_ARMCLCD
-	depends on (PLAT_VERSATILE || ARCH_INTEGRATOR)
-	default y
-	bool
+	def_bool ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS
+	depends on FB_ARMCLCD && FB=y
 
 config FB_ACORN
 	bool "Acorn VIDC support"
diff --git a/include/linux/platform_data/video-clcd-versatile.h b/include/linux/platform_data/video-clcd-versatile.h
index 6bb6a1d2019b..09ccf182af4d 100644
--- a/include/linux/platform_data/video-clcd-versatile.h
+++ b/include/linux/platform_data/video-clcd-versatile.h
@@ -1,9 +1,27 @@
 #ifndef PLAT_CLCD_H
 #define PLAT_CLCD_H
 
+#ifdef CONFIG_PLAT_VERSATILE_CLCD
 struct clcd_panel *versatile_clcd_get_panel(const char *);
 int versatile_clcd_setup_dma(struct clcd_fb *, unsigned long);
 int versatile_clcd_mmap_dma(struct clcd_fb *, struct vm_area_struct *);
 void versatile_clcd_remove_dma(struct clcd_fb *);
+#else
+static inline struct clcd_panel *versatile_clcd_get_panel(const char *s)
+{
+	return NULL;
+}
+static inline int versatile_clcd_setup_dma(struct clcd_fb *fb, unsigned long framesize)
+{
+	return -ENODEV;
+}
+static inline int versatile_clcd_mmap_dma(struct clcd_fb *fb, struct vm_area_struct *vm)
+{
+	return -ENODEV;
+}
+static inline void versatile_clcd_remove_dma(struct clcd_fb *fb)
+{
+}
+#endif
 
 #endif

