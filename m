From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 16 May 2014 09:55:12 +0000
Subject: [PATCH 3/3] OMAPDSS: panel NEC-NL8048HL11 DT support
Message-Id: <1400234112-29306-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400234112-29306-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1400234112-29306-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Erik Gilling <konkers@android.com>

We don't have any working boards using this panel right now, and the
panel driver looks odd compared to the panel specs. For example, the
panel spec does not mention any QVGA pin.

So, while this patch adds DT support to the driver, it's not really
supported and there are not bindings documentation for the panel until
someone can verify how the panel actually works.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Erik Gilling <konkers@android.com>
---
 .../omap2/displays-new/panel-nec-nl8048hl11.c      | 44 +++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c b/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c
index 996fa004b48c..553e5643e4ba 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c
@@ -16,6 +16,7 @@
 #include <linux/spi/spi.h>
 #include <linux/fb.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -156,7 +157,8 @@ static int nec_8048_enable(struct omap_dss_device *dssdev)
 	if (omapdss_device_is_enabled(dssdev))
 		return 0;
 
-	in->ops.dpi->set_data_lines(in, ddata->data_lines);
+	if (ddata->data_lines)
+		in->ops.dpi->set_data_lines(in, ddata->data_lines);
 	in->ops.dpi->set_timings(in, &ddata->videomode);
 
 	r = in->ops.dpi->enable(in);
@@ -258,6 +260,34 @@ static int nec_8048_probe_pdata(struct spi_device *spi)
 	return 0;
 }
 
+static int nec_8048_probe_of(struct spi_device *spi)
+{
+	struct device_node *node = spi->dev.of_node;
+	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
+	struct omap_dss_device *in;
+	int gpio;
+
+	gpio = of_get_named_gpio(node, "reset-gpios", 0);
+	if (!gpio_is_valid(gpio)) {
+		dev_err(&spi->dev, "failed to parse enable gpio\n");
+		return gpio;
+	}
+	ddata->res_gpio = gpio;
+
+	/* XXX the panel spec doesn't mention any QVGA pin?? */
+	ddata->qvga_gpio = -ENOENT;
+
+	in = omapdss_of_find_source_for_first_ep(node);
+	if (IS_ERR(in)) {
+		dev_err(&spi->dev, "failed to find video source\n");
+		return PTR_ERR(in);
+	}
+
+	ddata->in = in;
+
+	return 0;
+}
+
 static int nec_8048_probe(struct spi_device *spi)
 {
 	struct panel_drv_data *ddata;
@@ -289,6 +319,10 @@ static int nec_8048_probe(struct spi_device *spi)
 		r = nec_8048_probe_pdata(spi);
 		if (r)
 			return r;
+	} else if (spi->dev.of_node) {
+		r = nec_8048_probe_of(spi);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -377,6 +411,13 @@ static SIMPLE_DEV_PM_OPS(nec_8048_pm_ops, nec_8048_suspend,
 #define NEC_8048_PM_OPS NULL
 #endif
 
+static const struct of_device_id lb035q02_of_match[] = {
+	{ .compatible = "omapdss,nec,nl8048hl11", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, lb035q02_of_match);
+
 static struct spi_driver nec_8048_driver = {
 	.driver = {
 		.name	= "panel-nec-nl8048hl11",
@@ -389,6 +430,7 @@ static struct spi_driver nec_8048_driver = {
 
 module_spi_driver(nec_8048_driver);
 
+MODULE_ALIAS("spi:nec,nl8048hl11");
 MODULE_AUTHOR("Erik Gilling <konkers@android.com>");
 MODULE_DESCRIPTION("NEC-NL8048HL11 Driver");
 MODULE_LICENSE("GPL");
-- 
1.9.1

