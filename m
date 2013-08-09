From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 Aug 2013 08:38:53 +0000
Subject: [RFC 08/22] OMAPDSS: Add DT support to DSS, DISPC, DPI, HDMI, VENC
Message-Id: <1376037547-10859-9-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add the code to make DSS, DISPC, DPI, HDMI and VENC drivers work with
device tree on OMAP3 and OMAP4. The only change is adding the
of_match_tables.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  7 +++++++
 drivers/video/omap2/dss/dpi.c   |  8 ++++++++
 drivers/video/omap2/dss/dss.c   | 10 ++++++++++
 drivers/video/omap2/dss/hdmi.c  |  6 ++++++
 drivers/video/omap2/dss/venc.c  |  7 +++++++
 5 files changed, 38 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 02a7340..b4dccb8 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3743,12 +3743,19 @@ static const struct dev_pm_ops dispc_pm_ops = {
 	.runtime_resume = dispc_runtime_resume,
 };
 
+static const struct of_device_id dispc_of_match[] = {
+	{ .compatible = "ti,omap3-dispc", },
+	{ .compatible = "ti,omap4-dispc", },
+	{},
+};
+
 static struct platform_driver omap_dispchw_driver = {
 	.remove         = __exit_p(omap_dispchw_remove),
 	.driver         = {
 		.name   = "omapdss_dispc",
 		.owner  = THIS_MODULE,
 		.pm	= &dispc_pm_ops,
+		.of_match_table = dispc_of_match,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index a6b331e..6b832c8 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/string.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 
@@ -801,12 +802,19 @@ static int __exit omap_dpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id dpi_of_match[] = {
+	{ .compatible = "ti,omap3-dpi", },
+	{ .compatible = "ti,omap4-dpi", },
+	{},
+};
+
 static struct platform_driver omap_dpi_driver = {
 	.probe		= omap_dpi_probe,
 	.remove         = __exit_p(omap_dpi_remove),
 	.driver         = {
 		.name   = "omapdss_dpi",
 		.owner  = THIS_MODULE,
+		.of_match_table = dpi_of_match,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index bd01608..d0d61b1 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -23,6 +23,7 @@
 #define DSS_SUBSYS_NAME "DSS"
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/io.h>
 #include <linux/export.h>
 #include <linux/err.h>
@@ -955,12 +956,21 @@ static const struct dev_pm_ops dss_pm_ops = {
 	.runtime_resume = dss_runtime_resume,
 };
 
+static const struct of_device_id dss_of_match[] = {
+	{ .compatible = "ti,omap3-dss", },
+	{ .compatible = "ti,omap4-dss", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, dss_of_match);
+
 static struct platform_driver omap_dsshw_driver = {
 	.remove         = __exit_p(omap_dsshw_remove),
 	.driver         = {
 		.name   = "omapdss_dss",
 		.owner  = THIS_MODULE,
 		.pm	= &dss_pm_ops,
+		.of_match_table = dss_of_match,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 1b38f1f..1cea0ab 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1374,6 +1374,11 @@ static const struct dev_pm_ops hdmi_pm_ops = {
 	.runtime_resume = hdmi_runtime_resume,
 };
 
+static const struct of_device_id hdmi_of_match[] = {
+	{ .compatible = "ti,omap4-hdmi", },
+	{},
+};
+
 static struct platform_driver omapdss_hdmihw_driver = {
 	.probe		= omapdss_hdmihw_probe,
 	.remove         = __exit_p(omapdss_hdmihw_remove),
@@ -1381,6 +1386,7 @@ static struct platform_driver omapdss_hdmihw_driver = {
 		.name   = "omapdss_hdmi",
 		.owner  = THIS_MODULE,
 		.pm	= &hdmi_pm_ops,
+		.of_match_table = hdmi_of_match,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 496a106..93e13dd 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -980,6 +980,12 @@ static const struct dev_pm_ops venc_pm_ops = {
 	.runtime_resume = venc_runtime_resume,
 };
 
+
+static const struct of_device_id venc_of_match[] = {
+	{ .compatible = "ti,omap3-venc", },
+	{},
+};
+
 static struct platform_driver omap_venchw_driver = {
 	.probe		= omap_venchw_probe,
 	.remove         = __exit_p(omap_venchw_remove),
@@ -987,6 +993,7 @@ static struct platform_driver omap_venchw_driver = {
 		.name   = "omapdss_venc",
 		.owner  = THIS_MODULE,
 		.pm	= &venc_pm_ops,
+		.of_match_table = venc_of_match,
 	},
 };
 
-- 
1.8.1.2

