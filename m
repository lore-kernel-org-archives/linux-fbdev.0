From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 08:47:48 +0000
Subject: [PATCH 05/18] macb_main: pass struct device to DMA API functions
Message-Id: <20190201084801.10983-6-hch@lst.de>
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
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2b2882615e8b..61a27963f1d1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3673,9 +3673,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		/* Store packet information (to free when Tx completed) */
 		lp->skb = skb;
 		lp->skb_length = skb->len;
-		lp->skb_physaddr = dma_map_single(NULL, skb->data, skb->len,
-							DMA_TO_DEVICE);
-		if (dma_mapping_error(NULL, lp->skb_physaddr)) {
+		lp->skb_physaddr = dma_map_single(&lp->pdev->dev, skb->data,
+						  skb->len, DMA_TO_DEVICE);
+		if (dma_mapping_error(&lp->pdev->dev, lp->skb_physaddr)) {
 			dev_kfree_skb_any(skb);
 			dev->stats.tx_dropped++;
 			netdev_err(dev, "%s: DMA mapping error\n", __func__);
@@ -3765,7 +3765,7 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 		if (lp->skb) {
 			dev_kfree_skb_irq(lp->skb);
 			lp->skb = NULL;
-			dma_unmap_single(NULL, lp->skb_physaddr,
+			dma_unmap_single(&lp->pdev->dev, lp->skb_physaddr,
 					 lp->skb_length, DMA_TO_DEVICE);
 			dev->stats.tx_packets++;
 			dev->stats.tx_bytes += lp->skb_length;
-- 
2.20.1
