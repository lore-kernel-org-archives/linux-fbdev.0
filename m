From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:04 +0000
Subject: [PATCH 05/65] OMAPDSS: DISPC: make dispc_ovl_set_fifo_threshold() public
Message-Id: <1321953724-6350-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Make dispc_ovl_set_fifo_threshold() public so that later patches can
handle overlay fifo configuration.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    3 +--
 drivers/video/omap2/dss/dss.h   |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index b2865ef..7387e23 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1056,8 +1056,7 @@ u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
 	return dispc.fifo_size[plane];
 }
 
-static void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low,
-		u32 high)
+void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 {
 	u8 hi_start, hi_end, lo_start, lo_end;
 	u32 unit;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f899f0f..313a7ca 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -396,6 +396,7 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 		struct dispc_clock_info *cinfo);
 
 
+void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 u32 dispc_ovl_get_fifo_size(enum omap_plane plane);
 u32 dispc_ovl_get_burst_size(enum omap_plane plane);
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
-- 
1.7.4.1

