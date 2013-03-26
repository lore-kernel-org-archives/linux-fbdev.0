From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Mar 2013 13:33:52 +0000
Subject: [PATCH 22/26] ARM: OMAP: Panda: use new TFP410 platform driver
Message-Id: <1364304836-18134-23-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 4be5cfc..0e94df8 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -25,6 +25,7 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-tfp410.h>
@@ -42,20 +43,18 @@
 /* Display DVI */
 #define PANDA_DVI_TFP410_POWER_DOWN_GPIO	0
 
-/* Using generic display panel */
-static struct tfp410_platform_data omap4_dvi_panel = {
+static struct tfp410_platform_data omap4_tfp410_pdata = {
+	.name			= "dvi",
+	.source			= "dpi.0",
 	.i2c_bus_num		= 3,
+	.data_lines		= 24,
 	.power_down_gpio	= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
 };
 
-static struct omap_dss_device omap4_panda_dvi_device = {
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.name			= "dvi",
-	.driver_name		= "tfp410",
-	.data			= &omap4_dvi_panel,
-	.phy.dpi.data_lines	= 24,
-	.reset_gpio		= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
-	.channel		= OMAP_DSS_CHANNEL_LCD2,
+static struct platform_device omap4_panda_tfp410_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &omap4_tfp410_pdata,
 };
 
 static struct omap_dss_hdmi_data omap4_panda_hdmi_data = {
@@ -73,19 +72,19 @@ static struct omap_dss_device  omap4_panda_hdmi_device = {
 };
 
 static struct omap_dss_device *omap4_panda_dss_devices[] = {
-	&omap4_panda_dvi_device,
 	&omap4_panda_hdmi_device,
 };
 
 static struct omap_dss_board_info omap4_panda_dss_data = {
 	.num_devices	= ARRAY_SIZE(omap4_panda_dss_devices),
 	.devices	= omap4_panda_dss_devices,
-	.default_device	= &omap4_panda_dvi_device,
+	.default_display_name = "dvi",
 };
 
 void __init omap4_panda_display_init(void)
 {
 	omap_display_init(&omap4_panda_dss_data);
+	platform_device_register(&omap4_panda_tfp410_device);
 
 	/*
 	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
@@ -104,6 +103,7 @@ void __init omap4_panda_display_init(void)
 void __init omap4_panda_display_init_of(void)
 {
 	omap_display_init(&omap4_panda_dss_data);
+	platform_device_register(&omap4_panda_tfp410_device);
 }
 
 
-- 
1.7.10.4

