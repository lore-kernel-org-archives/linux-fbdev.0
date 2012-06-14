From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 14 Jun 2012 07:53:33 +0000
Subject: [PATCH] fbdev: sh_mipi_dsi: fix a section mismatch
Message-Id: <Pine.LNX.4.64.1206140951570.30810@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

sh_mipi_setup() is called from a .text function, therefore it cannot be
__init. Additionally, sh_mipi_remove() can be moved to the .devexit.text
section.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mipi_dsi.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 4c6b844..3951fda 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -127,8 +127,7 @@ static void sh_mipi_shutdown(struct platform_device *pdev)
 	sh_mipi_dsi_enable(mipi, false);
 }
 
-static int __init sh_mipi_setup(struct sh_mipi *mipi,
-				struct sh_mipi_dsi_info *pdata)
+static int sh_mipi_setup(struct sh_mipi *mipi, struct sh_mipi_dsi_info *pdata)
 {
 	void __iomem *base = mipi->base;
 	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
@@ -551,7 +550,7 @@ efindslot:
 	return ret;
 }
 
-static int __exit sh_mipi_remove(struct platform_device *pdev)
+static int __devexit sh_mipi_remove(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *res2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
@@ -592,7 +591,7 @@ static int __exit sh_mipi_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver sh_mipi_driver = {
-	.remove		= __exit_p(sh_mipi_remove),
+	.remove		= __devexit_p(sh_mipi_remove),
 	.shutdown	= sh_mipi_shutdown,
 	.driver = {
 		.name	= "sh-mipi-dsi",
-- 
1.7.2.5

