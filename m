From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:24 +0000
Subject: [PATCH 29/57] fbdev: sh_mobile_hdmi: Don't access LCDC fb_info
Message-Id: <1323784972-24205-30-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The LCDC fb_info structure is only used to retrieve the default video
mode in case none of the modes advertised by EDID information is
acceptable. Pass a pointer to the default mode through the
sh_mobile_lcdc_entity structure instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_hdmi.c   |   34 ++++++++++++++--------------------
 drivers/video/sh_mobile_lcdcfb.c |   24 +++++++++++++-----------
 drivers/video/sh_mobile_lcdcfb.h |    1 +
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 37f935f..eafb19d 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -734,12 +734,11 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi, unsigned long *hdmi_rate,
 			     unsigned long *parent_rate)
 {
 	struct sh_mobile_lcdc_chan *ch = hdmi->entity.lcdc;
-	struct fb_info *info = ch ? ch->info : NULL;
 	const struct fb_videomode *mode, *found = NULL;
-	const struct fb_modelist *modelist = NULL;
 	unsigned int f_width = 0, f_height = 0, f_refresh = 0;
 	unsigned long found_rate_error = ULONG_MAX; /* silly compiler... */
 	bool scanning = false, preferred_bad = false;
+	bool use_edid_mode = false;
 	u8 edid[128];
 	char *forced;
 	int i;
@@ -864,25 +863,19 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi, unsigned long *hdmi_rate,
 
 		found = mode;
 		found_rate_error = rate_error;
+		use_edid_mode = true;
 	}
 
 	/*
-	 * TODO 1: if no ->info is present, postpone running the config until
-	 * after ->info first gets registered.
+	 * TODO 1: if no default mode is present, postpone running the config
+	 * until after the LCDC channel is initialized.
 	 * TODO 2: consider registering the HDMI platform device from the LCDC
-	 * driver, and passing ->info with HDMI platform data.
+	 * driver.
 	 */
-	if (info && !found) {
-		modelist = info->modelist.next &&
-			!list_empty(&info->modelist) ?
-			list_entry(info->modelist.next,
-				   struct fb_modelist, list) :
-			NULL;
-
-		if (modelist) {
-			found = &modelist->mode;
-			found_rate_error = sh_hdmi_rate_error(hdmi, found, hdmi_rate, parent_rate);
-		}
+	if (!found && hdmi->entity.def_mode.xres != 0) {
+		found = &hdmi->entity.def_mode;
+		found_rate_error = sh_hdmi_rate_error(hdmi, found, hdmi_rate,
+						      parent_rate);
 	}
 
 	/* No cookie today */
@@ -906,10 +899,11 @@ static int sh_hdmi_read_edid(struct sh_hdmi *hdmi, unsigned long *hdmi_rate,
 	else
 		hdmi->preprogrammed_vic = 0;
 
-	dev_dbg(hdmi->dev, "Using %s %s mode %ux%u@%uHz (%luHz), clock error %luHz\n",
-		modelist ? "default" : "EDID", hdmi->preprogrammed_vic ? "VIC" : "external",
-		found->xres, found->yres, found->refresh,
-		PICOS2KHZ(found->pixclock) * 1000, found_rate_error);
+	dev_dbg(hdmi->dev, "Using %s %s mode %ux%u@%uHz (%luHz), "
+		"clock error %luHz\n", use_edid_mode ? "EDID" : "default",
+		hdmi->preprogrammed_vic ? "VIC" : "external", found->xres,
+		found->yres, found->refresh, PICOS2KHZ(found->pixclock) * 1000,
+		found_rate_error);
 
 	hdmi->mode = *found;
 	sh_hdmi_external_video_param(hdmi);
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 4ec216e..c5acae7 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1690,17 +1690,6 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	info->pseudo_palette = &ch->pseudo_palette;
 	info->flags = FBINFO_FLAG_DEFAULT;
 
-	if (cfg->tx_dev) {
-		if (!cfg->tx_dev->dev.driver ||
-		    !try_module_get(cfg->tx_dev->dev.driver->owner)) {
-			dev_warn(priv->dev, "unable to get transmitter "
-				 "device\n");
-			return -EINVAL;
-		}
-		ch->tx_dev = platform_get_drvdata(cfg->tx_dev);
-		ch->tx_dev->lcdc = ch;
-	}
-
 	/* Iterate through the modes to validate them and find the highest
 	 * resolution.
 	 */
@@ -1741,6 +1730,19 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 
 	fb_videomode_to_modelist(mode, num_cfg, &info->modelist);
 
+	/* Initialize the transmitter device if present. */
+	if (cfg->tx_dev) {
+		if (!cfg->tx_dev->dev.driver ||
+		    !try_module_get(cfg->tx_dev->dev.driver->owner)) {
+			dev_warn(priv->dev, "unable to get transmitter "
+				 "device\n");
+			return -EINVAL;
+		}
+		ch->tx_dev = platform_get_drvdata(cfg->tx_dev);
+		ch->tx_dev->lcdc = ch;
+		ch->tx_dev->def_mode = *mode;
+	}
+
 	/* Initialize variable screen information using the first mode as
 	 * default. The default Y virtual resolution is twice the panel size to
 	 * allow for double-buffering.
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 10086ae..9c91fae 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -40,6 +40,7 @@ struct sh_mobile_lcdc_entity {
 	struct module *owner;
 	const struct sh_mobile_lcdc_entity_ops *ops;
 	struct sh_mobile_lcdc_chan *lcdc;
+	struct fb_videomode def_mode;
 };
 
 /*
-- 
1.7.3.4

