From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 15 Apr 2011 08:11:08 +0000
Subject: [PATCH 2/5] OMAP: DSS2: DSI: fix dsi_dump_clocks()
Message-Id: <1302855071-5510-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

On OMAP4, reading DSI_PLL_CONFIGURATION2 register requires the L3 clock
(CIO_CLK_ICG) to PLL. Currently dsi_dump_clocks() tries to read that
register without enabling the L3 clock, leading to crash if DSI is not
in use.

The status of the bit being read from DSI_PLL_CONFIGURATION2 is
available from dsi_clock_info->use_sys_clk, so we can avoid the whole
problem by just using that.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8604153..1464ac4 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1491,7 +1491,6 @@ void dsi_pll_uninit(void)
 
 void dsi_dump_clocks(struct seq_file *s)
 {
-	int clksel;
 	struct dsi_clock_info *cinfo = &dsi.current_cinfo;
 	enum dss_clk_source dispc_clk_src, dsi_clk_src;
 
@@ -1500,13 +1499,10 @@ void dsi_dump_clocks(struct seq_file *s)
 
 	enable_clocks(1);
 
-	clksel = REG_GET(DSI_PLL_CONFIGURATION2, 11, 11);
-
 	seq_printf(s,	"- DSI PLL -\n");
 
 	seq_printf(s,	"dsi pll source = %s\n",
-			clksel = 0 ?
-			"dss_sys_clk" : "pclkfree");
+			cinfo->use_sys_clk ? "dss_sys_clk" : "pclkfree");
 
 	seq_printf(s,	"Fint\t\t%-16luregn %u\n", cinfo->fint, cinfo->regn);
 
-- 
1.7.1

