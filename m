From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 15:40:01 +0000
Subject: [PATCH] video: fbdev: remove redundant 'default n' from Kconfig-s
Message-Id: <20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449~brFqL1l6v1788017880eucas1p1O@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig                  |   28 ---------------------------
 drivers/video/fbdev/mmp/hw/Kconfig           |    1 
 drivers/video/fbdev/mmp/panel/Kconfig        |    1 
 drivers/video/fbdev/omap2/omapfb/dss/Kconfig |    7 ------
 4 files changed, 37 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig	2018-10-08 16:33:37.571968486 +0200
+++ b/drivers/video/fbdev/Kconfig	2018-10-08 17:21:23.632040663 +0200
@@ -47,7 +47,6 @@ menuconfig FB
 config FIRMWARE_EDID
        bool "Enable firmware EDID"
        depends on FB
-       default n
        ---help---
          This enables access to the EDID transferred from the firmware.
 	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
@@ -65,12 +64,10 @@ config FB_DDC
        depends on FB
        select I2C_ALGOBIT
        select I2C
-       default n
 
 config FB_BOOT_VESA_SUPPORT
 	bool
 	depends on FB
-	default n
 	---help---
 	  If true, at least one selected framebuffer driver can take advantage
 	  of VESA video modes set at an early boot stage via the vga= parameter.
@@ -78,7 +75,6 @@ config FB_BOOT_VESA_SUPPORT
 config FB_CFB_FILLRECT
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the cfb_fillrect function for generic software rectangle
 	  filling. This is used by drivers that don't provide their own
@@ -87,7 +83,6 @@ config FB_CFB_FILLRECT
 config FB_CFB_COPYAREA
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the cfb_copyarea function for generic software area copying.
 	  This is used by drivers that don't provide their own (accelerated)
@@ -96,7 +91,6 @@ config FB_CFB_COPYAREA
 config FB_CFB_IMAGEBLIT
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the cfb_imageblit function for generic software image
 	  blitting. This is used by drivers that don't provide their own
@@ -105,7 +99,6 @@ config FB_CFB_IMAGEBLIT
 config FB_CFB_REV_PIXELS_IN_BYTE
 	bool
 	depends on FB
-	default n
 	---help---
 	  Allow generic frame-buffer functions to work on displays with 1, 2
 	  and 4 bits per pixel depths which has opposite order of pixels in
@@ -114,7 +107,6 @@ config FB_CFB_REV_PIXELS_IN_BYTE
 config FB_SYS_FILLRECT
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the sys_fillrect function for generic software rectangle
 	  filling. This is used by drivers that don't provide their own
@@ -123,7 +115,6 @@ config FB_SYS_FILLRECT
 config FB_SYS_COPYAREA
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the sys_copyarea function for generic software area copying.
 	  This is used by drivers that don't provide their own (accelerated)
@@ -132,7 +123,6 @@ config FB_SYS_COPYAREA
 config FB_SYS_IMAGEBLIT
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Include the sys_imageblit function for generic software image
 	  blitting. This is used by drivers that don't provide their own
@@ -141,7 +131,6 @@ config FB_SYS_IMAGEBLIT
 config FB_PROVIDE_GET_FB_UNMAPPED_AREA
 	bool
 	depends on FB
-	default n
 	---help---
 	  Allow generic frame-buffer to provide get_fb_unmapped_area
 	  function.
@@ -173,7 +162,6 @@ endchoice
 config FB_SYS_FOPS
        tristate
        depends on FB
-       default n
 
 config FB_DEFERRED_IO
 	bool
@@ -187,7 +175,6 @@ config FB_HECUBA
 config FB_SVGALIB
 	tristate
 	depends on FB
-	default n
 	---help---
 	  Common utility functions useful to fbdev drivers of VGA-based
 	  cards.
@@ -195,19 +182,16 @@ config FB_SVGALIB
 config FB_MACMODES
        tristate
        depends on FB
-       default n
 
 config FB_BACKLIGHT
 	bool
 	depends on FB
 	select BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
-	default n
 
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"
         depends on FB
-	default n
 	---help---
 	  This enables functions for handling video modes using the
 	  Generalized Timing Formula and the EDID parser. A few drivers rely
@@ -218,7 +202,6 @@ config FB_MODE_HELPERS
 config FB_TILEBLITTING
        bool "Enable Tile Blitting Support"
        depends on FB
-       default n
        ---help---
          This enables tile blitting.  Tile blitting is a drawing technique
 	 where the screen is divided into rectangular sections (tiles), whereas
@@ -929,7 +912,6 @@ config FB_NVIDIA_I2C
 config FB_NVIDIA_DEBUG
 	bool "Lots of debug output"
 	depends on FB_NVIDIA
-	default n
 	help
 	  Say Y here if you want the nVidia driver to output all sorts
 	  of debugging information to provide to the maintainer when
@@ -976,7 +958,6 @@ config FB_RIVA_I2C
 config FB_RIVA_DEBUG
 	bool "Lots of debug output"
 	depends on FB_RIVA
-	default n
 	help
 	  Say Y here if you want the Riva driver to output all sorts
 	  of debugging information to provide to the maintainer when
@@ -1259,7 +1240,6 @@ config FB_RADEON_BACKLIGHT
 config FB_RADEON_DEBUG
 	bool "Lots of debug output from Radeon driver"
 	depends on FB_RADEON
-	default n
 	help
 	  Say Y here if you want the Radeon driver to output all sorts
 	  of debugging information to provide to the maintainer when
@@ -1392,7 +1372,6 @@ config FB_SAVAGE_I2C
 config FB_SAVAGE_ACCEL
        bool "Enable Console Acceleration"
        depends on FB_SAVAGE
-       default n
        help
           This option will compile in console acceleration support. If
           the resulting framebuffer console has bothersome glitches, then
@@ -1449,7 +1428,6 @@ if FB_VIA
 
 config FB_VIA_DIRECT_PROCFS
 	bool "direct hardware access via procfs (DEPRECATED)(DANGEROUS)"
-	default n
 	help
 	  Allow direct hardware access to some output registers via procfs.
 	  This is dangerous but may provide the only chance to get the
@@ -1458,7 +1436,6 @@ config FB_VIA_DIRECT_PROCFS
 
 config FB_VIA_X_COMPATIBILITY
 	bool "X server compatibility"
-	default n
 	help
 	  This option reduces the functionality (power saving, ...) of the
 	  framebuffer to avoid negative impact on the OpenChrome X server.
@@ -1683,7 +1660,6 @@ config FB_WM8505
 config FB_WMT_GE_ROPS
 	bool "VT8500/WM8xxx accelerated raster ops support"
 	depends on (FB = y) && (FB_VT8500 || FB_WM8505)
-	default n
 	help
 	  This adds support for accelerated raster operations on the
 	  VIA VT8500 and Wondermedia 85xx series SoCs.
@@ -1793,17 +1769,14 @@ config FB_PXA
 
 config FB_PXA_OVERLAY
 	bool "Support PXA27x/PXA3xx Overlay(s) as framebuffer"
-	default n
 	depends on FB_PXA && (PXA27x || PXA3xx)
 
 config FB_PXA_SMARTPANEL
 	bool "PXA Smartpanel LCD support"
-	default n
 	depends on FB_PXA
 
 config FB_PXA_PARAMETERS
 	bool "PXA LCD command line parameters"
-	default n
 	depends on FB_PXA
 	---help---
 	  Enable the use of kernel command line or module parameters
@@ -1841,7 +1814,6 @@ config FB_MBX
 config FB_MBX_DEBUG
        bool "Enable debugging info via debugfs"
        depends on FB_MBX && DEBUG_FS
-       default n
        ---help---
          Enable this if you want debugging information using the debug
          filesystem (debugfs)
Index: b/drivers/video/fbdev/mmp/hw/Kconfig
=================================--- a/drivers/video/fbdev/mmp/hw/Kconfig	2018-09-03 18:11:52.745791712 +0200
+++ b/drivers/video/fbdev/mmp/hw/Kconfig	2018-10-08 17:21:32.772040893 +0200
@@ -3,7 +3,6 @@ if MMP_DISP
 config MMP_DISP_CONTROLLER
 	bool "mmp display controller hw support"
 	depends on CPU_PXA910 || CPU_MMP2
-	default n
 	help
 		Marvell MMP display hw controller support
 		this controller is used on Marvell PXA910 and
Index: b/drivers/video/fbdev/mmp/panel/Kconfig
=================================--- a/drivers/video/fbdev/mmp/panel/Kconfig	2018-09-03 18:11:52.745791712 +0200
+++ b/drivers/video/fbdev/mmp/panel/Kconfig	2018-10-08 17:21:39.280041057 +0200
@@ -2,6 +2,5 @@
 config MMP_PANEL_TPOHVGA
 	bool "tpohvga panel TJ032MD01BW support"
 	depends on SPI_MASTER
-	default n
 	help
 		tpohvga panel support
Index: b/drivers/video/fbdev/omap2/omapfb/dss/Kconfig
=================================--- a/drivers/video/fbdev/omap2/omapfb/dss/Kconfig	2018-09-03 18:11:52.749791711 +0200
+++ b/drivers/video/fbdev/omap2/omapfb/dss/Kconfig	2018-10-08 17:22:02.768041649 +0200
@@ -10,7 +10,6 @@ config FB_OMAP2_DSS
 
 config FB_OMAP2_DSS_DEBUG
 	bool "Debug support"
-	default n
 	help
 	  This enables printing of debug messages. Alternatively, debug messages
 	  can also be enabled by setting CONFIG_DYNAMIC_DEBUG and then setting
@@ -19,7 +18,6 @@ config FB_OMAP2_DSS_DEBUG
 config FB_OMAP2_DSS_DEBUGFS
 	bool "Debugfs filesystem support"
 	depends on DEBUG_FS
-	default n
 	help
 	  This enables debugfs for OMAPDSS at <debugfs>/omapdss. This enables
 	  querying about clock configuration and register configuration of dss,
@@ -28,7 +26,6 @@ config FB_OMAP2_DSS_DEBUGFS
 config FB_OMAP2_DSS_COLLECT_IRQ_STATS
 	bool "Collect DSS IRQ statistics"
 	depends on FB_OMAP2_DSS_DEBUGFS
-	default n
 	help
 	  Collect DSS IRQ statistics, printable via debugfs.
 
@@ -45,7 +42,6 @@ config FB_OMAP2_DSS_DPI
 config FB_OMAP2_DSS_RFBI
 	bool "RFBI support"
 	depends on BROKEN
-        default n
 	help
 	  MIPI DBI support (RFBI, Remote Framebuffer Interface, in Texas
 	  Instrument's terminology).
@@ -73,7 +69,6 @@ config FB_OMAP4_DSS_HDMI
 
 config FB_OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
-	default n
 	select FB_OMAP2_DSS_HDMI_COMMON
 	help
 	  HDMI Interface for OMAP5 and similar cores. This adds the High
@@ -82,7 +77,6 @@ config FB_OMAP5_DSS_HDMI
 
 config FB_OMAP2_DSS_SDI
 	bool "SDI support"
-        default n
 	help
 	  SDI (Serial Display Interface) support.
 
@@ -91,7 +85,6 @@ config FB_OMAP2_DSS_SDI
 
 config FB_OMAP2_DSS_DSI
 	bool "DSI support"
-        default n
 	help
 	  MIPI DSI (Display Serial Interface) support.
 
