From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 02 Jul 2019 09:11:16 +0000
Subject: Re: [PATCH 03/12] backlight: gpio: pull the non-pdata device probing code into probe()
Message-Id: <920a5359-d662-5111-8b3d-4f5c63b2afb6@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625163434.13620-1-brgl@bgdev.pl>
 <20190625163434.13620-4-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

On 25/06/2019 17:34, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> There's no good reason to have the generic probing code in a separate
> routine. This function is short and is inlined by the compiler anyway.
> Move it into probe under the pdata-specific part.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Like the others, this will need to be respun to match latest code but 
when it comes round again:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> ---
>   drivers/video/backlight/gpio_backlight.c | 39 ++++++++----------------
>   1 file changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 8adbc8d75097..89e10bccfd3c 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -54,30 +54,6 @@ static const struct backlight_ops gpio_backlight_ops = {
>   	.check_fb	= gpio_backlight_check_fb,
>   };
>   
> -static int gpio_backlight_probe_prop(struct platform_device *pdev,
> -				     struct gpio_backlight *gbl)
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
>   static int gpio_backlight_probe(struct platform_device *pdev)
>   {
>   	struct gpio_backlight_platform_data *pdata > @@ -86,6 +62,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct backlight_device *bl;
>   	struct gpio_backlight *gbl;
> +	enum gpiod_flags flags;
>   	int ret;
>   
>   	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
> @@ -116,9 +93,19 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>   		if (!gbl->gpiod)
>   			return -EINVAL;
>   	} else {
> -		ret = gpio_backlight_probe_prop(pdev, gbl);
> -		if (ret)
> +		gbl->def_value = device_property_read_bool(dev, "default-on");
> +		flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> +
> +		gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
> +		if (IS_ERR(gbl->gpiod)) {
> +			ret = PTR_ERR(gbl->gpiod);
> +
> +			if (ret != -EPROBE_DEFER) {
> +				dev_err(dev,
> +					"Error: The gpios parameter is missing or invalid.\n");
> +			}
>   			return ret;
> +		}
>   	}
>   
>   	memset(&props, 0, sizeof(props));
> 
