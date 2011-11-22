From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:22 +0000
Subject: [PATCH 23/65] OMAPDSS: APPLY: skip isr register and config for manual update displays
Message-Id: <1321953724-6350-24-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The mechanism to cache manager and overlay settings and configure them
into the HW registers in VSYNC is meant only for auto-update displays,
as it doesn't make sense (and doesn't work) for manual-update displays.

This patchs adds a check so that we skip the above for manual update
displays.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 9af5809..04f3ff5 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -629,23 +629,26 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	}
 
 	r = 0;
-	if (!dss_cache.irq_enabled) {
-		u32 mask;
+	if (!mgr_manual_update(mgr)) {
+		if (!dss_cache.irq_enabled) {
+			u32 mask;
 
-		mask = DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
-			DISPC_IRQ_EVSYNC_EVEN;
-		if (dss_has_feature(FEAT_MGR_LCD2))
-			mask |= DISPC_IRQ_VSYNC2;
+			mask = DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
+				DISPC_IRQ_EVSYNC_EVEN;
+			if (dss_has_feature(FEAT_MGR_LCD2))
+				mask |= DISPC_IRQ_VSYNC2;
 
-		r = omap_dispc_register_isr(dss_apply_irq_handler, NULL, mask);
+			r = omap_dispc_register_isr(dss_apply_irq_handler,
+					NULL, mask);
 
-		if (r)
-			DSSERR("failed to register apply isr\n");
+			if (r)
+				DSSERR("failed to register apply isr\n");
 
-		dss_cache.irq_enabled = true;
-	}
+			dss_cache.irq_enabled = true;
+		}
 
-	configure_dispc();
+		configure_dispc();
+	}
 
 	spin_unlock_irqrestore(&dss_cache.lock, flags);
 
-- 
1.7.4.1

