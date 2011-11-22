From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:55 +0000
Subject: [PATCH 56/65] OMAPDSS: APPLY: add dss_apply_ovl_enable()
Message-Id: <1321953724-6350-57-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add a helper function dss_apply_ovl_enable(), which is similar to the
main apply() function: dss_apply_ovl_enable() applies the given overlay
enable-status to ovl_priv_data, and sets the dirty flag.

The difference between the helper function and the previous direct use
of the fields is that the helper function will not do anything if the
enable state is already the same as given in the parameter.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 916acd7..cfc17c0 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -646,6 +646,19 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	return r;
 }
 
+static void dss_apply_ovl_enable(struct omap_overlay *ovl, bool enable)
+{
+	struct ovl_priv_data *op;
+
+	op = get_ovl_priv(ovl);
+
+	if (op->enabled = enable)
+		return;
+
+	op->enabled = enable;
+	op->extra_info_dirty = true;
+}
+
 static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
@@ -999,8 +1012,7 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	op->enabled = true;
-	op->extra_info_dirty = true;
+	dss_apply_ovl_enable(ovl, true);
 
 	dss_ovl_setup_fifo(ovl);
 
@@ -1031,8 +1043,7 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	op->enabled = false;
-	op->extra_info_dirty = true;
+	dss_apply_ovl_enable(ovl, false);
 
 	dss_write_regs();
 
-- 
1.7.4.1

