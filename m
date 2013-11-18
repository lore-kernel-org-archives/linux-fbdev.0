From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 18 Nov 2013 12:39:02 +0000
Subject: [PATCH 5/7] OMAPDSS: cleanup fck parent handling
Message-Id: <1384778344-8226-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The dss parent_clk_name currently points to a clock node which we use to
change the fclk rate. Now that we have CLK_SET_RATE_PARENT properly set,
we can set the rate directly to the fclk node.

However, we still need to calculate the possible clock rates. For this,
we need the rate of the parent of the current parent_clk.

To simplify the code, this patch changes the parent_clk_name to point to
the above mentioned parent, so that we can get the rate directly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c | 39 ++++++++++++---------------------------
 drivers/video/omap2/dss/dss.h |  1 -
 2 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index d510ba3..7af9719 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -454,7 +454,7 @@ bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data)
 	fckd_hw_max = dss.feat->fck_div_max;
 
 	m = dss.feat->dss_fck_multiplier;
-	prate = dss_get_dpll4_rate();
+	prate = clk_get_rate(dss.parent_clk);
 
 	fck_min = fck_min ? fck_min : 1;
 
@@ -473,20 +473,13 @@ bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data)
 
 int dss_set_fck_rate(unsigned long rate)
 {
-	DSSDBG("set fck to %lu\n", rate);
-
-	if (dss.parent_clk) {
-		unsigned long prate;
-		unsigned m;
-		int r;
+	int r;
 
-		prate = clk_get_rate(clk_get_parent(dss.parent_clk));
-		m = dss.feat->dss_fck_multiplier;
+	DSSDBG("set fck to %lu\n", rate);
 
-		r = clk_set_rate(dss.parent_clk, rate * m);
-		if (r)
-			return r;
-	}
+	r = clk_set_rate(dss.dss_clk, rate);
+	if (r)
+		return r;
 
 	dss.dss_clk_rate = clk_get_rate(dss.dss_clk);
 
@@ -497,14 +490,6 @@ int dss_set_fck_rate(unsigned long rate)
 	return 0;
 }
 
-unsigned long dss_get_dpll4_rate(void)
-{
-	if (dss.parent_clk)
-		return clk_get_rate(clk_get_parent(dss.parent_clk));
-	else
-		return 0;
-}
-
 unsigned long dss_get_dispc_clk_rate(void)
 {
 	return dss.dss_clk_rate;
@@ -522,7 +507,7 @@ static int dss_setup_default_clock(void)
 
 	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
-	prate = dss_get_dpll4_rate();
+	prate = clk_get_rate(dss.parent_clk);
 
 	fck_div = DIV_ROUND_UP(prate * dss.feat->dss_fck_multiplier,
 			max_dss_fck);
@@ -715,35 +700,35 @@ static const struct dss_features omap24xx_dss_feats __initconst = {
 	 */
 	.fck_div_max		=	6,
 	.dss_fck_multiplier	=	2,
-	.parent_clk_name	=	"dss1_fck",
+	.parent_clk_name	=	"core_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
 
 static const struct dss_features omap34xx_dss_feats __initconst = {
 	.fck_div_max		=	16,
 	.dss_fck_multiplier	=	2,
-	.parent_clk_name	=	"dpll4_m4_ck",
+	.parent_clk_name	=	"dpll4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
 
 static const struct dss_features omap3630_dss_feats __initconst = {
 	.fck_div_max		=	32,
 	.dss_fck_multiplier	=	1,
-	.parent_clk_name	=	"dpll4_m4_ck",
+	.parent_clk_name	=	"dpll4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
 
 static const struct dss_features omap44xx_dss_feats __initconst = {
 	.fck_div_max		=	32,
 	.dss_fck_multiplier	=	1,
-	.parent_clk_name	=	"dpll_per_m5x2_ck",
+	.parent_clk_name	=	"dpll_per_x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap4,
 };
 
 static const struct dss_features omap54xx_dss_feats __initconst = {
 	.fck_div_max		=	64,
 	.dss_fck_multiplier	=	1,
-	.parent_clk_name	=	"dpll_per_h12x2_ck",
+	.parent_clk_name	=	"dpll_per_x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap5,
 };
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index ead1960..6fc786f 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -242,7 +242,6 @@ enum omap_dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel);
 void dss_set_venc_output(enum omap_dss_venc_type type);
 void dss_set_dac_pwrdn_bgz(bool enable);
 
-unsigned long dss_get_dpll4_rate(void);
 int dss_set_fck_rate(unsigned long rate);
 
 typedef bool (*dss_div_calc_func)(unsigned long fck, void *data);
-- 
1.8.3.2

