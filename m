From: Joe Perches <joe@perches.com>
Date: Sun, 15 Jun 2014 20:37:54 +0000
Subject: [PATCH -next 25/26] fbdev: Use dma_zalloc_coherent
Message-Id: <881b8f8d85c96b6e9d8735aa10bbf18468688b9d.1402863905.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1402863904.git.joe@perches.com>
In-Reply-To: <cover.1402863904.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Use the zeroing function instead of dma_alloc_coherent & memset(,0,)

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/da8xx-fb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index a8484f7..788f6b3 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1447,18 +1447,15 @@ static int fb_probe(struct platform_device *device)
 		da8xx_fb_fix.line_length - 1;
 
 	/* allocate palette buffer */
-	par->v_palette_base = dma_alloc_coherent(NULL,
-					       PALETTE_SIZE,
-					       (resource_size_t *)
-					       &par->p_palette_base,
-					       GFP_KERNEL | GFP_DMA);
+	par->v_palette_base = dma_zalloc_coherent(NULL, PALETTE_SIZE,
+						  (resource_size_t *)&par->p_palette_base,
+						  GFP_KERNEL | GFP_DMA);
 	if (!par->v_palette_base) {
 		dev_err(&device->dev,
 			"GLCD: kmalloc for palette buffer failed\n");
 		ret = -EINVAL;
 		goto err_release_fb_mem;
 	}
-	memset(par->v_palette_base, 0, PALETTE_SIZE);
 
 	par->irq = platform_get_irq(device, 0);
 	if (par->irq < 0) {
-- 
1.8.1.2.459.gbcd45b4.dirty

