From: Archit Taneja <archit@ti.com>
Date: Thu, 17 Oct 2013 11:38:42 +0000
Subject: [PATCH 6/6] omapdss: hdmi4/hdmi5: set regulator voltage to required level
Message-Id: <1382009202-18984-7-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382009202-18984-1-git-send-email-archit@ti.com>
In-Reply-To: <1382009202-18984-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Somnath Mukherjee <somnath@ti.com>

It's not sufficient to request the regulator. We need to set the IO voltage as
well if the min and max voltage values of the regulator differ.

However, if the regulator on a platform doesn't permit the range we requested
for, or is a fixed voltage regulator, we just give a warning that we didn't get
voltage range we requested for. The recommended voltage range for vdda_hdmi as
per the HDMI PHY spec is 1.8V to 1.98V for OMAP4 and 1.5V to 1.8V for OMAP5.

Originally worked on by Somnath Mukherjee <somnath@ti.com>

Cc: Somnath Mukherjee <somnath@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi4.c | 5 +++++
 drivers/video/omap2/dss/hdmi5.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index e140096..95638b8 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -83,6 +83,7 @@ static void hdmi_runtime_put(void)
 
 static int hdmi_init_regulator(void)
 {
+	int r;
 	struct regulator *reg;
 
 	if (hdmi.vdda_hdmi_dac_reg != NULL)
@@ -99,6 +100,10 @@ static int hdmi_init_regulator(void)
 		return PTR_ERR(reg);
 	}
 
+	r = regulator_set_voltage(reg, 1800000, 1980000);
+	if (r)
+		DSSWARN("can't set regulator voltage");
+
 	hdmi.vdda_hdmi_dac_reg = reg;
 
 	return 0;
diff --git a/drivers/video/omap2/dss/hdmi5.c b/drivers/video/omap2/dss/hdmi5.c
index 5a1cfd6..aa91f4e 100644
--- a/drivers/video/omap2/dss/hdmi5.c
+++ b/drivers/video/omap2/dss/hdmi5.c
@@ -85,6 +85,7 @@ static void hdmi_runtime_put(void)
 
 static int hdmi_init_regulator(void)
 {
+	int r;
 	struct regulator *reg;
 
 	if (hdmi.vdda_hdmi_dac_reg != NULL)
@@ -96,6 +97,10 @@ static int hdmi_init_regulator(void)
 		return PTR_ERR(reg);
 	}
 
+	r = regulator_set_voltage(reg, 1500000, 1800000);
+	if (r)
+		DSSWARN("can't set regulator voltage");
+
 	hdmi.vdda_hdmi_dac_reg = reg;
 
 	return 0;
-- 
1.8.1.2

