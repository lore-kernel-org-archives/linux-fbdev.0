From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:34:42 +0000
Subject: [PATCH 21/32] OMAPDSS: add panel list
Message-Id: <1369906493-27538-22-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We currently use the omapdss bus (which contains all the available
displays) to iterate the displays. As the omapdss bus is on its way out,
this needs to be changed.

Instead of using the dss bus to iterate displays, this patch adds our
own list of displays which we manage. The panels on the dss bus are
automatically added to this new list.

An "alias" field is also added to omap_dss_device. This field is
set to "display%d", the same way as omap_dss_device's dev name is set.
This alias is later used to keep backward compatibility, when the
embedded dev is no longer used.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c    |  2 ++
 drivers/video/omap2/dss/display.c | 32 ++++++++++++++++++++++++++++++++
 include/video/omapdss.h           |  8 ++++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index f64d0ac..186bc76 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -469,6 +469,7 @@ struct omap_dss_device *dss_alloc_and_init_device(struct device *parent)
 
 int dss_add_device(struct omap_dss_device *dssdev)
 {
+	omapdss_register_display(dssdev);
 	return device_add(&dssdev->dev);
 }
 
@@ -480,6 +481,7 @@ void dss_put_device(struct omap_dss_device *dssdev)
 void dss_unregister_device(struct omap_dss_device *dssdev)
 {
 	device_unregister(&dssdev->dev);
+	omapdss_unregister_display(dssdev);
 }
 
 static int dss_unregister_dss_dev(struct device *dev, void *data)
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 72ac058..1c175a4 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -146,6 +146,38 @@ void dss_disable_all_devices(void)
 	bus_for_each_dev(bus, NULL, NULL, dss_disable_device);
 }
 
+static LIST_HEAD(panel_list);
+static DEFINE_MUTEX(panel_list_mutex);
+static int disp_num_counter;
+
+int omapdss_register_display(struct omap_dss_device *dssdev)
+{
+	struct omap_dss_driver *drv = dssdev->driver;
+
+	snprintf(dssdev->alias, sizeof(dssdev->alias),
+			"display%d", disp_num_counter++);
+
+	if (drv && drv->get_resolution = NULL)
+		drv->get_resolution = omapdss_default_get_resolution;
+	if (drv && drv->get_recommended_bpp = NULL)
+		drv->get_recommended_bpp = omapdss_default_get_recommended_bpp;
+	if (drv && drv->get_timings = NULL)
+		drv->get_timings = omapdss_default_get_timings;
+
+	mutex_lock(&panel_list_mutex);
+	list_add_tail(&dssdev->panel_list, &panel_list);
+	mutex_unlock(&panel_list_mutex);
+	return 0;
+}
+EXPORT_SYMBOL(omapdss_register_display);
+
+void omapdss_unregister_display(struct omap_dss_device *dssdev)
+{
+	mutex_lock(&panel_list_mutex);
+	list_del(&dssdev->panel_list);
+	mutex_unlock(&panel_list_mutex);
+}
+EXPORT_SYMBOL(omapdss_unregister_display);
 
 void omap_dss_get_device(struct omap_dss_device *dssdev)
 {
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6c422f7..b19a8d2 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -598,6 +598,11 @@ struct omap_dss_output {
 struct omap_dss_device {
 	struct device dev;
 
+	struct list_head panel_list;
+
+	/* alias in the form of "display%d" */
+	char alias[16];
+
 	enum omap_display_type type;
 
 	/* obsolete, to be removed */
@@ -758,6 +763,9 @@ enum omapdss_version omapdss_get_version(void);
 int omap_dss_register_driver(struct omap_dss_driver *);
 void omap_dss_unregister_driver(struct omap_dss_driver *);
 
+int omapdss_register_display(struct omap_dss_device *dssdev);
+void omapdss_unregister_display(struct omap_dss_device *dssdev);
+
 void omap_dss_get_device(struct omap_dss_device *dssdev);
 void omap_dss_put_device(struct omap_dss_device *dssdev);
 #define for_each_dss_dev(d) while ((d = omap_dss_get_next_device(d)) != NULL)
-- 
1.8.1.2

