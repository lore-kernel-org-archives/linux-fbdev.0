From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 30 Jul 2011 20:26:55 +0000
Subject: [PATCH 4/4] fbdev: sh_mobile_meram: Remove unneeded sh_mobile_meram.h
Message-Id: <1312057615-29123-5-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The drivers/video/sh_mobile_meram.h header contains unused definitions
and declarations. Move the only used macro to sh_mobile_meram.c, and
remove the header.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 drivers/video/sh_mobile_meram.c  |    5 +++--
 drivers/video/sh_mobile_meram.h  |   33 ---------------------------------
 3 files changed, 4 insertions(+), 36 deletions(-)
 delete mode 100644 drivers/video/sh_mobile_meram.h

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index d0f768e..93e10ef 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -24,10 +24,10 @@
 #include <linux/backlight.h>
 #include <linux/gpio.h>
 #include <video/sh_mobile_lcdc.h>
+#include <video/sh_mobile_meram.h>
 #include <asm/atomic.h>
 
 #include "sh_mobile_lcdcfb.h"
-#include "sh_mobile_meram.h"
 
 #define SIDE_B_OFFSET 0x1000
 #define MIRROR_OFFSET 0x2000
diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 7ba6dce..f632970 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -16,8 +16,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
-
-#include "sh_mobile_meram.h"
+#include <video/sh_mobile_meram.h>
 
 /* meram registers */
 #define MEVCR1			0x4
@@ -82,6 +81,8 @@
 	 ((yszm1) << MExxBSIZE_YSZM1_SHIFT) | \
 	 ((xszm1) << MExxBSIZE_XSZM1_SHIFT))
 
+#define SH_MOBILE_MERAM_ICB_NUM		32
+
 static unsigned long common_regs[] = {
 	MEVCR1,
 	MEQSEL1,
diff --git a/drivers/video/sh_mobile_meram.h b/drivers/video/sh_mobile_meram.h
deleted file mode 100644
index 1615204..0000000
--- a/drivers/video/sh_mobile_meram.h
+++ /dev/null
@@ -1,33 +0,0 @@
-#ifndef __sh_mobile_meram_h__
-#define __sh_mobile_meram_h__
-
-#include <linux/mutex.h>
-#include <video/sh_mobile_meram.h>
-
-/*
- * MERAM private
- */
-
-#define MERAM_ICB_Y 0x1
-#define MERAM_ICB_C 0x2
-
-/* MERAM cache size */
-#define SH_MOBILE_MERAM_ICB_NUM		32
-
-#define SH_MOBILE_MERAM_CACHE_OFFSET(p)	((p) >> 16)
-#define SH_MOBILE_MERAM_CACHE_SIZE(p)	((p) & 0xffff)
-
-int sh_mobile_meram_alloc_icb(const struct sh_mobile_meram_cfg *cfg,
-		   int xres,
-		   int yres,
-		   unsigned int base_addr,
-		   int yuv_mode,
-		   int *marker_icb,
-		   int *out_pitch);
-
-void sh_mobile_meram_free_icb(int marker_icb);
-
-#define SH_MOBILE_MERAM_START(ind, ab) \
-	(0xC0000000 | ((ab & 0x1) << 23) | ((ind & 0x1F) << 24))
-
-#endif /* !__sh_mobile_meram_h__ */
-- 
1.7.3.4

