From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 24 Sep 2012 13:58:33 +0000
Subject: [PATCH 3/9] OMAPDSS: move dss feats to the end of dss.c
Message-Id: <1348495119-8262-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Move dss_features to the end of dss.c the same way they are in dispc.c,
so that we don't have to declare prototypes for static feat-related
functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   60 ++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 4524c17..660813b 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -99,36 +99,6 @@ static const char * const dss_generic_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_FCK",
 };
 
-static const struct dss_features omap24xx_dss_feats __initconst = {
-	.fck_div_max		=	16,
-	.dss_fck_multiplier	=	2,
-	.clk_name		=	NULL,
-};
-
-static const struct dss_features omap34xx_dss_feats __initconst = {
-	.fck_div_max		=	16,
-	.dss_fck_multiplier	=	2,
-	.clk_name		=	"dpll4_m4_ck",
-};
-
-static const struct dss_features omap3630_dss_feats __initconst = {
-	.fck_div_max		=	32,
-	.dss_fck_multiplier	=	1,
-	.clk_name		=	"dpll4_m4_ck",
-};
-
-static const struct dss_features omap44xx_dss_feats __initconst = {
-	.fck_div_max		=	32,
-	.dss_fck_multiplier	=	1,
-	.clk_name		=	"dpll_per_m5x2_ck",
-};
-
-static const struct dss_features omap54xx_dss_feats __initconst = {
-	.fck_div_max		=	64,
-	.dss_fck_multiplier	=	1,
-	.clk_name		=	"dpll_per_h12x2_ck",
-};
-
 static inline void dss_write_reg(const struct dss_reg idx, u32 val)
 {
 	__raw_writel(val, dss.base + idx.idx);
@@ -727,6 +697,36 @@ void dss_debug_dump_clocks(struct seq_file *s)
 }
 #endif
 
+static const struct dss_features omap24xx_dss_feats __initconst = {
+	.fck_div_max		=	16,
+	.dss_fck_multiplier	=	2,
+	.clk_name		=	NULL,
+};
+
+static const struct dss_features omap34xx_dss_feats __initconst = {
+	.fck_div_max		=	16,
+	.dss_fck_multiplier	=	2,
+	.clk_name		=	"dpll4_m4_ck",
+};
+
+static const struct dss_features omap3630_dss_feats __initconst = {
+	.fck_div_max		=	32,
+	.dss_fck_multiplier	=	1,
+	.clk_name		=	"dpll4_m4_ck",
+};
+
+static const struct dss_features omap44xx_dss_feats __initconst = {
+	.fck_div_max		=	32,
+	.dss_fck_multiplier	=	1,
+	.clk_name		=	"dpll_per_m5x2_ck",
+};
+
+static const struct dss_features omap54xx_dss_feats __initconst = {
+	.fck_div_max		=	64,
+	.dss_fck_multiplier	=	1,
+	.clk_name		=	"dpll_per_h12x2_ck",
+};
+
 static int __init dss_init_features(struct device *dev)
 {
 	const struct dss_features *src;
-- 
1.7.9.5

