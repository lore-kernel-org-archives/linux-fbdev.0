From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:36:13 +0000
Subject: [PATCH 20/27] OMAPDSS: Add new Analog TV Connector driver
Message-Id: <1369906580-27585-21-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add Analog TV Connector driver which uses the new DSS device model and
DSS ops.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays-new/Kconfig           |   5 +
 drivers/video/omap2/displays-new/Makefile          |   1 +
 .../video/omap2/displays-new/connector-analog-tv.c | 265 +++++++++++++++++++++
 3 files changed, 271 insertions(+)
 create mode 100644 drivers/video/omap2/displays-new/connector-analog-tv.c

diff --git a/drivers/video/omap2/displays-new/Kconfig b/drivers/video/omap2/displays-new/Kconfig
index 9a66413..5326638 100644
--- a/drivers/video/omap2/displays-new/Kconfig
+++ b/drivers/video/omap2/displays-new/Kconfig
@@ -23,4 +23,9 @@ config DISPLAY_CONNECTOR_HDMI
 	help
 	  Driver for a generic HDMI connector.
 
+config DISPLAY_CONNECTOR_ANALOG_TV
+        tristate "Analog TV Connector"
+	help
+	  Driver for a generic analog TV connector.
+
 endmenu
diff --git a/drivers/video/omap2/displays-new/Makefile b/drivers/video/omap2/displays-new/Makefile
index 1007b5f..083bf08 100644
--- a/drivers/video/omap2/displays-new/Makefile
+++ b/drivers/video/omap2/displays-new/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_DISPLAY_ENCODER_TFP410) += encoder-tfp410.o
 obj-$(CONFIG_DISPLAY_ENCODER_TPD12S015) += encoder-tpd12s015.o
 obj-$(CONFIG_DISPLAY_CONNECTOR_DVI) += connector-dvi.o
 obj-$(CONFIG_DISPLAY_CONNECTOR_HDMI) += connector-hdmi.o
+obj-$(CONFIG_DISPLAY_CONNECTOR_ANALOG_TV) += connector-analog-tv.o
diff --git a/drivers/video/omap2/displays-new/connector-analog-tv.c b/drivers/video/omap2/displays-new/connector-analog-tv.c
new file mode 100644
index 0000000..5338f36
--- /dev/null
+++ b/drivers/video/omap2/displays-new/connector-analog-tv.c
@@ -0,0 +1,265 @@
+/*
+ * Analog TV Connector driver
+ *
+ * Copyright (C) 2013 Texas Instruments
+ * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <video/omapdss.h>
+#include <video/omap-panel-data.h>
+
+struct panel_drv_data {
+	struct omap_dss_device dssdev;
+	struct omap_dss_device *in;
+
+	struct device *dev;
+
+	struct omap_video_timings timings;
+
+	enum omap_dss_venc_type connector_type;
+	bool invert_polarity;
+};
+
+#define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
+
+static int tvc_connect(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+	int r;
+
+	dev_dbg(ddata->dev, "connect\n");
+
+	if (omapdss_device_is_connected(dssdev))
+		return 0;
+
+	r = in->ops.atv->connect(in, dssdev);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static void tvc_disconnect(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	dev_dbg(ddata->dev, "disconnect\n");
+
+	if (!omapdss_device_is_connected(dssdev))
+		return;
+
+	in->ops.atv->disconnect(in, dssdev);
+}
+
+static int tvc_enable(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+	int r;
+
+	dev_dbg(ddata->dev, "enable\n");
+
+	if (!omapdss_device_is_connected(dssdev))
+		return -ENODEV;
+
+	if (omapdss_device_is_enabled(dssdev))
+		return 0;
+
+	in->ops.atv->set_timings(in, &ddata->timings);
+
+	in->ops.atv->set_type(in, ddata->connector_type);
+	in->ops.atv->invert_vid_out_polarity(in, ddata->invert_polarity);
+
+	r = in->ops.atv->enable(in);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return r;
+}
+
+static void tvc_disable(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	dev_dbg(ddata->dev, "disable\n");
+
+	if (!omapdss_device_is_enabled(dssdev))
+		return;
+
+	in->ops.atv->disable(in);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+}
+
+static void tvc_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	ddata->timings = *timings;
+	dssdev->panel.timings = *timings;
+
+	in->ops.atv->set_timings(in, timings);
+}
+
+static void tvc_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+
+	*timings = ddata->timings;
+}
+
+static int tvc_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	return in->ops.atv->check_timings(in, timings);
+}
+
+static u32 tvc_get_wss(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	return in->ops.atv->get_wss(in);
+}
+
+static int tvc_set_wss(struct omap_dss_device *dssdev, u32 wss)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	return in->ops.atv->set_wss(in, wss);
+}
+
+static struct omap_dss_driver tvc_driver = {
+	.connect		= tvc_connect,
+	.disconnect		= tvc_disconnect,
+
+	.enable			= tvc_enable,
+	.disable		= tvc_disable,
+
+	.set_timings		= tvc_set_timings,
+	.get_timings		= tvc_get_timings,
+	.check_timings		= tvc_check_timings,
+
+	.get_resolution		= omapdss_default_get_resolution,
+
+	.get_wss		= tvc_get_wss,
+	.set_wss		= tvc_set_wss,
+};
+
+static int tvc_probe_pdata(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct connector_atv_platform_data *pdata;
+	struct omap_dss_device *in, *dssdev;
+
+	pdata = dev_get_platdata(&pdev->dev);
+
+	in = omap_dss_find_output(pdata->source);
+	if (in = NULL) {
+		dev_err(&pdev->dev, "Failed to find video source\n");
+		return -ENODEV;
+	}
+
+	ddata->in = in;
+
+	ddata->connector_type = pdata->connector_type;
+	ddata->invert_polarity = ddata->invert_polarity;
+
+	dssdev = &ddata->dssdev;
+	dssdev->name = pdata->name;
+
+	return 0;
+}
+
+static int tvc_probe(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata;
+	struct omap_dss_device *dssdev;
+	int r;
+
+	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ddata);
+	ddata->dev = &pdev->dev;
+
+	if (dev_get_platdata(&pdev->dev)) {
+		r = tvc_probe_pdata(pdev);
+		if (r)
+			return r;
+	} else {
+		return -ENODEV;
+	}
+
+	ddata->timings = omap_dss_pal_timings;
+
+	dssdev = &ddata->dssdev;
+	dssdev->driver = &tvc_driver;
+	dssdev->dev = &pdev->dev;
+	dssdev->type = OMAP_DISPLAY_TYPE_VENC;
+	dssdev->owner = THIS_MODULE;
+	dssdev->panel.timings = omap_dss_pal_timings;
+
+	r = omapdss_register_display(dssdev);
+	if (r) {
+		dev_err(&pdev->dev, "Failed to register panel\n");
+		goto err_reg;
+	}
+
+	return 0;
+err_reg:
+	omap_dss_put_device(ddata->in);
+	return r;
+}
+
+static int __exit tvc_remove(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct omap_dss_device *dssdev = &ddata->dssdev;
+	struct omap_dss_device *in = ddata->in;
+
+	omapdss_unregister_display(&ddata->dssdev);
+
+	tvc_disable(dssdev);
+	tvc_disconnect(dssdev);
+
+	omap_dss_put_device(in);
+
+	return 0;
+}
+
+static struct platform_driver tvc_connector_driver = {
+	.probe	= tvc_probe,
+	.remove	= __exit_p(tvc_remove),
+	.driver	= {
+		.name	= "connector-analog-tv",
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(tvc_connector_driver);
+
+MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@ti.com>");
+MODULE_DESCRIPTION("Analog TV Connector driver");
+MODULE_LICENSE("GPL");
-- 
1.8.1.2

