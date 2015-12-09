From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:41 +0000
Subject: [PATCH 13/23] OMAPDSS: configure burst size for WB
Message-Id: <1449676791-26304-14-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Burst size for all pipelines is set in dispc_configure_burst_sizes(),
but we are missing WB pipe. So add that.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 4126d6225faf..0ebfef9ae07f 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -1057,6 +1057,8 @@ static void dispc_configure_burst_sizes(void)
 	/* Configure burst size always to maximum size */
 	for (i = 0; i < dss_feat_get_num_ovls(); ++i)
 		dispc_ovl_set_burst_size(i, burst_size);
+	if (dispc.feat->has_writeback)
+		dispc_ovl_set_burst_size(OMAP_DSS_WB, burst_size);
 }
 
 static u32 dispc_ovl_get_burst_size(enum omap_plane plane)
-- 
2.5.0

