From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 25 Apr 2017 08:19:33 +0000
Subject: Re: [PATCH v9 3/3] backlight arcxcnn add support for ArcticSand devices
Message-Id: <20170425081933.ea5pqxmhqo7hciif@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1490115528-11044-1-git-send-email-olimpiu@arcticsand.com>
 <1490115528-11044-3-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1490115528-11044-3-git-send-email-olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bdodge-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, medasaro-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org, daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org

On Tue, 21 Mar 2017, Olimpiu Dejeu wrote:

> backlight: Add support for Arctic Sand LED backlight driver chips
> This driver provides support for the Arctic Sand arc2c0608 chip,=20
>     and provides a framework to support future devices.
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> ---
> v8 =3D> v9:
> - Addressing kbuild test robot WARNING: PTR_ERR_OR_ZERO can be used
> v7 =3D> v8:
> - Version updated to match other patch in set. No other changes.
> v6 =3D> v7:
> - Addressing issues brought up by Daniel Thompson
> v5 =3D> v6:
> - Addressing issues brought up by Daniel Thompson
> v4 =3D> v5:
> - Code style changes per Joe Perches and Jingoo Han
> v3 =3D> v4:
> - Code style changes per Joe Perches and Jingoo Han
> v2 =3D> v3:
> - Renamed variables to comply with conventions on naming
> - Corrected device name in arcxcnn.h
> v1 =3D> v2:
> - Removed "magic numbers" to initialize registers
> - Cleaned up device tree bindings
> - Fixed code style to address comments and pass "checkpatch"
> - Removed unneeded debug and testing code
>=20
>=20
>  drivers/video/backlight/Kconfig      |   7 +
>  drivers/video/backlight/Makefile     |   1 +
>  drivers/video/backlight/arcxcnn_bl.c | 419 +++++++++++++++++++++++++++++=
++++++
>  3 files changed, 427 insertions(+)
>  create mode 100644 drivers/video/backlight/arcxcnn_bl.c

Applied this (and the correct (v9) version of [PATCH 2/3] too).

> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kc=
onfig
> index 5ffa4b4..4e1d2ad 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -460,6 +460,13 @@ config BACKLIGHT_BD6107
>  	help
>  	  If you have a Rohm BD6107 say Y to enable the backlight driver.
> =20
> +config BACKLIGHT_ARCXCNN
> +	tristate "Backlight driver for the Arctic Sands ARCxCnnnn family"
> +	depends on I2C
> +	help
> +	  If you have an ARCxCnnnn family backlight say Y to enable
> +	  the backlight driver.
> +
>  endif # BACKLIGHT_CLASS_DEVICE
> =20
>  endif # BACKLIGHT_LCD_SUPPORT
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/M=
akefile
> index 16ec534..8905129 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -55,3 +55,4 @@ obj-$(CONFIG_BACKLIGHT_SKY81452)	+=3D sky81452-backligh=
t.o
>  obj-$(CONFIG_BACKLIGHT_TOSA)		+=3D tosa_bl.o
>  obj-$(CONFIG_BACKLIGHT_TPS65217)	+=3D tps65217_bl.o
>  obj-$(CONFIG_BACKLIGHT_WM831X)		+=3D wm831x_bl.o
> +obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+=3D arcxcnn_bl.o
> diff --git a/drivers/video/backlight/arcxcnn_bl.c b/drivers/video/backlig=
ht/arcxcnn_bl.c
> new file mode 100644
> index 0000000..e01b1b0
> --- /dev/null
> +++ b/drivers/video/backlight/arcxcnn_bl.c
> @@ -0,0 +1,419 @@
> +/*
> + * Backlight driver for ArcticSand ARC_X_C_0N_0N Devices
> + *
> + * Copyright 2016 ArcticSand, Inc.
> + * Author : Brian Dodge <bdodge@arcticsand.com>
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
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +enum arcxcnn_chip_id {
> +	ARC2C0608
> +};
> +
> +/**
> + * struct arcxcnn_platform_data
> + * @name		: Backlight driver name (NULL will use default)
> + * @initial_brightness	: initial value of backlight brightness
> + * @leden		: initial LED string enables, upper bit is global on/off
> + * @led_config_0	: fading speed (period between intensity steps)
> + * @led_config_1	: misc settings, see datasheet
> + * @dim_freq		: pwm dimming frequency if in pwm mode
> + * @comp_config		: misc config, see datasheet
> + * @filter_config	: RC/PWM filter config, see datasheet
> + * @trim_config		: full scale current trim, see datasheet
> + */
> +struct arcxcnn_platform_data {
> +	const char *name;
> +	u16 initial_brightness;
> +	u8	leden;
> +	u8	led_config_0;
> +	u8	led_config_1;
> +	u8	dim_freq;
> +	u8	comp_config;
> +	u8	filter_config;
> +	u8	trim_config;
> +};
> +
> +#define ARCXCNN_CMD		0x00	/* Command Register */
> +#define ARCXCNN_CMD_STDBY	0x80	/*   I2C Standby */
> +#define ARCXCNN_CMD_RESET	0x40	/*   Reset */
> +#define ARCXCNN_CMD_BOOST	0x10	/*   Boost */
> +#define ARCXCNN_CMD_OVP_MASK	0x0C	/*   --- Over Voltage Threshold */
> +#define ARCXCNN_CMD_OVP_XXV	0x0C	/*   <rsvrd> Over Voltage Threshold */
> +#define ARCXCNN_CMD_OVP_20V	0x08	/*   20v Over Voltage Threshold */
> +#define ARCXCNN_CMD_OVP_24V	0x04	/*   24v Over Voltage Threshold */
> +#define ARCXCNN_CMD_OVP_31V	0x00	/*   31.4v Over Voltage Threshold */
> +#define ARCXCNN_CMD_EXT_COMP	0x01	/*   part (0) or full (1) ext. comp */
> +
> +#define ARCXCNN_CONFIG		0x01	/* Configuration */
> +#define ARCXCNN_STATUS1		0x02	/* Status 1 */
> +#define ARCXCNN_STATUS2		0x03	/* Status 2 */
> +#define ARCXCNN_FADECTRL	0x04	/* Fading Control */
> +#define ARCXCNN_ILED_CONFIG	0x05	/* ILED Configuration */
> +#define ARCXCNN_ILED_DIM_PWM	0x00	/*   config dim mode pwm */
> +#define ARCXCNN_ILED_DIM_INT	0x04	/*   config dim mode internal */
> +#define ARCXCNN_LEDEN		0x06	/* LED Enable Register */
> +#define ARCXCNN_LEDEN_ISETEXT	0x80	/*   Full-scale current set extern */
> +#define ARCXCNN_LEDEN_MASK	0x3F	/*   LED string enables mask */
> +#define ARCXCNN_LEDEN_BITS	0x06	/*   Bits of LED string enables */
> +#define ARCXCNN_LEDEN_LED1	0x01
> +#define ARCXCNN_LEDEN_LED2	0x02
> +#define ARCXCNN_LEDEN_LED3	0x04
> +#define ARCXCNN_LEDEN_LED4	0x08
> +#define ARCXCNN_LEDEN_LED5	0x10
> +#define ARCXCNN_LEDEN_LED6	0x20
> +
> +#define ARCXCNN_WLED_ISET_LSB	0x07	/* LED ISET LSB (in upper nibble) */
> +#define ARCXCNN_WLED_ISET_LSB_SHIFT 0x04  /* ISET LSB Left Shift */
> +#define ARCXCNN_WLED_ISET_MSB	0x08	/* LED ISET MSB (8 bits) */
> +
> +#define ARCXCNN_DIMFREQ		0x09
> +#define ARCXCNN_COMP_CONFIG	0x0A
> +#define ARCXCNN_FILT_CONFIG	0x0B
> +#define ARCXCNN_IMAXTUNE	0x0C
> +#define ARCXCNN_ID_MSB		0x1E
> +#define ARCXCNN_ID_LSB		0x1F
> +
> +#define MAX_BRIGHTNESS		4095
> +#define INIT_BRIGHT		60
> +
> +struct arcxcnn {
> +	struct i2c_client *client;
> +	struct backlight_device *bl;
> +	struct device *dev;
> +	struct arcxcnn_platform_data *pdata;
> +};
> +
> +static int arcxcnn_update_field(struct arcxcnn *lp, u8 reg, u8 mask, u8 =
data)
> +{
> +	int ret;
> +	u8 tmp;
> +
> +	ret =3D i2c_smbus_read_byte_data(lp->client, reg);
> +	if (ret < 0) {
> +		dev_err(lp->dev, "failed to read 0x%.2x\n", reg);
> +		return ret;
> +	}
> +
> +	tmp =3D (u8)ret;
> +	tmp &=3D ~mask;
> +	tmp |=3D data & mask;
> +
> +	return i2c_smbus_write_byte_data(lp->client, reg, tmp);
> +}
> +
> +static int arcxcnn_set_brightness(struct arcxcnn *lp, u32 brightness)
> +{
> +	int ret;
> +	u8 val;
> +
> +	/* lower nibble of brightness goes in upper nibble of LSB register */
> +	val =3D (brightness & 0xF) << ARCXCNN_WLED_ISET_LSB_SHIFT;
> +	ret =3D i2c_smbus_write_byte_data(lp->client,
> +		ARCXCNN_WLED_ISET_LSB, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* remaining 8 bits of brightness go in MSB register */
> +	val =3D (brightness >> 4);
> +	return i2c_smbus_write_byte_data(lp->client,
> +		ARCXCNN_WLED_ISET_MSB, val);
> +}
> +
> +static int arcxcnn_bl_update_status(struct backlight_device *bl)
> +{
> +	struct arcxcnn *lp =3D bl_get_data(bl);
> +	u32 brightness =3D bl->props.brightness;
> +	int ret;
> +
> +	if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> +		brightness =3D 0;
> +
> +	ret =3D arcxcnn_set_brightness(lp, brightness);
> +	if (ret)
> +		return ret;
> +
> +	/* set power-on/off/save modes */
> +	return arcxcnn_update_field(lp, ARCXCNN_CMD, ARCXCNN_CMD_STDBY,
> +		(bl->props.power =3D 0) ? 0 : ARCXCNN_CMD_STDBY);
> +}
> +
> +static const struct backlight_ops arcxcnn_bl_ops =3D {
> +	.options =3D BL_CORE_SUSPENDRESUME,
> +	.update_status =3D arcxcnn_bl_update_status,
> +};
> +
> +static int arcxcnn_backlight_register(struct arcxcnn *lp)
> +{
> +	struct backlight_properties *props;
> +	const char *name =3D lp->pdata->name ? : "arctic_bl";
> +
> +	props =3D devm_kzalloc(lp->dev, sizeof(*props), GFP_KERNEL);
> +	if (!props)
> +		return -ENOMEM;
> +
> +	props->type =3D BACKLIGHT_PLATFORM;
> +	props->max_brightness =3D MAX_BRIGHTNESS;
> +
> +	if (lp->pdata->initial_brightness > props->max_brightness)
> +		lp->pdata->initial_brightness =3D props->max_brightness;
> +
> +	props->brightness =3D lp->pdata->initial_brightness;
> +
> +	lp->bl =3D devm_backlight_device_register(lp->dev, name, lp->dev, lp,
> +				       &arcxcnn_bl_ops, props);
> +	return PTR_ERR_OR_ZERO(lp->bl);
> +}
> +
> +static void arcxcnn_parse_dt(struct arcxcnn *lp)
> +{
> +	struct device *dev =3D lp->dev;
> +	struct device_node *node =3D dev->of_node;
> +	u32 prog_val, num_entry, entry, sources[ARCXCNN_LEDEN_BITS];
> +	int ret;
> +
> +	/* device tree entry isn't required, defaults are OK */
> +	if (!node)
> +		return;
> +
> +	ret =3D of_property_read_string(node, "label", &lp->pdata->name);
> +	if (ret < 0)
> +		lp->pdata->name =3D NULL;
> +
> +	ret =3D of_property_read_u32(node, "default-brightness", &prog_val);
> +	if (ret =3D 0)
> +		lp->pdata->initial_brightness =3D prog_val;
> +
> +	ret =3D of_property_read_u32(node, "arc,led-config-0", &prog_val);
> +	if (ret =3D 0)
> +		lp->pdata->led_config_0 =3D (u8)prog_val;
> +
> +	ret =3D of_property_read_u32(node, "arc,led-config-1", &prog_val);
> +	if (ret =3D 0)
> +		lp->pdata->led_config_1 =3D (u8)prog_val;
> +
> +	ret =3D of_property_read_u32(node, "arc,dim-freq", &prog_val);
> +	if (ret =3D 0)
> +		lp->pdata->dim_freq =3D (u8)prog_val;
> +
> +	ret =3D of_property_read_u32(node, "arc,comp-config", &prog_val);
> +	if (ret =3D 0)
> +		lp->pdata->comp_config =3D (u8)prog_val;
> +
> +	ret =3D of_property_read_u32(node, "arc,filter-config", &prog_val);
> +	if (ret =3D 0)
> +		lp->pdata->filter_config =3D (u8)prog_val;
> +
> +	ret =3D of_property_read_u32(node, "arc,trim-config", &prog_val);
> +	if (ret =3D 0)
> +		lp->pdata->trim_config =3D (u8)prog_val;
> +
> +	ret =3D of_property_count_u32_elems(node, "led-sources");
> +	if (ret < 0) {
> +		lp->pdata->leden =3D ARCXCNN_LEDEN_MASK; /* all on is default */
> +	} else {
> +		num_entry =3D ret;
> +		if (num_entry > ARCXCNN_LEDEN_BITS)
> +			num_entry =3D ARCXCNN_LEDEN_BITS;
> +
> +		ret =3D of_property_read_u32_array(node, "led-sources", sources,
> +					num_entry);
> +		if (ret < 0) {
> +			dev_err(dev, "led-sources node is invalid.\n");
> +			return;
> +		}
> +
> +		lp->pdata->leden =3D 0;
> +
> +		/* for each enable in source, set bit in led enable */
> +		for (entry =3D 0; entry < num_entry; entry++) {
> +			u8 onbit =3D 1 << sources[entry];
> +
> +			lp->pdata->leden |=3D onbit;
> +		}
> +	}
> +}
> +
> +static int arcxcnn_probe(struct i2c_client *cl, const struct i2c_device_=
id *id)
> +{
> +	struct arcxcnn *lp;
> +	int ret;
> +
> +	if (!i2c_check_functionality(cl->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EIO;
> +
> +	lp =3D devm_kzalloc(&cl->dev, sizeof(*lp), GFP_KERNEL);
> +	if (!lp)
> +		return -ENOMEM;
> +
> +	lp->client =3D cl;
> +	lp->dev =3D &cl->dev;
> +	lp->pdata =3D dev_get_platdata(&cl->dev);
> +
> +	/* reset the device */
> +	ret =3D i2c_smbus_write_byte_data(lp->client,
> +		ARCXCNN_CMD, ARCXCNN_CMD_RESET);
> +	if (ret)
> +		goto probe_err;
> +
> +	if (!lp->pdata) {
> +		lp->pdata =3D devm_kzalloc(lp->dev,
> +				sizeof(*lp->pdata), GFP_KERNEL);
> +		if (!lp->pdata)
> +			return -ENOMEM;
> +
> +		/* Setup defaults based on power-on defaults */
> +		lp->pdata->name =3D NULL;
> +		lp->pdata->initial_brightness =3D INIT_BRIGHT;
> +		lp->pdata->leden =3D ARCXCNN_LEDEN_MASK;
> +
> +		lp->pdata->led_config_0 =3D i2c_smbus_read_byte_data(
> +			lp->client, ARCXCNN_FADECTRL);
> +
> +		lp->pdata->led_config_1 =3D i2c_smbus_read_byte_data(
> +			lp->client, ARCXCNN_ILED_CONFIG);
> +		/* insure dim mode is not default pwm */
> +		lp->pdata->led_config_1 |=3D ARCXCNN_ILED_DIM_INT;
> +
> +		lp->pdata->dim_freq =3D i2c_smbus_read_byte_data(
> +			lp->client, ARCXCNN_DIMFREQ);
> +
> +		lp->pdata->comp_config =3D i2c_smbus_read_byte_data(
> +			lp->client, ARCXCNN_COMP_CONFIG);
> +
> +		lp->pdata->filter_config =3D i2c_smbus_read_byte_data(
> +			lp->client, ARCXCNN_FILT_CONFIG);
> +
> +		lp->pdata->trim_config =3D i2c_smbus_read_byte_data(
> +			lp->client, ARCXCNN_IMAXTUNE);
> +
> +		if (IS_ENABLED(CONFIG_OF))
> +			arcxcnn_parse_dt(lp);
> +	}
> +
> +	i2c_set_clientdata(cl, lp);
> +
> +	/* constrain settings to what is possible */
> +	if (lp->pdata->initial_brightness > MAX_BRIGHTNESS)
> +		lp->pdata->initial_brightness =3D MAX_BRIGHTNESS;
> +
> +	/* set initial brightness */
> +	ret =3D arcxcnn_set_brightness(lp, lp->pdata->initial_brightness);
> +	if (ret)
> +		goto probe_err;
> +
> +	/* set other register values directly */
> +	ret =3D i2c_smbus_write_byte_data(lp->client, ARCXCNN_FADECTRL,
> +		lp->pdata->led_config_0);
> +	if (ret)
> +		goto probe_err;
> +
> +	ret =3D i2c_smbus_write_byte_data(lp->client, ARCXCNN_ILED_CONFIG,
> +		lp->pdata->led_config_1);
> +	if (ret)
> +		goto probe_err;
> +
> +	ret =3D i2c_smbus_write_byte_data(lp->client, ARCXCNN_DIMFREQ,
> +		lp->pdata->dim_freq);
> +	if (ret)
> +		goto probe_err;
> +
> +	ret =3D i2c_smbus_write_byte_data(lp->client, ARCXCNN_COMP_CONFIG,
> +		lp->pdata->comp_config);
> +	if (ret)
> +		goto probe_err;
> +
> +	ret =3D i2c_smbus_write_byte_data(lp->client, ARCXCNN_FILT_CONFIG,
> +		lp->pdata->filter_config);
> +	if (ret)
> +		goto probe_err;
> +
> +	ret =3D i2c_smbus_write_byte_data(lp->client, ARCXCNN_IMAXTUNE,
> +		lp->pdata->trim_config);
> +	if (ret)
> +		goto probe_err;
> +
> +	/* set initial LED Enables */
> +	arcxcnn_update_field(lp, ARCXCNN_LEDEN,
> +		ARCXCNN_LEDEN_MASK, lp->pdata->leden);
> +
> +	ret =3D arcxcnn_backlight_register(lp);
> +	if (ret)
> +		goto probe_register_err;
> +
> +	backlight_update_status(lp->bl);
> +
> +	return 0;
> +
> +probe_register_err:
> +	dev_err(lp->dev,
> +		"failed to register backlight.\n");
> +
> +probe_err:
> +	dev_err(lp->dev,
> +		"failure ret: %d\n", ret);
> +	return ret;
> +}
> +
> +static int arcxcnn_remove(struct i2c_client *cl)
> +{
> +	struct arcxcnn *lp =3D i2c_get_clientdata(cl);
> +
> +	/* disable all strings (ignore errors) */
> +	i2c_smbus_write_byte_data(lp->client,
> +		ARCXCNN_LEDEN, 0x00);
> +	/* reset the device (ignore errors) */
> +	i2c_smbus_write_byte_data(lp->client,
> +		ARCXCNN_CMD, ARCXCNN_CMD_RESET);
> +
> +	lp->bl->props.brightness =3D 0;
> +
> +	backlight_update_status(lp->bl);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id arcxcnn_dt_ids[] =3D {
> +	{ .compatible =3D "arc,arc2c0608" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, arcxcnn_dt_ids);
> +
> +static const struct i2c_device_id arcxcnn_ids[] =3D {
> +	{"arc2c0608", ARC2C0608},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, arcxcnn_ids);
> +
> +static struct i2c_driver arcxcnn_driver =3D {
> +	.driver =3D {
> +		.name =3D "arcxcnn_bl",
> +		.of_match_table =3D of_match_ptr(arcxcnn_dt_ids),
> +	},
> +	.probe =3D arcxcnn_probe,
> +	.remove =3D arcxcnn_remove,
> +	.id_table =3D arcxcnn_ids,
> +};
> +module_i2c_driver(arcxcnn_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Brian Dodge <bdodge@arcticsand.com>");
> +MODULE_DESCRIPTION("ARCXCNN Backlight driver");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
