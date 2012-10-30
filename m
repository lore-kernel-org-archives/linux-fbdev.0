From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Oct 2012 16:10:08 +0000
Subject: [PATCH 11/12] OMAPDSS: DPI: verify if DSI PLL is operational
Message-Id: <1351613409-21186-12-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The SoCs that have DSI module should have a working DSI PLL. However,
some rare boards have not connected the powers to the DSI PLL.

This patch adds a function that tries to power up the DSI PLL, and
reports if that doesn't succeed. DPI uses this function to fall back to
PRCM clocks if DSI PLL doesn't work.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index fc1ec7d..267caf0 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -361,6 +361,28 @@ void omapdss_dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
 }
 EXPORT_SYMBOL(omapdss_dpi_set_data_lines);
 
+static int __init dpi_verify_dsi_pll(struct platform_device *dsidev)
+{
+	int r;
+
+	/* do initial setup with the PLL to see if it is operational */
+
+	r = dsi_runtime_get(dsidev);
+	if (r)
+		return r;
+
+	r = dsi_pll_init(dsidev, 0, 1);
+	if (r) {
+		dsi_runtime_put(dsidev);
+		return r;
+	}
+
+	dsi_pll_uninit(dsidev, true);
+	dsi_runtime_put(dsidev);
+
+	return 0;
+}
+
 static int __init dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
@@ -383,6 +405,11 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 		enum omap_dss_clk_source dispc_fclk_src  			dssdev->clocks.dispc.dispc_fclk_src;
 		dpi.dsidev = dpi_get_dsidev(dispc_fclk_src);
+
+		if (dpi_verify_dsi_pll(dpi.dsidev)) {
+			dpi.dsidev = NULL;
+			DSSWARN("DSI PLL not operational\n");
+		}
 	}
 
 	return 0;
-- 
1.7.10.4

