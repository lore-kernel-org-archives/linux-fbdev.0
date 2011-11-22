From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:58 +0000
Subject: [PATCH 59/65] OMAPDSS: APPLY: remove runtime_get
Message-Id: <1321953724-6350-60-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

apply.c no longer touches any registers if an output is not enabled.
This means that we don't need to do dispc_runtime_get() anymore, and the
calls can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 75db522..6a50ee0 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -688,16 +688,11 @@ static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
 
 int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 {
-	int r;
 	unsigned long flags;
 	struct omap_overlay *ovl;
 
 	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
 
-	r = dispc_runtime_get();
-	if (r)
-		return r;
-
 	spin_lock_irqsave(&data_lock, flags);
 
 	/* Configure overlays */
@@ -711,9 +706,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
-	dispc_runtime_put();
-
-	return r;
+	return 0;
 }
 
 static void dss_apply_ovl_enable(struct omap_overlay *ovl, bool enable)
-- 
1.7.4.1

