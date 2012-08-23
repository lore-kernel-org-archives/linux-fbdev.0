From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:36:10 +0000
Subject: Re: [PATCH 3/5] drivers/video/cobalt_lcdfb.c: use devm_ functions
Message-Id: <5036943A.80103@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343742860-16213-1-git-send-email-damien.cassou@lifl.fr> <1343742860-16213-4-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1343742860-16213-4-git-send-email-damien.cassou@lifl.fr>
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
>  drivers/video/cobalt_lcdfb.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/cobalt_lcdfb.c b/drivers/video/cobalt_lcdfb.c
> index eae46f6..01a4ee7 100644
> --- a/drivers/video/cobalt_lcdfb.c
> +++ b/drivers/video/cobalt_lcdfb.c
> @@ -348,7 +348,8 @@ static int __devinit cobalt_lcdfb_probe(struct platform_device *dev)
>  	}
>  
>  	info->screen_size = resource_size(res);
> -	info->screen_base = ioremap(res->start, info->screen_size);
> +	info->screen_base = devm_ioremap(&dev->dev, res->start,
> +					 info->screen_size);
>  	info->fbops = &cobalt_lcd_fbops;
>  	info->fix = cobalt_lcdfb_fix;
>  	info->fix.smem_start = res->start;
> @@ -359,7 +360,6 @@ static int __devinit cobalt_lcdfb_probe(struct platform_device *dev)
>  
>  	retval = register_framebuffer(info);
>  	if (retval < 0) {
> -		iounmap(info->screen_base);
>  		framebuffer_release(info);
>  		return retval;
>  	}
> @@ -380,7 +380,6 @@ static int __devexit cobalt_lcdfb_remove(struct platform_device *dev)
>  
>  	info = platform_get_drvdata(dev);
>  	if (info) {
> -		iounmap(info->screen_base);
>  		unregister_framebuffer(info);
>  		framebuffer_release(info);
>  	}
> 
> 

