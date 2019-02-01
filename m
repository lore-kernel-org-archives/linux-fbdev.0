From: Robin Murphy <robin.murphy@arm.com>
Date: Fri, 01 Feb 2019 14:14:34 +0000
Subject: Re: [PATCH 10/18] smc911x: pass struct device to DMA API functions
Message-Id: <a8653acc-e0db-69a1-a8d3-2190f3767ce3@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de>
 <20190201084801.10983-11-hch@lst.de>
In-Reply-To: <20190201084801.10983-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: iommu@lists.linux-foundation.org

On 01/02/2019 08:47, Christoph Hellwig wrote:
> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.

Hmm, as far as I'm aware these are PIO chips with external DMA 
handshaking, rather than actual DMA masters...

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/net/ethernet/smsc/smc911x.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
> index 8355dfbb8ec3..b550e624500d 100644
> --- a/drivers/net/ethernet/smsc/smc911x.c
> +++ b/drivers/net/ethernet/smsc/smc911x.c
> @@ -1188,7 +1188,7 @@ smc911x_tx_dma_irq(void *data)
>   
>   	DBG(SMC_DEBUG_TX | SMC_DEBUG_DMA, dev, "TX DMA irq handler\n");
>   	BUG_ON(skb = NULL);
> -	dma_unmap_single(NULL, tx_dmabuf, tx_dmalen, DMA_TO_DEVICE);
> +	dma_unmap_single(lp->dev, tx_dmabuf, tx_dmalen, DMA_TO_DEVICE);

..so while the wrong device is still better than no device at all, this 
probably wants lp->txdma->device->dev.

>   	netif_trans_update(dev);
>   	dev_kfree_skb_irq(skb);
>   	lp->current_tx_skb = NULL;
> @@ -1219,7 +1219,7 @@ smc911x_rx_dma_irq(void *data)
>   
>   	DBG(SMC_DEBUG_FUNC, dev, "--> %s\n", __func__);
>   	DBG(SMC_DEBUG_RX | SMC_DEBUG_DMA, dev, "RX DMA irq handler\n");
> -	dma_unmap_single(NULL, rx_dmabuf, rx_dmalen, DMA_FROM_DEVICE);
> +	dma_unmap_single(lp->dev, rx_dmabuf, rx_dmalen, DMA_FROM_DEVICE);

And equivalently for rxdma here. However, given that this all seems only 
relevant to antique ARCH_PXA platforms which are presumably managing to 
work as-is, it's probably not worth tinkering too much. I'd just stick a 
note in the commit message that we're still only making these 
self-consistent with the existing dma_map_single() calls rather than 
necessarily correct.

Robin.

>   	BUG_ON(skb = NULL);
>   	lp->current_rx_skb = NULL;
>   	PRINT_PKT(skb->data, skb->len);
> 
