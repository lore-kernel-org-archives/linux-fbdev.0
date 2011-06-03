From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 03 Jun 2011 10:00:14 +0000
Subject: [PATCH 04/27] OMAP: DSS2: Handle dpll4_m4_ck in dss_get/put_clocks
Message-Id: <1307095237-14805-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Get and put for dpll4_m4_ck was handled in dss_init/dss_exit. Move the
code to dss_get/put_clocks(), which is a better place to handle it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   52 ++++++++++++++++++++--------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index d0b3f81..3eed8a2 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -669,7 +669,6 @@ static int dss_init(void)
 	int r;
 	u32 rev;
 	struct resource *dss_mem;
-	struct clk *dpll4_m4_ck;
 
 	dss_mem = platform_get_resource(dss.pdev, IORESOURCE_MEM, 0);
 	if (!dss_mem) {
@@ -715,26 +714,6 @@ static int dss_init(void)
 	REG_FLD_MOD(DSS_CONTROL, 1, 3, 3);	/* venc clock 4x enable */
 	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
 #endif
-	if (cpu_is_omap34xx()) {
-		dpll4_m4_ck = clk_get(NULL, "dpll4_m4_ck");
-		if (IS_ERR(dpll4_m4_ck)) {
-			DSSERR("Failed to get dpll4_m4_ck\n");
-			r = PTR_ERR(dpll4_m4_ck);
-			goto fail1;
-		}
-	} else if (cpu_is_omap44xx()) {
-		dpll4_m4_ck = clk_get(NULL, "dpll_per_m5x2_ck");
-		if (IS_ERR(dpll4_m4_ck)) {
-			DSSERR("Failed to get dpll4_m4_ck\n");
-			r = PTR_ERR(dpll4_m4_ck);
-			goto fail1;
-		}
-	} else { /* omap24xx */
-		dpll4_m4_ck = NULL;
-	}
-
-	dss.dpll4_m4_ck = dpll4_m4_ck;
-
 	dss.dsi_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.dsi_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 	dss.dispc_clk_source = OMAP_DSS_CLK_SRC_FCK;
@@ -749,17 +728,12 @@ static int dss_init(void)
 
 	return 0;
 
-fail1:
-	iounmap(dss.base);
 fail0:
 	return r;
 }
 
 static void dss_exit(void)
 {
-	if (dss.dpll4_m4_ck)
-		clk_put(dss.dpll4_m4_ck);
-
 	iounmap(dss.base);
 }
 
@@ -845,6 +819,7 @@ static int dss_get_clock(struct clk **clock, const char *clk_name)
 static int dss_get_clocks(void)
 {
 	int r;
+	struct clk *dpll4_m4_ck;
 	struct omap_display_platform_data *pdata = dss.pdev->dev.platform_data;
 
 	dss.dss_ick = NULL;
@@ -884,6 +859,27 @@ static int dss_get_clocks(void)
 			goto err;
 	}
 
+	if (cpu_is_omap34xx()) {
+		dpll4_m4_ck = clk_get(NULL, "dpll4_m4_ck");
+		if (IS_ERR(dpll4_m4_ck)) {
+			DSSERR("Failed to get dpll4_m4_ck\n");
+			r = PTR_ERR(dpll4_m4_ck);
+			goto err;
+		}
+	} else if (cpu_is_omap44xx()) {
+		dpll4_m4_ck = clk_get(NULL, "dpll_per_m5x2_ck");
+		if (IS_ERR(dpll4_m4_ck)) {
+			DSSERR("Failed to get dpll4_m4_ck\n");
+			r = PTR_ERR(dpll4_m4_ck);
+			goto err;
+		}
+	} else { /* omap24xx */
+		dpll4_m4_ck = NULL;
+	}
+
+	dss.dpll4_m4_ck = dpll4_m4_ck;
+
+
 	return 0;
 
 err:
@@ -897,12 +893,16 @@ err:
 		clk_put(dss.dss_tv_fck);
 	if (dss.dss_video_fck)
 		clk_put(dss.dss_video_fck);
+	if (dss.dpll4_m4_ck)
+		clk_put(dss.dpll4_m4_ck);
 
 	return r;
 }
 
 static void dss_put_clocks(void)
 {
+	if (dss.dpll4_m4_ck)
+		clk_put(dss.dpll4_m4_ck);
 	if (dss.dss_video_fck)
 		clk_put(dss.dss_video_fck);
 	if (dss.dss_tv_fck)
-- 
1.7.4.1

