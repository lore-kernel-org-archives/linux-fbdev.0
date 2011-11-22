From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:23 +0000
Subject: [PATCH 24/65] OMAPDSS: APPLY: skip isr register and config for disabled displays
Message-Id: <1321953724-6350-25-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

There's no need to register the vsync ISR and configure the hardware if
the overlay manager is disabled, so this patch adds a check for disabled
managers to the omap_dss_mgr_apply() function.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 04f3ff5..cf68c9e 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -629,7 +629,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	}
 
 	r = 0;
-	if (!mgr_manual_update(mgr)) {
+	if (mgr->enabled && !mgr_manual_update(mgr)) {
 		if (!dss_cache.irq_enabled) {
 			u32 mask;
 
-- 
1.7.4.1

