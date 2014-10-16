From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 16 Oct 2014 09:39:45 +0000
Subject: [PATCH 3/5] OMAPDSS: apply: wait pending updates on manager disable
Message-Id: <1413452387-25452-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

We should wait for any pending updates when an overlay manager is
about to be disabled, because the updates will never be finished if the
manager is disabled too early.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/apply.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/apply.c b/drivers/video/fbdev/omap2/dss/apply.c
index 0a0b084ce65d..663ccc3bf4e5 100644
--- a/drivers/video/fbdev/omap2/dss/apply.c
+++ b/drivers/video/fbdev/omap2/dss/apply.c
@@ -1132,6 +1132,8 @@ static void dss_mgr_disable_compat(struct omap_overlay_manager *mgr)
 	if (!mp->enabled)
 		goto out;
 
+	wait_pending_extra_info_updates();
+
 	if (!mgr_manual_update(mgr))
 		dispc_mgr_disable_sync(mgr->id);
 
-- 
2.1.1

