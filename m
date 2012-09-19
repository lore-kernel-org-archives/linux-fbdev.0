From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 19 Sep 2012 08:30:35 +0000
Subject: [PATCH 5/8] OMAPDSS: handle errors in dss_init_device
Message-Id: <1348043438-2624-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add error handling to dss_init_device(), which has, for some reason,
been missing.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c    |    4 +++-
 drivers/video/omap2/dss/display.c |   23 ++++++++++++++++++-----
 drivers/video/omap2/dss/dss.h     |    2 +-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 315f557..9315ece 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -358,7 +358,9 @@ static int dss_driver_probe(struct device *dev)
 				dev_name(dev), dssdev->driver_name,
 				dssdrv->driver.name);
 
-	dss_init_device(core.pdev, dssdev);
+	r = dss_init_device(core.pdev, dssdev);
+	if (r)
+		return r;
 
 	force = core.default_display_name &&
 		strcmp(core.default_display_name, dssdev->name) = 0;
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 5f09d503..f719010 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -320,26 +320,39 @@ void omapdss_default_get_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_default_get_timings);
 
-void dss_init_device(struct platform_device *pdev,
+int dss_init_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev)
 {
 	struct device_attribute *attr;
-	int i;
-	int r;
+	int i, r;
 
 	/* create device sysfs files */
 	i = 0;
 	while ((attr = display_sysfs_attrs[i++]) != NULL) {
 		r = device_create_file(&dssdev->dev, attr);
-		if (r)
+		if (r) {
+			for (i = i - 2; i >= 0; i--) {
+				attr = display_sysfs_attrs[i];
+				device_remove_file(&dssdev->dev, attr);
+			}
+
 			DSSERR("failed to create sysfs file\n");
+			return r;
+		}
 	}
 
 	/* create display? sysfs links */
 	r = sysfs_create_link(&pdev->dev.kobj, &dssdev->dev.kobj,
 			dev_name(&dssdev->dev));
-	if (r)
+	if (r) {
+		while ((attr = display_sysfs_attrs[i++]) != NULL)
+			device_remove_file(&dssdev->dev, attr);
+
 		DSSERR("failed to create sysfs display link\n");
+		return r;
+	}
+
+	return 0;
 }
 
 void dss_uninit_device(struct platform_device *pdev,
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index a977826..98e8273 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -228,7 +228,7 @@ int dss_suspend_all_devices(void);
 int dss_resume_all_devices(void);
 void dss_disable_all_devices(void);
 
-void dss_init_device(struct platform_device *pdev,
+int dss_init_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev);
 void dss_uninit_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev);
-- 
1.7.9.5

