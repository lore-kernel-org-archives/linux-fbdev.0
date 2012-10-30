From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Oct 2012 16:10:01 +0000
Subject: [PATCH 04/12] OMAPDSS: fix DSI2 PLL clk names
Message-Id: <1351613409-21186-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_generic_clk_source_names is missing the names for clocks from DSI2
PLL. Add them.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 37ee465..a85bd05 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -97,6 +97,8 @@ static const char * const dss_generic_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "DSI_PLL_HSDIV_DISPC",
 	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]	= "DSI_PLL_HSDIV_DSI",
 	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_FCK",
+	[OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC]	= "DSI_PLL2_HSDIV_DISPC",
+	[OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI]	= "DSI_PLL2_HSDIV_DSI",
 };
 
 static inline void dss_write_reg(const struct dss_reg idx, u32 val)
-- 
1.7.10.4

