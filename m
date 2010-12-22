From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 22 Dec 2010 09:52:18 +0000
Subject: [PATCH 1/2] fbdev: sh-mobile: implement MIPI DSI runtime PM support
Message-Id: <Pine.LNX.4.64.1012221050400.14483@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On SH-Mobile platforms using runtime PM with the MIPI DSI driver switches the
DSI Tx link clock on PM events.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mipi_dsi.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 3f3d431..ef19cac 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -33,6 +34,7 @@ struct sh_mipi {
 	void __iomem	*base;
 	struct clk	*dsit_clk;
 	struct clk	*dsip_clk;
+	struct device	*dev;
 };
 
 static struct sh_mipi *mipi_dsi[MAX_SH_MIPI_DSI];
@@ -104,6 +106,7 @@ static void mipi_display_on(void *arg, struct fb_info *info)
 {
 	struct sh_mipi *mipi = arg;
 
+	pm_runtime_get_sync(mipi->dev);
 	sh_mipi_dsi_enable(mipi, true);
 }
 
@@ -112,6 +115,7 @@ static void mipi_display_off(void *arg)
 	struct sh_mipi *mipi = arg;
 
 	sh_mipi_dsi_enable(mipi, false);
+	pm_runtime_put(mipi->dev);
 }
 
 static int __init sh_mipi_setup(struct sh_mipi *mipi,
@@ -356,7 +360,9 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 		goto emap;
 	}
 
-	mipi->dsit_clk = clk_get(&pdev->dev, "dsit_clk");
+	mipi->dev = &pdev->dev;
+
+	mipi->dsit_clk = clk_get(NULL, "dsit_clk");
 	if (IS_ERR(mipi->dsit_clk)) {
 		ret = PTR_ERR(mipi->dsit_clk);
 		goto eclktget;
@@ -405,6 +411,9 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 
 	mipi_dsi[idx] = mipi;
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_resume(&pdev->dev);
+
 	ret = sh_mipi_setup(mipi, pdata);
 	if (ret < 0)
 		goto emipisetup;
@@ -416,11 +425,13 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	pdata->lcd_chan->board_cfg.board_data = mipi;
 	pdata->lcd_chan->board_cfg.display_on = mipi_display_on;
 	pdata->lcd_chan->board_cfg.display_off = mipi_display_off;
+	pdata->lcd_chan->board_cfg.owner = THIS_MODULE;
 
 	return 0;
 
 emipisetup:
 	mipi_dsi[idx] = NULL;
+	pm_runtime_disable(&pdev->dev);
 	clk_disable(mipi->dsip_clk);
 eclkpon:
 	clk_disable(mipi->dsit_clk);
@@ -467,10 +478,12 @@ static int __exit sh_mipi_remove(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	pdata->lcd_chan->board_cfg.owner = NULL;
 	pdata->lcd_chan->board_cfg.display_on = NULL;
 	pdata->lcd_chan->board_cfg.display_off = NULL;
 	pdata->lcd_chan->board_cfg.board_data = NULL;
 
+	pm_runtime_disable(&pdev->dev);
 	clk_disable(mipi->dsip_clk);
 	clk_disable(mipi->dsit_clk);
 	clk_put(mipi->dsit_clk);
-- 
1.7.2.3

