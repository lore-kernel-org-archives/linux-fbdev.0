From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 12 Nov 2012 10:25:04 +0000
Subject: [PATCH 3/5] OMAP: RX51: remove use of vram
Message-Id: <1352715906-16946-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

As omapfb no longer uses omap specific vram allocator we can remove the
vram pre-allocation from rx51 board file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-rx51-video.c |   14 --------------
 arch/arm/mach-omap2/board-rx51.c       |    3 ---
 2 files changed, 17 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index c22e111..46f4fc9 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -16,7 +16,6 @@
 #include <linux/mm.h>
 #include <asm/mach-types.h>
 #include <video/omapdss.h>
-#include <plat/vram.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include "board-rx51.h"
@@ -87,17 +86,4 @@ static int __init rx51_video_init(void)
 }
 
 subsys_initcall(rx51_video_init);
-
-void __init rx51_video_mem_init(void)
-{
-	/*
-	 * GFX 864x480x32bpp
-	 * VID1/2 1280x720x32bpp double buffered
-	 */
-	omap_vram_set_sdram_vram(PAGE_ALIGN(864 * 480 * 4) +
-			2 * PAGE_ALIGN(1280 * 720 * 4 * 2), 0);
-}
-
-#else
-void __init rx51_video_mem_init(void) { }
 #endif /* defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE) */
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 7bbb05d..6e0de6f 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -34,8 +34,6 @@
 
 #define RX51_GPIO_SLEEP_IND 162
 
-extern void rx51_video_mem_init(void);
-
 static struct gpio_led gpio_leds[] = {
 	{
 		.name	= "sleep_ind",
@@ -112,7 +110,6 @@ static void __init rx51_init(void)
 
 static void __init rx51_reserve(void)
 {
-	rx51_video_mem_init();
 	omap_reserve();
 }
 
-- 
1.7.10.4

