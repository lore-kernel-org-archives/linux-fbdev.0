From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Dec 2012 14:27:29 +0000
Subject: [RFC 3/6] video: add tfp410
Message-Id: <1355495252-26364-4-git-send-email-tomi.valkeinen@ti.com>
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
 drivers/video/display/chip-tfp410.c |  164 +++++++++++++++++++++++++++++++++++
 include/video/omap-panel-tfp410.h   |    4 +
 2 files changed, 168 insertions(+)
 create mode 100644 drivers/video/display/chip-tfp410.c

diff --git a/drivers/video/display/chip-tfp410.c b/drivers/video/display/chip-tfp410.c
new file mode 100644
index 0000000..2f8bdb6
--- /dev/null
+++ b/drivers/video/display/chip-tfp410.c
@@ -0,0 +1,164 @@
+/*
+ * TFP410 DPI-to-DVI bridge
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
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+
+#include <video/display.h>
+#include <video/omap-panel-tfp410.h>
+
+struct tfp410_data {
+	struct video_source *in;
+
+	struct video_source out;
+
+	int power_down_gpio;
+};
+
+#define to_tfp410(p) container_of(p, struct tfp410_data, out)
+
+static int tfp410_set_stream(struct video_source *src,
+				     enum video_source_stream_state state)
+{
+	struct tfp410_data *data = to_tfp410(src);
+	struct video_source *in = data->in;
+	int r;
+
+	r = in->common_ops->set_stream(in, state);
+	if (r)
+		return r;
+
+	switch (state) {
+	case DISPLAY_ENTITY_STREAM_STOPPED:
+		printk("tfp410 set_stream: STOPPED\n");
+
+		gpio_set_value_cansleep(data->power_down_gpio, 0);
+
+		break;
+
+	case DISPLAY_ENTITY_STREAM_CONTINUOUS:
+		printk("tfp410 set_stream: CONTINUOUS\n");
+
+		gpio_set_value_cansleep(data->power_down_gpio, 1);
+
+		break;
+
+	default:
+		printk("tfp410 set_stream error\n");
+		break;
+	}
+
+	return 0;
+}
+
+static int tfp410_set_vm(struct video_source *src, const struct videomode *vm)
+{
+	struct tfp410_data *data = to_tfp410(src);
+	struct video_source *in = data->in;
+
+	printk("tfp410 set vm\n");
+
+	return in->ops.dpi->set_videomode(in, vm);
+}
+
+static const struct common_video_source_ops tfp410_common_ops = {
+	.set_stream = tfp410_set_stream,
+};
+
+static const struct dvi_video_source_ops tfp410_dvi_ops = {
+	.set_videomode = tfp410_set_vm,
+};
+
+static void tfp410_release(struct video_source *src)
+{
+	printk("tfp410 entity release\n");
+}
+
+static int __devinit tfp410_probe(struct platform_device *pdev)
+{
+	const struct tfp410_platform_data *pdata = pdev->dev.platform_data;
+	struct tfp410_data *data;
+	int r;
+
+	if (pdata = NULL)
+		return -ENODEV;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (data = NULL)
+		return -ENOMEM;
+
+	data->power_down_gpio = pdata->power_down_gpio;
+
+	r = devm_gpio_request_one(&pdev->dev, pdata->power_down_gpio,
+			GPIOF_OUT_INIT_LOW, "tfp410 pd");
+	if (r) {
+		printk("failed to request pd gpio\n");
+		return r;
+	}
+
+	/* setup input */
+
+	data->in = video_source_find(pdata->video_source);
+	if (data->in = NULL) {
+		printk("failed to get video source\n");
+		return -EINVAL;
+	}
+
+	data->in->ops.dpi->set_data_lines(data->in, 24);
+
+	/* setup output */
+
+	data->out.dev = &pdev->dev;
+	data->out.release = tfp410_release;
+	data->out.common_ops = &tfp410_common_ops;
+	data->out.ops.dvi = &tfp410_dvi_ops;
+	data->out.name = pdata->video_output;
+
+	r = video_source_register(&data->out);
+	if (r < 0) {
+		printk("tfp410 entity register failed\n");
+		video_source_put(data->in);
+		return r;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int tfp410_remove(struct platform_device *pdev)
+{
+	struct tfp410_data *data = platform_get_drvdata(pdev);
+
+	video_source_unregister(&data->out);
+
+	video_source_put(data->in);
+
+	return 0;
+}
+
+static struct platform_driver tfp410_driver = {
+	.probe = tfp410_probe,
+	.remove = tfp410_remove,
+	.driver = {
+		.name = "tfp410",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(tfp410_driver);
+
+MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@ti.com>");
+MODULE_DESCRIPTION("TFP410 DPI-to-DVI Bridge");
+MODULE_LICENSE("GPL");
diff --git a/include/video/omap-panel-tfp410.h b/include/video/omap-panel-tfp410.h
index b5b05f4..18f2b46 100644
--- a/include/video/omap-panel-tfp410.h
+++ b/include/video/omap-panel-tfp410.h
@@ -30,6 +30,10 @@ struct omap_dss_device;
  */
 struct tfp410_platform_data {
 	const char *name;
+
+	const char *video_source;
+	const char *video_output;
+
 	u16 i2c_bus_num;
 	int power_down_gpio;
 };
-- 
1.7.10.4

