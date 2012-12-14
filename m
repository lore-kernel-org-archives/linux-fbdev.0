From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Dec 2012 14:27:28 +0000
Subject: [RFC 2/6] video: add generic dpi panel
Message-Id: <1355495252-26364-3-git-send-email-tomi.valkeinen@ti.com>
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
 drivers/video/display/panel-dpi.c |  155 +++++++++++++++++++++++++++++++++++++
 include/video/panel-dpi.h         |   25 ++++++
 2 files changed, 180 insertions(+)
 create mode 100644 drivers/video/display/panel-dpi.c
 create mode 100644 include/video/panel-dpi.h

diff --git a/drivers/video/display/panel-dpi.c b/drivers/video/display/panel-dpi.c
new file mode 100644
index 0000000..824cd88
--- /dev/null
+++ b/drivers/video/display/panel-dpi.c
@@ -0,0 +1,155 @@
+/*
+ * DPI Display Panel
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <video/display.h>
+#include <video/panel-dpi.h>
+
+struct panel_dpi {
+	struct display_entity entity;
+	struct video_source *src;
+	const struct panel_dpi_platform_data *pdata;
+};
+
+#define to_panel_dpi(p)		container_of(p, struct panel_dpi, entity)
+
+static int panel_dpi_set_state(struct display_entity *entity,
+			       enum display_entity_state state)
+{
+	struct panel_dpi *panel = to_panel_dpi(entity);
+	struct video_source *src = panel->src;
+
+	switch (state) {
+	case DISPLAY_ENTITY_STATE_OFF:
+	case DISPLAY_ENTITY_STATE_STANDBY:
+		src->common_ops->set_stream(src,
+				DISPLAY_ENTITY_STREAM_STOPPED);
+		break;
+
+	case DISPLAY_ENTITY_STATE_ON:
+		src->common_ops->set_stream(src,
+				DISPLAY_ENTITY_STREAM_CONTINUOUS);
+		break;
+	}
+
+	return 0;
+}
+
+static int panel_dpi_get_modes(struct display_entity *entity,
+			       const struct videomode **modes)
+{
+	struct panel_dpi *panel = to_panel_dpi(entity);
+
+	*modes = panel->pdata->mode;
+	return 1;
+}
+
+static int panel_dpi_get_size(struct display_entity *entity,
+			      unsigned int *width, unsigned int *height)
+{
+	struct panel_dpi *panel = to_panel_dpi(entity);
+
+	*width = panel->pdata->width;
+	*height = panel->pdata->height;
+	return 0;
+}
+
+static const struct display_entity_control_ops panel_dpi_control_ops = {
+	.set_state = panel_dpi_set_state,
+	.get_modes = panel_dpi_get_modes,
+	.get_size = panel_dpi_get_size,
+};
+
+static void panel_dpi_release(struct display_entity *entity)
+{
+	struct panel_dpi *panel = to_panel_dpi(entity);
+
+	kfree(panel);
+}
+
+static int panel_dpi_remove(struct platform_device *pdev)
+{
+	struct panel_dpi *panel = platform_get_drvdata(pdev);
+
+	display_entity_unregister(&panel->entity);
+
+	if (panel->src) {
+		video_source_put(panel->src);
+		panel->src = NULL;
+	}
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static int __devinit panel_dpi_probe(struct platform_device *pdev)
+{
+	const struct panel_dpi_platform_data *pdata = pdev->dev.platform_data;
+	struct panel_dpi *panel;
+	int ret;
+
+	if (pdata = NULL)
+		return -ENODEV;
+
+	panel = kzalloc(sizeof(*panel), GFP_KERNEL);
+	if (panel = NULL)
+		return -ENOMEM;
+
+	panel->pdata = pdata;
+
+	panel->src = video_source_find(pdata->video_source);
+	if (panel->src = NULL) {
+		printk("failed to get video source\n");
+		return -EINVAL;
+	}
+
+	panel->src->ops.dpi->set_data_lines(panel->src, 24);
+	panel->src->ops.dpi->set_videomode(panel->src, pdata->mode);
+
+	panel->entity.dev = &pdev->dev;
+	panel->entity.release = panel_dpi_release;
+	panel->entity.ops = &panel_dpi_control_ops;
+
+	ret = display_entity_register(&panel->entity);
+	if (ret < 0) {
+		kfree(panel);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, panel);
+
+	return 0;
+}
+
+static const struct dev_pm_ops panel_dpi_dev_pm_ops = {
+};
+
+static struct platform_driver panel_dpi_driver = {
+	.probe = panel_dpi_probe,
+	.remove = panel_dpi_remove,
+	.driver = {
+		.name = "panel_dpi",
+		.owner = THIS_MODULE,
+		.pm = &panel_dpi_dev_pm_ops,
+	},
+};
+
+module_platform_driver(panel_dpi_driver);
+
+MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
+MODULE_DESCRIPTION("DPI Display Panel");
+MODULE_LICENSE("GPL");
diff --git a/include/video/panel-dpi.h b/include/video/panel-dpi.h
new file mode 100644
index 0000000..0c5856e
--- /dev/null
+++ b/include/video/panel-dpi.h
@@ -0,0 +1,25 @@
+/*
+ * DPI Display Panel
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
+#ifndef __PANEL_DPI_H__
+#define __PANEL_DPI_H__
+
+#include <linux/videomode.h>
+
+struct panel_dpi_platform_data {
+	const char *video_source;
+	unsigned long width;		/* Panel width in mm */
+	unsigned long height;		/* Panel height in mm */
+	const struct videomode *mode;
+};
+
+#endif /* __PANEL_DPI_H__ */
-- 
1.7.10.4

