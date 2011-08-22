From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Aug 2011 08:27:14 +0000
Subject: [PATCH 2/4] OMAP: DSS2: fix clock sources on error and uninit
Message-Id: <1314001636-18036-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

DPI and DSI were not cleaning up the clock source in error or uninit
cases. Set the clock source back to PRCM.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    4 +++-
 drivers/video/omap2/dss/dsi.c |    3 +++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 046ce08..dc698bd 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -83,8 +83,10 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev, bool is_tft,
 	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
 
 	r = dispc_set_clock_div(dssdev->manager->id, &dispc_cinfo);
-	if (r)
+	if (r) {
+		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 		return r;
+	}
 
 	*fck = dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
 	*lck_div = dispc_cinfo.lck_div;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ae6bf1d..c951a75 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4184,6 +4184,8 @@ err3:
 err2:
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi_module, OMAP_DSS_CLK_SRC_FCK);
+	dss_select_lcd_clk_source(dssdev->manager->id, OMAP_DSS_CLK_SRC_FCK);
+
 err1:
 	dsi_pll_uninit(dsidev, true);
 err0:
@@ -4209,6 +4211,7 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi_module, OMAP_DSS_CLK_SRC_FCK);
+	dss_select_lcd_clk_source(dssdev->manager->id, OMAP_DSS_CLK_SRC_FCK);
 	dsi_cio_uninit(dssdev);
 	dsi_pll_uninit(dsidev, disconnect_lanes);
 }
-- 
1.7.4.1

