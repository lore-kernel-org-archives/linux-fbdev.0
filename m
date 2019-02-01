From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 08:47:52 +0000
Subject: [PATCH 09/18] meth: pass struct device to DMA API functions
Message-Id: <20190201084801.10983-10-hch@lst.de>
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

Also use GFP_KERNEL instead of GFP_ATOMIC as the gfp_t for the memory
allocation, as we aren't in interrupt context or under a lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/sgi/meth.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/sgi/meth.c b/drivers/net/ethernet/sgi/meth.c
index 0e1b7e960b98..67954a9e3675 100644
--- a/drivers/net/ethernet/sgi/meth.c
+++ b/drivers/net/ethernet/sgi/meth.c
@@ -68,6 +68,8 @@ module_param(timeout, int, 0);
  * packets in and out, so there is place for a packet
  */
 struct meth_private {
+	struct platform_device *pdev;
+
 	/* in-memory copy of MAC Control register */
 	u64 mac_ctrl;
 
@@ -211,8 +213,8 @@ static void meth_check_link(struct net_device *dev)
 static int meth_init_tx_ring(struct meth_private *priv)
 {
 	/* Init TX ring */
-	priv->tx_ring = dma_alloc_coherent(NULL, TX_RING_BUFFER_SIZE,
-					   &priv->tx_ring_dma, GFP_ATOMIC);
+	priv->tx_ring = dma_alloc_coherent(&priv->pdev->dev,
+			TX_RING_BUFFER_SIZE, &priv->tx_ring_dma, GFP_KERNEL);
 	if (!priv->tx_ring)
 		return -ENOMEM;
 
@@ -236,7 +238,7 @@ static int meth_init_rx_ring(struct meth_private *priv)
 		priv->rx_ring[i]=(rx_packet*)(priv->rx_skbs[i]->head);
 		/* I'll need to re-sync it after each RX */
 		priv->rx_ring_dmas[i] -			dma_map_single(NULL, priv->rx_ring[i],
+			dma_map_single(&priv->pdev->dev, priv->rx_ring[i],
 				       METH_RX_BUFF_SIZE, DMA_FROM_DEVICE);
 		mace->eth.rx_fifo = priv->rx_ring_dmas[i];
 	}
@@ -253,7 +255,7 @@ static void meth_free_tx_ring(struct meth_private *priv)
 			dev_kfree_skb(priv->tx_skbs[i]);
 		priv->tx_skbs[i] = NULL;
 	}
-	dma_free_coherent(NULL, TX_RING_BUFFER_SIZE, priv->tx_ring,
+	dma_free_coherent(&priv->pdev->dev, TX_RING_BUFFER_SIZE, priv->tx_ring,
 	                  priv->tx_ring_dma);
 }
 
@@ -263,7 +265,7 @@ static void meth_free_rx_ring(struct meth_private *priv)
 	int i;
 
 	for (i = 0; i < RX_RING_ENTRIES; i++) {
-		dma_unmap_single(NULL, priv->rx_ring_dmas[i],
+		dma_unmap_single(&priv->pdev->dev, priv->rx_ring_dmas[i],
 				 METH_RX_BUFF_SIZE, DMA_FROM_DEVICE);
 		priv->rx_ring[i] = 0;
 		priv->rx_ring_dmas[i] = 0;
@@ -393,7 +395,8 @@ static void meth_rx(struct net_device* dev, unsigned long int_status)
 		fifo_rptr = (fifo_rptr - 1) & 0x0f;
 	}
 	while (priv->rx_write != fifo_rptr) {
-		dma_unmap_single(NULL, priv->rx_ring_dmas[priv->rx_write],
+		dma_unmap_single(&priv->pdev->dev,
+				 priv->rx_ring_dmas[priv->rx_write],
 				 METH_RX_BUFF_SIZE, DMA_FROM_DEVICE);
 		status = priv->rx_ring[priv->rx_write]->status.raw;
 #if MFE_DEBUG
@@ -454,7 +457,8 @@ static void meth_rx(struct net_device* dev, unsigned long int_status)
 		priv->rx_ring[priv->rx_write] = (rx_packet*)skb->head;
 		priv->rx_ring[priv->rx_write]->status.raw = 0;
 		priv->rx_ring_dmas[priv->rx_write] -			dma_map_single(NULL, priv->rx_ring[priv->rx_write],
+			dma_map_single(&priv->pdev->dev,
+				       priv->rx_ring[priv->rx_write],
 				       METH_RX_BUFF_SIZE, DMA_FROM_DEVICE);
 		mace->eth.rx_fifo = priv->rx_ring_dmas[priv->rx_write];
 		ADVANCE_RX_PTR(priv->rx_write);
@@ -637,7 +641,7 @@ static void meth_tx_1page_prepare(struct meth_private *priv,
 	}
 
 	/* first page */
-	catbuf = dma_map_single(NULL, buffer_data, buffer_len,
+	catbuf = dma_map_single(&priv->pdev->dev, buffer_data, buffer_len,
 				DMA_TO_DEVICE);
 	desc->data.cat_buf[0].form.start_addr = catbuf >> 3;
 	desc->data.cat_buf[0].form.len = buffer_len - 1;
@@ -663,12 +667,12 @@ static void meth_tx_2page_prepare(struct meth_private *priv,
 	}
 
 	/* first page */
-	catbuf1 = dma_map_single(NULL, buffer1_data, buffer1_len,
+	catbuf1 = dma_map_single(&priv->pdev->dev, buffer1_data, buffer1_len,
 				 DMA_TO_DEVICE);
 	desc->data.cat_buf[0].form.start_addr = catbuf1 >> 3;
 	desc->data.cat_buf[0].form.len = buffer1_len - 1;
 	/* second page */
-	catbuf2 = dma_map_single(NULL, buffer2_data, buffer2_len,
+	catbuf2 = dma_map_single(&priv->pdev->dev, buffer2_data, buffer2_len,
 				 DMA_TO_DEVICE);
 	desc->data.cat_buf[1].form.start_addr = catbuf2 >> 3;
 	desc->data.cat_buf[1].form.len = buffer2_len - 1;
@@ -840,6 +844,7 @@ static int meth_probe(struct platform_device *pdev)
 	memcpy(dev->dev_addr, o2meth_eaddr, ETH_ALEN);
 
 	priv = netdev_priv(dev);
+	priv->pdev = pdev;
 	spin_lock_init(&priv->meth_lock);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-- 
2.20.1
