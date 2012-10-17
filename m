From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Oct 2012 11:20:32 +0000
Subject: [PATCH 6/9] OMAPDSS: DISPC: remove struct omap_overlay use
Message-Id: <1350472835-28727-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dispc_ovl_setup() uses struct omap_overlay to get the caps for the
overlay. We can change the code to get the caps directly from dss
features, thus removing the dependency to struct omap_overlay.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d3c58eb..9f0ce18 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2505,7 +2505,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool mem_to_mem)
 {
 	int r;
-	const struct omap_overlay *ovl = omap_dss_get_overlay(plane);
+	enum omap_overlay_caps caps = dss_feat_get_overlay_caps(plane);
 	enum omap_channel channel;
 
 	channel = dispc_ovl_get_channel_out(plane);
@@ -2516,7 +2516,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		oi->pos_y, oi->width, oi->height, oi->out_width, oi->out_height,
 		oi->color_mode, oi->rotation, oi->mirror, channel, replication);
 
-	r = dispc_ovl_setup_common(plane, ovl->caps, oi->paddr, oi->p_uv_addr,
+	r = dispc_ovl_setup_common(plane, caps, oi->paddr, oi->p_uv_addr,
 		oi->screen_width, oi->pos_x, oi->pos_y, oi->width, oi->height,
 		oi->out_width, oi->out_height, oi->color_mode, oi->rotation,
 		oi->mirror, oi->zorder, oi->pre_mult_alpha, oi->global_alpha,
-- 
1.7.9.5

