From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:10 +0000
Subject: [PATCH 11/65] OMAPDSS: handle ilace/replication when configuring overlay
Message-Id: <1321953724-6350-12-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Move the configuration of interlace and replication from
omap_dss_mgr_apply() to configure_overlay(). This removes the need to
store the values into the cache data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/manager.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index bc28bfa..626f6b7 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -510,8 +510,6 @@ struct overlay_cache_data {
 	struct omap_overlay_info info;
 
 	enum omap_channel channel;
-	bool replication;
-	bool ilace;
 
 	u32 fifo_low;
 	u32 fifo_high;
@@ -757,8 +755,10 @@ static int overlay_enabled(struct omap_overlay *ovl)
 
 static int configure_overlay(enum omap_plane plane)
 {
+	struct omap_overlay *ovl;
 	struct overlay_cache_data *c;
 	struct omap_overlay_info *oi;
+	bool ilace, replication;
 	int r;
 
 	DSSDBGF("%d", plane);
@@ -771,8 +771,14 @@ static int configure_overlay(enum omap_plane plane)
 		return 0;
 	}
 
-	r = dispc_ovl_setup(plane, oi, c->ilace, c->channel,
-		c->replication, c->fifo_low, c->fifo_high);
+	ovl = omap_dss_get_overlay(plane);
+
+	replication = dss_use_replication(ovl->manager->device, oi->color_mode);
+
+	ilace = ovl->manager->device->type = OMAP_DISPLAY_TYPE_VENC;
+
+	r = dispc_ovl_setup(plane, oi, ilace, c->channel,
+		replication, c->fifo_low, c->fifo_high);
 	if (r) {
 		/* this shouldn't happen */
 		DSSERR("dispc_ovl_setup failed for ovl %d\n", plane);
@@ -1038,11 +1044,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		oc->dirty = true;
 		oc->info = ovl->info;
 
-		oc->replication -			dss_use_replication(dssdev, ovl->info.color_mode);
-
-		oc->ilace = dssdev->type = OMAP_DISPLAY_TYPE_VENC;
-
 		oc->channel = ovl->manager->id;
 
 		oc->enabled = true;
-- 
1.7.4.1

