From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Mar 2013 11:51:50 +0000
Subject: [PATCH 15/20] OMAP: dss-common.c: remove uses of dss channel (LATER)
Message-Id: <1362743515-10152-16-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that omap_dss_device's channel is resolved automatically, we can
remove its uses from the board files.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/dss-common.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 4be5cfc..125c4eb 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -55,7 +55,6 @@ static struct omap_dss_device omap4_panda_dvi_device = {
 	.data			= &omap4_dvi_panel,
 	.phy.dpi.data_lines	= 24,
 	.reset_gpio		= PANDA_DVI_TFP410_POWER_DOWN_GPIO,
-	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
 static struct omap_dss_hdmi_data omap4_panda_hdmi_data = {
@@ -68,7 +67,6 @@ static struct omap_dss_device  omap4_panda_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
 	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.channel = OMAP_DSS_CHANNEL_DIGIT,
 	.data = &omap4_panda_hdmi_data,
 };
 
@@ -132,7 +130,6 @@ static struct omap_dss_device sdp4430_lcd_device = {
 	.phy.dsi		= {
 		.module		= 0,
 	},
-	.channel		= OMAP_DSS_CHANNEL_LCD,
 };
 
 static struct nokia_dsi_panel_data dsi2_panel = {
@@ -156,7 +153,6 @@ static struct omap_dss_device sdp4430_lcd2_device = {
 
 		.module		= 1,
 	},
-	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
 static struct omap_dss_hdmi_data sdp4430_hdmi_data = {
@@ -169,7 +165,6 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
 	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.channel = OMAP_DSS_CHANNEL_DIGIT,
 	.data = &sdp4430_hdmi_data,
 };
 
@@ -215,7 +210,6 @@ static struct omap_dss_device sdp4430_picodlp_device = {
 	.driver_name		= "picodlp_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
-	.channel		= OMAP_DSS_CHANNEL_LCD2,
 	.platform_enable	= sdp4430_panel_enable_picodlp,
 	.platform_disable	= sdp4430_panel_disable_picodlp,
 	.data			= &sdp4430_picodlp_pdata,
-- 
1.7.10.4

