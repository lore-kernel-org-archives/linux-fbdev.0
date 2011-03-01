From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 01 Mar 2011 13:58:59 +0000
Subject: Re: [PATCH 3/6] FBDEV: JZ4740: Initialize framebuffer properly
Message-Id: <4D6CFBF6.7030101@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1d49e2b9aa2fa143c14a9782fd4e67cb50610ca8.1298980528.git.mcuelenaere@gmail.com>
In-Reply-To: <1d49e2b9aa2fa143c14a9782fd4e67cb50610ca8.1298980528.git.mcuelenaere@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 03/01/2011 01:06 PM, Maurus Cuelenaere wrote:
> Use the jzfb_enable() function instead of manually faking it in jzfb_probe().
> Also add the reverse operation when the framebuffer couldn't be registered.
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  drivers/video/jz4740_fb.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
> index cea7b7e..2f3ea57 100644
> --- a/drivers/video/jz4740_fb.c
> +++ b/drivers/video/jz4740_fb.c
> @@ -707,16 +707,13 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
>  
>  	fb_alloc_cmap(&fb->cmap, 256, 0);
>  
> -	clk_enable(jzfb->ldclk);
> -	jzfb->is_enabled = 1;
> -
> -	writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
> -
>  	fb->mode = NULL;
>  	jzfb_set_par(fb);
>  
>  	jzfb_pins_operation(jzfb, REQUEST_PINS);
>  
> +	jzfb_blank(FB_BLANK_UNBLANK, fb);
> +

I'd prefer:
jzfb_enable(jzfb);
jzfb->is_enabled = 1;

since there is no need for locking here.

>  	ret = register_framebuffer(fb);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register framebuffer: %d\n", ret);
> @@ -726,6 +723,7 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_free_devmem:
> +	jzfb_blank(FB_BLANK_POWERDOWN, fb);
>  	jzfb_pins_operation(jzfb, FREE_PINS);
>  
>  	fb_dealloc_cmap(&fb->cmap);

