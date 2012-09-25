From: Archit Taneja <archit@ti.com>
Date: Tue, 25 Sep 2012 06:31:43 +0000
Subject: [PATCH v2 08/18] OMAPDSS: DISPC: Allow both upscaling and downscaling of chroma
Message-Id: <1348553993-8083-9-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

In the function dispc_plane_set_scaling_uv(), create a parameter which tells if
we want to upscale or downscale the chroma plane.

Downscaling of chroma is required by writeback pipeline for converting the input
YUV444 color format to YUV422 or NV12.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ba65ebd..e42e902 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1457,6 +1457,7 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 {
 	int scale_x = out_width != orig_width;
 	int scale_y = out_height != orig_height;
+	bool chroma_upscale = true;
 
 	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
 		return;
@@ -1473,23 +1474,34 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 
 	switch (color_mode) {
 	case OMAP_DSS_COLOR_NV12:
-		/* UV is subsampled by 2 vertically*/
-		orig_height >>= 1;
-		/* UV is subsampled by 2 horz.*/
-		orig_width >>= 1;
+		if (chroma_upscale) {
+			/* UV is subsampled by 2 horizontally and vertically */
+			orig_height >>= 1;
+			orig_width >>= 1;
+		} else {
+			/* UV is downsampled by 2 horizontally and vertically */
+			orig_height <<= 1;
+			orig_width <<= 1;
+		}
+
 		break;
 	case OMAP_DSS_COLOR_YUV2:
 	case OMAP_DSS_COLOR_UYVY:
-		/*For YUV422 with 90/270 rotation,
-		 *we don't upsample chroma
-		 */
+		/* For YUV422 with 90/270 rotation, we don't upsample chroma */
 		if (rotation = OMAP_DSS_ROT_0 ||
-			rotation = OMAP_DSS_ROT_180)
-			/* UV is subsampled by 2 hrz*/
-			orig_width >>= 1;
+				rotation = OMAP_DSS_ROT_180) {
+			if (chroma_upscale)
+				/* UV is subsampled by 2 horizontally */
+				orig_width >>= 1;
+			else
+				/* UV is downsampled by 2 horizontally */
+				orig_width <<= 1;
+		}
+
 		/* must use FIR for YUV422 if rotated */
 		if (rotation != OMAP_DSS_ROT_0)
 			scale_x = scale_y = true;
+
 		break;
 	default:
 		BUG();
-- 
1.7.9.5

