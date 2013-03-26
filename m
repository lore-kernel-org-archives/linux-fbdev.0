From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Mar 2013 13:33:38 +0000
Subject: [PATCH 08/26] OMAPDSS: use the panel list in omap_dss_get_next_device
Message-Id: <1364304836-18134-9-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_dss_get_next_device() uses the dss bus to iterate over the
displays. This patch changes omap_dss_get_next_device() to use the new
panel list instead.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c |   63 +++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index e785694..50792bf 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -189,27 +189,51 @@ void omap_dss_put_device(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(omap_dss_put_device);
 
-/* ref count of the found device is incremented. ref count
- * of from-device is decremented. */
+/*
+ * ref count of the found device is incremented.
+ * ref count of from-device is decremented.
+ */
 struct omap_dss_device *omap_dss_get_next_device(struct omap_dss_device *from)
 {
-	struct device *dev;
-	struct device *dev_start = NULL;
-	struct omap_dss_device *dssdev = NULL;
+	struct list_head *l;
+	struct omap_dss_device *dssdev;
+
+	mutex_lock(&panel_list_mutex);
+
+	if (list_empty(&panel_list)) {
+		dssdev = NULL;
+		goto out;
+	}
 
-	int match(struct device *dev, void *data)
-	{
-		return 1;
+	if (from = NULL) {
+		dssdev = list_first_entry(&panel_list, struct omap_dss_device,
+				panel_list);
+		omap_dss_get_device(dssdev);
+		goto out;
 	}
 
-	if (from)
-		dev_start = &from->dev;
-	dev = bus_find_device(dss_get_bus(), dev_start, NULL, match);
-	if (dev)
-		dssdev = to_dss_device(dev);
-	if (from)
-		put_device(&from->dev);
+	omap_dss_put_device(from);
+
+	list_for_each(l, &panel_list) {
+		dssdev = list_entry(l, struct omap_dss_device, panel_list);
+		if (dssdev = from) {
+			if (list_is_last(l, &panel_list)) {
+				dssdev = NULL;
+				goto out;
+			}
+
+			dssdev = list_entry(l->next, struct omap_dss_device,
+					panel_list);
+			omap_dss_get_device(dssdev);
+			goto out;
+		}
+	}
+
+	WARN(1, "'from' dssdev not found\n");
 
+	dssdev = NULL;
+out:
+	mutex_unlock(&panel_list_mutex);
 	return dssdev;
 }
 EXPORT_SYMBOL(omap_dss_get_next_device);
@@ -219,12 +243,17 @@ struct omap_dss_device *omap_dss_find_device(void *data,
 {
 	struct omap_dss_device *dssdev = NULL;
 
+	mutex_lock(&panel_list_mutex);
+
 	while ((dssdev = omap_dss_get_next_device(dssdev)) != NULL) {
 		if (match(dssdev, data))
-			return dssdev;
+			goto out;
 	}
 
-	return NULL;
+	dssdev = NULL;
+out:
+	mutex_unlock(&panel_list_mutex);
+	return dssdev;
 }
 EXPORT_SYMBOL(omap_dss_find_device);
 
-- 
1.7.10.4

