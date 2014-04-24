From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 10:16:59 +0000
Subject: [PATCH 03/23] OMAPDSS: HDMI4: set regulator voltage to 1.8V
Message-Id: <1398334639-14172-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Set the HDMI vdda regulator voltage to the required 1.8V.

This is required for the case when the regulator in the DT data defines
a range of allowed voltages. In this case it's required to set the
voltage, as otherwise enabling the voltage fails.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index e15b89d49c28..5c7dd5c06593 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -83,6 +83,7 @@ static void hdmi_runtime_put(void)
 
 static int hdmi_init_regulator(void)
 {
+	int r;
 	struct regulator *reg;
 
 	if (hdmi.vdda_hdmi_dac_reg != NULL)
@@ -96,6 +97,15 @@ static int hdmi_init_regulator(void)
 		return PTR_ERR(reg);
 	}
 
+	if (regulator_can_change_voltage(reg)) {
+		r = regulator_set_voltage(reg, 1800000, 1800000);
+		if (r) {
+			devm_regulator_put(reg);
+			DSSWARN("can't set the regulator voltage\n");
+			return r;
+		}
+	}
+
 	hdmi.vdda_hdmi_dac_reg = reg;
 
 	return 0;
-- 
1.9.1

