From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:36 +0000
Subject: [PATCH 08/23] OMAPDSS: add num_wbs=1 to omap5 dss features
Message-Id: <1449676791-26304-9-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

OMAP5+ DSS has a writeback pipeline, but this was not specified in the
features list for OMAP5 DSS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss_features.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/dss/dss_features.c b/drivers/video/fbdev/omap2/dss/dss_features.c
index b0b6dfd657bf..28fe9a3ca1fa 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.c
+++ b/drivers/video/fbdev/omap2/dss/dss_features.c
@@ -801,6 +801,7 @@ static const struct omap_dss_features omap5_dss_features = {
 
 	.num_mgrs = 4,
 	.num_ovls = 4,
+	.num_wbs = 1,
 	.supported_displays = omap5_dss_supported_displays,
 	.supported_outputs = omap5_dss_supported_outputs,
 	.supported_color_modes = omap4_dss_supported_color_modes,
-- 
2.5.0

