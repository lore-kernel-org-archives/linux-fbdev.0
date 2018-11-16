From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 16 Nov 2018 10:39:53 +0000
Subject: Re: [PATCH] backlight: pwm_bl: fix devicetree parsing with auto-generated brightness tables
Message-Id: <20181116103953.xcrsbn6gh366yxcp@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181112090257.7084-1-heiko@sntech.de>
In-Reply-To: <20181112090257.7084-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-fbdev@vger.kernel.org, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, enric.balletbo@collabora.com, lee.jones@linaro.org, Heiko Stuebner <heiko.stuebner@bq.com>

On Mon, Nov 12, 2018 at 10:02:57AM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> Commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly
> to human eye") made the parse-dt function return early when using an auto-
> generated brightness-table, but didn't take into account that some more
> settings were handled below the brightness handling, like power-on-delays
> and also setting the pdata enable-gpio to -EINVAL.
> 
> This surfaces for example in the case of a backlight without any
> enable-gpio which then tries to use gpio-0 in error.
> 
> Fix this by simply moving the trailing settings above the brightness
> handling.
> 
> Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/pwm_bl.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index bcd08b41765d..b7b5b31f3824 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -272,6 +272,16 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  
>  	memset(data, 0, sizeof(*data));
>  
> +	/*
> +	 * These values are optional and set as 0 by default, the out values
> +	 * are modified only if a valid u32 value can be decoded.
> +	 */
> +	of_property_read_u32(node, "post-pwm-on-delay-ms",
> +			     &data->post_pwm_on_delay);
> +	of_property_read_u32(node, "pwm-off-delay-ms", &data->pwm_off_delay);
> +
> +	data->enable_gpio = -EINVAL;
> +
>  	/*
>  	 * Determine the number of brightness levels, if this property is not
>  	 * set a default table of brightness levels will be used.
> @@ -384,15 +394,6 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  		data->max_brightness--;
>  	}
>  
> -	/*
> -	 * These values are optional and set as 0 by default, the out values
> -	 * are modified only if a valid u32 value can be decoded.
> -	 */
> -	of_property_read_u32(node, "post-pwm-on-delay-ms",
> -			     &data->post_pwm_on_delay);
> -	of_property_read_u32(node, "pwm-off-delay-ms", &data->pwm_off_delay);
> -
> -	data->enable_gpio = -EINVAL;
>  	return 0;
>  }
>  
> -- 
> 2.18.0
> 
