From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 24 Sep 2012 13:58:35 +0000
Subject: [PATCH 5/9] OMAPDSS: DSI: Add FEAT_DSI_PLL_SELFREQDCO
Message-Id: <1348495119-8262-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add FEAT_DSI_PLL_SELFREQDCO. OMAP5's DSI PLL has a new configuration
option that needs to be programmed depending on the PLL's output clock
frequency.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c          |   12 ++++++++----
 drivers/video/omap2/dss/dss_features.c |    1 +
 drivers/video/omap2/dss/dss_features.h |    1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8d47fb7..0c3afc2 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1671,18 +1671,22 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 
 	BUG_ON(cinfo->fint < dsi->fint_min || cinfo->fint > dsi->fint_max);
 
+	l = dsi_read_reg(dsidev, DSI_PLL_CONFIGURATION2);
+
 	if (dss_has_feature(FEAT_DSI_PLL_FREQSEL)) {
 		f = cinfo->fint < 1000000 ? 0x3 :
 			cinfo->fint < 1250000 ? 0x4 :
 			cinfo->fint < 1500000 ? 0x5 :
 			cinfo->fint < 1750000 ? 0x6 :
 			0x7;
-	}
-
-	l = dsi_read_reg(dsidev, DSI_PLL_CONFIGURATION2);
 
-	if (dss_has_feature(FEAT_DSI_PLL_FREQSEL))
 		l = FLD_MOD(l, f, 4, 1);	/* DSI_PLL_FREQSEL */
+	} else if (dss_has_feature(FEAT_DSI_PLL_SELFREQDCO)) {
+		f = cinfo->clkin4ddr < 1000000000 ? 0x2 : 0x4;
+
+		l = FLD_MOD(l, f, 4, 1);	/* PLL_SELFREQDCO */
+	}
+
 	l = FLD_MOD(l, 1, 13, 13);		/* DSI_PLL_REFEN */
 	l = FLD_MOD(l, 0, 14, 14);		/* DSIPHY_CLKINEN */
 	l = FLD_MOD(l, 1, 20, 20);		/* DSI_HSDIVBYPASS */
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index af4775a..177f6e8 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -519,6 +519,7 @@ static const enum dss_feat_id omap5_dss_feat_list[] = {
 	FEAT_ALPHA_FREE_ZORDER,
 	FEAT_FIFO_MERGE,
 	FEAT_BURST_2D,
+	FEAT_DSI_PLL_SELFREQDCO,
 };
 
 /* OMAP2 DSS Features */
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index b81d603..f9b9d28 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -65,6 +65,7 @@ enum dss_feat_id {
 	/* An unknown HW bug causing the normal FIFO thresholds not to work */
 	FEAT_OMAP3_DSI_FIFO_BUG,
 	FEAT_BURST_2D,
+	FEAT_DSI_PLL_SELFREQDCO,
 };
 
 /* DSS register field id */
-- 
1.7.9.5

