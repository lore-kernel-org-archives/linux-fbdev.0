From: Christoph Hellwig <hch@lst.de>
Date: Thu, 21 Mar 2019 22:52:34 +0000
Subject: [PATCH 6/7] dma-mapping: remove leftover NULL device support
Message-Id: <20190321225235.30648-7-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190321225235.30648-1-hch@lst.de>
In-Reply-To: <20190321225235.30648-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@armlinux.org.uk>, x86@kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Most dma_map_ops implementations already had some issues with a NULL
device, or did simply crash if one was fed to them.  Now that we have
cleaned up all the obvious offenders we can stop to pretend we
support this mode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API-HOWTO.txt | 13 ++++++-------
 include/linux/dma-mapping.h     |  6 +++---
 kernel/dma/direct.c             |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index 1a721d0f35c8..0e98cf7466dd 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -365,13 +365,12 @@ __get_free_pages() (but takes size instead of a page order).  If your
 driver needs regions sized smaller than a page, you may prefer using
 the dma_pool interface, described below.
 
-The consistent DMA mapping interfaces, for non-NULL dev, will by
-default return a DMA address which is 32-bit addressable.  Even if the
-device indicates (via DMA mask) that it may address the upper 32-bits,
-consistent allocation will only return > 32-bit addresses for DMA if
-the consistent DMA mask has been explicitly changed via
-dma_set_coherent_mask().  This is true of the dma_pool interface as
-well.
+The consistent DMA mapping interfaces, will by default return a DMA address
+which is 32-bit addressable.  Even if the device indicates (via the DMA mask)
+that it may address the upper 32-bits, consistent allocation will only
+return > 32-bit addresses for DMA if the consistent DMA mask has been
+explicitly changed via dma_set_coherent_mask().  This is true of the
+dma_pool interface as well.
 
 dma_alloc_coherent() returns two values: the virtual address which you
 can use to access it from the CPU and dma_handle which you pass to the
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 75e60be91e5f..6309a721394b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -267,9 +267,9 @@ size_t dma_direct_max_mapping_size(struct device *dev);
 
 static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-	if (dev && dev->dma_ops)
+	if (dev->dma_ops)
 		return dev->dma_ops;
-	return get_arch_dma_ops(dev ? dev->bus : NULL);
+	return get_arch_dma_ops(dev->bus);
 }
 
 static inline void set_dma_ops(struct device *dev,
@@ -650,7 +650,7 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 
 static inline u64 dma_get_mask(struct device *dev)
 {
-	if (dev && dev->dma_mask && *dev->dma_mask)
+	if (dev->dma_mask && *dev->dma_mask)
 		return *dev->dma_mask;
 	return DMA_BIT_MASK(32);
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index fcdb23e8d2fc..2c2772e9702a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -311,7 +311,7 @@ static inline bool dma_direct_possible(struct device *dev, dma_addr_t dma_addr,
 		size_t size)
 {
 	return swiotlb_force != SWIOTLB_FORCE &&
-		(!dev || dma_capable(dev, dma_addr, size));
+		dma_capable(dev, dma_addr, size);
 }
 
 dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
-- 
2.20.1
