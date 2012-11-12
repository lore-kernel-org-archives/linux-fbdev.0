From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 12 Nov 2012 10:25:02 +0000
Subject: [PATCH 1/5] OMAP: FB: use DMA_BIT_MASK() for fb's coherent_dma_mask
Message-Id: <1352715906-16946-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use DMA_BIT_MASK() for fb's coherent_dma_mask for clarity.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/fb.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index bcbb9d5..218963b 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -29,6 +29,7 @@
 #include <linux/memblock.h>
 #include <linux/io.h>
 #include <linux/omapfb.h>
+#include <linux/dma-mapping.h>
 
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
@@ -45,7 +46,7 @@ static struct platform_device omap_fb_device = {
 	.id		= -1,
 	.dev = {
 		.dma_mask		= &omap_fb_dma_mask,
-		.coherent_dma_mask	= ~(u32)0,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &omapfb_config,
 	},
 	.num_resources = 0,
@@ -81,7 +82,7 @@ static struct platform_device omap_fb_device = {
 	.id		= -1,
 	.dev = {
 		.dma_mask		= &omap_fb_dma_mask,
-		.coherent_dma_mask	= ~(u32)0,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= &omapfb_config,
 	},
 	.num_resources = 0,
-- 
1.7.10.4

