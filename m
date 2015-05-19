From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2015 12:17:23 +0000
Subject: [PATCH] video: exynos: fix modular build
Message-Id: <2708563.ADEZz3igC5@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The s6e8ax0 driver has a dependency on BACKLIGHT_CLASS_DEVICE,
which can be configured as a loadable module, so we have to
make the driver a tristate symbol as well, to avoid this error:

drivers/built-in.o: In function `s6e8ax0_probe':
:(.text+0x23a48): undefined reference to `devm_backlight_device_register'

This also means we get another error from a missing export, which
this fixes as well:

ERROR: "exynos_mipi_dsi_register_lcd_driver" [drivers/video/fbdev/exynos/s6e8ax0.ko] undefined!

Finally, the EXYNOS_VIDEO option is turned into tristate as well
for good measure, as all framebuffer drivers should be configurable
as modules.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/video/fbdev/exynos/Kconfig b/drivers/video/fbdev/exynos/Kconfig
index 1f16b4678c71..d916bef94f25 100644
--- a/drivers/video/fbdev/exynos/Kconfig
+++ b/drivers/video/fbdev/exynos/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig EXYNOS_VIDEO
-	bool "Exynos Video driver support"
+	tristate "Exynos Video driver support"
 	depends on ARCH_S5PV210 || ARCH_EXYNOS
 	help
 	  This enables support for EXYNOS Video device.
@@ -15,13 +15,13 @@ if EXYNOS_VIDEO
 #
 
 config EXYNOS_MIPI_DSI
-	bool "EXYNOS MIPI DSI driver support."
+	tristate "EXYNOS MIPI DSI driver support."
 	select GENERIC_PHY
 	help
 	  This enables support for MIPI-DSI device.
 
 config EXYNOS_LCD_S6E8AX0
-	bool "S6E8AX0 MIPI AMOLED LCD Driver"
+	tristate "S6E8AX0 MIPI AMOLED LCD Driver"
 	depends on EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE
 	depends on (LCD_CLASS_DEVICE = y)
 	default n
diff --git a/drivers/video/fbdev/exynos/Makefile b/drivers/video/fbdev/exynos/Makefile
index b5b1bd228abb..02d8dc522fea 100644
--- a/drivers/video/fbdev/exynos/Makefile
+++ b/drivers/video/fbdev/exynos/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the exynos video drivers.
 #
 
-obj-$(CONFIG_EXYNOS_MIPI_DSI)		+= exynos_mipi_dsi.o exynos_mipi_dsi_common.o \
-				     	exynos_mipi_dsi_lowlevel.o
+obj-$(CONFIG_EXYNOS_MIPI_DSI)		+= exynos-mipi-dsi-mod.o
+
+exynos-mipi-dsi-mod-objs		+= exynos_mipi_dsi.o exynos_mipi_dsi_common.o \
+					   exynos_mipi_dsi_lowlevel.o
 obj-$(CONFIG_EXYNOS_LCD_S6E8AX0)	+= s6e8ax0.o
diff --git a/drivers/video/fbdev/exynos/exynos_mipi_dsi.c b/drivers/video/fbdev/exynos/exynos_mipi_dsi.c
index b527fe464628..18edc724bf57 100644
--- a/drivers/video/fbdev/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/fbdev/exynos/exynos_mipi_dsi.c
@@ -263,6 +263,7 @@ int exynos_mipi_dsi_register_lcd_driver(struct mipi_dsim_lcd_driver *lcd_drv)
 	return 0;
 
 }
+EXPORT_SYMBOL_GPL(exynos_mipi_dsi_register_lcd_driver);
 
 static struct mipi_dsim_ddi *exynos_mipi_dsi_bind_lcd_ddi(
 						struct mipi_dsim_device *dsim,

