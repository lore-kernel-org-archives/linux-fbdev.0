From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 15 Apr 2011 08:11:11 +0000
Subject: [PATCH 5/5] OMAP: DSS2: fix panel Kconfig dependencies
Message-Id: <1302855071-5510-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

All DPI panels were missing dependency to OMAP2_DSS_DPI. Add the
dependency.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/Kconfig |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index d18ad6b..609a280 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -3,6 +3,7 @@ menu "OMAP2/3 Display Device Drivers"
 
 config PANEL_GENERIC_DPI
         tristate "Generic DPI Panel"
+	depends on OMAP2_DSS_DPI
         help
 	  Generic DPI panel driver.
 	  Supports DVI output for Beagle and OMAP3 SDP.
@@ -11,20 +12,20 @@ config PANEL_GENERIC_DPI
 
 config PANEL_LGPHILIPS_LB035Q02
 	tristate "LG.Philips LB035Q02 LCD Panel"
-	depends on OMAP2_DSS && SPI
+	depends on OMAP2_DSS_DPI && SPI
 	help
 	  LCD Panel used on the Gumstix Overo Palo35
 
 config PANEL_SHARP_LS037V7DW01
         tristate "Sharp LS037V7DW01 LCD Panel"
-        depends on OMAP2_DSS
+        depends on OMAP2_DSS_DPI
         select BACKLIGHT_CLASS_DEVICE
         help
           LCD Panel used in TI's SDP3430 and EVM boards
 
 config PANEL_NEC_NL8048HL11_01B
 	tristate "NEC NL8048HL11-01B Panel"
-	depends on OMAP2_DSS
+	depends on OMAP2_DSS_DPI
 	help
 		This NEC NL8048HL11-01B panel is TFT LCD
 		used in the Zoom2/3/3630 sdp boards.
@@ -37,7 +38,7 @@ config PANEL_TAAL
 
 config PANEL_TPO_TD043MTEA1
         tristate "TPO TD043MTEA1 LCD Panel"
-        depends on OMAP2_DSS && SPI
+        depends on OMAP2_DSS_DPI && SPI
         help
           LCD Panel used in OMAP3 Pandora
 
-- 
1.7.1

