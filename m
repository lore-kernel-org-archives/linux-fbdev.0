From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 13 Jan 2012 11:46:33 +0000
Subject: [PATCH 6/6] OMAPDSS: DISPC: Add naive threshold calc for fifomerge
Message-Id: <1326455193-19716-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Take fifo merge into use by implementing a rather naive fifo merge
threshold calculation: keep the low threshold always the same, but
increase the high threshold when fifo merge is used.

This should greatly increase the time between pixel data fetches from
SDRAM, as the usable fifo size is much larger. However, it probably
won't help for fifo underflows, as the low threshols is kept the same.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a759722..6451321 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1077,8 +1077,24 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 	burst_size = dispc_ovl_get_burst_size(plane);
 	fifo_size = dispc_ovl_get_fifo_size(plane);
 
+	/*
+	 * We use the same low threshold for both fifomerge and non-fifomerge
+	 * cases, but for fifomerge we calculate the high threshold using the
+	 * combined fifo size
+	 */
 	*fifo_low = fifo_size - burst_size;
-	*fifo_high = fifo_size - buf_unit;
+
+	if (use_fifomerge) {
+		int i;
+
+		fifo_size = 0;
+		for (i = 0; i < omap_dss_get_num_overlays(); ++i)
+			fifo_size += dispc_ovl_get_fifo_size(i);
+
+		*fifo_high = fifo_size - buf_unit;
+	} else {
+		*fifo_high = fifo_size - buf_unit;
+	}
 }
 
 static void dispc_ovl_set_fir(enum omap_plane plane,
-- 
1.7.4.1

