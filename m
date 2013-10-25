From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Fri, 25 Oct 2013 11:13:12 +0000
Subject: Re: [PATCH 8/9] backlight: atmel-pwm-bl: refactor gpio_on handling
Message-Id: <20131025111312.GU18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382522143-32072-1-git-send-email-jhovold@gmail.com>
 <1382522143-32072-9-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382522143-32072-9-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johan Hovold <jhovold@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 11:55 Wed 23 Oct     , Johan Hovold wrote:
> Add helper function to control the gpio_on signal.
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

ok
> ---
>  drivers/video/backlight/atmel-pwm-bl.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/backlight/atmel-pwm-bl.c b/drivers/video/backlight/atmel-pwm-bl.c
> index ffc30d2..1277e0c 100644
> --- a/drivers/video/backlight/atmel-pwm-bl.c
> +++ b/drivers/video/backlight/atmel-pwm-bl.c
> @@ -26,6 +26,14 @@ struct atmel_pwm_bl {
>  	int					gpio_on;
>  };
>  
> +static void atmel_pwm_bl_set_gpio_on(struct atmel_pwm_bl *pwmbl, int on)
> +{
> +	if (!gpio_is_valid(pwmbl->gpio_on))
> +		return;
> +
> +	gpio_set_value(pwmbl->gpio_on, on ^ pwmbl->pdata->on_active_low);
> +}
> +
>  static int atmel_pwm_bl_set_intensity(struct backlight_device *bd)
>  {
>  	struct atmel_pwm_bl *pwmbl = bl_get_data(bd);
> @@ -48,19 +56,13 @@ static int atmel_pwm_bl_set_intensity(struct backlight_device *bd)
>  		pwm_duty = pwmbl->pdata->pwm_duty_min;
>  
>  	if (!intensity) {
> -		if (gpio_is_valid(pwmbl->gpio_on)) {
> -			gpio_set_value(pwmbl->gpio_on,
> -					0 ^ pwmbl->pdata->on_active_low);
> -		}
> +		atmel_pwm_bl_set_gpio_on(pwmbl, 0);
>  		pwm_channel_writel(&pwmbl->pwmc, PWM_CUPD, pwm_duty);
>  		pwm_channel_disable(&pwmbl->pwmc);
>  	} else {
>  		pwm_channel_enable(&pwmbl->pwmc);
>  		pwm_channel_writel(&pwmbl->pwmc, PWM_CUPD, pwm_duty);
> -		if (gpio_is_valid(pwmbl->gpio_on)) {
> -			gpio_set_value(pwmbl->gpio_on,
> -					1 ^ pwmbl->pdata->on_active_low);
> -		}
> +		atmel_pwm_bl_set_gpio_on(pwmbl, 1);
>  	}
>  
>  	return 0;
> @@ -196,10 +198,7 @@ static int atmel_pwm_bl_remove(struct platform_device *pdev)
>  {
>  	struct atmel_pwm_bl *pwmbl = platform_get_drvdata(pdev);
>  
> -	if (gpio_is_valid(pwmbl->gpio_on)) {
> -		gpio_set_value(pwmbl->gpio_on,
> -					0 ^ pwmbl->pdata->on_active_low);
> -	}
> +	atmel_pwm_bl_set_gpio_on(pwmbl, 0);
>  	pwm_channel_disable(&pwmbl->pwmc);
>  	pwm_channel_free(&pwmbl->pwmc);
>  
> -- 
> 1.8.4
> 
