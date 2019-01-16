From: Lubomir Rintel <lkundrak@v3.sk>
Date: Wed, 16 Jan 2019 15:14:54 +0000
Subject: [PATCH] video: fbdev: geode: remove ifdef OLPC noise
Message-Id: <20190116151453.1971999-1-lkundrak@v3.sk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>

<asm/olpc.h> provides olpc_has_dcon() stub for CONFIG_OLPC=n, compiler
should just optimize the unneeded bits away.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/video/fbdev/geode/gxfb_core.c | 13 ++-----------
 drivers/video/fbdev/geode/lxfb_core.c | 13 ++-----------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fbdev/geode/gxfb_core.c b/drivers/video/fbdev/geode/gxfb_core.c
index f4f76373b2a8..b1906cf5a8f0 100644
--- a/drivers/video/fbdev/geode/gxfb_core.c
+++ b/drivers/video/fbdev/geode/gxfb_core.c
@@ -33,6 +33,8 @@
 #include <linux/pci.h>
 #include <linux/cs5535.h>
 
+#include <asm/olpc.h>
+
 #include "gxfb.h"
 
 static char *mode_option;
@@ -107,9 +109,6 @@ static struct fb_videomode gx_modedb[] = {
 	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 };
 
-#ifdef CONFIG_OLPC
-#include <asm/olpc.h>
-
 static struct fb_videomode gx_dcon_modedb[] = {
 	/* The only mode the DCON has is 1200x900 */
 	{ NULL, 50, 1200, 900, 17460, 24, 8, 4, 5, 8, 3,
@@ -128,14 +127,6 @@ static void get_modedb(struct fb_videomode **modedb, unsigned int *size)
 	}
 }
 
-#else
-static void get_modedb(struct fb_videomode **modedb, unsigned int *size)
-{
-	*modedb = (struct fb_videomode *) gx_modedb;
-	*size = ARRAY_SIZE(gx_modedb);
-}
-#endif
-
 static int gxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	if (var->xres > 1600 || var->yres > 1200)
diff --git a/drivers/video/fbdev/geode/lxfb_core.c b/drivers/video/fbdev/geode/lxfb_core.c
index 138da6cb6cbc..17ab905811b1 100644
--- a/drivers/video/fbdev/geode/lxfb_core.c
+++ b/drivers/video/fbdev/geode/lxfb_core.c
@@ -23,6 +23,8 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 
+#include <asm/olpc.h>
+
 #include "lxfb.h"
 
 static char *mode_option;
@@ -216,9 +218,6 @@ static struct fb_videomode geode_modedb[] = {
 	  0, FB_VMODE_NONINTERLACED, 0 },
 };
 
-#ifdef CONFIG_OLPC
-#include <asm/olpc.h>
-
 static struct fb_videomode olpc_dcon_modedb[] = {
 	/* The only mode the DCON has is 1200x900 */
 	{ NULL, 50, 1200, 900, 17460, 24, 8, 4, 5, 8, 3,
@@ -237,14 +236,6 @@ static void get_modedb(struct fb_videomode **modedb, unsigned int *size)
 	}
 }
 
-#else
-static void get_modedb(struct fb_videomode **modedb, unsigned int *size)
-{
-	*modedb = (struct fb_videomode *) geode_modedb;
-	*size = ARRAY_SIZE(geode_modedb);
-}
-#endif
-
 static int lxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	if (var->xres > 1920 || var->yres > 1440)
-- 
2.20.1
