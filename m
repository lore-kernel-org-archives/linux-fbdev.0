From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 12 Nov 2012 10:25:05 +0000
Subject: [PATCH 4/5] OMAP: common.c: remove init call to vram
Message-Id: <1352715906-16946-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

OMAP specific vram allocator is no longer used, and we can remove init
call to the vram allocator.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/common.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 111315a..d21ed18 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -17,7 +17,6 @@
 #include <linux/dma-mapping.h>
 
 #include <plat/common.h>
-#include <plat/vram.h>
 #include <linux/platform_data/dsp-omap.h>
 #include <plat/dma.h>
 
@@ -25,7 +24,6 @@
 
 void __init omap_reserve(void)
 {
-	omap_vram_reserve_sdram_memblock();
 	omap_dsp_reserve_sdram_memblock();
 	omap_secure_ram_reserve_memblock();
 	omap_barrier_reserve_memblock();
-- 
1.7.10.4

