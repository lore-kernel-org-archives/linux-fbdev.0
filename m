From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:34:27 +0000
Subject: [PATCH 06/32] OMAPDSS: DPI: fix regulators for DT
Message-Id: <1369906493-27538-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

On some platforms DPI requires a regulator to be enabled to power up the
output pins. This regulator is, for some reason, currently attached to
the virtual omapdss device, instead of the DPI device. This does not
work for DT, as the regulator mappings need to be described in the DT
data, and the virtual omapdss device is not present there.

Fix the issue by acquiring the regulator in the DPI device. To retain
compatibility with the current board files, the old method of getting
the regulator is kept. The old method can be removed when the board
files have been changed to pass the regulator to DPI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index ef8fca2..43f6b26 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -37,7 +37,10 @@
 #include "dss_features.h"
 
 static struct {
+	struct platform_device *pdev;
+
 	struct regulator *vdds_dsi_reg;
+	bool vdds_dsi_from_core;
 	struct platform_device *dsidev;
 
 	struct mutex lock;
@@ -583,10 +586,15 @@ static int dpi_init_display(struct omap_dss_device *dssdev)
 		struct regulator *vdds_dsi;
 
 		vdds_dsi = dss_get_vdds_dsi();
-
 		if (IS_ERR(vdds_dsi)) {
-			DSSERR("can't get VDDS_DSI regulator\n");
-			return PTR_ERR(vdds_dsi);
+			vdds_dsi = regulator_get(&dpi.pdev->dev, "vdds_dsi");
+			if (IS_ERR(vdds_dsi)) {
+				DSSERR("can't get VDDS_DSI regulator\n");
+				return PTR_ERR(vdds_dsi);
+			}
+			dpi.vdds_dsi_from_core = false;
+		} else {
+			dpi.vdds_dsi_from_core = true;
 		}
 
 		dpi.vdds_dsi_reg = vdds_dsi;
@@ -702,6 +710,8 @@ static int omap_dpi_probe(struct platform_device *pdev)
 {
 	int r;
 
+	dpi.pdev = pdev;
+
 	mutex_init(&dpi.lock);
 
 	dpi_init_output(pdev);
@@ -725,6 +735,11 @@ static int __exit omap_dpi_remove(struct platform_device *pdev)
 
 	dpi_uninit_output(pdev);
 
+	if (dpi.vdds_dsi_reg != NULL && dpi.vdds_dsi_from_core = false) {
+		regulator_put(dpi.vdds_dsi_reg);
+		dpi.vdds_dsi_reg = NULL;
+	}
+
 	return 0;
 }
 
-- 
1.8.1.2

