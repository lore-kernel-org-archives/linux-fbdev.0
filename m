From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Mon, 08 Feb 2010 15:56:01 +0000
Subject: [PATCH 02/13] OMAP: 3430SDP: remove vdvi regulator
Message-Id: <1265644572-3578-3-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

The regulator is now enabled by DSS driver, and thus the panel driver
doesn't need to touch it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c                |    4 --
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   35 --------------------
 2 files changed, 0 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index c90b0d0..964c390 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -520,10 +520,6 @@ static struct regulator_init_data sdp3430_vdac = {
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
 	{
-		.supply		= "vdvi",
-		.dev		= &sdp3430_lcd_device.dev,
-	},
-	{
 		.supply		= "vdds_dsi",
 		.dev		= &sdp3430_dss_device.dev,
 	}
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index bbe880b..e207d66 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -25,14 +25,6 @@
 
 #include <plat/display.h>
 
-struct sharp_data {
-	/* XXX This regulator should actually be in SDP board file, not here,
-	 * as it doesn't actually power the LCD, but something else that
-	 * affects the output to LCD (I think. Somebody clarify). It doesn't do
-	 * harm here, as SDP is the only board using this currently */
-	struct regulator *vdvi_reg;
-};
-
 static struct omap_video_timings sharp_ls_timings = {
 	.x_res = 480,
 	.y_res = 640,
@@ -50,48 +42,25 @@ static struct omap_video_timings sharp_ls_timings = {
 
 static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
 {
-	struct sharp_data *sd;
-
 	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
 		OMAP_DSS_LCD_IHS;
 	dssdev->panel.acb = 0x28;
 	dssdev->panel.timings = sharp_ls_timings;
 
-	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
-	if (!sd)
-		return -ENOMEM;
-
-	dev_set_drvdata(&dssdev->dev, sd);
-
-	sd->vdvi_reg = regulator_get(&dssdev->dev, "vdvi");
-	if (IS_ERR(sd->vdvi_reg)) {
-		kfree(sd);
-		pr_err("failed to get VDVI regulator\n");
-		return PTR_ERR(sd->vdvi_reg);
-	}
-
 	return 0;
 }
 
 static void sharp_ls_panel_remove(struct omap_dss_device *dssdev)
 {
-	struct sharp_data *sd = dev_get_drvdata(&dssdev->dev);
-
-	regulator_put(sd->vdvi_reg);
-
-	kfree(sd);
 }
 
 static int sharp_ls_panel_enable(struct omap_dss_device *dssdev)
 {
-	struct sharp_data *sd = dev_get_drvdata(&dssdev->dev);
 	int r = 0;
 
 	/* wait couple of vsyncs until enabling the LCD */
 	msleep(50);
 
-	regulator_enable(sd->vdvi_reg);
-
 	if (dssdev->platform_enable)
 		r = dssdev->platform_enable(dssdev);
 
@@ -100,13 +69,9 @@ static int sharp_ls_panel_enable(struct omap_dss_device *dssdev)
 
 static void sharp_ls_panel_disable(struct omap_dss_device *dssdev)
 {
-	struct sharp_data *sd = dev_get_drvdata(&dssdev->dev);
-
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
-	regulator_disable(sd->vdvi_reg);
-
 	/* wait at least 5 vsyncs after disabling the LCD */
 
 	msleep(100);
-- 
1.6.5

