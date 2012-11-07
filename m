From: Archit Taneja <archit@ti.com>
Date: Wed, 07 Nov 2012 09:29:24 +0000
Subject: [PATCH 3/3] OMAPDSS: APPLY: Remove unnecessary call to mg_clear_shadow_dirty
Message-Id: <1352279844-10494-4-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <n>
 <1352279844-10494-1-git-send-email-archit@ti.com>
In-Reply-To: <1352279844-10494-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

When doing a manual update in dss_mgr_start_update, we clear the shadow dirty
flags. Although there isn't any harm in clearing them. The need to clear them
out here should never arrive.

When applying configurations for a manual update manager, we never do any
register writes, i.e, calls to dss_mgr_write_regs and dss_mgr_write_regs_extra
never happen while applying. We do all these writes only when we call
dss_mgr_start_update. Hence, there is never a time when the shadow registers
are dirty.

Remove the call to mg_clear_shadow_dirty.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 37a5d22..7a7b820 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -772,8 +772,6 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 
 	dispc_mgr_enable_sync(mgr->id);
 
-	mgr_clear_shadow_dirty(mgr);
-
 	spin_unlock_irqrestore(&data_lock, flags);
 }
 
-- 
1.7.9.5

