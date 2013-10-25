From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Fri, 25 Oct 2013 11:08:36 +0000
Subject: Re: [PATCH 1/9] backlight: atmel-pwm-bl: fix reported brightness
Message-Id: <20131025110836.GQ18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382522143-32072-1-git-send-email-jhovold@gmail.com>
 <1382522143-32072-2-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382522143-32072-2-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johan Hovold <jhovold@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On 11:55 Wed 23 Oct     , Johan Hovold wrote:
> The driver supports 16-bit brightness values, but the value returned
> from get_brightness was truncated to eight bits.
> 
> Cc: stable@vger.kernel.org
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Signed-off-by: Johan Hovold <jhovold@gmail.com>
> ---
>  drivers/video/backlight/atmel-pwm-bl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/atmel-pwm-bl.c b/drivers/video/backlight/atmel-pwm-bl.c
> index 66885fb..8aac273 100644
> --- a/drivers/video/backlight/atmel-pwm-bl.c
> +++ b/drivers/video/backlight/atmel-pwm-bl.c
> @@ -70,7 +70,7 @@ static int atmel_pwm_bl_set_intensity(struct backlight_device *bd)
>  static int atmel_pwm_bl_get_intensity(struct backlight_device *bd)
>  {
>  	struct atmel_pwm_bl *pwmbl = bl_get_data(bd);
> -	u8 intensity;
> +	u32 intensity;
>  
>  	if (pwmbl->pdata->pwm_active_low) {
>  		intensity = pwm_channel_readl(&pwmbl->pwmc, PWM_CDTY) -
> @@ -80,7 +80,7 @@ static int atmel_pwm_bl_get_intensity(struct backlight_device *bd)
>  			pwm_channel_readl(&pwmbl->pwmc, PWM_CDTY);
>  	}
>  
> -	return intensity;
> +	return (u16)intensity;
no cast mask it
>  }
>  
>  static int atmel_pwm_bl_init_pwm(struct atmel_pwm_bl *pwmbl)
> -- 
> 1.8.4
> 
