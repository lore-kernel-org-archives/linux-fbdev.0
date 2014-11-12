From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Nov 2014 11:52:09 +0000
Subject: [PATCH 07/22] OMAPDSS: DSI: use struct copy instead of individual field copy
Message-Id: <1415793144-11723-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that dsi_clock_info only contains information about the PLL, we can
just copy the whole struct when storing the clock information, instead
of copying individual fields.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dsi.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 37517e407f37..b0a3c9ed1341 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -1540,17 +1540,7 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 
 	DSSDBG("DSI PLL clock config starts");
 
-	dsi->current_cinfo.fint = cinfo->fint;
-	dsi->current_cinfo.clkin4ddr = cinfo->clkin4ddr;
-	dsi->current_cinfo.dsi_pll_hsdiv_dispc_clk -			cinfo->dsi_pll_hsdiv_dispc_clk;
-	dsi->current_cinfo.dsi_pll_hsdiv_dsi_clk -			cinfo->dsi_pll_hsdiv_dsi_clk;
-
-	dsi->current_cinfo.regn = cinfo->regn;
-	dsi->current_cinfo.regm = cinfo->regm;
-	dsi->current_cinfo.regm_dispc = cinfo->regm_dispc;
-	dsi->current_cinfo.regm_dsi = cinfo->regm_dsi;
+	dsi->current_cinfo = *cinfo;
 
 	DSSDBG("DSI Fint %ld\n", cinfo->fint);
 
-- 
2.1.3

