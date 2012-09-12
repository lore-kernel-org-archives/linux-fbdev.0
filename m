From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 12 Sep 2012 00:55:48 +0000
Subject: RE: [PATCH] pwm-backlight: Use devm_pwm_get in pwm_bl.c
Message-Id: <001601cd9081$5b2d0370$11870a50$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347352949-17515-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1347352949-17515-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tuesday, September 11, 2012 5:42 PM Sachin Kamat wrote
> 
> This file already makes use of device managed functions.
> Convert pwm_get() too to use it.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

CC'ed Thierry Reding.

Acked-by: Jingoo Han <jg1.han@samsung.com>


> ---
>  drivers/video/backlight/pwm_bl.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 4965408..0c91023 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -218,7 +218,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	pb->exit = data->exit;
>  	pb->dev = &pdev->dev;
> 
> -	pb->pwm = pwm_get(&pdev->dev, NULL);
> +	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm)) {
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
> 
> @@ -251,7 +251,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	if (IS_ERR(bl)) {
>  		dev_err(&pdev->dev, "failed to register backlight\n");
>  		ret = PTR_ERR(bl);
> -		goto err_bl;
> +		goto err_alloc;
>  	}
> 
>  	bl->props.brightness = data->dft_brightness;
> @@ -260,8 +260,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, bl);
>  	return 0;
> 
> -err_bl:
> -	pwm_put(pb->pwm);
>  err_alloc:
>  	if (data->exit)
>  		data->exit(&pdev->dev);
> @@ -276,7 +274,6 @@ static int pwm_backlight_remove(struct platform_device *pdev)
>  	backlight_device_unregister(bl);
>  	pwm_config(pb->pwm, 0, pb->period);
>  	pwm_disable(pb->pwm);
> -	pwm_put(pb->pwm);
>  	if (pb->exit)
>  		pb->exit(&pdev->dev);
>  	return 0;
> --
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

