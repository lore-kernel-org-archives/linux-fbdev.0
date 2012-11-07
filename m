From: Archit Taneja <archit@ti.com>
Date: Wed, 07 Nov 2012 06:27:03 +0000
Subject: [PATCH 2/3] OMAPDSS: DISPC: Don't allow predecimation for writeback
Message-Id: <1352268905-31093-3-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352268905-31093-1-git-send-email-archit@ti.com>
In-Reply-To: <1352268905-31093-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Since writeback writes to a buffer instead of reading from one, predecimation
doesn't make sense for it. Configure the width and height predecimation limits
to 1 if the plane is writeback.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index f19cd37..664ac6f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2315,9 +2315,14 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	if ((caps & OMAP_DSS_OVL_CAP_SCALE) = 0)
 		return -EINVAL;
 
-	*x_predecim = max_decim_limit;
-	*y_predecim = (rotation_type = OMAP_DSS_ROT_TILER &&
-			dss_has_feature(FEAT_BURST_2D)) ? 2 : max_decim_limit;
+	if (plane = OMAP_DSS_WB) {
+		*x_predecim = *y_predecim = 1;
+	} else {
+		*x_predecim = max_decim_limit;
+		*y_predecim = (rotation_type = OMAP_DSS_ROT_TILER &&
+				dss_has_feature(FEAT_BURST_2D)) ?
+				2 : max_decim_limit;
+	}
 
 	if (color_mode = OMAP_DSS_COLOR_CLUT1 ||
 	    color_mode = OMAP_DSS_COLOR_CLUT2 ||
-- 
1.7.9.5

