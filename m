From: Archit Taneja <archit@ti.com>
Date: Tue, 27 Dec 2011 12:49:02 +0000
Subject: [RFC PATCH 19/29] OMAPDSS: DISPC: Don't set chroma resampling bit for writeback
Message-Id: <1324989432-3625-20-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The bit YUVCHROMARESAMPLING isn't there for writeback in DISPC_WB_ATTRIBUTES2.
Ignore this bit in dispc_ovl_set_scaling_uv() if the plane is OMAP_DSS_WB.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 21d6286..3a40f8e 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1238,7 +1238,8 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 			color_mode != OMAP_DSS_COLOR_UYVY &&
 			color_mode != OMAP_DSS_COLOR_NV12)) {
 		/* reset chroma resampling for RGB formats  */
-		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane), 0, 8, 8);
+		if (plane != OMAP_DSS_WB)
+			REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane), 0, 8, 8);
 		return;
 	}
 	switch (color_mode) {
@@ -1277,8 +1278,10 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
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
1.7.4.1

