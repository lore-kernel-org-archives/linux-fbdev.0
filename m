From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 03 Jun 2011 10:00:34 +0000
Subject: [PATCH 24/27] OMAP: DSS2: Remove ctx loss count from dss.c
Message-Id: <1307095237-14805-25-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dss.c only saves 1 register (3 in OMAP3) so the extra overhead from
need_ctx_restore & co. is probably bigger than the time spent saving and
restoring those few registers every time.

So remove the code from dss.c and restore context every time dss has
been off.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   61 +----------------------------------------
 1 files changed, 1 insertions(+), 60 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index c8d7357..91572b6 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -62,7 +62,6 @@ static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
 
-	int		ctx_loss_cnt;
 	struct mutex	runtime_lock;
 	int		runtime_count;
 
@@ -633,61 +632,6 @@ void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
 	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
 }
 
-/* CONTEXT */
-static void dss_init_ctx_loss_count(void)
-{
-	struct device *dev = &dss.pdev->dev;
-	struct omap_display_platform_data *pdata = dev->platform_data;
-	struct omap_dss_board_info *board_data = pdata->board_data;
-	int cnt = 0;
-
-	/*
-	 * get_context_loss_count returns negative on error. We'll ignore the
-	 * error and store the error to ctx_loss_cnt, which will cause
-	 * dss_need_ctx_restore() call to return true.
-	 */
-
-	if (board_data->get_context_loss_count)
-		cnt = board_data->get_context_loss_count(dev);
-
-	WARN_ON(cnt < 0);
-
-	dss.ctx_loss_cnt = cnt;
-
-	DSSDBG("initial ctx_loss_cnt %u\n", cnt);
-}
-
-static bool dss_need_ctx_restore(void)
-{
-	struct device *dev = &dss.pdev->dev;
-	struct omap_display_platform_data *pdata = dev->platform_data;
-	struct omap_dss_board_info *board_data = pdata->board_data;
-	int cnt;
-
-	/*
-	 * If get_context_loss_count is not available, assume that we need
-	 * context restore always.
-	 */
-	if (!board_data->get_context_loss_count)
-		return true;
-
-	cnt = board_data->get_context_loss_count(dev);
-	if (cnt < 0) {
-		dev_err(dev, "getting context loss count failed, will force "
-				"context restore\n");
-		dss.ctx_loss_cnt = cnt;
-		return true;
-	}
-
-	if (cnt = dss.ctx_loss_cnt)
-		return false;
-
-	DSSDBG("ctx_loss_cnt %d -> %d\n", dss.ctx_loss_cnt, cnt);
-	dss.ctx_loss_cnt = cnt;
-
-	return true;
-}
-
 static int dss_get_clocks(void)
 {
 	struct clk *clk;
@@ -756,8 +700,7 @@ int dss_runtime_get(void)
 		if (r < 0)
 			goto err;
 
-		if (dss_need_ctx_restore())
-			dss_restore_context();
+		dss_restore_context();
 	}
 
 	mutex_unlock(&dss.runtime_lock);
@@ -828,8 +771,6 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 	if (r)
 		goto err_clocks;
 
-	dss_init_ctx_loss_count();
-
 	mutex_init(&dss.runtime_lock);
 
 	pm_runtime_enable(&pdev->dev);
-- 
1.7.4.1

