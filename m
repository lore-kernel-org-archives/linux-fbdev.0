From: Archit Taneja <archit@ti.com>
Date: Tue, 25 Sep 2012 06:31:51 +0000
Subject: [PATCH v2 16/18] OMAPDSS: DISPC: Configure writeback FIFOs
Message-Id: <1348553993-8083-17-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Extend the DISPC fifo functions to also configure the writeback FIFO thresholds.

The most optimal configuration for writeback is to push out data to the
interconnect the moment writeback pushes enough pixels in the FIFO to form a
burst. This reduces the chance of writeback overflowing it's FIFO.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ca28a88..d6f120d 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -993,7 +993,7 @@ void dispc_wb_set_channel_in(enum dss_writeback_channel channel)
 static void dispc_ovl_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size)
 {
-	static const unsigned shifts[] = { 6, 14, 14, 14, };
+	static const unsigned shifts[] = { 6, 14, 14, 14, 14, };
 	int shift;
 
 	shift = shifts[plane];
@@ -1225,6 +1225,14 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 	if (manual_update && dss_has_feature(FEAT_OMAP3_DSI_FIFO_BUG)) {
 		*fifo_low = ovl_fifo_size - burst_size * 2;
 		*fifo_high = total_fifo_size - burst_size;
+	} else if (plane = OMAP_DSS_WB) {
+		/*
+		 * Most optimal configuration for writeback is to push out data
+		 * to the interconnect the moment writeback pushes enough pixels
+		 * in the FIFO to form a burst
+		 */
+		*fifo_low = 0;
+		*fifo_high = burst_size;
 	} else {
 		*fifo_low = ovl_fifo_size - burst_size;
 		*fifo_high = total_fifo_size - buf_unit;
-- 
1.7.9.5

