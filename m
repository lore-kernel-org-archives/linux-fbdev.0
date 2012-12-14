From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Dec 2012 14:27:27 +0000
Subject: [RFC 1/6] video: add display-core
Message-Id: <1355495252-26364-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355495252-26364-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1355495252-26364-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/display/display-core.c |  207 ++++++++++++++++++++++++++++++++++
 include/video/display.h              |  166 +++++++++++++++++++++++++++
 2 files changed, 373 insertions(+)
 create mode 100644 drivers/video/display/display-core.c
 create mode 100644 include/video/display.h

diff --git a/drivers/video/display/display-core.c b/drivers/video/display/display-core.c
new file mode 100644
index 0000000..5f8be30
--- /dev/null
+++ b/drivers/video/display/display-core.c
@@ -0,0 +1,207 @@
+/*
+ * Display Core
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * Contacts: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/videomode.h>
+
+#include <video/display.h>
+
+/* -----------------------------------------------------------------------------
+ * Display Entity
+ */
+
+static LIST_HEAD(display_entity_list);
+static DEFINE_MUTEX(display_entity_mutex);
+
+struct display_entity *display_entity_get_first(void)
+{
+	if (list_empty(&display_entity_list))
+		return NULL;
+
+	return list_first_entry(&display_entity_list, struct display_entity,
+			list);
+}
+EXPORT_SYMBOL(display_entity_get_first);
+
+int display_entity_set_state(struct display_entity *entity,
+			     enum display_entity_state state)
+{
+	int ret;
+
+	if (entity->state = state)
+		return 0;
+
+	if (!entity->ops || !entity->ops->set_state)
+		return 0;
+
+	ret = entity->ops->set_state(entity, state);
+	if (ret < 0)
+		return ret;
+
+	entity->state = state;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(display_entity_set_state);
+
+int display_entity_get_modes(struct display_entity *entity,
+			     const struct videomode **modes)
+{
+	if (!entity->ops || !entity->ops->get_modes)
+		return 0;
+
+	return entity->ops->get_modes(entity, modes);
+}
+EXPORT_SYMBOL_GPL(display_entity_get_modes);
+
+int display_entity_get_size(struct display_entity *entity,
+			    unsigned int *width, unsigned int *height)
+{
+	if (!entity->ops || !entity->ops->get_size)
+		return -EOPNOTSUPP;
+
+	return entity->ops->get_size(entity, width, height);
+}
+EXPORT_SYMBOL_GPL(display_entity_get_size);
+
+static void display_entity_release(struct kref *ref)
+{
+	struct display_entity *entity +		container_of(ref, struct display_entity, ref);
+
+	if (entity->release)
+		entity->release(entity);
+}
+
+struct display_entity *display_entity_get(struct display_entity *entity)
+{
+	if (entity = NULL)
+		return NULL;
+
+	kref_get(&entity->ref);
+	return entity;
+}
+EXPORT_SYMBOL_GPL(display_entity_get);
+
+void display_entity_put(struct display_entity *entity)
+{
+	kref_put(&entity->ref, display_entity_release);
+}
+EXPORT_SYMBOL_GPL(display_entity_put);
+
+int __must_check __display_entity_register(struct display_entity *entity,
+					   struct module *owner)
+{
+	kref_init(&entity->ref);
+	entity->owner = owner;
+	entity->state = DISPLAY_ENTITY_STATE_OFF;
+
+	mutex_lock(&display_entity_mutex);
+	list_add(&entity->list, &display_entity_list);
+
+	mutex_unlock(&display_entity_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__display_entity_register);
+
+void display_entity_unregister(struct display_entity *entity)
+{
+	mutex_lock(&display_entity_mutex);
+
+	list_del(&entity->list);
+	mutex_unlock(&display_entity_mutex);
+
+	display_entity_put(entity);
+}
+EXPORT_SYMBOL_GPL(display_entity_unregister);
+
+/* -----------------------------------------------------------------------------
+ * Video Source
+ */
+
+static LIST_HEAD(video_source_list);
+static DEFINE_MUTEX(video_source_mutex);
+
+int __must_check __video_source_register(struct video_source *src,
+					   struct module *owner)
+{
+	kref_init(&src->ref);
+	src->owner = owner;
+
+	mutex_lock(&video_source_mutex);
+	list_add(&src->list, &video_source_list);
+
+	mutex_unlock(&video_source_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__video_source_register);
+
+void video_source_unregister(struct video_source *src)
+{
+	mutex_lock(&video_source_mutex);
+
+	list_del(&src->list);
+	mutex_unlock(&video_source_mutex);
+
+	video_source_put(src);
+}
+EXPORT_SYMBOL_GPL(video_source_unregister);
+
+
+static void video_source_release(struct kref *ref)
+{
+	struct video_source *src +		container_of(ref, struct video_source, ref);
+
+	if (src->release)
+		src->release(src);
+}
+
+struct video_source *video_source_get(struct video_source *src)
+{
+	if (src = NULL)
+		return NULL;
+
+	kref_get(&src->ref);
+	return src;
+}
+EXPORT_SYMBOL_GPL(video_source_get);
+
+void video_source_put(struct video_source *src)
+{
+	kref_put(&src->ref, video_source_release);
+}
+EXPORT_SYMBOL_GPL(video_source_put);
+
+struct video_source *video_source_find(const char *name)
+{
+	struct video_source *src;
+
+	list_for_each_entry(src, &video_source_list, list) {
+		if (strcmp(src->name, name) = 0) {
+			kref_get(&src->ref);
+			return src;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(video_source_find);
+
+MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
+MODULE_DESCRIPTION("Display Core");
+MODULE_LICENSE("GPL");
diff --git a/include/video/display.h b/include/video/display.h
new file mode 100644
index 0000000..b639fd0
--- /dev/null
+++ b/include/video/display.h
@@ -0,0 +1,166 @@
+/*
+ * Display Core
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * Contacts: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __DISPLAY_H__
+#define __DISPLAY_H__
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <video/omapdss.h>
+
+struct display_entity;
+struct video_source;
+struct videomode;
+
+/* -----------------------------------------------------------------------------
+ * Display Entity
+ */
+
+/* Hack to get the first registered display entity */
+struct display_entity *display_entity_get_first(void);
+
+enum display_entity_state {
+	DISPLAY_ENTITY_STATE_OFF,
+	DISPLAY_ENTITY_STATE_STANDBY,
+	DISPLAY_ENTITY_STATE_ON,
+};
+
+struct display_entity_control_ops {
+	int (*set_state)(struct display_entity *ent,
+			 enum display_entity_state state);
+	int (*update)(struct display_entity *ent,
+			void (*callback)(int, void *), void *data);
+	int (*get_modes)(struct display_entity *ent,
+			 const struct videomode **modes);
+	int (*get_size)(struct display_entity *ent,
+			unsigned int *width, unsigned int *height);
+};
+
+struct display_entity {
+	struct list_head list;
+	struct device *dev;
+	struct module *owner;
+	struct kref ref;
+
+	const struct display_entity_control_ops *ops;
+
+	void(*release)(struct display_entity *ent);
+
+	enum display_entity_state state;
+};
+
+int display_entity_set_state(struct display_entity *entity,
+			     enum display_entity_state state);
+int display_entity_get_modes(struct display_entity *entity,
+			     const struct videomode **modes);
+int display_entity_get_size(struct display_entity *entity,
+			    unsigned int *width, unsigned int *height);
+
+struct display_entity *display_entity_get(struct display_entity *entity);
+void display_entity_put(struct display_entity *entity);
+
+int __must_check __display_entity_register(struct display_entity *entity,
+					   struct module *owner);
+void display_entity_unregister(struct display_entity *entity);
+
+#define display_entity_register(display_entity) \
+	__display_entity_register(display_entity, THIS_MODULE)
+
+
+/* -----------------------------------------------------------------------------
+ * Video Source
+ */
+
+enum video_source_stream_state {
+	DISPLAY_ENTITY_STREAM_STOPPED,
+	DISPLAY_ENTITY_STREAM_CONTINUOUS,
+};
+
+struct common_video_source_ops {
+	int (*set_stream)(struct video_source *src,
+			 enum video_source_stream_state state);
+};
+
+struct dpi_video_source_ops {
+	int (*set_videomode)(struct video_source *src,
+			const struct videomode *vm);
+	int (*set_data_lines)(struct video_source *src, int lines);
+};
+
+struct dsi_video_source_ops {
+	/* enable/disable dsi bus */
+	int (*enable)(struct video_source *src);
+	void (*disable)(struct video_source *src);
+
+	/* bus configuration */
+	int (*configure_pins)(struct video_source *src,
+			const struct omap_dsi_pin_config *pins);
+	int (*set_clocks)(struct video_source *src,
+			unsigned long ddr_clk,
+			unsigned long lp_clk);
+
+	void (*set_operation_mode)(struct video_source *src,
+			enum omap_dss_dsi_mode mode);
+	void (*set_pixel_format)(struct video_source *src,
+			enum omap_dss_dsi_pixel_format fmt);
+	void (*set_size)(struct video_source *src, u16 w, u16 h);
+
+	void (*enable_hs)(struct video_source *src, bool enable);
+
+	/* data transfer */
+	int (*dcs_write)(struct video_source *src, int channel,
+			u8 *data, size_t len);
+	int (*dcs_read)(struct video_source *src, int channel, u8 dcs_cmd,
+			u8 *data, size_t len);
+	int (*update)(struct video_source *src, int channel,
+			void (*callback)(int, void *), void *data);
+};
+
+struct dvi_video_source_ops {
+	int (*set_videomode)(struct video_source *src,
+			const struct videomode *vm);
+};
+
+struct video_source {
+	struct list_head list;
+	struct device *dev;
+	struct module *owner;
+	struct kref ref;
+
+	const char *name;
+
+	const struct common_video_source_ops *common_ops;
+
+	union {
+		const struct dpi_video_source_ops *dpi;
+		const struct dsi_video_source_ops *dsi;
+		const struct dvi_video_source_ops *dvi;
+	} ops;
+
+	void(*release)(struct video_source *src);
+};
+
+
+#define video_source_register(video_source) \
+	__video_source_register(video_source, THIS_MODULE)
+
+int __must_check __video_source_register(struct video_source *entity,
+					   struct module *owner);
+void video_source_unregister(struct video_source *entity);
+
+struct video_source *video_source_get(struct video_source *src);
+void video_source_put(struct video_source *src);
+
+struct video_source *video_source_find(const char *name);
+
+#endif /* __DISPLAY_H__ */
-- 
1.7.10.4

