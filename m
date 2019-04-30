From: Christoph Hellwig <hch@lst.de>
Date: Tue, 30 Apr 2019 11:00:29 +0000
Subject: [PATCH 4/7] dma-direct: provide generic support for uncached kernel segments
Message-Id: <20190430110032.25301-5-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de>
In-Reply-To: <20190430110032.25301-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

A few architectures support uncached kernel segments.  In that case we get
an uncached mapping for a given physica address by using an offset in the
uncached segement.  Implement support for this scheme in the generic
dma-direct code instead of duplicating it in arch hooks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig                    |  8 ++++++++
 include/linux/dma-noncoherent.h |  3 +++
 kernel/dma/direct.c             | 18 ++++++++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 33687dddd86a..ea22a8c894ec 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -249,6 +249,14 @@ config ARCH_HAS_FORTIFY_SOURCE
 config ARCH_HAS_SET_MEMORY
 	bool
 
+#
+# Select if arch has an uncached kernel segment and provides the
+# uncached_kernel_address / cached_kernel_address symbols to use it
+#
+config ARCH_HAS_UNCACHED_SEGMENT
+	select ARCH_HAS_DMA_PREP_COHERENT
+	bool
+
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
        bool
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 9741767e400f..7e0126a04e02 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -80,4 +80,7 @@ static inline void arch_dma_prep_coherent(struct page *page, size_t size)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
 
+void *uncached_kernel_address(void *addr);
+void *cached_kernel_address(void *addr);
+
 #endif /* _LINUX_DMA_NONCOHERENT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 2c2772e9702a..d15a535c3e67 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -164,6 +164,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	}
 
 	ret = page_address(page);
+
+	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
+	    !dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
+		arch_dma_prep_coherent(page, size);
+		ret = uncached_kernel_address(ret);
+	}
+
 	if (force_dma_unencrypted()) {
 		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
 		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
@@ -171,6 +178,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	}
 	memset(ret, 0, size);
+
 	return ret;
 }
 
@@ -189,13 +197,18 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 
 	if (force_dma_unencrypted())
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
+
+	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
+	    !dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT))
+		cpu_addr = cached_kernel_address(cpu_addr);
 	__dma_direct_free_pages(dev, size, virt_to_page(cpu_addr));
 }
 
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	if (!dev_is_dma_coherent(dev))
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
+	    !dev_is_dma_coherent(dev))
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 	return dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
 }
@@ -203,7 +216,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
-	if (!dev_is_dma_coherent(dev))
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
+	    !dev_is_dma_coherent(dev))
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
 	else
 		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
-- 
2.20.1
