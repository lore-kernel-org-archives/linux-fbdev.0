From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Fri, 02 Sep 2011 14:40:48 +0000
Subject: [PATCH 3/6] au1200fb: make number of windows configurable at load time.
Message-Id: <1314974451-8535-4-git-send-email-manuel.lauss@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Make the number of framebuffer windows and the window configuration
selectable at the kernel commandline instead of hardcoding it
in the kernel config.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/video/au1200fb.c |   53 +++++++++++++++++++++++++++++++++------------
 1 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 480ecb1..4b58f7b 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -46,10 +46,6 @@
 #include <asm/mach-au1x00/au1000.h>
 #include "au1200fb.h"
 
-#ifndef CONFIG_FB_AU1200_DEVS
-#define CONFIG_FB_AU1200_DEVS 4
-#endif
-
 #define DRIVER_NAME "au1200fb"
 #define DRIVER_DESC "LCD controller driver for AU1200 processors"
 
@@ -154,7 +150,6 @@ struct au1200fb_device {
 	dma_addr_t    		fb_phys;
 };
 
-static struct fb_info *_au1200fb_infos[CONFIG_FB_AU1200_DEVS];
 /********************************************************************/
 
 /* LCD controller restrictions */
@@ -167,10 +162,18 @@ static struct fb_info *_au1200fb_infos[CONFIG_FB_AU1200_DEVS];
 /* Default number of visible screen buffer to allocate */
 #define AU1200FB_NBR_VIDEO_BUFFERS 1
 
+/* Default maximum number of fb devices to create */
+#define MAX_DEVICE_COUNT	4
+
+/* Default window configuration entry to use (see windows[]) */
+#define DEFAULT_WINDOW_INDEX	2
+
 /********************************************************************/
 
+static struct fb_info *_au1200fb_infos[MAX_DEVICE_COUNT];
 static struct au1200_lcd *lcd = (struct au1200_lcd *) AU1200_LCD_ADDR;
-static int window_index = 2; /* default is zero */
+static int device_count = MAX_DEVICE_COUNT;
+static int window_index = DEFAULT_WINDOW_INDEX;	/* default is zero */
 static int panel_index = 2; /* default is zero */
 static struct window_settings *win;
 static struct panel_settings *panel;
@@ -683,7 +686,7 @@ static int fbinfo2index (struct fb_info *fb_info)
 {
 	int i;
 
-	for (i = 0; i < CONFIG_FB_AU1200_DEVS; ++i) {
+	for (i = 0; i < device_count; ++i) {
 		if (fb_info = _au1200fb_infos[i])
 			return i;
 	}
@@ -1599,7 +1602,7 @@ static int __devinit au1200fb_drv_probe(struct platform_device *dev)
 	/* Kickstart the panel */
 	au1200_setpanel(panel);
 
-	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane) {
+	for (plane = 0; plane < device_count; ++plane) {
 		bpp = winbpp(win->w[plane].mode_winctrl1);
 		if (win->w[plane].xres = 0)
 			win->w[plane].xres = panel->Xres;
@@ -1699,7 +1702,7 @@ static int __devexit au1200fb_drv_remove(struct platform_device *dev)
 	/* Turn off the panel */
 	au1200_setpanel(NULL);
 
-	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane)	{
+	for (plane = 0; plane < device_count; ++plane)	{
 		fbi = _au1200fb_infos[plane];
 		fbdev = fbi->par;
 
@@ -1741,7 +1744,7 @@ static int au1200fb_drv_resume(struct device *dev)
 	/* Kickstart the panel */
 	au1200_setpanel(panel);
 
-	for (i = 0; i < CONFIG_FB_AU1200_DEVS; i++) {
+	for (i = 0; i < device_count; i++) {
 		fbi = _au1200fb_infos[i];
 		au1200fb_fb_set_par(fbi);
 	}
@@ -1776,10 +1779,10 @@ static struct platform_driver au1200fb_driver = {
 
 /* Kernel driver */
 
-static void au1200fb_setup(void)
+static int au1200fb_setup(void)
 {
-	char* options = NULL;
-	char* this_opt;
+	char *options = NULL;
+	char *this_opt, *endptr;
 	int num_panels = ARRAY_SIZE(known_lcd_panels);
 	int panel_idx = -1;
 
@@ -1824,12 +1827,33 @@ static void au1200fb_setup(void)
 				nohwcursor = 1;
 			}
 
+			else if (strncmp(this_opt, "devices:", 8) = 0) {
+				this_opt += 8;
+				device_count = simple_strtol(this_opt,
+							     &endptr, 0);
+				if ((device_count < 0) ||
+				    (device_count > MAX_DEVICE_COUNT))
+					device_count = MAX_DEVICE_COUNT;
+			}
+
+			else if (strncmp(this_opt, "wincfg:", 7) = 0) {
+				this_opt += 7;
+				window_index = simple_strtol(this_opt,
+							     &endptr, 0);
+				if ((window_index < 0) ||
+				    (window_index >= ARRAY_SIZE(windows)))
+					window_index = DEFAULT_WINDOW_INDEX;
+			}
+
+			else if (strncmp(this_opt, "off", 3) = 0)
+				return 1;
 			/* Unsupported option */
 			else {
 				print_warn("Unsupported option \"%s\"", this_opt);
 			}
 		}
 	}
+	return 0;
 }
 
 static int __init au1200fb_init(void)
@@ -1837,7 +1861,8 @@ static int __init au1200fb_init(void)
 	print_info("" DRIVER_DESC "");
 
 	/* Setup driver with options */
-	au1200fb_setup();
+	if (au1200fb_setup())
+		return -ENODEV;
 
 	/* Point to the panel selected */
 	panel = &known_lcd_panels[panel_index];
-- 
1.7.6

