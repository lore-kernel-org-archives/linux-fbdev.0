From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 01 Mar 2012 12:34:40 +0000
Subject: [PATCH 1/7] OMAP: DSS2: HDMI: use default dividers
Message-Id: <1330605286-24166-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1330605286-24166-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mythri P K <mythripk@ti.com>

Use default regn and regm2 dividers in the hdmi driver if the board file
does not define them.

Pandaboard's board file was missing the dividers, causing HDMI output
not to work, so this patch fixes the problem.

Backported from 8d88767a4377171752c22ac39bcb2b505eb751da

Cc: Mythri P K <mythripk@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    9 ---------
 drivers/video/omap2/dss/hdmi.c      |   15 +++++++++++++--
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 63de2d3..f515fa2 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -617,15 +617,6 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
 	.type = OMAP_DISPLAY_TYPE_HDMI,
-	.clocks	= {
-		.dispc	= {
-			.dispc_fclk_src	= OMAP_DSS_CLK_SRC_FCK,
-		},
-		.hdmi	= {
-			.regn	= 15,
-			.regm2	= 1,
-		},
-	},
 	.platform_enable = sdp4430_panel_enable_hdmi,
 	.platform_disable = sdp4430_panel_disable_hdmi,
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b0555f4..f3369cf 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -40,6 +40,9 @@
 #include "hdmi.h"
 #include "dss_features.h"
 
+#define HDMI_DEFAULT_REGN 15
+#define HDMI_DEFAULT_REGM2 1
+
 static struct {
 	struct mutex lock;
 	struct omap_display_platform_data *pdata;
@@ -1069,7 +1072,11 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	 * Input clock is predivided by N + 1
 	 * out put of which is reference clk
 	 */
-	pi->regn = dssdev->clocks.hdmi.regn;
+	if (dssdev->clocks.hdmi.regn = 0)
+		pi->regn = HDMI_DEFAULT_REGN;
+	else
+		pi->regn = dssdev->clocks.hdmi.regn;
+
 	refclk = clkin / (pi->regn + 1);
 
 	/*
@@ -1077,7 +1084,11 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	 * Multiplying by 100 to avoid fractional part removal
 	 */
 	pi->regm = (phy * 100 / (refclk)) / 100;
-	pi->regm2 = dssdev->clocks.hdmi.regm2;
+
+	if (dssdev->clocks.hdmi.regm2 = 0)
+		pi->regm2 = HDMI_DEFAULT_REGM2;
+	else
+		pi->regm2 = dssdev->clocks.hdmi.regm2;
 
 	/*
 	 * fractional multiplier is remainder of the difference between
-- 
1.7.4.1

