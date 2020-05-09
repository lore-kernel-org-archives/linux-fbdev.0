From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 09 May 2020 21:09:24 +0000
Subject: Re: [PATCH] video: fbdev: pxa168fb: make pxa168fb_init_mode() return void
Message-Id: <20200509210924.GB12666@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200506061745.19451-1-yanaijie@huawei.com>
In-Reply-To: <20200506061745.19451-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Yan <yanaijie@huawei.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

Hi Jason.

On Wed, May 06, 2020 at 02:17:45PM +0800, Jason Yan wrote:
> No other functions use the return value of pxa168fb_init_mode() and the
> return value is always 0 now. Make it return void. This fixes the
> following coccicheck warning:
> 
> drivers/video/fbdev/pxa168fb.c:565:5-8: Unneeded variable: "ret". Return
> "0" on line 597
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/pxa168fb.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index aef8a3042590..eedfbd3572a8 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -557,12 +557,11 @@ static const struct fb_ops pxa168fb_ops = {
>  	.fb_imageblit	= cfb_imageblit,
>  };
>  
> -static int pxa168fb_init_mode(struct fb_info *info,
> +static void pxa168fb_init_mode(struct fb_info *info,
>  			      struct pxa168fb_mach_info *mi)
>  {
>  	struct pxa168fb_info *fbi = info->par;
>  	struct fb_var_screeninfo *var = &info->var;
> -	int ret = 0;
>  	u32 total_w, total_h, refresh;
>  	u64 div_result;
>  	const struct fb_videomode *m;
> @@ -593,8 +592,6 @@ static int pxa168fb_init_mode(struct fb_info *info,
>  	div_result = 1000000000000ll;
>  	do_div(div_result, total_w * total_h * refresh);
>  	var->pixclock = (u32)div_result;
> -
> -	return ret;
>  }
>  
>  static int pxa168fb_probe(struct platform_device *pdev)
> -- 
> 2.21.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
