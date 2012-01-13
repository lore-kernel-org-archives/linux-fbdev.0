From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 13 Jan 2012 11:46:31 +0000
Subject: [PATCH 4/6] OMAPDSS: DISPC: print fifo threshold values in bytes
Message-Id: <1326455193-19716-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Fifo thresholds are calculated using bytes, but the debug print prints
values in buffer units. Change the prints to use bytes to be in line
with the calculations, and also to print in the same units on all OMAPs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d711518..ba907bd 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1039,13 +1039,13 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end);
 	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end);
 
-	DSSDBG("fifo(%d) low/high old %u/%u, new %u/%u\n",
+	DSSDBG("fifo(%d) threshold (bytes), old %u/%u, new %u/%u\n",
 			plane,
 			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
-				lo_start, lo_end),
+				lo_start, lo_end) * unit,
 			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
-				hi_start, hi_end),
-			low, high);
+				hi_start, hi_end) * unit,
+			low * unit, high * unit);
 
 	dispc_write_reg(DISPC_OVL_FIFO_THRESHOLD(plane),
 			FLD_VAL(high, hi_start, hi_end) |
-- 
1.7.4.1

