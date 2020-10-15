From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 15 Oct 2020 08:05:57 +0000
Subject: Re: [PATCH] au1100fb: Remove NULL pointer check before clk_enable/disable
Message-Id: <20201015100557.402f831f@linux-uq9g>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20201014082137.23320-1-vulab@iscas.ac.cn>
In-Reply-To: <20201014082137.23320-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Xu Wang <vulab@iscas.ac.cn>
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, jani.nikula@intel.com, daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi

On Wed, 14 Oct 2020 08:21:37 +0000 Xu Wang <vulab@iscas.ac.cn> wrote:

> Because clk_enable, clk_disable, clk_prepare, and clk_unprepare already
> checked NULL clock parameter, so the additional checks are unnecessary,
> just remove them.

All clk_*() functions seem to handle NULL pointers gracefully, so you can
also remove these checks from the driver's _probe and _remove functions.

Best regards
Thomas

> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/video/fbdev/au1100fb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
> index 37a6512feda0..3659dfbb81c1 100644
> --- a/drivers/video/fbdev/au1100fb.c
> +++ b/drivers/video/fbdev/au1100fb.c
> @@ -560,8 +560,7 @@ int au1100fb_drv_suspend(struct platform_device *dev,
> pm_message_t state) /* Blank the LCD */
>  	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
>  
> -	if (fbdev->lcdclk)
> -		clk_disable(fbdev->lcdclk);
> +	clk_disable(fbdev->lcdclk);
>  
>  	memcpy(&fbregs, fbdev->regs, sizeof(struct au1100fb_regs));
>  
> @@ -577,8 +576,7 @@ int au1100fb_drv_resume(struct platform_device *dev)
>  
>  	memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
>  
> -	if (fbdev->lcdclk)
> -		clk_enable(fbdev->lcdclk);
> +	clk_enable(fbdev->lcdclk);
>  
>  	/* Unblank the LCD */
>  	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);



-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
