From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Jun 2011 13:56:48 +0000
Subject: [PATCHv2 26/28] OMAP4: CLKDEV: Remove omapdss clock aliases
Message-Id: <1307627810-3768-27-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdss driver now gets the clocks via hwmod opt clocks, so clock
aliases for omapdss_dss are no longer needed.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 8c96567..4d278e7 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3114,11 +3114,11 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
 	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
-	CLK("omapdss_dss",	"sys_clk",			&dss_sys_clk,	CK_443X),
-	CLK("omapdss_dss",	"tv_clk",			&dss_tv_clk,	CK_443X),
-	CLK("omapdss_dss",	"video_clk",			&dss_48mhz_clk,	CK_443X),
-	CLK("omapdss_dss",	"fck",				&dss_dss_clk,	CK_443X),
-	CLK("omapdss_dss",	"ick",				&dss_fck,	CK_443X),
+	CLK(NULL,	"sys_clk",			&dss_sys_clk,	CK_443X),
+	CLK(NULL,	"tv_clk",			&dss_tv_clk,	CK_443X),
+	CLK(NULL,	"video_clk",			&dss_48mhz_clk,	CK_443X),
+	CLK(NULL,	"fck",				&dss_dss_clk,	CK_443X),
+	CLK(NULL,	"ick",				&dss_fck,	CK_443X),
 	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_443X),
 	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_443X),
 	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_443X),
-- 
1.7.4.1

