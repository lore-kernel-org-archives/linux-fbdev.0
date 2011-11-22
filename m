From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:22:03 +0000
Subject: [PATCH 64/65] OMAPDSS: APPLY: add return value to dss_mgr_enable()
Message-Id: <1321953724-6350-65-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that dss_mgr_enable() can fail due to checks, make it return the
error value.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   12 +++++++++---
 drivers/video/omap2/dss/dss.h   |    2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 72afa85..1ce4c00 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -967,7 +967,7 @@ static void dss_mgr_setup_fifos(struct omap_overlay_manager *mgr)
 	}
 }
 
-void dss_mgr_enable(struct omap_overlay_manager *mgr)
+int dss_mgr_enable(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
@@ -986,8 +986,7 @@ void dss_mgr_enable(struct omap_overlay_manager *mgr)
 	if (r) {
 		DSSERR("failed to enable manager %d: check_settings failed\n",
 				mgr->id);
-		spin_unlock_irqrestore(&data_lock, flags);
-		goto out;
+		goto err;
 	}
 
 	mp->enabled = true;
@@ -1006,6 +1005,13 @@ void dss_mgr_enable(struct omap_overlay_manager *mgr)
 
 out:
 	mutex_unlock(&apply_lock);
+
+	return 0;
+
+err:
+	spin_unlock_irqrestore(&data_lock, flags);
+	mutex_unlock(&apply_lock);
+	return r;
 }
 
 void dss_mgr_disable(struct omap_overlay_manager *mgr)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index c6caf2f..f91eba3 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -170,7 +170,7 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl);
 void dss_start_update(struct omap_overlay_manager *mgr);
 int omap_dss_mgr_apply(struct omap_overlay_manager *mgr);
 
-void dss_mgr_enable(struct omap_overlay_manager *mgr);
+int dss_mgr_enable(struct omap_overlay_manager *mgr);
 void dss_mgr_disable(struct omap_overlay_manager *mgr);
 int dss_mgr_set_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info);
-- 
1.7.4.1

