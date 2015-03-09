From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 09 Mar 2015 09:40:28 +0000
Subject: Re: [PATCH v11 2/6] backlight: Add support Skyworks SKY81452 backlight driver
Message-Id: <20150309094028.GM3427@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425019346-4559-1-git-send-email-jack.yoo@skyworksinc.com>
 <1425019346-4559-3-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1425019346-4559-3-git-send-email-jack.yoo@skyworksinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: gyungoh@gmail.com
Cc: sameo@linux.intel.com, robh+dt@kernel.org, jg1.han@samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org, broonie@kernel.org, florian.vaussard@epfl.ch, andrew@lunn.ch, antonynpavlov@gmail.com, hytszk@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jack.yoo@skyworksinc.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, treding@nvidia.com, p.zabel@pengutronix.de, arno@natisbad.org, kuninori.morimoto.gx@renesas.com

Applied, thanks.

On Fri, 27 Feb 2015, gyungoh@gmail.com wrote:

> From: Gyungoh Yoo <jack.yoo@skyworksinc.com>
>=20
> Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Bryan Wu <cooloney@gmail.com>
> ---
> Changes v11:
> Renamed 'skyworks,en-channels' property to led-sources.
>=20
> Changes v10:
> Removed trivial get_brightness implementations
>=20
> Changes v9:
> Nothing
>=20
> Changes v8:
> Renamed property names for backlight with vendor prefix
> Modified gpio-enable property to generic property for GPIO
>=20
> Changes v7:
> Modified licensing text to GPLv2
>=20
> Changes v6:
> Added new line character at the end of line of dev_err()
>=20
> Changes v5:
> Move sky81452-backlight.h to include/linux/platform_data
>=20
> Changes v4:
> Reordering header files for readability
> Removed calling to backlight_device_unregister()
> Removed MODULE_VERSION()
> Modified license to GPLv2
>=20
> Changes v3:
> Modified DBG messages
>=20
> Changes v2:
> Added 'compatible' attribute in the driver
> Added message for exception or errors
>=20
>  drivers/video/backlight/Kconfig                  |  10 +
>  drivers/video/backlight/Makefile                 |   1 +
>  drivers/video/backlight/sky81452-backlight.c     | 353 +++++++++++++++++=
++++++
>  include/linux/platform_data/sky81452-backlight.h |  46 +++
>  4 files changed, 410 insertions(+)
>  create mode 100644 drivers/video/backlight/sky81452-backlight.c
>  create mode 100644 include/linux/platform_data/sky81452-backlight.h
>=20
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kc=
onfig
> index efb0904..2d9923a 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -408,6 +408,16 @@ config BACKLIGHT_PANDORA
>  	  If you have a Pandora console, say Y to enable the
>  	  backlight driver.
> =20
> +config BACKLIGHT_SKY81452
> +	tristate "Backlight driver for SKY81452"
> +	depends on BACKLIGHT_CLASS_DEVICE && MFD_SKY81452
> +	help
> +	  If you have a Skyworks SKY81452, say Y to enable the
> +	  backlight driver.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called sky81452-backlight
> +
>  config BACKLIGHT_TPS65217
>  	tristate "TPS65217 Backlight"
>  	depends on BACKLIGHT_CLASS_DEVICE && MFD_TPS65217
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/M=
akefile
> index fcd50b73..d67073f 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_BACKLIGHT_PANDORA)		+=3D pandora_bl.o
>  obj-$(CONFIG_BACKLIGHT_PCF50633)	+=3D pcf50633-backlight.o
>  obj-$(CONFIG_BACKLIGHT_PWM)		+=3D pwm_bl.o
>  obj-$(CONFIG_BACKLIGHT_SAHARA)		+=3D kb3886_bl.o
> +obj-$(CONFIG_BACKLIGHT_SKY81452)	+=3D sky81452-backlight.o
>  obj-$(CONFIG_BACKLIGHT_TOSA)		+=3D tosa_bl.o
>  obj-$(CONFIG_BACKLIGHT_TPS65217)	+=3D tps65217_bl.o
>  obj-$(CONFIG_BACKLIGHT_WM831X)		+=3D wm831x_bl.o
> diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video=
/backlight/sky81452-backlight.c
> new file mode 100644
> index 0000000..052fa1b
> --- /dev/null
> +++ b/drivers/video/backlight/sky81452-backlight.c
> @@ -0,0 +1,353 @@
> +/*
> + * sky81452-backlight.c	SKY81452 backlight driver
> + *
> + * Copyright 2014 Skyworks Solutions Inc.
> + * Author : Gyungoh Yoo <jack.yoo@skyworksinc.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_data/sky81452-backlight.h>
> +#include <linux/slab.h>
> +
> +/* registers */
> +#define SKY81452_REG0	0x00
> +#define SKY81452_REG1	0x01
> +#define SKY81452_REG2	0x02
> +#define SKY81452_REG4	0x04
> +#define SKY81452_REG5	0x05
> +
> +/* bit mask */
> +#define SKY81452_CS	0xFF
> +#define SKY81452_EN	0x3F
> +#define SKY81452_IGPW	0x20
> +#define SKY81452_PWMMD	0x10
> +#define SKY81452_PHASE	0x08
> +#define SKY81452_ILIM	0x04
> +#define SKY81452_VSHRT	0x03
> +#define SKY81452_OCP	0x80
> +#define SKY81452_OTMP	0x40
> +#define SKY81452_SHRT	0x3F
> +#define SKY81452_OPN	0x3F
> +
> +#define SKY81452_DEFAULT_NAME "lcd-backlight"
> +#define SKY81452_MAX_BRIGHTNESS	(SKY81452_CS + 1)
> +
> +#define CTZ(b) __builtin_ctz(b)
> +
> +static int sky81452_bl_update_status(struct backlight_device *bd)
> +{
> +	const struct sky81452_bl_platform_data *pdata > +			dev_get_platdata(bd=
->dev.parent);
> +	const unsigned int brightness =3D (unsigned int)bd->props.brightness;
> +	struct regmap *regmap =3D bl_get_data(bd);
> +	int ret;
> +
> +	if (brightness > 0) {
> +		ret =3D regmap_write(regmap, SKY81452_REG0, brightness - 1);
> +		if (IS_ERR_VALUE(ret))
> +			return ret;
> +
> +		return regmap_update_bits(regmap, SKY81452_REG1, SKY81452_EN,
> +					pdata->enable << CTZ(SKY81452_EN));
> +	}
> +
> +	return regmap_update_bits(regmap, SKY81452_REG1, SKY81452_EN, 0);
> +}
> +
> +static const struct backlight_ops sky81452_bl_ops =3D {
> +	.update_status =3D sky81452_bl_update_status,
> +};
> +
> +static ssize_t sky81452_bl_store_enable(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct regmap *regmap =3D bl_get_data(to_backlight_device(dev));
> +	unsigned long value;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 16, &value);
> +	if (IS_ERR_VALUE(ret))
> +		return ret;
> +
> +	ret =3D regmap_update_bits(regmap, SKY81452_REG1, SKY81452_EN,
> +					value << CTZ(SKY81452_EN));
> +	if (IS_ERR_VALUE(ret))
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t sky81452_bl_show_open_short(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct regmap *regmap =3D bl_get_data(to_backlight_device(dev));
> +	unsigned int reg, value =3D 0;
> +	char tmp[3];
> +	int i, ret;
> +
> +	reg =3D !strcmp(attr->attr.name, "open") ? SKY81452_REG5 : SKY81452_REG=
4;
> +	ret =3D regmap_read(regmap, reg, &value);
> +	if (IS_ERR_VALUE(ret))
> +		return ret;
> +
> +	if (value & SKY81452_SHRT) {
> +		*buf =3D 0;
> +		for (i =3D 0; i < 6; i++) {
> +			if (value & 0x01) {
> +				sprintf(tmp, "%d ", i + 1);
> +				strcat(buf, tmp);
> +			}
> +			value >>=3D 1;
> +		}
> +		strcat(buf, "\n");
> +	} else {
> +		strcpy(buf, "none\n");
> +	}
> +
> +	return strlen(buf);
> +}
> +
> +static ssize_t sky81452_bl_show_fault(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct regmap *regmap =3D bl_get_data(to_backlight_device(dev));
> +	unsigned int value =3D 0;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, SKY81452_REG4, &value);
> +	if (IS_ERR_VALUE(ret))
> +		return ret;
> +
> +	*buf =3D 0;
> +
> +	if (value & SKY81452_OCP)
> +		strcat(buf, "over-current ");
> +
> +	if (value & SKY81452_OTMP)
> +		strcat(buf, "over-temperature");
> +
> +	strcat(buf, "\n");
> +	return strlen(buf);
> +}
> +
> +static DEVICE_ATTR(enable, S_IWGRP | S_IWUSR, NULL, sky81452_bl_store_en=
able);
> +static DEVICE_ATTR(open, S_IRUGO, sky81452_bl_show_open_short, NULL);
> +static DEVICE_ATTR(short, S_IRUGO, sky81452_bl_show_open_short, NULL);
> +static DEVICE_ATTR(fault, S_IRUGO, sky81452_bl_show_fault, NULL);
> +
> +static struct attribute *sky81452_bl_attribute[] =3D {
> +	&dev_attr_enable.attr,
> +	&dev_attr_open.attr,
> +	&dev_attr_short.attr,
> +	&dev_attr_fault.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group sky81452_bl_attr_group =3D {
> +	.attrs =3D sky81452_bl_attribute,
> +};
> +
> +#ifdef CONFIG_OF
> +static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
> +							struct device *dev)
> +{
> +	struct device_node *np =3D of_node_get(dev->of_node);
> +	struct sky81452_bl_platform_data *pdata;
> +	int num_entry;
> +	unsigned int sources[6];
> +	int ret;
> +
> +	if (!np) {
> +		dev_err(dev, "backlight node not found.\n");
> +		return ERR_PTR(-ENODATA);
> +	}
> +
> +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		of_node_put(np);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	of_property_read_string(np, "name", &pdata->name);
> +	pdata->ignore_pwm =3D of_property_read_bool(np, "skyworks,ignore-pwm");
> +	pdata->dpwm_mode =3D of_property_read_bool(np, "skyworks,dpwm-mode");
> +	pdata->phase_shift =3D of_property_read_bool(np, "skyworks,phase-shift"=
);
> +	pdata->gpio_enable =3D of_get_gpio(np, 0);
> +
> +	ret =3D of_property_count_u32_elems(np, "led-sources");
> +	if (IS_ERR_VALUE(ret)) {
> +		pdata->enable =3D SKY81452_EN >> CTZ(SKY81452_EN);
> +	} else {
> +		num_entry =3D ret;
> +		if (num_entry > 6)
> +			num_entry =3D 6;
> +
> +		ret =3D of_property_read_u32_array(np, "led-sources", sources,
> +					num_entry);
> +		if (IS_ERR_VALUE(ret)) {
> +			dev_err(dev, "led-sources node is invalid.\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		pdata->enable =3D 0;
> +		while (--num_entry)
> +			pdata->enable |=3D (1 << sources[num_entry]);
> +	}
> +
> +	ret =3D of_property_read_u32(np,
> +			"skyworks,short-detection-threshold-volt",
> +			&pdata->short_detection_threshold);
> +	if (IS_ERR_VALUE(ret))
> +		pdata->short_detection_threshold =3D 7;
> +
> +	ret =3D of_property_read_u32(np, "skyworks,current-limit-mA",
> +			&pdata->boost_current_limit);
> +	if (IS_ERR_VALUE(ret))
> +		pdata->boost_current_limit =3D 2750;
> +
> +	of_node_put(np);
> +	return pdata;
> +}
> +#else
> +static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
> +							struct device *dev)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +#endif
> +
> +static int sky81452_bl_init_device(struct regmap *regmap,
> +		struct sky81452_bl_platform_data *pdata)
> +{
> +	unsigned int value;
> +
> +	value =3D pdata->ignore_pwm ? SKY81452_IGPW : 0;
> +	value |=3D pdata->dpwm_mode ? SKY81452_PWMMD : 0;
> +	value |=3D pdata->phase_shift ? 0 : SKY81452_PHASE;
> +
> +	if (pdata->boost_current_limit =3D 2300)
> +		value |=3D SKY81452_ILIM;
> +	else if (pdata->boost_current_limit !=3D 2750)
> +		return -EINVAL;
> +
> +	if (pdata->short_detection_threshold < 4 ||
> +				pdata->short_detection_threshold > 7)
> +		return -EINVAL;
> +	value |=3D (7 - pdata->short_detection_threshold) << CTZ(SKY81452_VSHRT=
);
> +
> +	return regmap_write(regmap, SKY81452_REG2, value);
> +}
> +
> +static int sky81452_bl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct regmap *regmap =3D dev_get_drvdata(dev->parent);
> +	struct sky81452_bl_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct backlight_device *bd;
> +	struct backlight_properties props;
> +	const char *name;
> +	int ret;
> +
> +	if (!pdata) {
> +		pdata =3D sky81452_bl_parse_dt(dev);
> +		if (IS_ERR(pdata))
> +			return PTR_ERR(pdata);
> +	}
> +
> +	if (gpio_is_valid(pdata->gpio_enable)) {
> +		ret =3D devm_gpio_request_one(dev, pdata->gpio_enable,
> +					GPIOF_OUT_INIT_HIGH, "sky81452-en");
> +		if (IS_ERR_VALUE(ret)) {
> +			dev_err(dev, "failed to request GPIO. err=3D%d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret =3D sky81452_bl_init_device(regmap, pdata);
> +	if (IS_ERR_VALUE(ret)) {
> +		dev_err(dev, "failed to initialize. err=3D%d\n", ret);
> +		return ret;
> +	}
> +
> +	memset(&props, 0, sizeof(props));
> +	props.max_brightness =3D SKY81452_MAX_BRIGHTNESS,
> +	name =3D pdata->name ? pdata->name : SKY81452_DEFAULT_NAME;
> +	bd =3D devm_backlight_device_register(dev, name, dev, regmap,
> +						&sky81452_bl_ops, &props);
> +	if (IS_ERR(bd)) {
> +		dev_err(dev, "failed to register. err=3D%ld\n", PTR_ERR(bd));
> +		return PTR_ERR(bd);
> +	}
> +
> +	platform_set_drvdata(pdev, bd);
> +
> +	ret  =3D sysfs_create_group(&bd->dev.kobj, &sky81452_bl_attr_group);
> +	if (IS_ERR_VALUE(ret)) {
> +		dev_err(dev, "failed to create attribute. err=3D%d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sky81452_bl_remove(struct platform_device *pdev)
> +{
> +	const struct sky81452_bl_platform_data *pdata > +						dev_get_platdata=
(&pdev->dev);
> +	struct backlight_device *bd =3D platform_get_drvdata(pdev);
> +
> +	sysfs_remove_group(&bd->dev.kobj, &sky81452_bl_attr_group);
> +
> +	bd->props.power =3D FB_BLANK_UNBLANK;
> +	bd->props.brightness =3D 0;
> +	backlight_update_status(bd);
> +
> +	if (gpio_is_valid(pdata->gpio_enable))
> +		gpio_set_value_cansleep(pdata->gpio_enable, 0);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id sky81452_bl_of_match[] =3D {
> +	{ .compatible =3D "skyworks,sky81452-backlight", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sky81452_bl_of_match);
> +#endif
> +
> +static struct platform_driver sky81452_bl_driver =3D {
> +	.driver =3D {
> +		.name =3D "sky81452-backlight",
> +		.of_match_table =3D of_match_ptr(sky81452_bl_of_match),
> +	},
> +	.probe =3D sky81452_bl_probe,
> +	.remove =3D sky81452_bl_remove,
> +};
> +
> +module_platform_driver(sky81452_bl_driver);
> +
> +MODULE_DESCRIPTION("Skyworks SKY81452 backlight driver");
> +MODULE_AUTHOR("Gyungoh Yoo <jack.yoo@skyworksinc.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/platform_data/sky81452-backlight.h b/include/l=
inux/platform_data/sky81452-backlight.h
> new file mode 100644
> index 0000000..1231e9b
> --- /dev/null
> +++ b/include/linux/platform_data/sky81452-backlight.h
> @@ -0,0 +1,46 @@
> +/*
> + * sky81452.h	SKY81452 backlight driver
> + *
> + * Copyright 2014 Skyworks Solutions Inc.
> + * Author : Gyungoh Yoo <jack.yoo@skyworksinc.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef _SKY81452_BACKLIGHT_H
> +#define _SKY81452_BACKLIGHT_H
> +
> +/**
> + * struct sky81452_platform_data
> + * @name:	backlight driver name.
> +		If it is not defined, default name is lcd-backlight.
> + * @gpio_enable:GPIO number which control EN pin
> + * @enable:	Enable mask for current sink channel 1, 2, 3, 4, 5 and 6.
> + * @ignore_pwm:	true if DPWMI should be ignored.
> + * @dpwm_mode:	true is DPWM dimming mode, otherwise Analog dimming mode.
> + * @phase_shift:true is phase shift mode.
> + * @short_detecion_threshold:	It should be one of 4, 5, 6 and 7V.
> + * @boost_current_limit:	It should be one of 2300, 2750mA.
> + */
> +struct sky81452_bl_platform_data {
> +	const char *name;
> +	int gpio_enable;
> +	unsigned int enable;
> +	bool ignore_pwm;
> +	bool dpwm_mode;
> +	bool phase_shift;
> +	unsigned int short_detection_threshold;
> +	unsigned int boost_current_limit;
> +};
> +
> +#endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
