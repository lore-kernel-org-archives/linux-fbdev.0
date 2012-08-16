From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:53 +0000
Subject: [PATCH 18/19] sh: kfr2r09: Use the backlight API for brightness control
Message-Id: <1345122054-16013-19-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Don't hook up brightness control in the display on/off operations, use
the backlight API instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |   16 +++-------------
 arch/sh/boards/mach-kfr2r09/setup.c         |    7 +++++--
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |    6 ++----
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c b/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
index c148b36..c620503 100644
--- a/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
+++ b/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
@@ -283,7 +283,7 @@ void kfr2r09_lcd_start(void *sohandle, struct sh_mobile_lcdc_sys_bus_ops *so)
 #define MAIN_MLED4      0x40
 #define MAIN_MSW        0x80
 
-static int kfr2r09_lcd_backlight(int on)
+int kfr2r09_lcd_set_brightness(int brightness)
 {
 	struct i2c_adapter *a;
 	struct i2c_msg msg;
@@ -295,7 +295,7 @@ static int kfr2r09_lcd_backlight(int on)
 		return -ENODEV;
 
 	buf[0] = 0x00;
-	if (on)
+	if (brightness)
 		buf[1] = CTRL_CPSW | CTRL_C10 | CTRL_CKSW;
 	else
 		buf[1] = 0;
@@ -309,7 +309,7 @@ static int kfr2r09_lcd_backlight(int on)
 		return -ENODEV;
 
 	buf[0] = 0x01;
-	if (on)
+	if (brightness)
 		buf[1] = MAIN_MSW | MAIN_MLED4 | 0x0c;
 	else
 		buf[1] = 0;
@@ -324,13 +324,3 @@ static int kfr2r09_lcd_backlight(int on)
 
 	return 0;
 }
-
-void kfr2r09_lcd_on(void)
-{
-	kfr2r09_lcd_backlight(1);
-}
-
-void kfr2r09_lcd_off(void)
-{
-	kfr2r09_lcd_backlight(0);
-}
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 158c917..ecf40b8 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -156,8 +156,11 @@ static struct sh_mobile_lcdc_info kfr2r09_sh_lcdc_info = {
 			.height = 58,
 			.setup_sys = kfr2r09_lcd_setup,
 			.start_transfer = kfr2r09_lcd_start,
-			.display_on = kfr2r09_lcd_on,
-			.display_off = kfr2r09_lcd_off,
+		},
+		.bl_info = {
+			.name = "sh_mobile_lcdc_bl",
+			.max_brightness = 1,
+			.set_brightness = kfr2r09_lcd_set_brightness,
 		},
 		.sys_bus_cfg = {
 			.ldmt2r = 0x07010904,
diff --git a/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h b/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h
index ba3d93d..c20c9e5 100644
--- a/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h
+++ b/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h
@@ -4,15 +4,13 @@
 #include <video/sh_mobile_lcdc.h>
 
 #if defined(CONFIG_FB_SH_MOBILE_LCDC) || defined(CONFIG_FB_SH_MOBILE_LCDC_MODULE)
-void kfr2r09_lcd_on(void);
-void kfr2r09_lcd_off(void);
+int kfr2r09_lcd_set_brightness(int brightness);
 int kfr2r09_lcd_setup(void *sys_ops_handle,
 		      struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 void kfr2r09_lcd_start(void *sys_ops_handle,
 		       struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 #else
-static void kfr2r09_lcd_on(void) {}
-static void kfr2r09_lcd_off(void) {}
+static int kfr2r09_lcd_set_brightness(int brightness) {}
 static int kfr2r09_lcd_setup(void *sys_ops_handle,
 				struct sh_mobile_lcdc_sys_bus_ops *sys_ops)
 {
-- 
1.7.8.6

