From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 09 Mar 2015 09:40:12 +0000
Subject: Re: [PATCH v11 1/6] mfd: Add support for Skyworks SKY81452 driver
Message-Id: <20150309094012.GL3427@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425019346-4559-1-git-send-email-jack.yoo@skyworksinc.com>
 <1425019346-4559-2-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1425019346-4559-2-git-send-email-jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: gyungoh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, florian.vaussard-p8DiymsW2f8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hytszk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org

Applied, thanks.

On Fri, 27 Feb 2015, gyungoh@gmail.com wrote:

> From: Gyungoh Yoo <jack.yoo@skyworksinc.com>
>=20
> Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> Changes v11:
> Nothing
>=20
> Changes v10:
> Nothing
>=20
> Changes v9:
> Nothing
>=20
> Changes v8:
> Nothing
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
> Removed MODULE_VERSION()
> Modified license to GPLv2
>=20
> Changes v3:
> Fixed the backlight name from 'sky81452-bl' to 'sky81452-backlight'
> Assigned mfd_cell.of_compatible for binding device node
> Modified error messages
>=20
> Changes v2:
> Renamed CONFIG_SKY81452 to CONFIG_MFD_SKY81452
> Changed the dependency from I2C=3Dy to I2C, for CONFIG_MFD_SKY81452
> Added message for exception or errors
>=20
>  drivers/mfd/Kconfig          |  12 +++++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/sky81452.c       | 108 +++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/sky81452.h |  31 +++++++++++++
>  4 files changed, 152 insertions(+)
>  create mode 100644 drivers/mfd/sky81452.c
>  create mode 100644 include/linux/mfd/sky81452.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 38356e3..bc3b540 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -753,6 +753,18 @@ config MFD_SM501_GPIO
>  	 lines on the SM501. The platform data is used to supply the
>  	 base number for the first GPIO line to register.
> =20
> +config MFD_SKY81452
> +	tristate "Skyworks Solutions SKY81452"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  This is the core driver for the Skyworks SKY81452 backlight and
> +	  voltage regulator device.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sky81452.
> +
>  config MFD_SMSC
>         bool "SMSC ECE1099 series chips"
>         depends on I2C=3Dy
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 19f3d74..75b3ffb 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -178,6 +178,7 @@ obj-$(CONFIG_MFD_MENF21BMC)	+=3D menf21bmc.o
>  obj-$(CONFIG_MFD_HI6421_PMIC)	+=3D hi6421-pmic-core.o
>  obj-$(CONFIG_MFD_DLN2)		+=3D dln2.o
>  obj-$(CONFIG_MFD_RT5033)	+=3D rt5033.o
> +obj-$(CONFIG_MFD_SKY81452)	+=3D sky81452.o
> =20
>  intel-soc-pmic-objs		:=3D intel_soc_pmic_core.o intel_soc_pmic_crc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+=3D intel-soc-pmic.o
> diff --git a/drivers/mfd/sky81452.c b/drivers/mfd/sky81452.c
> new file mode 100644
> index 0000000..b0c9b04
> --- /dev/null
> +++ b/drivers/mfd/sky81452.c
> @@ -0,0 +1,108 @@
> +/*
> + * sky81452.c	SKY81452 MFD driver
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
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/sky81452.h>
> +
> +static const struct regmap_config sky81452_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};
> +
> +static int sky81452_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +	struct device *dev =3D &client->dev;
> +	const struct sky81452_platform_data *pdata =3D dev_get_platdata(dev);
> +	struct mfd_cell cells[2];
> +	struct regmap *regmap;
> +	int ret;
> +
> +	if (!pdata) {
> +		pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			return -ENOMEM;
> +	}
> +
> +	regmap =3D devm_regmap_init_i2c(client, &sky81452_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "failed to initialize.err=3D%ld\n", PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	i2c_set_clientdata(client, regmap);
> +
> +	memset(cells, 0, sizeof(cells));
> +	cells[0].name =3D "sky81452-backlight";
> +	cells[0].of_compatible =3D "skyworks,sky81452-backlight";
> +	cells[0].platform_data =3D pdata->bl_pdata;
> +	cells[0].pdata_size =3D sizeof(*pdata->bl_pdata);
> +	cells[1].name =3D "sky81452-regulator";
> +	cells[1].platform_data =3D pdata->regulator_init_data;
> +	cells[1].pdata_size =3D sizeof(*pdata->regulator_init_data);
> +
> +	ret =3D mfd_add_devices(dev, -1, cells, ARRAY_SIZE(cells), NULL, 0, NUL=
L);
> +	if (ret)
> +		dev_err(dev, "failed to add child devices. err=3D%d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int sky81452_remove(struct i2c_client *client)
> +{
> +	mfd_remove_devices(&client->dev);
> +	return 0;
> +}
> +
> +static const struct i2c_device_id sky81452_ids[] =3D {
> +	{ "sky81452" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sky81452_ids);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id sky81452_of_match[] =3D {
> +	{ .compatible =3D "skyworks,sky81452", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sky81452_of_match);
> +#endif
> +
> +static struct i2c_driver sky81452_driver =3D {
> +	.driver =3D {
> +		.name =3D "sky81452",
> +		.of_match_table =3D of_match_ptr(sky81452_of_match),
> +	},
> +	.probe =3D sky81452_probe,
> +	.remove =3D sky81452_remove,
> +	.id_table =3D sky81452_ids,
> +};
> +
> +module_i2c_driver(sky81452_driver);
> +
> +MODULE_DESCRIPTION("Skyworks SKY81452 MFD driver");
> +MODULE_AUTHOR("Gyungoh Yoo <jack.yoo@skyworksinc.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/sky81452.h b/include/linux/mfd/sky81452.h
> new file mode 100644
> index 0000000..b0925fa
> --- /dev/null
> +++ b/include/linux/mfd/sky81452.h
> @@ -0,0 +1,31 @@
> +/*
> + * sky81452.h	SKY81452 MFD driver
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
> +#ifndef _SKY81452_H
> +#define _SKY81452_H
> +
> +#include <linux/platform_data/sky81452-backlight.h>
> +#include <linux/regulator/machine.h>
> +
> +struct sky81452_platform_data {
> +	struct sky81452_bl_platform_data *bl_pdata;
> +	struct regulator_init_data *regulator_init_data;
> +};
> +
> +#endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
