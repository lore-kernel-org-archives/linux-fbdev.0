From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 19 Sep 2012 08:30:36 +0000
Subject: [PATCH 6/8] OMAPDSS: cleanup dss_recheck_connections
Message-Id: <1348043438-2624-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_recheck_connections is quite a mess. With the previous commit that
initializes the channel field for HDMI and VENC displays, we can greatly
simplify the dss_recheck_connections.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/overlay.c |   49 +++++--------------------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index e3d4068..1bf05ef 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -109,52 +109,15 @@ void dss_init_overlays(struct platform_device *pdev)
  * selected, connect always. */
 void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 {
-	int i;
-	struct omap_overlay_manager *lcd_mgr;
-	struct omap_overlay_manager *tv_mgr;
-	struct omap_overlay_manager *lcd2_mgr = NULL;
-	struct omap_overlay_manager *lcd3_mgr = NULL;
 	struct omap_overlay_manager *mgr = NULL;
+	int i;
 
-	lcd_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_LCD);
-	tv_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_DIGIT);
-	if (dss_has_feature(FEAT_MGR_LCD3))
-		lcd3_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_LCD3);
-	if (dss_has_feature(FEAT_MGR_LCD2))
-		lcd2_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_LCD2);
-
-	if (dssdev->channel = OMAP_DSS_CHANNEL_LCD3) {
-		if (!lcd3_mgr->device || force) {
-			if (lcd3_mgr->device)
-				lcd3_mgr->unset_device(lcd3_mgr);
-			lcd3_mgr->set_device(lcd3_mgr, dssdev);
-			mgr = lcd3_mgr;
-		}
-	} else if (dssdev->channel = OMAP_DSS_CHANNEL_LCD2) {
-		if (!lcd2_mgr->device || force) {
-			if (lcd2_mgr->device)
-				lcd2_mgr->unset_device(lcd2_mgr);
-			lcd2_mgr->set_device(lcd2_mgr, dssdev);
-			mgr = lcd2_mgr;
-		}
-	} else if (dssdev->type != OMAP_DISPLAY_TYPE_VENC
-			&& dssdev->type != OMAP_DISPLAY_TYPE_HDMI) {
-		if (!lcd_mgr->device || force) {
-			if (lcd_mgr->device)
-				lcd_mgr->unset_device(lcd_mgr);
-			lcd_mgr->set_device(lcd_mgr, dssdev);
-			mgr = lcd_mgr;
-		}
-	}
+	mgr =  omap_dss_get_overlay_manager(dssdev->channel);
 
-	if (dssdev->type = OMAP_DISPLAY_TYPE_VENC
-			|| dssdev->type = OMAP_DISPLAY_TYPE_HDMI) {
-		if (!tv_mgr->device || force) {
-			if (tv_mgr->device)
-				tv_mgr->unset_device(tv_mgr);
-			tv_mgr->set_device(tv_mgr, dssdev);
-			mgr = tv_mgr;
-		}
+	if (!mgr->device || force) {
+		if (mgr->device)
+			mgr->unset_device(mgr);
+		mgr->set_device(mgr, dssdev);
 	}
 
 	if (mgr) {
-- 
1.7.9.5

