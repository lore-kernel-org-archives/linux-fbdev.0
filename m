From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 Mar 2012 12:44:47 +0000
Subject: [PATCH 18/21] OMAPDSS: use platform_driver_probe for dsi/hdmi/rfbi/venc/dpi/sdi
Message-Id: <1331124290-6285-19-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that the core.c doesn't fail if output driver's init fails, we can
change the uses of platform_driver_register to platform_driver_probe.
This will allow us to use __init in the following patches.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |    3 +--
 drivers/video/omap2/dss/dsi.c  |    3 +--
 drivers/video/omap2/dss/hdmi.c |    3 +--
 drivers/video/omap2/dss/rfbi.c |    3 +--
 drivers/video/omap2/dss/sdi.c  |    3 +--
 drivers/video/omap2/dss/venc.c |    3 +--
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 511df3c..5ca216b 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -375,7 +375,6 @@ static int omap_dpi_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_dpi_driver = {
-	.probe		= omap_dpi_probe,
 	.remove         = omap_dpi_remove,
 	.driver         = {
 		.name   = "omapdss_dpi",
@@ -385,7 +384,7 @@ static struct platform_driver omap_dpi_driver = {
 
 int dpi_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dpi_driver);
+	return platform_driver_probe(&omap_dpi_driver, omap_dpi_probe);
 }
 
 void dpi_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 0a1c5e3..9402d00 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4803,7 +4803,6 @@ static const struct dev_pm_ops dsi_pm_ops = {
 };
 
 static struct platform_driver omap_dsihw_driver = {
-	.probe          = omap_dsihw_probe,
 	.remove         = omap_dsihw_remove,
 	.driver         = {
 		.name   = "omapdss_dsi",
@@ -4814,7 +4813,7 @@ static struct platform_driver omap_dsihw_driver = {
 
 int dsi_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dsihw_driver);
+	return platform_driver_probe(&omap_dsihw_driver, omap_dsihw_probe);
 }
 
 void dsi_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 10295fc..2f369ed 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -871,7 +871,6 @@ static const struct dev_pm_ops hdmi_pm_ops = {
 };
 
 static struct platform_driver omapdss_hdmihw_driver = {
-	.probe          = omapdss_hdmihw_probe,
 	.remove         = omapdss_hdmihw_remove,
 	.driver         = {
 		.name   = "omapdss_hdmi",
@@ -882,7 +881,7 @@ static struct platform_driver omapdss_hdmihw_driver = {
 
 int hdmi_init_platform_driver(void)
 {
-	return platform_driver_register(&omapdss_hdmihw_driver);
+	return platform_driver_probe(&omapdss_hdmihw_driver, omapdss_hdmihw_probe);
 }
 
 void hdmi_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index b07010b..b2b0d5e 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -995,7 +995,6 @@ static const struct dev_pm_ops rfbi_pm_ops = {
 };
 
 static struct platform_driver omap_rfbihw_driver = {
-	.probe          = omap_rfbihw_probe,
 	.remove         = omap_rfbihw_remove,
 	.driver         = {
 		.name   = "omapdss_rfbi",
@@ -1006,7 +1005,7 @@ static struct platform_driver omap_rfbihw_driver = {
 
 int rfbi_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_rfbihw_driver);
+	return platform_driver_probe(&omap_rfbihw_driver, omap_rfbihw_probe);
 }
 
 void rfbi_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 684a4de..2cbcc00 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -187,7 +187,6 @@ static int omap_sdi_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_sdi_driver = {
-	.probe		= omap_sdi_probe,
 	.remove         = omap_sdi_remove,
 	.driver         = {
 		.name   = "omapdss_sdi",
@@ -197,7 +196,7 @@ static struct platform_driver omap_sdi_driver = {
 
 int sdi_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_sdi_driver);
+	return platform_driver_probe(&omap_sdi_driver, omap_sdi_probe);
 }
 
 void sdi_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index a9c7c7c..ca0bcdd 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -879,7 +879,6 @@ static const struct dev_pm_ops venc_pm_ops = {
 };
 
 static struct platform_driver omap_venchw_driver = {
-	.probe          = omap_venchw_probe,
 	.remove         = omap_venchw_remove,
 	.driver         = {
 		.name   = "omapdss_venc",
@@ -893,7 +892,7 @@ int venc_init_platform_driver(void)
 	if (cpu_is_omap44xx())
 		return 0;
 
-	return platform_driver_register(&omap_venchw_driver);
+	return platform_driver_probe(&omap_venchw_driver, omap_venchw_probe);
 }
 
 void venc_uninit_platform_driver(void)
-- 
1.7.4.1

