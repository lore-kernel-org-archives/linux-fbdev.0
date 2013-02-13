From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:34:07 +0000
Subject: [PATCH 15/33] OMAPDSS: sharp-ls panel: remove platform_enable/disable callbacks
Message-Id: <1360765345-19312-16-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The sharp-ls panel driver now manages the gpios required to configure the panel.
This was previously done in omap_dss_device's platform_enable/disable callbacks
defined in board files using this panel.

All the board files using this panel now pass the gpio information as platform
data via the panel_sharp_ls037v7dw01_data struct, which is needed by the panel
driver to configure the gpios connected to the panel. Hence, the
platform_enable/disable ops can be safely removed now.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index e6d9c9b..74cb0eb 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -125,12 +125,6 @@ static int sharp_ls_power_on(struct omap_dss_device *dssdev)
 	/* wait couple of vsyncs until enabling the LCD */
 	msleep(50);
 
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
 	if (gpio_is_valid(pd->resb_gpio))
 		gpio_set_value_cansleep(pd->resb_gpio, 1);
 
@@ -138,8 +132,6 @@ static int sharp_ls_power_on(struct omap_dss_device *dssdev)
 		gpio_set_value_cansleep(pd->ini_gpio, 1);
 
 	return 0;
-err1:
-	omapdss_dpi_display_disable(dssdev);
 err0:
 	return r;
 }
@@ -157,9 +149,6 @@ static void sharp_ls_power_off(struct omap_dss_device *dssdev)
 	if (gpio_is_valid(pd->resb_gpio))
 		gpio_set_value_cansleep(pd->resb_gpio, 0);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	/* wait at least 5 vsyncs after disabling the LCD */
 
 	msleep(100);
-- 
1.7.9.5

