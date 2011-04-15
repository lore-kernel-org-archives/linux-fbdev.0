From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 15 Apr 2011 08:11:07 +0000
Subject: [PATCH 1/5] OMAP: DSS2: DSI: fix use_sys_clk & highfreq
Message-Id: <1302855071-5510-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

use_sys_clk and highfreq fields in dsi.current_cinfo were never set.
Luckily they weren't used anywhere so it didn't cause any problems.

This patch fixes those fields and they are now set at the same time as
the rest of the fields.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 0a7f1a4..8604153 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1276,6 +1276,9 @@ int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
 
 	DSSDBGF();
 
+	dsi.current_cinfo.use_sys_clk = cinfo->use_sys_clk;
+	dsi.current_cinfo.highfreq = cinfo->highfreq;
+
 	dsi.current_cinfo.fint = cinfo->fint;
 	dsi.current_cinfo.clkin4ddr = cinfo->clkin4ddr;
 	dsi.current_cinfo.dsi_pll_hsdiv_dispc_clk -- 
1.7.1

