From: Christoph Hellwig <hch@lst.de>
Date: Fri, 01 Feb 2019 08:47:47 +0000
Subject: [PATCH 04/18] au1000_eth: pass struct device to DMA API functions
Message-Id: <20190201084801.10983-5-hch@lst.de>
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
 drivers/net/ethernet/amd/au1000_eth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index e833d1b3fe18..e5073aeea06a 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -1167,7 +1167,7 @@ static int au1000_probe(struct platform_device *pdev)
 	/* Allocate the data buffers
 	 * Snooping works fine with eth on all au1xxx
 	 */
-	aup->vaddr = (u32)dma_alloc_attrs(NULL, MAX_BUF_SIZE *
+	aup->vaddr = (u32)dma_alloc_attrs(&pdev->dev, MAX_BUF_SIZE *
 					  (NUM_TX_BUFFS + NUM_RX_BUFFS),
 					  &aup->dma_addr, 0,
 					  DMA_ATTR_NON_CONSISTENT);
@@ -1349,7 +1349,7 @@ static int au1000_probe(struct platform_device *pdev)
 err_remap2:
 	iounmap(aup->mac);
 err_remap1:
-	dma_free_attrs(NULL, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
+	dma_free_attrs(&pdev->dev, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
 			(void *)aup->vaddr, aup->dma_addr,
 			DMA_ATTR_NON_CONSISTENT);
 err_vaddr:
@@ -1383,7 +1383,7 @@ static int au1000_remove(struct platform_device *pdev)
 		if (aup->tx_db_inuse[i])
 			au1000_ReleaseDB(aup, aup->tx_db_inuse[i]);
 
-	dma_free_attrs(NULL, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
+	dma_free_attrs(&pdev->dev, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
 			(void *)aup->vaddr, aup->dma_addr,
 			DMA_ATTR_NON_CONSISTENT);
 
-- 
2.20.1
