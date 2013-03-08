From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Mar 2013 11:52:45 +0000
Subject: [PATCH 10/14] OMAPDSS: SDI: use new clock calculation code
Message-Id: <1362743569-10289-11-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new clock calculation code in the SDI driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/sdi.c |   68 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index eb4ee17..5754245 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -41,6 +41,72 @@ static struct {
 	struct omap_dss_output output;
 } sdi;
 
+struct sdi_clk_calc_ctx {
+	unsigned long pck_min, pck_max;
+
+	struct dss_clock_info dss_cinfo;
+	struct dispc_clock_info dispc_cinfo;
+};
+
+static bool dpi_calc_dispc_cb(int lckd, int pckd, unsigned long lck,
+		unsigned long pck, void *data)
+{
+	struct sdi_clk_calc_ctx *ctx = data;
+
+	ctx->dispc_cinfo.lck_div = lckd;
+	ctx->dispc_cinfo.pck_div = pckd;
+	ctx->dispc_cinfo.lck = lck;
+	ctx->dispc_cinfo.pck = pck;
+
+	return true;
+}
+
+static bool dpi_calc_dss_cb(int fckd, unsigned long fck, void *data)
+{
+	struct sdi_clk_calc_ctx *ctx = data;
+
+	ctx->dss_cinfo.fck = fck;
+	ctx->dss_cinfo.fck_div = fckd;
+
+	return dispc_div_calc(fck, ctx->pck_min, ctx->pck_max,
+			dpi_calc_dispc_cb, ctx);
+}
+
+static int sdi_calc_clock_div(unsigned long pclk,
+		struct dss_clock_info *dss_cinfo,
+		struct dispc_clock_info *dispc_cinfo)
+{
+	int i;
+	struct sdi_clk_calc_ctx ctx;
+
+	/*
+	 * DSS fclk gives us very few possibilities, so finding a good pixel
+	 * clock may not be possible. We try multiple times to find the clock,
+	 * each time widening the pixel clock range we look for, up to
+	 * +/- 1MHz.
+	 */
+
+	for (i = 0; i < 10; ++i) {
+		bool ok;
+
+		memset(&ctx, 0, sizeof(ctx));
+		if (pclk > 1000 * i * i * i)
+			ctx.pck_min = max(pclk - 1000 * i * i * i, 0lu);
+		else
+			ctx.pck_min = 0;
+		ctx.pck_max = pclk + 1000 * i * i * i;
+
+		ok = dss_div_calc(ctx.pck_min, dpi_calc_dss_cb, &ctx);
+		if (ok) {
+			*dss_cinfo = ctx.dss_cinfo;
+			*dispc_cinfo = ctx.dispc_cinfo;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
 {
 	struct omap_overlay_manager *mgr = dssdev->output->manager;
@@ -88,7 +154,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	t->data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 	t->sync_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 
-	r = dss_calc_clock_div(t->pixel_clock * 1000, &dss_cinfo, &dispc_cinfo);
+	r = sdi_calc_clock_div(t->pixel_clock * 1000, &dss_cinfo, &dispc_cinfo);
 	if (r)
 		goto err_calc_clock_div;
 
-- 
1.7.10.4

