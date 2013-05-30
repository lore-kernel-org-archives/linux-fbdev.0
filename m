From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:35:59 +0000
Subject: [PATCH 06/27] ARM: OMAP: rx51: use new display drivers
Message-Id: <1369906580-27585-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new display drivers for RX51 board.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 12 ++++++++++
 arch/arm/mach-omap2/board-rx51-video.c       | 35 ++++++++++------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 18ca61e..e35e0b6 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -45,6 +45,8 @@
 #include <linux/platform_data/tsl2563.h>
 #include <linux/lis3lv02d.h>
 
+#include <video/omap-panel-data.h>
+
 #if defined(CONFIG_IR_RX51) || defined(CONFIG_IR_RX51_MODULE)
 #include <media/ir-rx51.h>
 #endif
@@ -226,6 +228,15 @@ static struct lp55xx_platform_data rx51_lp5523_platform_data = {
 };
 #endif
 
+#define RX51_LCD_RESET_GPIO	90
+
+static struct panel_acx565akm_platform_data acx_pdata = {
+	.name		= "lcd",
+	.source		= "sdi.0",
+	.reset_gpio	= RX51_LCD_RESET_GPIO,
+	.datapairs	= 2,
+};
+
 static struct omap2_mcspi_device_config wl1251_mcspi_config = {
 	.turbo_mode	= 0,
 };
@@ -254,6 +265,7 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 		.chip_select		= 2,
 		.max_speed_hz		= 6000000,
 		.controller_data	= &mipid_mcspi_config,
+		.platform_data		= &acx_pdata,
 	},
 	[RX51_SPI_TSC2005] = {
 		.modalias		= "tsc2005",
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index bd74f9f..b007fd3 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -29,34 +29,21 @@
 
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
 
-static struct panel_acx565akm_data lcd_data = {
-	.reset_gpio	= RX51_LCD_RESET_GPIO,
+static struct connector_atv_platform_data rx51_tv_pdata = {
+	.name = "tv",
+	.source = "venc.0",
+	.connector_type = OMAP_DSS_VENC_TYPE_COMPOSITE,
+	.invert_polarity = false,
 };
 
-static struct omap_dss_device rx51_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "panel-acx565akm",
-	.type			= OMAP_DISPLAY_TYPE_SDI,
-	.phy.sdi.datapairs	= 2,
-	.data			= &lcd_data,
-};
-
-static struct omap_dss_device  rx51_tv_device = {
-	.name			= "tv",
-	.type			= OMAP_DISPLAY_TYPE_VENC,
-	.driver_name		= "venc",
-	.phy.venc.type	        = OMAP_DSS_VENC_TYPE_COMPOSITE,
-};
-
-static struct omap_dss_device *rx51_dss_devices[] = {
-	&rx51_lcd_device,
-	&rx51_tv_device,
+static struct platform_device rx51_tv_device = {
+	.name                   = "connector-analog-tv",
+	.id                     = 0,
+	.dev.platform_data      = &rx51_tv_pdata,
 };
 
 static struct omap_dss_board_info rx51_dss_board_info = {
-	.num_devices	= ARRAY_SIZE(rx51_dss_devices),
-	.devices	= rx51_dss_devices,
-	.default_device	= &rx51_lcd_device,
+	.default_display_name = "lcd",
 };
 
 static int __init rx51_video_init(void)
@@ -71,6 +58,8 @@ static int __init rx51_video_init(void)
 
 	omap_display_init(&rx51_dss_board_info);
 
+	platform_device_register(&rx51_tv_device);
+
 	return 0;
 }
 
-- 
1.8.1.2

