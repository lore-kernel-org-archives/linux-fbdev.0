From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 23 Aug 2012 13:45:11 +0000
Subject: [PATCH 5/8] OMAPDSS: Add DSI fclk maximum to dss_features
Message-Id: <1345729514-2441-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add max value of DSI functional clock to dss_features, so that DSI
driver can use it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    2 ++
 drivers/video/omap2/dss/dss_features.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 2fe39d6..c26fc1f 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -326,6 +326,7 @@ static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 4) - 1 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 750000, 2100000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 1, (1 << 13) - 1},
+	[FEAT_PARAM_DSI_FCK]			= { 0, 173000000 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 1024 },
 	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
@@ -341,6 +342,7 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 5) - 1 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
+	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 2048 },
 	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 26d43a4..b81d603 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -92,6 +92,7 @@ enum dss_range_param {
 	FEAT_PARAM_DSIPLL_REGM_DSI,
 	FEAT_PARAM_DSIPLL_FINT,
 	FEAT_PARAM_DSIPLL_LPDIV,
+	FEAT_PARAM_DSI_FCK,
 	FEAT_PARAM_DOWNSCALE,
 	FEAT_PARAM_LINEWIDTH,
 	FEAT_PARAM_MGR_WIDTH,
-- 
1.7.9.5

