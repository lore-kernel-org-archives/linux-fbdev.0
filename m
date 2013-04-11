From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Apr 2013 00:04:55 +0000
Subject: [PATCH 13/30] video/s3c: move platform_data out of arch/arm
Message-Id: <1365638712-1028578-14-git-send-email-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The s3c-fb driver requires header files from the samsung platforms
to find its platform_data definition, but this no longer works on
multiplatform kernels, so let's move the data into a new header
file under include/linux/platform_data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org
Cc: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/plat-samsung/include/plat/fb.h | 50 +-----------------------------
 drivers/video/s3c-fb.c                  |  3 +-
 include/linux/platform_data/video_s3c.h | 54 +++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 51 deletions(-)
 create mode 100644 include/linux/platform_data/video_s3c.h

diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index b885322..9ae5072 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -15,55 +15,7 @@
 #ifndef __PLAT_S3C_FB_H
 #define __PLAT_S3C_FB_H __FILE__
 
-/* S3C_FB_MAX_WIN
- * Set to the maximum number of windows that any of the supported hardware
- * can use. Since the platform data uses this for an array size, having it
- * set to the maximum of any version of the hardware can do is safe.
- */
-#define S3C_FB_MAX_WIN	(5)
-
-/**
- * struct s3c_fb_pd_win - per window setup data
- * @xres     : The window X size.
- * @yres     : The window Y size.
- * @virtual_x: The virtual X size.
- * @virtual_y: The virtual Y size.
- */
-struct s3c_fb_pd_win {
-	unsigned short		default_bpp;
-	unsigned short		max_bpp;
-	unsigned short		xres;
-	unsigned short		yres;
-	unsigned short		virtual_x;
-	unsigned short		virtual_y;
-};
-
-/**
- * struct s3c_fb_platdata -  S3C driver platform specific information
- * @setup_gpio: Setup the external GPIO pins to the right state to transfer
- *		the data from the display system to the connected display
- *		device.
- * @vidcon0: The base vidcon0 values to control the panel data format.
- * @vidcon1: The base vidcon1 values to control the panel data output.
- * @vtiming: Video timing when connected to a RGB type panel.
- * @win: The setup data for each hardware window, or NULL for unused.
- * @display_mode: The LCD output display mode.
- *
- * The platform data supplies the video driver with all the information
- * it requires to work with the display(s) attached to the machine. It
- * controls the initial mode, the number of display windows (0 is always
- * the base framebuffer) that are initialised etc.
- *
- */
-struct s3c_fb_platdata {
-	void	(*setup_gpio)(void);
-
-	struct s3c_fb_pd_win	*win[S3C_FB_MAX_WIN];
-	struct fb_videomode     *vtiming;
-
-	u32			 vidcon0;
-	u32			 vidcon1;
-};
+#include <linux/platform_data/video_s3c.h>
 
 /**
  * s3c_fb_set_platdata() - Setup the FB device with platform data.
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 968a625..2e7991c 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -24,10 +24,9 @@
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
+#include <linux/platform_data/video_s3c.h>
 
 #include <video/samsung_fimd.h>
-#include <mach/map.h>
-#include <plat/fb.h>
 
 /* This driver will export a number of framebuffer interfaces depending
  * on the configuration passed in via the platform data. Each fb instance
diff --git a/include/linux/platform_data/video_s3c.h b/include/linux/platform_data/video_s3c.h
new file mode 100644
index 0000000..fa40f96
--- /dev/null
+++ b/include/linux/platform_data/video_s3c.h
@@ -0,0 +1,54 @@
+#ifndef __PLATFORM_DATA_VIDEO_S3C
+#define __PLATFORM_DATA_VIDEO_S3C
+
+/* S3C_FB_MAX_WIN
+ * Set to the maximum number of windows that any of the supported hardware
+ * can use. Since the platform data uses this for an array size, having it
+ * set to the maximum of any version of the hardware can do is safe.
+ */
+#define S3C_FB_MAX_WIN	(5)
+
+/**
+ * struct s3c_fb_pd_win - per window setup data
+ * @xres     : The window X size.
+ * @yres     : The window Y size.
+ * @virtual_x: The virtual X size.
+ * @virtual_y: The virtual Y size.
+ */
+struct s3c_fb_pd_win {
+	unsigned short		default_bpp;
+	unsigned short		max_bpp;
+	unsigned short		xres;
+	unsigned short		yres;
+	unsigned short		virtual_x;
+	unsigned short		virtual_y;
+};
+
+/**
+ * struct s3c_fb_platdata -  S3C driver platform specific information
+ * @setup_gpio: Setup the external GPIO pins to the right state to transfer
+ *		the data from the display system to the connected display
+ *		device.
+ * @vidcon0: The base vidcon0 values to control the panel data format.
+ * @vidcon1: The base vidcon1 values to control the panel data output.
+ * @vtiming: Video timing when connected to a RGB type panel.
+ * @win: The setup data for each hardware window, or NULL for unused.
+ * @display_mode: The LCD output display mode.
+ *
+ * The platform data supplies the video driver with all the information
+ * it requires to work with the display(s) attached to the machine. It
+ * controls the initial mode, the number of display windows (0 is always
+ * the base framebuffer) that are initialised etc.
+ *
+ */
+struct s3c_fb_platdata {
+	void	(*setup_gpio)(void);
+
+	struct s3c_fb_pd_win	*win[S3C_FB_MAX_WIN];
+	struct fb_videomode     *vtiming;
+
+	u32			 vidcon0;
+	u32			 vidcon1;
+};
+ 
+#endif
-- 
1.8.1.2

