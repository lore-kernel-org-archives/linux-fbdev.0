From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:28:09 +0000
Subject: [WIP/RFC 31/31] fbdev: sh_mobile_lcdc: Add media controller support
Message-Id: <1316392089-27598-32-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/Kconfig            |    1 +
 drivers/video/sh_mobile_lcdcfb.c |  116 ++++++++++++++++++++++++++++++++++++--
 drivers/video/sh_mobile_lcdcfb.h |    8 +++
 3 files changed, 120 insertions(+), 5 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 549b960..c18e1b8 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1977,6 +1977,7 @@ config FB_SH_MOBILE_LCDC
 	select FB_SYS_FOPS
 	select FB_DEFERRED_IO
 	select FB_BACKLIGHT
+	select MEDIA_CONTROLLER
 	select SH_MIPI_DSI if SH_LCD_MIPI_DSI
 	---help---
 	  Frame buffer driver for the on-chip SH-Mobile LCD controller.
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 19ac3c5..ac8b82d 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -26,6 +26,9 @@
 #include <linux/videodev2.h>
 #include <linux/vmalloc.h>
 
+#include <media/media-device.h>
+#include <media/media-entity.h>
+
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mobile_meram.h>
 
@@ -38,17 +41,22 @@
 #define MAX_YRES 1080
 
 struct sh_mobile_lcdc_priv {
+	struct media_device mdev;
+	struct device *dev;
+	struct sh_mobile_meram_info *meram_dev;
+
 	void __iomem *base;
 	int irq;
-	atomic_t hw_usecnt;
-	struct device *dev;
 	struct clk *dot_clk;
+
+	atomic_t hw_usecnt;
 	unsigned long lddckr;
+
 	struct sh_mobile_lcdc_chan ch[2];
 	struct notifier_block notifier;
+
 	int started;
 	int forced_fourcc; /* 2 channel LCDC must share fourcc setting */
-	struct sh_mobile_meram_info *meram_dev;
 };
 
 /* -----------------------------------------------------------------------------
@@ -1532,6 +1540,84 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 }
 
 /* -----------------------------------------------------------------------------
+ * Media controller init/cleanup
+ */
+
+static int __devinit sh_mobile_lcdc_media_init(struct sh_mobile_lcdc_chan *ch)
+{
+	int ret;
+
+	/* Initialize the panel media entity. */
+	ch->panel.pad.flags = MEDIA_PAD_FL_SINK;
+	ret = media_entity_init(&ch->panel.entity, 1, &ch->panel.pad, 0);
+	if (ret < 0)
+		return ret;
+
+	ch->panel.entity.name = "Panel";
+
+	/* Create links. */
+	if (ch->tx_dev) {
+		ret = media_entity_create_link(&ch->info->entity, 0,
+					       &ch->tx_dev->entity, 0,
+					       MEDIA_LNK_FL_IMMUTABLE |
+					       MEDIA_LNK_FL_ENABLED);
+		if (ret < 0)
+			return ret;
+
+		ret = media_entity_create_link(&ch->tx_dev->entity, 1,
+					       &ch->panel.entity, 0,
+					       MEDIA_LNK_FL_IMMUTABLE |
+					       MEDIA_LNK_FL_ENABLED);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = media_entity_create_link(&ch->info->entity, 0,
+					       &ch->panel.entity, 0,
+					       MEDIA_LNK_FL_IMMUTABLE |
+					       MEDIA_LNK_FL_ENABLED);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int __devinit
+sh_mobile_lcdc_media_register(struct sh_mobile_lcdc_priv *priv)
+{
+	unsigned int i;
+	int ret;
+
+	priv->mdev.dev = priv->dev;
+	strlcpy(priv->mdev.model, "SH Mobile LCDC", sizeof(priv->mdev.model));
+
+	ret = media_device_register(&priv->mdev);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(priv->ch); i++) {
+		struct sh_mobile_lcdc_chan *ch = &priv->ch[i];
+
+		if (ch->info = NULL)
+			continue;
+
+		if (ch->tx_dev) {
+			ret = media_device_register_entity(&priv->mdev,
+							   &ch->tx_dev->entity);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = media_device_register_entity(&priv->mdev,
+						   &ch->panel.entity);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* -----------------------------------------------------------------------------
  * Probe/remove and driver init/exit
  */
 
@@ -1587,6 +1673,9 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 					  info->screen_base, ch->dma_handle);
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
+
+		media_device_unregister_entity(&ch->panel.entity);
+		media_entity_cleanup(&ch->panel.entity);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(priv->ch); i++) {
@@ -1651,8 +1740,9 @@ sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *ch)
 
 static int __devinit
 sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
-			    struct sh_mobile_lcdc_chan *ch)
+			    struct sh_mobile_lcdc_chan *ch, unsigned int index)
 {
+	struct platform_device *pdev = to_platform_device(priv->dev);
 	struct sh_mobile_lcdc_chan_cfg *cfg = &ch->cfg;
 	const struct fb_videomode *max_mode;
 	const struct fb_videomode *mode;
@@ -1679,6 +1769,8 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	info->par = ch;
 	info->pseudo_palette = &ch->pseudo_palette;
 	info->flags = FBINFO_FLAG_DEFAULT;
+	snprintf(info->name, sizeof(info->name), "LCDC %u channel %u", pdev->id,
+		 index);
 
 	if (cfg->tx_dev) {
 		if (!cfg->tx_dev->dev.driver ||
@@ -1691,6 +1783,12 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 		ch->tx_dev->lcdc = ch;
 	}
 
+	ret = sh_mobile_lcdc_media_init(ch);
+	if (ret < 0) {
+		dev_err(priv->dev, "unable to initialize media entities\n");
+		return ret;
+	}
+
 	/* Iterate through the modes to validate them and find the highest
 	 * resolution.
 	 */
@@ -1907,11 +2005,18 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 	for (i = 0; i < num_channels; i++) {
 		struct sh_mobile_lcdc_chan *ch = priv->ch + i;
 
-		error = sh_mobile_lcdc_channel_init(priv, ch);
+		error = sh_mobile_lcdc_channel_init(priv, ch, i);
 		if (error)
 			goto err1;
 	}
 
+	error = sh_mobile_lcdc_media_register(priv);
+	if (error) {
+		dev_err(&pdev->dev, "media device registration failed (%d)\n",
+			error);
+		goto err1;
+	}
+
 	error = sh_mobile_lcdc_start(priv);
 	if (error) {
 		dev_err(&pdev->dev, "unable to start hardware\n");
@@ -1931,6 +2036,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			}
 		}
 
+		info->mdev = &priv->mdev;
 		info->bl_dev = ch->bl;
 
 		error = register_framebuffer(info);
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index fa60d00..98ed5f4 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -79,6 +79,14 @@ struct sh_mobile_lcdc_chan {
 	int (*notify)(struct sh_mobile_lcdc_chan *ch,
 		      enum sh_mobile_lcdc_entity_event event,
 		      struct fb_var_screeninfo *var);
+
+	struct media_pad pad;
+	struct media_entity entity;
+
+	struct {
+		struct media_pad pad;
+		struct media_entity entity;
+	} panel;
 };
 
 #endif
-- 
1.7.3.4

