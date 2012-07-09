From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 09 Jul 2012 05:11:26 +0000
Subject: RE: [PATCH] pwm_backlight: pass correct brightness to callback
Message-Id: <00a701cd5d91$4aa71f40$dff55dc0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341807700-7103-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1341807700-7103-1-git-send-email-acourbot@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Alexandre Courbot' <acourbot@nvidia.com>, 'Thierry Reding' <thierry.reding@avionic-design.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Monday, July 09, 2012 1:22 PM, Alexandre Courbot wrote:

> pwm_backlight_update_status calls two callbacks before and after
> applying the new PWM settings. However, the brightness scale is
> completely changed in between if brightness levels are used. This patch
> ensures that both callbacks are passed brightness values of the same
> meaning.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 057389d..dd4d24d 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -39,6 +39,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>  {
>  	struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);
>  	int brightness = bl->props.brightness;
> +	int pwm_brightness;
>  	int max = bl->props.max_brightness;
> 
>  	if (bl->props.power != FB_BLANK_UNBLANK)
> @@ -55,13 +56,14 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
>  		pwm_disable(pb->pwm);
>  	} else {
>  		if (pb->levels) {
> -			brightness = pb->levels[brightness];
> +			pwm_brightness = pb->levels[brightness];
>  			max = pb->levels[max];
> -		}
> +		} else
> +			pwm_brightness = brightness;

Hi Alexandre Courbot,

Please, use braces to keep the Coding Style.
Refer to Documentation/CodingStyle as follow:

169 This does not apply if only one branch of a conditional statement is a single
170 statement; in the latter case use braces in both branches:
171
172 if (condition) {
173         do_this();
174         do_that();
175 } else {
176         otherwise();
177 }

Best regards,
Jingoo Han

> 
> -		brightness = pb->lth_brightness +
> -			(brightness * (pb->period - pb->lth_brightness) / max);
> -		pwm_config(pb->pwm, brightness, pb->period);
> +		pwm_brightness = pb->lth_brightness +
> +		     (pwm_brightness * (pb->period - pb->lth_brightness) / max);
> +		pwm_config(pb->pwm, pwm_brightness, pb->period);
>  		pwm_enable(pb->pwm);
>  	}
> 
> --
> 1.7.11.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

