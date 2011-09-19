From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:28:00 +0000
Subject: [WIP/RFC 22/31] fbdev: sh_mobile_lcdc: Remove fb_info parameter to display_on operation
Message-Id: <1316392089-27598-23-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The parameter is unused, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mipi_dsi.c      |    3 +--
 drivers/video/sh_mobile_hdmi.c   |   10 ++--------
 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 drivers/video/sh_mobile_lcdcfb.h |    3 +--
 4 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index e198067..f5d380c 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -125,8 +125,7 @@ static void sh_mipi_shutdown(struct platform_device *pdev)
 	sh_mipi_dsi_enable(mipi, false);
 }
 
-static void mipi_display_on(struct sh_mobile_lcdc_entity *entity,
-			    struct fb_info *info)
+static void mipi_display_on(struct sh_mobile_lcdc_entity *entity)
 {
 	struct sh_mipi *mipi = to_sh_mipi(entity);
 
diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index deca755..88de4e0 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1000,14 +1000,8 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/* locking:	called with info->lock held, or before register_framebuffer() */
-static void sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity,
-			       struct fb_info *info)
+static void sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity)
 {
-	/*
-	 * info is guaranteed to be valid, when we are called, because our
-	 * FB_EVENT_FB_UNBIND notify is also called with info->lock held
-	 */
 	struct sh_hdmi *hdmi = entity_to_sh_hdmi(entity);
 	struct sh_mobile_lcdc_chan *ch = entity->lcdc;
 	struct fb_info *info = ch->info;
@@ -1155,7 +1149,7 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 			if (lock_fb_info(info)) {
 				info->var.width = hdmi->var.width;
 				info->var.height = hdmi->var.height;
-				sh_hdmi_display_on(&hdmi->entity, info);
+				sh_hdmi_display_on(&hdmi->entity);
 				unlock_fb_info(info);
 			}
 		} else {
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index f8bdbe9..afd00cc 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -337,7 +337,7 @@ static void sh_mobile_lcdc_display_on(struct sh_mobile_lcdc_chan *ch)
 	struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg.panel_cfg;
 
 	if (ch->tx_dev)
-		ch->tx_dev->ops->display_on(ch->tx_dev, ch->info);
+		ch->tx_dev->ops->display_on(ch->tx_dev);
 
 	/* HDMI must be enabled before LCDC configuration */
 	if (panel->display_on)
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index b57a847..50c2d1f 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -23,8 +23,7 @@ struct sh_mobile_lcdc_chan;
 
 struct sh_mobile_lcdc_entity_ops {
 	/* Display */
-	void (*display_on)(struct sh_mobile_lcdc_entity *entity,
-			   struct fb_info *info);
+	void (*display_on)(struct sh_mobile_lcdc_entity *entity);
 	void (*display_off)(struct sh_mobile_lcdc_entity *entity);
 };
 
-- 
1.7.3.4

