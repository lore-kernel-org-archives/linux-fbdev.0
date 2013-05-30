From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:34:28 +0000
Subject: [PATCH 07/32] OMAPDSS: SDI: fix regulators for DT
Message-Id: <1369906493-27538-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

SDI requires a regulator to operate. This regulator is, for some reason,
currently attached to the virtual omapdss device, instead of the SDI
device. This does not work for DT, as the regulator mappings need to be
described in the DT data, and the virtual omapdss device is not present
there.

Fix the issue by acquiring the regulator in the SDI device. To retain
compatibility with the current board files, the old method of getting
the regulator is kept. The old method can be removed when the board
files have been changed to pass the regulator to SDI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/sdi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 6277c05..2e3afb8 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -31,8 +31,11 @@
 #include "dss.h"
 
 static struct {
+	struct platform_device *pdev;
+
 	bool update_enabled;
 	struct regulator *vdds_sdi_reg;
+	bool vdds_sdi_from_core;
 
 	struct dss_lcd_mgr_config mgr_config;
 	struct omap_video_timings timings;
@@ -258,8 +261,14 @@ static int sdi_init_display(struct omap_dss_device *dssdev)
 		vdds_sdi = dss_get_vdds_sdi();
 
 		if (IS_ERR(vdds_sdi)) {
-			DSSERR("can't get VDDS_SDI regulator\n");
-			return PTR_ERR(vdds_sdi);
+			vdds_sdi = regulator_get(&sdi.pdev->dev, "vdds_sdi");
+			if (IS_ERR(vdds_sdi)) {
+				DSSERR("can't get VDDS_SDI regulator\n");
+				return PTR_ERR(vdds_sdi);
+			}
+			sdi.vdds_sdi_from_core = false;
+		} else {
+			sdi.vdds_sdi_from_core = true;
 		}
 
 		sdi.vdds_sdi_reg = vdds_sdi;
@@ -363,6 +372,8 @@ static int omap_sdi_probe(struct platform_device *pdev)
 {
 	int r;
 
+	sdi.pdev = pdev;
+
 	sdi_init_output(pdev);
 
 	if (pdev->dev.platform_data) {
@@ -384,6 +395,11 @@ static int __exit omap_sdi_remove(struct platform_device *pdev)
 
 	sdi_uninit_output(pdev);
 
+	if (sdi.vdds_sdi_reg != NULL && sdi.vdds_sdi_from_core = false) {
+		regulator_put(sdi.vdds_sdi_reg);
+		sdi.vdds_sdi_reg = NULL;
+	}
+
 	return 0;
 }
 
-- 
1.8.1.2

