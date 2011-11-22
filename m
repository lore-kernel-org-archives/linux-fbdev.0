From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:30 +0000
Subject: [PATCH 31/65] OMAPDSS: APPLY: use dispc_mgr_get_vsync_irq()
Message-Id: <1321953724-6350-32-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use dispc_mgr_get_vsync_irq() to get the interrupt numbers for vsync,
instead of hardcoding the values depending on the display type.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   36 ++++++++++++------------------------
 1 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 6aad0fd..84ac2d4 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -131,13 +131,7 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 	if (mgr_manual_update(mgr))
 		return 0;
 
-	if (dssdev->type = OMAP_DISPLAY_TYPE_VENC
-			|| dssdev->type = OMAP_DISPLAY_TYPE_HDMI) {
-		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
-	} else {
-		irq = (dssdev->manager->id = OMAP_DSS_CHANNEL_LCD) ?
-			DISPC_IRQ_VSYNC : DISPC_IRQ_VSYNC2;
-	}
+	irq = dispc_mgr_get_vsync_irq(mgr->id);
 
 	mc = &dss_cache.manager_cache[mgr->id];
 	i = 0;
@@ -200,13 +194,7 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 	if (ovl_manual_update(ovl))
 		return 0;
 
-	if (dssdev->type = OMAP_DISPLAY_TYPE_VENC
-			|| dssdev->type = OMAP_DISPLAY_TYPE_HDMI) {
-		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
-	} else {
-		irq = (dssdev->manager->id = OMAP_DSS_CHANNEL_LCD) ?
-			DISPC_IRQ_VSYNC : DISPC_IRQ_VSYNC2;
-	}
+	irq = dispc_mgr_get_vsync_irq(ovl->manager->id);
 
 	oc = &dss_cache.overlay_cache[ovl->id];
 	i = 0;
@@ -421,13 +409,13 @@ static void dss_apply_irq_handler(void *data, u32 mask);
 
 static void dss_register_vsync_isr(void)
 {
+	const int num_mgrs = dss_feat_get_num_mgrs();
 	u32 mask;
-	int r;
+	int r, i;
 
-	mask = DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
-		DISPC_IRQ_EVSYNC_EVEN;
-	if (dss_has_feature(FEAT_MGR_LCD2))
-		mask |= DISPC_IRQ_VSYNC2;
+	mask = 0;
+	for (i = 0; i < num_mgrs; ++i)
+		mask |= dispc_mgr_get_vsync_irq(i);
 
 	r = omap_dispc_register_isr(dss_apply_irq_handler, NULL, mask);
 	WARN_ON(r);
@@ -437,13 +425,13 @@ static void dss_register_vsync_isr(void)
 
 static void dss_unregister_vsync_isr(void)
 {
+	const int num_mgrs = dss_feat_get_num_mgrs();
 	u32 mask;
-	int r;
+	int r, i;
 
-	mask = DISPC_IRQ_VSYNC | DISPC_IRQ_EVSYNC_ODD |
-			DISPC_IRQ_EVSYNC_EVEN;
-	if (dss_has_feature(FEAT_MGR_LCD2))
-		mask |= DISPC_IRQ_VSYNC2;
+	mask = 0;
+	for (i = 0; i < num_mgrs; ++i)
+		mask |= dispc_mgr_get_vsync_irq(i);
 
 	r = omap_dispc_unregister_isr(dss_apply_irq_handler, NULL, mask);
 	WARN_ON(r);
-- 
1.7.4.1

