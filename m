From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 30 Jun 2010 09:55:38 +0000
Subject: [PATCH 4/6] fbdev: sh-mobile-lcdc: add a parameter to LCDC driver's
Message-Id: <Pine.LNX.4.64.1006301143240.17489@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

HDMI support for the sh_mobile_lcdc framebuffer driver will require a 'struct
fb_info *' pointer for its .display_on() callback. While at it fix kfr2r09
framebuffer modular build.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-ap325rxa/setup.c        |    2 +-
 arch/sh/boards/mach-kfr2r09/Makefile        |    6 ++++--
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |    2 +-
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |   16 ++++++++--------
 drivers/video/sh_mipi_dsi.c                 |    2 +-
 drivers/video/sh_mobile_lcdcfb.c            |    2 +-
 include/video/sh_mobile_lcdc.h              |    2 +-
 7 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 57e37e2..ab3bd9d 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -154,7 +154,7 @@ static struct platform_device nand_flash_device = {
 #define PORT_DRVCRA	0xA405018A
 #define PORT_DRVCRB	0xA405018C
 
-static void ap320_wvga_power_on(void *board_data)
+static void ap320_wvga_power_on(void *board_data, struct fb_info *info)
 {
 	msleep(100);
 
diff --git a/arch/sh/boards/mach-kfr2r09/Makefile b/arch/sh/boards/mach-kfr2r09/Makefile
index 4e577a3..60dd63f 100644
--- a/arch/sh/boards/mach-kfr2r09/Makefile
+++ b/arch/sh/boards/mach-kfr2r09/Makefile
@@ -1,2 +1,4 @@
-obj-y	 := setup.o sdram.o
-obj-$(CONFIG_FB_SH_MOBILE_LCDC)	+=  lcd_wqvga.o
+obj-y	:= setup.o sdram.o
+ifneq ($(CONFIG_FB_SH_MOBILE_LCDC),)
+obj-y	+=  lcd_wqvga.o
+endif
diff --git a/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c b/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
index e9b9708..25e145f 100644
--- a/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
+++ b/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
@@ -327,7 +327,7 @@ static int kfr2r09_lcd_backlight(int on)
 	return 0;
 }
 
-void kfr2r09_lcd_on(void *board_data)
+void kfr2r09_lcd_on(void *board_data, struct fb_info *info)
 {
 	kfr2r09_lcd_backlight(1);
 }
diff --git a/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h b/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h
index 484ef42..07e635b 100644
--- a/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h
+++ b/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h
@@ -3,23 +3,23 @@
 
 #include <video/sh_mobile_lcdc.h>
 
-#ifdef CONFIG_FB_SH_MOBILE_LCDC
-void kfr2r09_lcd_on(void *board_data);
+#if defined(CONFIG_FB_SH_MOBILE_LCDC) || defined(CONFIG_FB_SH_MOBILE_LCDC_MODULE)
+void kfr2r09_lcd_on(void *board_data, struct fb_info *info);
 void kfr2r09_lcd_off(void *board_data);
 int kfr2r09_lcd_setup(void *board_data, void *sys_ops_handle,
 		      struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 void kfr2r09_lcd_start(void *board_data, void *sys_ops_handle,
 		       struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 #else
-static inline void kfr2r09_lcd_on(void *board_data) {}
-static inline void kfr2r09_lcd_off(void *board_data) {}
-static inline int kfr2r09_lcd_setup(void *board_data, void *sys_ops_handle,
-				    struct sh_mobile_lcdc_sys_bus_ops *sys_ops)
+static void kfr2r09_lcd_on(void *board_data) {}
+static void kfr2r09_lcd_off(void *board_data) {}
+static int kfr2r09_lcd_setup(void *board_data, void *sys_ops_handle,
+				struct sh_mobile_lcdc_sys_bus_ops *sys_ops)
 {
 	return -ENODEV;
 }
-static inline void kfr2r09_lcd_start(void *board_data, void *sys_ops_handle,
-				     struct sh_mobile_lcdc_sys_bus_ops *sys_ops)
+static void kfr2r09_lcd_start(void *board_data, void *sys_ops_handle,
+				struct sh_mobile_lcdc_sys_bus_ops *sys_ops)
 {
 }
 #endif
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 017ae9f..5699ce0 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -100,7 +100,7 @@ static void sh_mipi_shutdown(struct platform_device *pdev)
 	sh_mipi_dsi_enable(mipi, false);
 }
 
-static void mipi_display_on(void *arg)
+static void mipi_display_on(void *arg, struct fb_info *info)
 {
 	struct sh_mipi *mipi = arg;
 
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 1ece226..060674a 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -577,7 +577,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 		board_cfg = &ch->cfg.board_cfg;
 		if (board_cfg->display_on)
-			board_cfg->display_on(board_cfg->board_data);
+			board_cfg->display_on(board_cfg->board_data, ch->info);
 	}
 
 	return 0;
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index 2439344..55d700e 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -55,7 +55,7 @@ struct sh_mobile_lcdc_board_cfg {
 			 struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 	void (*start_transfer)(void *board_data, void *sys_ops_handle,
 			       struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
-	void (*display_on)(void *board_data);
+	void (*display_on)(void *board_data, struct fb_info *info);
 	void (*display_off)(void *board_data);
 };
 
-- 
1.6.2.4

