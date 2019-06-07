From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 07 Jun 2019 12:21:05 +0000
Subject: Re: [PATCH 3/3] jz4740_fb: fix DMA API abuse
Message-Id: <8a149d05-047b-6df1-28fc-184dae9c32df@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190509173849.11825-1-hch@lst.de>
        <CGME20190509173943epcas2p27a7106894d5a235a405a94e84340b416@epcas2p2.samsung.com>
        <20190509173849.11825-4-hch@lst.de>
In-Reply-To: <20190509173849.11825-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 5/9/19 7:38 PM, Christoph Hellwig wrote:
> Virtual addresses return from dma(m)_alloc_coherent are opaque in what
> backs then, and drivers must not poke into them.  Switch the driver
> to use the generic DMA API mmap helper to avoid these problems.
Change itself looks fine but the patch description doesn't match what
the patch is actually doing (there is no conversion to DMA API helper
because the driver is already using it). Please correct it. Thank you.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/video/fbdev/jz4740_fb.c | 7 -------
>  1 file changed, 7 deletions(-)
> diff --git a/drivers/video/fbdev/jz4740_fb.c b/drivers/video/fbdev/jz4740_fb.c
> index b57df83fdbd3..b95cdfa9e0a1 100644
> --- a/drivers/video/fbdev/jz4740_fb.c
> +++ b/drivers/video/fbdev/jz4740_fb.c
> @@ -466,7 +466,6 @@ static int jzfb_alloc_devmem(struct jzfb *jzfb)
>  {
>  	int max_videosize = 0;
>  	struct fb_videomode *mode = jzfb->pdata->modes;
> -	void *page;
>  	int i;
>  
>  	for (i = 0; i < jzfb->pdata->num_modes; ++mode, ++i) {
> @@ -491,12 +490,6 @@ static int jzfb_alloc_devmem(struct jzfb *jzfb)
>  	if (!jzfb->vidmem)
>  		goto err_free_framedesc;
>  
> -	for (page = jzfb->vidmem;
> -		 page < jzfb->vidmem + PAGE_ALIGN(jzfb->vidmem_size);
> -		 page += PAGE_SIZE) {
> -		SetPageReserved(virt_to_page(page));
> -	}
> -
>  	jzfb->framedesc->next = jzfb->framedesc_phys;
>  	jzfb->framedesc->addr = jzfb->vidmem_phys;
>  	jzfb->framedesc->id = 0xdeafbead;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
