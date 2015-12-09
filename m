From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:48 +0000
Subject: [PATCH 20/23] OMAPDSS: remove extra EXPORT_SYMBOLs
Message-Id: <1449676791-26304-21-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The functions dispc_ovl_set_fifo_threshold and
dispc_ovl_compute_fifo_thresholds are exported, but not declared in
public headers, and thus are not used outside omapdss. So we can remove
the EXPORT_SYMBOL()s.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index c3ba555737b8..822add50f92e 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -1270,7 +1270,6 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 			plane != OMAP_DSS_WB)
 		dispc_write_reg(DISPC_OVL_PRELOAD(plane), min(high, 0xfffu));
 }
-EXPORT_SYMBOL(dispc_ovl_set_fifo_threshold);
 
 void dispc_enable_fifomerge(bool enable)
 {
@@ -1329,7 +1328,6 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 		*fifo_high = total_fifo_size - buf_unit;
 	}
 }
-EXPORT_SYMBOL(dispc_ovl_compute_fifo_thresholds);
 
 static void dispc_ovl_set_mflag(enum omap_plane plane, bool enable)
 {
-- 
2.5.0

