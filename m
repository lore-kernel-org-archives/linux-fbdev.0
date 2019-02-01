From: Robin Murphy <robin.murphy@arm.com>
Date: Fri, 01 Feb 2019 13:53:09 +0000
Subject: Re: [PATCH 03/18] net: caif: pass struct device to DMA API functions
Message-Id: <1cafba51-b652-5457-0dd7-77d64264c85e@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de>
 <20190201084801.10983-4-hch@lst.de>
In-Reply-To: <20190201084801.10983-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: iommu@lists.linux-foundation.org

On 01/02/2019 08:47, Christoph Hellwig wrote:
> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.
> 
> Also use the proper Kconfig symbol to check for DMA API availability.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/net/caif/caif_spi.c | 30 ++++++++++++++++--------------
>   1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/caif/caif_spi.c b/drivers/net/caif/caif_spi.c
> index d28a1398c091..b7f3e263b57c 100644
> --- a/drivers/net/caif/caif_spi.c
> +++ b/drivers/net/caif/caif_spi.c
> @@ -73,35 +73,37 @@ MODULE_PARM_DESC(spi_down_tail_align, "SPI downlink tail alignment.");
>   #define LOW_WATER_MARK   100
>   #define HIGH_WATER_MARK  (LOW_WATER_MARK*5)
>   
> -#ifdef CONFIG_UML
> +#ifdef CONFIG_HAS_DMA

#ifndef, surely?

Robin.

>   
>   /*
>    * We sometimes use UML for debugging, but it cannot handle
>    * dma_alloc_coherent so we have to wrap it.
>    */
> -static inline void *dma_alloc(dma_addr_t *daddr)
> +static inline void *dma_alloc(struct cfspi *cfspi, dma_addr_t *daddr)
>   {
>   	return kmalloc(SPI_DMA_BUF_LEN, GFP_KERNEL);
>   }
>   
> -static inline void dma_free(void *cpu_addr, dma_addr_t handle)
> +static inline void dma_free(struct cfspi *cfspi, void *cpu_addr,
> +		dma_addr_t handle)
>   {
>   	kfree(cpu_addr);
>   }
>   
>   #else
>   
> -static inline void *dma_alloc(dma_addr_t *daddr)
> +static inline void *dma_alloc(struct cfspi *cfspi, dma_addr_t *daddr)
>   {
> -	return dma_alloc_coherent(NULL, SPI_DMA_BUF_LEN, daddr,
> +	return dma_alloc_coherent(&cfspi->pdev->dev, SPI_DMA_BUF_LEN, daddr,
>   				GFP_KERNEL);
>   }
>   
> -static inline void dma_free(void *cpu_addr, dma_addr_t handle)
> +static inline void dma_free(struct cfspi *cfspi, void *cpu_addr,
> +		dma_addr_t handle)
>   {
> -	dma_free_coherent(NULL, SPI_DMA_BUF_LEN, cpu_addr, handle);
> +	dma_free_coherent(&cfspi->pdev->dev, SPI_DMA_BUF_LEN, cpu_addr, handle);
>   }
> -#endif	/* CONFIG_UML */
> +#endif	/* CONFIG_HAS_DMA */
>   
>   #ifdef CONFIG_DEBUG_FS
>   
> @@ -610,13 +612,13 @@ static int cfspi_init(struct net_device *dev)
>   	}
>   
>   	/* Allocate DMA buffers. */
> -	cfspi->xfer.va_tx[0] = dma_alloc(&cfspi->xfer.pa_tx[0]);
> +	cfspi->xfer.va_tx[0] = dma_alloc(cfspi, &cfspi->xfer.pa_tx[0]);
>   	if (!cfspi->xfer.va_tx[0]) {
>   		res = -ENODEV;
>   		goto err_dma_alloc_tx_0;
>   	}
>   
> -	cfspi->xfer.va_rx = dma_alloc(&cfspi->xfer.pa_rx);
> +	cfspi->xfer.va_rx = dma_alloc(cfspi, &cfspi->xfer.pa_rx);
>   
>   	if (!cfspi->xfer.va_rx) {
>   		res = -ENODEV;
> @@ -665,9 +667,9 @@ static int cfspi_init(struct net_device *dev)
>   	return 0;
>   
>    err_create_wq:
> -	dma_free(cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
> +	dma_free(cfspi, cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
>    err_dma_alloc_rx:
> -	dma_free(cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
> +	dma_free(cfspi, cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
>    err_dma_alloc_tx_0:
>   	return res;
>   }
> @@ -683,8 +685,8 @@ static void cfspi_uninit(struct net_device *dev)
>   
>   	cfspi->ndev = NULL;
>   	/* Free DMA buffers. */
> -	dma_free(cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
> -	dma_free(cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
> +	dma_free(cfspi, cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
> +	dma_free(cfspi, cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
>   	set_bit(SPI_TERMINATE, &cfspi->state);
>   	wake_up_interruptible(&cfspi->wait);
>   	destroy_workqueue(cfspi->wq);
> 
