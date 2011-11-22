From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:26 +0000
Subject: [PATCH 27/65] OMAPDSS: store managers in an array
Message-Id: <1321953724-6350-28-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Overlay managers are stored in a linked list. There's no need for this
list, as an array would do just as fine.

This patch changes the code to use an array for overlay managers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/manager.c |   49 +++++++++++++------------------------
 include/video/omapdss.h           |    1 -
 2 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 780a307..a08cc6e 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -34,7 +34,7 @@
 #include "dss_features.h"
 
 static int num_managers;
-static struct list_head manager_list;
+static struct omap_overlay_manager *managers;
 
 static ssize_t manager_name_show(struct omap_overlay_manager *mgr, char *buf)
 {
@@ -585,25 +585,19 @@ static void omap_dss_mgr_get_info(struct omap_overlay_manager *mgr,
 	*info = mgr->info;
 }
 
-static void omap_dss_add_overlay_manager(struct omap_overlay_manager *manager)
-{
-	++num_managers;
-	list_add_tail(&manager->list, &manager_list);
-}
-
 int dss_init_overlay_managers(struct platform_device *pdev)
 {
 	int i, r;
 
-	INIT_LIST_HEAD(&manager_list);
+	num_managers = dss_feat_get_num_mgrs();
 
-	num_managers = 0;
+	managers = kzalloc(sizeof(struct omap_overlay_manager) * num_managers,
+			GFP_KERNEL);
 
-	for (i = 0; i < dss_feat_get_num_mgrs(); ++i) {
-		struct omap_overlay_manager *mgr;
-		mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+	BUG_ON(managers = NULL);
 
-		BUG_ON(mgr = NULL);
+	for (i = 0; i < num_managers; ++i) {
+		struct omap_overlay_manager *mgr = &managers[i];
 
 		switch (i) {
 		case 0:
@@ -634,15 +628,11 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 
 		dss_overlay_setup_dispc_manager(mgr);
 
-		omap_dss_add_overlay_manager(mgr);
-
 		r = kobject_init_and_add(&mgr->kobj, &manager_ktype,
 				&pdev->dev.kobj, "manager%d", i);
 
-		if (r) {
+		if (r)
 			DSSERR("failed to create sysfs file\n");
-			continue;
-		}
 	}
 
 	return 0;
@@ -650,17 +640,17 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 
 void dss_uninit_overlay_managers(struct platform_device *pdev)
 {
-	struct omap_overlay_manager *mgr;
+	int i;
+
+	for (i = 0; i < num_managers; ++i) {
+		struct omap_overlay_manager *mgr = &managers[i];
 
-	while (!list_empty(&manager_list)) {
-		mgr = list_first_entry(&manager_list,
-				struct omap_overlay_manager, list);
-		list_del(&mgr->list);
 		kobject_del(&mgr->kobj);
 		kobject_put(&mgr->kobj);
-		kfree(mgr);
 	}
 
+	kfree(managers);
+	managers = NULL;
 	num_managers = 0;
 }
 
@@ -672,15 +662,10 @@ EXPORT_SYMBOL(omap_dss_get_num_overlay_managers);
 
 struct omap_overlay_manager *omap_dss_get_overlay_manager(int num)
 {
-	int i = 0;
-	struct omap_overlay_manager *mgr;
-
-	list_for_each_entry(mgr, &manager_list, list) {
-		if (i++ = num)
-			return mgr;
-	}
+	if (num >= num_managers)
+		return NULL;
 
-	return NULL;
+	return &managers[num];
 }
 EXPORT_SYMBOL(omap_dss_get_overlay_manager);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index d61efc3..fd5a96c 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -418,7 +418,6 @@ struct omap_overlay_manager_info {
 
 struct omap_overlay_manager {
 	struct kobject kobj;
-	struct list_head list;
 
 	/* static fields */
 	const char *name;
-- 
1.7.4.1

