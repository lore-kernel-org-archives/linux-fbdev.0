From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Feb 2015 12:48:55 +0000
Subject: [PATCH 01/15] OMAPDSS: fix AM43xx minimum pixel clock divider
Message-Id: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

AM43xx supports pixel clock divider of 1, just like all OMAP3+ SoCs. Fix
the minimum divider value.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss_features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss_features.c b/drivers/video/fbdev/omap2/dss/dss_features.c
index 376270b777f8..b0b6dfd657bf 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.c
+++ b/drivers/video/fbdev/omap2/dss/dss_features.c
@@ -440,7 +440,7 @@ static const struct dss_param_range omap3_dss_param_range[] = {
 
 static const struct dss_param_range am43xx_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 200000000 },
-	[FEAT_PARAM_DSS_PCD]			= { 2, 255 },
+	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 1024 },
 };
-- 
2.3.0

