From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 18 Nov 2013 12:39:03 +0000
Subject: [PATCH 6/7] OMAPDSS: pass pck to dss fck clock calc
Message-Id: <1384778344-8226-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

We need the required pixel clock rate when calculating the dss fclk on
SoCs that have a dedicated DSS PLL.

This patch changes the code to pass the pck to the calc functions. The
pck rate is taken into use in the next patch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c | 2 +-
 drivers/video/omap2/dss/dss.c | 3 ++-
 drivers/video/omap2/dss/dss.h | 3 ++-
 drivers/video/omap2/dss/sdi.c | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 16acddd..ae1c8b9 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -236,7 +236,7 @@ static bool dpi_dss_clk_calc(unsigned long pck, struct dpi_clk_calc_ctx *ctx)
 			ctx->pck_min = 0;
 		ctx->pck_max = pck + 1000 * i * i * i;
 
-		ok = dss_div_calc(ctx->pck_min, dpi_calc_dss_cb, ctx);
+		ok = dss_div_calc(pck, ctx->pck_min, dpi_calc_dss_cb, ctx);
 		if (ok)
 			return ok;
 	}
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 7af9719..08c58eb 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -436,7 +436,8 @@ enum omap_dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel)
 	}
 }
 
-bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data)
+bool dss_div_calc(unsigned long pck, unsigned long fck_min,
+		dss_div_calc_func func, void *data)
 {
 	int fckd, fckd_start, fckd_stop;
 	unsigned long fck;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6fc786f..2acc661 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -245,7 +245,8 @@ void dss_set_dac_pwrdn_bgz(bool enable);
 int dss_set_fck_rate(unsigned long rate);
 
 typedef bool (*dss_div_calc_func)(unsigned long fck, void *data);
-bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data);
+bool dss_div_calc(unsigned long pck, unsigned long fck_min,
+		dss_div_calc_func func, void *data);
 
 /* SDI */
 int sdi_init_platform_driver(void) __init;
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 221fd34..3bf47c9 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -97,7 +97,7 @@ static int sdi_calc_clock_div(unsigned long pclk,
 			ctx.pck_min = 0;
 		ctx.pck_max = pclk + 1000 * i * i * i;
 
-		ok = dss_div_calc(ctx.pck_min, dpi_calc_dss_cb, &ctx);
+		ok = dss_div_calc(pclk, ctx.pck_min, dpi_calc_dss_cb, &ctx);
 		if (ok) {
 			*fck = ctx.fck;
 			*dispc_cinfo = ctx.dispc_cinfo;
-- 
1.8.3.2

