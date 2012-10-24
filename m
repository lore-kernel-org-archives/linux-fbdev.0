From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 24 Oct 2012 09:29:09 +0000
Subject: [PATCH 18/20] OMAPDSS: DISPC: fix loop in error handler
Message-Id: <1351070951-18616-19-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The dispc's error handler has a loop inside another loop, and both use
the same loop variable. This is clearly wrong, and this patch makes a
new variable for the inner loop.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d294873..070ce30 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3901,6 +3901,7 @@ static void dispc_error_worker(struct work_struct *work)
 		bit = mgr_desc[i].sync_lost_irq;
 
 		if (bit & errors) {
+			int j;
 			struct omap_dss_device *dssdev = mgr->get_device(mgr);
 			bool enable;
 
@@ -3911,9 +3912,9 @@ static void dispc_error_worker(struct work_struct *work)
 			enable = dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 			dssdev->driver->disable(dssdev);
 
-			for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+			for (j = 0; j < omap_dss_get_num_overlays(); ++j) {
 				struct omap_overlay *ovl;
-				ovl = omap_dss_get_overlay(i);
+				ovl = omap_dss_get_overlay(j);
 
 				if (ovl->id != OMAP_DSS_GFX &&
 						ovl->manager = mgr)
-- 
1.7.9.5

