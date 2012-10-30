From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Oct 2012 16:10:00 +0000
Subject: [PATCH 03/12] OMAPDSS: fix DPI & DSI init order
Message-Id: <1351613409-21186-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

DPI may use DSI PLL, so it depends on DSI. However, currently DPI driver
is added first, which causes DPI initialization to fail when it tries to
get the DSI PLL.

This patch changes the init order to fix this.

A better solution would be to separate DSI PLL and DSI drivers. They
have dependencies, though, but we could still have DSI PLL as an
independent entity that we could initialize before any of the output
drivers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 00aa026..d25374c 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -502,6 +502,9 @@ static int __init omap_dss_bus_register(void)
 
 /* INIT */
 static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_init_platform_driver,
+#endif
 #ifdef CONFIG_OMAP2_DSS_DPI
 	dpi_init_platform_driver,
 #endif
@@ -514,15 +517,15 @@ static int (*dss_output_drv_reg_funcs[])(void) __initdata = {
 #ifdef CONFIG_OMAP2_DSS_VENC
 	venc_init_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_init_platform_driver,
-#endif
 #ifdef CONFIG_OMAP4_DSS_HDMI
 	hdmi_init_platform_driver,
 #endif
 };
 
 static void (*dss_output_drv_unreg_funcs[])(void) __exitdata = {
+#ifdef CONFIG_OMAP2_DSS_DSI
+	dsi_uninit_platform_driver,
+#endif
 #ifdef CONFIG_OMAP2_DSS_DPI
 	dpi_uninit_platform_driver,
 #endif
@@ -535,9 +538,6 @@ static void (*dss_output_drv_unreg_funcs[])(void) __exitdata = {
 #ifdef CONFIG_OMAP2_DSS_VENC
 	venc_uninit_platform_driver,
 #endif
-#ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_uninit_platform_driver,
-#endif
 #ifdef CONFIG_OMAP4_DSS_HDMI
 	hdmi_uninit_platform_driver,
 #endif
-- 
1.7.10.4

