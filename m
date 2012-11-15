From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Nov 2012 15:58:28 +0000
Subject: [PATCH 20/32] OMAPDSS: add manager ops
Message-Id: <1352995120-3288-21-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

The output drivers need some operations from the overlay managers, like
enable and set_timings. These will affect the dispc registers, and need
to be synchronized with the composition-side changes with overlays and
overlay managers.

We want to handle these calls in the apply.c in the compatibility mode,
but when in non-compat mode, the calls need to be handled by some other
component (e.g. omapdrm).

To make this possible, this patch creates a set of function pointers in
a dss_mgr_ops struct, that is used to redirect the calls into the
correct destination.

The non-compat users can install their mgr ops with
dss_install_mgr_ops() function.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c  |   36 +++++++++++++++++++++++++------
 drivers/video/omap2/dss/dss.h    |   13 +++++++++++
 drivers/video/omap2/dss/output.c |   44 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 91d02db..ca85eaf 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -781,7 +781,7 @@ static void mgr_clear_shadow_dirty(struct omap_overlay_manager *mgr)
 	}
 }
 
-void dss_mgr_start_update(struct omap_overlay_manager *mgr)
+static void dss_mgr_start_update_compat(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
@@ -1021,7 +1021,7 @@ static void dss_setup_fifos(void)
 	}
 }
 
-int dss_mgr_enable(struct omap_overlay_manager *mgr)
+static int dss_mgr_enable_compat(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
@@ -1071,7 +1071,7 @@ err:
 	return r;
 }
 
-void dss_mgr_disable(struct omap_overlay_manager *mgr)
+static void dss_mgr_disable_compat(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
@@ -1208,7 +1208,7 @@ static void dss_apply_mgr_timings(struct omap_overlay_manager *mgr,
 	mp->extra_info_dirty = true;
 }
 
-void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
+static void dss_mgr_set_timings_compat(struct omap_overlay_manager *mgr,
 		const struct omap_video_timings *timings)
 {
 	unsigned long flags;
@@ -1236,7 +1236,7 @@ static void dss_apply_mgr_lcd_config(struct omap_overlay_manager *mgr,
 	mp->extra_info_dirty = true;
 }
 
-void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
+static void dss_mgr_set_lcd_config_compat(struct omap_overlay_manager *mgr,
 		const struct dss_lcd_mgr_config *config)
 {
 	unsigned long flags;
@@ -1501,12 +1501,20 @@ err:
 	return r;
 }
 
+static const struct dss_mgr_ops apply_mgr_ops = {
+	.start_update = dss_mgr_start_update_compat,
+	.enable = dss_mgr_enable_compat,
+	.disable = dss_mgr_disable_compat,
+	.set_timings = dss_mgr_set_timings_compat,
+	.set_lcd_config = dss_mgr_set_lcd_config_compat,
+};
+
 static int compat_refcnt;
 
 int omapdss_compat_init(void)
 {
 	struct platform_device *pdev = dss_get_core_pdev();
-	int i;
+	int i, r;
 
 	mutex_lock(&apply_lock);
 
@@ -1547,10 +1555,24 @@ int omapdss_compat_init(void)
 		ovl->get_device = &dss_ovl_get_device;
 	}
 
+	r = dss_install_mgr_ops(&apply_mgr_ops);
+	if (r)
+		goto err_mgr_ops;
+
 out:
 	mutex_unlock(&apply_lock);
 
 	return 0;
+
+err_mgr_ops:
+	dss_uninit_overlay_managers(pdev);
+	dss_uninit_overlays(pdev);
+
+	compat_refcnt--;
+
+	mutex_unlock(&apply_lock);
+
+	return r;
 }
 EXPORT_SYMBOL(omapdss_compat_init);
 
@@ -1563,6 +1585,8 @@ void omapdss_compat_uninit(void)
 	if (--compat_refcnt > 0)
 		goto out;
 
+	dss_uninstall_mgr_ops();
+
 	dss_uninit_overlay_managers(pdev);
 	dss_uninit_overlays(pdev);
 out:
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 2cd126c..dbe54c0 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -523,4 +523,17 @@ static inline void dss_collect_irq_stats(u32 irqstatus, unsigned *irq_arr)
 }
 #endif
 
+struct dss_mgr_ops {
+	void (*start_update)(struct omap_overlay_manager *mgr);
+	int (*enable)(struct omap_overlay_manager *mgr);
+	void (*disable)(struct omap_overlay_manager *mgr);
+	void (*set_timings)(struct omap_overlay_manager *mgr,
+			const struct omap_video_timings *timings);
+	void (*set_lcd_config)(struct omap_overlay_manager *mgr,
+			const struct dss_lcd_mgr_config *config);
+};
+
+int dss_install_mgr_ops(const struct dss_mgr_ops *mgr_ops);
+void dss_uninstall_mgr_ops(void);
+
 #endif
diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 813f266..c8972bf 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -146,3 +146,47 @@ struct omap_dss_output *omapdss_get_output_from_dssdev(struct omap_dss_device *d
 
 	return out;
 }
+
+static const struct dss_mgr_ops *dss_mgr_ops;
+
+int dss_install_mgr_ops(const struct dss_mgr_ops *mgr_ops)
+{
+	if (dss_mgr_ops)
+		return -EBUSY;
+
+	dss_mgr_ops = mgr_ops;
+
+	return 0;
+}
+
+void dss_uninstall_mgr_ops(void)
+{
+	dss_mgr_ops = NULL;
+}
+
+void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
+		const struct omap_video_timings *timings)
+{
+	dss_mgr_ops->set_timings(mgr, timings);
+}
+
+void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
+		const struct dss_lcd_mgr_config *config)
+{
+	dss_mgr_ops->set_lcd_config(mgr, config);
+}
+
+int dss_mgr_enable(struct omap_overlay_manager *mgr)
+{
+	return dss_mgr_ops->enable(mgr);
+}
+
+void dss_mgr_disable(struct omap_overlay_manager *mgr)
+{
+	dss_mgr_ops->disable(mgr);
+}
+
+void dss_mgr_start_update(struct omap_overlay_manager *mgr)
+{
+	dss_mgr_ops->start_update(mgr);
+}
-- 
1.7.10.4

