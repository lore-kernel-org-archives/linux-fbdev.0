From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 Aug 2013 08:39:05 +0000
Subject: [RFC 20/22] OMAPDSS: hdmi-connector: Add DT support
Message-Id: <1376037547-10859-21-git-send-email-tomi.valkeinen@ti.com>
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
 drivers/video/omap2/displays-new/connector-hdmi.c | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/video/omap2/displays-new/connector-hdmi.c b/drivers/video/omap2/displays-new/connector-hdmi.c
index c582671..13f7a5e 100644
--- a/drivers/video/omap2/displays-new/connector-hdmi.c
+++ b/drivers/video/omap2/displays-new/connector-hdmi.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <drm/drm_edid.h>
 
@@ -301,6 +302,29 @@ static int hdmic_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int hdmic_probe_of(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_dss_device *in;
+	struct device_node *src_node;
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
+	return 0;
+}
+
 static int hdmic_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -318,6 +342,10 @@ static int hdmic_probe(struct platform_device *pdev)
 		r = hdmic_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r = hdmic_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -359,12 +387,20 @@ static int __exit hdmic_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id hdmic_of_match[] = {
+	{ .compatible = "ti,hdmi_connector", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, hdmic_of_match);
+
 static struct platform_driver hdmi_connector_driver = {
 	.probe	= hdmic_probe,
 	.remove	= __exit_p(hdmic_remove),
 	.driver	= {
 		.name	= "connector-hdmi",
 		.owner	= THIS_MODULE,
+		.of_match_table = hdmic_of_match,
 	},
 };
 
-- 
1.8.1.2

