From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] au1200fb: make framebuffer config
	runtime selectable.
Date: Tue, 5 Aug 2008 14:45:22 +0200
Message-ID: <20080805124522.GB27469@roarinelk.homelinux.net>
References: <20080805124221.GA27469@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQLuo-00042X-C1 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 05:45:26 -0700
Received: from fnoeppeil43.netpark.at ([217.175.205.171]
	helo=roarinelk.homelinux.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQLun-0003iW-1Y
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 05:45:26 -0700
Content-Disposition: inline
In-Reply-To: <20080805124221.GA27469@roarinelk.homelinux.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sf.net
Cc: L-M-O <linux-mips@linux-mips.org>, Kevin Hickey <khickey@rmicorp.com>

Make the number of framebuffer windows and the window configuration
selectable at the kernel commandline instead of hardcoding it
in the kernel config.

This patch does not directly depend on the previous one ("au1200fb: fixup PM
support"), but it only applies cleanly on top of it.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/video/au1200fb.c |   55 ++++++++++++++++++++++++++++++++++-----------
 1 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index be945ab..7127aa7 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -45,10 +45,6 @@
 #include <asm/mach-au1x00/au1000.h>
 #include "au1200fb.h"
 
-#ifndef CONFIG_FB_AU1200_DEVS
-#define CONFIG_FB_AU1200_DEVS 4
-#endif
-
 #define DRIVER_NAME "au1200fb"
 #define DRIVER_DESC "LCD controller driver for AU1200 processors"
 
@@ -153,7 +149,7 @@ struct au1200fb_device {
 	dma_addr_t    		fb_phys;
 };
 
-static struct au1200fb_device _au1200fb_devices[CONFIG_FB_AU1200_DEVS];
+static struct au1200fb_device _au1200fb_devices[4];
 /********************************************************************/
 
 /* LCD controller restrictions */
@@ -166,10 +162,17 @@ static struct au1200fb_device _au1200fb_devices[CONFIG_FB_AU1200_DEVS];
 /* Default number of visible screen buffer to allocate */
 #define AU1200FB_NBR_VIDEO_BUFFERS 1
 
+/* Default number of fb devices to create */
+#define DEFAULT_DEVICE_COUNT	4
+
+/* Default window configuration entry to use (see windows[]) */
+#define DEFAULT_WINDOW_INDEX	2
+
 /********************************************************************/
 
 static struct au1200_lcd *lcd = (struct au1200_lcd *) AU1200_LCD_ADDR;
-static int window_index = 2; /* default is zero */
+static int device_count = DEFAULT_DEVICE_COUNT;	/* number of fb devices to create */
+static int window_index = DEFAULT_WINDOW_INDEX;	/* default is zero */
 static int panel_index = 2; /* default is zero */
 static struct window_settings *win;
 static struct panel_settings *panel;
@@ -682,7 +685,7 @@ static int fbinfo2index (struct fb_info *fb_info)
 {
 	int i;
 
-	for (i = 0; i < CONFIG_FB_AU1200_DEVS; ++i) {
+	for (i = 0; i < device_count; ++i) {
 		if (fb_info == (struct fb_info *)(&_au1200fb_devices[i].fb_info))
 			return i;
 	}
@@ -1594,7 +1597,7 @@ static int au1200fb_drv_probe(struct platform_device *pdev)
 	/* Kickstart the panel */
 	au1200_setpanel(panel);
 
-	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane) {
+	for (plane = 0; plane < device_count; ++plane) {
 		bpp = winbpp(win->w[plane].mode_winctrl1);
 		if (win->w[plane].xres == 0)
 			win->w[plane].xres = panel->Xres;
@@ -1686,7 +1689,7 @@ static int au1200fb_drv_remove(struct platform_device *pdev)
 	/* Turn off the panel */
 	au1200_setpanel(NULL);
 
-	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane)
+	for (plane = 0; plane < device_count; ++plane)
 	{
 		fbdev = &_au1200fb_devices[plane];
 
@@ -1727,7 +1730,7 @@ static int au1200fb_drv_resume(struct platform_device *pdev)
 	/* Kickstart the panel */
 	au1200_setpanel(panel);
 
-	for (i = 0; i < CONFIG_FB_AU1200_DEVS; i++) {
+	for (i = 0; i < device_count; i++) {
 		fbdev = &_au1200fb_devices[i];
 		au1200fb_fb_set_par(&fbdev->fb_info);
 	}
@@ -1754,10 +1757,10 @@ static struct platform_driver au1200fb_driver = {
 
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
 
@@ -1802,12 +1805,29 @@ static void au1200fb_setup(void)
 				nohwcursor = 1;
 			}
 
+			else if (strncmp(this_opt, "devices:", 8) == 0) {
+				this_opt += 8;
+				device_count = simple_strtol(this_opt, &endptr, 0);
+				if ((device_count < 0) || (device_count > 4))
+					device_count = DEFAULT_DEVICE_COUNT;
+			}
+
+			else if (strncmp(this_opt, "wincfg:", 7) == 0) {
+				this_opt += 7;
+				window_index = simple_strtol(this_opt, &endptr, 0);
+				if ((window_index < 0) || (window_index >= ARRAY_SIZE(windows)))
+					window_index = DEFAULT_WINDOW_INDEX;
+			}
+
+			else if (strncmp(this_opt, "off", 3) == 0)
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
@@ -1815,7 +1835,14 @@ static int __init au1200fb_init(void)
 	print_info("" DRIVER_DESC "");
 
 	/* Setup driver with options */
-	au1200fb_setup();
+	if (au1200fb_setup())
+		return -ENODEV;
+
+	if ((device_count < 0) || (device_count > 4))
+		device_count = DEFAULT_DEVICE_COUNT;
+
+	if ((window_index < 0) || (window_index >= ARRAY_SIZE(windows)))
+		window_index = DEFAULT_WINDOW_INDEX;
 
 	/* Point to the panel selected */
 	panel = &known_lcd_panels[panel_index];
-- 
1.5.6.4


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
