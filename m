From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 14 Mar 2013 17:09:37 +0000
Subject: [PATCH v2 7/8] drivers: video: use module_platform_driver_probe()
Message-Id: <1363280978-24051-8-git-send-email-fabio.porcedda@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch converts the drivers to use the
module_platform_driver_probe() macro which makes the code smaller and
a bit simpler.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/sh_mipi_dsi.c    | 12 +-----------
 drivers/video/sh_mobile_hdmi.c | 12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 701b461..6cad530 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -581,17 +581,7 @@ static struct platform_driver sh_mipi_driver = {
 	},
 };
 
-static int __init sh_mipi_init(void)
-{
-	return platform_driver_probe(&sh_mipi_driver, sh_mipi_probe);
-}
-module_init(sh_mipi_init);
-
-static void __exit sh_mipi_exit(void)
-{
-	platform_driver_unregister(&sh_mipi_driver);
-}
-module_exit(sh_mipi_exit);
+module_platform_driver_probe(sh_mipi_driver, sh_mipi_probe);
 
 MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
 MODULE_DESCRIPTION("SuperH / ARM-shmobile MIPI DSI driver");
diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 930e550..bfe4728 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1445,17 +1445,7 @@ static struct platform_driver sh_hdmi_driver = {
 	},
 };
 
-static int __init sh_hdmi_init(void)
-{
-	return platform_driver_probe(&sh_hdmi_driver, sh_hdmi_probe);
-}
-module_init(sh_hdmi_init);
-
-static void __exit sh_hdmi_exit(void)
-{
-	platform_driver_unregister(&sh_hdmi_driver);
-}
-module_exit(sh_hdmi_exit);
+module_platform_driver_probe(sh_hdmi_driver, sh_hdmi_probe);
 
 MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
 MODULE_DESCRIPTION("SuperH / ARM-shmobile HDMI driver");
-- 
1.8.1.5

