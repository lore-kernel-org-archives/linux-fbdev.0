From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 23 Sep 2012 19:23:07 +0000
Subject: Re: [PATCH] video: hpfb: Fix error handling
Message-Id: <505F619B.80505@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345487545-9590-1-git-send-email-emilgoode@gmail.com>
In-Reply-To: <1345487545-9590-1-git-send-email-emilgoode@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emil Goode <emilgoode@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On 08/20/2012 06:32 PM, Emil Goode wrote:
> This patch solves problems with the error handling by
> introducing labels for proper error paths and it also
> frees resources that where missed.
> 
> Signed-off-by: Emil Goode <emilgoode@gmail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/hpfb.c |   28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/hpfb.c b/drivers/video/hpfb.c
> index ebf8495..7324865 100644
> --- a/drivers/video/hpfb.c
> +++ b/drivers/video/hpfb.c
> @@ -210,6 +210,7 @@ static int __devinit hpfb_init_one(unsigned long phys_base,
>  				   unsigned long virt_base)
>  {
>  	unsigned long fboff, fb_width, fb_height, fb_start;
> +	int ret;
>  
>  	fb_regs = virt_base;
>  	fboff = (in_8(fb_regs + HPFB_FBOMSB) << 8) | in_8(fb_regs + HPFB_FBOLSB);
> @@ -290,19 +291,29 @@ static int __devinit hpfb_init_one(unsigned long phys_base,
>  	fb_info.var   = hpfb_defined;
>  	fb_info.screen_base = (char *)fb_start;
>  
> -	fb_alloc_cmap(&fb_info.cmap, 1 << hpfb_defined.bits_per_pixel, 0);
> +	ret = fb_alloc_cmap(&fb_info.cmap, 1 << hpfb_defined.bits_per_pixel, 0);
> +	if (ret < 0)
> +		goto unmap_screen_base;
>  
> -	if (register_framebuffer(&fb_info) < 0) {
> -		fb_dealloc_cmap(&fb_info.cmap);
> -		iounmap(fb_info.screen_base);
> -		fb_info.screen_base = NULL;
> -		return 1;
> -	}
> +	ret = register_framebuffer(&fb_info);
> +	if (ret < 0)
> +		goto dealloc_cmap;
>  
>  	printk(KERN_INFO "fb%d: %s frame buffer device\n",
>  	       fb_info.node, fb_info.fix.id);
>  
>  	return 0;
> +
> +dealloc_cmap:
> +	fb_dealloc_cmap(&fb_info.cmap);
> +
> +unmap_screen_base:
> +	if (fb_info.screen_base) {
> +		iounmap(fb_info.screen_base);
> +		fb_info.screen_base = NULL;
> +	}
> +
> +	return ret;
>  }
>  
>  /* 
> @@ -345,6 +356,9 @@ static void __devexit hpfb_remove_one(struct dio_dev *d)
>  	if (d->scode >= DIOII_SCBASE)
>  		iounmap((void *)fb_regs);
>  	release_mem_region(d->resource.start, resource_size(&d->resource));
> +	fb_dealloc_cmap(&fb_info.cmap);
> +	if (fb_info.screen_base)
> +		iounmap(fb_info.screen_base);
>  }
>  
>  static struct dio_device_id hpfb_dio_tbl[] = {

