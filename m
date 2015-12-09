From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:43 +0000
Subject: [PATCH 15/23] OMAPDSS: configure WB mflag threshold
Message-Id: <1449676791-26304-16-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Mflag thresholds for all pipelines are set in dispc_init_mflag(), but we
are missing that for WB pipeline. Add WB configuration.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 22b6e0f3e657..3cd78dcfefc5 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -1384,6 +1384,25 @@ static void dispc_init_mflag(void)
 
 		dispc_ovl_set_mflag_threshold(i, low, high);
 	}
+
+	if (dispc.feat->has_writeback) {
+		u32 size = dispc_ovl_get_fifo_size(OMAP_DSS_WB);
+		u32 unit = dss_feat_get_buffer_size_unit();
+		u32 low, high;
+
+		dispc_ovl_set_mflag(OMAP_DSS_WB, true);
+
+		/*
+		 * Simulation team suggests below thesholds:
+		 * HT = fifosize * 5 / 8;
+		 * LT = fifosize * 4 / 8;
+		 */
+
+		low = size * 4 / 8 / unit;
+		high = size * 5 / 8 / unit;
+
+		dispc_ovl_set_mflag_threshold(OMAP_DSS_WB, low, high);
+	}
 }
 
 static void dispc_ovl_set_fir(enum omap_plane plane,
-- 
2.5.0

