From: Archit Taneja <archit@ti.com>
Date: Mon, 16 Apr 2012 07:35:47 +0000
Subject: [PATCH 6/6] OMAPDSS: APPLY: Remove display dependency from overlay and manager checks
Message-Id: <1334561027-28569-7-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
In-Reply-To: <1334561027-28569-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

In order to check the validity of overlay and manager info, there was a need to
use the omap_dss_device struct to get the panel resolution. manager_info now
contains the manager size(which should be the panel resolution in most cases).
Hence, we don't need to depend on the display resolution.

manager_info is now passed to dss_ovl_check() to see if the overlay fits within
the manager area.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   24 +++++++++++-------------
 drivers/video/omap2/dss/dss.h     |    5 ++---
 drivers/video/omap2/dss/manager.c |    3 +--
 drivers/video/omap2/dss/overlay.c |   20 +++++++++-----------
 4 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 53a198f..5073009 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -198,7 +198,7 @@ static bool mgr_manual_update(struct omap_overlay_manager *mgr)
 }
 
 static int dss_check_settings_low(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev, bool applying)
+		bool applying)
 {
 	struct omap_overlay_info *oi;
 	struct omap_overlay_manager_info *mi;
@@ -228,26 +228,24 @@ static int dss_check_settings_low(struct omap_overlay_manager *mgr,
 		ois[ovl->id] = oi;
 	}
 
-	return dss_mgr_check(mgr, dssdev, mi, ois);
+	return dss_mgr_check(mgr, mi, ois);
 }
 
 /*
  * check manager and overlay settings using overlay_info from data->info
  */
-static int dss_check_settings(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev)
+static int dss_check_settings(struct omap_overlay_manager *mgr)
 {
-	return dss_check_settings_low(mgr, dssdev, false);
+	return dss_check_settings_low(mgr, false);
 }
 
 /*
  * check manager and overlay settings using overlay_info from ovl->info if
  * dirty and from data->info otherwise
  */
-static int dss_check_settings_apply(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev)
+static int dss_check_settings_apply(struct omap_overlay_manager *mgr)
 {
-	return dss_check_settings_low(mgr, dssdev, true);
+	return dss_check_settings_low(mgr, true);
 }
 
 static bool need_isr(void)
@@ -668,7 +666,7 @@ static void dss_write_regs(void)
 		if (!mp->enabled || mgr_manual_update(mgr) || mp->busy)
 			continue;
 
-		r = dss_check_settings(mgr, mgr->device);
+		r = dss_check_settings(mgr);
 		if (r) {
 			DSSERR("cannot write registers for manager %s: "
 					"illegal configuration\n", mgr->name);
@@ -733,7 +731,7 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 
 	WARN_ON(mp->updating);
 
-	r = dss_check_settings(mgr, mgr->device);
+	r = dss_check_settings(mgr);
 	if (r) {
 		DSSERR("cannot start manual update: illegal configuration\n");
 		spin_unlock_irqrestore(&data_lock, flags);
@@ -879,7 +877,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	r = dss_check_settings_apply(mgr, mgr->device);
+	r = dss_check_settings_apply(mgr);
 	if (r) {
 		spin_unlock_irqrestore(&data_lock, flags);
 		DSSERR("failed to apply settings: illegal configuration.\n");
@@ -1072,7 +1070,7 @@ int dss_mgr_enable(struct omap_overlay_manager *mgr)
 
 	mp->enabled = true;
 
-	r = dss_check_settings(mgr, mgr->device);
+	r = dss_check_settings(mgr);
 	if (r) {
 		DSSERR("failed to enable manager %d: check_settings failed\n",
 				mgr->id);
@@ -1415,7 +1413,7 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 
 	op->enabling = true;
 
-	r = dss_check_settings(ovl->manager, ovl->manager->device);
+	r = dss_check_settings(ovl->manager);
 	if (r) {
 		DSSERR("failed to enable overlay %d: check_settings failed\n",
 				ovl->id);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 9e47bdf..fb5ca51 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -209,7 +209,6 @@ int dss_mgr_simple_check(struct omap_overlay_manager *mgr,
 int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
 		struct omap_video_timings *timings);
 int dss_mgr_check(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev,
 		struct omap_overlay_manager_info *info,
 		struct omap_overlay_info **overlay_infos);
 int dss_mgr_set_timings(struct omap_overlay_manager *mgr,
@@ -222,8 +221,8 @@ void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr);
 void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 int dss_ovl_simple_check(struct omap_overlay *ovl,
 		const struct omap_overlay_info *info);
-int dss_ovl_check(struct omap_overlay *ovl,
-		struct omap_overlay_info *info, struct omap_dss_device *dssdev);
+int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *info,
+		struct omap_overlay_manager_info *mgr_info);
 
 /* DSS */
 int dss_init_platform_driver(void);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index fb61b76..9821015 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -666,7 +666,6 @@ int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
 }
 
 int dss_mgr_check(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev,
 		struct omap_overlay_manager_info *info,
 		struct omap_overlay_info **overlay_infos)
 {
@@ -692,7 +691,7 @@ int dss_mgr_check(struct omap_overlay_manager *mgr,
 		if (oi = NULL)
 			continue;
 
-		r = dss_ovl_check(ovl, oi, dssdev);
+		r = dss_ovl_check(ovl, oi, info);
 		if (r)
 			return r;
 	}
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 6e82181..4436376 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -631,16 +631,14 @@ int dss_ovl_simple_check(struct omap_overlay *ovl,
 	return 0;
 }
 
-int dss_ovl_check(struct omap_overlay *ovl,
-		struct omap_overlay_info *info, struct omap_dss_device *dssdev)
+int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *info,
+		struct omap_overlay_manager_info *mgr_info)
 {
 	u16 outw, outh;
-	u16 dw, dh;
+	u16 mgr_width, mgr_height;
 
-	if (dssdev = NULL)
-		return 0;
-
-	dssdev->driver->get_resolution(dssdev, &dw, &dh);
+	mgr_width = mgr_info->timings.x_res;
+	mgr_height = mgr_info->timings.y_res;
 
 	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) = 0) {
 		outw = info->width;
@@ -657,17 +655,17 @@ int dss_ovl_check(struct omap_overlay *ovl,
 			outh = info->out_height;
 	}
 
-	if (dw < info->pos_x + outw) {
+	if (mgr_width < info->pos_x + outw) {
 		DSSERR("overlay %d horizontally not inside the display area "
 				"(%d + %d >= %d)\n",
-				ovl->id, info->pos_x, outw, dw);
+				ovl->id, info->pos_x, outw, mgr_width);
 		return -EINVAL;
 	}
 
-	if (dh < info->pos_y + outh) {
+	if (mgr_height < info->pos_y + outh) {
 		DSSERR("overlay %d vertically not inside the display area "
 				"(%d + %d >= %d)\n",
-				ovl->id, info->pos_y, outh, dh);
+				ovl->id, info->pos_y, outh, mgr_height);
 		return -EINVAL;
 	}
 
-- 
1.7.5.4

