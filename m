From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 03 May 2012 13:57:53 +0000
Subject: [PATCH 17/25] OMAPDSS: use platform_driver_probe for dsi/hdmi/rfbi/venc/dpi/sdi
Message-Id: <1336053481-25433-18-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
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
index d7a433b..5481f7c 100644
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
index b380231..eedec80 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4770,7 +4770,6 @@ static const struct dev_pm_ops dsi_pm_ops = {
 };
 
 static struct platform_driver omap_dsihw_driver = {
-	.probe          = omap_dsihw_probe,
 	.remove         = omap_dsihw_remove,
 	.driver         = {
 		.name   = "omapdss_dsi",
@@ -4781,7 +4780,7 @@ static struct platform_driver omap_dsihw_driver = {
 
 int dsi_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dsihw_driver);
+	return platform_driver_probe(&omap_dsihw_driver, omap_dsihw_probe);
 }
 
 void dsi_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 614eaed..0e3d099 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -870,7 +870,6 @@ static const struct dev_pm_ops hdmi_pm_ops = {
 };
 
 static struct platform_driver omapdss_hdmihw_driver = {
-	.probe          = omapdss_hdmihw_probe,
 	.remove         = omapdss_hdmihw_remove,
 	.driver         = {
 		.name   = "omapdss_hdmi",
@@ -881,7 +880,7 @@ static struct platform_driver omapdss_hdmihw_driver = {
 
 int hdmi_init_platform_driver(void)
 {
-	return platform_driver_register(&omapdss_hdmihw_driver);
+	return platform_driver_probe(&omapdss_hdmihw_driver, omapdss_hdmihw_probe);
 }
 
 void hdmi_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 6f28955..23b4142 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1015,7 +1015,6 @@ static const struct dev_pm_ops rfbi_pm_ops = {
 };
 
 static struct platform_driver omap_rfbihw_driver = {
-	.probe          = omap_rfbihw_probe,
 	.remove         = omap_rfbihw_remove,
 	.driver         = {
 		.name   = "omapdss_rfbi",
@@ -1026,7 +1025,7 @@ static struct platform_driver omap_rfbihw_driver = {
 
 int rfbi_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_rfbihw_driver);
+	return platform_driver_probe(&omap_rfbihw_driver, omap_rfbihw_probe);
 }
 
 void rfbi_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 90a1955..ff9ad37 100644
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
index cb6b571..130263b 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -877,7 +877,6 @@ static const struct dev_pm_ops venc_pm_ops = {
 };
 
 static struct platform_driver omap_venchw_driver = {
-	.probe          = omap_venchw_probe,
 	.remove         = omap_venchw_remove,
 	.driver         = {
 		.name   = "omapdss_venc",
@@ -891,7 +890,7 @@ int venc_init_platform_driver(void)
 	if (cpu_is_omap44xx())
 		return 0;
 
-	return platform_driver_register(&omap_venchw_driver);
+	return platform_driver_probe(&omap_venchw_driver, omap_venchw_probe);
 }
 
 void venc_uninit_platform_driver(void)
-- 
1.7.9.5

