From: Alexander Shiyan <shc_work@mail.ru>
Date: Fri, 14 Mar 2014 10:41:50 +0000
Subject: [PATCH] video: lcd: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol
Message-Id: <1394793710-31203-1-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Symbol BACKLIGHT_LCD_SUPPORT affecting anything, except enabling
the backlight & LCD Kconfig menu. Patch removes this symbol as useless.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/unicore32/Kconfig          |  1 -
 drivers/gpu/drm/i915/Kconfig    |  1 -
 drivers/gpu/drm/nouveau/Kconfig |  1 -
 drivers/gpu/drm/tilcdc/Kconfig  |  1 -
 drivers/platform/x86/Kconfig    |  1 -
 drivers/usb/misc/Kconfig        |  1 -
 drivers/video/backlight/Kconfig | 39 +++++++++++++--------------------------
 drivers/video/fbdev/Kconfig     |  1 -
 8 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 25c0dba..ccb3f01 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -237,7 +237,6 @@ config I2C_EEPROM_AT24
 
 config LCD_BACKLIGHT
 	tristate "LCD Backlight support"
-	select BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_PWM
 
 endmenu
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 73ed59e..cd4b3c0 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -12,7 +12,6 @@ config DRM_I915
 	select DRM_KMS_HELPER
 	# i915 depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_LCD_SUPPORT if ACPI
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select VIDEO_OUTPUT_CONTROL if ACPI
 	select INPUT if ACPI
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 7cf787d..c6f04e2 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -17,7 +17,6 @@ config DRM_NOUVEAU
 	select MXM_WMI if ACPI && X86
 	select POWER_SUPPLY
 	# Similar to i915, we need to select ACPI_VIDEO and it's dependencies
-	select BACKLIGHT_LCD_SUPPORT if ACPI && X86
 	select BACKLIGHT_CLASS_DEVICE if ACPI && X86
 	select VIDEO_OUTPUT_CONTROL if ACPI && X86
 	select INPUT if ACPI && X86
diff --git a/drivers/gpu/drm/tilcdc/Kconfig b/drivers/gpu/drm/tilcdc/Kconfig
index 7c3ef79..fb5f1c6 100644
--- a/drivers/gpu/drm/tilcdc/Kconfig
+++ b/drivers/gpu/drm/tilcdc/Kconfig
@@ -7,7 +7,6 @@ config DRM_TILCDC
 	select DRM_GEM_CMA_HELPER
 	select VIDEOMODE_HELPERS
 	select BACKLIGHT_CLASS_DEVICE
-	select BACKLIGHT_LCD_SUPPORT
 	help
 	  Choose this option if you have an TI SoC with LCDC display
 	  controller, for example AM33xx in beagle-bone, DA8xx, or
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 5ae65c1..f1dc7ae 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -311,7 +311,6 @@ config THINKPAD_ACPI
 	depends on ACPI
 	depends on INPUT
 	depends on RFKILL || RFKILL = n
-	select BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	select NVRAM
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 1bca274..3bc6333 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -150,7 +150,6 @@ config USB_FTDI_ELAN
 
 config USB_APPLEDISPLAY
 	tristate "Apple Cinema Display support"
-	select BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y here if you want to control the backlight of Apple Cinema
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 5a3eb2e..6c37268 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -2,20 +2,13 @@
 # Backlight & LCD drivers configuration
 #
 
-menuconfig BACKLIGHT_LCD_SUPPORT
-	bool "Backlight & LCD device support"
-	help
-	  Enable this to be able to choose the drivers for controlling the
-	  backlight and the LCD panel on some platforms, for example on PDAs.
-
-if BACKLIGHT_LCD_SUPPORT
+menu "Backlight & LCD device support"
 
 #
 # LCD
 #
 config LCD_CLASS_DEVICE
         tristate "Lowlevel LCD controls"
-	default m
 	help
 	  This framework adds support for low-level control of LCD.
 	  Some framebuffer devices connect to platform-specific LCD modules
@@ -112,7 +105,6 @@ config LCD_HP700
 config LCD_S6E63M0
 	tristate "S6E63M0 AMOLED LCD Driver"
 	depends on SPI && BACKLIGHT_CLASS_DEVICE
-	default n
 	help
 	  If you have an S6E63M0 LCD Panel, say Y to enable its
 	  LCD control driver.
@@ -120,7 +112,6 @@ config LCD_S6E63M0
 config LCD_LD9040
 	tristate "LD9040 AMOLED LCD Driver"
 	depends on SPI && BACKLIGHT_CLASS_DEVICE
-	default n
 	help
 	  If you have an LD9040 Panel, say Y to enable its
 	  control driver.
@@ -128,7 +119,6 @@ config LCD_LD9040
 config LCD_AMS369FG06
 	tristate "AMS369FG06 AMOLED LCD Driver"
 	depends on SPI && BACKLIGHT_CLASS_DEVICE
-	default n
 	help
 	  If you have an AMS369FG06 AMOLED Panel, say Y to enable its
 	  LCD control driver.
@@ -136,7 +126,6 @@ config LCD_AMS369FG06
 config LCD_LMS501KF03
 	tristate "LMS501KF03 LCD Driver"
 	depends on SPI
-	default n
 	help
 	  If you have an LMS501KF03 LCD Panel, say Y to enable its
 	  LCD control driver.
@@ -155,7 +144,6 @@ endif # LCD_CLASS_DEVICE
 #
 config BACKLIGHT_CLASS_DEVICE
         tristate "Lowlevel Backlight controls"
-	default m
 	help
 	  This framework adds support for low-level control of the LCD
           backlight. This includes support for brightness and power.
@@ -209,7 +197,6 @@ config BACKLIGHT_GENERIC
 
 config BACKLIGHT_LM3533
 	tristate "Backlight Driver for LM3533"
-	depends on BACKLIGHT_CLASS_DEVICE
 	depends on MFD_LM3533
 	help
 	  Say Y to enable the backlight driver for National Semiconductor / TI
@@ -326,7 +313,7 @@ config BACKLIGHT_ADP5520
 
 config BACKLIGHT_ADP8860
 	tristate "Backlight Driver for ADP8860/ADP8861/ADP8863 using WLED"
-	depends on BACKLIGHT_CLASS_DEVICE && I2C
+	depends on I2C
 	select NEW_LEDS
 	select LEDS_CLASS
 	help
@@ -338,7 +325,7 @@ config BACKLIGHT_ADP8860
 
 config BACKLIGHT_ADP8870
 	tristate "Backlight Driver for ADP8870 using WLED"
-	depends on BACKLIGHT_CLASS_DEVICE && I2C
+	depends on I2C
 	select NEW_LEDS
 	select LEDS_CLASS
 	help
@@ -356,28 +343,28 @@ config BACKLIGHT_88PM860X
 
 config BACKLIGHT_PCF50633
 	tristate "Backlight driver for NXP PCF50633 MFD"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_PCF50633
+	depends on MFD_PCF50633
 	help
 	  If you have a backlight driven by a NXP PCF50633 MFD, say Y here to
 	  enable its driver.
 
 config BACKLIGHT_AAT2870
 	tristate "AnalogicTech AAT2870 Backlight"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_AAT2870_CORE
+	depends on MFD_AAT2870_CORE
 	help
 	  If you have a AnalogicTech AAT2870 say Y to enable the
 	  backlight driver.
 
 config BACKLIGHT_LM3630A
 	tristate "Backlight Driver for LM3630A"
-	depends on BACKLIGHT_CLASS_DEVICE && I2C
+	depends on I2C
 	select REGMAP_I2C
 	help
 	  This supports TI LM3630A Backlight Driver
 
 config BACKLIGHT_LM3639
 	tristate "Backlight Driver for LM3639"
-	depends on BACKLIGHT_CLASS_DEVICE && I2C
+	depends on I2C
 	select REGMAP_I2C
 	select NEW_LEDS
 	select LEDS_CLASS
@@ -386,20 +373,20 @@ config BACKLIGHT_LM3639
 
 config BACKLIGHT_LP855X
 	tristate "Backlight driver for TI LP855X"
-	depends on BACKLIGHT_CLASS_DEVICE && I2C
+	depends on I2C
 	help
 	  This supports TI LP8550, LP8551, LP8552, LP8553, LP8555, LP8556 and
 	  LP8557 backlight driver.
 
 config BACKLIGHT_LP8788
 	tristate "Backlight driver for TI LP8788 MFD"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_LP8788
+	depends on MFD_LP8788
 	help
 	  This supports TI LP8788 backlight driver.
 
 config BACKLIGHT_OT200
 	tristate "Backlight driver for ot200 visualisation device"
-	depends on BACKLIGHT_CLASS_DEVICE && CS5535_MFGPT && GPIO_CS5535
+	depends on CS5535_MFGPT && GPIO_CS5535
 	help
 	  To compile this driver as a module, choose M here: the module will be
 	  called ot200_bl.
@@ -413,14 +400,14 @@ config BACKLIGHT_PANDORA
 
 config BACKLIGHT_TPS65217
 	tristate "TPS65217 Backlight"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_TPS65217
+	depends on MFD_TPS65217
 	help
 	  If you have a Texas Instruments TPS65217 say Y to enable the
 	  backlight driver.
 
 config BACKLIGHT_AS3711
 	tristate "AS3711 Backlight"
-	depends on BACKLIGHT_CLASS_DEVICE && MFD_AS3711
+	depends on MFD_AS3711
 	help
 	  If you have an Austrian Microsystems AS3711 say Y to enable the
 	  backlight driver.
@@ -446,4 +433,4 @@ config BACKLIGHT_BD6107
 
 endif # BACKLIGHT_CLASS_DEVICE
 
-endif # BACKLIGHT_LCD_SUPPORT
+endmenu
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 67409e0..dede128 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -184,7 +184,6 @@ config FB_MACMODES
 config FB_BACKLIGHT
 	bool
 	depends on FB
-	select BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	default n
 
-- 
1.8.3.2

