From: "Andrew F. Davis" <afd@ti.com>
Date: Wed, 16 Oct 2019 18:04:24 +0000
Subject: [PATCH] omapfb/dss: remove unneeded conversions to bool
Message-Id: <20191016180424.23907-1-afd@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <trivial@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>

Found with scripts/coccinelle/misc/boolconv.cocci.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index 376ee5bc3ddc..ce37da85cc45 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -1635,7 +1635,7 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 {
 	int scale_x = out_width != orig_width;
 	int scale_y = out_height != orig_height;
-	bool chroma_upscale = plane != OMAP_DSS_WB ? true : false;
+	bool chroma_upscale = plane != OMAP_DSS_WB;
 
 	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
 		return;
@@ -3100,9 +3100,9 @@ static bool _dispc_mgr_pclk_ok(enum omap_channel channel,
 		unsigned long pclk)
 {
 	if (dss_mgr_is_lcd(channel))
-		return pclk <= dispc.feat->max_lcd_pclk ? true : false;
+		return pclk <= dispc.feat->max_lcd_pclk;
 	else
-		return pclk <= dispc.feat->max_tv_pclk ? true : false;
+		return pclk <= dispc.feat->max_tv_pclk;
 }
 
 bool dispc_mgr_timings_ok(enum omap_channel channel,
-- 
2.17.1
