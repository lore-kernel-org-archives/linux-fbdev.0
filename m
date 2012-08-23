From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 23 Aug 2012 13:45:13 +0000
Subject: [PATCH 7/8] OMAP: 4430SDP: remove DSI clock config from board file
Message-Id: <1345729514-2441-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

DSI clocks are now configured dynamically by the DSI driver, so we can
remove the hardcoded clock configuration from the board file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   46 -----------------------------------
 1 file changed, 46 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 852e05c..4352d91 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -621,29 +621,6 @@ static struct omap_dss_device sdp4430_lcd_device = {
 	.phy.dsi		= {
 		.module		= 0,
 	},
-
-	.clocks = {
-		.dispc = {
-			.channel = {
-				/* Logic Clock = 172.8 MHz */
-				.lck_div	= 1,
-				/* Pixel Clock = 34.56 MHz */
-				.pck_div	= 5,
-				.lcd_clk_src	= OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC,
-			},
-			.dispc_fclk_src	= OMAP_DSS_CLK_SRC_FCK,
-		},
-
-		.dsi = {
-			.regn		= 16,	/* Fint = 2.4 MHz */
-			.regm		= 180,	/* DDR Clock = 216 MHz */
-			.regm_dispc	= 5,	/* PLL1_CLK1 = 172.8 MHz */
-			.regm_dsi	= 5,	/* PLL1_CLK2 = 172.8 MHz */
-
-			.lp_clk_div	= 10,	/* LP Clock = 8.64 MHz */
-			.dsi_fclk_src	= OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI,
-		},
-	},
 	.channel		= OMAP_DSS_CHANNEL_LCD,
 };
 
@@ -668,29 +645,6 @@ static struct omap_dss_device sdp4430_lcd2_device = {
 
 		.module		= 1,
 	},
-
-	.clocks = {
-		.dispc = {
-			.channel = {
-				/* Logic Clock = 172.8 MHz */
-				.lck_div	= 1,
-				/* Pixel Clock = 34.56 MHz */
-				.pck_div	= 5,
-				.lcd_clk_src	= OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC,
-			},
-			.dispc_fclk_src	= OMAP_DSS_CLK_SRC_FCK,
-		},
-
-		.dsi = {
-			.regn		= 16,	/* Fint = 2.4 MHz */
-			.regm		= 180,	/* DDR Clock = 216 MHz */
-			.regm_dispc	= 5,	/* PLL1_CLK1 = 172.8 MHz */
-			.regm_dsi	= 5,	/* PLL1_CLK2 = 172.8 MHz */
-
-			.lp_clk_div	= 10,	/* LP Clock = 8.64 MHz */
-			.dsi_fclk_src	= OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI,
-		},
-	},
 	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
-- 
1.7.9.5

