From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Wed, 10 Nov 2010 09:45:19 +0000
Subject: [PATCH 2/3] OMAP: VRAM: Fix boot-time memory allocation
Message-Id: <1289382320-17412-2-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Use memblock_free() and memblock_remove() to remove the allocated or
reserved VRAM area from normal kernel memory.

This is a slightly modified version of patches from Felipe Contreras and
Namhyung Kim.

Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
Reported-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/vram.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index bb5ee06..2fd7e52 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -576,9 +576,12 @@ void __init omap_vram_reserve_sdram_memblock(void)
 			return;
 		}
 	} else {
-		paddr = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
+		paddr = memblock_alloc(size, PAGE_SIZE);
 	}
 
+	memblock_free(paddr, size);
+	memblock_remove(paddr, size);
+
 	omap_vram_add_region(paddr, size);
 
 	pr_info("Reserving %u bytes SDRAM for VRAM\n", size);
-- 
1.7.1

