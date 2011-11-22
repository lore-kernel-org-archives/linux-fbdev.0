From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:59 +0000
Subject: [PATCH 60/65] OMAPDSS: Add comments about blocking of ovl/mgr functions
Message-Id: <1321953724-6350-61-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add comments specifying what ovl/mgr functions may block.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 98fc026..39862b8 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -384,6 +384,17 @@ struct omap_overlay {
 	/* dynamic fields */
 	struct omap_overlay_manager *manager;
 
+	/*
+	 * The following functions do not block:
+	 *
+	 * is_enabled
+	 * set_overlay_info
+	 * get_overlay_info
+	 *
+	 * The rest of the functions may block and cannot be called from
+	 * interrupt context
+	 */
+
 	int (*enable)(struct omap_overlay *ovl);
 	int (*disable)(struct omap_overlay *ovl);
 	bool (*is_enabled)(struct omap_overlay *ovl);
@@ -426,6 +437,17 @@ struct omap_overlay_manager {
 	/* dynamic fields */
 	struct omap_dss_device *device;
 
+	/*
+	 * The following functions do not block:
+	 *
+	 * set_manager_info
+	 * get_manager_info
+	 * apply
+	 *
+	 * The rest of the functions may block and cannot be called from
+	 * interrupt context
+	 */
+
 	int (*set_device)(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev);
 	int (*unset_device)(struct omap_overlay_manager *mgr);
-- 
1.7.4.1

