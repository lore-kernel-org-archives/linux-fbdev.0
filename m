From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:21 +0000
Subject: [PATCH 22/65] OMAPDSS: APPLY: track whether a manager is enabled
Message-Id: <1321953724-6350-23-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add "enabled" field to struct omap_overlay_manager, which tells if the
output is enabled or not. This will be used in apply.c in the following
patches.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    2 ++
 include/video/omapdss.h         |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index ebc0ae1..9af5809 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -657,10 +657,12 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 void dss_mgr_enable(struct omap_overlay_manager *mgr)
 {
 	dispc_mgr_enable(mgr->id, true);
+	mgr->enabled = true;
 }
 
 void dss_mgr_disable(struct omap_overlay_manager *mgr)
 {
 	dispc_mgr_enable(mgr->id, false);
+	mgr->enabled = false;
 }
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 04741cd..d61efc3 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -432,6 +432,8 @@ struct omap_overlay_manager {
 	struct omap_dss_device *device;
 	struct omap_overlay_manager_info info;
 
+	bool enabled;
+
 	bool device_changed;
 	/* if true, info has been changed but not applied() yet */
 	bool info_dirty;
-- 
1.7.4.1

