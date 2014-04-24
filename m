From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 10:17:00 +0000
Subject: [PATCH 04/23] OMAPDSS: DSI: set regulator voltage to 1.8V
Message-Id: <1398334639-14172-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Set the DSI vdd regulator voltage to the required 1.8V.

This is required for the case when the regulator in the DT data defines
a range of allowed voltages. In this case it's required to set the
voltage, as otherwise enabling the voltage fails.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 8be9b04d8849..57f120896b43 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -1161,6 +1161,7 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct regulator *vdds_dsi;
+	int r;
 
 	if (dsi->vdds_dsi_reg != NULL)
 		return 0;
@@ -1173,6 +1174,15 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 		return PTR_ERR(vdds_dsi);
 	}
 
+	if (regulator_can_change_voltage(vdds_dsi)) {
+		r = regulator_set_voltage(vdds_dsi, 1800000, 1800000);
+		if (r) {
+			devm_regulator_put(vdds_dsi);
+			DSSERR("can't set the DSI regulator voltage\n");
+			return r;
+		}
+	}
+
 	dsi->vdds_dsi_reg = vdds_dsi;
 
 	return 0;
-- 
1.9.1

