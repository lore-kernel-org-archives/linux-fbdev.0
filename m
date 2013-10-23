From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 23 Oct 2013 01:20:59 +0000
Subject: Re: [PATCH 1/9] backlight: atmel-pwm-bl: fix reported brightness
Message-Id: <001901cecf8e$21764db0$6462e910$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382462819-28576-1-git-send-email-jhovold@gmail.com>
 <1382462819-28576-2-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382462819-28576-2-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Johan Hovold' <jhovold@gmail.com>
Cc: 'Richard Purdie' <rpurdie@rpsys.net>, 'Nicolas Ferre' <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, October 23, 2013 2:27 AM, Johan Hovold wrote:
> 
> The driver supports 16-bit brightness values, but the value returned
> from get_brightness was truncated to eight bits.
> 
> Cc: stable@vger.kernel.org
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

However, atmel_pwm_bl_get_intensity() should return 'int',
instead of 'u16'. Also, pwm_channel_readl() returns 'u32'.

Then, how about the following?

--- a/drivers/video/backlight/atmel-pwm-bl.c
+++ b/drivers/video/backlight/atmel-pwm-bl.c
@@ -70,17 +70,17 @@ static int atmel_pwm_bl_set_intensity(struct backlight_device *bd)
 static int atmel_pwm_bl_get_intensity(struct backlight_device *bd)
 {
	struct atmel_pwm_bl *pwmbl = bl_get_data(bd);
-	u8 intensity;
+	u16 intensity;

	if (pwmbl->pdata->pwm_active_low) {
-		intensity = pwm_channel_readl(&pwmbl->pwmc, PWM_CDTY) -
+		intensity = (u16) pwm_channel_readl(&pwmbl->pwmc, PWM_CDTY) -
			pwmbl->pdata->pwm_duty_min;
	} else {
-		intensity = pwmbl->pdata->pwm_duty_max -
+		intensity = (u16) pwmbl->pdata->pwm_duty_max -
			pwm_channel_readl(&pwmbl->pwmc, PWM_CDTY);
	}

-	return intensity;
+	return (int)intensity;
 }

Best regards,
Jingoo Han

