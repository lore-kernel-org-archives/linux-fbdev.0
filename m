From: "Jingoo Han" <jingoohan1@gmail.com>
Date: Mon, 18 May 2015 23:15:25 +0000
Subject: Re: [PATCH] backlight: pwm: make use of 3rd argument to devm_gpiod_get_optional
Message-Id: <000001d091c0$88f832a0$9ae897e0$@com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431983162-21494-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1431983162-21494-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Tuesday, May 19, 2015 6:06 AM, Uwe Kleine-König wrote:
> 
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions) which
> appeared in v3.17-rc1, the gpiod_get* functions take an additional parameter
> that allows to specify direction and initial value for output.
>
> This allows to drop the explicit setting of direction.
>
> Furthermore this is one caller less that stops us making the 3rd 
> argument mandatory.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

+cc Axel Lin

Hi Uwe Kleine-König,

The same patch was already sent by Axel Lin 3 days ago.
Anyway, thank you for sending the patch.

Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/pwm_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 3a145a643e0d..57cb9ec8be43 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -241,7 +241,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	pb->dev = &pdev->dev;
>  	pb->enabled = false;
>  
> -	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");
> +	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> +						  GPIOD_OUT_HIGH);
>  	if (IS_ERR(pb->enable_gpio)) {
>  		ret = PTR_ERR(pb->enable_gpio);
>  		goto err_alloc;
> @@ -263,9 +264,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
>  	}
>  
> -	if (pb->enable_gpio)
> -		gpiod_direction_output(pb->enable_gpio, 1);
> -
>  	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
>  	if (IS_ERR(pb->power_supply)) {
>  		ret = PTR_ERR(pb->power_supply);
> --
> 2.1.4

