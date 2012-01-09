From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Mon, 09 Jan 2012 16:17:18 +0000
Subject: Re: [PATCH 2/2] atmel_lcdfb: Use proper blanking on negative contrast
Message-Id: <4F0B130E.10701@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1317801598-23757-1-git-send-email-alexander.stein@systec-electronic.com>
 <1317801598-23757-2-git-send-email-alexander.stein@systec-electronic.com>
In-Reply-To: <1317801598-23757-2-git-send-email-alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/05/2011 09:59 AM, Alexander Stein :
> If used with negative polarity the PWM unit cannot be disabled. This would
> result in a full contrast screen.
> Instead let the PWM unit enabled using 0x0 as compare value which darkens
> the display.
> In result no power saving is possible if inverted contrast polarity
> is used.

Ok, this patch looks correct.

> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Florian, you can propagate this one upstream.

Thanks you, best regards,

> ---
>  drivers/video/atmel_lcdfb.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 816d528..2bd75b5 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -96,8 +96,11 @@ static int atmel_bl_update_status(struct backlight_device *bl)
>  		brightness = 0;
>  
>  	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, brightness);
> -	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR,
> +	if (contrast_ctr & ATMEL_LCDC_POL_POSITIVE)
> +		lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR,
>  			brightness ? contrast_ctr : 0);
> +	else
> +		lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
>  
>  	bl->props.fb_blank = bl->props.power = sinfo->bl_power = power;
>  


-- 
Nicolas Ferre
