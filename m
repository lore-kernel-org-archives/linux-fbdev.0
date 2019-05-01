From: Paul Burton <paul.burton@mips.com>
Date: Wed, 01 May 2019 17:18:59 +0000
Subject: Re: [PATCH 4/7] dma-direct: provide generic support for uncached kernel segments
Message-Id: <20190501171857.chfxqntvm6r4xrr4@pburton-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190430110032.25301-1-hch@lst.de>
 <20190430110032.25301-5-hch@lst.de>
In-Reply-To: <20190430110032.25301-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Christoph,

On Tue, Apr 30, 2019 at 07:00:29AM -0400, Christoph Hellwig wrote:
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 2c2772e9702a..d15a535c3e67 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -164,6 +164,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	}
>  
>  	ret = page_address(page);
> +
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
> +	    !dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
> +		arch_dma_prep_coherent(page, size);
> +		ret = uncached_kernel_address(ret);
> +	}
> +
>  	if (force_dma_unencrypted()) {
>  		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
>  		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
> @@ -171,6 +178,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		*dma_handle = phys_to_dma(dev, page_to_phys(page));
>  	}
>  	memset(ret, 0, size);
> +
>  	return ret;
>  }

I'm not so sure about this part though.

On MIPS we currently don't clear the allocated memory with memset. Is
doing that really necessary?

If it is necessary then as-is this code will clear the allocated memory
using uncached writes which will be pretty slow. It would be much more
efficient to perform the memset before arch_dma_prep_coherent() & before
converting ret to an uncached address.

Thanks,
    Paul
