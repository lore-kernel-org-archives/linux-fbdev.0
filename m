From: Archit Taneja <archit@ti.com>
Date: Thu, 13 Sep 2012 12:26:59 +0000
Subject: [PATCH 15/21] OMAPDSS: DISPC: Don't set chroma resampling bit for writeback
Message-Id: <1347538505-25359-16-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The bit YUVCHROMARESAMPLING isn't there for writeback in DISPC_WB_ATTRIBUTES2.
It isn't there because we don't upsample chroma like for video pipelines, we
downsample chroma in writeback to get YUV422 or NV12 formats from the YUV444
input.

Ignore this bit in dispc_ovl_set_scaling_uv() if the plane is OMAP_DSS_WB.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index f3bf93d..b0f14c0 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1473,7 +1473,8 @@ static void dispc_plane_set_scaling_uv(enum omap_plane plane,
 			color_mode != OMAP_DSS_COLOR_UYVY &&
 			color_mode != OMAP_DSS_COLOR_NV12)) {
 		/* reset chroma resampling for RGB formats  */
-		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane), 0, 8, 8);
+		if (plane != OMAP_DSS_WB)
+			REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane), 0, 8, 8);
 		return;
 	}
 
@@ -1525,8 +1526,10 @@ static void dispc_plane_set_scaling_uv(enum omap_plane plane,
 			out_width, out_height, five_taps,
 				rotation, DISPC_COLOR_COMPONENT_UV);
 
-	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane),
-		(scale_x || scale_y) ? 1 : 0, 8, 8);
+	if (plane != OMAP_DSS_WB)
+		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane),
+			(scale_x || scale_y) ? 1 : 0, 8, 8);
+
 	/* set H scaling */
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), scale_x ? 1 : 0, 5, 5);
 	/* set V scaling */
-- 
1.7.9.5

