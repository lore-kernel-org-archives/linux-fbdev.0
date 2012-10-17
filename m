From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Oct 2012 11:20:31 +0000
Subject: [PATCH 5/9] OMAPDSS: remove declarations for non-existing funcs
Message-Id: <1350472835-28727-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_mgr_set_device and dss_mgr_unset_device are declared in dss.h, but
the functions do not exist. Remove the declarations.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8447871..373847c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -217,9 +217,6 @@ int dss_mgr_set_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info);
 void dss_mgr_get_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info);
-int dss_mgr_set_device(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev);
-int dss_mgr_unset_device(struct omap_overlay_manager *mgr);
 int dss_mgr_set_output(struct omap_overlay_manager *mgr,
 		struct omap_dss_output *output);
 int dss_mgr_unset_output(struct omap_overlay_manager *mgr);
-- 
1.7.9.5

