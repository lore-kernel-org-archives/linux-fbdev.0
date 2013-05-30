From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:34:38 +0000
Subject: [PATCH 17/32] OMAPDSS: SDI: clean up regulator init
Message-Id: <1369906493-27538-18-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Clean up the SDI driver's regulator init to remove the (unused)
omap_dss_device parameter, renaming the function to a more sensible
name, and making the code slightly clearer.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/sdi.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 2e3afb8..9801a6e 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -251,30 +251,31 @@ void omapdss_sdi_set_datapairs(struct omap_dss_device *dssdev, int datapairs)
 }
 EXPORT_SYMBOL(omapdss_sdi_set_datapairs);
 
-static int sdi_init_display(struct omap_dss_device *dssdev)
+static int sdi_init_regulator(void)
 {
-	DSSDBG("SDI init\n");
-
-	if (sdi.vdds_sdi_reg = NULL) {
-		struct regulator *vdds_sdi;
-
-		vdds_sdi = dss_get_vdds_sdi();
-
-		if (IS_ERR(vdds_sdi)) {
-			vdds_sdi = regulator_get(&sdi.pdev->dev, "vdds_sdi");
-			if (IS_ERR(vdds_sdi)) {
-				DSSERR("can't get VDDS_SDI regulator\n");
-				return PTR_ERR(vdds_sdi);
-			}
-			sdi.vdds_sdi_from_core = false;
-		} else {
-			sdi.vdds_sdi_from_core = true;
-		}
+	struct regulator *vdds_sdi;
+
+	if (sdi.vdds_sdi_reg != NULL)
+		return 0;
 
+	vdds_sdi = dss_get_vdds_sdi();
+
+	if (!IS_ERR(vdds_sdi)) {
+		sdi.vdds_sdi_from_core = true;
 		sdi.vdds_sdi_reg = vdds_sdi;
+		return 0;
 	}
 
-	return 0;
+	vdds_sdi = regulator_get(&sdi.pdev->dev, "vdds_sdi");
+
+	if (!IS_ERR(vdds_sdi)) {
+		sdi.vdds_sdi_from_core = false;
+		sdi.vdds_sdi_reg = vdds_sdi;
+	}
+
+	DSSERR("can't get VDDS_SDI regulator\n");
+
+	return PTR_ERR(vdds_sdi);
 }
 
 static struct omap_dss_device *sdi_find_dssdev(struct platform_device *pdev)
@@ -322,7 +323,7 @@ static int sdi_probe_pdata(struct platform_device *sdidev)
 
 	dss_copy_device_pdata(dssdev, plat_dssdev);
 
-	r = sdi_init_display(dssdev);
+	r = sdi_init_regulator();
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
 		dss_put_device(dssdev);
-- 
1.8.1.2

