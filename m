From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:35:43 +0000
Subject: Re: [PATCH 5/5] drivers/video/ep93xx-fb.c: use devm_ functions
Message-Id: <5036941F.2070305@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343742860-16213-1-git-send-email-damien.cassou@lifl.fr> <1343742860-16213-2-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1343742860-16213-2-git-send-email-damien.cassou@lifl.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Damien Cassou <damien.cassou@lifl.fr>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/31/2012 01:54 PM, Damien Cassou wrote:
> From: Damien Cassou <damien.cassou@lifl.fr>
> 
> The various devm_ functions allocate memory that is released when a driver
> detaches.  This patch uses these functions for data that is allocated in
> the probe function of a platform device and is only freed in the remove
> function.
> 
> Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
>  drivers/video/ep93xx-fb.c |   17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
> index 345d962..69c89f2 100644
> --- a/drivers/video/ep93xx-fb.c
> +++ b/drivers/video/ep93xx-fb.c
> @@ -529,7 +529,8 @@ static int __devinit ep93xxfb_probe(struct platform_device *pdev)
>  	 * any of the framebuffer registers.
>  	 */
>  	fbi->res = res;
> -	fbi->mmio_base = ioremap(res->start, resource_size(res));
> +	fbi->mmio_base = devm_ioremap(&pdev->dev, res->start,
> +				      resource_size(res));
>  	if (!fbi->mmio_base) {
>  		err = -ENXIO;
>  		goto failed_resource;
> @@ -553,20 +554,20 @@ static int __devinit ep93xxfb_probe(struct platform_device *pdev)
>  	if (err = 0) {
>  		dev_err(info->dev, "No suitable video mode found\n");
>  		err = -EINVAL;
> -		goto failed_mode;
> +		goto failed_resource;
>  	}
>  
>  	if (mach_info->setup) {
>  		err = mach_info->setup(pdev);
>  		if (err)
> -			goto failed_mode;
> +			goto failed_resource;
>  	}
>  
>  	err = ep93xxfb_check_var(&info->var, info);
>  	if (err)
>  		goto failed_check;
>  
> -	fbi->clk = clk_get(info->dev, NULL);
> +	fbi->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(fbi->clk)) {
>  		err = PTR_ERR(fbi->clk);
>  		fbi->clk = NULL;
> @@ -578,19 +579,15 @@ static int __devinit ep93xxfb_probe(struct platform_device *pdev)
>  
>  	err = register_framebuffer(info);
>  	if (err)
> -		goto failed;
> +		goto failed_check;
>  
>  	dev_info(info->dev, "registered. Mode = %dx%d-%d\n",
>  		 info->var.xres, info->var.yres, info->var.bits_per_pixel);
>  	return 0;
>  
> -failed:
> -	clk_put(fbi->clk);
>  failed_check:
>  	if (fbi->mach_info->teardown)
>  		fbi->mach_info->teardown(pdev);
> -failed_mode:
> -	iounmap(fbi->mmio_base);
>  failed_resource:
>  	ep93xxfb_dealloc_videomem(info);
>  failed_videomem:
> @@ -609,8 +606,6 @@ static int __devexit ep93xxfb_remove(struct platform_device *pdev)
>  
>  	unregister_framebuffer(info);
>  	clk_disable(fbi->clk);
> -	clk_put(fbi->clk);
> -	iounmap(fbi->mmio_base);
>  	ep93xxfb_dealloc_videomem(info);
>  	fb_dealloc_cmap(&info->cmap);
>  
> 
> 

