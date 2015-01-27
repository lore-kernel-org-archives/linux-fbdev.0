From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Jan 2015 10:50:39 +0000
Subject: [PATCH 11/14] OMAPDSS: DISPC: Add DRA7xx support
Message-Id: <1422355842-11234-12-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DRA7xx support to DISPC driver. The DISPC block is the same as on
OMAP5, except the PLL's used for clocking are "videoX", not "dsiX".

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 9850d9ef9a9d..48429bab294a 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -3037,10 +3037,16 @@ unsigned long dispc_fclk_rate(void)
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		pll = dss_pll_find("dsi0");
+		if (!pll)
+			pll = dss_pll_find("video0");
+
 		r = pll->cinfo.clkout[0];
 		break;
 	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
 		pll = dss_pll_find("dsi1");
+		if (!pll)
+			pll = dss_pll_find("video1");
+
 		r = pll->cinfo.clkout[0];
 		break;
 	default:
@@ -3069,10 +3075,16 @@ unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
 			break;
 		case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 			pll = dss_pll_find("dsi0");
+			if (!pll)
+				pll = dss_pll_find("video0");
+
 			r = pll->cinfo.clkout[0];
 			break;
 		case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
 			pll = dss_pll_find("dsi1");
+			if (!pll)
+				pll = dss_pll_find("video1");
+
 			r = pll->cinfo.clkout[0];
 			break;
 		default:
@@ -3668,6 +3680,7 @@ static int __init dispc_init_features(struct platform_device *pdev)
 		break;
 
 	case OMAPDSS_VER_OMAP5:
+	case OMAPDSS_VER_DRA7xx:
 		src = &omap54xx_dispc_feats;
 		break;
 
@@ -3832,6 +3845,7 @@ static const struct of_device_id dispc_of_match[] = {
 	{ .compatible = "ti,omap3-dispc", },
 	{ .compatible = "ti,omap4-dispc", },
 	{ .compatible = "ti,omap5-dispc", },
+	{ .compatible = "ti,dra7-dispc", },
 	{},
 };
 
-- 
2.2.2

