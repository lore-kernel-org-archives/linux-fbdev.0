From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 25 Jul 2013 23:47:36 +0000
Subject: Re: [PATCHv2 2/3] video: hx8357: Make IM pins optional
Message-Id: <002201ce8991$5785e8e0$0691baa0$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374757513-2253-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374757513-2253-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1374757513-2253-3-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, July 25, 2013 10:05 PM, Maxime Ripard wrote:
> 
> The IM pins of the HX8357 controller are used to define the interface
> used to feed pixel stream to the LCD panel.
> 
> Most of the time, these pins are directly routed to either the ground or
> the VCC to set their values.
> 
> Remove the need to assign GPIOs to these pins when we are in such a case.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/video/backlight/hx8357.c | 53 +++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
> 

[.....]

> +	if (of_find_property(spi->dev.of_node, "im-gpios", NULL)) {
> +		lcd->use_im_pins = 1;
> +
> +		for (i = 0; i < HX8357_NUM_IM_PINS; i++) {
> +			lcd->im_pins[i] = of_get_named_gpio(spi->dev.of_node,
> +							    "im-gpios", i);
> +			if (lcd->im_pins[i] = -EPROBE_DEFER) {
> +				dev_info(&spi->dev, "GPIO requested is not here yet, deferring the
> probe\n");
> +				return -EPROBE_DEFER;
> +			}
> +			if (!gpio_is_valid(lcd->im_pins[i])) {
> +				dev_err(&spi->dev, "Missing dt property: im-gpios\n");
> +				return -EINVAL;
> +			}
> +
> +			ret = devm_gpio_request_one(&spi->dev, lcd->im_pins[i],
> +						    GPIOF_OUT_INIT_LOW,
> +						    "im_pins");
> +			if (ret) {
> +				dev_err(&spi->dev, "failed to request gpio %d: %d\n",
> +					lcd->im_pins[i], ret);
> +				return -EINVAL;
> +			}
>  		}
> -
> -		ret = devm_gpio_request_one(&spi->dev, lcd->im_pins[i],
> -					GPIOF_OUT_INIT_LOW, "im_pins");
> -		if (ret) {
> -			dev_err(&spi->dev, "failed to request gpio %d: %d\n",
> -				lcd->im_pins[i], ret);
> -			return -EINVAL;
> -		}
> -	}
> +	} else
> +		lcd->use_im_pins = 0;

According to the 'Documentation/CodingStyle', braces are necessary as below.

	} else {
		lcd->use_im_pins = 0;
	}

Others look good.
Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han


