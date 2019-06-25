From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2019 16:34:34 +0000
Subject: [PATCH 12/12] fbdev: da8xx: use resource management for dma
Message-Id: <20190625163434.13620-13-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625163434.13620-1-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use managed variants of dma alloc functions in the da8xx fbdev driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/fbdev/da8xx-fb.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 6b11a8108108..22f79b3c2326 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1087,10 +1087,6 @@ static int fb_remove(struct platform_device *dev)
 
 	unregister_framebuffer(info);
 	fb_dealloc_cmap(&info->cmap);
-	dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
-			  par->p_palette_base);
-	dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
-			  par->vram_phys);
 	pm_runtime_put_sync(&dev->dev);
 	pm_runtime_disable(&dev->dev);
 	framebuffer_release(info);
@@ -1428,10 +1424,10 @@ static int fb_probe(struct platform_device *device)
 	par->vram_size = roundup(par->vram_size/8, ulcm);
 	par->vram_size = par->vram_size * LCD_NUM_BUFFERS;
 
-	par->vram_virt = dma_alloc_coherent(par->dev,
-					    par->vram_size,
-					    &par->vram_phys,
-					    GFP_KERNEL | GFP_DMA);
+	par->vram_virt = dmam_alloc_coherent(par->dev,
+					     par->vram_size,
+					     &par->vram_phys,
+					     GFP_KERNEL | GFP_DMA);
 	if (!par->vram_virt) {
 		dev_err(&device->dev,
 			"GLCD: kmalloc for frame buffer failed\n");
@@ -1449,20 +1445,20 @@ static int fb_probe(struct platform_device *device)
 		da8xx_fb_fix.line_length - 1;
 
 	/* allocate palette buffer */
-	par->v_palette_base = dma_alloc_coherent(par->dev, PALETTE_SIZE,
-						 &par->p_palette_base,
-						 GFP_KERNEL | GFP_DMA);
+	par->v_palette_base = dmam_alloc_coherent(par->dev, PALETTE_SIZE,
+						  &par->p_palette_base,
+						  GFP_KERNEL | GFP_DMA);
 	if (!par->v_palette_base) {
 		dev_err(&device->dev,
 			"GLCD: kmalloc for palette buffer failed\n");
 		ret = -EINVAL;
-		goto err_release_fb_mem;
+		goto err_release_fb;
 	}
 
 	par->irq = platform_get_irq(device, 0);
 	if (par->irq < 0) {
 		ret = -ENOENT;
-		goto err_release_pl_mem;
+		goto err_release_fb;
 	}
 
 	da8xx_fb_var.grayscale @@ -1480,7 +1476,7 @@ static int fb_probe(struct platform_device *device)
 
 	ret = fb_alloc_cmap(&da8xx_fb_info->cmap, PALETTE_SIZE, 0);
 	if (ret)
-		goto err_release_pl_mem;
+		goto err_release_fb;
 	da8xx_fb_info->cmap.len = par->palette_sz;
 
 	/* initialize var_screeninfo */
@@ -1534,14 +1530,6 @@ static int fb_probe(struct platform_device *device)
 err_dealloc_cmap:
 	fb_dealloc_cmap(&da8xx_fb_info->cmap);
 
-err_release_pl_mem:
-	dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
-			  par->p_palette_base);
-
-err_release_fb_mem:
-	dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
-		          par->vram_phys);
-
 err_release_fb:
 	framebuffer_release(da8xx_fb_info);
 
-- 
2.21.0
