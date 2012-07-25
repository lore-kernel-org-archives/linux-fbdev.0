From: Hideki EIRAKU <hdk@igel.co.jp>
Date: Wed, 25 Jul 2012 06:29:22 +0000
Subject: [PATCH 1/3] ARM: dma-mapping: define ARCH_HAS_DMA_MMAP_COHERENT
Message-Id: <1343197764-13659-2-git-send-email-hdk@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343197764-13659-1-git-send-email-hdk@igel.co.jp>
In-Reply-To: <1343197764-13659-1-git-send-email-hdk@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

ARCH_HAS_DMA_MMAP_COHERENT indicates that there is dma_mmap_coherent() API
in this architecture.  The name is already defined in PowerPC.

Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>
---
 arch/arm/include/asm/dma-mapping.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index bbef15d..f41cd30 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -187,6 +187,7 @@ extern int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 			struct dma_attrs *attrs);
 
 #define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, NULL)
+#define ARCH_HAS_DMA_MMAP_COHERENT
 
 static inline int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 				  void *cpu_addr, dma_addr_t dma_addr,
-- 
1.7.0.4

