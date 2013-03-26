From: Archit Taneja <archit@ti.com>
Date: Tue, 26 Mar 2013 13:57:23 +0000
Subject: [PATCH v2 6/8] omapdss: Features: Fix some parameter ranges
Message-Id: <1364305525-28496-7-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362493070-17706-1-git-send-email-archit@ti.com>
 <1364305525-28496-1-git-send-email-archit@ti.com>
In-Reply-To: <1364305525-28496-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, robdclark@gmail.com, andy.gross@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

Increase the DSS_FCLK and DSI_FCLK max supported frequencies, these come because
some frequencies were increased from OMAP5 ES1 to OMAP5 ES2. We support only
OMAP5 ES2 in the kernel, so replace the ES1 values with ES2 values. Increase the
DSI PLL Fint range, this was previously just copied from the OMAP4 param range
struct.

Fix the maximum DSS_FCLK on OMAP2, it's 133 Mhz according to the TRM.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 7f791ae..77dbe0c 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -414,7 +414,7 @@ static const char * const omap5_dss_clk_source_names[] = {
 };
 
 static const struct dss_param_range omap2_dss_param_range[] = {
-	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
+	[FEAT_PARAM_DSS_FCK]			= { 0, 133000000 },
 	[FEAT_PARAM_DSS_PCD]			= { 2, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, 0 },
@@ -459,15 +459,15 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 };
 
 static const struct dss_param_range omap5_dss_param_range[] = {
-	[FEAT_PARAM_DSS_FCK]			= { 0, 200000000 },
+	[FEAT_PARAM_DSS_FCK]			= { 0, 209250000 },
 	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 5) - 1 },
-	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
+	[FEAT_PARAM_DSIPLL_FINT]		= { 150000, 52000000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
-	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
+	[FEAT_PARAM_DSI_FCK]			= { 0, 209250000 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 2048 },
 };
-- 
1.7.10.4

