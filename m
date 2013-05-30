From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:34:34 +0000
Subject: [PATCH 13/32] OMAPDSS: CORE: use devm_regulator_get
Message-Id: <1369906493-27538-14-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use devm_regulator_get() instead of regulator_get() to simplify code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 4bd8f79..f64d0ac 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -80,7 +80,7 @@ struct regulator *dss_get_vdds_dsi(void)
 	if (core.vdds_dsi_reg != NULL)
 		return core.vdds_dsi_reg;
 
-	reg = regulator_get(&core.pdev->dev, "vdds_dsi");
+	reg = devm_regulator_get(&core.pdev->dev, "vdds_dsi");
 	if (!IS_ERR(reg))
 		core.vdds_dsi_reg = reg;
 
@@ -94,7 +94,7 @@ struct regulator *dss_get_vdds_sdi(void)
 	if (core.vdds_sdi_reg != NULL)
 		return core.vdds_sdi_reg;
 
-	reg = regulator_get(&core.pdev->dev, "vdds_sdi");
+	reg = devm_regulator_get(&core.pdev->dev, "vdds_sdi");
 	if (!IS_ERR(reg))
 		core.vdds_sdi_reg = reg;
 
@@ -654,16 +654,6 @@ static int __init omap_dss_init(void)
 
 static void __exit omap_dss_exit(void)
 {
-	if (core.vdds_dsi_reg != NULL) {
-		regulator_put(core.vdds_dsi_reg);
-		core.vdds_dsi_reg = NULL;
-	}
-
-	if (core.vdds_sdi_reg != NULL) {
-		regulator_put(core.vdds_sdi_reg);
-		core.vdds_sdi_reg = NULL;
-	}
-
 	omap_dss_unregister_drivers();
 
 	omap_dss_bus_unregister();
-- 
1.8.1.2

