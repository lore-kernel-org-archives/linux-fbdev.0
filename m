From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 24 Sep 2012 13:58:36 +0000
Subject: [PATCH 6/9] OMAPDSS: DSI: Add FEAT_DSI_PLL_REFSEL
Message-Id: <1348495119-8262-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add FEAT_DSI_PLL_REFSEL. OMAP5's DSI PLL needs configuration to select
the reference clock to be used. We always use SYSCLK.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c          |    2 ++
 drivers/video/omap2/dss/dss_features.c |    1 +
 drivers/video/omap2/dss/dss_features.h |    1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 0c3afc2..a16c8b2 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1690,6 +1690,8 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 	l = FLD_MOD(l, 1, 13, 13);		/* DSI_PLL_REFEN */
 	l = FLD_MOD(l, 0, 14, 14);		/* DSIPHY_CLKINEN */
 	l = FLD_MOD(l, 1, 20, 20);		/* DSI_HSDIVBYPASS */
+	if (dss_has_feature(FEAT_DSI_PLL_REFSEL))
+		l = FLD_MOD(l, 3, 22, 21);	/* REF_SYSCLK = sysclk */
 	dsi_write_reg(dsidev, DSI_PLL_CONFIGURATION2, l);
 
 	REG_FLD_MOD(dsidev, DSI_PLL_GO, 1, 0, 0);	/* DSI_PLL_GO */
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 177f6e8..4685531 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -520,6 +520,7 @@ static const enum dss_feat_id omap5_dss_feat_list[] = {
 	FEAT_FIFO_MERGE,
 	FEAT_BURST_2D,
 	FEAT_DSI_PLL_SELFREQDCO,
+	FEAT_DSI_PLL_REFSEL,
 };
 
 /* OMAP2 DSS Features */
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index f9b9d28..0020bf6 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -66,6 +66,7 @@ enum dss_feat_id {
 	FEAT_OMAP3_DSI_FIFO_BUG,
 	FEAT_BURST_2D,
 	FEAT_DSI_PLL_SELFREQDCO,
+	FEAT_DSI_PLL_REFSEL,
 };
 
 /* DSS register field id */
-- 
1.7.9.5

