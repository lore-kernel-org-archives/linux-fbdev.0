From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 28 Apr 2016 12:56:23 +0000
Subject: [PATCH] video: fbdev: omap2: Remove deprecated regulator_can_change_voltage() usage
Message-Id: <1461848183-3634-1-git-send-email-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com
Cc: robdclark@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

regulator_can_change_voltage() is deprecated and it's use is not necessary
as commit:
6a0028b3dd67b regulator: Deprecate regulator_can_change_voltage()
describers it clearly.
As there is no practical use of it it can be removed.
At this point the regulator_set_voltage() calls can not be removed as the
DT data need to be fixed first.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c   | 12 +++++-------
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c | 12 +++++-------
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c | 12 +++++-------
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index 0eec073b3919..d63e59807707 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -1180,13 +1180,11 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 		return PTR_ERR(vdds_dsi);
 	}
 
-	if (regulator_can_change_voltage(vdds_dsi)) {
-		r = regulator_set_voltage(vdds_dsi, 1800000, 1800000);
-		if (r) {
-			devm_regulator_put(vdds_dsi);
-			DSSERR("can't set the DSI regulator voltage\n");
-			return r;
-		}
+	r = regulator_set_voltage(vdds_dsi, 1800000, 1800000);
+	if (r) {
+		devm_regulator_put(vdds_dsi);
+		DSSERR("can't set the DSI regulator voltage\n");
+		return r;
 	}
 
 	dsi->vdds_dsi_reg = vdds_dsi;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
index 7103c659a534..2e71aec838b1 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
@@ -114,13 +114,11 @@ static int hdmi_init_regulator(void)
 		return PTR_ERR(reg);
 	}
 
-	if (regulator_can_change_voltage(reg)) {
-		r = regulator_set_voltage(reg, 1800000, 1800000);
-		if (r) {
-			devm_regulator_put(reg);
-			DSSWARN("can't set the regulator voltage\n");
-			return r;
-		}
+	r = regulator_set_voltage(reg, 1800000, 1800000);
+	if (r) {
+		devm_regulator_put(reg);
+		DSSWARN("can't set the regulator voltage\n");
+		return r;
 	}
 
 	hdmi.vdda_reg = reg;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
index a955a2c4c061..aade6d99662a 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
@@ -131,13 +131,11 @@ static int hdmi_init_regulator(void)
 		return PTR_ERR(reg);
 	}
 
-	if (regulator_can_change_voltage(reg)) {
-		r = regulator_set_voltage(reg, 1800000, 1800000);
-		if (r) {
-			devm_regulator_put(reg);
-			DSSWARN("can't set the regulator voltage\n");
-			return r;
-		}
+	r = regulator_set_voltage(reg, 1800000, 1800000);
+	if (r) {
+		devm_regulator_put(reg);
+		DSSWARN("can't set the regulator voltage\n");
+		return r;
 	}
 
 	hdmi.vdda_reg = reg;
-- 
2.8.1

