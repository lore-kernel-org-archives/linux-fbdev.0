From: Archit Taneja <archit@ti.com>
Date: Tue, 27 Dec 2011 12:48:59 +0000
Subject: [RFC PATCH 16/29] OMAPDSS: OVERLAY: Add position and replication as overlay caps
Message-Id: <1324989432-3625-17-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add position and replication as overlay caps. Pass overlay caps as an argument
to the corresponding functions.

These caps will be set for all overlays, but not for writeback. This is done
so writeback can reuse dispc_ovl_setup() to the maximum.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   20 +++++++++++++++-----
 drivers/video/omap2/dss/overlay.c |    6 ++++++
 include/video/omapdss.h           |    2 ++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d9e04f0..58de7d7 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -656,9 +656,15 @@ static void dispc_ovl_set_ba1_uv(enum omap_plane plane, u32 paddr)
 	dispc_write_reg(DISPC_OVL_BA1_UV(plane), paddr);
 }
 
-static void dispc_ovl_set_pos(enum omap_plane plane, int x, int y)
+static void dispc_ovl_set_pos(enum omap_plane plane,
+		enum omap_overlay_caps caps, int x, int y)
 {
-	u32 val = FLD_VAL(y, 26, 16) | FLD_VAL(x, 10, 0);
+	u32 val;
+
+	if ((caps & OMAP_DSS_OVL_CAP_POS) = 0)
+		return;
+
+	val = FLD_VAL(y, 26, 16) | FLD_VAL(x, 10, 0);
 
 	dispc_write_reg(DISPC_OVL_POSITION(plane), val);
 }
@@ -988,11 +994,15 @@ static void dispc_ovl_set_vid_color_conv(enum omap_plane plane, bool enable)
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
 
-static void dispc_ovl_enable_replication(enum omap_plane plane, bool enable)
+static void dispc_ovl_enable_replication(enum omap_plane plane,
+		enum omap_overlay_caps caps, bool enable)
 {
 	static const unsigned shifts[] = { 5, 10, 10, 10 };
 	int shift;
 
+	if ((caps & OMAP_DSS_OVL_CAP_REPLICATION) = 0)
+		return;
+
 	shift = shifts[plane];
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable, shift, shift);
 }
@@ -1881,7 +1891,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	DSSDBG("%d,%d %dx%d -> %dx%d\n", oi->pos_x, oi->pos_y, oi->width,
 			oi->height, outw, outh);
 
-	dispc_ovl_set_pos(plane, oi->pos_x, oi->pos_y);
+	dispc_ovl_set_pos(plane, caps, oi->pos_x, oi->pos_y);
 
 	dispc_ovl_set_pic_size(plane, oi->width, oi->height);
 
@@ -1901,7 +1911,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	dispc_ovl_set_pre_mult_alpha(plane, caps, oi->pre_mult_alpha);
 	dispc_ovl_setup_global_alpha(plane, caps, oi->global_alpha);
 
-	dispc_ovl_enable_replication(plane, replication);
+	dispc_ovl_enable_replication(plane, caps, replication);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index dc0cc52..cb548c0 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -509,6 +509,12 @@ void dss_init_overlays(struct platform_device *pdev)
 		ovl->wait_for_go = &dss_mgr_wait_for_go_ovl;
 
 		ovl->caps = dss_feat_get_overlay_caps(ovl->id);
+
+		/* these caps are common to all ovelays across all OMAPs, they
+		 * are used to differentiate between an overlay and writeback */
+		ovl->caps |= OMAP_DSS_OVL_CAP_POS |
+				OMAP_DSS_OVL_CAP_REPLICATION;
+
 		ovl->supported_modes  			dss_feat_get_supported_color_modes(ovl->id);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6bf84b2..49e3ccb 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -185,6 +185,8 @@ enum omap_overlay_caps {
 	OMAP_DSS_OVL_CAP_GLOBAL_ALPHA = 1 << 1,
 	OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA = 1 << 2,
 	OMAP_DSS_OVL_CAP_ZORDER = 1 << 3,
+	OMAP_DSS_OVL_CAP_POS = 1 << 4,
+	OMAP_DSS_OVL_CAP_REPLICATION = 1 << 5,
 };
 
 enum omap_overlay_manager_caps {
-- 
1.7.4.1

