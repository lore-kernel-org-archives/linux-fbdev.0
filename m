From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 29 Aug 2013 13:31:50 +0000
Subject: [PATCH 05/15] OMAPDSS: DPI: change regulator handling
Message-Id: <1377783120-14001-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Regulator handling for DPI and SDI is currently handled in the core.c,
using the 'virtual' omapdss platform device. Nowadays we have proper
devices for both DPI and SDI, and so we can handle the regulators inside
the respective drivers.

This patch moves the regulator handling for DPI into dpi.c.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c | 18 ------------------
 drivers/video/omap2/dss/dpi.c  | 10 +++-------
 drivers/video/omap2/dss/dss.h  |  1 -
 3 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index a07d626..71e6a77 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -43,8 +43,6 @@
 static struct {
 	struct platform_device *pdev;
 
-	struct regulator *vdds_dsi_reg;
-
 	const char *default_display_name;
 } core;
 
@@ -78,22 +76,6 @@ struct platform_device *dss_get_core_pdev(void)
 	return core.pdev;
 }
 
-/* REGULATORS */
-
-struct regulator *dss_get_vdds_dsi(void)
-{
-	struct regulator *reg;
-
-	if (core.vdds_dsi_reg != NULL)
-		return core.vdds_dsi_reg;
-
-	reg = devm_regulator_get(&core.pdev->dev, "vdds_dsi");
-	if (!IS_ERR(reg))
-		core.vdds_dsi_reg = reg;
-
-	return reg;
-}
-
 int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 {
 	struct omap_dss_board_info *board_data = core.pdev->dev.platform_data;
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index a6b331e..89c7a6e 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -554,14 +554,10 @@ static int dpi_init_regulator(void)
 	if (dpi.vdds_dsi_reg)
 		return 0;
 
-	vdds_dsi = dss_get_vdds_dsi();
-
+	vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "vdds_dsi");
 	if (IS_ERR(vdds_dsi)) {
-		vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "vdds_dsi");
-		if (IS_ERR(vdds_dsi)) {
-			DSSERR("can't get VDDS_DSI regulator\n");
-			return PTR_ERR(vdds_dsi);
-		}
+		DSSERR("can't get VDDS_DSI regulator\n");
+		return PTR_ERR(vdds_dsi);
 	}
 
 	dpi.vdds_dsi_reg = vdds_dsi;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 7d97de4..146349f 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -164,7 +164,6 @@ struct platform_device;
 /* core */
 struct platform_device *dss_get_core_pdev(void);
 struct bus_type *dss_get_bus(void);
-struct regulator *dss_get_vdds_dsi(void);
 int dss_dsi_enable_pads(int dsi_id, unsigned lane_mask);
 void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask);
 int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
-- 
1.8.1.2

