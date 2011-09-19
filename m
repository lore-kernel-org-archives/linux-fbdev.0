From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:27:47 +0000
Subject: [WIP/RFC 09/31] fbdev: sh_mipi_dsi: Implement sh_mobile_lcdc_entity interface
Message-Id: <1316392089-27598-10-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mipi_dsi.c |   49 +++++++++++++++++++++++++++++++++++--------
 1 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 24640c8..31a403d 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -22,6 +22,8 @@
 #include <video/sh_mipi_dsi.h>
 #include <video/sh_mobile_lcdc.h>
 
+#include "sh_mobile_lcdcfb.h"
+
 #define SYSCTRL		0x0000
 #define SYSCONF		0x0004
 #define TIMSET		0x0008
@@ -47,6 +49,8 @@
 #define MAX_SH_MIPI_DSI 2
 
 struct sh_mipi {
+	struct sh_mobile_lcdc_entity entity;
+
 	void __iomem	*base;
 	void __iomem	*linkbase;
 	struct clk	*dsit_clk;
@@ -58,6 +62,8 @@ struct sh_mipi {
 	void	(*next_display_off)(void *board_data);
 };
 
+#define to_sh_mipi(e)	container_of(e, struct sh_mipi, entity)
+
 static struct sh_mipi *mipi_dsi[MAX_SH_MIPI_DSI];
 
 /* Protect the above array */
@@ -118,33 +124,55 @@ static void sh_mipi_dsi_enable(struct sh_mipi *mipi, bool enable)
 
 static void sh_mipi_shutdown(struct platform_device *pdev)
 {
-	struct sh_mipi *mipi = platform_get_drvdata(pdev);
+	struct sh_mipi *mipi = to_sh_mipi(platform_get_drvdata(pdev));
 
 	sh_mipi_dsi_enable(mipi, false);
 }
 
-static void mipi_display_on(void *arg, struct fb_info *info)
+static void __mipi_display_on(struct sh_mobile_lcdc_entity *entity,
+			    struct fb_info *info)
 {
-	struct sh_mipi *mipi = arg;
+	struct sh_mipi *mipi = to_sh_mipi(entity);
 
 	pm_runtime_get_sync(mipi->dev);
 	sh_mipi_dsi_enable(mipi, true);
+}
+
+static void mipi_display_on(void *arg, struct fb_info *info)
+{
+	struct sh_mobile_lcdc_entity *entity = arg;
+	struct sh_mipi *mipi = to_sh_mipi(entity);
+
+	__mipi_display_on(entity, info);
 
 	if (mipi->next_display_on)
 		mipi->next_display_on(mipi->next_board_data, info);
 }
 
+static void __mipi_display_off(struct sh_mobile_lcdc_entity *entity)
+{
+	struct sh_mipi *mipi = to_sh_mipi(entity);
+
+	sh_mipi_dsi_enable(mipi, false);
+	pm_runtime_put(mipi->dev);
+}
+
 static void mipi_display_off(void *arg)
 {
-	struct sh_mipi *mipi = arg;
+	struct sh_mobile_lcdc_entity *entity = arg;
+	struct sh_mipi *mipi = to_sh_mipi(entity);
 
 	if (mipi->next_display_off)
 		mipi->next_display_off(mipi->next_board_data);
 
-	sh_mipi_dsi_enable(mipi, false);
-	pm_runtime_put(mipi->dev);
+	__mipi_display_off(entity);
 }
 
+static const struct sh_mobile_lcdc_entity_ops mipi_ops = {
+	.display_on = __mipi_display_on,
+	.display_off = __mipi_display_off,
+};
+
 static int __init sh_mipi_setup(struct sh_mipi *mipi,
 				struct sh_mipi_dsi_info *pdata)
 {
@@ -383,6 +411,9 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 		goto ealloc;
 	}
 
+	mipi->entity.owner = THIS_MODULE;
+	mipi->entity.ops = &mipi_ops;
+
 	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
 		dev_err(&pdev->dev, "MIPI register region already claimed\n");
 		ret = -EBUSY;
@@ -466,7 +497,7 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 		goto emipisetup;
 
 	mutex_unlock(&array_lock);
-	platform_set_drvdata(pdev, mipi);
+	platform_set_drvdata(pdev, &mipi->entity);
 
 	/* Save original LCDC callbacks */
 	mipi->next_board_data = pdata->lcd_chan->board_cfg.board_data;
@@ -474,7 +505,7 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	mipi->next_display_off = pdata->lcd_chan->board_cfg.display_off;
 
 	/* Set up LCDC callbacks */
-	pdata->lcd_chan->board_cfg.board_data = mipi;
+	pdata->lcd_chan->board_cfg.board_data = &mipi->entity;
 	pdata->lcd_chan->board_cfg.display_on = mipi_display_on;
 	pdata->lcd_chan->board_cfg.display_off = mipi_display_off;
 	pdata->lcd_chan->board_cfg.owner = THIS_MODULE;
@@ -515,7 +546,7 @@ static int __exit sh_mipi_remove(struct platform_device *pdev)
 	struct sh_mipi_dsi_info *pdata = pdev->dev.platform_data;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *res2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	struct sh_mipi *mipi = platform_get_drvdata(pdev);
+	struct sh_mipi *mipi = to_sh_mipi(platform_get_drvdata(pdev));
 	int i, ret;
 
 	mutex_lock(&array_lock);
-- 
1.7.3.4

