From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Jan 2016 15:05:18 +0000
Subject: [PATCH] fbdev: da8xx-fb: remove incorrect type cast
Message-Id: <1453734351-1958373-1-git-send-email-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The probe function correct passes a dma_addr_t pointer into
dma_alloc_coherent(), but has a cast to resource_size_t, which
might be different from dma_addr_t:

drivers/video/fbdev/da8xx-fb.c: In function 'fb_probe':
drivers/video/fbdev/da8xx-fb.c:1431:10: error: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]

This removes the cast, which avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/da8xx-fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 0081725c6b5b..6b2a06d09f2b 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -152,7 +152,7 @@ static void lcdc_write(unsigned int val, unsigned int addr)
 
 struct da8xx_fb_par {
 	struct device		*dev;
-	resource_size_t p_palette_base;
+	dma_addr_t		p_palette_base;
 	unsigned char *v_palette_base;
 	dma_addr_t		vram_phys;
 	unsigned long		vram_size;
@@ -1428,7 +1428,7 @@ static int fb_probe(struct platform_device *device)
 
 	par->vram_virt = dma_alloc_coherent(NULL,
 					    par->vram_size,
-					    (resource_size_t *) &par->vram_phys,
+					    &par->vram_phys,
 					    GFP_KERNEL | GFP_DMA);
 	if (!par->vram_virt) {
 		dev_err(&device->dev,
@@ -1448,7 +1448,7 @@ static int fb_probe(struct platform_device *device)
 
 	/* allocate palette buffer */
 	par->v_palette_base = dma_zalloc_coherent(NULL, PALETTE_SIZE,
-						  (resource_size_t *)&par->p_palette_base,
+						  &par->p_palette_base,
 						  GFP_KERNEL | GFP_DMA);
 	if (!par->v_palette_base) {
 		dev_err(&device->dev,
-- 
2.7.0

