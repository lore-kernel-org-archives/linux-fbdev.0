From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 15:51:13 +0000
Subject: Re: [PATCH] pxa168fb: fix release function mismatch in probe failure
Message-Id: <83ca49d1-ca86-1005-7799-cc9f95af28db@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20191205160628epcas4p38c1843647699dcbd209c5381d65ab869@epcas4p3.samsung.com>
 <20191205160613.32075-1-hslester96@gmail.com>
In-Reply-To: <20191205160613.32075-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuhong Yuan <hslester96@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 12/5/19 5:06 PM, Chuhong Yuan wrote:
> The driver uses kfree() to release the resource allocated by
> framebuffer_alloc(), which does not match.
> Use framebuffer_release() instead to fix it.

For pxa168fb driver framebuffer_release() does only kfree() so
there is no real breakage currently. Lets fix it anyway so it
won't break in the future.

> Fixes: 638772c7553f ("fb: add support of LCD display controller on pxa168/910 (base layer)")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Patch queued for v5.6, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/pxa168fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index 1410f476e135..b9435133b6f3 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -769,7 +769,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
>  	dma_free_coherent(fbi->dev, info->fix.smem_len,
>  			info->screen_base, fbi->fb_start_dma);
>  failed_free_info:
> -	kfree(info);
> +	framebuffer_release(info);
>  
>  	dev_err(&pdev->dev, "frame buffer device init failed with %d\n", ret);
>  	return ret;
> 
