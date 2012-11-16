From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Fri, 16 Nov 2012 22:29:05 +0000
Subject: [PATCH v2] backlight: Add of_find_backlight_by_node() function
Message-Id: <1353104945-24153-1-git-send-email-thierry.reding@avionic-design.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jingoo Han <jg1.han@samsung.com>, Grant Likely <grant.likely@secretlab.ca>, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

This function finds the struct backlight_device for a given device tree
node. A dummy function is provided so that it safely compiles out if OF
support is disabled.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Jingoo Han <jg1.han@samsung.com>
---
Changes in v2:
- use #ifdef CONFIG_OF instead of #if IS_ENABLED(CONFIG_OF)
- add kerneldoc to of_find_backlight_by_node() function

 drivers/video/backlight/backlight.c | 29 +++++++++++++++++++++++++++++
 include/linux/backlight.h           | 10 ++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 297db2f..345f666 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -370,6 +370,35 @@ void backlight_device_unregister(struct backlight_device *bd)
 }
 EXPORT_SYMBOL(backlight_device_unregister);
 
+#ifdef CONFIG_OF
+static int of_parent_match(struct device *dev, void *data)
+{
+	return dev->parent && dev->parent->of_node = data;
+}
+
+/**
+ * of_find_backlight_by_node() - find backlight device by device-tree node
+ * @node: device-tree node of the backlight device
+ *
+ * Returns a pointer to the backlight device corresponding to the given DT
+ * node or NULL if no such backlight device exists or if the device hasn't
+ * been probed yet.
+ *
+ * This function obtains a reference on the backlight device and it is the
+ * caller's responsibility to drop the reference by calling put_device() on
+ * the backlight device's .dev field.
+ */
+struct backlight_device *of_find_backlight_by_node(struct device_node *node)
+{
+	struct device *dev;
+
+	dev = class_find_device(backlight_class, NULL, node, of_parent_match);
+
+	return dev ? to_backlight_device(dev) : NULL;
+}
+EXPORT_SYMBOL(of_find_backlight_by_node);
+#endif
+
 static void __exit backlight_class_exit(void)
 {
 	class_destroy(backlight_class);
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 5ffc6dd..da9a082 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -134,4 +134,14 @@ struct generic_bl_info {
 	void (*kick_battery)(void);
 };
 
+#ifdef CONFIG_OF
+struct backlight_device *of_find_backlight_by_node(struct device_node *node);
+#else
+static inline struct backlight_device *
+of_find_backlight_by_node(struct device_node *node)
+{
+	return NULL;
+}
+#endif
+
 #endif
-- 
1.8.0

