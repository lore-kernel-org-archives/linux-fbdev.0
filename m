From: Paul Burton <paul.burton@mips.com>
Date: Tue, 30 Apr 2019 20:10:43 +0000
Subject: Re: [PATCH 5/7] MIPS: use the generic uncached segment support in dma-direct
Message-Id: <20190430201041.536amvinrcvd2wua@pburton-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de>
 <20190430110032.25301-6-hch@lst.de>
In-Reply-To: <20190430110032.25301-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Christoph,

On Tue, Apr 30, 2019 at 07:00:30AM -0400, Christoph Hellwig wrote:
> diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
> index f9549d2fbea3..f739f42c9d3c 100644
> --- a/arch/mips/mm/dma-noncoherent.c
> +++ b/arch/mips/mm/dma-noncoherent.c
> @@ -44,33 +44,26 @@ static inline bool cpu_needs_post_dma_flush(struct device *dev)
>  	}
>  }
>  
> -void *arch_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> +void arch_dma_prep_coherent(struct page *page, size_t size)
>  {
> -	void *ret;
> -
> -	ret = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
> -	if (ret && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
> -		dma_cache_wback_inv((unsigned long) ret, size);
> -		ret = (void *)UNCAC_ADDR(ret);
> -	}
> +	if (!PageHighMem(page))
> +		dma_cache_wback_inv((unsigned long)page_address(page), size);
> +}

This series looks like a nice cleanup to me - the one thing that puzzles
me is the !PageHighMem check above.

As far as I can see arch_dma_prep_coherent() should never be called with
a highmem page, so would it make more sense to either drop this check or
perhaps wrap it in a WARN_ON()?

Thanks,
    Paul
