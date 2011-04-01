From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 01 Apr 2011 10:00:26 +0000
Subject: [PATCH 1/5] OMAP: DSS2: make omap_dss_(un)register_device static
Message-Id: <1301652030-32223-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_dss_register_device and omap_dss_unregister_device can only be
called from core.c, so we can make it static.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    3 ---
 drivers/video/omap2/dss/core.c            |    7 +++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 5e04ddc..e239a0d 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -519,9 +519,6 @@ struct omap_dss_driver {
 int omap_dss_register_driver(struct omap_dss_driver *);
 void omap_dss_unregister_driver(struct omap_dss_driver *);
 
-int omap_dss_register_device(struct omap_dss_device *);
-void omap_dss_unregister_device(struct omap_dss_device *);
-
 void omap_dss_get_device(struct omap_dss_device *dssdev);
 void omap_dss_put_device(struct omap_dss_device *dssdev);
 #define for_each_dss_dev(d) while ((d = omap_dss_get_next_device(d)) != NULL)
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 1aa2ed1..9bcb0b8 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -54,6 +54,9 @@ unsigned int dss_debug;
 module_param_named(debug, dss_debug, bool, 0644);
 #endif
 
+static int omap_dss_register_device(struct omap_dss_device *);
+static void omap_dss_unregister_device(struct omap_dss_device *);
+
 /* REGULATORS */
 
 struct regulator *dss_get_vdds_dsi(void)
@@ -480,7 +483,7 @@ static void omap_dss_dev_release(struct device *dev)
 	reset_device(dev, 0);
 }
 
-int omap_dss_register_device(struct omap_dss_device *dssdev)
+static int omap_dss_register_device(struct omap_dss_device *dssdev)
 {
 	static int dev_num;
 
@@ -494,7 +497,7 @@ int omap_dss_register_device(struct omap_dss_device *dssdev)
 	return device_register(&dssdev->dev);
 }
 
-void omap_dss_unregister_device(struct omap_dss_device *dssdev)
+static void omap_dss_unregister_device(struct omap_dss_device *dssdev)
 {
 	device_unregister(&dssdev->dev);
 }
-- 
1.7.1

