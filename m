From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 27 Dec 2012 01:08:55 +0000
Subject: Re: [PATCH fix-3.8] video: vt8500: Fix X crash when initializing framebuffer.
Message-Id: <50DB9FA7.1090402@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1356567943-3836-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1356567943-3836-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 12/27/2012 12:25 AM, Tony Prisk wrote:
> This patch adds support for .fb_check_var which is required when
> X attempts to initialize the framebuffer. The only supported
> resolution is the native resolution of the LCD panel, so we test
> against the resolution supplied from the DT panel definition.

Nack. As far as I understand this driver behaves as it is supposed to do
according to drivers/video/skeletonfb.c. The frambuffer code seems to do
what is documented as well. If the X driver cannot cope with a different
var set than requested it needs to be fixed anyway as check_var is
always allowed to alter the parameters requested.
Strange, I thought I already saw X complaining about this when I added
30bpp mode to viafb.


Best regards,

Florian Tobias Schandinat


> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/video/wm8505fb.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
> index 77539c1..c84e376 100644
> --- a/drivers/video/wm8505fb.c
> +++ b/drivers/video/wm8505fb.c
> @@ -41,10 +41,18 @@
>  
>  #define to_wm8505fb_info(__info) container_of(__info, \
>  						struct wm8505fb_info, fb)
> +
> +struct lcd_params {
> +	u32 pixel_width;
> +	u32 pixel_height;
> +	u32 color_depth;
> +};
> +
>  struct wm8505fb_info {
>  	struct fb_info		fb;
>  	void __iomem		*regbase;
>  	unsigned int		contrast;
> +	struct lcd_params	lcd_params;
>  };
>  
>  
> @@ -248,8 +256,21 @@ static int wm8505fb_blank(int blank, struct fb_info *info)
>  	return 0;
>  }
>  
> +static int wm8505fb_check_var(struct fb_var_screeninfo *var,
> +			      struct fb_info *info)
> +{
> +	struct wm8505fb_info *fbi = to_wm8505fb_info(info);
> +        if (!fbi) return -EINVAL;
> +
> +	if (info->var.bits_per_pixel != fbi->lcd_params.color_depth) return -EINVAL;
> +	if (info->var.xres != fbi->lcd_params.pixel_width) return -EINVAL;
> +	if (info->var.yres != fbi->lcd_params.pixel_height) return -EINVAL;
> +	return 0;
> +}
> +
>  static struct fb_ops wm8505fb_ops = {
>  	.owner		= THIS_MODULE,
> +	.fb_check_var	= wm8505fb_check_var,
>  	.fb_set_par	= wm8505fb_set_par,
>  	.fb_setcolreg	= wm8505fb_setcolreg,
>  	.fb_fillrect	= wmt_ge_fillrect,
> @@ -354,6 +375,10 @@ static int __devinit wm8505fb_probe(struct platform_device *pdev)
>  		goto failed_free_res;
>  	}
>  
> +	fbi->lcd_params.pixel_width = of_mode.xres;
> +	fbi->lcd_params.pixel_height = of_mode.yres;
> +	fbi->lcd_params.color_depth = bpp;
> +
>  	of_mode.vmode = FB_VMODE_NONINTERLACED;
>  	fb_videomode_to_var(&fbi->fb.var, &of_mode);
>  

