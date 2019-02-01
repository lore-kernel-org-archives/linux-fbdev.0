From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 08:47:45 +0000
Subject: [PATCH 02/18] dmaengine: imx-sdma: pass struct device to DMA API functions
Message-Id: <20190201084801.10983-3-hch@lst.de>
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
 drivers/dma/imx-sdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 86708fb9bda1..0b6bba0b9f38 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -677,7 +677,7 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 	int ret;
 	unsigned long flags;
 
-	buf_virt = dma_alloc_coherent(NULL, size, &buf_phys, GFP_KERNEL);
+	buf_virt = dma_alloc_coherent(sdma->dev, size, &buf_phys, GFP_KERNEL);
 	if (!buf_virt) {
 		return -ENOMEM;
 	}
@@ -696,7 +696,7 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
-	dma_free_coherent(NULL, size, buf_virt, buf_phys);
+	dma_free_coherent(sdma->dev, size, buf_virt, buf_phys);
 
 	return ret;
 }
@@ -1182,8 +1182,8 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
 {
 	int ret = -EBUSY;
 
-	sdma->bd0 = dma_alloc_coherent(NULL, PAGE_SIZE, &sdma->bd0_phys,
-				       GFP_NOWAIT);
+	sdma->bd0 = dma_alloc_coherent(sdma->dev, PAGE_SIZE, &sdma->bd0_phys,
+					GFP_NOWAIT);
 	if (!sdma->bd0) {
 		ret = -ENOMEM;
 		goto out;
@@ -1842,7 +1842,7 @@ static int sdma_init(struct sdma_engine *sdma)
 	/* Be sure SDMA has not started yet */
 	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
 
-	sdma->channel_control = dma_alloc_coherent(NULL,
+	sdma->channel_control = dma_alloc_coherent(sdma->dev,
 			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control) +
 			sizeof(struct sdma_context_data),
 			&ccb_phys, GFP_KERNEL);
-- 
2.20.1
