From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 13 Oct 2015 08:43:41 +0000
Subject: Re: [PATCHv4 2/3] backlight: add led-backlight driver
Message-Id: <20151013084341.GB32409@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
 <1443605522-1118-3-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1443605522-1118-3-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Jingoo?

On Wed, 30 Sep 2015, Tomi Valkeinen wrote:
> This patch adds a led-backlight driver (led_bl), which is similar to
> pwm_bl except the driver uses a LED class driver to adjust the
> brightness in the HW.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/backlight/Kconfig  |   7 ++
>  drivers/video/backlight/Makefile |   1 +
>  drivers/video/backlight/led_bl.c | 246 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 drivers/video/backlight/led_bl.c
>=20
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kc=
onfig
> index 0505b796d743..d1336196aba2 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -453,6 +453,13 @@ config BACKLIGHT_BD6107
>  	help
>  	  If you have a Rohm BD6107 say Y to enable the backlight driver.
> =20
> +config BACKLIGHT_LED
> +	tristate "Generic LED based Backlight Driver"
> +	depends on LEDS_CLASS && OF
> +	help
> +	  If you have a LCD backlight adjustable by LED class driver, say Y
> +	  to enable this driver.
> +
>  endif # BACKLIGHT_CLASS_DEVICE
> =20
>  endif # BACKLIGHT_LCD_SUPPORT
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/M=
akefile
> index d67073f9d421..ecd321daee21 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -54,3 +54,4 @@ obj-$(CONFIG_BACKLIGHT_SKY81452)	+=3D sky81452-backligh=
t.o
>  obj-$(CONFIG_BACKLIGHT_TOSA)		+=3D tosa_bl.o
>  obj-$(CONFIG_BACKLIGHT_TPS65217)	+=3D tps65217_bl.o
>  obj-$(CONFIG_BACKLIGHT_WM831X)		+=3D wm831x_bl.o
> +obj-$(CONFIG_BACKLIGHT_LED)		+=3D led_bl.o
> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/l=
ed_bl.c
> new file mode 100644
> index 000000000000..1befc8ce5964
> --- /dev/null
> +++ b/drivers/video/backlight/led_bl.c
> @@ -0,0 +1,246 @@
> +/*
> + * Copyright 2015 Texas Instruments
> + *
> + * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> + *
> + * Based on pwm_bl.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +#include <linux/backlight.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/leds.h>
> +#include <linux/of_leds.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +struct led_bl_data {
> +	struct device		*dev;
> +	struct backlight_device	*bl_dev;
> +
> +	unsigned int		*levels;
> +	bool			enabled;
> +	struct regulator	*power_supply;
> +	struct gpio_desc	*enable_gpio;
> +
> +	struct led_classdev *led_cdev;
> +
> +	unsigned int max_brightness;
> +	unsigned int default_brightness;
> +};
> +
> +static void led_bl_set_brightness(struct led_bl_data *priv, int brightne=
ss)
> +{
> +	int err;
> +
> +	if (!priv->enabled) {
> +		if (priv->power_supply) {
> +			err =3D regulator_enable(priv->power_supply);
> +
> +			if (err < 0)
> +				dev_err(priv->dev,
> +					"failed to enable power supply\n");
> +		}
> +
> +		if (priv->enable_gpio)
> +			gpiod_set_value_cansleep(priv->enable_gpio, 1);
> +	}
> +
> +	led_set_brightness(priv->led_cdev, priv->levels[brightness]);
> +
> +	priv->enabled =3D true;
> +}
> +
> +static void led_bl_power_off(struct led_bl_data *priv)
> +{
> +	if (!priv->enabled)
> +		return;
> +
> +	led_set_brightness(priv->led_cdev, LED_OFF);
> +
> +	if (priv->enable_gpio)
> +		gpiod_set_value_cansleep(priv->enable_gpio, 0);
> +
> +	if (priv->power_supply)
> +		regulator_disable(priv->power_supply);
> +
> +	priv->enabled =3D false;
> +}
> +
> +static int led_bl_update_status(struct backlight_device *bl)
> +{
> +	struct led_bl_data *priv =3D bl_get_data(bl);
> +	int brightness =3D bl->props.brightness;
> +
> +	if (bl->props.power !=3D FB_BLANK_UNBLANK ||
> +	    bl->props.fb_blank !=3D FB_BLANK_UNBLANK ||
> +	    bl->props.state & BL_CORE_FBBLANK)
> +		brightness =3D 0;
> +
> +	if (brightness > 0)
> +		led_bl_set_brightness(priv, brightness);
> +	else
> +		led_bl_power_off(priv);
> +
> +	return 0;
> +}
> +
> +static const struct backlight_ops led_bl_ops =3D {
> +	.update_status	=3D led_bl_update_status,
> +};
> +
> +static int led_bl_parse_dt(struct device *dev,
> +			   struct led_bl_data *priv)
> +{
> +	struct device_node *node =3D dev->of_node;
> +	int num_levels;
> +	u32 *levels;
> +	u32 value;
> +	int ret;
> +
> +	if (!node)
> +		return -ENODEV;
> +
> +	num_levels =3D of_property_count_u32_elems(node, "brightness-levels");
> +	if (num_levels < 0) {
> +		dev_err(dev, "failed to find 'brightness-levels'\n");
> +		return num_levels;
> +	}
> +
> +	levels =3D devm_kzalloc(dev, sizeof(u32) * num_levels, GFP_KERNEL);
> +	if (!levels)
> +		return -ENOMEM;
> +
> +	ret =3D of_property_read_u32_array(node, "brightness-levels",
> +					 levels,
> +					 num_levels);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to parse 'brightness-levels'\n");
> +		return ret;
> +	}
> +
> +	ret =3D of_property_read_u32(node, "default-brightness-level", &value);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to parse 'default-brightness-level'\n");
> +		return ret;
> +	}
> +
> +	if (value >=3D num_levels) {
> +		dev_err(dev, "invalid default-brightness-level\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->levels =3D levels;
> +	priv->max_brightness =3D num_levels - 1;
> +	priv->default_brightness =3D value;
> +
> +	priv->led_cdev =3D of_led_get(node);
> +	if (IS_ERR(priv->led_cdev)) {
> +		dev_err(dev, "failed to get LED device\n");
> +		return PTR_ERR(priv->led_cdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int led_bl_probe(struct platform_device *pdev)
> +{
> +	struct backlight_properties props;
> +	struct led_bl_data *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->dev =3D &pdev->dev;
> +
> +	ret =3D led_bl_parse_dt(&pdev->dev, priv);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to parse DT data\n");
> +		return ret;
> +	}
> +
> +	priv->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable",
> +			    GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->enable_gpio)) {
> +		ret =3D PTR_ERR(priv->enable_gpio);
> +		goto err;
> +	}
> +
> +	priv->power_supply =3D devm_regulator_get_optional(&pdev->dev, "power");
> +	if (IS_ERR(priv->power_supply)) {
> +		ret =3D PTR_ERR(priv->power_supply);
> +
> +		if (ret =3D -ENODEV) {
> +			priv->power_supply =3D NULL;
> +		} else {
> +			ret =3D PTR_ERR(priv->power_supply);
> +			goto err;
> +		}
> +	}
> +
> +	memset(&props, 0, sizeof(struct backlight_properties));
> +	props.type =3D BACKLIGHT_RAW;
> +	props.max_brightness =3D priv->max_brightness;
> +	priv->bl_dev =3D backlight_device_register(dev_name(&pdev->dev),
> +			&pdev->dev, priv, &led_bl_ops, &props);
> +	if (IS_ERR(priv->bl_dev)) {
> +		dev_err(&pdev->dev, "failed to register backlight\n");
> +		ret =3D PTR_ERR(priv->bl_dev);
> +		goto err;
> +	}
> +
> +	priv->bl_dev->props.brightness =3D priv->default_brightness;
> +	backlight_update_status(priv->bl_dev);
> +
> +	return 0;
> +
> +err:
> +	if (priv->led_cdev)
> +		led_put(priv->led_cdev);
> +
> +	return ret;
> +}
> +
> +static int led_bl_remove(struct platform_device *pdev)
> +{
> +	struct led_bl_data *priv =3D platform_get_drvdata(pdev);
> +	struct backlight_device *bl =3D priv->bl_dev;
> +
> +	backlight_device_unregister(bl);
> +
> +	led_bl_power_off(priv);
> +
> +	led_put(priv->led_cdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id led_bl_of_match[] =3D {
> +	{ .compatible =3D "led-backlight" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, led_bl_of_match);
> +
> +static struct platform_driver led_bl_driver =3D {
> +	.driver		=3D {
> +		.name		=3D "led-backlight",
> +		.of_match_table	=3D of_match_ptr(led_bl_of_match),
> +	},
> +	.probe		=3D led_bl_probe,
> +	.remove		=3D led_bl_remove,
> +};
> +
> +module_platform_driver(led_bl_driver);
> +
> +MODULE_DESCRIPTION("LED based Backlight Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:led-backlight");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
