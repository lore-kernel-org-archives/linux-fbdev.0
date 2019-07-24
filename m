From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Jul 2019 11:12:22 +0000
Subject: Re: [PATCH v3 2/7] backlight: gpio: simplify the platform data handling
Message-Id: <20190724111222.6wcq72btthz4l3r7@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190724082508.27617-1-brgl@bgdev.pl>
 <20190724082508.27617-3-brgl@bgdev.pl>
In-Reply-To: <20190724082508.27617-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-fbdev@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>

On Wed, Jul 24, 2019 at 10:25:03AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Now that the last user of platform data (sh ecovec24) defines a proper
> GPIO lookup and sets the 'default-on' device property, we can drop the
> platform_data-specific GPIO handling and unify a big chunk of code.
> 
> The only field used from the platform data is now the fbdev pointer.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/gpio_backlight.c | 64 +++++-------------------
>  1 file changed, 13 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index e84f3087e29f..01262186fa1e 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -55,30 +55,6 @@ static const struct backlight_ops gpio_backlight_ops = {
>  	.check_fb	= gpio_backlight_check_fb,
>  };
>  
> -static int gpio_backlight_probe_dt(struct platform_device *pdev,
> -				   struct gpio_backlight *gbl)
> -{
> -	struct device *dev = &pdev->dev;
> -	enum gpiod_flags flags;
> -	int ret;
> -
> -	gbl->def_value = device_property_read_bool(dev, "default-on");
> -	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> -
> -	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
> -	if (IS_ERR(gbl->gpiod)) {
> -		ret = PTR_ERR(gbl->gpiod);
> -
> -		if (ret != -EPROBE_DEFER) {
> -			dev_err(dev,
> -				"Error: The gpios parameter is missing or invalid.\n");
> -		}
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int gpio_backlight_probe(struct platform_device *pdev)
>  {
>  	struct gpio_backlight_platform_data *pdata > @@ -86,6 +62,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
> +	enum gpiod_flags flags;
>  	int ret;
>  
>  	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
> @@ -94,35 +71,20 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  
>  	gbl->dev = &pdev->dev;
>  
> -	if (pdev->dev.fwnode) {
> -		ret = gpio_backlight_probe_dt(pdev, gbl);
> -		if (ret)
> -			return ret;
> -	} else if (pdata) {
> -		/*
> -		 * Legacy platform data GPIO retrieveal. Do not expand
> -		 * the use of this code path, currently only used by one
> -		 * SH board.
> -		 */
> -		unsigned long flags = GPIOF_DIR_OUT;
> -
> +	if (pdata)
>  		gbl->fbdev = pdata->fbdev;
> -		gbl->def_value = pdata->def_value;
> -		flags |= gbl->def_value ? GPIOF_INIT_HIGH : GPIOF_INIT_LOW;
> -
> -		ret = devm_gpio_request_one(gbl->dev, pdata->gpio, flags,
> -					    pdata ? pdata->name : "backlight");
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "unable to request GPIO\n");
> -			return ret;
> +
> +	gbl->def_value = device_property_read_bool(&pdev->dev, "default-on");
> +	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> +
> +	gbl->gpiod = devm_gpiod_get(&pdev->dev, NULL, flags);
> +	if (IS_ERR(gbl->gpiod)) {
> +		ret = PTR_ERR(gbl->gpiod);
> +		if (ret != -EPROBE_DEFER) {
> +			dev_err(&pdev->dev,
> +				"Error: The gpios parameter is missing or invalid.\n");
>  		}
> -		gbl->gpiod = gpio_to_desc(pdata->gpio);
> -		if (!gbl->gpiod)
> -			return -EINVAL;
> -	} else {
> -		dev_err(&pdev->dev,
> -			"failed to find platform data or device tree node.\n");
> -		return -ENODEV;
> +		return ret;
>  	}
>  
>  	memset(&props, 0, sizeof(props));
> -- 
> 2.21.0
> 
