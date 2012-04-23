From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 23 Apr 2012 06:19:14 +0000
Subject: Re: [PATCH] drivers/video/ep93xx-fb.c: clean up error-handling code
Message-Id: <4F94F462.3010704@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334777828-3557-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1334777828-3557-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/18/2012 07:37 PM, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> There were two problems in this code: failure of the setup function should
> free locally allocated resources like other nearby failures, and the test
> if (&info->cmap) can never be false.  To generally clean things up, this
> patch reorders the error handling code at the failed label and adds labels
> so that the conditionals are not necessary.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
> Not tested.
> 
>  drivers/video/ep93xx-fb.c |   32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
> index f8babbe..345d962 100644
> --- a/drivers/video/ep93xx-fb.c
> +++ b/drivers/video/ep93xx-fb.c
> @@ -507,16 +507,16 @@ static int __devinit ep93xxfb_probe(struct platform_device *pdev)
>  
>  	err = fb_alloc_cmap(&info->cmap, 256, 0);
>  	if (err)
> -		goto failed;
> +		goto failed_cmap;
>  
>  	err = ep93xxfb_alloc_videomem(info);
>  	if (err)
> -		goto failed;
> +		goto failed_videomem;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		err = -ENXIO;
> -		goto failed;
> +		goto failed_resource;
>  	}
>  
>  	/*
> @@ -532,7 +532,7 @@ static int __devinit ep93xxfb_probe(struct platform_device *pdev)
>  	fbi->mmio_base = ioremap(res->start, resource_size(res));
>  	if (!fbi->mmio_base) {
>  		err = -ENXIO;
> -		goto failed;
> +		goto failed_resource;
>  	}
>  
>  	strcpy(info->fix.id, pdev->name);
> @@ -553,24 +553,24 @@ static int __devinit ep93xxfb_probe(struct platform_device *pdev)
>  	if (err = 0) {
>  		dev_err(info->dev, "No suitable video mode found\n");
>  		err = -EINVAL;
> -		goto failed;
> +		goto failed_mode;
>  	}
>  
>  	if (mach_info->setup) {
>  		err = mach_info->setup(pdev);
>  		if (err)
> -			return err;
> +			goto failed_mode;
>  	}
>  
>  	err = ep93xxfb_check_var(&info->var, info);
>  	if (err)
> -		goto failed;
> +		goto failed_check;
>  
>  	fbi->clk = clk_get(info->dev, NULL);
>  	if (IS_ERR(fbi->clk)) {
>  		err = PTR_ERR(fbi->clk);
>  		fbi->clk = NULL;
> -		goto failed;
> +		goto failed_check;
>  	}
>  
>  	ep93xxfb_set_par(info);
> @@ -585,15 +585,17 @@ static int __devinit ep93xxfb_probe(struct platform_device *pdev)
>  	return 0;
>  
>  failed:
> -	if (fbi->clk)
> -		clk_put(fbi->clk);
> -	if (fbi->mmio_base)
> -		iounmap(fbi->mmio_base);
> -	ep93xxfb_dealloc_videomem(info);
> -	if (&info->cmap)
> -		fb_dealloc_cmap(&info->cmap);
> +	clk_put(fbi->clk);
> +failed_check:
>  	if (fbi->mach_info->teardown)
>  		fbi->mach_info->teardown(pdev);
> +failed_mode:
> +	iounmap(fbi->mmio_base);
> +failed_resource:
> +	ep93xxfb_dealloc_videomem(info);
> +failed_videomem:
> +	fb_dealloc_cmap(&info->cmap);
> +failed_cmap:
>  	kfree(info);
>  	platform_set_drvdata(pdev, NULL);
>  
> 
> 

