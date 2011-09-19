From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:28:08 +0000
Subject: [WIP/RFC 30/31] fbdev: sh_mobile_hdmi: Add media controller support
Message-Id: <1316392089-27598-31-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Initialize the entity associated with the HDMI transmitter.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_hdmi.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index c17e3ad..c30c6a0 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -209,6 +209,7 @@ enum hotplug_state {
 
 struct sh_hdmi {
 	struct sh_mobile_lcdc_entity entity;
+	struct media_pad pads[2];
 
 	void __iomem *base;
 	enum hotplug_state hp_state;	/* hot-plug status */
@@ -1129,9 +1130,10 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_hdmi_info *pdata = pdev->dev.platform_data;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	int irq = platform_get_irq(pdev, 0), ret;
+	int irq = platform_get_irq(pdev, 0);
 	struct sh_hdmi *hdmi;
 	long rate;
+	int ret;
 
 	if (!res || !pdata || irq < 0)
 		return -ENODEV;
@@ -1146,6 +1148,17 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 	hdmi->entity.owner = THIS_MODULE;
 	hdmi->entity.ops = &sh_hdmi_ops;
 
+	/* Initialize the panel media entity. */
+	hdmi->pads[0].flags = MEDIA_PAD_FL_SINK;
+	hdmi->pads[1].flags = MEDIA_PAD_FL_SOURCE;
+	ret = media_entity_init(&hdmi->entity.entity, 2, hdmi->pads, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to initialize HDMI entity\n");
+		goto egetclk;
+	}
+
+	hdmi->entity.entity.name = "HDMI transmitter";
+
 	hdmi->hdmi_clk = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(hdmi->hdmi_clk)) {
 		ret = PTR_ERR(hdmi->hdmi_clk);
@@ -1224,6 +1237,7 @@ ereqreg:
 erate:
 	clk_put(hdmi->hdmi_clk);
 egetclk:
+	media_entity_cleanup(&hdmi->entity.entity);
 	kfree(hdmi);
 
 	return ret;
@@ -1247,6 +1261,7 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
 	clk_put(hdmi->hdmi_clk);
 	iounmap(hdmi->base);
 	release_mem_region(res->start, resource_size(res));
+	media_entity_cleanup(&hdmi->entity.entity);
 	kfree(hdmi);
 
 	return 0;
-- 
1.7.3.4

