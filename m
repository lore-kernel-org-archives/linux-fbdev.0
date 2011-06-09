From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Jun 2011 13:56:39 +0000
Subject: [PATCHv2 17/28] OMAP2420: HWMOD: Add DSS opt clocks
Message-Id: <1307627810-3768-18-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DSS optional clocks to HWMOD data for OMAP2420.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index c4d0ae8..d87019d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1208,6 +1208,7 @@ static struct omap_hwmod_ocp_if *omap2420_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	{ .role = "dss_clk", .clk = "dss1_fck" },
 	{ .role = "tv_clk", .clk = "dss_54m_fck" },
 	{ .role = "sys_clk", .clk = "dss2_fck" },
 };
@@ -1291,6 +1292,10 @@ static struct omap_hwmod_ocp_if *omap2420_dss_dispc_slaves[] = {
 	&omap2420_l4_core__dss_dispc,
 };
 
+static struct omap_hwmod_opt_clk dispc_opt_clks[] = {
+	{ .role = "dss_clk", .clk = "dss1_fck" },
+};
+
 static struct omap_hwmod omap2420_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap2420_dispc_hwmod_class,
@@ -1306,6 +1311,8 @@ static struct omap_hwmod omap2420_dss_dispc_hwmod = {
 			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
 		},
 	},
+	.opt_clks	= dispc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dispc_opt_clks),
 	.slaves		= omap2420_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_dispc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
@@ -1361,6 +1368,10 @@ static struct omap_hwmod_ocp_if *omap2420_dss_rfbi_slaves[] = {
 	&omap2420_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk rfbi_opt_clks[] = {
+	{ .role = "rfbi_iclk", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2420_rfbi_hwmod_class,
@@ -1372,6 +1383,8 @@ static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 			.module_offs = CORE_MOD,
 		},
 	},
+	.opt_clks	= rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(rfbi_opt_clks),
 	.slaves		= omap2420_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
@@ -1418,6 +1431,10 @@ static struct omap_hwmod_ocp_if *omap2420_dss_venc_slaves[] = {
 	&omap2420_l4_core__dss_venc,
 };
 
+static struct omap_hwmod_opt_clk venc_opt_clks[] = {
+	{ .role = "tv_clk", .clk = "dss_54m_fck" },
+};
+
 static struct omap_hwmod omap2420_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap2420_venc_hwmod_class,
@@ -1429,6 +1446,8 @@ static struct omap_hwmod omap2420_dss_venc_hwmod = {
 			.module_offs = CORE_MOD,
 		},
 	},
+	.opt_clks	= venc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(venc_opt_clks),
 	.slaves		= omap2420_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_venc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-- 
1.7.4.1

