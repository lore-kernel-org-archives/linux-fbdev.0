From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:42 +0000
Subject: [PATCH 14/23] OMAPDSS: configure WB fifo thresholds
Message-Id: <1449676791-26304-15-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fifo thresholds for all pipelines are set in dispc_init_fifos(), but we
are missing it for WB pipeline. Add that.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 0ebfef9ae07f..22b6e0f3e657 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -1205,6 +1205,17 @@ static void dispc_init_fifos(void)
 
 		dispc_ovl_set_fifo_threshold(i, low, high);
 	}
+
+	if (dispc.feat->has_writeback) {
+		u32 low, high;
+		const bool use_fifomerge = false;
+		const bool manual_update = false;
+
+		dispc_ovl_compute_fifo_thresholds(OMAP_DSS_WB, &low, &high,
+			use_fifomerge, manual_update);
+
+		dispc_ovl_set_fifo_threshold(OMAP_DSS_WB, low, high);
+	}
 }
 
 static u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
-- 
2.5.0

