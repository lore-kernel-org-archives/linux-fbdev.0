From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Mon, 24 Jun 2013 14:26:45 +0000
Subject: Re: [PATCH 1/2] fb: backlight: HX8357: Make IM pins optionnal
Message-Id: <20130624142645.GG305@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371839259-543-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1371839259-543-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, jimwall@q.com, brian@crystalfontz.com, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On 20:27 Fri 21 Jun     , Alexandre Belloni wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/video/backlight/hx8357.c | 53 +++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
> index a0482b5..69f5672 100644
> --- a/drivers/video/backlight/hx8357.c
> +++ b/drivers/video/backlight/hx8357.c
> @@ -76,6 +76,7 @@ struct hx8357_data {
>  	unsigned		reset;
>  	struct spi_device	*spi;
>  	int			state;
> +	u8			use_im_pins;
boolean please
>  };
>  
>  static u8 hx8357_seq_power[] = {
> @@ -250,9 +251,11 @@ static int hx8357_lcd_init(struct lcd_device *lcdev)
>  	 * Set the interface selection pins to SPI mode, with three
>  	 * wires
>  	 */
> -	gpio_set_value_cansleep(lcd->im_pins[0], 1);
> -	gpio_set_value_cansleep(lcd->im_pins[1], 0);
> -	gpio_set_value_cansleep(lcd->im_pins[2], 1);
> +	if (lcd->use_im_pins) {
> +		gpio_set_value_cansleep(lcd->im_pins[0], 1);
> +		gpio_set_value_cansleep(lcd->im_pins[1], 0);
> +		gpio_set_value_cansleep(lcd->im_pins[2], 1);
> +	}

base on the dt probe you may have gpios betwee 0 to HX8357_NUM_IM_PINS

so this look wrong
>  
>  	/* Reset the screen */
>  	gpio_set_value(lcd->reset, 1);
> @@ -424,26 +427,32 @@ static int hx8357_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	for (i = 0; i < HX8357_NUM_IM_PINS; i++) {
> -		lcd->im_pins[i] = of_get_named_gpio(spi->dev.of_node,
> -						"im-gpios", i);
> -		if (lcd->im_pins[i] = -EPROBE_DEFER) {
> -			dev_info(&spi->dev, "GPIO requested is not here yet, deferring the probe\n");
> -			return -EPROBE_DEFER;
> -		}
> -		if (!gpio_is_valid(lcd->im_pins[i])) {
> -			dev_err(&spi->dev, "Missing dt property: im-gpios\n");
> -			return -EINVAL;
> +	if (of_find_property(spi->dev.of_node, "im-gpios", NULL)) {
> +		lcd->use_im_pins = 1;
> +
> +		for (i = 0; i < HX8357_NUM_IM_PINS; i++) {
> +			lcd->im_pins[i] = of_get_named_gpio(spi->dev.of_node,
> +							    "im-gpios", i);
> +			if (lcd->im_pins[i] = -EPROBE_DEFER) {
> +				dev_info(&spi->dev, "GPIO requested is not here yet, deferring the probe\n");
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
>  
>  	lcdev = lcd_device_register("mxsfb", &spi->dev, lcd, &hx8357_ops);
>  	if (IS_ERR(lcdev)) {
> -- 
> 1.8.1.2
> 
