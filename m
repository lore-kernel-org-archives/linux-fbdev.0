From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 10:17:10 +0000
Subject: [PATCH 14/23] OMAPDSS: features: fix OMAP5 features
Message-Id: <1398334639-14172-15-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

OMAP5 has LCD3 overlay manager, and total 4 overlay managers. These are
not correctly defined in the dss features. Fix them.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss_features.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss_features.c b/drivers/video/fbdev/omap2/dss/dss_features.c
index 7f8969191dc6..ec1527de218d 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.c
+++ b/drivers/video/fbdev/omap2/dss/dss_features.c
@@ -595,6 +595,7 @@ static const enum dss_feat_id omap4_dss_feat_list[] = {
 
 static const enum dss_feat_id omap5_dss_feat_list[] = {
 	FEAT_MGR_LCD2,
+	FEAT_MGR_LCD3,
 	FEAT_CORE_CLK_DIV,
 	FEAT_LCD_CLK_SRC,
 	FEAT_DSI_DCS_CMD_CONFIG_VC,
@@ -777,7 +778,7 @@ static const struct omap_dss_features omap5_dss_features = {
 	.features = omap5_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap5_dss_feat_list),
 
-	.num_mgrs = 3,
+	.num_mgrs = 4,
 	.num_ovls = 4,
 	.supported_displays = omap5_dss_supported_displays,
 	.supported_outputs = omap5_dss_supported_outputs,
-- 
1.9.1

