From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Jul 2020 14:24:00 +0000
Subject: Re: [PATCH] fbdev: da8xx-fb: go to proper label on error handling paths in probe
Message-Id: <8f2d2497-2fd3-f3db-32b6-f74736b1ea2e@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200702160546eucas1p1b722eb071cdab13a7bfd47bd98a7d670@eucas1p1.samsung.com>
 <20200702160540.24546-1-novikov@ispras.ru>
In-Reply-To: <20200702160540.24546-1-novikov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Evgeny Novikov <novikov@ispras.ru>
Cc: ldv-project@linuxtesting.org, linux-fbdev@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>


On 7/2/20 6:05 PM, Evgeny Novikov wrote:
> fb_probe() can successfully allocate a new frame buffer, but then fail
> to perform some operations with regulator. In these cases fb_probe()
> goes to label err_pm_runtime_disable where the frame buffer is not
> released. The patch makes fb_probe() to go to label err_release_fb on
> corresponding error handling paths.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/da8xx-fb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
> index 73c3c4c8cc12..e38c0e3f9c61 100644
> --- a/drivers/video/fbdev/da8xx-fb.c
> +++ b/drivers/video/fbdev/da8xx-fb.c
> @@ -1402,14 +1402,14 @@ static int fb_probe(struct platform_device *device)
>  	if (IS_ERR(par->lcd_supply)) {
>  		if (PTR_ERR(par->lcd_supply) = -EPROBE_DEFER) {
>  			ret = -EPROBE_DEFER;
> -			goto err_pm_runtime_disable;
> +			goto err_release_fb;
>  		}
>  
>  		par->lcd_supply = NULL;
>  	} else {
>  		ret = regulator_enable(par->lcd_supply);
>  		if (ret)
> -			goto err_pm_runtime_disable;
> +			goto err_release_fb;
>  	}
>  
>  	fb_videomode_to_var(&da8xx_fb_var, lcdc_info);
> 
