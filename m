From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Fri, 09 Nov 2012 14:04:38 +0000
Subject: [PATCH] backlight: Add of_find_backlight_by_node() function
Message-Id: <1352469878-4532-1-git-send-email-thierry.reding@avionic-design.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352326119-7301-1-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1352326119-7301-1-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This function finds the struct backlight_device for a given device tree
node. A dummy function is provided so that it safely compiles out if OF
support is disabled.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/video/backlight/backlight.c | 17 +++++++++++++++++
 include/linux/backlight.h           | 10 ++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 297db2f..0d1ed4f 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -370,6 +370,23 @@ void backlight_device_unregister(struct backlight_device *bd)
 }
 EXPORT_SYMBOL(backlight_device_unregister);
 
+#if IS_ENABLED(CONFIG_OF)
+static int of_parent_match(struct device *dev, void *data)
+{
+	return dev->parent && dev->parent->of_node = data;
+}
+
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
index 5ffc6dd..11840e9 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -134,4 +134,14 @@ struct generic_bl_info {
 	void (*kick_battery)(void);
 };
 
+#if IS_ENABLED(CONFIG_OF)
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

