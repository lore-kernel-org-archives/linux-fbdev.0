From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:27:46 +0000
Subject: [WIP/RFC 08/31] fbdev: sh_mobile_hdmi: Implement sh_mobile_lcdc_entity interface
Message-Id: <1316392089-27598-9-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_hdmi.c |   43 +++++++++++++++++++++++++++++----------
 1 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index e888081..ce858d6 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -208,6 +208,8 @@ enum hotplug_state {
 };
 
 struct sh_hdmi {
+	struct sh_mobile_lcdc_entity entity;
+
 	void __iomem *base;
 	enum hotplug_state hp_state;	/* hot-plug status */
 	u8 preprogrammed_vic;		/* use a pre-programmed VIC or
@@ -225,6 +227,9 @@ struct sh_hdmi {
 	struct notifier_block notifier;
 };
 
+#define entity_to_sh_hdmi(e)	container_of(e, struct sh_hdmi, entity)
+#define notifier_to_sh_hdmi(n)	container_of(n, struct sh_hdmi, notifier)
+
 static void hdmi_write(struct sh_hdmi *hdmi, u8 data, u8 reg)
 {
 	iowrite8(data, hdmi->base + reg);
@@ -999,13 +1004,14 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 }
 
 /* locking:	called with info->lock held, or before register_framebuffer() */
-static void sh_hdmi_display_on(void *arg, struct fb_info *info)
+static void __sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity,
+			       struct fb_info *info)
 {
 	/*
 	 * info is guaranteed to be valid, when we are called, because our
 	 * FB_EVENT_FB_UNBIND notify is also called with info->lock held
 	 */
-	struct sh_hdmi *hdmi = arg;
+	struct sh_hdmi *hdmi = entity_to_sh_hdmi(entity);
 	struct sh_mobile_lcdc_chan *ch = info->par;
 
 	dev_dbg(hdmi->dev, "%s(%p): state %x\n", __func__, hdmi, info->state);
@@ -1032,16 +1038,31 @@ static void sh_hdmi_display_on(void *arg, struct fb_info *info)
 	}
 }
 
+static void sh_hdmi_display_on(void *arg, struct fb_info *info)
+{
+	__sh_hdmi_display_on(arg, info);
+}
+
 /* locking: called with info->lock held */
-static void sh_hdmi_display_off(void *arg)
+static void __sh_hdmi_display_off(struct sh_mobile_lcdc_entity *entity)
 {
-	struct sh_hdmi *hdmi = arg;
+	struct sh_hdmi *hdmi = entity_to_sh_hdmi(entity);
 
 	dev_dbg(hdmi->dev, "%s(%p)\n", __func__, hdmi);
 	/* PS mode e->a */
 	hdmi_write(hdmi, 0x10, HDMI_SYSTEM_CTRL);
 }
 
+static void sh_hdmi_display_off(void *arg)
+{
+	__sh_hdmi_display_off(arg);
+}
+
+static const struct sh_mobile_lcdc_entity_ops sh_hdmi_ops = {
+	.display_on = __sh_hdmi_display_on,
+	.display_off = __sh_hdmi_display_off,
+};
+
 static bool sh_hdmi_must_reconfigure(struct sh_hdmi *hdmi)
 {
 	struct fb_info *info = hdmi->info;
@@ -1153,7 +1174,7 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 			if (lock_fb_info(info)) {
 				info->var.width = hdmi->var.width;
 				info->var.height = hdmi->var.height;
-				sh_hdmi_display_on(hdmi, info);
+				__sh_hdmi_display_on(&hdmi->entity, info);
 				unlock_fb_info(info);
 			}
 		} else {
@@ -1192,9 +1213,7 @@ static int sh_hdmi_notify(struct notifier_block *nb,
 {
 	struct fb_event *event = data;
 	struct fb_info *info = event->info;
-	struct sh_mobile_lcdc_chan *ch = info->par;
-	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
-	struct sh_hdmi *hdmi = board_cfg->board_data;
+	struct sh_hdmi *hdmi = notifier_to_sh_hdmi(nb);
 
 	if (!hdmi || nb != &hdmi->notifier || hdmi->info != info)
 		return NOTIFY_DONE;
@@ -1246,6 +1265,8 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 	mutex_init(&hdmi->mutex);
 
 	hdmi->dev = &pdev->dev;
+	hdmi->entity.owner = THIS_MODULE;
+	hdmi->entity.ops = &sh_hdmi_ops;
 
 	hdmi->hdmi_clk = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(hdmi->hdmi_clk)) {
@@ -1285,12 +1306,12 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		goto emap;
 	}
 
-	platform_set_drvdata(pdev, hdmi);
+	platform_set_drvdata(pdev, &hdmi->entity);
 
 	/* Set up LCDC callbacks */
 	board_cfg = &pdata->lcd_chan->board_cfg;
 	board_cfg->owner = THIS_MODULE;
-	board_cfg->board_data = hdmi;
+	board_cfg->board_data = &hdmi->entity;
 	board_cfg->display_on = sh_hdmi_display_on;
 	board_cfg->display_off = sh_hdmi_display_off;
 
@@ -1344,7 +1365,7 @@ egetclk:
 static int __exit sh_hdmi_remove(struct platform_device *pdev)
 {
 	struct sh_mobile_hdmi_info *pdata = pdev->dev.platform_data;
-	struct sh_hdmi *hdmi = platform_get_drvdata(pdev);
+	struct sh_hdmi *hdmi = entity_to_sh_hdmi(platform_get_drvdata(pdev));
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct sh_mobile_lcdc_board_cfg	*board_cfg = &pdata->lcd_chan->board_cfg;
 	int irq = platform_get_irq(pdev, 0);
-- 
1.7.3.4

