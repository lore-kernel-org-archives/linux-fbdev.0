From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 24 Sep 2012 13:58:38 +0000
Subject: [PATCH 8/9] OMAPDSS: DSI: Add code to disable PHY DCC
Message-Id: <1348495119-8262-9-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP5 DSI PHY has DCC (Duty Cycle Corrector) block, and by default DCC
is enabled and thus the PLL clock is divided by 2 to get the DSI DDR
clk. This divider has been 4 for all previous OMAPs, and changing it
needs some reorganization of the code. The DCC can be disabled, and in
that case the divider is back to the old 4.

This patch adds dss feature for the DCC, and adds code to always disable
the DCC.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c          |    7 +++++++
 drivers/video/omap2/dss/dss_features.c |    1 +
 drivers/video/omap2/dss/dss_features.h |    1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 0dc24f2..497b219 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2292,6 +2292,13 @@ static void dsi_cio_timings(struct platform_device *dsidev)
 	r = FLD_MOD(r, tlpx_half, 22, 16);
 	r = FLD_MOD(r, tclk_trail, 15, 8);
 	r = FLD_MOD(r, tclk_zero, 7, 0);
+
+	if (dss_has_feature(FEAT_DSI_PHY_DCC)) {
+		r = FLD_MOD(r, 0, 21, 21);	/* DCCEN = disable */
+		r = FLD_MOD(r, 1, 22, 22);	/* CLKINP_DIVBY2EN = enable */
+		r = FLD_MOD(r, 1, 23, 23);	/* CLKINP_SEL = enable */
+	}
+
 	dsi_write_reg(dsidev, DSI_DSIPHY_CFG1, r);
 
 	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG2);
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 4685531..e650a4a 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -521,6 +521,7 @@ static const enum dss_feat_id omap5_dss_feat_list[] = {
 	FEAT_BURST_2D,
 	FEAT_DSI_PLL_SELFREQDCO,
 	FEAT_DSI_PLL_REFSEL,
+	FEAT_DSI_PHY_DCC,
 };
 
 /* OMAP2 DSS Features */
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 0020bf6..aacad86 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -67,6 +67,7 @@ enum dss_feat_id {
 	FEAT_BURST_2D,
 	FEAT_DSI_PLL_SELFREQDCO,
 	FEAT_DSI_PLL_REFSEL,
+	FEAT_DSI_PHY_DCC,
 };
 
 /* DSS register field id */
-- 
1.7.9.5

