From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 19 Oct 2020 07:21:00 +0000
Subject: Re: [PATCH] au1100fb: Remove NULL pointer check before clk_enable/disable
Message-Id: <6cf83ff0-eeae-5646-b068-34dbacf2d961@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20201014082137.23320-1-vulab@iscas.ac.cn>
In-Reply-To: <20201014082137.23320-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Xu Wang <vulab@iscas.ac.cn>, b.zolnierkie@samsung.com, jani.nikula@intel.com, daniel.vetter@ffwll.ch
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi

On 14.10.20 10:21, Xu Wang wrote:
> Because clk_enable, clk_disable, clk_prepare, and clk_unprepare already
> checked NULL clock parameter, so the additional checks are unnecessary,
> just remove them.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Sam convinced me to merge this patch as-is with out the additional
cleanup of the driver. So

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

I'll merge it into drm-misc-next.

I'd still like to encourage you to send a patch for the other clk_*
calls in au1100fb.

Best regard
Thomas

> ---
>  drivers/video/fbdev/au1100fb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
> index 37a6512feda0..3659dfbb81c1 100644
> --- a/drivers/video/fbdev/au1100fb.c
> +++ b/drivers/video/fbdev/au1100fb.c
> @@ -560,8 +560,7 @@ int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
>  	/* Blank the LCD */
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
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
