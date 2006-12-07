From: James Simmons <jsimmons@infradead.org>
Subject: [PATCH] Proper backlight selection for fbdev drivers
Date: Thu, 7 Dec 2006 17:59:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0612071757230.949@pentafluge.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1162612AbWLGR7M@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Try this patch. This should fix any module/built-in dependencys.

Signed-Off: James Simmons <jsimmons@infradead.org>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7a43020..3fb52d2 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -4,20 +4,9 @@
 
 menu "Graphics support"
 
-config FIRMWARE_EDID
-       bool "Enable firmware EDID"
-       default y
-       ---help---
-         This enables access to the EDID transferred from the firmware.
-	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
-	 transfers do not work for your driver and if you are using
-	 nvidiafb, i810fb or savagefb.
-
-	 In general, choosing Y for this option is safe.  If you
-	 experience extremely long delays while booting before you get
-	 something on your display, try setting this to N.  Matrox cards in
-	 combination with certain motherboards and monitors are known to
-	 suffer from this problem.
+if SYSFS
+	source "drivers/video/backlight/Kconfig"
+endif
 
 config FB
 	tristate "Support for frame buffer devices"
@@ -53,9 +42,27 @@ config FB
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.
 
+config FIRMWARE_EDID
+       bool "Enable firmware EDID"
+       depends on FB
+       default n
+       ---help---
+         This enables access to the EDID transferred from the firmware.
+	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
+	 transfers do not work for your driver and if you are using
+	 nvidiafb, i810fb or savagefb.
+
+	 In general, choosing Y for this option is safe.  If you
+	 experience extremely long delays while booting before you get
+	 something on your display, try setting this to N.  Matrox cards in
+	 combination with certain motherboards and monitors are known to
+	 suffer from this problem.
+
 config FB_DDC
        tristate
-       depends on FB && I2C && I2C_ALGOBIT
+       depends on FB
+       select I2C_ALGOBIT
+       select I2C
        default n
 
 config FB_CFB_FILLRECT
@@ -126,6 +133,9 @@ config FB_TILEBLITTING
 	 This is particularly important to one driver, matroxfb.  If
 	 unsure, say N.
 
+comment "Frambuffer hardware drivers"
+	depends on FB
+
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
 	depends on FB && (ZORRO || PCI)
@@ -701,6 +711,7 @@ config FB_NVIDIA
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_NVIDIA_I2C
 	select I2C if FB_NVIDIA_I2C
+	select FB_BACKLIGHT if FB_NVIDIA_BACKLIGHT	
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -728,8 +739,7 @@ config FB_NVIDIA_I2C
 
 config FB_NVIDIA_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_NVIDIA && PMAC_BACKLIGHT
-	select FB_BACKLIGHT
+	depends on FB_NVIDIA
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -737,9 +747,8 @@ config FB_NVIDIA_BACKLIGHT
 config FB_RIVA
 	tristate "nVidia Riva support"
 	depends on FB && PCI
-	select I2C_ALGOBIT if FB_RIVA_I2C
-	select I2C if FB_RIVA_I2C
 	select FB_DDC if FB_RIVA_I2C
+	select FB_BACKLIGHT if FB_RIVA_BACKLIGHT	
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -775,8 +784,7 @@ config FB_RIVA_DEBUG
 
 config FB_RIVA_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_RIVA && PMAC_BACKLIGHT
-	select FB_BACKLIGHT
+	depends on FB_RIVA
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -826,8 +834,6 @@ config FB_I810_GTF
 config FB_I810_I2C
 	bool "Enable DDC Support"
 	depends on FB_I810 && FB_I810_GTF
-	select I2C
-	select I2C_ALGOBIT
 	select FB_DDC
 	help
 
@@ -1017,9 +1023,8 @@ config FB_MATROX_MULTIHEAD
 config FB_RADEON
 	tristate "ATI Radeon display support"
 	depends on FB && PCI
-	select I2C_ALGOBIT if FB_RADEON_I2C
-	select I2C if FB_RADEON_I2C
 	select FB_DDC if FB_RADEON_I2C
+	select FB_BACKLIGHT if FB_RADEON_BACKLIGHT	
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -1049,8 +1054,7 @@ config FB_RADEON_I2C
 
 config FB_RADEON_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_RADEON && PMAC_BACKLIGHT
-	select FB_BACKLIGHT
+	depends on FB_RADEON
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -1070,6 +1074,7 @@ config FB_ATY128
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_BACKLIGHT if FB_ATY128_BACKLIGHT	
 	select FB_MACMODES if PPC_PMAC
 	help
 	  This driver supports graphics boards with the ATI Rage128 chips.
@@ -1081,8 +1086,7 @@ config FB_ATY128
 
 config FB_ATY128_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_ATY128 && PMAC_BACKLIGHT
-	select FB_BACKLIGHT
+	depends on FB_ATY128
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -1093,6 +1097,7 @@ config FB_ATY
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_BACKLIGHT if FB_ATY_BACKLIGHT	
 	select FB_MACMODES if PPC
 	help
 	  This driver supports graphics boards with the ATI Mach64 chips.
@@ -1131,8 +1136,7 @@ config FB_ATY_GX
 
 config FB_ATY_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_ATY && PMAC_BACKLIGHT
-	select FB_BACKLIGHT
+	depends on FB_ATY
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -1146,8 +1150,6 @@ config FB_S3TRIO
 config FB_SAVAGE
 	tristate "S3 Savage support"
 	depends on FB && PCI && EXPERIMENTAL
-	select I2C_ALGOBIT if FB_SAVAGE_I2C
-	select I2C if FB_SAVAGE_I2C
 	select FB_DDC if FB_SAVAGE_I2C
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
@@ -1632,6 +1634,7 @@ config FB_VIRTUAL
 	  the vfb_enable=1 option.
 
 	  If unsure, say N.
+
 if VT
 	source "drivers/video/console/Kconfig"
 endif
@@ -1640,9 +1643,5 @@ if FB || SGI_NEWPORT_CONSOLE
 	source "drivers/video/logo/Kconfig"
 endif
 
-if SYSFS
-	source "drivers/video/backlight/Kconfig"
-endif
-
 endmenu
 
