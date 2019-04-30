From: Christoph Hellwig <hch@lst.de>
Date: Tue, 30 Apr 2019 11:00:31 +0000
Subject: [PATCH 6/7] nios2: use the generic uncached segment support in dma-direct
Message-Id: <20190430110032.25301-7-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de>
In-Reply-To: <20190430110032.25301-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Stop providing our own arch alloc/free hooks and just expose the segment
offset and use the generic dma-direct allocator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nios2/Kconfig            |  1 +
 arch/nios2/include/asm/page.h |  6 ------
 arch/nios2/mm/dma-mapping.c   | 34 +++++++++++++++-------------------
 3 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 4ef15a61b7bc..c87af5c77d24 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -4,6 +4,7 @@ config NIOS2
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_UNCACHED_SEGMENT
 	select ARCH_NO_SWAP
 	select TIMER_OF
 	select GENERIC_ATOMIC64
diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
index f1fbdc47bdaf..79fcac61f6ef 100644
--- a/arch/nios2/include/asm/page.h
+++ b/arch/nios2/include/asm/page.h
@@ -101,12 +101,6 @@ static inline bool pfn_valid(unsigned long pfn)
 # define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-# define UNCAC_ADDR(addr)	\
-	((void *)((unsigned)(addr) | CONFIG_NIOS2_IO_REGION_BASE))
-# define CAC_ADDR(addr)		\
-	((void *)(((unsigned)(addr) & ~CONFIG_NIOS2_IO_REGION_BASE) |	\
-		CONFIG_NIOS2_KERNEL_REGION_BASE))
-
 #include <asm-generic/memory_model.h>
 
 #include <asm-generic/getorder.h>
diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
index 4af9e5b5ba1c..9cb238664584 100644
--- a/arch/nios2/mm/dma-mapping.c
+++ b/arch/nios2/mm/dma-mapping.c
@@ -60,32 +60,28 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 	}
 }
 
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
+void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	void *ret;
+	unsigned long start = (unsigned long)page_address(page);
 
-	/* optimized page clearing */
-	gfp |= __GFP_ZERO;
+	flush_dcache_range(start, start + size);
+}
 
-	if (dev = NULL || (dev->coherent_dma_mask < 0xffffffff))
-		gfp |= GFP_DMA;
+void *uncached_kernel_address(void *ptr)
+{
+	unsigned long addr = (unsigned long)ptr;
 
-	ret = (void *) __get_free_pages(gfp, get_order(size));
-	if (ret != NULL) {
-		*dma_handle = virt_to_phys(ret);
-		flush_dcache_range((unsigned long) ret,
-			(unsigned long) ret + size);
-		ret = UNCAC_ADDR(ret);
-	}
+	addr |= CONFIG_NIOS2_IO_REGION_BASE;
 
-	return ret;
+	return (void *)ptr;
 }
 
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
+void *cached_kernel_address(void *ptr)
 {
-	unsigned long addr = (unsigned long) CAC_ADDR((unsigned long) vaddr);
+	unsigned long addr = (unsigned long)ptr;
+
+	addr &= ~CONFIG_NIOS2_IO_REGION_BASE;
+	addr |= CONFIG_NIOS2_KERNEL_REGION_BASE;
 
-	free_pages(addr, get_order(size));
+	return (void *)ptr;
 }
-- 
2.20.1
