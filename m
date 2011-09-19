From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:28:01 +0000
Subject: [WIP/RFC 23/31] fbdev: sh_mobile_lcdc: Return display connection state in display_on
Message-Id: <1316392089-27598-24-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Return true if the display is connected and false otherwise. Set the fb
info state to FBINFO_STATE_SUSPENDED in the sh_mobile_lcdc driver when
the display is not connected.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mipi_dsi.c      |    4 +++-
 drivers/video/sh_mobile_hdmi.c   |    9 +++++----
 drivers/video/sh_mobile_lcdcfb.c |    8 ++++++--
 drivers/video/sh_mobile_lcdcfb.h |    2 +-
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index f5d380c..3ead395 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -125,12 +125,14 @@ static void sh_mipi_shutdown(struct platform_device *pdev)
 	sh_mipi_dsi_enable(mipi, false);
 }
 
-static void mipi_display_on(struct sh_mobile_lcdc_entity *entity)
+static bool mipi_display_on(struct sh_mobile_lcdc_entity *entity)
 {
 	struct sh_mipi *mipi = to_sh_mipi(entity);
 
 	pm_runtime_get_sync(mipi->dev);
 	sh_mipi_dsi_enable(mipi, true);
+
+	return true;
 }
 
 static void mipi_display_off(struct sh_mobile_lcdc_entity *entity)
diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 88de4e0..4b87c6e 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1000,13 +1000,13 @@ static irqreturn_t sh_hdmi_hotplug(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity)
+static bool sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity)
 {
 	struct sh_hdmi *hdmi = entity_to_sh_hdmi(entity);
 	struct sh_mobile_lcdc_chan *ch = entity->lcdc;
-	struct fb_info *info = ch->info;
 
-	dev_dbg(hdmi->dev, "%s(%p): state %x\n", __func__, hdmi, info->state);
+	dev_dbg(hdmi->dev, "%s(%p): state %x\n", __func__, hdmi,
+		hdmi->hp_state);
 
 	/*
 	 * hp_state can be set to
@@ -1021,10 +1021,11 @@ static void sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity)
 		dev_dbg(hdmi->dev, "HDMI running\n");
 		break;
 	case HDMI_HOTPLUG_DISCONNECTED:
-		info->state = FBINFO_STATE_SUSPENDED;
 	default:
 		hdmi->var = ch->display_var;
 	}
+
+	return hdmi->hp_state != HDMI_HOTPLUG_DISCONNECTED;
 }
 
 static void sh_hdmi_display_off(struct sh_mobile_lcdc_entity *entity)
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index afd00cc..d6c117b 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -335,9 +335,13 @@ static void sh_mobile_lcdc_deferred_io_touch(struct fb_info *info)
 static void sh_mobile_lcdc_display_on(struct sh_mobile_lcdc_chan *ch)
 {
 	struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg.panel_cfg;
+	bool connected;
 
-	if (ch->tx_dev)
-		ch->tx_dev->ops->display_on(ch->tx_dev);
+	if (ch->tx_dev) {
+		connected = ch->tx_dev->ops->display_on(ch->tx_dev);
+		if (!connected)
+			ch->info->state = FBINFO_STATE_SUSPENDED;
+	}
 
 	/* HDMI must be enabled before LCDC configuration */
 	if (panel->display_on)
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 50c2d1f..8f1e007 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -23,7 +23,7 @@ struct sh_mobile_lcdc_chan;
 
 struct sh_mobile_lcdc_entity_ops {
 	/* Display */
-	void (*display_on)(struct sh_mobile_lcdc_entity *entity);
+	bool (*display_on)(struct sh_mobile_lcdc_entity *entity);
 	void (*display_off)(struct sh_mobile_lcdc_entity *entity);
 };
 
-- 
1.7.3.4

