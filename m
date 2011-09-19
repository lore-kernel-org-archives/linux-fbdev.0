From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:28:07 +0000
Subject: [WIP/RFC 29/31] fbdev: sh_mipi_dsi: Add media controller support
Message-Id: <1316392089-27598-30-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Initialize the entity associated with the MIPI/DSI transmitter.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mipi_dsi.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 3ead395..93ee3ee 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -50,6 +50,7 @@
 
 struct sh_mipi {
 	struct sh_mobile_lcdc_entity entity;
+	struct media_pad pads[2];
 
 	void __iomem	*base;
 	void __iomem	*linkbase;
@@ -364,8 +365,9 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *res2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	unsigned long rate, f_current;
-	int idx = pdev->id, ret;
+	int idx = pdev->id;
 	char dsip_clk[] = "dsi.p_clk";
+	int ret;
 
 	if (!res || !res2 || idx >= ARRAY_SIZE(mipi_dsi) || !pdata)
 		return -ENODEV;
@@ -389,6 +391,17 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	mipi->entity.owner = THIS_MODULE;
 	mipi->entity.ops = &mipi_ops;
 
+	/* Initialize the panel media entity. */
+	mipi->pads[0].flags = MEDIA_PAD_FL_SINK;
+	mipi->pads[1].flags = MEDIA_PAD_FL_SOURCE;
+	ret = media_entity_init(&mipi->entity.entity, 2, mipi->pads, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to initialize MIPI entity\n");
+		goto ereqreg;
+	}
+
+	mipi->entity.entity.name = "MIPI/DSI transmitter";
+
 	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
 		dev_err(&pdev->dev, "MIPI register region already claimed\n");
 		ret = -EBUSY;
@@ -497,6 +510,7 @@ ereqreg2:
 emap:
 	release_mem_region(res->start, resource_size(res));
 ereqreg:
+	media_entity_cleanup(&mipi->entity.entity);
 	kfree(mipi);
 ealloc:
 efindslot:
@@ -541,6 +555,7 @@ static int __exit sh_mipi_remove(struct platform_device *pdev)
 	if (res)
 		release_mem_region(res->start, resource_size(res));
 	platform_set_drvdata(pdev, NULL);
+	media_entity_cleanup(&mipi->entity.entity);
 	kfree(mipi);
 
 	return 0;
-- 
1.7.3.4

