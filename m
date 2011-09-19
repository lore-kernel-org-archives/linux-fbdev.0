From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:27:57 +0000
Subject: [WIP/RFC 19/31] fbdev: sh_mobile_lcdc: Merge board_cfg and lcd_size_cfg into panel_cfg
Message-Id: <1316392089-27598-20-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Update board code accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c   |    6 ++--
 arch/arm/mach-shmobile/board-ap4evb.c   |    8 +++---
 arch/arm/mach-shmobile/board-mackerel.c |    6 +++-
 arch/sh/boards/mach-ap325rxa/setup.c    |    6 +---
 arch/sh/boards/mach-ecovec24/setup.c    |    2 +-
 arch/sh/boards/mach-kfr2r09/setup.c     |    4 +--
 arch/sh/boards/mach-migor/setup.c       |    8 ++----
 arch/sh/boards/mach-se/7724/setup.c     |    2 +-
 drivers/video/sh_mobile_lcdcfb.c        |   35 +++++++++++++++----------------
 include/video/sh_mobile_lcdc.h          |   12 +++-------
 10 files changed, 40 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 139fbd1..c8b57a7 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -258,12 +258,12 @@ static struct sh_mobile_lcdc_info lcdc0_info = {
 		.interface_type = RGB24,
 		.clock_divider = 1,
 		.flags = LCDC_FLAGS_DWPOL,
-		.lcd_size_cfg.width = 44,
-		.lcd_size_cfg.height = 79,
 		.fourcc = V4L2_PIX_FMT_RGB565,
 		.lcd_cfg = lcdc0_modes,
 		.num_cfg = ARRAY_SIZE(lcdc0_modes),
-		.board_cfg = {
+		.panel_cfg = {
+			.width = 44,
+			.height = 79,
 			.display_on = lcd_backlight_on,
 			.display_off = lcd_backlight_reset,
 		},
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 851e1ac..f8d0b4d 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1326,8 +1326,8 @@ static void __init ap4evb_init(void)
 	lcdc_info.ch[0].interface_type		= RGB24;
 	lcdc_info.ch[0].clock_divider		= 1;
 	lcdc_info.ch[0].flags			= LCDC_FLAGS_DWPOL;
-	lcdc_info.ch[0].lcd_size_cfg.width	= 44;
-	lcdc_info.ch[0].lcd_size_cfg.height	= 79;
+	lcdc_info.ch[0].panel_cfg.width		= 44;
+	lcdc_info.ch[0].panel_cfg.height	= 79;
 
 	platform_add_devices(qhd_devices, ARRAY_SIZE(qhd_devices));
 
@@ -1368,8 +1368,8 @@ static void __init ap4evb_init(void)
 	lcdc_info.ch[0].interface_type		= RGB18;
 	lcdc_info.ch[0].clock_divider		= 3;
 	lcdc_info.ch[0].flags			= 0;
-	lcdc_info.ch[0].lcd_size_cfg.width	= 152;
-	lcdc_info.ch[0].lcd_size_cfg.height	= 91;
+	lcdc_info.ch[0].panel_cfg.width		= 152;
+	lcdc_info.ch[0].panel_cfg.height	= 91;
 
 	/* enable TouchScreen */
 	irq_set_irq_type(IRQ7, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index ecd1982..1bdcf61 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -393,8 +393,10 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.interface_type		= RGB24,
 		.clock_divider		= 3,
 		.flags			= 0,
-		.lcd_size_cfg.width	= 152,
-		.lcd_size_cfg.height	= 91,
+		.panel_cfg = {
+			.width		= 152,
+			.height		= 91,
+		},
 		.bl_info = {
 			.name = "sh_mobile_lcdc_bl",
 			.max_brightness = 1,
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 315d79a..4d1df51 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -212,11 +212,9 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.clock_divider = 1,
 		.lcd_cfg = ap325rxa_lcdc_modes,
 		.num_cfg = ARRAY_SIZE(ap325rxa_lcdc_modes),
-		.lcd_size_cfg = { /* 7.0 inch */
-			.width = 152,
+		.panel_cfg = {
+			.width = 152,	/* 7.0 inch */
 			.height = 91,
-		},
-		.board_cfg = {
 			.display_on = ap320_wvga_power_on,
 			.display_off = ap320_wvga_power_off,
 		},
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index b957b54..3f3f2ec 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -327,7 +327,7 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.interface_type = RGB18,
 		.chan = LCDC_CHAN_MAINLCD,
 		.fourcc = V4L2_PIX_FMT_RGB565,
-		.lcd_size_cfg = { /* 7.0 inch */
+		.panel_cfg = { /* 7.0 inch */
 			.width = 152,
 			.height = 91,
 		},
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 208c9b0..615cb4b 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -152,11 +152,9 @@ static struct sh_mobile_lcdc_info kfr2r09_sh_lcdc_info = {
 		.flags = LCDC_FLAGS_DWPOL,
 		.lcd_cfg = kfr2r09_lcdc_modes,
 		.num_cfg = ARRAY_SIZE(kfr2r09_lcdc_modes),
-		.lcd_size_cfg = {
+		.panel_cfg = {
 			.width = 35,
 			.height = 58,
-		},
-		.board_cfg = {
 			.setup_sys = kfr2r09_lcd_setup,
 			.start_transfer = kfr2r09_lcd_start,
 			.display_on = kfr2r09_lcd_on,
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 69f8d7d..b052946 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -249,7 +249,7 @@ static struct sh_mobile_lcdc_info sh_mobile_lcdc_info = {
 		.clock_divider = 2,
 		.lcd_cfg = migor_lcd_modes,
 		.num_cfg = ARRAY_SIZE(migor_lcd_modes),
-		.lcd_size_cfg = { /* 7.0 inch */
+		.panel_cfg = { /* 7.0 inch */
 			.width = 152,
 			.height = 91,
 		},
@@ -263,11 +263,9 @@ static struct sh_mobile_lcdc_info sh_mobile_lcdc_info = {
 		.clock_divider = 10,
 		.lcd_cfg = migor_lcd_modes,
 		.num_cfg = ARRAY_SIZE(migor_lcd_modes),
-		.lcd_size_cfg = { /* 2.4 inch */
-			.width = 49,
+		.panel_cfg = {
+			.width = 49,	/* 2.4 inch */
 			.height = 37,
-		},
-		.board_cfg = {
 			.setup_sys = migor_lcd_qvga_setup,
 		},
 		.sys_bus_cfg = {
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 334b463..56e7361 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -181,7 +181,7 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.fourcc = V4L2_PIX_FMT_RGB565,
 		.clock_divider = 1,
-		.lcd_size_cfg = { /* 7.0 inch */
+		.panel_cfg = { /* 7.0 inch */
 			.width = 152,
 			.height = 91,
 		},
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index a490c7a..eff475d 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -288,7 +288,7 @@ static void sh_mobile_lcdc_deferred_io(struct fb_info *info,
 				       struct list_head *pagelist)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
-	struct sh_mobile_lcdc_board_cfg	*bcfg = &ch->cfg.board_cfg;
+	struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg.panel_cfg;
 
 	/* enable clocks before accessing hardware */
 	sh_mobile_lcdc_clk_on(ch->lcdc);
@@ -313,13 +313,13 @@ static void sh_mobile_lcdc_deferred_io(struct fb_info *info,
 
 		/* trigger panel update */
 		dma_map_sg(info->dev, ch->sglist, nr_pages, DMA_TO_DEVICE);
-		if (bcfg->start_transfer)
-			bcfg->start_transfer(ch, &sh_mobile_lcdc_sys_bus_ops);
+		if (panel->start_transfer)
+			panel->start_transfer(ch, &sh_mobile_lcdc_sys_bus_ops);
 		lcdc_write_chan(ch, LDSM2R, LDSM2R_OSTRG);
 		dma_unmap_sg(info->dev, ch->sglist, nr_pages, DMA_TO_DEVICE);
 	} else {
-		if (bcfg->start_transfer)
-			bcfg->start_transfer(ch, &sh_mobile_lcdc_sys_bus_ops);
+		if (panel->start_transfer)
+			panel->start_transfer(ch, &sh_mobile_lcdc_sys_bus_ops);
 		lcdc_write_chan(ch, LDSM2R, LDSM2R_OSTRG);
 	}
 }
@@ -334,22 +334,22 @@ static void sh_mobile_lcdc_deferred_io_touch(struct fb_info *info)
 
 static void sh_mobile_lcdc_display_on(struct sh_mobile_lcdc_chan *ch)
 {
-	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
+	struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg.panel_cfg;
 
 	if (ch->tx_dev)
 		ch->tx_dev->ops->display_on(ch->tx_dev, ch->info);
 
 	/* HDMI must be enabled before LCDC configuration */
-	if (board_cfg->display_on)
-		board_cfg->display_on();
+	if (panel->display_on)
+		panel->display_on();
 }
 
 static void sh_mobile_lcdc_display_off(struct sh_mobile_lcdc_chan *ch)
 {
-	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
+	struct sh_mobile_lcdc_panel_cfg *panel = &ch->cfg.panel_cfg;
 
-	if (board_cfg->display_off)
-		board_cfg->display_off();
+	if (panel->display_off)
+		panel->display_off();
 
 	if (ch->tx_dev)
 		ch->tx_dev->ops->display_off(ch->tx_dev);
@@ -679,16 +679,15 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 	lcdc_wait_bit(priv, _LDCNT2R, LDCNT2R_BR, 0);
 
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
-		struct sh_mobile_lcdc_board_cfg	*board_cfg;
+		struct sh_mobile_lcdc_panel_cfg *panel;
 
 		ch = &priv->ch[k];
 		if (!ch->enabled)
 			continue;
 
-		board_cfg = &ch->cfg.board_cfg;
-		if (board_cfg->setup_sys) {
-			ret = board_cfg->setup_sys(ch,
-						   &sh_mobile_lcdc_sys_bus_ops);
+		panel = &ch->cfg.panel_cfg;
+		if (panel->setup_sys) {
+			ret = panel->setup_sys(ch, &sh_mobile_lcdc_sys_bus_ops);
 			if (ret)
 				return ret;
 		}
@@ -1654,8 +1653,8 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 	 */
 	var = &info->var;
 	fb_videomode_to_var(var, mode);
-	var->width = cfg->lcd_size_cfg.width;
-	var->height = cfg->lcd_size_cfg.height;
+	var->width = cfg->panel_cfg.width;
+	var->height = cfg->panel_cfg.height;
 	var->yres_virtual = var->yres * 2;
 	var->activate = FB_ACTIVATE_NOW;
 
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index 541b2b3..84163e4 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -147,7 +147,9 @@ struct sh_mobile_lcdc_sys_bus_ops {
 	unsigned long (*read_data)(void *handle);
 };
 
-struct sh_mobile_lcdc_board_cfg {
+struct sh_mobile_lcdc_panel_cfg {
+	unsigned long width;		/* Panel width in mm */
+	unsigned long height;		/* Panel height in mm */
 	int (*setup_sys)(void *sys_ops_handle,
 			 struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 	void (*start_transfer)(void *sys_ops_handle,
@@ -156,11 +158,6 @@ struct sh_mobile_lcdc_board_cfg {
 	void (*display_off)(void);
 };
 
-struct sh_mobile_lcdc_lcd_size_cfg { /* width and height of panel in mm */
-	unsigned long width;
-	unsigned long height;
-};
-
 /* backlight info */
 struct sh_mobile_lcdc_bl_info {
 	const char *name;
@@ -178,8 +175,7 @@ struct sh_mobile_lcdc_chan_cfg {
 	unsigned long flags; /* LCDC_FLAGS_... */
 	const struct fb_videomode *lcd_cfg;
 	int num_cfg;
-	struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
-	struct sh_mobile_lcdc_board_cfg board_cfg;
+	struct sh_mobile_lcdc_panel_cfg panel_cfg;
 	struct sh_mobile_lcdc_bl_info bl_info;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
 	struct sh_mobile_meram_cfg *meram_cfg;
-- 
1.7.3.4

