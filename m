From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:18 +0000
Subject: [PATCH 19/65] OMAPDSS: apply affects only one overlay manager
Message-Id: <1321953724-6350-20-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_dss_mgr_apply currently applies settings to all overlays and
overlay managers. The reason for this was to support cases where
configuration changes affecting multiple managers are made. However, the
current code doesn't support changing such configurations, so the
functionality is not needed.

Change the apply to affect only the manager given as an argument, and
the overlays attached to that manager.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/manager.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 3aca2b4..5c120ac 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -1114,23 +1114,28 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	spin_lock_irqsave(&dss_cache.lock, flags);
 
 	/* Configure overlays */
-	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+	for (i = 0; i < mgr->num_overlays; ++i) {
 		struct omap_overlay *ovl;
 
-		ovl = omap_dss_get_overlay(i);
+		ovl = mgr->overlays[i];
+
+		if (ovl->manager != mgr)
+			continue;
 
 		omap_dss_mgr_apply_ovl(ovl);
 	}
 
-	/* Configure managers */
-	list_for_each_entry(mgr, &manager_list, list)
-		omap_dss_mgr_apply_mgr(mgr);
+	/* Configure manager */
+	omap_dss_mgr_apply_mgr(mgr);
 
 	/* Configure overlay fifos */
-	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+	for (i = 0; i < mgr->num_overlays; ++i) {
 		struct omap_overlay *ovl;
 
-		ovl = omap_dss_get_overlay(i);
+		ovl = mgr->overlays[i];
+
+		if (ovl->manager != mgr)
+			continue;
 
 		omap_dss_mgr_apply_ovl_fifos(ovl);
 	}
-- 
1.7.4.1

