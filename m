From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:18 +0000
Subject: [PATCH 23/57] fbdev: sh_mobile_lcdc: Remove fb_info parameter to display_on operation
Message-Id: <1323784972-24205-24-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The parameter is unused, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mipi_dsi.c      |    3 +--
 drivers/video/sh_mobile_hdmi.c   |   11 +++--------
 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 drivers/video/sh_mobile_lcdcfb.h |    3 +--
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index ad09a05..1ede247 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -394,8 +394,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	return 0;
 }
 
-static int mipi_display_on(struct sh_mobile_lcdc_entity *entity,
-			   struct fb_info *info)
+static int mipi_display_on(struct sh_mobile_lcdc_entity *entity)
 {
 	struct sh_mipi *mipi = to_sh_mipi(entity);
 	struct sh_mipi_dsi_info *pdata = mipi->pdev->dev.platform_data;
diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index bd885ee..c22e123 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1000,16 +1000,11 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/* locking:	called with info->lock held, or before register_framebuffer() */
-static int sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity,
-			      struct fb_info *info)
+static int sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity)
 {
-	/*
-	 * info is guaranteed to be valid, when we are called, because our
-	 * FB_EVENT_FB_UNBIND notify is also called with info->lock held
-	 */
 	struct sh_hdmi *hdmi = entity_to_sh_hdmi(entity);
 	struct sh_mobile_lcdc_chan *ch = entity->lcdc;
+	struct fb_info *info = ch->info;
 
 	dev_dbg(hdmi->dev, "%s(%p): state %x\n", __func__, hdmi, info->state);
 
@@ -1156,7 +1151,7 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 				 */
 				info->var.width = hdmi->var.width;
 				info->var.height = hdmi->var.height;
-				sh_hdmi_display_on(&hdmi->entity, info);
+				sh_hdmi_display_on(&hdmi->entity);
 			} else {
 				/* New monitor or have to wake up */
 				fb_set_suspend(info, 0);
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 2dccfde..47108aa 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -339,7 +339,7 @@ static void sh_mobile_lcdc_display_on(struct sh_mobile_lcdc_chan *ch)
 	int ret;
 
 	if (ch->tx_dev) {
-		ret = ch->tx_dev->ops->display_on(ch->tx_dev, ch->info);
+		ret = ch->tx_dev->ops->display_on(ch->tx_dev);
 		if (ret < 0)
 			return;
 	}
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 36cd564..b2cb8e6 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -23,8 +23,7 @@ struct sh_mobile_lcdc_chan;
 
 struct sh_mobile_lcdc_entity_ops {
 	/* Display */
-	int (*display_on)(struct sh_mobile_lcdc_entity *entity,
-			  struct fb_info *info);
+	int (*display_on)(struct sh_mobile_lcdc_entity *entity);
 	void (*display_off)(struct sh_mobile_lcdc_entity *entity);
 };
 
-- 
1.7.3.4

