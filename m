From: Christoph Hellwig <hch@lst.de>
Date: Thu, 21 Mar 2019 22:52:31 +0000
Subject: [PATCH 3/7] gbefb: switch to managed version of the DMA allocator
Message-Id: <20190321225235.30648-4-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190321225235.30648-1-hch@lst.de>
In-Reply-To: <20190321225235.30648-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@armlinux.org.uk>, x86@kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

gbefb uses managed resources, so it should do the same for DMA
allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/gbefb.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 1a242b1338e9..3fcb33232ba3 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -1162,9 +1162,9 @@ static int gbefb_probe(struct platform_device *p_dev)
 	}
 	gbe_revision = gbe->ctrlstat & 15;
 
-	gbe_tiles.cpu -		dma_alloc_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
-				   &gbe_tiles.dma, GFP_KERNEL);
+	gbe_tiles.cpu = dmam_alloc_coherent(&p_dev->dev,
+				GBE_TLB_SIZE * sizeof(uint16_t),
+				&gbe_tiles.dma, GFP_KERNEL);
 	if (!gbe_tiles.cpu) {
 		printk(KERN_ERR "gbefb: couldn't allocate tiles table\n");
 		ret = -ENOMEM;
@@ -1178,19 +1178,20 @@ static int gbefb_probe(struct platform_device *p_dev)
 		if (!gbe_mem) {
 			printk(KERN_ERR "gbefb: couldn't map framebuffer\n");
 			ret = -ENOMEM;
-			goto out_tiles_free;
+			goto out_release_mem_region;
 		}
 
 		gbe_dma_addr = 0;
 	} else {
 		/* try to allocate memory with the classical allocator
 		 * this has high chance to fail on low memory machines */
-		gbe_mem = dma_alloc_wc(NULL, gbe_mem_size, &gbe_dma_addr,
-				       GFP_KERNEL);
+		gbe_mem = dmam_alloc_attrs(&p_dev->dev, gbe_mem_size,
+				&gbe_dma_addr, GFP_KERNEL,
+				DMA_ATTR_WRITE_COMBINE);
 		if (!gbe_mem) {
 			printk(KERN_ERR "gbefb: couldn't allocate framebuffer memory\n");
 			ret = -ENOMEM;
-			goto out_tiles_free;
+			goto out_release_mem_region;
 		}
 
 		gbe_mem_phys = (unsigned long) gbe_dma_addr;
@@ -1237,11 +1238,6 @@ static int gbefb_probe(struct platform_device *p_dev)
 
 out_gbe_unmap:
 	arch_phys_wc_del(par->wc_cookie);
-	if (gbe_dma_addr)
-		dma_free_wc(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
-out_tiles_free:
-	dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
-			  (void *)gbe_tiles.cpu, gbe_tiles.dma);
 out_release_mem_region:
 	release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
 out_release_framebuffer:
@@ -1258,10 +1254,6 @@ static int gbefb_remove(struct platform_device* p_dev)
 	unregister_framebuffer(info);
 	gbe_turn_off();
 	arch_phys_wc_del(par->wc_cookie);
-	if (gbe_dma_addr)
-		dma_free_wc(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
-	dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
-			  (void *)gbe_tiles.cpu, gbe_tiles.dma);
 	release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
 	gbefb_remove_sysfs(&p_dev->dev);
 	framebuffer_release(info);
-- 
2.20.1
