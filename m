From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 04 Jul 2017 15:44:57 +0000
Subject: Re: [PATCH] video: fbdev: imxfb: use after free in imxfb_remove()
Message-Id: <2088323.70idy6k2dB@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170630080242.emnw7l53f52pvzeo@mwanda>
In-Reply-To: <20170630080242.emnw7l53f52pvzeo@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi,

On Friday, June 30, 2017 11:02:42 AM Dan Carpenter wrote:
> We free "info" then dereference it on the next line.  I've moved the
> call to framebuffer_release() down a line to avoid this problem.
> 
> Fixes: b7d2d37276c1 ("video: imxfb: Remove unused fields from platform data structure")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index c166e0725be5..1d0c3592b290 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -1080,10 +1080,9 @@ static int imxfb_remove(struct platform_device *pdev)
>  
>  	fb_dealloc_cmap(&info->cmap);
>  	kfree(info->pseudo_palette);
> -	framebuffer_release(info);
> -
>  	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_base,
>  		    fbi->map_dma);
> +	framebuffer_release(info);
>  
>  	iounmap(fbi->regs);

Good catch.

While you are at it, please:

- move framebuffer_release() after iounmap() (memory occupied by
  fbi will also be freed by framebuffer_release() call, please see
  framebuffer_alloc() for details)

- make the ordering in imxfb_remove() match the ordering of error
  path in imxfb_probe() (to improve consistency and prevent similar
  ordering errors in future)

>  	release_mem_region(res->start, resource_size(res));

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

