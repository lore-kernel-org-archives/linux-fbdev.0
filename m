From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 27 Mar 2013 08:45:11 +0000
Subject: [RFC 04/14] OMAPDSS: Add DT support to DSI
Message-Id: <1364373921-7599-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Archit Taneja <archit@ti.com>, Andy Gross <andy.gross@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add the code to make the DSI driver work with device tree on OMAP3 and
OMAP4. The of_match_table is added, and also a bit hacky
"ti,dsi-module-id" DT property, which tells the DSI ID number.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index fb77aa8..1058cab 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/debugfs.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 #include <video/mipi_display.h>
@@ -5541,7 +5542,20 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 	if (!dsi)
 		return -ENOMEM;
 
-	dsi->module_id = dsidev->id;
+	if (dsidev->dev.of_node) {
+		u32 id;
+		r = of_property_read_u32(dsidev->dev.of_node,
+				"ti,dsi-module-id", &id);
+		if (r) {
+			DSSERR("failed to read DSI module ID\n");
+			return r;
+		}
+
+		dsi->module_id = id;
+	} else {
+		dsi->module_id = dsidev->id;
+	}
+
 	dsi->pdev = dsidev;
 	dev_set_drvdata(&dsidev->dev, dsi);
 
@@ -5642,6 +5656,7 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 	else if (dsi->module_id = 1)
 		dss_debugfs_create_file("dsi2_irqs", dsi2_dump_irqs);
 #endif
+
 	return 0;
 
 err_runtime_get:
@@ -5700,12 +5715,19 @@ static const struct dev_pm_ops dsi_pm_ops = {
 	.runtime_resume = dsi_runtime_resume,
 };
 
+static const struct of_device_id dsi_of_match[] = {
+	{ .compatible = "ti,omap3-dsi", },
+	{ .compatible = "ti,omap4-dsi", },
+	{},
+};
+
 static struct platform_driver omap_dsihw_driver = {
 	.remove         = __exit_p(omap_dsihw_remove),
 	.driver         = {
 		.name   = "omapdss_dsi",
 		.owner  = THIS_MODULE,
 		.pm	= &dsi_pm_ops,
+		.of_match_table = dsi_of_match,
 	},
 };
 
-- 
1.7.10.4

