From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 02 Jul 2019 09:02:03 +0000
Subject: Re: [PATCH 01/12] backlight: gpio: allow to probe non-pdata devices from board files
Message-Id: <57229b83-c876-1042-2866-1a63e6654bd4@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625163434.13620-1-brgl@bgdev.pl>
 <20190625163434.13620-2-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

On 25/06/2019 17:34, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently we can only probe devices that either use device tree or pass
> platform data to probe(). Rename gpio_backlight_probe_dt() to
> gpio_backlight_probe_prop() and use generic device properties instead
> of OF specific helpers.

This has already been done in (which IIRC did get queued for the next 
release):
https://www.spinics.net/lists/dri-devel/msg215050.html

> Reverse the logic checking the presence of
> platform data in probe(). This way we can probe devices() registered
> from machine code that neither have a DT node nor use platform data.

Andy's patch did not reverse this logic... but it does check 
pdev->dev.fwnode rather than of_node .


Daniel.


> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/video/backlight/gpio_backlight.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index b9300f3e1ee6..654c19d3a81d 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -54,15 +54,14 @@ static const struct backlight_ops gpio_backlight_ops = {
>   	.check_fb	= gpio_backlight_check_fb,
>   };
>   
> -static int gpio_backlight_probe_dt(struct platform_device *pdev,
> -				   struct gpio_backlight *gbl)
> +static int gpio_backlight_probe_prop(struct platform_device *pdev,
> +				     struct gpio_backlight *gbl)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;
>   	enum gpiod_flags flags;
>   	int ret;
>   
> -	gbl->def_value = of_property_read_bool(np, "default-on");
> +	gbl->def_value = device_property_read_bool(dev, "default-on");
>   	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
>   
>   	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
> @@ -86,26 +85,15 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>   	struct backlight_properties props;
>   	struct backlight_device *bl;
>   	struct gpio_backlight *gbl;
> -	struct device_node *np = pdev->dev.of_node;
>   	int ret;
>   
> -	if (!pdata && !np) {
> -		dev_err(&pdev->dev,
> -			"failed to find platform data or device tree node.\n");
> -		return -ENODEV;
> -	}
> -
>   	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
>   	if (gbl = NULL)
>   		return -ENOMEM;
>   
>   	gbl->dev = &pdev->dev;
>   
> -	if (np) {
> -		ret = gpio_backlight_probe_dt(pdev, gbl);
> -		if (ret)
> -			return ret;
> -	} else {
> +	if (pdata) {
>   		/*
>   		 * Legacy platform data GPIO retrieveal. Do not expand
>   		 * the use of this code path, currently only used by one
> @@ -126,6 +114,10 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>   		gbl->gpiod = gpio_to_desc(pdata->gpio);
>   		if (!gbl->gpiod)
>   			return -EINVAL;
> +	} else {
> +		ret = gpio_backlight_probe_prop(pdev, gbl);
> +		if (ret)
> +			return ret;
>   	}
>   
>   	memset(&props, 0, sizeof(props));
> 
