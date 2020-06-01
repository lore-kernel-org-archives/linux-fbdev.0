From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Jun 2020 13:25:21 +0000
Subject: Re: [PATCH] video: pxafb: Fix the function used to balance a 'dma_alloc_coherent()' call
Message-Id: <b39fa7b2-fc01-be3e-f899-40b949aa11ee@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200429084519eucas1p2813ed7e76d573778607ac1270d8cb2e7@eucas1p2.samsung.com>
 <20200429084505.108897-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200429084505.108897-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-fbdev@vger.kernel.org, corbet@lwn.net, jani.nikula@intel.com, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, eric.miao@marvell.com, mchehab+samsung@kernel.org


On 4/29/20 10:45 AM, Christophe JAILLET wrote:
> 'dma_alloc_coherent()' must be balanced by a call to 'dma_free_coherent()'
> not 'dma_free_wc()'.
> The correct dma_free_ function is already used in the error handling path
> of the probe function.
> 
> Fixes: 77e196752bdd ("[ARM] pxafb: allow video memory size to be configurable")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to drm-misc-next tree (patch should show up in v5.9), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/pxafb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index 00b96a78676e..6f972bed410a 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -2417,8 +2417,8 @@ static int pxafb_remove(struct platform_device *dev)
>  
>  	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
>  
> -	dma_free_wc(&dev->dev, fbi->dma_buff_size, fbi->dma_buff,
> -		    fbi->dma_buff_phys);
> +	dma_free_coherent(&dev->dev, fbi->dma_buff_size, fbi->dma_buff,
> +			  fbi->dma_buff_phys);
>  
>  	return 0;
>  }
> 
