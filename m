From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 08:47:57 +0000
Subject: [PATCH 14/18] da8xx-fb: pass struct device to DMA API functions
Message-Id: <20190201084801.10983-15-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de>
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: iommu@lists.linux-foundation.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/da8xx-fb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 43f2a4816860..ec62274b914b 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1097,9 +1097,9 @@ static int fb_remove(struct platform_device *dev)
 
 		unregister_framebuffer(info);
 		fb_dealloc_cmap(&info->cmap);
-		dma_free_coherent(NULL, PALETTE_SIZE, par->v_palette_base,
+		dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
 				  par->p_palette_base);
-		dma_free_coherent(NULL, par->vram_size, par->vram_virt,
+		dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
 				  par->vram_phys);
 		pm_runtime_put_sync(&dev->dev);
 		pm_runtime_disable(&dev->dev);
@@ -1425,7 +1425,7 @@ static int fb_probe(struct platform_device *device)
 	par->vram_size = roundup(par->vram_size/8, ulcm);
 	par->vram_size = par->vram_size * LCD_NUM_BUFFERS;
 
-	par->vram_virt = dma_alloc_coherent(NULL,
+	par->vram_virt = dma_alloc_coherent(par->dev,
 					    par->vram_size,
 					    &par->vram_phys,
 					    GFP_KERNEL | GFP_DMA);
@@ -1446,7 +1446,7 @@ static int fb_probe(struct platform_device *device)
 		da8xx_fb_fix.line_length - 1;
 
 	/* allocate palette buffer */
-	par->v_palette_base = dma_alloc_coherent(NULL, PALETTE_SIZE,
+	par->v_palette_base = dma_alloc_coherent(par->dev, PALETTE_SIZE,
 						 &par->p_palette_base,
 						 GFP_KERNEL | GFP_DMA);
 	if (!par->v_palette_base) {
@@ -1532,11 +1532,12 @@ static int fb_probe(struct platform_device *device)
 	fb_dealloc_cmap(&da8xx_fb_info->cmap);
 
 err_release_pl_mem:
-	dma_free_coherent(NULL, PALETTE_SIZE, par->v_palette_base,
+	dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
 			  par->p_palette_base);
 
 err_release_fb_mem:
-	dma_free_coherent(NULL, par->vram_size, par->vram_virt, par->vram_phys);
+	dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
+		          par->vram_phys);
 
 err_release_fb:
 	framebuffer_release(da8xx_fb_info);
-- 
2.20.1
