From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:27:51 +0000
Subject: [WIP/RFC 13/31] fbdev: sh_mobile_hdmi: Don't hook up into board_cfg display operations
Message-Id: <1316392089-27598-14-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The display_on/off operations are now accessed through the
sh_mobile_lcdc_entity operations.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_hdmi.c |   35 +++++------------------------------
 1 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index ce858d6..d89645e 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1004,7 +1004,7 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 }
 
 /* locking:	called with info->lock held, or before register_framebuffer() */
-static void __sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity,
+static void sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity,
 			       struct fb_info *info)
 {
 	/*
@@ -1038,13 +1038,8 @@ static void __sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity,
 	}
 }
 
-static void sh_hdmi_display_on(void *arg, struct fb_info *info)
-{
-	__sh_hdmi_display_on(arg, info);
-}
-
 /* locking: called with info->lock held */
-static void __sh_hdmi_display_off(struct sh_mobile_lcdc_entity *entity)
+static void sh_hdmi_display_off(struct sh_mobile_lcdc_entity *entity)
 {
 	struct sh_hdmi *hdmi = entity_to_sh_hdmi(entity);
 
@@ -1053,14 +1048,9 @@ static void __sh_hdmi_display_off(struct sh_mobile_lcdc_entity *entity)
 	hdmi_write(hdmi, 0x10, HDMI_SYSTEM_CTRL);
 }
 
-static void sh_hdmi_display_off(void *arg)
-{
-	__sh_hdmi_display_off(arg);
-}
-
 static const struct sh_mobile_lcdc_entity_ops sh_hdmi_ops = {
-	.display_on = __sh_hdmi_display_on,
-	.display_off = __sh_hdmi_display_off,
+	.display_on = sh_hdmi_display_on,
+	.display_off = sh_hdmi_display_off,
 };
 
 static bool sh_hdmi_must_reconfigure(struct sh_hdmi *hdmi)
@@ -1174,7 +1164,7 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 			if (lock_fb_info(info)) {
 				info->var.width = hdmi->var.width;
 				info->var.height = hdmi->var.height;
-				__sh_hdmi_display_on(&hdmi->entity, info);
+				sh_hdmi_display_on(&hdmi->entity, info);
 				unlock_fb_info(info);
 			}
 		} else {
@@ -1248,7 +1238,6 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_hdmi_info *pdata = pdev->dev.platform_data;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct sh_mobile_lcdc_board_cfg	*board_cfg;
 	int irq = platform_get_irq(pdev, 0), ret;
 	struct sh_hdmi *hdmi;
 	long rate;
@@ -1308,13 +1297,6 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &hdmi->entity);
 
-	/* Set up LCDC callbacks */
-	board_cfg = &pdata->lcd_chan->board_cfg;
-	board_cfg->owner = THIS_MODULE;
-	board_cfg->board_data = &hdmi->entity;
-	board_cfg->display_on = sh_hdmi_display_on;
-	board_cfg->display_off = sh_hdmi_display_off;
-
 	INIT_DELAYED_WORK(&hdmi->edid_work, sh_hdmi_edid_work_fn);
 
 	pm_runtime_enable(&pdev->dev);
@@ -1364,21 +1346,14 @@ egetclk:
 
 static int __exit sh_hdmi_remove(struct platform_device *pdev)
 {
-	struct sh_mobile_hdmi_info *pdata = pdev->dev.platform_data;
 	struct sh_hdmi *hdmi = entity_to_sh_hdmi(platform_get_drvdata(pdev));
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct sh_mobile_lcdc_board_cfg	*board_cfg = &pdata->lcd_chan->board_cfg;
 	int irq = platform_get_irq(pdev, 0);
 
 	snd_soc_unregister_codec(&pdev->dev);
 
 	fb_unregister_client(&hdmi->notifier);
 
-	board_cfg->display_on = NULL;
-	board_cfg->display_off = NULL;
-	board_cfg->board_data = NULL;
-	board_cfg->owner = NULL;
-
 	/* No new work will be scheduled, wait for running ISR */
 	free_irq(irq, hdmi);
 	/* Wait for already scheduled work */
-- 
1.7.3.4

