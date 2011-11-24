From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Nov 2011 13:29:35 +0000
Subject: [PATCH 07/13] OMAPDSS: DSI: use lane config in dsi_get_lane_mask
Message-Id: <1322141381-5395-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new lane config in dsi_get_lane_mask().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ba8d6b3..1a209a2 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2422,22 +2422,20 @@ static int dsi_cio_wait_tx_clk_esc_reset(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+/* return bitmask of enabled lanes, lane0 being the lsb */
 static unsigned dsi_get_lane_mask(struct omap_dss_device *dssdev)
 {
-	unsigned lanes = 0;
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	unsigned mask = 0;
+	int i;
 
-	if (dssdev->phy.dsi.clk_lane != 0)
-		lanes |= 1 << (dssdev->phy.dsi.clk_lane - 1);
-	if (dssdev->phy.dsi.data1_lane != 0)
-		lanes |= 1 << (dssdev->phy.dsi.data1_lane - 1);
-	if (dssdev->phy.dsi.data2_lane != 0)
-		lanes |= 1 << (dssdev->phy.dsi.data2_lane - 1);
-	if (dssdev->phy.dsi.data3_lane != 0)
-		lanes |= 1 << (dssdev->phy.dsi.data3_lane - 1);
-	if (dssdev->phy.dsi.data4_lane != 0)
-		lanes |= 1 << (dssdev->phy.dsi.data4_lane - 1);
+	for (i = 0; i < dsi->num_lanes_supported; ++i) {
+		if (dsi->lanes[i].function != DSI_LANE_UNUSED)
+			mask |= 1 << i;
+	}
 
-	return lanes;
+	return mask;
 }
 
 static int dsi_cio_init(struct omap_dss_device *dssdev)
-- 
1.7.4.1

