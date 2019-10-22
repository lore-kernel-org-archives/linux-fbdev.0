From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 22 Oct 2019 10:14:17 +0000
Subject: Re: [PATCH v7 3/9] backlight: gpio: explicitly set the direction of the GPIO
Message-Id: <20191022101417.24zkd3htnyfg3hy6@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191022083630.28175-1-brgl@bgdev.pl>
 <20191022083630.28175-4-brgl@bgdev.pl>
In-Reply-To: <20191022083630.28175-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On Tue, Oct 22, 2019 at 10:36:24AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The GPIO backlight driver currently requests the line 'as is', without
> acively setting its direction. This can lead to problems: if the line
> is in input mode by default, we won't be able to drive it later when
> updating the status and also reading its initial value doesn't make
> sense for backlight setting.
> 
> Request the line 'as is' initially, so that we can read its value
> without affecting it but then change the direction to output explicitly
> when setting the initial brightness.
> 
> Also: check the current direction and only read the value if it's output.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/gpio_backlight.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 3955b513f2f8..52f17c9ca1c3 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -25,9 +25,8 @@ struct gpio_backlight {
>  	int def_value;
>  };
>  
> -static int gpio_backlight_update_status(struct backlight_device *bl)
> +static int gpio_backlight_get_next_brightness(struct backlight_device *bl)
>  {
> -	struct gpio_backlight *gbl = bl_get_data(bl);
>  	int brightness = bl->props.brightness;
>  
>  	if (bl->props.power != FB_BLANK_UNBLANK ||
> @@ -35,6 +34,14 @@ static int gpio_backlight_update_status(struct backlight_device *bl)
>  	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
>  		brightness = 0;
>  
> +	return brightness;
> +}
> +
> +static int gpio_backlight_update_status(struct backlight_device *bl)
> +{
> +	struct gpio_backlight *gbl = bl_get_data(bl);
> +	int brightness = gpio_backlight_get_next_brightness(bl);
> +
>  	gpiod_set_value_cansleep(gbl->gpiod, brightness);
>  
>  	return 0;
> @@ -85,7 +92,8 @@ static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
>  		return gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
>  
>  	/* if the enable GPIO is disabled, do not enable the backlight */
> -	if (gpiod_get_value_cansleep(gbl->gpiod) = 0)
> +	if (gpiod_get_direction(gbl->gpiod) = 0 &&
> +	    gpiod_get_value_cansleep(gbl->gpiod) = 0)
>  		return FB_BLANK_POWERDOWN;
>  
>  	return FB_BLANK_UNBLANK;
> @@ -98,7 +106,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
> -	int ret;
> +	int ret, init_brightness;
>  
>  	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
>  	if (gbl = NULL)
> @@ -151,7 +159,12 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	bl->props.power = gpio_backlight_initial_power_state(gbl);
>  	bl->props.brightness = 1;
>  
> -	backlight_update_status(bl);
> +	init_brightness = gpio_backlight_get_next_brightness(bl);
> +	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to set initial brightness\n");
> +		return ret;
> +	}
>  
>  	platform_set_drvdata(pdev, bl);
>  	return 0;
> -- 
> 2.23.0
> 
