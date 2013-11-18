From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 18 Nov 2013 12:44:06 +0000
Subject: [PATCH 1/4] OMAPDSS: fix missing EXPORT_SYMBOL()s
Message-Id: <1384778649-9396-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Functions dispc_ovl_set_fifo_threshold and
dispc_ovl_compute_fifo_thresholds need to be exported. Add the
EXPORT_SYMBOLs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 91c687f..aa95ba5 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1201,6 +1201,7 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 			FLD_VAL(high, hi_start, hi_end) |
 			FLD_VAL(low, lo_start, lo_end));
 }
+EXPORT_SYMBOL(dispc_ovl_set_fifo_threshold);
 
 void dispc_enable_fifomerge(bool enable)
 {
@@ -1259,6 +1260,7 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 		*fifo_high = total_fifo_size - buf_unit;
 	}
 }
+EXPORT_SYMBOL(dispc_ovl_compute_fifo_thresholds);
 
 static void dispc_ovl_set_fir(enum omap_plane plane,
 				int hinc, int vinc,
-- 
1.8.3.2

