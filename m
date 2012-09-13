From: Archit Taneja <archit@ti.com>
Date: Thu, 13 Sep 2012 12:26:58 +0000
Subject: [PATCH 14/21] OMAPDSS: DISPC: Downscale chroma if plane is writeback
Message-Id: <1347538505-25359-15-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

When converting YUYV444 content to YUV422 or NV12 formats through writeback
pipeline, the scalar needs to downscale the chroma plane. Ensure that chroma
is downscaled when the pipeline is writeback.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 1d5dddf..f3bf93d 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1465,7 +1465,7 @@ static void dispc_plane_set_scaling_uv(enum omap_plane plane,
 {
 	int scale_x = out_width != orig_width;
 	int scale_y = out_height != orig_height;
-	bool chroma_upscale = true;
+	bool chroma_upscale = plane != OMAP_DSS_WB ? true : false;
 
 	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
 		return;
-- 
1.7.9.5

