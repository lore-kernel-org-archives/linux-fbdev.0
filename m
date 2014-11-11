From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 11 Nov 2014 16:34:08 +0000
Subject: Re: [PATCH v4 3/5] simplefb: formalize pseudo palette handling
Message-Id: <20141111163408.9C364C416AF@trevor.secretlab.ca>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <1413996311-4287-4-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1413996311-4287-4-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 22 Oct 2014 18:45:09 +0200
, Hans de Goede <hdegoede@redhat.com>
 wrote:
> From: Luc Verhaegen <libv@skynet.be>
> 

Patch description? Write a proper changelog before merging please.
Describe why the change is necessary and what was done. You need to give
future readers some information about this patch. Heck, you're listed in
MAINTAINERS, you should be *enforcing* proper changelogs.

The code looks fine though.

Acked-by: Grant Likely <grant.likely@linaro.org>

> Signed-off-by: Luc Verhaegen <libv@skynet.be>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> [hdegoede@redhat.com: drop unnecessary void * cast]
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  drivers/video/fbdev/simplefb.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 210f3a0..ec112c1 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -41,6 +41,8 @@ static struct fb_var_screeninfo simplefb_var = {
>  	.vmode		= FB_VMODE_NONINTERLACED,
>  };
>  
> +#define PSEUDO_PALETTE_SIZE 16
> +
>  static int simplefb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
>  			      u_int transp, struct fb_info *info)
>  {
> @@ -50,7 +52,7 @@ static int simplefb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
>  	u32 cb = blue >> (16 - info->var.blue.length);
>  	u32 value;
>  
> -	if (regno >= 16)
> +	if (regno >= PSEUDO_PALETTE_SIZE)
>  		return -EINVAL;
>  
>  	value = (cr << info->var.red.offset) |
> @@ -163,11 +165,16 @@ static int simplefb_parse_pd(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +struct simplefb_par {
> +	u32 palette[PSEUDO_PALETTE_SIZE];
> +};
> +
>  static int simplefb_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	struct simplefb_params params;
>  	struct fb_info *info;
> +	struct simplefb_par *par;
>  	struct resource *mem;
>  
>  	if (fb_get_options("simplefb", NULL))
> @@ -188,11 +195,13 @@ static int simplefb_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	info = framebuffer_alloc(sizeof(u32) * 16, &pdev->dev);
> +	info = framebuffer_alloc(sizeof(struct simplefb_par), &pdev->dev);
>  	if (!info)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, info);
>  
> +	par = info->par;
> +
>  	info->fix = simplefb_fix;
>  	info->fix.smem_start = mem->start;
>  	info->fix.smem_len = resource_size(mem);
> @@ -225,7 +234,7 @@ static int simplefb_probe(struct platform_device *pdev)
>  		framebuffer_release(info);
>  		return -ENODEV;
>  	}
> -	info->pseudo_palette = (void *)(info + 1);
> +	info->pseudo_palette = par->palette;
>  
>  	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
>  			     info->fix.smem_start, info->fix.smem_len,
> -- 
> 2.1.0
> 

