From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:08 +0000
Subject: [PATCH 09/65] OMAPDSS: pass ovl manager to dss_start_update
Message-Id: <1321953724-6350-10-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_start_update() takes currently the dss device as a parameter. Change
the parameter to ovl manager, as that is what the dss_start_update()
actually needs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c     |    2 +-
 drivers/video/omap2/dss/dss.h     |    2 +-
 drivers/video/omap2/dss/manager.c |    7 ++-----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 9ef04ff..e5a2dcc 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4063,7 +4063,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 		msecs_to_jiffies(250));
 	BUG_ON(r = 0);
 
-	dss_start_update(dssdev);
+	dss_start_update(dssdev->manager);
 
 	if (dsi->te_enabled) {
 		/* disable LP_RX_TO, so that we can receive TE.  Time to wait
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 7f6a612..0937bd8 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -182,7 +182,7 @@ void default_get_overlay_fifo_thresholds(enum omap_plane plane,
 int dss_init_overlay_managers(struct platform_device *pdev);
 void dss_uninit_overlay_managers(struct platform_device *pdev);
 int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl);
-void dss_start_update(struct omap_dss_device *dssdev);
+void dss_start_update(struct omap_overlay_manager *mgr);
 
 /* overlay */
 void dss_init_overlays(struct platform_device *pdev);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index c616f85..bc28bfa 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -896,17 +896,14 @@ static int configure_dispc(void)
 	return r;
 }
 
-void dss_start_update(struct omap_dss_device *dssdev)
+void dss_start_update(struct omap_overlay_manager *mgr)
 {
 	struct manager_cache_data *mc;
 	struct overlay_cache_data *oc;
 	const int num_ovls = dss_feat_get_num_ovls();
 	const int num_mgrs = dss_feat_get_num_mgrs();
-	struct omap_overlay_manager *mgr;
 	int i;
 
-	mgr = dssdev->manager;
-
 	mc = &dss_cache.manager_cache[mgr->id];
 
 	mc->do_manual_update = true;
@@ -929,7 +926,7 @@ void dss_start_update(struct omap_dss_device *dssdev)
 		mc->shadow_dirty = false;
 	}
 
-	dssdev->manager->enable(dssdev->manager);
+	mgr->enable(mgr);
 }
 
 static void dss_apply_irq_handler(void *data, u32 mask)
-- 
1.7.4.1

