From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 03 May 2012 13:57:45 +0000
Subject: [PATCH 09/25] OMAPDSS: remove return from platform_driver_unreg
Message-Id: <1336053481-25433-10-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

For unknown reasons we seem to have a return in each of the omapdss's
uninit functions, which is a void function.

Remove the returns.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    2 +-
 drivers/video/omap2/dss/dsi.c   |    2 +-
 drivers/video/omap2/dss/dss.c   |    2 +-
 drivers/video/omap2/dss/hdmi.c  |    2 +-
 drivers/video/omap2/dss/rfbi.c  |    2 +-
 drivers/video/omap2/dss/venc.c  |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 262ed29..2aa1fea 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3636,5 +3636,5 @@ int dispc_init_platform_driver(void)
 
 void dispc_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omap_dispchw_driver);
+	platform_driver_unregister(&omap_dispchw_driver);
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a5a8316..45ba9e7 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4816,5 +4816,5 @@ int dsi_init_platform_driver(void)
 
 void dsi_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omap_dsihw_driver);
+	platform_driver_unregister(&omap_dsihw_driver);
 }
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index e731aa4..24f5429 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -873,5 +873,5 @@ int dss_init_platform_driver(void)
 
 void dss_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omap_dsshw_driver);
+	platform_driver_unregister(&omap_dsshw_driver);
 }
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 2321b75..35580b1 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -914,5 +914,5 @@ int hdmi_init_platform_driver(void)
 
 void hdmi_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omapdss_hdmihw_driver);
+	platform_driver_unregister(&omapdss_hdmihw_driver);
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index a81ffcb..39aac0b 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1039,5 +1039,5 @@ int rfbi_init_platform_driver(void)
 
 void rfbi_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omap_rfbihw_driver);
+	platform_driver_unregister(&omap_rfbihw_driver);
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 30bbb63..7b0e8ed 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -907,5 +907,5 @@ void venc_uninit_platform_driver(void)
 	if (cpu_is_omap44xx())
 		return;
 
-	return platform_driver_unregister(&omap_venchw_driver);
+	platform_driver_unregister(&omap_venchw_driver);
 }
-- 
1.7.9.5

