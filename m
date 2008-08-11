From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] video: export sh_mobile_lcdc panel size
Date: Mon, 11 Aug 2008 15:26:00 +0900
Message-ID: <20080811062600.19986.98178.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Export the LCD panel size for sh_mobile_lcdc boards. This allows us
to perform dpi and screen aspect ratio calculations in user space.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Paul, maybe this is material for the SuperH tree?

 arch/sh/boards/board-ap325rxa.c      |    4 ++++
 arch/sh/boards/mach-migor/setup.c    |    8 ++++++++
 arch/sh/include/asm/sh_mobile_lcdc.h |    6 ++++++
 drivers/video/sh_mobile_lcdcfb.c     |    2 ++
 4 files changed, 20 insertions(+)

--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2008-08-11 11:36:22.000000000 +0900
@@ -140,6 +140,10 @@ static struct sh_mobile_lcdc_info lcdc_i
 			.vsync_len = 1,
 			.sync = 0, /* hsync and vsync are active low */
 		},
+		.lcd_size_cfg = { /* 7.0 inch */
+			.width = 152,
+			.height = 91,
+		},
 		.board_cfg = {
 			.display_on = ap320_wvga_power_on,
 		},
--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-08-11 11:36:12.000000000 +0900
@@ -224,6 +224,10 @@ static struct sh_mobile_lcdc_info sh_mob
 			.vsync_len = 2,
 			.sync = 0,
 		},
+		.lcd_size_cfg = { /* 7.0 inch */
+			.width = 152,
+			.height = 91,
+		},
 	}
 #endif
 #ifdef CONFIG_SH_MIGOR_QVGA
@@ -245,6 +249,10 @@ static struct sh_mobile_lcdc_info sh_mob
 			.vsync_len = 2,
 			.sync = FB_SYNC_HOR_HIGH_ACT,
 		},
+		.lcd_size_cfg = { /* 2.4 inch */
+			.width = 49,
+			.height = 37,
+		},
 		.board_cfg = {
 			.setup_sys = migor_lcd_qvga_setup,
 		},
--- 0001/arch/sh/include/asm/sh_mobile_lcdc.h
+++ work/arch/sh/include/asm/sh_mobile_lcdc.h	2008-08-11 11:28:30.000000000 +0900
@@ -47,12 +47,18 @@ struct sh_mobile_lcdc_board_cfg {
 	void (*display_off)(void *board_data);
 };
 
+struct sh_mobile_lcdc_lcd_size_cfg { /* width and height of panel in mm */
+	unsigned long width;
+	unsigned long height;
+};
+
 struct sh_mobile_lcdc_chan_cfg {
 	int chan;
 	int bpp;
 	int interface_type; /* selects RGBn or SYSn I/F, see above */
 	int clock_divider;
 	struct fb_videomode lcd_cfg;
+	struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
 	struct sh_mobile_lcdc_board_cfg board_cfg;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
 };
--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2008-08-11 11:28:30.000000000 +0900
@@ -595,6 +595,8 @@ static int __init sh_mobile_lcdc_probe(s
 		info->fbops = &sh_mobile_lcdc_ops;
 		info->var.xres = info->var.xres_virtual = cfg->lcd_cfg.xres;
 		info->var.yres = info->var.yres_virtual = cfg->lcd_cfg.yres;
+		info->var.width = cfg->lcd_size_cfg.width;
+		info->var.height = cfg->lcd_size_cfg.height;
 		info->var.activate = FB_ACTIVATE_NOW;
 		error = sh_mobile_lcdc_set_bpp(&info->var, cfg->bpp);
 		if (error)
