From: Lubomir Rintel <lkundrak@v3.sk>
Date: Mon, 02 Sep 2019 09:10:46 +0000
Subject: Re: [PATCH] pxa168fb: Fix the function used to release some memory in an error handling path
Message-Id: <ca0213fd439a2b569e0d3bdb000712ee62ff4836.camel@v3.sk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190831100024.3248-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20190831100024.3248-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, b.zolnierkie@samsung.com, yuehaibing@huawei.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sat, 2019-08-31 at 12:00 +0200, Christophe JAILLET wrote:
> In the probe function, some resources are allocated using 'dma_alloc_wc()',
> they should be released with 'dma_free_wc()', not 'dma_free_coherent()'.
> 
> We already use 'dma_free_wc()' in the remove function, but not in the
> error handling path of the probe function.
> 
> Also, remove a useless 'PAGE_ALIGN()'. 'info->fix.smem_len' is already
> PAGE_ALIGNed.
> 
> Fixes: 638772c7553f ("fb: add support of LCD display controller on pxa168/910 (base layer)")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks,
Lubo

> ---
> The change about PAGE_ALIGN should probably be part of a separate commit.
> However, git history for this driver is really quiet. If you think it
> REALLY deserves a separate patch, either split it by yourself or axe this
> part of the patch. I won't bother resubmitting for this lonely cleanup.
> Hoping for your understanding.
> ---
>  drivers/video/fbdev/pxa168fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index 1410f476e135..1fc50fc0694b 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -766,8 +766,8 @@ static int pxa168fb_probe(struct platform_device *pdev)
>  failed_free_clk:
>  	clk_disable_unprepare(fbi->clk);
>  failed_free_fbmem:
> -	dma_free_coherent(fbi->dev, info->fix.smem_len,
> -			info->screen_base, fbi->fb_start_dma);
> +	dma_free_wc(fbi->dev, info->fix.smem_len,
> +		    info->screen_base, fbi->fb_start_dma);
>  failed_free_info:
>  	kfree(info);
>  
> @@ -801,7 +801,7 @@ static int pxa168fb_remove(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  
> -	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
> +	dma_free_wc(fbi->dev, info->fix.smem_len,
>  		    info->screen_base, info->fix.smem_start);
>  
>  	clk_disable_unprepare(fbi->clk);
