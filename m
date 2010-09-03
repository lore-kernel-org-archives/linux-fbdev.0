From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:20:04 +0000
Subject: [PATCH 05/15] fbdev: sh_mobile_lcdcfb: Support multiple video modes
Message-Id: <Pine.LNX.4.64.1009030912230.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is a preparation for HDMI hotplug support. This patch just moves all
platform defined video modes for the sh_mobile_lcdcfb driver to separate
arrays and switches all users to use element 0 of that array, so, this patch
doesn't introduce any functional changes and as such should not cause any
regressions.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   98 +++++++++++++++++++--------------
 arch/sh/boards/mach-ap325rxa/setup.c  |   29 ++++++----
 arch/sh/boards/mach-ecovec24/setup.c  |   60 ++++++++++++--------
 arch/sh/boards/mach-kfr2r09/setup.c   |   29 ++++++----
 arch/sh/boards/mach-migor/setup.c     |   58 ++++++++++---------
 arch/sh/boards/mach-se/7724/setup.c   |   54 +++++++++++-------
 drivers/video/sh_mipi_dsi.c           |   32 ++++++-----
 drivers/video/sh_mobile_hdmi.c        |    3 +-
 drivers/video/sh_mobile_lcdcfb.c      |   10 ++--
 include/video/sh_mobile_lcdc.h        |    3 +-
 10 files changed, 219 insertions(+), 157 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 95935c8..0a7bab2 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -375,10 +375,40 @@ static struct platform_device usb1_host_device = {
 	.resource	= usb1_host_resources,
 };
 
+const static struct fb_videomode ap4evb_lcdc_modes[] = {
+	{
+#ifdef CONFIG_AP4EVB_QHD
+		.name		= "R63302(QHD)",
+		.xres		= 544,
+		.yres		= 961,
+		.left_margin	= 72,
+		.right_margin	= 600,
+		.hsync_len	= 16,
+		.upper_margin	= 8,
+		.lower_margin	= 8,
+		.vsync_len	= 2,
+		.sync		= FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
+#else
+		.name		= "WVGA Panel",
+		.xres		= 800,
+		.yres		= 480,
+		.left_margin	= 220,
+		.right_margin	= 110,
+		.hsync_len	= 70,
+		.upper_margin	= 20,
+		.lower_margin	= 5,
+		.vsync_len	= 5,
+		.sync		= 0,
+#endif
+	},
+};
+
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
+		.lcd_cfg = ap4evb_lcdc_modes,
+		.num_cfg = ARRAY_SIZE(ap4evb_lcdc_modes),
 	}
 };
 
@@ -569,6 +599,31 @@ static struct platform_device fsi_device = {
 	},
 };
 
+const static struct fb_videomode ap4evb_hdmi_modes[] = {
+	{
+		.name = "HDMI 720p",
+		.xres = 1280,
+		.yres = 720,
+
+		/*
+		 * If left and right margins are not multiples of 8,
+		 * LDHAJR will be adjusted accordingly by the LCDC
+		 * driver. Until we start using EDID, these values
+		 * might have to be adjusted for different monitors.
+		 */
+		.left_margin = 200,
+		.right_margin = 88,
+		.hsync_len = 48,
+
+		.upper_margin = 20,
+		.lower_margin = 5,
+		.vsync_len = 5,
+
+		.pixclock = 13468,
+		.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
+	},
+};
+
 static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
 	.clock_source = LCDC_CLK_EXTERNAL,
 	.ch[0] = {
@@ -577,26 +632,8 @@ static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
 		.interface_type = RGB24,
 		.clock_divider = 1,
 		.flags = LCDC_FLAGS_DWPOL,
-		.lcd_cfg = {
-			.name = "HDMI",
-			/* So far only 720p is supported */
-			.xres = 1280,
-			.yres = 720,
-			/*
-			 * If left and right margins are not multiples of 8,
-			 * LDHAJR will be adjusted accordingly by the LCDC
-			 * driver. Until we start using EDID, these values
-			 * might have to be adjusted for different monitors.
-			 */
-			.left_margin = 200,
-			.right_margin = 88,
-			.hsync_len = 48,
-			.upper_margin = 20,
-			.lower_margin = 5,
-			.vsync_len = 5,
-			.pixclock = 13468,
-			.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
-		},
+		.lcd_cfg = ap4evb_hdmi_modes,
+		.num_cfg = ARRAY_SIZE(ap4evb_hdmi_modes),
 	}
 };
 
@@ -1004,17 +1041,6 @@ static void __init ap4evb_init(void)
 	lcdc_info.ch[0].interface_type		= RGB24;
 	lcdc_info.ch[0].clock_divider		= 1;
 	lcdc_info.ch[0].flags			= LCDC_FLAGS_DWPOL;
-	lcdc_info.ch[0].lcd_cfg.name		= "R63302(QHD)";
-	lcdc_info.ch[0].lcd_cfg.xres		= 544;
-	lcdc_info.ch[0].lcd_cfg.yres		= 961;
-	lcdc_info.ch[0].lcd_cfg.left_margin	= 72;
-	lcdc_info.ch[0].lcd_cfg.right_margin	= 600;
-	lcdc_info.ch[0].lcd_cfg.hsync_len	= 16;
-	lcdc_info.ch[0].lcd_cfg.upper_margin	= 8;
-	lcdc_info.ch[0].lcd_cfg.lower_margin	= 8;
-	lcdc_info.ch[0].lcd_cfg.vsync_len	= 2;
-	lcdc_info.ch[0].lcd_cfg.sync		= FB_SYNC_VERT_HIGH_ACT |
-						  FB_SYNC_HOR_HIGH_ACT;
 	lcdc_info.ch[0].lcd_size_cfg.width	= 44;
 	lcdc_info.ch[0].lcd_size_cfg.height	= 79;
 
@@ -1055,16 +1081,6 @@ static void __init ap4evb_init(void)
 	lcdc_info.ch[0].interface_type		= RGB18;
 	lcdc_info.ch[0].clock_divider		= 2;
 	lcdc_info.ch[0].flags			= 0;
-	lcdc_info.ch[0].lcd_cfg.name		= "WVGA Panel";
-	lcdc_info.ch[0].lcd_cfg.xres		= 800;
-	lcdc_info.ch[0].lcd_cfg.yres		= 480;
-	lcdc_info.ch[0].lcd_cfg.left_margin	= 220;
-	lcdc_info.ch[0].lcd_cfg.right_margin	= 110;
-	lcdc_info.ch[0].lcd_cfg.hsync_len	= 70;
-	lcdc_info.ch[0].lcd_cfg.upper_margin	= 20;
-	lcdc_info.ch[0].lcd_cfg.lower_margin	= 5;
-	lcdc_info.ch[0].lcd_cfg.vsync_len	= 5;
-	lcdc_info.ch[0].lcd_cfg.sync		= 0;
 	lcdc_info.ch[0].lcd_size_cfg.width	= 152;
 	lcdc_info.ch[0].lcd_size_cfg.height	= 91;
 
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 3da116f..0055323 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -176,6 +176,21 @@ static void ap320_wvga_power_off(void *board_data)
 	__raw_writew(0, FPGA_LCDREG);
 }
 
+const static struct fb_videomode ap325rxa_lcdc_modes[] = {
+	{
+		.name = "LB070WV1",
+		.xres = 800,
+		.yres = 480,
+		.left_margin = 32,
+		.right_margin = 160,
+		.hsync_len = 8,
+		.upper_margin = 63,
+		.lower_margin = 80,
+		.vsync_len = 1,
+		.sync = 0, /* hsync and vsync are active low */
+	},
+};
+
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.clock_source = LCDC_CLK_EXTERNAL,
 	.ch[0] = {
@@ -183,18 +198,8 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.bpp = 16,
 		.interface_type = RGB18,
 		.clock_divider = 1,
-		.lcd_cfg = {
-			.name = "LB070WV1",
-			.xres = 800,
-			.yres = 480,
-			.left_margin = 32,
-			.right_margin = 160,
-			.hsync_len = 8,
-			.upper_margin = 63,
-			.lower_margin = 80,
-			.vsync_len = 1,
-			.sync = 0, /* hsync and vsync are active low */
-		},
+		.lcd_cfg = ap325rxa_lcdc_modes,
+		.num_cfg = ARRAY_SIZE(ap325rxa_lcdc_modes),
 		.lcd_size_cfg = { /* 7.0 inch */
 			.width = 152,
 			.height = 91,
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 1d7b495..feadf5d 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -231,14 +231,41 @@ static struct platform_device usb1_common_device = {
 };
 
 /* LCDC */
+const static struct fb_videomode ecovec_lcd_modes[] = {
+	{
+		.name		= "Panel",
+		.xres		= 800,
+		.yres		= 480,
+		.left_margin	= 220,
+		.right_margin	= 110,
+		.hsync_len	= 70,
+		.upper_margin	= 20,
+		.lower_margin	= 5,
+		.vsync_len	= 5,
+		.sync		= 0, /* hsync and vsync are active low */
+	},
+};
+
+const static struct fb_videomode ecovec_dvi_modes[] = {
+	{
+		.name		= "DVI",
+		.xres		= 1280,
+		.yres		= 720,
+		.left_margin	= 220,
+		.right_margin	= 110,
+		.hsync_len	= 40,
+		.upper_margin	= 20,
+		.lower_margin	= 5,
+		.vsync_len	= 5,
+		.sync = 0, /* hsync and vsync are active low */
+	},
+};
+
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.ch[0] = {
 		.interface_type = RGB18,
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
-		.lcd_cfg = {
-			.sync = 0, /* hsync and vsync are active low */
-		},
 		.lcd_size_cfg = { /* 7.0 inch */
 			.width = 152,
 			.height = 91,
@@ -1079,33 +1106,18 @@ static int __init arch_setup(void)
 	if (gpio_get_value(GPIO_PTE6)) {
 		/* DVI */
 		lcdc_info.clock_source			= LCDC_CLK_EXTERNAL;
-		lcdc_info.ch[0].clock_divider		= 1,
-		lcdc_info.ch[0].lcd_cfg.name		= "DVI";
-		lcdc_info.ch[0].lcd_cfg.xres		= 1280;
-		lcdc_info.ch[0].lcd_cfg.yres		= 720;
-		lcdc_info.ch[0].lcd_cfg.left_margin	= 220;
-		lcdc_info.ch[0].lcd_cfg.right_margin	= 110;
-		lcdc_info.ch[0].lcd_cfg.hsync_len	= 40;
-		lcdc_info.ch[0].lcd_cfg.upper_margin	= 20;
-		lcdc_info.ch[0].lcd_cfg.lower_margin	= 5;
-		lcdc_info.ch[0].lcd_cfg.vsync_len	= 5;
+		lcdc_info.ch[0].clock_divider		= 1;
+		lcdc_info.ch[0].lcd_cfg			= ecovec_dvi_modes;
+		lcdc_info.ch[0].num_cfg			= ARRAY_SIZE(ecovec_dvi_modes);
 
 		gpio_set_value(GPIO_PTA2, 1);
 		gpio_set_value(GPIO_PTU1, 1);
 	} else {
 		/* Panel */
-
 		lcdc_info.clock_source			= LCDC_CLK_PERIPHERAL;
-		lcdc_info.ch[0].clock_divider		= 2,
-		lcdc_info.ch[0].lcd_cfg.name		= "Panel";
-		lcdc_info.ch[0].lcd_cfg.xres		= 800;
-		lcdc_info.ch[0].lcd_cfg.yres		= 480;
-		lcdc_info.ch[0].lcd_cfg.left_margin	= 220;
-		lcdc_info.ch[0].lcd_cfg.right_margin	= 110;
-		lcdc_info.ch[0].lcd_cfg.hsync_len	= 70;
-		lcdc_info.ch[0].lcd_cfg.upper_margin	= 20;
-		lcdc_info.ch[0].lcd_cfg.lower_margin	= 5;
-		lcdc_info.ch[0].lcd_cfg.vsync_len	= 5;
+		lcdc_info.ch[0].clock_divider		= 2;
+		lcdc_info.ch[0].lcd_cfg			= ecovec_lcd_modes;
+		lcdc_info.ch[0].num_cfg			= ARRAY_SIZE(ecovec_lcd_modes);
 
 		gpio_set_value(GPIO_PTR1, 1);
 
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 68994a1..87d4b90 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -126,6 +126,21 @@ static struct platform_device kfr2r09_sh_keysc_device = {
 	},
 };
 
+const static struct fb_videomode kfr2r09_lcdc_modes[] = {
+	{
+		.name = "TX07D34VM0AAA",
+		.xres = 240,
+		.yres = 400,
+		.left_margin = 0,
+		.right_margin = 16,
+		.hsync_len = 8,
+		.upper_margin = 0,
+		.lower_margin = 1,
+		.vsync_len = 1,
+		.sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	},
+};
+
 static struct sh_mobile_lcdc_info kfr2r09_sh_lcdc_info = {
 	.clock_source = LCDC_CLK_BUS,
 	.ch[0] = {
@@ -134,18 +149,8 @@ static struct sh_mobile_lcdc_info kfr2r09_sh_lcdc_info = {
 		.interface_type = SYS18,
 		.clock_divider = 6,
 		.flags = LCDC_FLAGS_DWPOL,
-		.lcd_cfg = {
-			.name = "TX07D34VM0AAA",
-			.xres = 240,
-			.yres = 400,
-			.left_margin = 0,
-			.right_margin = 16,
-			.hsync_len = 8,
-			.upper_margin = 0,
-			.lower_margin = 1,
-			.vsync_len = 1,
-			.sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		},
+		.lcd_cfg = kfr2r09_lcdc_modes,
+		.num_cfg = ARRAY_SIZE(kfr2r09_lcdc_modes),
 		.lcd_size_cfg = {
 			.width = 35,
 			.height = 58,
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 662debe..9204cbb 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -213,51 +213,55 @@ static struct platform_device migor_nand_flash_device = {
 	}
 };
 
+const static struct fb_videomode migor_lcd_modes[] = {
+	{
+#if defined(CONFIG_SH_MIGOR_RTA_WVGA)
+		.name = "LB070WV1",
+		.xres = 800,
+		.yres = 480,
+		.left_margin = 64,
+		.right_margin = 16,
+		.hsync_len = 120,
+		.sync = 0,
+#elif defined(CONFIG_SH_MIGOR_QVGA)
+		.name = "PH240320T",
+		.xres = 320,
+		.yres = 240,
+		.left_margin = 0,
+		.right_margin = 16,
+		.hsync_len = 8,
+		.sync = FB_SYNC_HOR_HIGH_ACT,
+#endif
+		.upper_margin = 1,
+		.lower_margin = 17,
+		.vsync_len = 2,
+	},
+};
+
 static struct sh_mobile_lcdc_info sh_mobile_lcdc_info = {
-#ifdef CONFIG_SH_MIGOR_RTA_WVGA
+#if defined(CONFIG_SH_MIGOR_RTA_WVGA)
 	.clock_source = LCDC_CLK_BUS,
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
 		.interface_type = RGB16,
 		.clock_divider = 2,
-		.lcd_cfg = {
-			.name = "LB070WV1",
-			.xres = 800,
-			.yres = 480,
-			.left_margin = 64,
-			.right_margin = 16,
-			.hsync_len = 120,
-			.upper_margin = 1,
-			.lower_margin = 17,
-			.vsync_len = 2,
-			.sync = 0,
-		},
+		.lcd_cfg = migor_lcd_modes,
+		.num_cfg = ARRAY_SIZE(migor_lcd_modes),
 		.lcd_size_cfg = { /* 7.0 inch */
 			.width = 152,
 			.height = 91,
 		},
 	}
-#endif
-#ifdef CONFIG_SH_MIGOR_QVGA
+#elif defined(CONFIG_SH_MIGOR_QVGA)
 	.clock_source = LCDC_CLK_PERIPHERAL,
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
 		.interface_type = SYS16A,
 		.clock_divider = 10,
-		.lcd_cfg = {
-			.name = "PH240320T",
-			.xres = 320,
-			.yres = 240,
-			.left_margin = 0,
-			.right_margin = 16,
-			.hsync_len = 8,
-			.upper_margin = 1,
-			.lower_margin = 17,
-			.vsync_len = 2,
-			.sync = FB_SYNC_HOR_HIGH_ACT,
-		},
+		.lcd_cfg = migor_lcd_modes,
+		.num_cfg = ARRAY_SIZE(migor_lcd_modes),
 		.lcd_size_cfg = { /* 2.4 inch */
 			.width = 49,
 			.height = 37,
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 552ebd9..3099c36 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -144,16 +144,42 @@ static struct platform_device nor_flash_device = {
 };
 
 /* LCDC */
+const static struct fb_videomode lcdc_720p_modes[] = {
+	{
+		.name		= "LB070WV1",
+		.sync		= 0, /* hsync and vsync are active low */
+		.xres		= 1280;
+		.yres		= 720;
+		.left_margin	= 220;
+		.right_margin	= 110;
+		.hsync_len	= 40;
+		.upper_margin	= 20;
+		.lower_margin	= 5;
+		.vsync_len	= 5;
+	},
+};
+
+const static struct fb_videomode lcdc_vga_modes[] = {
+	{
+		.name		= "LB070WV1",
+		.sync		= 0, /* hsync and vsync are active low */
+		.xres		= 640;
+		.yres		= 480;
+		.left_margin	= 105;
+		.right_margin	= 50;
+		.hsync_len	= 96;
+		.upper_margin	= 33;
+		.lower_margin	= 10;
+		.vsync_len	= 2;
+	},
+};
+
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.clock_source = LCDC_CLK_EXTERNAL,
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
 		.clock_divider = 1,
-		.lcd_cfg = {
-			.name = "LB070WV1",
-			.sync = 0, /* hsync and vsync are active low */
-		},
 		.lcd_size_cfg = { /* 7.0 inch */
 			.width = 152,
 			.height = 91,
@@ -909,24 +935,12 @@ static int __init devices_setup(void)
 
 	if (sw & SW41_B) {
 		/* 720p */
-		lcdc_info.ch[0].lcd_cfg.xres         = 1280;
-		lcdc_info.ch[0].lcd_cfg.yres         = 720;
-		lcdc_info.ch[0].lcd_cfg.left_margin  = 220;
-		lcdc_info.ch[0].lcd_cfg.right_margin = 110;
-		lcdc_info.ch[0].lcd_cfg.hsync_len    = 40;
-		lcdc_info.ch[0].lcd_cfg.upper_margin = 20;
-		lcdc_info.ch[0].lcd_cfg.lower_margin = 5;
-		lcdc_info.ch[0].lcd_cfg.vsync_len    = 5;
+		lcdc_info.ch[0].lcd_cfg	= lcdc_720p_modes;
+		lcdc_info.ch[0].num_cfg	= ARRAY_SIZE(lcdc_720p_modes);
 	} else {
 		/* VGA */
-		lcdc_info.ch[0].lcd_cfg.xres         = 640;
-		lcdc_info.ch[0].lcd_cfg.yres         = 480;
-		lcdc_info.ch[0].lcd_cfg.left_margin  = 105;
-		lcdc_info.ch[0].lcd_cfg.right_margin = 50;
-		lcdc_info.ch[0].lcd_cfg.hsync_len    = 96;
-		lcdc_info.ch[0].lcd_cfg.upper_margin = 33;
-		lcdc_info.ch[0].lcd_cfg.lower_margin = 10;
-		lcdc_info.ch[0].lcd_cfg.vsync_len    = 2;
+		lcdc_info.ch[0].lcd_cfg	= lcdc_vga_modes;
+		lcdc_info.ch[0].num_cfg	= ARRAY_SIZE(lcdc_vga_modes);
 	}
 
 	if (sw & SW41_A) {
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 5699ce0..3f3d431 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -123,83 +123,87 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	u32 linelength;
 	bool yuv;
 
-	/* Select data format */
+	/*
+	 * Select data format. MIPI DSI is not hot-pluggable, so, we just use
+	 * the default videomode. If this ever becomes a problem, We'll have to
+	 * move this to mipi_display_on() above and use info->var.xres
+	 */
 	switch (pdata->data_format) {
 	case MIPI_RGB888:
 		pctype = 0;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_24;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
-		linelength = ch->lcd_cfg.xres * 3;
+		linelength = ch->lcd_cfg[0].xres * 3;
 		yuv = false;
 		break;
 	case MIPI_RGB565:
 		pctype = 1;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
-		linelength = ch->lcd_cfg.xres * 2;
+		linelength = ch->lcd_cfg[0].xres * 2;
 		yuv = false;
 		break;
 	case MIPI_RGB666_LP:
 		pctype = 2;
 		datatype = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
-		linelength = ch->lcd_cfg.xres * 3;
+		linelength = ch->lcd_cfg[0].xres * 3;
 		yuv = false;
 		break;
 	case MIPI_RGB666:
 		pctype = 3;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_18BIT;
-		linelength = (ch->lcd_cfg.xres * 18 + 7) / 8;
+		linelength = (ch->lcd_cfg[0].xres * 18 + 7) / 8;
 		yuv = false;
 		break;
 	case MIPI_BGR888:
 		pctype = 8;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_24;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
-		linelength = ch->lcd_cfg.xres * 3;
+		linelength = ch->lcd_cfg[0].xres * 3;
 		yuv = false;
 		break;
 	case MIPI_BGR565:
 		pctype = 9;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
-		linelength = ch->lcd_cfg.xres * 2;
+		linelength = ch->lcd_cfg[0].xres * 2;
 		yuv = false;
 		break;
 	case MIPI_BGR666_LP:
 		pctype = 0xa;
 		datatype = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_24BIT;
-		linelength = ch->lcd_cfg.xres * 3;
+		linelength = ch->lcd_cfg[0].xres * 3;
 		yuv = false;
 		break;
 	case MIPI_BGR666:
 		pctype = 0xb;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_18;
 		pixfmt = MIPI_DCS_PIXEL_FMT_18BIT;
-		linelength = (ch->lcd_cfg.xres * 18 + 7) / 8;
+		linelength = (ch->lcd_cfg[0].xres * 18 + 7) / 8;
 		yuv = false;
 		break;
 	case MIPI_YUYV:
 		pctype = 4;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
-		linelength = ch->lcd_cfg.xres * 2;
+		linelength = ch->lcd_cfg[0].xres * 2;
 		yuv = true;
 		break;
 	case MIPI_UYVY:
 		pctype = 5;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR16;
 		pixfmt = MIPI_DCS_PIXEL_FMT_16BIT;
-		linelength = ch->lcd_cfg.xres * 2;
+		linelength = ch->lcd_cfg[0].xres * 2;
 		yuv = true;
 		break;
 	case MIPI_YUV420_L:
 		pctype = 6;
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR12;
 		pixfmt = MIPI_DCS_PIXEL_FMT_12BIT;
-		linelength = (ch->lcd_cfg.xres * 12 + 7) / 8;
+		linelength = (ch->lcd_cfg[0].xres * 12 + 7) / 8;
 		yuv = true;
 		break;
 	case MIPI_YUV420:
@@ -207,7 +211,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 		datatype = MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR12;
 		pixfmt = MIPI_DCS_PIXEL_FMT_12BIT;
 		/* Length of U/V line */
-		linelength = (ch->lcd_cfg.xres + 1) / 2;
+		linelength = (ch->lcd_cfg[0].xres + 1) / 2;
 		yuv = true;
 		break;
 	default:
@@ -281,7 +285,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	iowrite32(0x00e00000, base + 0x8024); /* VMCTR2 */
 	/*
 	 * 0x660 = 1632 bytes per line (RGB24, 544 pixels: see
-	 * sh_mobile_lcdc_info.ch[0].lcd_cfg.xres), HSALEN = 1 - default
+	 * sh_mobile_lcdc_info.ch[0].lcd_cfg[0].xres), HSALEN = 1 - default
 	 * (unused, since VMCTR2[HSABM] = 0)
 	 */
 	iowrite32(1 | (linelength << 16), base + 0x8028); /* VMLEN1 */
diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 03bcb20..5583cd6 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -883,7 +883,8 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		goto egetclk;
 	}
 
-	rate = PICOS2KHZ(pdata->lcd_chan->lcd_cfg.pixclock) * 1000;
+	/* TODO: reconfigure the clock on monitor plug in */
+	rate = PICOS2KHZ(pdata->lcd_chan->lcd_cfg[0].pixclock) * 1000;
 
 	rate = clk_round_rate(hdmi->hdmi_clk, rate);
 	if (rate < 0) {
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index e4f6012..ce3ed4b 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -989,8 +989,8 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 			int ret;
 
 			/* Can we handle this display? */
-			if (var->xres > ch->cfg.lcd_cfg.xres ||
-			    var->yres > ch->cfg.lcd_cfg.yres)
+			if (var->xres > ch->cfg.lcd_cfg[0].xres ||
+			    var->yres > ch->cfg.lcd_cfg[0].yres)
 				return -ENOMEM;
 
 			/* Add to the modelist */
@@ -1115,7 +1115,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 		info = ch->info;
 		var = &info->var;
-		lcd_cfg = &cfg->lcd_cfg;
+		lcd_cfg = &cfg->lcd_cfg[0];
 		info->fbops = &sh_mobile_lcdc_ops;
 		fb_videomode_to_var(var, lcd_cfg);
 		/* Default Y virtual resolution is 2x panel size */
@@ -1187,8 +1187,8 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			 pdev->name,
 			 (ch->cfg.chan = LCDC_CHAN_MAINLCD) ?
 			 "mainlcd" : "sublcd",
-			 (int) ch->cfg.lcd_cfg.xres,
-			 (int) ch->cfg.lcd_cfg.yres,
+			 (int) ch->cfg.lcd_cfg[0].xres,
+			 (int) ch->cfg.lcd_cfg[0].yres,
 			 ch->cfg.bpp);
 
 		/* deferred io mode: disable clock to save power */
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index 55d700e..19c69d7 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -70,7 +70,8 @@ struct sh_mobile_lcdc_chan_cfg {
 	int interface_type; /* selects RGBn or SYSn I/F, see above */
 	int clock_divider;
 	unsigned long flags; /* LCDC_FLAGS_... */
-	struct fb_videomode lcd_cfg;
+	const struct fb_videomode *lcd_cfg;
+	int num_cfg;
 	struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
 	struct sh_mobile_lcdc_board_cfg board_cfg;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
-- 
1.7.1

