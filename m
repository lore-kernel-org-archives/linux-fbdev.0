From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 09 Sep 2019 10:57:29 +0000
Subject: Re: [PATCH 1/2] backlight: lm3630a: add an enable gpio for the HWEN pin
Message-Id: <20190909105729.w5552rtop7rhghy2@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190908203704.30147-1-andreas@kemnade.info>
 <20190908203704.30147-2-andreas@kemnade.info>
In-Reply-To: <20190908203704.30147-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee.jones@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

On Sun, Sep 08, 2019 at 10:37:03PM +0200, Andreas Kemnade wrote:
> For now just enable it in the probe function to allow i2c
> access and disable it on remove. Disabling also means resetting
> the register values to default.
> 
> Tested on Kobo Clara HD.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/video/backlight/lm3630a_bl.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index b04b35d007a2..3b45a1733198 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -12,6 +12,8 @@
>  #include <linux/uaccess.h>
>  #include <linux/interrupt.h>
>  #include <linux/regmap.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio.h>
>  #include <linux/pwm.h>
>  #include <linux/platform_data/lm3630a_bl.h>
>  
> @@ -48,6 +50,7 @@ struct lm3630a_chip {
>  	struct lm3630a_platform_data *pdata;
>  	struct backlight_device *bleda;
>  	struct backlight_device *bledb;
> +	struct gpio_desc *enable_gpio;
>  	struct regmap *regmap;
>  	struct pwm_device *pwmd;
>  };
> @@ -506,6 +509,14 @@ static int lm3630a_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  	pchip->dev = &client->dev;
>  
> +	pchip->enable_gpio = devm_gpiod_get_optional(&client->dev, "enable",
> +						GPIOD_ASIS);

Initializing GPIOD_ASIS doesn't look right to me.

If you initialize ASIS then the driver must configure the pin as an
output... far easier just to set GPIOD_OUT_HIGH during the get.

Note also that the call to this function should also be moved *below*
the calls parse the DT.


> +	if (IS_ERR(pchip->enable_gpio)) {
> +		rval = PTR_ERR(pchip->enable_gpio);
> +		return rval;
> +	}
> +
> +
>  	pchip->regmap = devm_regmap_init_i2c(client, &lm3630a_regmap);
>  	if (IS_ERR(pchip->regmap)) {
>  		rval = PTR_ERR(pchip->regmap);
> @@ -535,6 +546,10 @@ static int lm3630a_probe(struct i2c_client *client,
>  	}
>  	pchip->pdata = pdata;
>  
> +	if (pchip->enable_gpio) {
> +		gpiod_set_value_cansleep(pchip->enable_gpio, 1);

Not needed, use GPIOD_OUT_HIGH instead.


> +		usleep_range(1000, 2000);

Not needed, this sleep is already part of lm3630a_chip_init().


> +	}
>  	/* chip initialize */
>  	rval = lm3630a_chip_init(pchip);
>  	if (rval < 0) {
> @@ -586,6 +601,9 @@ static int lm3630a_remove(struct i2c_client *client)
>  	if (rval < 0)
>  		dev_err(pchip->dev, "i2c failed to access register\n");
>  
> +	if (pchip->enable_gpio)
> +		gpiod_set_value_cansleep(pchip->enable_gpio, 0);
> +

Is this needed?

This is a remove path, not a power management path, and we have no idea
what the original status of the pin was anyway?


>  	if (pchip->irq) {
>  		free_irq(pchip->irq, pchip);
>  		flush_workqueue(pchip->irqthread);
> -- 
> 2.20.1
> 
