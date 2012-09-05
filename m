From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 05 Sep 2012 08:25:44 +0000
Subject: [PATCH 06/17] OMAPDSS: VRAM: Remove clearing with sDMA
Message-Id: <1346833555-31258-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Currently vram.c clears the allocated memory automatically using OMAP
system DMA. In an effort to reduce OMAP dependencies, we'll do the
memory clear with CPU from now on.

The previous patch implemented memory clear in the omapfb driver, and
this patch removes the now obsolete clear functionality from vram.c.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---
 drivers/video/omap2/vram.c |   56 --------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index 87e421e..f2b15c4 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -34,7 +34,6 @@
 #include <asm/setup.h>
 
 #include <plat/vram.h>
-#include <plat/dma.h>
 
 #ifdef DEBUG
 #define DBG(format, ...) pr_debug("VRAM: " format, ## __VA_ARGS__)
@@ -250,59 +249,6 @@ int omap_vram_reserve(unsigned long paddr, size_t size)
 }
 EXPORT_SYMBOL(omap_vram_reserve);
 
-static void _omap_vram_dma_cb(int lch, u16 ch_status, void *data)
-{
-	struct completion *compl = data;
-	complete(compl);
-}
-
-static int _omap_vram_clear(u32 paddr, unsigned pages)
-{
-	struct completion compl;
-	unsigned elem_count;
-	unsigned frame_count;
-	int r;
-	int lch;
-
-	init_completion(&compl);
-
-	r = omap_request_dma(OMAP_DMA_NO_DEVICE, "VRAM DMA",
-			_omap_vram_dma_cb,
-			&compl, &lch);
-	if (r) {
-		pr_err("VRAM: request_dma failed for memory clear\n");
-		return -EBUSY;
-	}
-
-	elem_count = pages * PAGE_SIZE / 4;
-	frame_count = 1;
-
-	omap_set_dma_transfer_params(lch, OMAP_DMA_DATA_TYPE_S32,
-			elem_count, frame_count,
-			OMAP_DMA_SYNC_ELEMENT,
-			0, 0);
-
-	omap_set_dma_dest_params(lch, 0, OMAP_DMA_AMODE_POST_INC,
-			paddr, 0, 0);
-
-	omap_set_dma_color_mode(lch, OMAP_DMA_CONSTANT_FILL, 0x000000);
-
-	omap_start_dma(lch);
-
-	if (wait_for_completion_timeout(&compl, msecs_to_jiffies(1000)) = 0) {
-		omap_stop_dma(lch);
-		pr_err("VRAM: dma timeout while clearing memory\n");
-		r = -EIO;
-		goto err;
-	}
-
-	r = 0;
-err:
-	omap_free_dma(lch);
-
-	return r;
-}
-
 static int _omap_vram_alloc(unsigned pages, unsigned long *paddr)
 {
 	struct vram_region *rm;
@@ -337,8 +283,6 @@ found:
 
 		*paddr = start;
 
-		_omap_vram_clear(start, pages);
-
 		return 0;
 	}
 
-- 
1.7.9.5

