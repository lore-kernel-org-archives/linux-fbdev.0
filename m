From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 Dec 2015 14:25:31 +0000
Subject: [PATCH RFC 5/9] omapfb/displays: change CONFIG_DISPLAY_* to CONFIG_FB_OMAP2_*
Message-Id: <1449757535-5674-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We need to change the config symbols of omapfb's private copy of the
panel and encoder drivers so that we won't have config symbol conflicts.

This patch changes the symbols from the panel and encoder drivers using
simple replacement of DISPLAY_* to FB_OMAP2*.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/Kconfig  | 32 +++++++++++-----------
 drivers/video/fbdev/omap2/omapfb/displays/Makefile | 28 +++++++++----------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/Kconfig b/drivers/video/fbdev/omap2/omapfb/displays/Kconfig
index 574710141a61..08f12039dd02 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/displays/Kconfig
@@ -1,81 +1,81 @@
-menu "OMAP Display Device Drivers (new device model)"
-        depends on OMAP2_DSS
+menu "OMAPFB Panel and Encoder Drivers"
+        depends on FB_OMAP2_DSS
 
-config DISPLAY_ENCODER_OPA362
+config FB_OMAP2_ENCODER_OPA362
 	tristate "OPA362 external analog amplifier"
 	help
 	  Driver for OPA362 external analog TV amplifier controlled
 	  through a GPIO.
 
-config DISPLAY_ENCODER_TFP410
+config FB_OMAP2_ENCODER_TFP410
         tristate "TFP410 DPI to DVI Encoder"
 	help
 	  Driver for TFP410 DPI to DVI encoder.
 
-config DISPLAY_ENCODER_TPD12S015
+config FB_OMAP2_ENCODER_TPD12S015
         tristate "TPD12S015 HDMI ESD protection and level shifter"
 	help
 	  Driver for TPD12S015, which offers HDMI ESD protection and level
 	  shifting.
 
-config DISPLAY_CONNECTOR_DVI
+config FB_OMAP2_CONNECTOR_DVI
         tristate "DVI Connector"
 	depends on I2C
 	help
 	  Driver for a generic DVI connector.
 
-config DISPLAY_CONNECTOR_HDMI
+config FB_OMAP2_CONNECTOR_HDMI
         tristate "HDMI Connector"
 	help
 	  Driver for a generic HDMI connector.
 
-config DISPLAY_CONNECTOR_ANALOG_TV
+config FB_OMAP2_CONNECTOR_ANALOG_TV
         tristate "Analog TV Connector"
 	help
 	  Driver for a generic analog TV connector.
 
-config DISPLAY_PANEL_DPI
+config FB_OMAP2_PANEL_DPI
 	tristate "Generic DPI panel"
 	help
 	  Driver for generic DPI panels.
 
-config DISPLAY_PANEL_DSI_CM
+config FB_OMAP2_PANEL_DSI_CM
 	tristate "Generic DSI Command Mode Panel"
 	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Driver for generic DSI command mode panels.
 
-config DISPLAY_PANEL_SONY_ACX565AKM
+config FB_OMAP2_PANEL_SONY_ACX565AKM
 	tristate "ACX565AKM Panel"
 	depends on SPI && BACKLIGHT_CLASS_DEVICE
 	help
 	  This is the LCD panel used on Nokia N900
 
-config DISPLAY_PANEL_LGPHILIPS_LB035Q02
+config FB_OMAP2_PANEL_LGPHILIPS_LB035Q02
 	tristate "LG.Philips LB035Q02 LCD Panel"
 	depends on SPI
 	help
 	  LCD Panel used on the Gumstix Overo Palo35
 
-config DISPLAY_PANEL_SHARP_LS037V7DW01
+config FB_OMAP2_PANEL_SHARP_LS037V7DW01
         tristate "Sharp LS037V7DW01 LCD Panel"
         depends on BACKLIGHT_CLASS_DEVICE
         help
           LCD Panel used in TI's SDP3430 and EVM boards
 
-config DISPLAY_PANEL_TPO_TD028TTEC1
+config FB_OMAP2_PANEL_TPO_TD028TTEC1
         tristate "TPO TD028TTEC1 LCD Panel"
         depends on SPI
         help
           LCD panel used in Openmoko.
 
-config DISPLAY_PANEL_TPO_TD043MTEA1
+config FB_OMAP2_PANEL_TPO_TD043MTEA1
         tristate "TPO TD043MTEA1 LCD Panel"
         depends on SPI
         help
           LCD Panel used in OMAP3 Pandora
 
-config DISPLAY_PANEL_NEC_NL8048HL11
+config FB_OMAP2_PANEL_NEC_NL8048HL11
 	tristate "NEC NL8048HL11 Panel"
 	depends on SPI
 	depends on BACKLIGHT_CLASS_DEVICE
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/Makefile b/drivers/video/fbdev/omap2/omapfb/displays/Makefile
index 9aa176bfbf2e..4f7459272256 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/Makefile
+++ b/drivers/video/fbdev/omap2/omapfb/displays/Makefile
@@ -1,14 +1,14 @@
-obj-$(CONFIG_DISPLAY_ENCODER_OPA362) += encoder-opa362.o
-obj-$(CONFIG_DISPLAY_ENCODER_TFP410) += encoder-tfp410.o
-obj-$(CONFIG_DISPLAY_ENCODER_TPD12S015) += encoder-tpd12s015.o
-obj-$(CONFIG_DISPLAY_CONNECTOR_DVI) += connector-dvi.o
-obj-$(CONFIG_DISPLAY_CONNECTOR_HDMI) += connector-hdmi.o
-obj-$(CONFIG_DISPLAY_CONNECTOR_ANALOG_TV) += connector-analog-tv.o
-obj-$(CONFIG_DISPLAY_PANEL_DPI) += panel-dpi.o
-obj-$(CONFIG_DISPLAY_PANEL_DSI_CM) += panel-dsi-cm.o
-obj-$(CONFIG_DISPLAY_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
-obj-$(CONFIG_DISPLAY_PANEL_LGPHILIPS_LB035Q02) += panel-lgphilips-lb035q02.o
-obj-$(CONFIG_DISPLAY_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
-obj-$(CONFIG_DISPLAY_PANEL_TPO_TD028TTEC1) += panel-tpo-td028ttec1.o
-obj-$(CONFIG_DISPLAY_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
-obj-$(CONFIG_DISPLAY_PANEL_NEC_NL8048HL11) += panel-nec-nl8048hl11.o
+obj-$(CONFIG_FB_OMAP2_ENCODER_OPA362) += encoder-opa362.o
+obj-$(CONFIG_FB_OMAP2_ENCODER_TFP410) += encoder-tfp410.o
+obj-$(CONFIG_FB_OMAP2_ENCODER_TPD12S015) += encoder-tpd12s015.o
+obj-$(CONFIG_FB_OMAP2_CONNECTOR_DVI) += connector-dvi.o
+obj-$(CONFIG_FB_OMAP2_CONNECTOR_HDMI) += connector-hdmi.o
+obj-$(CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV) += connector-analog-tv.o
+obj-$(CONFIG_FB_OMAP2_PANEL_DPI) += panel-dpi.o
+obj-$(CONFIG_FB_OMAP2_PANEL_DSI_CM) += panel-dsi-cm.o
+obj-$(CONFIG_FB_OMAP2_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
+obj-$(CONFIG_FB_OMAP2_PANEL_LGPHILIPS_LB035Q02) += panel-lgphilips-lb035q02.o
+obj-$(CONFIG_FB_OMAP2_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
+obj-$(CONFIG_FB_OMAP2_PANEL_TPO_TD028TTEC1) += panel-tpo-td028ttec1.o
+obj-$(CONFIG_FB_OMAP2_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
+obj-$(CONFIG_FB_OMAP2_PANEL_NEC_NL8048HL11) += panel-nec-nl8048hl11.o
-- 
2.5.0

