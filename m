From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:19 +0000
Subject: [PATCH 24/57] fbdev: sh_mobile_lcdc: Return display connection state in display_on
Message-Id: <1323784972-24205-25-git-send-email-laurent.pinchart@ideasonboard.com>
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
 drivers/video/sh_mipi_dsi.c      |    2 +-
 drivers/video/sh_mobile_hdmi.c   |    9 +++++----
 drivers/video/sh_mobile_lcdcfb.c |    3 +++
 drivers/video/sh_mobile_lcdcfb.h |    3 +++
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 1ede247..5ff3742 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -412,7 +412,7 @@ static int mipi_display_on(struct sh_mobile_lcdc_entity *entity)
 
 	sh_mipi_dsi_enable(mipi, true);
 
-	return 0;
+	return SH_MOBILE_LCDC_DISPLAY_CONNECTED;
 
 mipi_display_on_fail1:
 	pm_runtime_put_sync(&mipi->pdev->dev);
diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index c22e123..1464abf 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1004,9 +1004,9 @@ static int sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity)
 {
 	struct sh_hdmi *hdmi = entity_to_sh_hdmi(entity);
 	struct sh_mobile_lcdc_chan *ch = entity->lcdc;
-	struct fb_info *info = ch->info;
 
-	dev_dbg(hdmi->dev, "%s(%p): state %x\n", __func__, hdmi, info->state);
+	dev_dbg(hdmi->dev, "%s(%p): state %x\n", __func__, hdmi,
+		hdmi->hp_state);
 
 	/*
 	 * hp_state can be set to
@@ -1021,12 +1021,13 @@ static int sh_hdmi_display_on(struct sh_mobile_lcdc_entity *entity)
 		dev_dbg(hdmi->dev, "HDMI running\n");
 		break;
 	case HDMI_HOTPLUG_DISCONNECTED:
-		info->state = FBINFO_STATE_SUSPENDED;
 	default:
 		hdmi->var = ch->display_var;
 	}
 
-	return 0;
+	return hdmi->hp_state = HDMI_HOTPLUG_DISCONNECTED
+		? SH_MOBILE_LCDC_DISPLAY_DISCONNECTED
+		: SH_MOBILE_LCDC_DISPLAY_CONNECTED;
 }
 
 static void sh_hdmi_display_off(struct sh_mobile_lcdc_entity *entity)
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 47108aa..4b03aa5 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -342,6 +342,9 @@ static void sh_mobile_lcdc_display_on(struct sh_mobile_lcdc_chan *ch)
 		ret = ch->tx_dev->ops->display_on(ch->tx_dev);
 		if (ret < 0)
 			return;
+
+		if (ret = SH_MOBILE_LCDC_DISPLAY_DISCONNECTED)
+			ch->info->state = FBINFO_STATE_SUSPENDED;
 	}
 
 	/* HDMI must be enabled before LCDC configuration */
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index b2cb8e6..6fb956c 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -21,6 +21,9 @@ struct sh_mobile_lcdc_entity;
 struct sh_mobile_lcdc_priv;
 struct sh_mobile_lcdc_chan;
 
+#define SH_MOBILE_LCDC_DISPLAY_DISCONNECTED	0
+#define SH_MOBILE_LCDC_DISPLAY_CONNECTED	1
+
 struct sh_mobile_lcdc_entity_ops {
 	/* Display */
 	int (*display_on)(struct sh_mobile_lcdc_entity *entity);
-- 
1.7.3.4

