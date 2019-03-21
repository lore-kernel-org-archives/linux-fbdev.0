From: Christoph Hellwig <hch@lst.de>
Date: Thu, 21 Mar 2019 22:52:32 +0000
Subject: [PATCH 4/7] pxa3xx-gcu: pass struct device to dma_mmap_coherent
Message-Id: <20190321225235.30648-5-hch@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190321225235.30648-1-hch@lst.de>
In-Reply-To: <20190321225235.30648-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@armlinux.org.uk>, x86@kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Just like we do for all other DMA operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 69cfb337c857..047a2fa4b87e 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -96,6 +96,7 @@ struct pxa3xx_gcu_batch {
 };
 
 struct pxa3xx_gcu_priv {
+	struct device		 *dev;
 	void __iomem		 *mmio_base;
 	struct clk		 *clk;
 	struct pxa3xx_gcu_shared *shared;
@@ -493,7 +494,7 @@ pxa3xx_gcu_mmap(struct file *file, struct vm_area_struct *vma)
 		if (size != SHARED_SIZE)
 			return -EINVAL;
 
-		return dma_mmap_coherent(NULL, vma,
+		return dma_mmap_coherent(priv->dev, vma,
 			priv->shared, priv->shared_phys, size);
 
 	case SHARED_SIZE >> PAGE_SHIFT:
@@ -670,6 +671,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 	priv->resource_mem = r;
+	priv->dev = dev;
 	pxa3xx_gcu_reset(priv);
 	pxa3xx_gcu_init_debug_timer(priv);
 
-- 
2.20.1
