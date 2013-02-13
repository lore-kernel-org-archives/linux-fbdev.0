From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:34:11 +0000
Subject: [PATCH 19/33] arm: omap: board-zoom: use NEC panel's gpio handling
Message-Id: <1360765345-19312-20-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The zoom board file currently requests gpios required by the nec-nl8048hl11-01
dpi panel, and provides dummy platform_enable/disable callbacks.

gpio request and configuration have been moved to the nec-nl8048hl11-01 panel
driver itself and shouldn't be done in the board files.

Remove the gpio requests and the platform callbacks from the board file. Add the
gpio information to panel_nec_nl8048_data so that it's passed to the panel
driver.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-zoom-display.c |   38 ++++++++++--------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index 4717ed5..bd79082 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -16,8 +16,9 @@
 #include <linux/spi/spi.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <video/omapdss.h>
-#include "board-zoom.h"
+#include <video/omap-panel-data.h>
 
+#include "board-zoom.h"
 #include "soc.h"
 #include "common.h"
 
@@ -25,30 +26,11 @@
 #define LCD_PANEL_RESET_GPIO_PILOT	55
 #define LCD_PANEL_QVGA_GPIO		56
 
-static struct gpio zoom_lcd_gpios[] __initdata = {
-	{ -EINVAL,		GPIOF_OUT_INIT_HIGH, "lcd reset" },
-	{ LCD_PANEL_QVGA_GPIO,	GPIOF_OUT_INIT_HIGH, "lcd qvga"	 },
+static struct panel_nec_nl8048_data zoom_lcd_data = {
+	/* res_gpio filled in code */
+	.qvga_gpio = LCD_PANEL_QVGA_GPIO,
 };
 
-static void __init zoom_lcd_panel_init(void)
-{
-	zoom_lcd_gpios[0].gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
-			LCD_PANEL_RESET_GPIO_PROD :
-			LCD_PANEL_RESET_GPIO_PILOT;
-
-	if (gpio_request_array(zoom_lcd_gpios, ARRAY_SIZE(zoom_lcd_gpios)))
-		pr_err("%s: Failed to get LCD GPIOs.\n", __func__);
-}
-
-static int zoom_panel_enable_lcd(struct omap_dss_device *dssdev)
-{
-	return 0;
-}
-
-static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
-{
-}
-
 /*
  * PWMA/B register offsets (TWL4030_MODULE_PWMA)
  */
@@ -107,8 +89,7 @@ static struct omap_dss_device zoom_lcd_device = {
 	.driver_name		= "NEC_8048_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
-	.platform_enable	= zoom_panel_enable_lcd,
-	.platform_disable	= zoom_panel_disable_lcd,
+	.data			= &zoom_lcd_data,
 };
 
 static struct omap_dss_device *zoom_dss_devices[] = {
@@ -121,6 +102,13 @@ static struct omap_dss_board_info zoom_dss_data = {
 	.default_device		= &zoom_lcd_device,
 };
 
+static void __init zoom_lcd_panel_init(void)
+{
+	zoom_lcd_data.res_gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
+			LCD_PANEL_RESET_GPIO_PROD :
+			LCD_PANEL_RESET_GPIO_PILOT;
+}
+
 static struct omap2_mcspi_device_config dss_lcd_mcspi_config = {
 	.turbo_mode		= 1,
 };
-- 
1.7.9.5

