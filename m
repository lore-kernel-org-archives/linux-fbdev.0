From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:11 +0000
Subject: [PATCH 12/65] OMAPDSS: separate FIFO threshold setup from ovl_setup
Message-Id: <1321953724-6350-13-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Overlay FIFO thresholds are configured with ovl_setup, with all the
other overlay attributes. This patch separates FIFO threshold setup so
that we can later configure FIFO thresholds only when needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   10 ++++------
 drivers/video/omap2/dss/dss.h     |    3 +--
 drivers/video/omap2/dss/manager.c |    5 +++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 49f97db..55cfbc9 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1769,8 +1769,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 }
 
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
-		bool ilace, enum omap_channel channel, bool replication,
-		u32 fifo_low, u32 fifo_high)
+		bool ilace, enum omap_channel channel, bool replication)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	bool five_taps = false;
@@ -1784,11 +1783,11 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	u16 outw, outh;
 
 	DSSDBG("dispc_ovl_setup %d, pa %x, pa_uv %x, sw %d, %d,%d, %dx%d -> "
-		"%dx%d, cmode %x, rot %d, mir %d, ilace %d chan %d repl %d "
-		"fifo_low %d fifo high %d\n", plane, oi->paddr, oi->p_uv_addr,
+		"%dx%d, cmode %x, rot %d, mir %d, ilace %d chan %d repl %d\n",
+		plane, oi->paddr, oi->p_uv_addr,
 		oi->screen_width, oi->pos_x, oi->pos_y, oi->width, oi->height,
 		oi->out_width, oi->out_height, oi->color_mode, oi->rotation,
-		oi->mirror, ilace, channel, replication, fifo_low, fifo_high);
+		oi->mirror, ilace, channel, replication);
 
 	if (oi->paddr = 0)
 		return -EINVAL;
@@ -1896,7 +1895,6 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	dispc_ovl_set_channel_out(plane, channel);
 
 	dispc_ovl_enable_replication(plane, replication);
-	dispc_ovl_set_fifo_threshold(plane, fifo_low, fifo_high);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 0937bd8..61001c3 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -397,8 +397,7 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 u32 dispc_ovl_get_fifo_size(enum omap_plane plane);
 u32 dispc_ovl_get_burst_size(enum omap_plane plane);
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
-		bool ilace, enum omap_channel channel, bool replication,
-		u32 fifo_low, u32 fifo_high);
+		bool ilace, enum omap_channel channel, bool replication);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
 void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 626f6b7..b47c1fa 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -777,8 +777,7 @@ static int configure_overlay(enum omap_plane plane)
 
 	ilace = ovl->manager->device->type = OMAP_DISPLAY_TYPE_VENC;
 
-	r = dispc_ovl_setup(plane, oi, ilace, c->channel,
-		replication, c->fifo_low, c->fifo_high);
+	r = dispc_ovl_setup(plane, oi, ilace, c->channel, replication);
 	if (r) {
 		/* this shouldn't happen */
 		DSSERR("dispc_ovl_setup failed for ovl %d\n", plane);
@@ -786,6 +785,8 @@ static int configure_overlay(enum omap_plane plane)
 		return r;
 	}
 
+	dispc_ovl_set_fifo_threshold(plane, c->fifo_low, c->fifo_high);
+
 	dispc_ovl_enable(plane, 1);
 
 	return 0;
-- 
1.7.4.1

