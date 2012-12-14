From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Dec 2012 14:27:30 +0000
Subject: [RFC 4/6] video: add generic dvi monitor
Message-Id: <1355495252-26364-5-git-send-email-tomi.valkeinen@ti.com>
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
 drivers/video/display/panel-dvi.c |  164 +++++++++++++++++++++++++++++++++++++
 include/video/panel-dvi.h         |   18 ++++
 2 files changed, 182 insertions(+)
 create mode 100644 drivers/video/display/panel-dvi.c
 create mode 100644 include/video/panel-dvi.h

diff --git a/drivers/video/display/panel-dvi.c b/drivers/video/display/panel-dvi.c
new file mode 100644
index 0000000..01cea09
--- /dev/null
+++ b/drivers/video/display/panel-dvi.c
@@ -0,0 +1,164 @@
+/*
+ * Generic DVI monitor
+ *
+ * Copyright (C) 2012 Texas Instruments
+ *
+ * Contacts: Tomi Valkeinen <tomi.valkeinen@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <video/display.h>
+#include <video/panel-dvi.h>
+
+struct panel_data {
+	struct display_entity entity;
+	struct video_source *in;
+};
+
+#define to_panel(p) container_of(p, struct panel_data, entity)
+
+static int panel_dvi_set_state(struct display_entity *entity,
+			       enum display_entity_state state)
+{
+	struct panel_data *data = to_panel(entity);
+	struct video_source *in = data->in;
+
+	switch (state) {
+	case DISPLAY_ENTITY_STATE_OFF:
+	case DISPLAY_ENTITY_STATE_STANDBY:
+		in->common_ops->set_stream(in, DISPLAY_ENTITY_STREAM_STOPPED);
+		break;
+
+	case DISPLAY_ENTITY_STATE_ON:
+		in->common_ops->set_stream(in, DISPLAY_ENTITY_STREAM_CONTINUOUS);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct videomode vga_mode = {
+	.pixelclock = 23500,
+
+	.hactive = 640,
+	.hfront_porch = 48,
+	.hback_porch = 80,
+	.hsync_len = 32,
+
+	.vactive = 480,
+	.vfront_porch = 3,
+	.vback_porch = 7,
+	.vsync_len = 4,
+
+	.hah = true,
+	.vah = true,
+	.de = true,
+};
+
+static int panel_dvi_get_modes(struct display_entity *entity,
+			       const struct videomode **modes)
+{
+	//struct panel_data *data = to_panel(entity);
+
+	*modes = &vga_mode;
+	return 1;
+}
+
+static int panel_dvi_get_size(struct display_entity *entity,
+			      unsigned int *width, unsigned int *height)
+{
+	//struct panel_data *data = to_panel(entity);
+
+	*width = 10;
+	*height = 10;
+	return 0;
+}
+
+static const struct display_entity_control_ops panel_dvi_control_ops = {
+	.set_state = panel_dvi_set_state,
+	.get_modes = panel_dvi_get_modes,
+	.get_size = panel_dvi_get_size,
+};
+
+static void panel_dvi_release(struct display_entity *entity)
+{
+	printk("panel dvi release\n");
+}
+
+static int __devinit panel_dvi_probe(struct platform_device *pdev)
+{
+	const struct panel_dvi_platform_data *pdata = pdev->dev.platform_data;
+	struct panel_data *data;
+	int ret;
+
+	if (pdata = NULL)
+		return -ENODEV;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (data = NULL)
+		return -ENOMEM;
+
+	/* setup input */
+	data->in = video_source_find(pdata->video_source);
+	if (data->in = NULL) {
+		printk("failed to get video source\n");
+		return -EINVAL;
+	}
+
+	/* setup default mode */
+	data->in->ops.dvi->set_videomode(data->in, &vga_mode);
+
+	/* setup panel entity */
+
+	data->entity.dev = &pdev->dev;
+	data->entity.release = panel_dvi_release;
+	data->entity.ops = &panel_dvi_control_ops;
+
+	ret = display_entity_register(&data->entity);
+	if (ret < 0) {
+		video_source_put(data->in);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int panel_dvi_remove(struct platform_device *pdev)
+{
+	struct panel_data *data = platform_get_drvdata(pdev);
+
+	display_entity_unregister(&data->entity);
+
+	video_source_put(data->in);
+
+	return 0;
+}
+
+
+static const struct dev_pm_ops panel_dvi_dev_pm_ops = {
+};
+
+static struct platform_driver panel_dvi_driver = {
+	.probe = panel_dvi_probe,
+	.remove = panel_dvi_remove,
+	.driver = {
+		.name = "panel_dvi",
+		.owner = THIS_MODULE,
+		.pm = &panel_dvi_dev_pm_ops,
+	},
+};
+
+module_platform_driver(panel_dvi_driver);
+
+MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@ti.com>");
+MODULE_DESCRIPTION("DVI Monitor");
+MODULE_LICENSE("GPL");
diff --git a/include/video/panel-dvi.h b/include/video/panel-dvi.h
new file mode 100644
index 0000000..ab88380
--- /dev/null
+++ b/include/video/panel-dvi.h
@@ -0,0 +1,18 @@
+/*
+ * DVI Display Panel
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __PANEL_DVI_H__
+#define __PANEL_DVI_H__
+
+#include <linux/videomode.h>
+
+struct panel_dvi_platform_data {
+	const char *video_source;
+};
+
+#endif /* __PANEL_DVI_H__ */
-- 
1.7.10.4

