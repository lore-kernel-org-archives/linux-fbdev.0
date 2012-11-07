From: Archit Taneja <archit@ti.com>
Date: Wed, 07 Nov 2012 09:29:23 +0000
Subject: [PATCH 2/3] OMAPDSS: APPLY: Remove unnecessary variable in dss_apply_irq_handler
Message-Id: <1352279844-10494-3-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <n>
 <1352279844-10494-1-git-send-email-archit@ti.com>
In-Reply-To: <1352279844-10494-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The bool was_updating is never really used for anything. It is set to the
current value of mp->updating, but not used anywhere. Remove this variable.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index b64a083..37a5d22 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -829,7 +829,6 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 	for (i = 0; i < num_mgrs; i++) {
 		struct omap_overlay_manager *mgr;
 		struct mgr_priv_data *mp;
-		bool was_updating;
 
 		mgr = omap_dss_get_overlay_manager(i);
 		mp = get_mgr_priv(mgr);
@@ -837,7 +836,6 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 		if (!mp->enabled)
 			continue;
 
-		was_updating = mp->updating;
 		mp->updating = dispc_mgr_is_enabled(i);
 
 		if (!mgr_manual_update(mgr)) {
-- 
1.7.9.5

