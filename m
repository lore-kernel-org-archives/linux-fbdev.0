From: Christoph Hellwig <hch@lst.de>
Date: Tue, 30 Apr 2019 11:00:26 +0000
Subject: [PATCH 1/7] MIPS: remove the _dma_cache_wback_inv export
Message-Id: <20190430110032.25301-2-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de>
In-Reply-To: <20190430110032.25301-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

This export is not used in modular code, which is a good thing as
everyone should use the proper DMA API instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/mm/cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 3da216988672..33b409391ddb 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -62,8 +62,6 @@ void (*_dma_cache_wback_inv)(unsigned long start, unsigned long size);
 void (*_dma_cache_wback)(unsigned long start, unsigned long size);
 void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
-EXPORT_SYMBOL(_dma_cache_wback_inv);
-
 #endif /* CONFIG_DMA_NONCOHERENT */
 
 /*
-- 
2.20.1
