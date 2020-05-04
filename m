From: Joe Perches <joe@perches.com>
Date: Mon, 04 May 2020 23:29:00 +0000
Subject: [trivial PATCH] video: fbdev: Use IS_BUILTIN
Message-Id: <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

IS_BUILTIN can be use to replace various initializations
like #if CONFIG_<FOO> int val = 1; #else int val = 0; #endif
so do so.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/aty/aty128fb.c     | 6 +-----
 drivers/video/fbdev/aty/atyfb_base.c   | 7 +------
 drivers/video/fbdev/aty/radeon_base.c  | 6 +-----
 drivers/video/fbdev/nvidia/nvidia.c    | 6 +-----
 drivers/video/fbdev/omap/omapfb_main.c | 6 +-----
 drivers/video/fbdev/riva/fbdev.c       | 6 +-----
 drivers/video/fbdev/s3c2410fb.c        | 6 +-----
 7 files changed, 7 insertions(+), 36 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index d05d4195acad..6fae6ad6cb77 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -384,11 +384,7 @@ static int default_lcd_on = 1;
 static bool mtrr = true;
 
 #ifdef CONFIG_FB_ATY128_BACKLIGHT
-#ifdef CONFIG_PMAC_BACKLIGHT
-static int backlight = 1;
-#else
-static int backlight = 0;
-#endif
+static int backlight = IS_BUILTIN(CONFIG_PMAC_BACKLIGHT);
 #endif
 
 /* PLL constants */
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 49d192869cf5..23a29d61c2a2 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -317,12 +317,7 @@ static int mclk;
 static int xclk;
 static int comp_sync = -1;
 static char *mode;
-
-#ifdef CONFIG_PMAC_BACKLIGHT
-static int backlight = 1;
-#else
-static int backlight = 0;
-#endif
+static int backlight = IS_BUILTIN(CONFIG_PMAC_BACKLIGHT);
 
 #ifdef CONFIG_PPC
 static int default_vmode = VMODE_CHOOSE;
diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index e116a3f9ad56..3fe509cb9b87 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -269,11 +269,7 @@ static bool force_measure_pll = 0;
 static bool nomtrr = 0;
 static bool force_sleep;
 static bool ignore_devlist;
-#ifdef CONFIG_PMAC_BACKLIGHT
-static int backlight = 1;
-#else
-static int backlight = 0;
-#endif
+static int backlight = IS_BUILTIN(CONFIG_PMAC_BACKLIGHT);
 
 /* Note about this function: we have some rare cases where we must not schedule,
  * this typically happen with our special "wake up early" hook which allows us to
diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index c24de9107958..c6820e21875d 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -74,11 +74,7 @@ static int vram = 0;
 static int bpp = 8;
 static int reverse_i2c;
 static bool nomtrr = false;
-#ifdef CONFIG_PMAC_BACKLIGHT
-static int backlight = 1;
-#else
-static int backlight = 0;
-#endif
+static int backlight = IS_BUILTIN(CONFIG_PMAC_BACKLIGHT);
 
 static char *mode_option = NULL;
 
diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 1a9d6242916e..0cbcc74fa943 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -34,11 +34,7 @@ static unsigned long	def_vyres;
 static unsigned int	def_rotate;
 static unsigned int	def_mirror;
 
-#ifdef CONFIG_FB_OMAP_MANUAL_UPDATE
-static bool		manual_update = 1;
-#else
-static bool		manual_update;
-#endif
+static bool	manual_update = IS_BUILTIN(CONFIG_FB_OMAP_MANUAL_UPDATE);
 
 static struct platform_device	*fbdev_pdev;
 static struct lcd_panel		*fbdev_panel;
diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index 764ec3285e62..9b3493846f4d 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -202,11 +202,7 @@ static int flatpanel = -1; /* Autodetect later */
 static int forceCRTC = -1;
 static bool noaccel  = 0;
 static bool nomtrr = 0;
-#ifdef CONFIG_PMAC_BACKLIGHT
-static int backlight = 1;
-#else
-static int backlight = 0;
-#endif
+static int backlight = IS_BUILTIN(CONFIG_PMAC_BACKLIGHT);
 
 static char *mode_option = NULL;
 static bool strictmode       = 0;
diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
index 2fb15a540167..6f8fa501583f 100644
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -44,11 +44,7 @@
 #include "s3c2410fb.h"
 
 /* Debugging stuff */
-#ifdef CONFIG_FB_S3C2410_DEBUG
-static int debug	= 1;
-#else
-static int debug;
-#endif
+static int debug = IS_BUILTIN(CONFIG_FB_S3C2410_DEBUG);
 
 #define dprintk(msg...) \
 do { \
