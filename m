From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 20 Mar 2020 12:22:02 +0000
Subject: Re: [PATCH v2] fbdev: s1d13xxxfb: add missed unregister_framebuffer in remove
Message-Id: <eda0b4c0-93ff-dfb3-4f63-907a8bef01ec@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200310143051eucas1p2ad43ac5aee1f9132db0c377212ec8419@eucas1p2.samsung.com>
 <20200310143033.5098-1-hslester96@gmail.com>
In-Reply-To: <20200310143033.5098-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuhong Yuan <hslester96@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 3/10/20 3:30 PM, Chuhong Yuan wrote:
> The driver calls register_framebuffer() in probe but does not call
> unregister_framebuffer() in remove.
> Rename current remove to __s1d13xxxfb_remove() for error handler.
> Then add a new remove to call unregister_framebuffer().
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Rename the existing remove and add a new one to ensure the correctness
>     of error handler in probe.
> 
>  drivers/video/fbdev/s1d13xxxfb.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
> index 8048499e398d..bafea3d09bba 100644
> --- a/drivers/video/fbdev/s1d13xxxfb.c
> +++ b/drivers/video/fbdev/s1d13xxxfb.c
> @@ -721,9 +721,8 @@ static void s1d13xxxfb_fetch_hw_state(struct fb_info *info)
>  		xres, yres, xres_virtual, yres_virtual, is_color, is_dual, is_tft);
>  }
>  
> -
>  static int
> -s1d13xxxfb_remove(struct platform_device *pdev)
> +__s1d13xxxfb_remove(struct platform_device *pdev)

The new function can be made void as it always returns 0.

Also please use the standard CodingStyle while at it:

void __s1d13xxxfb_remove(struct platform_device *pdev)

>  {
>  	struct fb_info *info = platform_get_drvdata(pdev);
>  	struct s1d13xxxfb_par *par = NULL;
> @@ -752,6 +751,18 @@ s1d13xxxfb_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int
> +s1d13xxxfb_remove(struct platform_device *pdev)

Please use the standard CodingStyle while at it:

static int s1d13xxxfb_remove(struct platform_device *pdev)

> +{
> +	struct fb_info *info = platform_get_drvdata(pdev);
> +
> +	if (info)

'info' check is superfluous in the ->remove only code-path.

> +		unregister_framebuffer(info);
> +
> +	return __s1d13xxxfb_remove(pdev);
> +}
> +
> +
>  static int s1d13xxxfb_probe(struct platform_device *pdev)
>  {
>  	struct s1d13xxxfb_par *default_par;
> @@ -895,7 +906,7 @@ static int s1d13xxxfb_probe(struct platform_device *pdev)
>  	return 0;
>  
>  bail:
> -	s1d13xxxfb_remove(pdev);
> +	__s1d13xxxfb_remove(pdev);
>  	return ret;
>  
>  }
> 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
