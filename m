From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:16 +0000
Subject: [PATCH 21/57] sh_mobile_lcdc: Add an lcdc channel pointer to sh_mobile_lcdc_entity
Message-Id: <1323784972-24205-22-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The field will be used by the transmitter drivers to access
sh_mobile_lcdc_chan fields such as fb_info.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    5 ++++-
 drivers/video/sh_mobile_lcdcfb.h |    2 ++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index cb5ea3c..2dccfde 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1497,8 +1497,10 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 		if (!info || !info->device)
 			continue;
 
-		if (ch->tx_dev)
+		if (ch->tx_dev) {
+			ch->tx_dev->lcdc = NULL;
 			module_put(ch->cfg.tx_dev->dev.driver->owner);
+		}
 
 		if (ch->sglist)
 			vfree(ch->sglist);
@@ -1608,6 +1610,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 			return -EINVAL;
 		}
 		ch->tx_dev = platform_get_drvdata(cfg->tx_dev);
+		ch->tx_dev->lcdc = ch;
 	}
 
 	/* Iterate through the modes to validate them and find the highest
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 9601b92..36cd564 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -19,6 +19,7 @@ struct fb_info;
 struct module;
 struct sh_mobile_lcdc_entity;
 struct sh_mobile_lcdc_priv;
+struct sh_mobile_lcdc_chan;
 
 struct sh_mobile_lcdc_entity_ops {
 	/* Display */
@@ -30,6 +31,7 @@ struct sh_mobile_lcdc_entity_ops {
 struct sh_mobile_lcdc_entity {
 	struct module *owner;
 	const struct sh_mobile_lcdc_entity_ops *ops;
+	struct sh_mobile_lcdc_chan *lcdc;
 };
 
 /*
-- 
1.7.3.4

