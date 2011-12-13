From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:46 +0000
Subject: [PATCH 51/57] fbdev: sh_mobile_lcdc: Don't store copy of platform data
Message-Id: <1323784972-24205-52-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Instead of copying the whole platform data structure to struct
sh_mobile_lcdc_chan, store a const pointer to the channel platform data.

MERAM configuration information needs to be changed at runtime, so copy
it to struct sh_mobile_lcdc_chan.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   71 ++++++++++++++++++-------------------
 drivers/video/sh_mobile_lcdcfb.h |    3 +-
 include/video/sh_mobile_lcdc.h   |    2 +-
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index c1f1e03..4e9572c 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -116,7 +116,7 @@ static bool banked(int reg_nr)
 
 static int lcdc_chan_is_sublcd(struct sh_mobile_lcdc_chan *chan)
 {
-	return chan->cfg.chan = LCDC_CHAN_SUBLCD;
+	return chan->cfg->chan = LCDC_CHAN_SUBLCD;
 }
 
 static void lcdc_write_chan(struct sh_mobile_lcdc_chan *chan,
@@ -289,7 +289,7 @@ static void sh_mobile_lcdc_deferred_io(struct fb_info *info,
 				       struct list_head *pagelist)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
-	struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg.panel_cfg;
+	const struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg->panel_cfg;
 
 	/* enable clocks before accessing hardware */
 	sh_mobile_lcdc_clk_on(ch->lcdc);
@@ -336,7 +336,7 @@ static void sh_mobile_lcdc_deferred_io_touch(struct fb_info *info)
 
 static void sh_mobile_lcdc_display_on(struct sh_mobile_lcdc_chan *ch)
 {
-	struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg.panel_cfg;
+	const struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg->panel_cfg;
 	int ret;
 
 	if (ch->tx_dev) {
@@ -355,7 +355,7 @@ static void sh_mobile_lcdc_display_on(struct sh_mobile_lcdc_chan *ch)
 
 static void sh_mobile_lcdc_display_off(struct sh_mobile_lcdc_chan *ch)
 {
-	struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg.panel_cfg;
+	const struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg->panel_cfg;
 
 	if (panel->display_off)
 		panel->display_off();
@@ -642,16 +642,16 @@ static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
 	tmp = ch->ldmt1r_value;
 	tmp |= (var->sync & FB_SYNC_VERT_HIGH_ACT) ? 0 : LDMT1R_VPOL;
 	tmp |= (var->sync & FB_SYNC_HOR_HIGH_ACT) ? 0 : LDMT1R_HPOL;
-	tmp |= (ch->cfg.flags & LCDC_FLAGS_DWPOL) ? LDMT1R_DWPOL : 0;
-	tmp |= (ch->cfg.flags & LCDC_FLAGS_DIPOL) ? LDMT1R_DIPOL : 0;
-	tmp |= (ch->cfg.flags & LCDC_FLAGS_DAPOL) ? LDMT1R_DAPOL : 0;
-	tmp |= (ch->cfg.flags & LCDC_FLAGS_HSCNT) ? LDMT1R_HSCNT : 0;
-	tmp |= (ch->cfg.flags & LCDC_FLAGS_DWCNT) ? LDMT1R_DWCNT : 0;
+	tmp |= (ch->cfg->flags & LCDC_FLAGS_DWPOL) ? LDMT1R_DWPOL : 0;
+	tmp |= (ch->cfg->flags & LCDC_FLAGS_DIPOL) ? LDMT1R_DIPOL : 0;
+	tmp |= (ch->cfg->flags & LCDC_FLAGS_DAPOL) ? LDMT1R_DAPOL : 0;
+	tmp |= (ch->cfg->flags & LCDC_FLAGS_HSCNT) ? LDMT1R_HSCNT : 0;
+	tmp |= (ch->cfg->flags & LCDC_FLAGS_DWCNT) ? LDMT1R_DWCNT : 0;
 	lcdc_write_chan(ch, LDMT1R, tmp);
 
 	/* setup SYS bus */
-	lcdc_write_chan(ch, LDMT2R, ch->cfg.sys_bus_cfg.ldmt2r);
-	lcdc_write_chan(ch, LDMT3R, ch->cfg.sys_bus_cfg.ldmt3r);
+	lcdc_write_chan(ch, LDMT2R, ch->cfg->sys_bus_cfg.ldmt2r);
+	lcdc_write_chan(ch, LDMT3R, ch->cfg->sys_bus_cfg.ldmt3r);
 
 	/* horizontal configuration */
 	h_total = mode->xres + mode->hsync_len + mode->left_margin
@@ -715,7 +715,7 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		/* Power supply */
 		lcdc_write_chan(ch, LDPMR, 0);
 
-		m = ch->cfg.clock_divider;
+		m = ch->cfg->clock_divider;
 		if (!m)
 			continue;
 
@@ -766,7 +766,7 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		 * continuous read mode.
 		 */
 		if (ch->ldmt1r_value & LDMT1R_IFM &&
-		    ch->cfg.sys_bus_cfg.deferred_io_msec) {
+		    ch->cfg->sys_bus_cfg.deferred_io_msec) {
 			lcdc_write_chan(ch, LDSM1R, LDSM1R_OS);
 			lcdc_write(priv, _LDINTR, LDINTR_FE);
 		} else {
@@ -820,13 +820,13 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 	lcdc_wait_bit(priv, _LDCNT2R, LDCNT2R_BR, 0);
 
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
-		struct sh_mobile_lcdc_panel_cfg *panel;
+		const struct sh_mobile_lcdc_panel_cfg *panel;
 
 		ch = &priv->ch[k];
 		if (!ch->enabled)
 			continue;
 
-		panel = &ch->cfg.panel_cfg;
+		panel = &ch->cfg->panel_cfg;
 		if (panel->setup_sys) {
 			ret = panel->setup_sys(ch, &sh_mobile_lcdc_sys_bus_ops);
 			if (ret)
@@ -836,7 +836,6 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 	/* Compute frame buffer base address and pitch for each channel. */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
-		struct sh_mobile_meram_cfg *cfg;
 		int pixelformat;
 		void *meram;
 
@@ -848,8 +847,8 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		ch->base_addr_c = ch->base_addr_y + ch->xres * ch->yres_virtual;
 
 		/* Enable MERAM if possible. */
-		cfg = ch->cfg.meram_cfg;
-		if (mdev = NULL || mdev->ops = NULL || cfg = NULL)
+		if (mdev = NULL || mdev->ops = NULL ||
+		    ch->cfg->meram_cfg = NULL)
 			continue;
 
 		/* we need to de-init configured ICBs before we can
@@ -879,8 +878,8 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			break;
 		}
 
-		meram = mdev->ops->meram_register(mdev, cfg, ch->pitch,
-					ch->yres, pixelformat,
+		meram = mdev->ops->meram_register(mdev, ch->cfg->meram_cfg,
+					ch->pitch, ch->yres, pixelformat,
 					ch->base_addr_y, ch->base_addr_c,
 					&ch->base_addr_y, &ch->base_addr_c,
 					&ch->pitch);
@@ -899,7 +898,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		if (!ch->enabled)
 			continue;
 
-		tmp = ch->cfg.sys_bus_cfg.deferred_io_msec;
+		tmp = ch->cfg->sys_bus_cfg.deferred_io_msec;
 		if (ch->ldmt1r_value & LDMT1R_IFM && tmp) {
 			ch->defio.deferred_io = sh_mobile_lcdc_deferred_io;
 			ch->defio.delay = msecs_to_jiffies(tmp);
@@ -1207,8 +1206,8 @@ static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *in
 	 * distance between two modes is defined as the size of the
 	 * non-overlapping parts of the two rectangles.
 	 */
-	for (i = 0; i < ch->cfg.num_modes; ++i) {
-		const struct fb_videomode *mode = &ch->cfg.lcd_modes[i];
+	for (i = 0; i < ch->cfg->num_modes; ++i) {
+		const struct fb_videomode *mode = &ch->cfg->lcd_modes[i];
 		unsigned int dist;
 
 		/* We can only round up. */
@@ -1227,7 +1226,7 @@ static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *in
 	}
 
 	/* If no available mode can be used, return an error. */
-	if (ch->cfg.num_modes != 0) {
+	if (ch->cfg->num_modes != 0) {
 		if (best_dist = (unsigned int)-1)
 			return -EINVAL;
 
@@ -1437,7 +1436,7 @@ sh_mobile_lcdc_channel_fb_register(struct sh_mobile_lcdc_chan *ch)
 		return ret;
 
 	dev_info(ch->lcdc->dev, "registered %s/%s as %dx%d %dbpp.\n",
-		 dev_name(ch->lcdc->dev), (ch->cfg.chan = LCDC_CHAN_MAINLCD) ?
+		 dev_name(ch->lcdc->dev), (ch->cfg->chan = LCDC_CHAN_MAINLCD) ?
 		 "mainlcd" : "sublcd", info->var.xres, info->var.yres,
 		 info->var.bits_per_pixel);
 
@@ -1522,8 +1521,8 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 	 */
 	var = &info->var;
 	fb_videomode_to_var(var, mode);
-	var->width = ch->cfg.panel_cfg.width;
-	var->height = ch->cfg.panel_cfg.height;
+	var->width = ch->cfg->panel_cfg.width;
+	var->height = ch->cfg->panel_cfg.height;
 	var->yres_virtual = var->yres * 2;
 	var->activate = FB_ACTIVATE_NOW;
 
@@ -1555,14 +1554,14 @@ static int sh_mobile_lcdc_update_bl(struct backlight_device *bdev)
 	    bdev->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
 		brightness = 0;
 
-	return ch->cfg.bl_info.set_brightness(brightness);
+	return ch->cfg->bl_info.set_brightness(brightness);
 }
 
 static int sh_mobile_lcdc_get_brightness(struct backlight_device *bdev)
 {
 	struct sh_mobile_lcdc_chan *ch = bl_get_data(bdev);
 
-	return ch->cfg.bl_info.get_brightness();
+	return ch->cfg->bl_info.get_brightness();
 }
 
 static int sh_mobile_lcdc_check_fb(struct backlight_device *bdev,
@@ -1583,7 +1582,7 @@ static struct backlight_device *sh_mobile_lcdc_bl_probe(struct device *parent,
 {
 	struct backlight_device *bl;
 
-	bl = backlight_device_register(ch->cfg.bl_info.name, parent, ch,
+	bl = backlight_device_register(ch->cfg->bl_info.name, parent, ch,
 				       &sh_mobile_lcdc_bl_ops, NULL);
 	if (IS_ERR(bl)) {
 		dev_err(parent, "unable to register backlight device: %ld\n",
@@ -1591,7 +1590,7 @@ static struct backlight_device *sh_mobile_lcdc_bl_probe(struct device *parent,
 		return NULL;
 	}
 
-	bl->props.max_brightness = ch->cfg.bl_info.max_brightness;
+	bl->props.max_brightness = ch->cfg->bl_info.max_brightness;
 	bl->props.brightness = bl->props.max_brightness;
 	backlight_update_status(bl);
 
@@ -1724,7 +1723,7 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 
 		if (ch->tx_dev) {
 			ch->tx_dev->lcdc = NULL;
-			module_put(ch->cfg.tx_dev->dev.driver->owner);
+			module_put(ch->cfg->tx_dev->dev.driver->owner);
 		}
 
 		sh_mobile_lcdc_channel_fb_cleanup(ch);
@@ -1756,7 +1755,7 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 static int __devinit
 sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *ch)
 {
-	int interface_type = ch->cfg.interface_type;
+	int interface_type = ch->cfg->interface_type;
 
 	switch (interface_type) {
 	case RGB8:
@@ -1799,7 +1798,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 			    struct sh_mobile_lcdc_chan *ch)
 {
 	const struct sh_mobile_lcdc_format_info *format;
-	struct sh_mobile_lcdc_chan_cfg *cfg = &ch->cfg;
+	const struct sh_mobile_lcdc_chan_cfg *cfg = ch->cfg;
 	const struct fb_videomode *max_mode;
 	const struct fb_videomode *mode;
 	unsigned int num_modes;
@@ -1942,7 +1941,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		struct sh_mobile_lcdc_chan *ch = priv->ch + num_channels;
 
 		ch->lcdc = priv;
-		memcpy(&ch->cfg, &pdata->ch[i], sizeof(pdata->ch[i]));
+		ch->cfg = &pdata->ch[i];
 
 		error = sh_mobile_lcdc_check_interface(ch);
 		if (error) {
@@ -1954,7 +1953,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		ch->pan_offset = 0;
 
 		/* probe the backlight is there is one defined */
-		if (ch->cfg.bl_info.max_brightness)
+		if (ch->cfg->bl_info.max_brightness)
 			ch->bl = sh_mobile_lcdc_bl_probe(&pdev->dev, ch);
 
 		switch (pdata->ch[i].chan) {
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index bf1707c..da1c26e 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -54,7 +54,7 @@ struct sh_mobile_lcdc_entity {
 struct sh_mobile_lcdc_chan {
 	struct sh_mobile_lcdc_priv *lcdc;
 	struct sh_mobile_lcdc_entity *tx_dev;
-	struct sh_mobile_lcdc_chan_cfg cfg;
+	const struct sh_mobile_lcdc_chan_cfg *cfg;
 
 	unsigned long *reg_offs;
 	unsigned long ldmt1r_value;
@@ -66,6 +66,7 @@ struct sh_mobile_lcdc_chan {
 
 	void *fb_mem;
 	unsigned long fb_size;
+
 	dma_addr_t dma_handle;
 	unsigned long pan_offset;
 
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index 5a6991d..53cbbd4 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -178,7 +178,7 @@ struct sh_mobile_lcdc_chan_cfg {
 	struct sh_mobile_lcdc_panel_cfg panel_cfg;
 	struct sh_mobile_lcdc_bl_info bl_info;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
-	struct sh_mobile_meram_cfg *meram_cfg;
+	const struct sh_mobile_meram_cfg *meram_cfg;
 
 	struct platform_device *tx_dev;	/* HDMI/MIPI transmitter device */
 };
-- 
1.7.3.4

