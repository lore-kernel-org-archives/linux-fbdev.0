From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 26 Feb 2016 12:38:08 +0000
Subject: [PATCH v2] video: exynos: fix modular build
Message-Id: <1456490307-823812-1-git-send-email-arnd@arndb.de>
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

The drivers are all written to be loadable modules already,
except the Kconfig options for that are missing, which makes
the patch really easy.

Finally, the EXYNOS_VIDEO option is turned into tristate as well
for good measure, as all framebuffer drivers should be configurable
as modules, though this change is not strictly necessary.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/video/fbdev/exynos/Kconfig           | 6 +++---
 drivers/video/fbdev/exynos/Makefile          | 6 ++++--
 drivers/video/fbdev/exynos/exynos_mipi_dsi.c | 1 +
 3 files changed, 8 insertions(+), 5 deletions(-)

v2: improved changelog after feedback from Paul Bolle

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
index 951b592794e3..92e4af3caaf8 100644
--- a/drivers/video/fbdev/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/fbdev/exynos/exynos_mipi_dsi.c
@@ -263,6 +263,7 @@ int exynos_mipi_dsi_register_lcd_driver(struct mipi_dsim_lcd_driver *lcd_drv)
 	return 0;
 
 }
+EXPORT_SYMBOL_GPL(exynos_mipi_dsi_register_lcd_driver);
 
 static struct mipi_dsim_ddi *exynos_mipi_dsi_bind_lcd_ddi(
 						struct mipi_dsim_device *dsim,
-- 
2.7.0

