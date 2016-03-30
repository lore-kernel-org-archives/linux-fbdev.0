From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Mar 2016 16:29:36 +0000
Subject: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
Message-Id: <1459355376-28507-1-git-send-email-broonie@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The voltage changing code in this driver is broken and should be
removed.  The driver sets a single, exact voltage on probe.  Unless
there is a very good reason for this (which should be documented in
comments) constraints like this need to be set via the machine
constraints, voltage setting in a driver is expected to be used in cases
where the voltage varies at runtime.

In addition client drivers should almost never be calling
regulator_can_set_voltage(), if the device needs to set a voltage it
needs to set the voltage and the regulator core will handle the case
where the regulator is fixed voltage.  If the driver can skip setting
the voltage it should just never set the voltage.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c   | 9 ---------
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index 0eec073b3919..cfd0e3d5f36a 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -1180,15 +1180,6 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 		return PTR_ERR(vdds_dsi);
 	}
 
-	if (regulator_can_change_voltage(vdds_dsi)) {
-		r = regulator_set_voltage(vdds_dsi, 1800000, 1800000);
-		if (r) {
-			devm_regulator_put(vdds_dsi);
-			DSSERR("can't set the DSI regulator voltage\n");
-			return r;
-		}
-	}
-
 	dsi->vdds_dsi_reg = vdds_dsi;
 
 	return 0;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
index 7103c659a534..68b5ce1610ea 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
@@ -114,15 +114,6 @@ static int hdmi_init_regulator(void)
 		return PTR_ERR(reg);
 	}
 
-	if (regulator_can_change_voltage(reg)) {
-		r = regulator_set_voltage(reg, 1800000, 1800000);
-		if (r) {
-			devm_regulator_put(reg);
-			DSSWARN("can't set the regulator voltage\n");
-			return r;
-		}
-	}
-
 	hdmi.vdda_reg = reg;
 
 	return 0;
-- 
2.8.0.rc3

