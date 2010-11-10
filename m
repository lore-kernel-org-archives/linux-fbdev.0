From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Wed, 10 Nov 2010 09:45:18 +0000
Subject: [PATCH 1/3] OMAP: VRAM: improve VRAM error prints
Message-Id: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Improve the error prints to give more information about the offending
address & size.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/vram.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index fed2a72..bb5ee06 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -554,9 +554,15 @@ void __init omap_vram_reserve_sdram_memblock(void)
 	size = PAGE_ALIGN(size);
 
 	if (paddr) {
-		if ((paddr & ~PAGE_MASK) ||
-		    !memblock_is_region_memory(paddr, size)) {
-			pr_err("Illegal SDRAM region for VRAM\n");
+		if (paddr & ~PAGE_MASK) {
+			pr_err("VRAM start address 0x%08x not page aligned\n",
+					paddr);
+			return;
+		}
+
+		if (!memblock_is_region_memory(paddr, size)) {
+			pr_err("Illegal SDRAM region 0x%08x..0x%08x for VRAM\n",
+					paddr, paddr + size - 1);
 			return;
 		}
 
-- 
1.7.1

