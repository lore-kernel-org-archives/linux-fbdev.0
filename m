From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 08:47:50 +0000
Subject: [PATCH 07/18] pxa168_eth: pass struct device to DMA API functions
Message-Id: <20190201084801.10983-8-hch@lst.de>
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

Note that this driver seems to entirely lack dma_map_single error
handling, but that is left for another time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/marvell/pxa168_eth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index f8a6d6e3cb7a..35f2142aac5e 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -201,6 +201,7 @@ struct tx_desc {
 };
 
 struct pxa168_eth_private {
+	struct platform_device *pdev;
 	int port_num;		/* User Ethernet port number    */
 	int phy_addr;
 	int phy_speed;
@@ -331,7 +332,7 @@ static void rxq_refill(struct net_device *dev)
 		used_rx_desc = pep->rx_used_desc_q;
 		p_used_rx_desc = &pep->p_rx_desc_area[used_rx_desc];
 		size = skb_end_pointer(skb) - skb->data;
-		p_used_rx_desc->buf_ptr = dma_map_single(NULL,
+		p_used_rx_desc->buf_ptr = dma_map_single(&pep->pdev->dev,
 							 skb->data,
 							 size,
 							 DMA_FROM_DEVICE);
@@ -743,7 +744,7 @@ static int txq_reclaim(struct net_device *dev, int force)
 				netdev_err(dev, "Error in TX\n");
 			dev->stats.tx_errors++;
 		}
-		dma_unmap_single(NULL, addr, count, DMA_TO_DEVICE);
+		dma_unmap_single(&pep->pdev->dev, addr, count, DMA_TO_DEVICE);
 		if (skb)
 			dev_kfree_skb_irq(skb);
 		released++;
@@ -805,7 +806,7 @@ static int rxq_process(struct net_device *dev, int budget)
 		if (rx_next_curr_desc = rx_used_desc)
 			pep->rx_resource_err = 1;
 		pep->rx_desc_count--;
-		dma_unmap_single(NULL, rx_desc->buf_ptr,
+		dma_unmap_single(&pep->pdev->dev, rx_desc->buf_ptr,
 				 rx_desc->buf_size,
 				 DMA_FROM_DEVICE);
 		received_packets++;
@@ -1274,7 +1275,8 @@ pxa168_eth_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	length = skb->len;
 	pep->tx_skb[tx_index] = skb;
 	desc->byte_cnt = length;
-	desc->buf_ptr = dma_map_single(NULL, skb->data, length, DMA_TO_DEVICE);
+	desc->buf_ptr = dma_map_single(&pep->pdev->dev, skb->data, length,
+					DMA_TO_DEVICE);
 
 	skb_tx_timestamp(skb);
 
@@ -1528,6 +1530,7 @@ static int pxa168_eth_probe(struct platform_device *pdev)
 	if (err)
 		goto err_free_mdio;
 
+	pep->pdev = pdev;
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	pxa168_init_hw(pep);
 	err = register_netdev(dev);
-- 
2.20.1
