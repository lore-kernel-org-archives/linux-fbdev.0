From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:27:50 +0000
Subject: [WIP/RFC 12/31] fbdev: sh_mipi_dsi: Don't hook up into board_cfg display operations
Message-Id: <1316392089-27598-13-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The display_on/off operations are now accessed through the
sh_mobile_lcdc_entity operations.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mipi_dsi.c |   51 +++---------------------------------------
 1 files changed, 4 insertions(+), 47 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 31a403d..e198067 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -56,10 +56,6 @@ struct sh_mipi {
 	struct clk	*dsit_clk;
 	struct clk	*dsip_clk;
 	struct device	*dev;
-
-	void	*next_board_data;
-	void	(*next_display_on)(void *board_data, struct fb_info *info);
-	void	(*next_display_off)(void *board_data);
 };
 
 #define to_sh_mipi(e)	container_of(e, struct sh_mipi, entity)
@@ -129,7 +125,7 @@ static void sh_mipi_shutdown(struct platform_device *pdev)
 	sh_mipi_dsi_enable(mipi, false);
 }
 
-static void __mipi_display_on(struct sh_mobile_lcdc_entity *entity,
+static void mipi_display_on(struct sh_mobile_lcdc_entity *entity,
 			    struct fb_info *info)
 {
 	struct sh_mipi *mipi = to_sh_mipi(entity);
@@ -138,18 +134,7 @@ static void __mipi_display_on(struct sh_mobile_lcdc_entity *entity,
 	sh_mipi_dsi_enable(mipi, true);
 }
 
-static void mipi_display_on(void *arg, struct fb_info *info)
-{
-	struct sh_mobile_lcdc_entity *entity = arg;
-	struct sh_mipi *mipi = to_sh_mipi(entity);
-
-	__mipi_display_on(entity, info);
-
-	if (mipi->next_display_on)
-		mipi->next_display_on(mipi->next_board_data, info);
-}
-
-static void __mipi_display_off(struct sh_mobile_lcdc_entity *entity)
+static void mipi_display_off(struct sh_mobile_lcdc_entity *entity)
 {
 	struct sh_mipi *mipi = to_sh_mipi(entity);
 
@@ -157,20 +142,9 @@ static void __mipi_display_off(struct sh_mobile_lcdc_entity *entity)
 	pm_runtime_put(mipi->dev);
 }
 
-static void mipi_display_off(void *arg)
-{
-	struct sh_mobile_lcdc_entity *entity = arg;
-	struct sh_mipi *mipi = to_sh_mipi(entity);
-
-	if (mipi->next_display_off)
-		mipi->next_display_off(mipi->next_board_data);
-
-	__mipi_display_off(entity);
-}
-
 static const struct sh_mobile_lcdc_entity_ops mipi_ops = {
-	.display_on = __mipi_display_on,
-	.display_off = __mipi_display_off,
+	.display_on = mipi_display_on,
+	.display_off = mipi_display_off,
 };
 
 static int __init sh_mipi_setup(struct sh_mipi *mipi,
@@ -499,17 +473,6 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	mutex_unlock(&array_lock);
 	platform_set_drvdata(pdev, &mipi->entity);
 
-	/* Save original LCDC callbacks */
-	mipi->next_board_data = pdata->lcd_chan->board_cfg.board_data;
-	mipi->next_display_on = pdata->lcd_chan->board_cfg.display_on;
-	mipi->next_display_off = pdata->lcd_chan->board_cfg.display_off;
-
-	/* Set up LCDC callbacks */
-	pdata->lcd_chan->board_cfg.board_data = &mipi->entity;
-	pdata->lcd_chan->board_cfg.display_on = mipi_display_on;
-	pdata->lcd_chan->board_cfg.display_off = mipi_display_off;
-	pdata->lcd_chan->board_cfg.owner = THIS_MODULE;
-
 	return 0;
 
 emipisetup:
@@ -543,7 +506,6 @@ efindslot:
 
 static int __exit sh_mipi_remove(struct platform_device *pdev)
 {
-	struct sh_mipi_dsi_info *pdata = pdev->dev.platform_data;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *res2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	struct sh_mipi *mipi = to_sh_mipi(platform_get_drvdata(pdev));
@@ -566,11 +528,6 @@ static int __exit sh_mipi_remove(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	pdata->lcd_chan->board_cfg.owner = NULL;
-	pdata->lcd_chan->board_cfg.display_on = NULL;
-	pdata->lcd_chan->board_cfg.display_off = NULL;
-	pdata->lcd_chan->board_cfg.board_data = NULL;
-
 	pm_runtime_disable(&pdev->dev);
 	clk_disable(mipi->dsip_clk);
 	clk_disable(mipi->dsit_clk);
-- 
1.7.3.4

