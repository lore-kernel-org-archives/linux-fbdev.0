From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 Apr 2020 14:08:16 +0000
Subject: Re: [PATCH v3] fbdev: s1d13xxxfb: add missed unregister_framebuffer in remove
Message-Id: <903cffdd-2f4e-b825-0d2f-7ffd2d0fc4e0@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200324132625eucas1p1dc7c0d591946a44d149418e3525630ed@eucas1p1.samsung.com>
 <20200324132311.21729-1-hslester96@gmail.com>
In-Reply-To: <20200324132311.21729-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuhong Yuan <hslester96@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 3/24/20 2:23 PM, Chuhong Yuan wrote:
> The driver calls register_framebuffer() in probe but does not call
> unregister_framebuffer() in remove.
> Rename current remove to __s1d13xxxfb_remove() for error handler.
> Then add a new remove to call unregister_framebuffer().
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Patch queued for v5.8 (w/ extra newline removed), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> Changes in v3:
>   - Fix code style.
>   - Set __s1d13xxxfb_remove() to return void.
>   - Remove redundant check for info.
> 
>  drivers/video/fbdev/s1d13xxxfb.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
> index 8048499e398d..d51ef7619115 100644
> --- a/drivers/video/fbdev/s1d13xxxfb.c
> +++ b/drivers/video/fbdev/s1d13xxxfb.c
> @@ -721,9 +721,7 @@ static void s1d13xxxfb_fetch_hw_state(struct fb_info *info)
>  		xres, yres, xres_virtual, yres_virtual, is_color, is_dual, is_tft);
>  }
>  
> -
> -static int
> -s1d13xxxfb_remove(struct platform_device *pdev)
> +static void __s1d13xxxfb_remove(struct platform_device *pdev)
>  {
>  	struct fb_info *info = platform_get_drvdata(pdev);
>  	struct s1d13xxxfb_par *par = NULL;
> @@ -749,9 +747,18 @@ s1d13xxxfb_remove(struct platform_device *pdev)
>  			pdev->resource[0].end - pdev->resource[0].start +1);
>  	release_mem_region(pdev->resource[1].start,
>  			pdev->resource[1].end - pdev->resource[1].start +1);
> +}
> +
> +static int s1d13xxxfb_remove(struct platform_device *pdev)
> +{
> +	struct fb_info *info = platform_get_drvdata(pdev);
> +
> +	unregister_framebuffer(info);
> +	__s1d13xxxfb_remove(pdev);
>  	return 0;
>  }
>  
> +
>  static int s1d13xxxfb_probe(struct platform_device *pdev)
>  {
>  	struct s1d13xxxfb_par *default_par;
> @@ -895,7 +902,7 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
>  	return 0;
>  
>  bail:
> -	s1d13xxxfb_remove(pdev);
> +	__s1d13xxxfb_remove(pdev);
>  	return ret;
>  
>  }
> 
