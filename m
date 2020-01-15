From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 16:06:30 +0000
Subject: Re: [PATCH 03/10] fbdev: s1d13xxxfb: use resource_size
Message-Id: <847e5e23-38fd-ec1b-2296-456435c06fd6@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
 <CGME20200101182630eucas1p2ba58d07a485bd831a4afb16adbbe9306@eucas1p2.samsung.com>
 <1577900990-8588-4-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1577900990-8588-4-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: linux-fbdev@vger.kernel.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org



On 1/1/20 6:49 PM, Julia Lawall wrote:
> Use resource_size rather than a verbose computation on
> the end and start fields.
> 
> The semantic patch that makes these changes is as follows:
> (http://coccinelle.lip6.fr/)
> 
> <smpl>
> @@ struct resource ptr; @@
> - (ptr.end - ptr.start + 1)
> + resource_size(&ptr)
> </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Patch queued for v5.6, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/s1d13xxxfb.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
> index 8048499e398d..eaea8c373753 100644
> --- a/drivers/video/fbdev/s1d13xxxfb.c
> +++ b/drivers/video/fbdev/s1d13xxxfb.c
> @@ -746,9 +746,9 @@ s1d13xxxfb_remove(struct platform_device *pdev)
>  	}
>  
>  	release_mem_region(pdev->resource[0].start,
> -			pdev->resource[0].end - pdev->resource[0].start +1);
> +			   resource_size(&pdev->resource[0]));
>  	release_mem_region(pdev->resource[1].start,
> -			pdev->resource[1].end - pdev->resource[1].start +1);
> +			   resource_size(&pdev->resource[1]));
>  	return 0;
>  }
>  
> @@ -788,14 +788,14 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!request_mem_region(pdev->resource[0].start,
> -		pdev->resource[0].end - pdev->resource[0].start +1, "s1d13xxxfb mem")) {
> +		resource_size(&pdev->resource[0]), "s1d13xxxfb mem")) {
>  		dev_dbg(&pdev->dev, "request_mem_region failed\n");
>  		ret = -EBUSY;
>  		goto bail;
>  	}
>  
>  	if (!request_mem_region(pdev->resource[1].start,
> -		pdev->resource[1].end - pdev->resource[1].start +1, "s1d13xxxfb regs")) {
> +		resource_size(&pdev->resource[1]), "s1d13xxxfb regs")) {
>  		dev_dbg(&pdev->dev, "request_mem_region failed\n");
>  		ret = -EBUSY;
>  		goto bail;
> @@ -810,7 +810,7 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, info);
>  	default_par = info->par;
>  	default_par->regs = ioremap(pdev->resource[1].start,
> -			pdev->resource[1].end - pdev->resource[1].start +1);
> +				    resource_size(&pdev->resource[1]));
>  	if (!default_par->regs) {
>  		printk(KERN_ERR PFX "unable to map registers\n");
>  		ret = -ENOMEM;
> @@ -819,7 +819,7 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
>  	info->pseudo_palette = default_par->pseudo_palette;
>  
>  	info->screen_base = ioremap(pdev->resource[0].start,
> -			pdev->resource[0].end - pdev->resource[0].start +1);
> +				    resource_size(&pdev->resource[0]));
>  
>  	if (!info->screen_base) {
>  		printk(KERN_ERR PFX "unable to map framebuffer\n");
> @@ -857,9 +857,9 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
>  
>  	info->fix = s1d13xxxfb_fix;
>  	info->fix.mmio_start = pdev->resource[1].start;
> -	info->fix.mmio_len = pdev->resource[1].end - pdev->resource[1].start + 1;
> +	info->fix.mmio_len = resource_size(&pdev->resource[1]);
>  	info->fix.smem_start = pdev->resource[0].start;
> -	info->fix.smem_len = pdev->resource[0].end - pdev->resource[0].start + 1;
> +	info->fix.smem_len = resource_size(&pdev->resource[0]);
>  
>  	printk(KERN_INFO PFX "regs mapped at 0x%p, fb %d KiB mapped at 0x%p\n",
>  	       default_par->regs, info->fix.smem_len / 1024, info->screen_base);
> 
> 
> 
