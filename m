From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 05 Sep 2012 08:25:41 +0000
Subject: [PATCH 03/17] OMAPFB1: remove a non-used table
Message-Id: <1346833555-31258-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The old omapfb driver contains a table for DMA element types, which is
not used. Remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap/omapfb_main.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index f54b463..4351c43 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -131,15 +131,6 @@ static void omapfb_rqueue_unlock(struct omapfb_device *fbdev)
  * LCD controller and LCD DMA
  * ---------------------------------------------------------------------------
  */
-/* Lookup table to map elem size to elem type. */
-static const int dma_elem_type[] = {
-	0,
-	OMAP_DMA_DATA_TYPE_S8,
-	OMAP_DMA_DATA_TYPE_S16,
-	0,
-	OMAP_DMA_DATA_TYPE_S32,
-};
-
 /*
  * Allocate resources needed for LCD controller and LCD DMA operations. Video
  * memory is allocated from system memory according to the virtual display
-- 
1.7.9.5

