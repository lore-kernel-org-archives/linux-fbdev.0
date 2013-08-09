From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 Aug 2013 08:39:03 +0000
Subject: [RFC 18/22] OMAPDSS: connector-dvi: Add DT support
Message-Id: <1376037547-10859-19-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays-new/connector-dvi.c | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/video/omap2/displays-new/connector-dvi.c b/drivers/video/omap2/displays-new/connector-dvi.c
index bc5f8ce..99ee1b2 100644
--- a/drivers/video/omap2/displays-new/connector-dvi.c
+++ b/drivers/video/omap2/displays-new/connector-dvi.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of_i2c.h>
 
 #include <drm/drm_edid.h>
 
@@ -274,6 +275,42 @@ static int dvic_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int dvic_probe_of(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_dss_device *in;
+	struct device_node *src_node;
+	struct device_node *adapter_node;
+	struct i2c_adapter *adapter;
+
+	src_node = of_parse_phandle(node, "video-source", 0);
+	if (!src_node) {
+		dev_err(&pdev->dev, "failed to parse video source\n");
+		return -ENODEV;
+	}
+
+	in = omap_dss_find_output_by_node(src_node);
+	if (in = NULL) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return -EPROBE_DEFER;
+	}
+	ddata->in = in;
+
+	adapter_node = of_parse_phandle(node, "i2c-bus", 0);
+	if (adapter_node) {
+		adapter = of_find_i2c_adapter_by_node(adapter_node);
+		if (adapter = NULL) {
+			dev_err(&pdev->dev, "failed to parse i2c-bus\n");
+			return -EINVAL;
+		}
+
+		ddata->i2c_adapter = adapter;
+	}
+
+	return 0;
+}
+
 static int dvic_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -290,6 +327,10 @@ static int dvic_probe(struct platform_device *pdev)
 		r = dvic_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r = dvic_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -335,12 +376,20 @@ static int __exit dvic_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id dvic_of_match[] = {
+	{ .compatible = "ti,dvi_connector", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, dvic_of_match);
+
 static struct platform_driver dvi_connector_driver = {
 	.probe	= dvic_probe,
 	.remove	= __exit_p(dvic_remove),
 	.driver	= {
 		.name	= "connector-dvi",
 		.owner	= THIS_MODULE,
+		.of_match_table = dvic_of_match,
 	},
 };
 
-- 
1.8.1.2

